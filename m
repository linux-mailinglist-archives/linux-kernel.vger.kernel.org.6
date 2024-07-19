Return-Path: <linux-kernel+bounces-257467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95593937A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95161C21BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A61494DD;
	Fri, 19 Jul 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bZZcsQrm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E521465A3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405402; cv=none; b=bCgvS4uicOikvHgKwBJwqnEFyE9fkPRKXVt3Gwp5hYG3jKe1SugsBNM6dnEWdx5cctpyHgtFY5GyOvu5tNBKqtVeedTjE9hPF8HOC87SQYU9Sl8vv6q188Jrromb01HEjZ6pvku3/S22hWQTWMvbA2tRwOeIFYIGFky+R6Ey2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405402; c=relaxed/simple;
	bh=Xhv3HXShlEgZM+chx6Tr7wuaHvM5bM4qQ3/9V0800ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFSAt8C0nXWWQjE7s8+vxiSGluM0VbT32K44cRgyALHzXc73pZY25exA5NogAaVuW8t5W7WxHmmzWCGowu4jrF0J/bYbDVFVjSbwZfL7aQgMpre8EAde7M1MPsjEck+0CGRw4eFQtA6xKwhXcC9ODZfuCZb6TMAIra55j8elOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bZZcsQrm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb53bfb6easo17088955ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721405400; x=1722010200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtNFL5zw6IBLLvkGdXCYkboBqItL+86jnTgFrfDdkSg=;
        b=bZZcsQrm7cLBVijskKHehxgChlpHIQNGAlMCBW78Kj3jAkmpwsakfy+chAvq5xPCPd
         1Hx92Ix19oNeQT3keUHfJV3CYT9TkeQDJ1Q8D6Co9KxvljdVdrENo+BhXpbChyVCKqYo
         7C6R6Fm2t0ig7LUHJQeO9pDRvKpO2lBjlM+xlNWnHzRS5tLffK6w4tFySrbJPHbE2urj
         fiKCO2UmvKsOZGoLTdFsxRX5pZaUA6qpmAAXcZpqR9vZJR5mUz8RhtjdPgjAmQ8LjlBL
         M9FJs0gVf11gFWXhllJ0hzlTKxC3eod2jtzZs+b0ezYzU7sTYsOHw0XE26rgFa7oJSiB
         1t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405400; x=1722010200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtNFL5zw6IBLLvkGdXCYkboBqItL+86jnTgFrfDdkSg=;
        b=ZSWiOV6k93hVE4Bl2AuhQuCLL3a4CTe0DstsRWo5kkM6v4qRnAnzd21Dh7vG2tMIyM
         nQcGmZMylJ2tKWm8WaT7+9QgUf3/ocq6TvBF+IacmZUFPhrIw2ycjeQwBs8KBNBUuDe0
         OU3PnAGsuRhG5z5A0y7ILbX8w/19xHvsud2wYAaf85h6x/ruk+xLYBI3QGP8naQ/eIeV
         5slKgv762m+OEtu/hL0j79920wfURckwxt5rbp9GjlKPeYYmbq00OM3K7Zl5qHDYi3y9
         lVw815yWiZ3SUEuhWybQmGkcrEfCUGC2I/j3sUjTmcbcCL9+AGQsOdg6d1jnIoXUyTG+
         lovQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRffIiSimxHQjqKS20tGcY0eBI4lLE4pCLLDtjK+uZyuWmwzXgwNSdD+sCC7qmLyDZ6nkGak6J+1rl/fA+1LkCOvbGPzZYbhuK2H4j
X-Gm-Message-State: AOJu0YyG7Y8kOXPEkDcdbqJMYT2VzJIIUsBcHdsh7lVVdTmUKuuqltfx
	anRPoOpiW2WxyXy/3gnCKdQtbFgQ4TWmCjX5H+4jFph7WHKZc5h1mQbIomIllvQ=
X-Google-Smtp-Source: AGHT+IE6FYkmm8DMa+wcmCi2mhwqT2Wr9Wnby8aQ4da6gYfYdk6hWAZmI/41ReZ874E3E8C4iOimbQ==
X-Received: by 2002:a17:902:fd48:b0:1fb:74b3:53d5 with SMTP id d9443c01a7336-1fd7457c7dcmr2679895ad.35.1721405399762;
        Fri, 19 Jul 2024 09:09:59 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([223.185.135.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f518sm6632615ad.69.2024.07.19.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:09:59 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 10/13] RISC-V: KVM: Use nacl_csr_xyz() for accessing AIA CSRs
Date: Fri, 19 Jul 2024 21:39:10 +0530
Message-Id: <20240719160913.342027-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-1-apatel@ventanamicro.com>
References: <20240719160913.342027-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running under some other hypervisor, prefer nacl_csr_xyz()
for accessing AIA CSRs in the run-loop. This makes CSR access
faster whenever SBI nested acceleration is available.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/aia.c | 97 ++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 8ffae0330c89..dcced4db7fe8 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -16,6 +16,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <asm/cpufeature.h>
+#include <asm/kvm_nacl.h>
 
 struct aia_hgei_control {
 	raw_spinlock_t lock;
@@ -88,7 +89,7 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
 	if (kvm_riscv_aia_available())
-		csr->vsieh = csr_read(CSR_VSIEH);
+		csr->vsieh = ncsr_read(CSR_VSIEH);
 }
 #endif
 
@@ -115,7 +116,7 @@ bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
 
 	hgei = aia_find_hgei(vcpu);
 	if (hgei > 0)
-		return !!(csr_read(CSR_HGEIP) & BIT(hgei));
+		return !!(ncsr_read(CSR_HGEIP) & BIT(hgei));
 
 	return false;
 }
@@ -128,45 +129,73 @@ void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu)
 		return;
 
 #ifdef CONFIG_32BIT
-	csr_write(CSR_HVIPH, vcpu->arch.aia_context.guest_csr.hviph);
+	ncsr_write(CSR_HVIPH, vcpu->arch.aia_context.guest_csr.hviph);
 #endif
-	csr_write(CSR_HVICTL, aia_hvictl_value(!!(csr->hvip & BIT(IRQ_VS_EXT))));
+	ncsr_write(CSR_HVICTL, aia_hvictl_value(!!(csr->hvip & BIT(IRQ_VS_EXT))));
 }
 
 void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+	void *nsh;
 
 	if (!kvm_riscv_aia_available())
 		return;
 
-	csr_write(CSR_VSISELECT, csr->vsiselect);
-	csr_write(CSR_HVIPRIO1, csr->hviprio1);
-	csr_write(CSR_HVIPRIO2, csr->hviprio2);
+	if (kvm_riscv_nacl_sync_csr_available()) {
+		nsh = nacl_shmem();
+		nacl_csr_write(nsh, CSR_VSISELECT, csr->vsiselect);
+		nacl_csr_write(nsh, CSR_HVIPRIO1, csr->hviprio1);
+		nacl_csr_write(nsh, CSR_HVIPRIO2, csr->hviprio2);
+#ifdef CONFIG_32BIT
+		nacl_csr_write(nsh, CSR_VSIEH, csr->vsieh);
+		nacl_csr_write(nsh, CSR_HVIPH, csr->hviph);
+		nacl_csr_write(nsh, CSR_HVIPRIO1H, csr->hviprio1h);
+		nacl_csr_write(nsh, CSR_HVIPRIO2H, csr->hviprio2h);
+#endif
+	} else {
+		csr_write(CSR_VSISELECT, csr->vsiselect);
+		csr_write(CSR_HVIPRIO1, csr->hviprio1);
+		csr_write(CSR_HVIPRIO2, csr->hviprio2);
 #ifdef CONFIG_32BIT
-	csr_write(CSR_VSIEH, csr->vsieh);
-	csr_write(CSR_HVIPH, csr->hviph);
-	csr_write(CSR_HVIPRIO1H, csr->hviprio1h);
-	csr_write(CSR_HVIPRIO2H, csr->hviprio2h);
+		csr_write(CSR_VSIEH, csr->vsieh);
+		csr_write(CSR_HVIPH, csr->hviph);
+		csr_write(CSR_HVIPRIO1H, csr->hviprio1h);
+		csr_write(CSR_HVIPRIO2H, csr->hviprio2h);
 #endif
+	}
 }
 
 void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+	void *nsh;
 
 	if (!kvm_riscv_aia_available())
 		return;
 
-	csr->vsiselect = csr_read(CSR_VSISELECT);
-	csr->hviprio1 = csr_read(CSR_HVIPRIO1);
-	csr->hviprio2 = csr_read(CSR_HVIPRIO2);
+	if (kvm_riscv_nacl_available()) {
+		nsh = nacl_shmem();
+		csr->vsiselect = nacl_csr_read(nsh, CSR_VSISELECT);
+		csr->hviprio1 = nacl_csr_read(nsh, CSR_HVIPRIO1);
+		csr->hviprio2 = nacl_csr_read(nsh, CSR_HVIPRIO2);
 #ifdef CONFIG_32BIT
-	csr->vsieh = csr_read(CSR_VSIEH);
-	csr->hviph = csr_read(CSR_HVIPH);
-	csr->hviprio1h = csr_read(CSR_HVIPRIO1H);
-	csr->hviprio2h = csr_read(CSR_HVIPRIO2H);
+		csr->vsieh = nacl_csr_read(nsh, CSR_VSIEH);
+		csr->hviph = nacl_csr_read(nsh, CSR_HVIPH);
+		csr->hviprio1h = nacl_csr_read(nsh, CSR_HVIPRIO1H);
+		csr->hviprio2h = nacl_csr_read(nsh, CSR_HVIPRIO2H);
 #endif
+	} else {
+		csr->vsiselect = csr_read(CSR_VSISELECT);
+		csr->hviprio1 = csr_read(CSR_HVIPRIO1);
+		csr->hviprio2 = csr_read(CSR_HVIPRIO2);
+#ifdef CONFIG_32BIT
+		csr->vsieh = csr_read(CSR_VSIEH);
+		csr->hviph = csr_read(CSR_HVIPH);
+		csr->hviprio1h = csr_read(CSR_HVIPRIO1H);
+		csr->hviprio2h = csr_read(CSR_HVIPRIO2H);
+#endif
+	}
 }
 
 int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
@@ -250,20 +279,20 @@ static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsigned int irq)
 
 	switch (bitpos / BITS_PER_LONG) {
 	case 0:
-		hviprio = csr_read(CSR_HVIPRIO1);
+		hviprio = ncsr_read(CSR_HVIPRIO1);
 		break;
 	case 1:
 #ifndef CONFIG_32BIT
-		hviprio = csr_read(CSR_HVIPRIO2);
+		hviprio = ncsr_read(CSR_HVIPRIO2);
 		break;
 #else
-		hviprio = csr_read(CSR_HVIPRIO1H);
+		hviprio = ncsr_read(CSR_HVIPRIO1H);
 		break;
 	case 2:
-		hviprio = csr_read(CSR_HVIPRIO2);
+		hviprio = ncsr_read(CSR_HVIPRIO2);
 		break;
 	case 3:
-		hviprio = csr_read(CSR_HVIPRIO2H);
+		hviprio = ncsr_read(CSR_HVIPRIO2H);
 		break;
 #endif
 	default:
@@ -283,20 +312,20 @@ static void aia_set_iprio8(struct kvm_vcpu *vcpu, unsigned int irq, u8 prio)
 
 	switch (bitpos / BITS_PER_LONG) {
 	case 0:
-		hviprio = csr_read(CSR_HVIPRIO1);
+		hviprio = ncsr_read(CSR_HVIPRIO1);
 		break;
 	case 1:
 #ifndef CONFIG_32BIT
-		hviprio = csr_read(CSR_HVIPRIO2);
+		hviprio = ncsr_read(CSR_HVIPRIO2);
 		break;
 #else
-		hviprio = csr_read(CSR_HVIPRIO1H);
+		hviprio = ncsr_read(CSR_HVIPRIO1H);
 		break;
 	case 2:
-		hviprio = csr_read(CSR_HVIPRIO2);
+		hviprio = ncsr_read(CSR_HVIPRIO2);
 		break;
 	case 3:
-		hviprio = csr_read(CSR_HVIPRIO2H);
+		hviprio = ncsr_read(CSR_HVIPRIO2H);
 		break;
 #endif
 	default:
@@ -308,20 +337,20 @@ static void aia_set_iprio8(struct kvm_vcpu *vcpu, unsigned int irq, u8 prio)
 
 	switch (bitpos / BITS_PER_LONG) {
 	case 0:
-		csr_write(CSR_HVIPRIO1, hviprio);
+		ncsr_write(CSR_HVIPRIO1, hviprio);
 		break;
 	case 1:
 #ifndef CONFIG_32BIT
-		csr_write(CSR_HVIPRIO2, hviprio);
+		ncsr_write(CSR_HVIPRIO2, hviprio);
 		break;
 #else
-		csr_write(CSR_HVIPRIO1H, hviprio);
+		ncsr_write(CSR_HVIPRIO1H, hviprio);
 		break;
 	case 2:
-		csr_write(CSR_HVIPRIO2, hviprio);
+		ncsr_write(CSR_HVIPRIO2, hviprio);
 		break;
 	case 3:
-		csr_write(CSR_HVIPRIO2H, hviprio);
+		ncsr_write(CSR_HVIPRIO2H, hviprio);
 		break;
 #endif
 	default:
@@ -377,7 +406,7 @@ int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
 		return KVM_INSN_ILLEGAL_TRAP;
 
 	/* First try to emulate in kernel space */
-	isel = csr_read(CSR_VSISELECT) & ISELECT_MASK;
+	isel = ncsr_read(CSR_VSISELECT) & ISELECT_MASK;
 	if (isel >= ISELECT_IPRIO0 && isel <= ISELECT_IPRIO15)
 		return aia_rmw_iprio(vcpu, isel, val, new_val, wr_mask);
 	else if (isel >= IMSIC_FIRST && isel <= IMSIC_LAST &&
-- 
2.34.1


