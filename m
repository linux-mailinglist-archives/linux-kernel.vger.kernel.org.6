Return-Path: <linux-kernel+bounces-253357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE82932007
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9296283640
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350B17550;
	Tue, 16 Jul 2024 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZmjCXdIg"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B8B67F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107632; cv=none; b=svgPkh1ixuMpLuEuzUzr3ezO4YgRbJhPT5YlzNwsucYGgOAGLuSfuLngCBDnAkiQ/H3118J/RMPXLyVd3rL2OBYEBg/t7PLzr4G31SZG2gmMsa2KLPnxx9RwO1waFoCB485xyaGSn2eo+bbg3DMXj2Dj8USaFxwRhop35u7jyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107632; c=relaxed/simple;
	bh=n9mrTrq5+LraWjYtTuapNum43v8RQdRKu8yn8S9340Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/to7yvx8ptMbD3CgrM7wqzRILjw5Utiym2L3IRFVTbzcYC624kh0hLLFivapXeyIwbpg225m2i74BsQ2e0ia4QX2LshZ+Ntg3vs8oSu1tRTH7YY4fqcO/nPfymv+oSGhcRtdcCwpOSDS/3Yv+aosGwFWFpDcyBmQ/qlsL8dczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZmjCXdIg; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JMUzw
	31GzDBFXXf8S1ZK7C+G64nkNDBD7NUvACKUfvQ=; b=ZmjCXdIgRpH7/ngq7XHOr
	KQPYqt4HuVr8JiFzTBfliCRgnd02iUJQ8U6pZhd4LHfFBhL6+UvQkxZ0zVEpixs6
	CnX7zggda+ASWDncJOG5S6ezu5aYFDq34Gb+kyxqUPnC8d8LiDhu9xgz+Wmzx6Gf
	RrDY71YK2ac3waOOa2hjFY=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDnr1ZgBJZmH_lwBQ--.2434S2;
	Tue, 16 Jul 2024 13:25:53 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	Xavier <xavier_qy@163.com>
Subject: [PATCH-RT sched v3 2/2] RT test: Adding test cases for RT group scheduling
Date: Tue, 16 Jul 2024 13:25:43 +0800
Message-Id: <20240716052543.302383-3-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716052543.302383-1-xavier_qy@163.com>
References: <20240716052543.302383-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr1ZgBJZmH_lwBQ--.2434S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1xGr47XFy8ZrykCFWDXFb_yoWftFy8pF
	WkuryDAw4rG3W3trs3Ca10vF1ruws7ZFW7JrZ3KryUAa4xGFs3tFyIkFW2qrn3CrWF9w13
	Zayagay7CF47trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-db8UUUUU=
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwgEeEGWXvkgPIgABsl

Adding test cases for RT group scheduling, create some RT infinite loop
processes/threads, then set them to the same or different priorities.
Place them in different RT task groups, run for a period of time,
and finally count the number of infinite loop executions for all tasks.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 MAINTAINERS                                   |   7 +
 tools/testing/selftests/sched/Makefile        |   4 +-
 tools/testing/selftests/sched/deadloop.c      | 192 ++++++++++++++++++
 .../selftests/sched/rt_group_sched_test.sh    | 119 +++++++++++
 4 files changed, 320 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched/deadloop.c
 create mode 100755 tools/testing/selftests/sched/rt_group_sched_test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 43353b705988..d29effe57bf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19480,6 +19480,13 @@ L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/rpmsg_tty.c
 
+RT GROUP SCHED TEST
+M:	Xavier <xavier_qy@163.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	tools/testing/selftests/sched/deadloop.c
+F:	tools/testing/selftests/sched/rt_group_sched_test.sh
+
 RTL2830 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..96decb58bf35 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -8,7 +8,7 @@ CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
-TEST_GEN_FILES := cs_prctl_test
-TEST_PROGS := cs_prctl_test
+TEST_GEN_FILES := cs_prctl_test deadloop
+TEST_PROGS := cs_prctl_test deadloop
 
 include ../lib.mk
diff --git a/tools/testing/selftests/sched/deadloop.c b/tools/testing/selftests/sched/deadloop.c
new file mode 100644
index 000000000000..d850a3e2a0ab
--- /dev/null
+++ b/tools/testing/selftests/sched/deadloop.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <signal.h>
+
+/*
+ * Create multiple infinite loop threads based on the passed parameters
+ * Usage: deadloop num policy prio
+ *	num: the number of child threads
+ *	policy: the scheduling policy of the child threads, 0-fair, 1-fifo, 2-rr
+ *	prio: the priority
+ * If this process is killed, it will print the loop count of all child threads
+ * to the OUTPUT_FILE
+ *
+ * Date: June 27, 2024
+ * Author: Xavier <xavier_qy@163.com>
+ */
+
+#define OUTPUT_FILE "rt_group_sched_test.log"
+
+#if __GLIBC_PREREQ(2, 30) == 0
+#include <sys/syscall.h>
+static pid_t gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+#endif
+
+#define do_err(x) \
+do { \
+	if ((x) < 0) {  \
+		printf("test BUG_ON func %s, line %d %ld\n", \
+			__func__, __LINE__, (long)(x) \
+		); \
+		while (1) \
+			sleep(1); \
+	} \
+} while (0)
+
+#define do_false(x) \
+do { \
+	if ((x) == 1) { \
+		printf("test BUG_ON func %s, line %d %d\n", \
+			__func__, __LINE__, (x) \
+		); \
+		while (1) \
+			sleep(1); \
+	} \
+} while (0)
+
+
+struct thread_data {
+	pthread_t thread;
+	int index;
+	int pid;
+	unsigned long cnt;
+};
+
+static struct thread_data *pdata;
+static int thread_num = 1;
+
+static void create_thread_posix(void *entry, pthread_t *thread, int *para,
+								 int policy, int prio)
+{
+	int					ret;
+	struct sched_param	param;
+	pthread_attr_t		attr;
+
+	memset(&param, 0, sizeof(param));
+	ret = pthread_attr_init(&attr);
+	do_err(ret);
+
+	ret = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
+	do_err(ret);
+
+	param.sched_priority = prio;
+
+	ret = pthread_attr_setschedpolicy(&attr, policy);
+	do_err(ret);
+
+	ret = pthread_attr_setschedparam(&attr, &param);
+	do_err(ret);
+
+	ret = pthread_create(thread, &attr, entry, para);
+	do_err(ret);
+}
+
+static void *dead_loop_entry(void *arg)
+{
+	int index = *(int *)arg;
+	struct sched_param param;
+	int cur = gettid();
+
+	sched_getparam(cur, &param);
+	pdata[index].pid = cur;
+	printf("cur:%d prio:%d\n", cur, param.sched_priority);
+
+	while (1) {
+		asm volatile("" ::: "memory");
+		pdata[index].cnt++;
+	}
+	return NULL;
+}
+
+static void handle_signal(int signal)
+{
+	int cnt = 0;
+
+	if (signal == SIGTERM) {
+		FILE *file = freopen(OUTPUT_FILE, "a", stdout);
+
+		if (file == NULL) {
+			perror("freopen");
+			exit(0);
+		}
+
+		while (cnt < thread_num) {
+			printf("pid:%d cnt:%ld\n", pdata[cnt].pid, pdata[cnt].cnt);
+			cnt++;
+		}
+		fclose(file);
+		exit(0);
+	}
+}
+
+static int dead_loop_create(int policy, int prio)
+{
+	int cnt = 0;
+	int ret;
+	void *status;
+	struct sched_param param;
+
+	param.sched_priority = prio;
+	pdata = malloc(thread_num * sizeof(struct thread_data));
+	do_false(!pdata);
+
+	if (policy) {
+		ret = sched_setscheduler(0, policy, &param);
+		do_err(ret);
+	}
+
+	while (cnt < thread_num) {
+		pdata[cnt].index = cnt;
+		create_thread_posix(dead_loop_entry, &pdata[cnt].thread,
+								 &pdata[cnt].index, policy, prio);
+		cnt++;
+	}
+
+	signal(SIGTERM, handle_signal);
+
+	cnt = 0;
+	while (cnt < thread_num) {
+		pthread_join(pdata[cnt].thread, &status);
+		cnt++;
+	}
+
+	free(pdata);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int policy = 2;
+	int prio = 50;
+
+	if (argc == 2)
+		thread_num = atoi(argv[1]);
+
+	if (argc == 3) {
+		thread_num = atoi(argv[1]);
+		policy = atoi(argv[2]);
+		if (policy > 0)
+			prio = 50;
+	}
+
+	if (argc == 4) {
+		thread_num = atoi(argv[1]);
+		policy = atoi(argv[2]);
+		prio = atoi(argv[3]);
+	}
+
+	dead_loop_create(policy, prio);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/sched/rt_group_sched_test.sh b/tools/testing/selftests/sched/rt_group_sched_test.sh
new file mode 100755
index 000000000000..9031250a2684
--- /dev/null
+++ b/tools/testing/selftests/sched/rt_group_sched_test.sh
@@ -0,0 +1,119 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test for rt group scheduling
+# Date: June 27, 2024
+# Author: Xavier <xavier_qy@163.com>
+
+# Record the list of child process PIDs
+PIDS=()
+
+# File for redirected output
+LOGFILE="rt_group_sched_test.log"
+
+# Cleanup function: kill all recorded child processes and unmount the cgroup
+function cleanup() {
+	echo "Cleaning up..."
+	for pid in "${PIDS[@]}"; do
+		if kill -0 $pid 2>/dev/null; then
+			kill -TERM $pid
+		fi
+	done
+
+	# Sleep for a while to ensure the processes are properly killed
+	sleep 2
+
+	# Unmount the cgroup filesystem
+	umount /sys/fs/cgroup/cpu 2>/dev/null
+	umount /sys/fs/cgroup 2>/dev/null
+	echo "Cleanup completed."
+
+	# Ensure the LOGFILE exists and is correct
+	if [ ! -f "$LOGFILE" ]; then
+		echo "$LOGFILE not found!"
+		exit 1
+	fi
+
+	# Initialize the total count variable
+	total=0
+
+	# Read matching lines and calculate the total sum
+	while IFS= read -r line
+	do
+		# Use grep to match lines containing 'pid:' and 'cnt:', and extract the value of cnt
+		if echo "$line" | grep -q '^pid:[[:digit:]]\+ cnt:[[:digit:]]\+'; then
+			cnt=$(echo "$line" | sed -n \
+			  's/^pid:[[:digit:]]\+ cnt:\([[:digit:]]\+\)/\1/p')
+			total=$((total + cnt))
+		fi
+	done < "$LOGFILE"
+
+	# Print the total sum
+	echo "Total cnt: $total"
+	echo "Finished processing."
+}
+
+# Capture actions when interrupted or terminated by a signal
+trap cleanup EXIT
+
+# Start the cgroup filesystem and create the necessary directories
+function setup_cgroups() {
+	mount -t tmpfs -o mode=755 cgroup_root /sys/fs/cgroup
+	mkdir -p /sys/fs/cgroup/cpu
+	mount -t cgroup -o cpu none /sys/fs/cgroup/cpu
+}
+
+# Create cgroup subdirectories and configure their settings
+function create_child_cgroup() {
+	local base_dir=$1
+	local name=$2
+	local rt_period=$3
+	local rt_runtime=$4
+	mkdir -p "$base_dir/$name"
+	echo $rt_period > "$base_dir/$name/cpu.rt_period_us"
+	echo $rt_runtime > "$base_dir/$name/cpu.rt_runtime_us"
+}
+# Launch a process and add it to the specified cgroup
+function launch_process() {
+	local process_name=$1
+
+	# Three parameters representing the number of child threads, scheduling policy, and priority
+	local args=$2
+	local cgroup_path=$3
+
+	# Launch the process
+	exec -a $process_name ./deadloop $args &
+	local pid=$!
+	PIDS+=($pid)
+
+	# Short sleep to ensure the process starts
+	sleep 1
+
+	# Check if the process started successfully
+	if ! pgrep -x $process_name > /dev/null; then
+		echo "Error: No process found with name $process_name."
+		exit 1
+	fi
+
+	echo $pid > "$cgroup_path/cgroup.procs"
+	echo "Process $process_name with PID $pid added to cgroup $cgroup_path"
+}
+
+# Main function running all tasks
+function main() {
+	echo "The test needs 30 seconds..."
+	rm -f "$LOGFILE"
+	setup_cgroups
+	create_child_cgroup "/sys/fs/cgroup/cpu" "child1" 1000000 800000
+	create_child_cgroup "/sys/fs/cgroup/cpu/child1" "child2" 1000000 700000
+	create_child_cgroup "/sys/fs/cgroup/cpu/child1/child2" "child3" 1000000 600000
+	launch_process "child1" "3 2 50" "/sys/fs/cgroup/cpu/child1"
+	launch_process "child2" "3 2 50" "/sys/fs/cgroup/cpu/child1/child2"
+	launch_process "child3" "1 2 50" "/sys/fs/cgroup/cpu/child1/child2/child3"
+	launch_process "tg_root" "1 2 50" "/sys/fs/cgroup/cpu"
+
+	# Run for 30 seconds
+	sleep 30
+}
+
+# Execute the main function
+main
-- 
2.45.2


