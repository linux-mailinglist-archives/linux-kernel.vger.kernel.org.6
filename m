Return-Path: <linux-kernel+bounces-248426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE2A92DD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E64287225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F516D9DA;
	Wed, 10 Jul 2024 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olFEjrFU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161916D300
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654978; cv=none; b=WCVnn7vpouRw6IfF8VrjY1lkcAcyfwN2EJbA28R/iPAn7NQM0I2wSeEmU9aHvmwZ1wSIPVCWFWog+sr7xwTUUPEoE5/KrioYspweIxkyQWJ8o80TadDekseo7kUZahzPrsGywL7HXOM6dT5B9PjEBZKQDVY8GSmAdQGKbZCsd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654978; c=relaxed/simple;
	bh=eBdL3QVT/FXe2eEdF9QRtRlL8ltbcelrbHtqXfp5W3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWeYJ91Vr9CIy/7e4xqGlo82NYrz/tJYRYC7bvCVVQFn/wQtv0qot3XAD2MUcWO8isaDYnlJb68U1u+lrh/e/itFt5b5HgsKTz/w1+wEOUWFcKXcg/T/+Ji34nmN2V2KE23Sx4UTNZ7b5oEM8excyzS/hlI/y9q3xnVMgkGvSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olFEjrFU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a59172dbso416093276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654975; x=1721259775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=23lW1dYHwRXqrRIzh0tt4ShqtRWFD2EoChbCYcPjw+M=;
        b=olFEjrFURi3qSy42gzywIicXy4QwpEGsf6PYG/HOpvjB3nyrBTHPoIl96wDyMAhzbw
         0FrEFUj1qFhhe+y7CRVpTXqKxRMeldvuJ6bQ4Y9x0WWvtSxchu3YLvEvbpDfTmbEPX/Z
         fm+5PbxW721I2b+4cARVQXSh98dMAjDipUdSFC44cW2eQ/+rzzxjxuelRiEhZGNic92T
         J2xvoQJD4qNMdgdJo8nbmkDsuJSKAUewX5VTOMtL0bADcTCCNK8gjRDkyZxlDJ+AmBOY
         JDcYLcQU4ayrwMUKZbM6nEGDJLNnK5aXCX3CULBs2IcOMsxyLwE9ldRDJzcrKFxa6iO/
         KvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654975; x=1721259775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23lW1dYHwRXqrRIzh0tt4ShqtRWFD2EoChbCYcPjw+M=;
        b=xSX9m/AiS0twOHudyowFdw4wyTk8KAMEfrX8goljM+z+CNzOniWhBivjXZ1MPQnSCy
         eNZHf5bMMXFKBR2JC8hSYkeX8snxSHIS/ypRmNlIYpf2pmgDCYMpAQTfxgMFd92WaDVC
         eRdRsQMSBFfGpMt2mRC/9T9z3s/y+OHARThRVNXIvP3NZDIRZEf55pYNAw+q0HAj8e+S
         WZveWuWmfeXNj6rBQYP/j2IqkQrHogTPaN93SKNwnFlDo1oJkTP84u8RU3bAQV8unkTq
         HPuMaK8HYMuxVgbfiMqqslSK9M0NHgYxeYROzxjyathMp9F807ArD1t39XSMuVf/b5eO
         1uVw==
X-Forwarded-Encrypted: i=1; AJvYcCUn8fATZ60u5lQnxwQ+IBjS7HuY/sS4yNmJobgavOLnSBUi5VzOYPnyKQzF78v4BRzFenRs6FiqsIiSc6b3OJqW4yxoaSDCrHKSWULZ
X-Gm-Message-State: AOJu0YxjZGyHo+S0fMn0XfkHM0KoGAwgGqbUbbxaRkzMJTVVXZnfJt2i
	gI7/P+4vAK4WsL+PVW4u78mDdarguFj+gjXaAKlG56V4RIxlE3GQH3wvMqLLfLP+/2pC5GsFvpi
	t10Y6fntwj4QTWY2axA==
X-Google-Smtp-Source: AGHT+IH2x5mDHjhnJd4Mu/PM7RGmCTtDANjq+WihoofI52RvaYh1X5nH2Cnmm44GTYY+PggisrUn2Jo0WRfC2acE
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1ac1:b0:e03:62dc:63de with
 SMTP id 3f1490d57ef6-e041b0593efmr582356276.6.1720654974739; Wed, 10 Jul 2024
 16:42:54 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:21 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-18-jthoughton@google.com>
Subject: [RFC PATCH 17/18] KVM: selftests: Add KVM Userfault mode to demand_paging_test
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The KVM Userfault mode checks that we are able to resolve KVM Userfaults
and the vCPUs will continue to make progress. It initially sets all of
guest memory as KVM_MEMORY_ATTRIBUTE_USERFAULT, then, as the test runs,
clears the attribute from pages as they are faulted on.

This test does not currently check for asynchronous page faults.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 0202b78f8680..8654b58091b2 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -28,6 +28,13 @@ static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
 
 static size_t demand_paging_size;
 static char *guest_data_prototype;
+bool userfault_enabled = false;
+
+static void resolve_kvm_userfault(u64 gpa, u64 size)
+{
+	/* Toggle KVM_MEMORY_ATTRIBUTE_USERFAULT off */
+	vm_set_memory_attributes(memstress_args.vm, gpa, size, 0);
+}
 
 static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 {
@@ -41,8 +48,22 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
 	/* Let the guest access its memory */
+restart:
 	ret = _vcpu_run(vcpu);
-	TEST_ASSERT(ret == 0, "vcpu_run failed: %d", ret);
+	if (ret < 0 && errno == EFAULT && userfault_enabled) {
+		/* Check for userfault. */
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_MEMORY_FAULT,
+			    "Got invalid exit reason: %llx", run->exit_reason);
+		TEST_ASSERT(run->memory_fault.flags ==
+			    KVM_MEMORY_EXIT_FLAG_USERFAULT,
+			    "Got invalid memory fault exit: %llx",
+			    run->memory_fault.flags);
+		resolve_kvm_userfault(run->memory_fault.gpa,
+				      run->memory_fault.size);
+		goto restart;
+	} else
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d", ret);
+
 	if (get_ucall(vcpu, NULL) != UCALL_SYNC) {
 		TEST_ASSERT(false,
 			    "Invalid guest sync status: exit_reason=%s",
@@ -136,6 +157,7 @@ struct test_params {
 	int readers_per_uffd;
 	enum vm_mem_backing_src_type src_type;
 	bool partition_vcpu_memory_access;
+	bool kvm_userfault;
 };
 
 static void prefault_mem(void *alias, uint64_t len)
@@ -206,6 +228,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		}
 	}
 
+	if (p->kvm_userfault) {
+		TEST_REQUIRE(kvm_has_cap(KVM_CAP_USERFAULT));
+		vm_enable_cap(vm, KVM_CAP_USERFAULT, KVM_USERFAULT_ENABLE);
+		TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
+			     KVM_MEMORY_ATTRIBUTE_USERFAULT);
+		vm_set_memory_attributes(vm, memstress_args.gpa,
+					 memstress_args.size,
+					 KVM_MEMORY_ATTRIBUTE_USERFAULT);
+		userfault_enabled = true;
+	}
+
 	pr_info("Finished creating vCPUs and starting uffd threads\n");
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
@@ -232,6 +265,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	pr_info("Overall demand paging rate:\t%f pgs/sec\n",
 		vcpu_paging_rate * nr_vcpus);
 
+	if (p->kvm_userfault) {
+		vm_enable_cap(vm, KVM_CAP_USERFAULT, KVM_USERFAULT_DISABLE);
+		userfault_enabled = false;
+	}
+
 	memstress_destroy_vm(vm);
 
 	free(guest_data_prototype);
@@ -263,6 +301,7 @@ static void help(char *name)
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
+	printf(" -k: Use KVM Userfault\n");
 	puts("");
 	exit(0);
 }
@@ -281,7 +320,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ahom:u:d:b:s:v:c:r:")) != -1) {
+	while ((opt = getopt(argc, argv, "ahokm:u:d:b:s:v:c:r:")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -324,6 +363,9 @@ int main(int argc, char *argv[])
 				    "Invalid number of readers per uffd %d: must be >=1",
 				    p.readers_per_uffd);
 			break;
+		case 'k':
+			p.kvm_userfault = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.45.2.993.g49e7a77208-goog


