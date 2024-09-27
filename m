Return-Path: <linux-kernel+bounces-341178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BE987C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E42850F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934314500E;
	Fri, 27 Sep 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NC7jcXPL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DE101F7
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727396204; cv=none; b=VKO0y7T4X3lu4mV63RwJf+NDHLHNeZJWxZhM2TrbJDTwNSdJ7Z+WTNOOz0ymPHBUc+HmqNPlDxP4TFFP8g8fD6qtZQ7scbsqsYLXo5h2hICiTjcsf98fpY5Z6CXe5y1xpEbXlXfkzWDtWbLXQ0zaIuH14YSOGf2/kd5Uj01UTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727396204; c=relaxed/simple;
	bh=qPB840LKVU6ZflRf4RW/o9F2/cJChriS9wj2fwnqz/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uljOuEMg5Y//lqvNqiDKRGIWJfTC8GOvBSpIO3/vaUMZQ/XcgQOrlIZohJPyJxKLgI6xRghBParhQycsTmVXeX7Z9sw7dFceSxdQ/as6I0LNqhdphmIb+dBfuOvPX8GofKnOzpIpe3pY4Fflp8HRBZJ3fU1CaCiggnyCV9/F9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NC7jcXPL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-206b912491eso25693935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727396202; x=1728001002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LnipXkdMp/tlON0pah63FvB2MDul+F9hL2RAHqV8Mqc=;
        b=NC7jcXPLf7b4SblfqLKX+beZUKFvbWkFWWfTAU/PKAoWG7eyRQG4slbU6YytIeuMeB
         ySP47Y+UAIN3hn/cSZLwHbEB5pnaDwj5jkviBRe3pSyUnhVwHCpQkGteINz9omPy+vY7
         31qlNy5r3nNJl0K3P1yyNUtGmZ7zvxqIvodLNLHD8Ycv74escpf5gk8lPsHxu7JR/mZP
         8Sdea/KIYJ4Zz4LtT2wbKLf8eDeCeVJ/bUooWhSqLYgs0bIBxCREcL1dcUFcraEeVDed
         5wERlESEX0OWMTdc7MdX75ByTQb0Oem8+BWPsrcHCY9EC9HDlYjTqnKrmUD2Bv7z9/mi
         qebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727396202; x=1728001002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnipXkdMp/tlON0pah63FvB2MDul+F9hL2RAHqV8Mqc=;
        b=ZxBnZcA0GTeN2BxO67e0pn1FzMFc+bW1ho+GSo5f3XCaRea+YJoxKApUPX0zjvlZlj
         FkDoNEiLX6IFO8Bd0937hl8MRT5BS1d/WEZ41KBheP7QI6C9qsdJceIjfW1XgqXYklGm
         K9pfCw7sxUWX8pSMywQZQZ4La6ZqrZQigA79BHg7nBUP9uRf7+kFK40WvCSx3Pu+kpJz
         eAZINSx0HDiEIpfwFnSObj0WWUoYfJE7CdzWx6NiQowEoeo0xgt0RQJJq/VTqk4fqtjM
         7y+BVn3E4+nqPGzsrr5YpWL8cauWzfLxqs2v0JH9jCfnQRC0DUTWhOnhSUfddlXH7HfE
         MwPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnJnc637jPJnQmMsdm60SUv01FVrwRMGX1RGd/mWnflZls61guXnMwcpPveQXY63wChRp23OftkhDcb5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94HWdKiTtaYiGSGiDZT1aZkRHw9yy26ntCRPPpA3pVdKW8iFx
	Cinf7P1UdqNyOC1lx1lE39qyPBdjv0CSxJiG77C6mrxLqB8gUJSPKra0nNrvgLC6C2v1dPJdVyB
	DaA==
X-Google-Smtp-Source: AGHT+IGBgI29zkiAKYn/9+spEvVm1fKGkUxDR5oSOVdglhJX+CIn7SSutJlwoDocu8LwMv7t2j2eZRuCCYQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:33cf:b0:205:3bc6:bf1 with SMTP id
 d9443c01a7336-20b19cad0f2mr59905ad.4.1727396201564; Thu, 26 Sep 2024 17:16:41
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 26 Sep 2024 17:16:33 -0700
In-Reply-To: <20240927001635.501418-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927001635.501418-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927001635.501418-3-seanjc@google.com>
Subject: [PATCH 2/4] Revert "KVM: selftests: Allow slot modification stress
 test with quirk disabled"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Revert memslot_modification_stress_test's KVM_X86_QUIRK_SLOT_ZAP_ALL
testcase, as the quirk is being removed, i.e. the KVM side of things is
being reverted.

This reverts commit 218f6415004a881d116e254eeb837358aced55ab.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/memslot_modification_stress_test.c    | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index e3343f0df9e1..49f162573126 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -79,7 +79,6 @@ struct test_params {
 	useconds_t delay;
 	uint64_t nr_iterations;
 	bool partition_vcpu_memory_access;
-	bool disable_slot_zap_quirk;
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
@@ -90,13 +89,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
 				 VM_MEM_SRC_ANONYMOUS,
 				 p->partition_vcpu_memory_access);
-#ifdef __x86_64__
-	if (p->disable_slot_zap_quirk)
-		vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-
-	pr_info("Memslot zap quirk %s\n", p->disable_slot_zap_quirk ?
-		"disabled" : "enabled");
-#endif
 
 	pr_info("Finished creating vCPUs\n");
 
@@ -115,12 +107,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 static void help(char *name)
 {
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-d delay_usec] [-q]\n"
+	printf("usage: %s [-h] [-m mode] [-d delay_usec]\n"
 	       "          [-b memory] [-v vcpus] [-o] [-i iterations]\n", name);
 	guest_modes_help();
 	printf(" -d: add a delay between each iteration of adding and\n"
 	       "     deleting a memslot in usec.\n");
-	printf(" -q: Disable memslot zap quirk.\n");
 	printf(" -b: specify the size of the memory region which should be\n"
 	       "     accessed by each vCPU. e.g. 10M or 3G.\n"
 	       "     Default: 1G\n");
@@ -146,7 +137,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:d:qb:v:oi:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:d:b:v:oi:")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -169,12 +160,6 @@ int main(int argc, char *argv[])
 		case 'i':
 			p.nr_iterations = atoi_positive("Number of iterations", optarg);
 			break;
-		case 'q':
-			p.disable_slot_zap_quirk = true;
-
-			TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
-				     KVM_X86_QUIRK_SLOT_ZAP_ALL);
-			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.46.1.824.gd892dcdcdd-goog


