Return-Path: <linux-kernel+bounces-335047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8797E04C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D89B20F96
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D0629CF6;
	Sun, 22 Sep 2024 06:38:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A39EEB5
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987091; cv=none; b=VzQ1eDSgre5gttLCM6hOBEVk+WV/JJLEOXpOvyrke9zf52Gv5iCbifnKRKYy/Yo/r+B9HAe8eHp19MEu2Dli1lEMEgkBWJ2l7ud2CcJL2E5Esw79gxk2LEI+Vde/SDc+KSYavUMOFhklc+T8nVQtp+cpvFEm9GMR+WUqBsloSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987091; c=relaxed/simple;
	bh=TrM3S0L6RmZf+9Y4xzWaUhdnlz+wHl5YXH4DKlpfT8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kBrMBEAOLtqkk+IphoMijpZsurLs2G88gaYEAEx0PcGOdLhnr57GYkc9u8prLnLaHwXuv6VnZvjSCG4hRvwwPoy1t2BdQ74/Vb0kDni2SB5l5xjM+MDAPCCKqEa8xsSH4oXDAQUQDwgGOZoRaKQ2/dLC6R5pcWYXYmUWVDwA7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FE2C4CEC3;
	Sun, 22 Sep 2024 06:38:09 +0000 (UTC)
Date: Sun, 22 Sep 2024 02:38:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John 'Warthog9' Hawley
 <warthog9@kernel.org>, Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [GIT PULL] ktest.pl: Updates for 6.12
Message-ID: <20240922023805.044eba62@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

ktest.pl updates for 6.12:

- Add notification of build warnings for all tests

  Currently, the build will only fail on warnings if the ktest config file
  states that it should fail or if the compile is done with -Werror. This
  has allowed warnings to sneak in if it doesn't fail. Add a notification at
  the end of the test that will state that warnings were found in the build
  so that the developer will be aware of it.

- Fix the grub2 parser to not return the wrong kernel index

  ktest.pl can read the grub.cfg file to know what kernel to boot to via
  grub-reboot. This requires knowing the index that the kernel is referenced
  by in the grub.cfg file. Some distros have logic to determine the
  menuentry that can cause the ktest.pl to come up with the wrong index and
  boot the wrong kernel.


Please pull the latest ktest-v6.12 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v6.12

Tag SHA1: 3224d5d52aef011ccbbb82a8f52e51f1c4f1ba52
Head SHA1: 2351e8c65404aabc433300b6bf90c7a37e8bbc4d


Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Steven Rostedt (1):
      ktest.pl: Always warn on build warnings

----
 tools/testing/ktest/ktest.pl | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index eb31cd9c977b..dacad94e2be4 100755
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
@@ -2047,7 +2056,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
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

