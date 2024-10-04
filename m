Return-Path: <linux-kernel+bounces-351371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B150399101B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E0F28177C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CD1E32C3;
	Fri,  4 Oct 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2CUIwt4T"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC561E2306
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071751; cv=none; b=qJ/GVHclIYexc+vHBK1Wq/lZTIkGMVptluJrUe+SP1gnmptoKoU+Xunwldpc9TEGvWHaZn7UnWvGkzh5kzDOicgy5exOA3hbn1K/eG3aP/ZCwtsgixTi1BTKh7Wn/QBsegASO9N2Ai7Kh3SISU9HPNEqve28sRlthHMiKq7AOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071751; c=relaxed/simple;
	bh=s/TK3RBzGYb24+3inpEnxECyw5ok/NiB3oxf3jwxHGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPRTp4BFaLUTcbZChVzZzNy5xCjyFzzf51eU661+Xj0B44jB+p4dDTO7nO0b631dqyqtxeZaGS5VWdBiggl+5CZr2yRPfab4K/HMAxczuJECnhGM9brmVZ2U7wOVkYNAQmA+75Pl66dkZs9kh+MSVcppGBe+tbjR+LS1ejZJG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2CUIwt4T; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71da742892aso3057801b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728071749; x=1728676549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyDR+uj3DUNXBrtUhe7IJycvNyVdH4HzZ+qoUtsI/QE=;
        b=2CUIwt4T32J964o9lYs0aKviHCPV6F16jb766DLuDO4aFmsszZm5dYAPl8dP8wRCvd
         9NtbIut3VQpgSc/ag0eMgR2Fzm33d3brTjGxGfglwP1baObLoUG5gOk8dUnIuKgrl9O0
         eYqFBG0jywvfZk7pU3KnP0FGrP5bi/06W7xAiI0T5wTJZC2bBWl0+1YhSwn4CWenKe7I
         LgeRcU0idsDlnJelHhukBFAV5dA2MUuFpxmYKj938+ydiDDJD4Dk1swCTAb7/rD6/Eye
         /jl1iikNgpd5SsRS/TGX7IJ/RHBX7MEkDRAVRioTAQjoXGyI57uqh/DRSwbou5Zx4Cfd
         8veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071749; x=1728676549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyDR+uj3DUNXBrtUhe7IJycvNyVdH4HzZ+qoUtsI/QE=;
        b=Kp+W3tJ39BIiGV1ZWE1qIGStRk1nUHu3AmjN3sosXtCAMQ7de7cgNHlO1jf5O2P2VU
         mXSqhatkeo0+lwNOPLi1qR6u7gn/a1KK/V8LC5Fsk4snp/Y4YR0mW/iYxqhU1hq8Uypw
         UMyJ2q/72OTe2oV739Ba4oCoE9FbM3NEBcaH/OUtt0JE72v1nEcNtpF41MOKpOeRfC/m
         Bb9wpRlF4rfgUhHamkIMwK0HAawsJCs05CwOQUNCE7+4hHd+Fmi8auP1DGneBImVUgv6
         hKV+TEaMaHgjZpo7l0mtsNS6ZWIVIitB8nyNJah2d+IhhMCUoHubWsbwRa1URSQAyFH/
         a/fA==
X-Forwarded-Encrypted: i=1; AJvYcCUqJa+46+EK6Pcm2ws5lWYQ3TY2+e1DgcRIDnR65YzvT0c7OZNfcddbb2LxKxDcOEYwWZ+1tzqqLMGXCSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXp9m/NF7Iv2+mk4MRy8sbYW6Pbcfq47aa8k/HCyhB3Ugryzt+
	XNROTRX+K33YXgi+9nXRSAJBsLCSxe1zC6wWKRHsPB/xihlBKUoJwRqyIIChY+s/KQHJQw7WexY
	sJM1WbA==
X-Google-Smtp-Source: AGHT+IEPqABrZbInB9iF+3YhRj7tIobE3sERHXQs5uQYKTkhSk5zgLJdd7oOaPB+U/5x7r0jRQxnAieri8NH
X-Received: from vipin.c.googlers.com ([34.105.13.176]) (user=vipinsh
 job=sendgmr) by 2002:a05:6a00:3199:b0:71d:ec11:1214 with SMTP id
 d2e1a72fcca58-71dec11129amr5983b3a.0.1728071749432; Fri, 04 Oct 2024 12:55:49
 -0700 (PDT)
Date: Fri,  4 Oct 2024 12:55:40 -0700
In-Reply-To: <20241004195540.210396-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004195540.210396-1-vipinsh@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004195540.210396-4-vipinsh@google.com>
Subject: [PATCH v2 3/3] KVM: selftests: Add a test to invoke MMU shrinker on
 KVM VMs
From: Vipin Sharma <vipinsh@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc: zhi.wang.linux@gmail.com, weijiang.yang@intel.com, mizhang@google.com, 
	liangchen.linux@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a test which invokes KVM MMU shrinker to free caches used by vCPUs in
KVM while a VM is running. Find the KVM MMU shrinker location in
shrinker_debugfs and invoke its scan file to fire the shrinker. Provide
options to specify number of vCPUs, memory accessed by each vCPU, number
of iterations of firing the shrinker scan and delay in milliseconds to
take a pause between two consecutive shrinker calls.

If shrinker_debugfs is not mounted then exit with soft skip.

Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/test_util.h |   5 +
 tools/testing/selftests/kvm/lib/test_util.c   |  51 ++++
 .../selftests/kvm/x86_64/mmu_shrinker_test.c  | 269 ++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/mmu_shrinker_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 45cb70c048bb7..a0119e44a37f6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -81,6 +81,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_tlb_flush
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_test
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_pv_test
+TEST_GEN_PROGS_x86_64 += x86_64/mmu_shrinker_test
 TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
 TEST_GEN_PROGS_x86_64 += x86_64/nested_exceptions_test
 TEST_GEN_PROGS_x86_64 += x86_64/platform_info_test
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849ff..7fb530fbc9ce3 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -218,4 +218,9 @@ char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2), n
 
 char *sys_get_cur_clocksource(void);
 
+int find_debugfs_root(char *debugfs_path, size_t size);
+int find_debugfs_subsystem_path(const char *subsystem,
+				char *debugfs_subsystem_path,
+				size_t max_path_size);
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae8373..abd2837b5d69d 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2020, Google LLC.
  */
+#include <linux/limits.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <assert.h>
@@ -15,6 +16,8 @@
 #include <sys/syscall.h>
 #include <linux/mman.h>
 #include "linux/kernel.h"
+#include <mntent.h>
+#include <string.h>
 
 #include "test_util.h"
 
@@ -415,3 +418,51 @@ char *sys_get_cur_clocksource(void)
 
 	return clk_name;
 }
+
+int find_debugfs_root(char *debugfs_path, size_t size)
+{
+	FILE *mtab = setmntent("/etc/mtab", "r");
+	struct mntent *mntent;
+	int r = -ENOENT;
+
+	if (!mtab)
+		return r;
+
+	while ((mntent = getmntent(mtab))) {
+		if (strcmp("debugfs", mntent->mnt_type))
+			continue;
+
+		if (strlen(mntent->mnt_dir) >= size) {
+			r = -EOVERFLOW;
+		} else {
+			strcpy(debugfs_path, mntent->mnt_dir);
+			r = 0;
+		}
+		break;
+	}
+
+	endmntent(mtab);
+	return r;
+}
+
+int find_debugfs_subsystem_path(const char *subsystem,
+				char *debugfs_subsystem_path,
+				size_t max_path_size)
+{
+	char debugfs_path[PATH_MAX];
+	int ret;
+
+	ret = find_debugfs_root(debugfs_path, PATH_MAX);
+	if (ret)
+		return ret;
+
+	/* Add extra 1 for separator "/". */
+	if (strlen(debugfs_path) + 1 + strlen(subsystem) >= max_path_size)
+		return -EOVERFLOW;
+
+	strcpy(debugfs_subsystem_path, debugfs_path);
+	strcat(debugfs_subsystem_path, "/");
+	strcat(debugfs_subsystem_path, subsystem);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/mmu_shrinker_test.c b/tools/testing/selftests/kvm/x86_64/mmu_shrinker_test.c
new file mode 100644
index 0000000000000..81dd745bcebdb
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/mmu_shrinker_test.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMU shrinker test
+ *
+ * Test MMU shrinker invocation on VMs. This test needs kernel built with
+ * shrinker debugfs and mounted. Generally that location is
+ * /sys/debug/kernel/shrinker.
+ *
+ * Test will keep adding and removing memslots while guest is accessing memory
+ * so that vCPUs will keep taking fault and filling up caches to process the
+ * page faults. It will also invoke shrinker after memslot changes which will
+ * race with vCPUs to empty caches.
+ *
+ * Copyright 2010 Google LLC
+ *
+ */
+
+#include "guest_modes.h"
+#include "kvm_util.h"
+#include "memstress.h"
+#include "test_util.h"
+#include "ucall_common.h"
+
+#include <dirent.h>
+#include <error.h>
+#include <fnmatch.h>
+#include <kselftest.h>
+#include <linux/limits.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#define SHRINKER_DIR "shrinker"
+#define KVM_MMU_SHRINKER_PREFIX "x86-mmu-*"
+#define SHRINKER_SCAN_FILE "scan"
+#define DUMMY_MEMSLOT_INDEX 10
+#define DEFAULT_MMU_SHRINKER_ITERATIONS 5
+#define DEFAULT_MMU_SHRINKER_VCPUS 2
+#define DEFAULT_MMU_SHRINKER_DELAY_MS 100
+
+struct test_params {
+	uint64_t iterations;
+	uint64_t guest_percpu_mem_size;
+	int delay_ms;
+	int nr_vcpus;
+	char kvm_shrink_scan_file[PATH_MAX];
+};
+
+static int filter(const struct dirent *dir)
+{
+	return !fnmatch(KVM_MMU_SHRINKER_PREFIX, dir->d_name, 0);
+}
+
+static int find_kvm_shrink_scan_path(const char *shrinker_path,
+				     char *kvm_shrinker_path, size_t size)
+{
+	struct dirent **dirs = NULL;
+	int ret = 0;
+	size_t len;
+	int n;
+
+	n = scandir(shrinker_path, &dirs, filter, NULL);
+	if (n == -1) {
+		return -errno;
+	} else if (n != 1) {
+		pr_info("Expected one x86-mmu shrinker but found %d\n", n);
+		ret = -ENOTSUP;
+		goto out;
+	}
+
+	len = strnlen(shrinker_path, PATH_MAX) +
+	      1 + /* For path separator '/' */
+	      strnlen(dirs[0]->d_name, PATH_MAX) +
+	      1 + /* For path separator '/' */
+	      strnlen(SHRINKER_SCAN_FILE, PATH_MAX);
+
+	if (len >= PATH_MAX) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+
+	strcpy(kvm_shrinker_path, shrinker_path);
+	strcat(kvm_shrinker_path, "/");
+	strcat(kvm_shrinker_path, dirs[0]->d_name);
+	strcat(kvm_shrinker_path, "/");
+	strcat(kvm_shrinker_path, SHRINKER_SCAN_FILE);
+
+out:
+	while (n > 0)
+		free(dirs[n--]);
+	free(dirs);
+	return ret;
+}
+
+static void find_and_validate_kvm_shrink_scan_file(char *kvm_mmu_shrink_scan_file, size_t size)
+{
+	char shrinker_path[PATH_MAX];
+	int ret;
+
+	ret = find_debugfs_subsystem_path(SHRINKER_DIR, shrinker_path, PATH_MAX);
+	if (ret == -ENOENT) {
+		pr_info("Cannot find debugfs, error (%d - %s). Skipping the test.\n",
+			-ret, strerror(-ret));
+		exit(KSFT_SKIP);
+	} else if (ret) {
+		exit(-ret);
+	}
+
+	ret = find_kvm_shrink_scan_path(shrinker_path, kvm_mmu_shrink_scan_file, size);
+	if (ret == -ENOENT) {
+		pr_info("Cannot find kvm shrinker debugfs path, error (%d - %s). Skipping the test.\n",
+			-ret, strerror(-ret));
+		exit(KSFT_SKIP);
+	} else if (ret) {
+		exit(-ret);
+	}
+
+	if (access(kvm_mmu_shrink_scan_file, W_OK))
+		exit(errno);
+
+	pr_info("Got KVM MMU shrink scan file at: %s\n",
+		kvm_mmu_shrink_scan_file);
+}
+
+static int invoke_kvm_mmu_shrinker_scan(struct kvm_vm *vm,
+					const char *kvm_shrink_scan_file,
+					uint64_t iterations, int delay_ms)
+{
+	uint64_t pages = 1;
+	uint64_t gpa;
+	FILE *shrinker_scan_fp;
+	struct timespec ts;
+	int i = 1;
+
+	ts.tv_sec = delay_ms / 1000;
+	ts.tv_nsec = (delay_ms - (ts.tv_sec * 1000)) * 1000000;
+
+	gpa = memstress_args.gpa - pages * vm->page_size;
+
+	shrinker_scan_fp = fopen(kvm_shrink_scan_file, "w");
+	if (!shrinker_scan_fp) {
+		pr_info("Not able to open KVM shrink scan file for writing\n");
+		return -errno;
+	}
+
+	while (iterations--) {
+		/* Adding and deleting memslots rebuilds the page table */
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa,
+					    DUMMY_MEMSLOT_INDEX, pages, 0);
+		vm_mem_region_delete(vm, DUMMY_MEMSLOT_INDEX);
+
+		pr_info("Iteration %d: Invoking shrinker.\n", i++);
+		fprintf(shrinker_scan_fp, "0 0 1000\n");
+		rewind(shrinker_scan_fp);
+
+		nanosleep(&ts, NULL);
+	}
+
+	fclose(shrinker_scan_fp);
+	return 0;
+}
+
+static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
+{
+	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
+	struct kvm_run *run;
+	int ret;
+
+	run = vcpu->run;
+
+	/* Let the guest access its memory until a stop signal is received */
+	while (!READ_ONCE(memstress_args.stop_vcpus)) {
+		ret = _vcpu_run(vcpu);
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d", ret);
+
+		if (get_ucall(vcpu, NULL) == UCALL_SYNC)
+			continue;
+
+		TEST_ASSERT(false,
+			    "Invalid guest sync status: exit_reason=%s\n",
+			    exit_reason_str(run->exit_reason));
+	}
+}
+
+static void run_test(struct test_params *p)
+{
+	struct kvm_vm *vm;
+	int nr_vcpus = p->nr_vcpus;
+
+	pr_info("Creating the VM.\n");
+	vm = memstress_create_vm(VM_MODE_DEFAULT, p->nr_vcpus,
+				 p->guest_percpu_mem_size,
+				 /*slots =*/1, DEFAULT_VM_MEM_SRC,
+				 /*partition_vcpu_memory_access=*/true);
+
+	memstress_start_vcpu_threads(p->nr_vcpus, vcpu_worker);
+
+	pr_info("Starting the test.\n");
+	invoke_kvm_mmu_shrinker_scan(vm, p->kvm_shrink_scan_file, p->iterations,
+				     p->delay_ms);
+
+	pr_info("Test completed.\nStopping the VM.\n");
+	memstress_join_vcpu_threads(nr_vcpus);
+	memstress_destroy_vm(vm);
+}
+
+static void help(char *name)
+{
+	puts("");
+	printf("usage: %s [-b memory] [-d delay_usec] [-i iterations] [-h]\n"
+	       "       [-v vcpus] \n", name);
+	printf(" -b: specify the size of the memory region which should be\n"
+	       "     accessed by each vCPU. e.g. 10M or 3G. (Default: 1G)\n");
+	printf(" -d: add a delay between each iterations of firing MMU shrinker\n"
+	       "     scan in milliseconds. (Default: %dms).\n",
+	       DEFAULT_MMU_SHRINKER_DELAY_MS);
+	printf(" -i: specify the number of iterations of firing MMU shrinker.\n"
+	       "     scan. (Default: %d)\n",
+	       DEFAULT_MMU_SHRINKER_ITERATIONS);
+	printf(" -v: specify the number of vCPUs to run. (Default: %d)\n",
+	       DEFAULT_MMU_SHRINKER_VCPUS);
+	printf(" -h: Print the help message.\n");
+	puts("");
+}
+
+int main(int argc, char *argv[])
+{
+	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	struct test_params p = {
+		.iterations = DEFAULT_MMU_SHRINKER_ITERATIONS,
+		.guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE,
+		.nr_vcpus = DEFAULT_MMU_SHRINKER_VCPUS,
+		.delay_ms = DEFAULT_MMU_SHRINKER_DELAY_MS,
+	};
+	int opt;
+
+	while ((opt = getopt(argc, argv, "b:d:i:v:")) != -1) {
+		switch (opt) {
+		case 'b':
+			p.guest_percpu_mem_size = parse_size(optarg);
+			break;
+		case 'd':
+			p.delay_ms = atoi_non_negative("Time gap between two MMU shrinker invocations in milliseconds",
+						       optarg);
+			break;
+		case 'i':
+			p.iterations = atoi_positive("Number of iterations", optarg);
+			break;
+		case 'v':
+			p.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
+			TEST_ASSERT(p.nr_vcpus <= max_vcpus,
+				    "Invalid number of vcpus, must be between 1 and %d",
+				    max_vcpus);
+			break;
+		case 'h':
+			help(argv[0]);
+			exit(EXIT_SUCCESS);
+		default:
+			help(argv[0]);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	find_and_validate_kvm_shrink_scan_file(p.kvm_shrink_scan_file, PATH_MAX);
+	run_test(&p);
+	return 0;
+}
-- 
2.47.0.rc0.187.ge670bccf7e-goog


