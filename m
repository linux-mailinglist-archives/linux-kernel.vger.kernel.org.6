Return-Path: <linux-kernel+bounces-389281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037849B6AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AC11F22A44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA121621F;
	Wed, 30 Oct 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1EB4WMza"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E34216E18
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308883; cv=none; b=Os1JqWwe+QwJDzMijWymYRHuj58fN41AjZQZERL0DyzZZffrzmZAVLd/3CQQh2lLSgvx9WlDNpyEUfd2cilBKioBZMpSTtXaYkB8OgIH71vuEYO90zl/lPBxDXW2ADCuIo1Rq6MisAQdfrBJgCUPcYA6k+nAeZCVph0T8LPh3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308883; c=relaxed/simple;
	bh=jy7fX6fXtTicagX/1fKgETRpjghchdVKkUSUUenccKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s78ogP6D35W00HER/sX7Y+lpi5Mi++pIS5KkUqjF+wJh1G1DIckD4mSDcQrwhlFIgt33u9Ueuhr3wLWYbH+jG2i56nxxTUOpVwWKhSfQ0kozdG7Sh7sljkyZtsl+ENSSzeRO2mhD9JDMB0dKfxk162s/Dl02GejYLn+RisrDTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1EB4WMza; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fc60660dso56574276.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308879; x=1730913679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnPITcasFwhqHG4kzONwlC03HHUaTOQQrrmOaxaFJyo=;
        b=1EB4WMzaWZqPwmr/eE98GtortPVopebwt/7H0NjnmdAmPHxc7l+00fpE9M1cG9+Ppt
         TIJGWX0odlTT+y1tQ3eoLTdWW4GdO/9io9vi51tVxifKygYBlP7vIeU5UofikdcxrpKg
         FPcPWDgdJRI8WY2ev0K4z2R7muXsK7AlrOFnCexbfUQN2y4eqj3QXU5/qI8+PirEKZOh
         CIz3mkCvQRIWDDiKxcN+lbf5tCFcZ2sctxLai78NTbtonxeTwzu+yAqhx0Ccs7wTbfxs
         8wh3dtXqEag2mK8ja/RaaXES8GfigyhgrCo3cc5+bhzG6uqCMUlPu0NjeRCI8h8yGWys
         uwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308879; x=1730913679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnPITcasFwhqHG4kzONwlC03HHUaTOQQrrmOaxaFJyo=;
        b=thj3QGdAEO23bLslN2bPA9qDSpW7wViY+zGWEwRRuyige+vUQrRVuuOQoL00TXaEoc
         VCuYTp2OtyMSN4aTHQcQcgF3orH6yBbkY7RBAgcXlkzcLsZCowC758otYcfpq0HooHzK
         GiuU6+v96N2SkNVUCP94M2DHjVw5T5nNZ0ZMRf6W4vSbitJI1/oRbOYw4qUtPCkDi6Tq
         DD5hGFimerY5lNGrojU/p4888wbirFU8DL0QEVYtfMsx4TM1lKSQqceUTl9Qz8Cq7vYN
         lCmRrA7Rd9Y7AC55EhZntgPwDyICBp957YxYBi5ohnc5X1uf62lcO8fyZlGz6/iEPufy
         V+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWkGOccmKjlBVC3zPmfV1b6iIWhJUY3b9vnBgmnLK1H0f675TYovSRxASGtg5EuD8nuSdqFFIudBQJhrRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GNga1FNgl4MQJsEpZS3lzscbnGetj4h03U36+bJsmZjLqoMN
	IrPeYUiQY9TT37KBLn0u5u+JXRaiMnq8aFRYiOIt6q1431uBCMoH6tlhVnvui1oEqpq5mVhgZXa
	UDlSTqO5uzzhm0EF98ynFTQ==
X-Google-Smtp-Source: AGHT+IEU6ajAu+W43CFSJeGRF7aKFVpYs7iw/D3cnnCbf9TsQuTQ7xbXdt4NGUXEiXKpoIpfSqS3LSUlm/2uyT5r9g==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8382:0:b0:e2b:ce2f:787a with SMTP
 id 3f1490d57ef6-e3087a603e2mr59008276.3.1730308879011; Wed, 30 Oct 2024
 10:21:19 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:50 -0700
In-Reply-To: <20241030171928.4168869-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030171928.4168869-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-4-kaleshsingh@google.com>
Subject: [PATCH v2 3/3] tracing/selftests: Add tracefs mount options test
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a selftest to check that the tracefs gid mount option is applied
correctly.

   ./ftracetest test.d/00basic/mount_options.tc

Use the new readme string "[gid=<gid>] as a requirement and also update
test_ownership.tc requirements to use this.

Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 .../ftrace/test.d/00basic/mount_options.tc    | 101 ++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc   |  16 +--
 .../testing/selftests/ftrace/test.d/functions |  25 +++++
 3 files changed, 129 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
new file mode 100644
index 000000000000..35e8d47d6072
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
@@ -0,0 +1,101 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test tracefs GID mount option
+# requires: "[gid=<gid>]":README
+
+fail() {
+	local msg="$1"
+
+	echo "FAILED: $msg"
+	exit_fail
+}
+
+find_alternate_gid() {
+	local original_gid="$1"
+	tac /etc/group | grep -v ":$original_gid:" | head -1 | cut -d: -f3
+}
+
+mount_tracefs_with_options() {
+	local mount_point="$1"
+	local options="$2"
+
+	mount -t tracefs -o "$options" nodev "$mount_point"
+
+	setup
+}
+
+unmount_tracefs() {
+	local mount_point="$1"
+
+	# Need to make sure the mount isn't busy so that we can umount it
+	(cd $mount_point; finish_ftrace;)
+
+	cleanup
+}
+
+create_instance() {
+	local mount_point="$1"
+	local instance="$mount_point/instances/$(mktemp -u test-XXXXXX)"
+
+	mkdir "$instance"
+	echo "$instance"
+}
+
+remove_instance() {
+	local instance="$1"
+
+	rmdir "$instance"
+}
+
+check_gid() {
+	local mount_point="$1"
+	local expected_gid="$2"
+
+	echo "Checking permission group ..."
+
+	cd "$mount_point"
+
+	for file in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable"; do
+		local gid=`stat -c "%g" $file`
+		if [ "$gid" -ne "$expected_gid" ]; then
+			cd - # Return to the previous working directory (tracefs root)
+			fail "$(realpath $file): Expected group $expected_gid; Got group $gid"
+		fi
+	done
+
+	cd - # Return to the previous working directory (tracefs root)
+}
+
+test_gid_mount_option() {
+	local mount_point=$(get_mount_point)
+	local mount_options=$(get_mnt_options "$mount_point")
+	local original_group=$(stat -c "%g" .)
+	local other_group=$(find_alternate_gid "$original_group")
+
+	# Set up mount options with new GID for testing
+	local new_options=`echo "$mount_options" | sed -e "s/gid=[0-9]*/gid=$other_group/"`
+	if [ "$new_options" = "$mount_options" ]; then
+		new_options="$mount_options,gid=$other_group"
+		mount_options="$mount_options,gid=$original_group"
+	fi
+
+	# Unmount existing tracefs instance and mount with new GID
+	unmount_tracefs "$mount_point"
+	mount_tracefs_with_options "$mount_point" "$new_options"
+
+	check_gid "$mount_point" "$other_group"
+
+	# Check that files created after the mount inherit the GID
+	local instance=$(create_instance "$mount_point")
+	check_gid "$instance" "$other_group"
+	remove_instance "$instance"
+
+	# Unmount and remount with the original GID
+	unmount_tracefs "$mount_point"
+	mount_tracefs_with_options "$mount_point" "$mount_options"
+	check_gid "$mount_point" "$original_group"
+}
+
+test_gid_mount_option
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
index 094419e190c2..e71cc3ad0bdf 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
@@ -1,24 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test file and directory ownership changes for eventfs
+# requires: "[gid=<gid>]":README
 
 original_group=`stat -c "%g" .`
 original_owner=`stat -c "%u" .`
 
-mount_point=`stat -c '%m' .`
+local mount_point=$(get_mount_point)
 
-# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
-# current working directory (which should be a tracefs) as the mount point.
-if [ ! -d "$mount_point" ]; then
-	if mount | grep -qw $PWD ; then
-		mount_point=$PWD
-	else
-		# If PWD doesn't work, that is an environmental problem.
-		exit_unresolved
-	fi
-fi
-
-mount_options=`mount | grep "$mount_point" | sed -e 's/.*(\(.*\)).*/\1/'`
+mount_options=$(get_mnt_options "$mount_point")
 
 # find another owner and group that is not the original
 other_group=`tac /etc/group | grep -v ":$original_group:" | head -1 | cut -d: -f3`
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779f3e62ec90..84d6a9c7ad67 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -193,3 +193,28 @@ ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
     # "  Command: " and "^\n" => 13
     test $(expr 13 + $pos) -eq $N
 }
+
+# Helper to get the tracefs mount point
+get_mount_point() {
+	local mount_point=`stat -c '%m' .`
+
+	# If stat -c '%m' does not work (e.g. busybox) or failed, try to use the
+	# current working directory (which should be a tracefs) as the mount point.
+	if [ ! -d "$mount_point" ]; then
+		if mount | grep -qw "$PWD"; then
+			mount_point=$PWD
+		else
+			# If PWD doesn't work, that is an environmental problem.
+			exit_unresolved
+		fi
+	fi
+	echo "$mount_point"
+}
+
+# Helper function to retrieve mount options for a given mount point
+get_mnt_options() {
+	local mnt_point="$1"
+	local opts=$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.*\)).*/\1/')
+
+	echo "$opts"
+}
\ No newline at end of file
-- 
2.47.0.163.g1226f6d8fa-goog


