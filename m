Return-Path: <linux-kernel+bounces-559361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0747A5F2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716CA3AB2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D5267700;
	Thu, 13 Mar 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4DoA5v5"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E32676C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866057; cv=none; b=ul11WpZn9VIZZdwMCEHab0h6mDUf3eZIUvOyS0an20Ck5fGHsf/JXO3b+7wr4IUYVXw4/yIucbSLzW9dMJVgCwJSyw1Iua2AY2NYa7ow/fYOYeObnBFK6Vjn6Jugof3Qv/CjH+vsZTo3MktiRooHah+qhAxwgIFiDPmQmQd7lCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866057; c=relaxed/simple;
	bh=xQw7CCkIa/tItrTgXKvKC4t9RKukRRO3SkH3BuVk0FY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8HCuOsvzDp1wfDoR2GSLPximtuyyie1M3wRvyTKs4FUYyEbSHeumpFqWlH5nFBo3L1hE7FSQyYIT8GJc5+Yg37uOWPEXylWhj1qw82MGSt6Chp3HT9MGfpk7K5SS3Jxq1cFHyML3s/+aKJ5ssntJhDSsfH/z/tiLACHTgLK2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4DoA5v5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912b54611dso563709f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741866054; x=1742470854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp6lx89NDYaCWj8yztXIUiroS+BazPKE4hbafizh3a4=;
        b=d4DoA5v5McBNzUz6lH8JCM6/Tgn5VjnVK4jBQUH1EvKFOI7iOPiI5LiKm+KzSKUoMt
         AECPgQf2MVpy4/qf0H5nVWzKDc1DwcHyb2wjGQRAcdYjd5M/xcI0k7n8xFWf3ev9bcre
         ZVEnk1jJh+Sio+tGJiv7igJ0NUcVezZ7Mt3nwWnqoh6AfBeYwudOqHJpJQUCDZyOr+C7
         +nzlU4MwkzZgzSWZrHNHFjN7BQWDRhOKc+X/aoTz6ZQrraKqwrE2+3zckU/+N1s1S3m2
         WMsJPIlYjfJQLG0fOVmNV1SskK4fl2IjTSQN5PLtUkc17teZTH4R3kwmrfjCvADPJkou
         iMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866054; x=1742470854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp6lx89NDYaCWj8yztXIUiroS+BazPKE4hbafizh3a4=;
        b=Hzy/2pJjTS5jJjsVyI+OKeqpra7gxyLe1fYbcnPqyjIsHUcJsfzjRrbkBy4gBHLIbl
         N7uC9fU8KZm6PiZMvNbuleQ3Kf/+/rnPlVTjcggmTV/Q/1Z7X07EZy49k43sjb0zJAlU
         c29GYbGQSAxvOMva78KMa/qDekSn9/tKNbYUhRMAt9Sn8v+Oj9rJ4M5+bXRgptUOCqV6
         uOE2j1PePHtnNGzWNy42sBV8PY6jaLDQXSWH3aGplXDaoedUg0gElFIqz2ExHvJ4wwFT
         ZS3jDKd4qKbQgFsD6PDNEU5S+58LIhFvC8GQeUOrOuVi//ZZH4EkmecDWzxcWdof5m7E
         BB2g==
X-Forwarded-Encrypted: i=1; AJvYcCUuB9OSdBeqRPElmAMv9gTqWLXr3sd+M2/tuZ0xJRvOcZx7xj0XwVkvhArmooSxrnKxWF+gH3fLwSHVZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4JMUz1ne6/DfW0c0jaKbwELkeVMu5qMMRNK9Wk0Ti4JsX9uY
	Z7vQlJCAbFA/1cSpcmVdFA/n4OMohlDudpANRebcQoNiYMpahtPm6DeUjpgrodq+3V9ivGg+8NU
	BrXFIpb1l/EziuUj5DQ==
X-Google-Smtp-Source: AGHT+IFt9bxBQ+OiJ6M9T42VJJBXQ3dgE7XPDiGETKJiQhO61thf8YCecySsYum/tlZhh/1oFpOYkgivgvMyU5WF
X-Received: from wryv4.prod.google.com ([2002:a5d:59c4:0:b0:391:3be0:78cb])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a87:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39132dc4395mr17764441f8f.55.1741866054357;
 Thu, 13 Mar 2025 04:40:54 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:40:38 +0000
In-Reply-To: <20250313114038.1502357-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313114038.1502357-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250313114038.1502357-4-vdonnefort@google.com>
Subject: [PATCH v4 3/3] KVM: arm64: Count pKVM stage-2 usage in secondary
 pagetable stats
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Count the pages used by pKVM for the guest stage-2 in memory stats under
secondary pagetable, similarly to what the VHE mode does.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ace3969e8106..51754a354b7a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -86,6 +86,8 @@ struct kvm_hyp_memcache {
 	phys_addr_t head;
 	unsigned long nr_pages;
 	struct pkvm_mapping *mapping; /* only used from EL1 */
+
+#define	HYP_MEMCACHE_ACCOUNT_STAGE2	BIT(1)
 	unsigned long flags;
 };
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6107a3c8ccf6..2feb6c6b63af 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1088,12 +1088,24 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 
 static void hyp_mc_free_fn(void *addr, void *mc)
 {
+	struct kvm_hyp_memcache *memcache = mc;
+
+	if (memcache->flags & HYP_MEMCACHE_ACCOUNT_STAGE2)
+		kvm_account_pgtable_pages(addr, -1);
+
 	free_page((unsigned long)addr);
 }
 
 static void *hyp_mc_alloc_fn(void *mc)
 {
-	return (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+	struct kvm_hyp_memcache *memcache = mc;
+	void *addr;
+
+	addr = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+	if (addr && memcache->flags & HYP_MEMCACHE_ACCOUNT_STAGE2)
+		kvm_account_pgtable_pages(addr, 1);
+
+	return addr;
 }
 
 void free_hyp_memcache(struct kvm_hyp_memcache *mc)
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 19921ca407c6..4409a10d02b6 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -165,12 +165,16 @@ static int __pkvm_create_hyp_vm(struct kvm *host_kvm)
 	handle = ret;
 
 	host_kvm->arch.pkvm.handle = handle;
+	host_kvm->arch.pkvm.stage2_teardown_mc.flags |= HYP_MEMCACHE_ACCOUNT_STAGE2;
+	kvm_account_pgtable_pages(pgd, pgd_sz / PAGE_SIZE);
 
 	/* Donate memory for the vcpus at hyp and initialize it. */
 	hyp_vcpu_sz = PAGE_ALIGN(PKVM_HYP_VCPU_SIZE);
 	kvm_for_each_vcpu(idx, host_vcpu, host_kvm) {
 		void *hyp_vcpu;
 
+		host_vcpu->arch.pkvm_memcache.flags |= HYP_MEMCACHE_ACCOUNT_STAGE2;
+
 		/* Indexing of the vcpus to be sequential starting at 0. */
 		if (WARN_ON(host_vcpu->vcpu_idx != idx)) {
 			ret = -EINVAL;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


