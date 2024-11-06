Return-Path: <linux-kernel+bounces-398655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6EA9BF43C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F57E1F22D83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365920651A;
	Wed,  6 Nov 2024 17:22:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A601F9ABB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913768; cv=none; b=f8pS5F+JtYaAS46xKvv7cjQpZ4pvFTTR5Tkbvsv1AYSOX3lHM/3ypn+WgOAlFqFBBQTm7muZxAIXBiXDQVmnyWtxGLwEI1cU4AlgIIFZsUhBX9pTSNSW/1fzkmbuDAYXn8W2LHZKDFRi7U0+YG4tsm9eImcHrOqg+8rOzBUMO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913768; c=relaxed/simple;
	bh=BnnbcK7EvbaUNMV7DgM4BVKqLy+ZRqGziQZoMChzrZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DZQB6M0XQN9V6ZSHhwtAzGC0Iuu4TapwY9BVuUd8MBtT7lidMCUhyNp6stYKgPpAaurFGmVGtEoInRINDMGuDYiM5Vr4xeHL1WpSgXOat0hNMPvZOPiFAZAai+0ZzuFadlh/nes3+/MmTQY0HL5Os1vQcLPc99LwpZQIhc4OSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F26C4CEC6;
	Wed,  6 Nov 2024 17:22:46 +0000 (UTC)
Date: Wed, 6 Nov 2024 12:22:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kalesh Singh <kaleshsingh@google.com>
Subject: [GIT PULL] tracefs: Fix regression of setting group permissions at
 boot
Message-ID: <20241106122250.2667681b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Kalesh Singh <kaleshsingh@google.com>

Linus,

Fix tracefs mount options:

The commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
broke the gid setting when set by fstab or other mount utility.
It is ignored when it is set. Fix the code so that it recognizes the
option again and will honor the settings on mount at boot up.

Update the internal documentation and create a selftest to make sure
it doesn't break again in the future.


Please pull the latest tracefs-v6.12-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tracefs-v6.12-rc6

Tag SHA1: ba611308a30ae768483f77653d25ac6c98c618a7
Head SHA1: 8b55572e51805184353ee7d587c720a51818fb82


Kalesh Singh (3):
      tracing: Fix tracefs mount options
      tracing: Document tracefs gid mount option
      tracing/selftests: Add tracefs mount options test

----
 fs/tracefs/inode.c                                 |  12 ++-
 kernel/trace/trace.c                               |   4 +
 .../ftrace/test.d/00basic/mount_options.tc         | 101 +++++++++++++++++++++
 .../ftrace/test.d/00basic/test_ownership.tc        |  16 +---
 tools/testing/selftests/ftrace/test.d/functions    |  25 +++++
 5 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc
---------------------------
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1748dff58c3b..cfc614c638da 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *fc)
 	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
 	struct tracefs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 	/* structure copy of new mount options to sb */
 	*sb_opts = *new_opts;
@@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &tracefs_super_operations;
 	sb->s_d_op = &tracefs_dentry_operations;
 
-	tracefs_apply_options(sb, false);
-
 	return 0;
 }
 
 static int tracefs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, tracefs_fill_super);
+	int err = get_tree_single(fc, tracefs_fill_super);
+
+	if (err)
+		return err;
+
+	return tracefs_reconfigure(fc);
 }
 
 static void tracefs_free_fc(struct fs_context *fc)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..2b64b3ec67d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5501,6 +5501,10 @@ static const struct file_operations tracing_iter_fops = {
 
 static const char readme_msg[] =
 	"tracing mini-HOWTO:\n\n"
+	"By default tracefs removes all OTH file permission bits.\n"
+	"When mounting tracefs an optional group id can be specified\n"
+	"which adds the group to every directory and file in tracefs:\n\n"
+	"\t e.g. mount -t tracefs [-o [gid=<gid>]] nodev /sys/kernel/tracing\n\n"
 	"# echo 0 > tracing_on : quick way to disable tracing\n"
 	"# echo 1 > tracing_on : quick way to re-enable tracing\n\n"
 	" Important files:\n"
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

