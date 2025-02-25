Return-Path: <linux-kernel+bounces-530379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3162A432AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63D6165BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559D78F45;
	Tue, 25 Feb 2025 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fS6tAMeJ"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F78172A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448415; cv=none; b=BYjYZrDc/0VUOD6dnhJxGQkC5vxB6Qmx+vwr+a5rQratt+9E5scnk+kiuEhnCPksNsJ5IE8SxF7NXKBZt3nt9WVSV9HEXj4ucEB4jt735LueQtQ0pjKbzzMo7KhvkofW9jod0PvKBZrf0t1ypq0HsowSz9mOjc63zGszOwfK5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448415; c=relaxed/simple;
	bh=jtDmuo3JMeqvUeKpLmarSq/9wWlf5/kdtMpl5UqbU9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srxHfBOsOq2KjL9S+Vi1ua5Uk2dMsM/NDECGEj8dPJgFcDcwpniKod//XIOVOD1asZgEGEQu8NAk9by8PbhIY9AvxJ66TWNm33R8lEd/AHWihad6BnDlRBd9NgYGnUeWfuam4/SannqI9WMsEpYTnicd982v/g8L32AJtscu81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fS6tAMeJ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abba896add9so394043266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740448412; x=1741053212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrlFCJQM+s/SC4GA9X2sl0022JOgPYCcRoZjBzdMN/w=;
        b=fS6tAMeJYLI8vej3qJnAPOOzpYpcPHxORjBErrAQUHCwJhdbCEPkla438b2WY+EMVi
         aksTwe1upzlrOCTngG/DE+2jzH+61OQLj2ALVAgNu0LzAWjPhcariEJ9bI7hpjrSV0MC
         n4av7AuPGF3ggNLjLLrhaaFaBHGW3gMLeVtuxflqpTuu3J934TJct4chp8b7kWlXzFsv
         oHZnihRX7PWTd/hwTu1S9H+g55qHNTHHutR56m5w0Uu7asK4FuVot22Mh6eGyE9dp/+I
         Ildwiwc+cntRufvOPAb+WUChOCptT3HvieNARAhprWOabyItrJ166kqsiHfSDQb4YtC+
         C3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448412; x=1741053212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrlFCJQM+s/SC4GA9X2sl0022JOgPYCcRoZjBzdMN/w=;
        b=Nb1fAWwKQPV7rFPeD/aNc1heB0EFOF0JYcN81QZptXSY01OIFtJOBh0UegNeQULrhr
         N+/f5AtX7nCm+rHYNvqQxbS4lRTwUEwxiALlxYMpgCOqWOjRHOTjt20nA8XcGqc2sgh1
         qS61WAiMDXS/dm2CblorO0313Vj1EiCpskZ8KzTmjPvA4ISHc1kghdaQP3RJKvlH6fLi
         bJKRhiHTA/XeSomQGiTyfMg9Oa+pvGP/lPTMJMXztDHbz2gOHmxU43PC//ObwAOZ6egr
         P+eNCcy15D1JJezog5G3+NCZPdiASruP+T0FOXs8zzhxjncUNes0GBvvpLj5LA0Amfd0
         OPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7UV/7a2LpH2JuHwRoUYUuyzMGCTY4qvGrjsOQ+AYiDlSrFJP3IVZjpZEzZEa3X304rlRMqavqcoJZ3u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydH5bdttm8rpg0FuFdX3iAwQiSSJYQqMXb0MLngWw9/4vbWXnA
	vMbGIVc8uhF6FowIM3QIlMvUHYm3OOHNig7+hAWXICSRW74scI0lu1WixNhsuNQYOY+djqfnRi6
	lwSZx4g==
X-Google-Smtp-Source: AGHT+IFg0MEAMnG3Wrp4miJYl1OKfv7vBcy37QYN3xqF0m8kAhUHahTRAESm+yjq5eaH5DT3if2TwSacRsJb
X-Received: from ejcvw12.prod.google.com ([2002:a17:907:a70c:b0:abc:7db:4a27])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:6a15:b0:abe:c849:7aa7
 with SMTP id a640c23a62f3a-abec84989c0mr309298366b.41.1740448411867; Mon, 24
 Feb 2025 17:53:31 -0800 (PST)
Date: Tue, 25 Feb 2025 01:53:24 +0000
In-Reply-To: <20250225015327.3708420-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225015327.3708420-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225015327.3708420-2-qperret@google.com>
Subject: [PATCH v2 1/4] KVM: arm64: Add .hyp.data section
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

From: David Brazdil <dbrazdil@google.com>

The hypervisor has not needed its own .data section because all globals
were either .rodata or .bss. To avoid having to initialize future
data-structures at run-time, let's introduce add a .data section to the
hypervisor.

Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/image-vars.h    |  2 ++
 arch/arm64/kernel/vmlinux.lds.S   | 18 +++++++++++++++---
 arch/arm64/kvm/arm.c              |  7 +++++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  2 ++
 arch/arm64/kvm/hyp/nvhe/setup.c   |  4 ++++
 arch/arm64/kvm/pkvm.c             |  1 +
 7 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 40971ac1303f..51b0d594239e 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,6 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
+extern char __hyp_data_start[], __hyp_data_end[];
 extern char __hyp_rodata_start[], __hyp_rodata_end[];
 extern char __hyp_reloc_begin[], __hyp_reloc_end[];
 extern char __hyp_bss_start[], __hyp_bss_end[];
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index ef3a69cc398e..7c675e61ae58 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -135,6 +135,8 @@ KVM_NVHE_ALIAS(__hyp_text_start);
 KVM_NVHE_ALIAS(__hyp_text_end);
 KVM_NVHE_ALIAS(__hyp_bss_start);
 KVM_NVHE_ALIAS(__hyp_bss_end);
+KVM_NVHE_ALIAS(__hyp_data_start);
+KVM_NVHE_ALIAS(__hyp_data_end);
 KVM_NVHE_ALIAS(__hyp_rodata_start);
 KVM_NVHE_ALIAS(__hyp_rodata_end);
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e73326bd3ff7..7c770053f072 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -13,7 +13,7 @@
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
-#define HYPERVISOR_DATA_SECTIONS				\
+#define HYPERVISOR_RODATA_SECTIONS				\
 	HYP_SECTION_NAME(.rodata) : {				\
 		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_start = .;				\
@@ -23,6 +23,15 @@
 		__hyp_rodata_end = .;				\
 	}
 
+#define HYPERVISOR_DATA_SECTION					\
+	HYP_SECTION_NAME(.data) : {				\
+		. = ALIGN(PAGE_SIZE);				\
+		__hyp_data_start = .;				\
+		*(HYP_SECTION_NAME(.data))			\
+		. = ALIGN(PAGE_SIZE);				\
+		__hyp_data_end = .;				\
+	}
+
 #define HYPERVISOR_PERCPU_SECTION				\
 	. = ALIGN(PAGE_SIZE);					\
 	HYP_SECTION_NAME(.data..percpu) : {			\
@@ -51,7 +60,8 @@
 #define SBSS_ALIGN			PAGE_SIZE
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
-#define HYPERVISOR_DATA_SECTIONS
+#define HYPERVISOR_RODATA_SECTIONS
+#define HYPERVISOR_DATA_SECTION
 #define HYPERVISOR_PERCPU_SECTION
 #define HYPERVISOR_RELOC_SECTION
 #define SBSS_ALIGN			0
@@ -190,7 +200,7 @@ SECTIONS
 	/* everything from this point to __init_begin will be marked RO NX */
 	RO_DATA(PAGE_SIZE)
 
-	HYPERVISOR_DATA_SECTIONS
+	HYPERVISOR_RODATA_SECTIONS
 
 	.got : { *(.got) }
 	/*
@@ -295,6 +305,8 @@ SECTIONS
 	_sdata = .;
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 
+	HYPERVISOR_DATA_SECTION
+
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
 	 * cache lines to be invalidated, discarding up to a Cache Writeback
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b8e55a441282..94d23b901b66 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2568,6 +2568,13 @@ static int __init init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_start),
+				  kvm_ksym_ref(__hyp_data_end), PAGE_HYP);
+	if (err) {
+		kvm_err("Cannot map .hyp.data section\n");
+		goto out_err;
+	}
+
 	err = create_hyp_mappings(kvm_ksym_ref(__hyp_rodata_start),
 				  kvm_ksym_ref(__hyp_rodata_end), PAGE_HYP_RO);
 	if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index f4562f417d3f..d724f6d69302 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -25,5 +25,7 @@ SECTIONS {
 	BEGIN_HYP_SECTION(.data..percpu)
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	END_HYP_SECTION
+
 	HYP_SECTION(.bss)
+	HYP_SECTION(.data)
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index d62bcb5634a2..46d9bd04348f 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -119,6 +119,10 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
+	ret = pkvm_create_mappings(__hyp_data_start, __hyp_data_end, PAGE_HYP);
+	if (ret)
+		return ret;
+
 	ret = pkvm_create_mappings(__hyp_rodata_start, __hyp_rodata_end, PAGE_HYP_RO);
 	if (ret)
 		return ret;
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 930b677eb9b0..5a75f9554e57 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -259,6 +259,7 @@ static int __init finalize_pkvm(void)
 	 * at, which would end badly once inaccessible.
 	 */
 	kmemleak_free_part(__hyp_bss_start, __hyp_bss_end - __hyp_bss_start);
+	kmemleak_free_part(__hyp_data_start, __hyp_data_end - __hyp_data_start);
 	kmemleak_free_part(__hyp_rodata_start, __hyp_rodata_end - __hyp_rodata_start);
 	kmemleak_free_part_phys(hyp_mem_base, hyp_mem_size);
 
-- 
2.48.1.658.g4767266eb4-goog


