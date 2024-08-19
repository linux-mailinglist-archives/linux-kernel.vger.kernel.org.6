Return-Path: <linux-kernel+bounces-292915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23195766B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3386B2224F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE3C172BD3;
	Mon, 19 Aug 2024 21:20:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472171591E3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102404; cv=none; b=p/W8hzxr9Kg5c4oUSCtJG65JIBYKk2jLu5+25pkDbli9JWUJv+Azq+d7s6v9SEAf1QBHn0s6JdwXGUs4prma8RuWys+7Mu1EvFgl3g2EhgM1qJrmCb2db0cklAa6xesZuJ0AH5OdMFegkIZq0WKmhvRs+a/54eXL2te6+yNVpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102404; c=relaxed/simple;
	bh=geBg7oorSdiRSuO2UKmQ8oDVSavpaFjuxoK3dPTIuVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=os55TA8rLkuXOpFj4OCfogc/GPxfsDiPulShOjJneUXQc1bmnv7/Us1z2RIwYAxaW+v0nARPzKzQkLAmV3uM8ZcDlTKn+46yh8jMHwunxKUIbOYtRVA6nAEjclfZWNRVKuiwegGDP0MqQA3UA7wKemrA8yDrxTVxqdqOAjRldq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678EFC4AF0E;
	Mon, 19 Aug 2024 21:20:03 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:20:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: [PATCH] ktest.pl: Always warn on build warnings
Message-ID: <20240819172028.3a7fae09@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

If a warning happens at build, give a warning at the end:

  Build time:   1 minute 40 seconds
  Install time: 17 seconds
  Reboot time:  25 seconds

  *** WARNING found in build: 1 ***

  *******************************************
  *******************************************
  KTEST RESULT: TEST 1 SUCCESS!!!!   **
  *******************************************
  *******************************************

This way, even if the test isn't made to fail on warnings during the
build, a message is still displayed that warnings were found.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index eb31cd9c977b..c82b8d55dddb 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -222,6 +222,8 @@ my $install_time;
 my $reboot_time;
 my $test_time;
 
+my $warning_found = 0;
+
 my $pwd;
 my $dirname = $FindBin::Bin;
 
@@ -729,11 +731,18 @@ sub print_times {
 	show_time($test_time);
 	doprint "\n";
     }
+    if ($warning_found) {
+	doprint "\n*** WARNING";
+	doprint "S" if ($warning_found > 1);
+	doprint " found in build: $warning_found ***\n\n";
+    }
+
     # reset for iterations like bisect
     $build_time = 0;
     $install_time = 0;
     $reboot_time = 0;
     $test_time = 0;
+    $warning_found = 0;
 }
 
 sub get_mandatory_configs {
@@ -2460,8 +2469,6 @@ sub process_warning_line {
 # Returns 1 if OK
 #         0 otherwise
 sub check_buildlog {
-    return 1 if (!defined $warnings_file);
-
     my %warnings_list;
 
     # Failed builds should not reboot the target
@@ -2482,18 +2489,21 @@ sub check_buildlog {
 	close(IN);
     }
 
-    # If warnings file didn't exist, and WARNINGS_FILE exist,
-    # then we fail on any warning!
-
     open(IN, $buildlog) or dodie "Can't open $buildlog";
     while (<IN>) {
 	if (/$check_build_re/) {
 	    my $warning = process_warning_line $_;
 
 	    if (!defined $warnings_list{$warning}) {
-		fail "New warning found (not in $warnings_file)\n$_\n";
-		$no_reboot = $save_no_reboot;
-		return 0;
+		$warning_found++;
+
+		# If warnings file didn't exist, and WARNINGS_FILE exist,
+		# then we fail on any warning!
+		if (defined $warnings_file) {
+		    fail "New warning found (not in $warnings_file)\n$_\n";
+		    $no_reboot = $save_no_reboot;
+		    return 0;
+		}
 	    }
 	}
     }
-- 
2.43.0


