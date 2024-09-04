Return-Path: <linux-kernel+bounces-315814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DEE96C74A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F1E1C2520E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F91E6338;
	Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C371E632B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477274; cv=none; b=GZbeJMsHDg2kPjP8YfjrLkCxiOdDjdgj2ZHNK001HpooBJ0x0VEvNnCQ/Jhu7E/7SSH4dGgo3O2ngmH8AdIuzng2lkJOtLcqEXRRwLKb1xgSHqwmw8fEG4TN1X8hLU+3XG2QwRBw92uxUuf2nbxy0ybJLbEArzQ5Bws4tQltFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477274; c=relaxed/simple;
	bh=ocIbq0VaqldyWEkg1BzYXbiz3X2p5bsJ1TEONFzS2cs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ATG59Z4eO/Lbo9ievsKCZd3w0jSZvDNi8wfr/JHOBRS1f1A0DcMF7ztx4lsRYWp2WB/f35AwKTCsHscPxusEjJrpBGX5yGn7D6VPAkDe300Hj/aW75v0lWqwja6U26kulOyrzV6yD27faiP0hSDIyORZruYJvOwZP6uPtRDMVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DED6C4AF09;
	Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slvTb-000000059Dp-2ueg;
	Wed, 04 Sep 2024 15:15:35 -0400
Message-ID: <20240904191535.550567736@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 15:15:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 "John Warthog9 Hawley (Tenstorrent)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 1/2] ktest.pl: Always warn on build warnings
References: <20240904191514.942314784@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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

Link: https://lore.kernel.org/<20240819172028.3a7fae09@gandalf.local.home>
Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>
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



