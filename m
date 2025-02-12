Return-Path: <linux-kernel+bounces-510239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D3A31A28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF6B188A8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F23727181B;
	Wed, 12 Feb 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5aFYlFc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668E5680
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318897; cv=none; b=E9d1AOBGYGEbnDcPm/PQ/s/32Kd8FFv/9NklwZy8I054SORDokWe0MPGcV4rJUA+GQIccI1tHlkDQKVoSKneZ89RZ1WlG/+hUq4P9eRq4T+qNCQvW3fo4MQpku71gfd+4Kx8xlRlSO4XGYj975ek7/u/aMqy5DlZ53tWcKYzW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318897; c=relaxed/simple;
	bh=ehLYTG6Xoh6RePEuOdsJO1YiF66iXfldRHD0ATxH28M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=upld0w9x9orLk5oAMZzC7s3jUwSgcbgVfcW1XT2SIWe3XKWYE5V9NKLZPUjVrP+MoVRsVmI+Ascwv/QHgErQhjwZitgC8ODJsxnpGbJg3xpgp/NuZBH28fvdwbsIMTnPkKkx7I0SQ9DL8ZoxxKaxg4Mpq6rcZXa5wuXiWMiBxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5aFYlFc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6b2d49e3so91680585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739318895; x=1739923695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aflUMaVdfiypUqtPtl++K+1MuoyNGKota/M1UlzbiMc=;
        b=d5aFYlFcPz68rfIoI3Nm0O3H2FUUA8m++SrnBOhazh85Qe//glBuoSQ6VnjdLvZkQU
         M+KNMbhmIzG26UFs/RQbIZBPfo+Mz8N0xSx6UAgMS/U+oFYUEetGlTJ/K2TNO4NucEy4
         qYPDKrVIh/ryDIZ1Dz6Zus7agIycoLtjD0VGzQes991YuW1ZXpp+v61e+cCKnwZBKqUw
         ZfZEOz+on9x0gf/bDoueuUQQ6R3J3jrAgiSwSKnFKLzGMjCRYmdS2tDchrtvcKQIbHwT
         OAgPcFuxjmrIaGN2r5eiwwbI7foiB48AedsKpjIYSOgwuqcT+9UKS8FQdU9YFGRvAkKV
         RYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318895; x=1739923695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aflUMaVdfiypUqtPtl++K+1MuoyNGKota/M1UlzbiMc=;
        b=D25+CtMTYFeNWXHfk5Zt9HeSdXZOXbp6vCvx43Ha/c5ALFFz8Aqyk/IumzHBgmOBcI
         LkxqtmsN7thz7DIB3Ec16l7nX5z7wwKVOOL2xLNef6Nc2sqn6D1FXuKuCCAq31hRBZL2
         TXv1G+ljwIJ88TfwzGyqXWeqEzRJ5FFPMuCdyC3LVap9mKU/IAKnBxNd11PnCnelAxFu
         J9D+gzHWuB/HxM69I0mZF4TA8oo6dqH/vwAfOJzKHUPdHNqaKE7yp4ZaMeBuxIiWKRi0
         MRrkxPC6kW1zWvU3ZJZmKR1yMhB5AmBG8W3X8tGdsIwOIqWuz1bMbupqQWccU6sGtF5C
         5G3A==
X-Forwarded-Encrypted: i=1; AJvYcCXTGPArhPx7LHMVzSgfbx5eR0FHkPoUYNwKIKZu8j+Z+3GvYV5GSv9iLtopTiIUiYbsJ70L5g7VcxyNIJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0//vlYrT6m1tlVy5I2zH3yp2K9rI1J5NLcX13kFDbqHWDbUBS
	R+lTE+yp1tl576jVS3DcUQLYzuZGVzIO8nlnIDk2qWWc0fd3R7qiVNVv1xF1Kvh4PwLr416VZpA
	eQT/SFKTS0c/4Wy2ptQ==
X-Google-Smtp-Source: AGHT+IHPxfAdpM1iOOY8z1AmixqeOmuG/IEf4j5AgcwJnfrRV4HF54kPCepPnvhuZO3QjCmSQoEz/uA6jsv32fdY
X-Received: from pgtq26.prod.google.com ([2002:a65:685a:0:b0:ad5:444f:7093])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2450:b0:1e1:bdae:e04d with SMTP id adf61e73a8af0-1ee5c85db6bmr2527873637.36.1739318895379;
 Tue, 11 Feb 2025 16:08:15 -0800 (PST)
Date: Wed, 12 Feb 2025 00:07:44 +0000
In-Reply-To: <20250212000747.3403836-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212000747.3403836-2-vannapurve@google.com>
Subject: [PATCH V4 1/4] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
other VM guest types, features supported under CONFIG_PARAVIRT
are self sufficient. CONFIG_PARAVIRT mainly provides support for
TLB flush operations and time related operations.

For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
most of its requirement except the need of HLT and SAFE_HLT
paravirt calls, which is currently defined under
CONFIG_PARAVIRT_XXL.

Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
like platforms, move HLT and SAFE_HLT paravirt calls under
CONFIG_PARAVIRT.

Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
break any functionality for current users of CONFIG_PARAVIRT.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 4 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cf7fc2b8e3ce..1c2db11a2c3c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static __always_inline void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static __always_inline void halt(void)
+{
+	native_halt();
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -97,24 +119,6 @@ static __always_inline void arch_local_irq_enable(void)
 	native_irq_enable();
 }
 
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static __always_inline void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static __always_inline void halt(void)
-{
-	native_halt();
-}
-
 /*
  * For spinlocks, etc:
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..29e7331a0c98 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -107,6 +107,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
 	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
+static __always_inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -170,16 +180,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static __always_inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..abccfccc2e3f 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -120,10 +120,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..c5bb980b8a67 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -110,6 +110,11 @@ int paravirt_disable_iospace(void)
 	return request_resource(&ioport_resource, &reserve_ioports);
 }
 
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
@@ -125,11 +130,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
-
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -186,9 +186,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
-- 
2.48.1.502.g6dc24dfdaf-goog


