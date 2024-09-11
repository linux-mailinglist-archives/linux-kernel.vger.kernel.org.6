Return-Path: <linux-kernel+bounces-324024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353739746EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B53287AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE72C1C2DD2;
	Tue, 10 Sep 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWdp0suZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428D1C2458
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011932; cv=none; b=e/t+oxQ8ulrhmOeeXoj3UdG7CLxB2yrJdAmd07506X0VRs2sHBlft+SzYg9LF5c4GZ2IeltOmmOxjhc64unLH6Dyh80rGC3qGHI8zkAcPUIk+4YupSp461hX7obbgTvIqjw6pocMujInYv87GuaYe+3wG6YP6hpuQyU+ZC4l3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011932; c=relaxed/simple;
	bh=G5DVY9O/BmZ1THKu+vEQ50mgiE7dZQUwvb/YLif0DiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxXy+TKC21m+lKXRdwmAlevBGmCZJFqIXIPhEqVCjxJx3+KuNR9lasbDBgZOiA/gu8Beh8wqTZ/tbzKWLCI3U4tAz3Gpe0MNnkMixMzgihZBhhsVR5ffiOMolYjNowRgju7MHsUKx44xUVAczA+PSq+6lDQDaqI4B947Eys8CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWdp0suZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1aa529e30eso13655562276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011930; x=1726616730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=afFoS57EFj7PA7MrTOtXA3rUEPuyIQGDyAEgOLUqk8M=;
        b=lWdp0suZRpXSRu4Hul5FaDqogquQ6QGqb/ToKA+AJnL6m6UpNs9Nund7+l+sLDOAUF
         /j+ic7xQUewi9UJr/lrvFLfbRPXWeQpO2mI3KfwUKkUKPSrOV1pCDUPInXk/vg9BcMOU
         wSDg+c4PkWQ6ZJKcb+lHdjC8JPmNV8WxtjmUwQne/eGzJWJ33kEy+oV8AQLGvdpClFPy
         k0HwsHPW8qATH4D5C7Ki5oScr0ZwKgpUnSDu/dQTwDqjYxZkahu5g8aIej9M+s2qHvib
         bZwE0oIOqmUuEv1HjuYTPNwWxURQu8GJo2B71KOxBIH63LDusmi/n1VR0WM2CPTsDzJ2
         VCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011930; x=1726616730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afFoS57EFj7PA7MrTOtXA3rUEPuyIQGDyAEgOLUqk8M=;
        b=P2cB/tYCIo0EzPhA5TLJ4Bm9QtJR4sPRrbVwQtQehnO8PJkNZiC669cRx9NVIbYHyK
         9XVWIxqxjUzZaTpac0Umsq9TSchDTR31t3ASiGoK7EI9ptHWOap0sWXf7cnVpLpMWCpx
         HT6IDPMQRfakT3lC+Qt3HPmQSF3EqekhKYCAteTPmSjclEY+xr2zDLB/YkJkX5ePC2+K
         soFudDjsBFdyb7a9ak2CW1F5n6Z/lE/EG4BYekS16ohCe8juKCHj6Q2VyW9cVbuAMfPi
         0oQXMbErai52vPg1JFIolS6FOq9IAaK0nPxRW5yHIA5jIen543WkogB+L2mMgCf2ZO2A
         U1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXZFIFfXq1d5ecDs5qMRWbQR3OphuskWPg9LAhGk9RTd+YTsq8lQ4UEZ5xAvrBXbCkAhQkN5sm7LVjbLt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzcYQTSPK2kie2yweexSqVvITgH3tLQcXVvlNvC0bnJlX9gYL
	Dz0D8CmL9CUm5V+MV76V/mzdkKkn9c2xHWr3VaNxcBHwhhlTsLkvqM8HD8KKLjgXevmwlPOTWCD
	uYp7IwpLUBBEe74+sA/d4Dg==
X-Google-Smtp-Source: AGHT+IFM7zwKBbA2/Jy7tyIWzTxWbF+45RbnY6QrI6xQ5u7bHZg40qPkgO7/Rd+Sibot2kYeLv7TVh8XJXwwFOEoiw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:ef46:0:b0:e1a:8735:8390 with SMTP
 id 3f1490d57ef6-e1d3489c673mr70623276.4.1726011929867; Tue, 10 Sep 2024
 16:45:29 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:04 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <19a16094c3e99d83c53931ff5f3147079d03c810.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 33/39] KVM: selftests: Test guest_memfd memory sharing
 between guest and host
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Minimal test for guest_memfd to test that when memory is marked shared
in a VM, the host can read and write to it via an mmap()ed address,
and the guest can also read and write to it.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/guest_memfd_sharing_test.c  | 160 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_sharing_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b3b7e83f39fc..3c1f35456bfc 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -135,6 +135,7 @@ TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
 TEST_GEN_PROGS_x86_64 += guest_memfd_test
 TEST_GEN_PROGS_x86_64 += guest_memfd_hugetlb_reporting_test
+TEST_GEN_PROGS_x86_64 += guest_memfd_sharing_test
 TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/guest_memfd_sharing_test.c b/tools/testing/selftests/kvm/guest_memfd_sharing_test.c
new file mode 100644
index 000000000000..fef5a73e5053
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_sharing_test.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Minimal test for guest_memfd to test that when memory is marked shared in a
+ * VM, the host can read and write to it via an mmap()ed address, and the guest
+ * can also read and write to it.
+ *
+ * Copyright (c) 2024, Google LLC.
+ */
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "ucall_common.h"
+
+#define GUEST_MEMFD_SHARING_TEST_SLOT 10
+#define GUEST_MEMFD_SHARING_TEST_GPA 0x50000000ULL
+#define GUEST_MEMFD_SHARING_TEST_GVA 0x90000000ULL
+#define GUEST_MEMFD_SHARING_TEST_OFFSET 0
+#define GUEST_MEMFD_SHARING_TEST_GUEST_TO_HOST_VALUE 0x11
+#define GUEST_MEMFD_SHARING_TEST_HOST_TO_GUEST_VALUE 0x22
+
+static void guest_code(int page_size)
+{
+	char *mem;
+	int i;
+
+	mem = (char *)GUEST_MEMFD_SHARING_TEST_GVA;
+
+	for (i = 0; i < page_size; ++i) {
+		GUEST_ASSERT_EQ(mem[i], GUEST_MEMFD_SHARING_TEST_HOST_TO_GUEST_VALUE);
+	}
+
+	memset(mem, GUEST_MEMFD_SHARING_TEST_GUEST_TO_HOST_VALUE, page_size);
+
+	GUEST_DONE();
+}
+
+int run_test(struct kvm_vcpu *vcpu, void *hva, int page_size)
+{
+	struct ucall uc;
+	uint64_t uc_cmd;
+
+	memset(hva, GUEST_MEMFD_SHARING_TEST_HOST_TO_GUEST_VALUE, page_size);
+	vcpu_args_set(vcpu, 1, page_size);
+
+	/* Reset vCPU to guest_code every time run_test is called. */
+	vcpu_arch_set_entry_point(vcpu, guest_code);
+
+	vcpu_run(vcpu);
+	uc_cmd = get_ucall(vcpu, &uc);
+
+	if (uc_cmd == UCALL_ABORT) {
+		REPORT_GUEST_ASSERT(uc);
+		return 1;
+	} else if (uc_cmd == UCALL_DONE) {
+		char *mem;
+		int i;
+
+		mem = hva;
+		for (i = 0; i < page_size; ++i)
+			TEST_ASSERT_EQ(mem[i], GUEST_MEMFD_SHARING_TEST_GUEST_TO_HOST_VALUE);
+
+		return 0;
+	} else {
+		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+		return 1;
+	}
+}
+
+void *add_memslot(struct kvm_vm *vm, int guest_memfd, size_t page_size,
+		  bool back_shared_memory_with_guest_memfd)
+{
+	void *mem;
+
+	if (back_shared_memory_with_guest_memfd) {
+		mem = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			   guest_memfd, GUEST_MEMFD_SHARING_TEST_OFFSET);
+	} else {
+		mem = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	}
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should return valid address");
+
+	/*
+	 * Setting up this memslot with a KVM_X86_SW_PROTECTED_VM marks all
+	 * offsets in the file as shared.
+	 */
+	vm_set_user_memory_region2(vm, GUEST_MEMFD_SHARING_TEST_SLOT,
+				   KVM_MEM_GUEST_MEMFD,
+				   GUEST_MEMFD_SHARING_TEST_GPA, page_size, mem,
+				   guest_memfd, GUEST_MEMFD_SHARING_TEST_OFFSET);
+
+	return mem;
+}
+
+void test_sharing(bool back_shared_memory_with_guest_memfd)
+{
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	size_t page_size;
+	int guest_memfd;
+	void *mem;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, &guest_code);
+
+	page_size = getpagesize();
+
+	guest_memfd = vm_create_guest_memfd(vm, page_size, 0);
+
+	mem = add_memslot(vm, guest_memfd, page_size, back_shared_memory_with_guest_memfd);
+
+	virt_map(vm, GUEST_MEMFD_SHARING_TEST_GVA, GUEST_MEMFD_SHARING_TEST_GPA, 1);
+
+	run_test(vcpu, mem, page_size);
+
+	/* Toggle private flag of memory attributes and run the test again. */
+	if (back_shared_memory_with_guest_memfd) {
+		/*
+		 * Use MADV_REMOVE to release the backing guest_memfd memory
+		 * back to the system before it is used again. Test that this is
+		 * only necessary when guest_memfd is used to back shared
+		 * memory.
+		 */
+		madvise(mem, page_size, MADV_REMOVE);
+	}
+	vm_mem_set_private(vm, GUEST_MEMFD_SHARING_TEST_GPA, page_size);
+	vm_mem_set_shared(vm, GUEST_MEMFD_SHARING_TEST_GPA, page_size);
+
+	run_test(vcpu, mem, page_size);
+
+	kvm_vm_free(vm);
+	munmap(mem, page_size);
+	close(guest_memfd);
+}
+
+int main(int argc, char *argv[])
+{
+	/*
+	 * Confidence check that when guest_memfd is associated with a memslot
+	 * but only anonymous memory is used to back shared memory, sharing
+	 * memory between guest and host works as expected.
+	 */
+	test_sharing(false);
+
+	/*
+	 * Memory sharing should work as expected when shared memory is backed
+	 * with guest_memfd.
+	 */
+	test_sharing(true);
+
+	return 0;
+}
-- 
2.46.0.598.g6f2099f65c-goog


