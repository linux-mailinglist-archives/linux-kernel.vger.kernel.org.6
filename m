Return-Path: <linux-kernel+bounces-428555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875589E108F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B428282715
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81F2C697;
	Tue,  3 Dec 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GW9eVGZT"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E01CABA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187629; cv=none; b=nP4knmin3It2KRo23rz7gGEkzZx8os0xQEecSEDsVdSx2EnX+umrjgB4IZ0IrG7JRcRNyvgWWC+SmdSx8Cv3nR0oEPoZrHSWlsyCS1HRJg4zOSpmSZ4eu95X5NK9Mn5HSdTPmmQdebN5oufTGfidIyn3hqljmtI4vhhD4Zx7lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187629; c=relaxed/simple;
	bh=ST360jAFSalxvsspokUYZryLYZwouzKdgllkKmYC1PE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jI0oodd/g2m1VqqWgDpGH2hcUEcXfgTLWrVdVebTB+I1q8QEhO+dDYAktduQ49WLAEy0jgEoGo19Oizs1EdDdhwLsQ0GN5ovhgbf+mxxSAdVhnzc41reOMUOLXCh25h/Y5LzLsW1AO19zaAWsObkQnEYg1jCx0vC7MExV67TbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GW9eVGZT; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-843eb4505e7so805278239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733187625; x=1733792425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+a3eBnHKvD8AQod1gMB/LKTW1oN3to08D39Docv/eQ=;
        b=GW9eVGZTeipjdM+eGq+l/HLsrsZZShlivMxOaVKVKh8ltJ1caFtTHRVHQVCx3rUk44
         aY8y33zvHfKEEzhg5n/N5dyyz3Nz8OcGL5vMXyJiqEQ64J3SD3w31piw/Cafj8Efze05
         Dtn82qaknKCWBc7hFQzkIKZXPqwBRPDYHogCCNS5rn+TB4bZYdP4KOMTHOUsPuJHW6KJ
         x77Tn8GlY4cyPi2v4uf0jRCKLM/FEp0VtDO8DnKZP73QYVwcEc1P1QlX1vItGt8O8DzC
         AzKCpTYngn4fkgz4+OrNGkNs5P9UpDJANpWeRRf054qpe0qtslj1AI2sUPbrZ54FRorJ
         0hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733187625; x=1733792425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+a3eBnHKvD8AQod1gMB/LKTW1oN3to08D39Docv/eQ=;
        b=VzEM9Nvg8g5Xhea5tzVCVCqtfCCKFA/vfx8oyHiXSuolDDbhR6TCY1g472jXSR0m5Q
         VtH7zpEa5QOUSFV0JDXva0r844F+PWnLz8/m0vcOXhMQVhdbguwEnYi/mja31tjeX9OV
         myHcmoSQIa/nB71M1KL4SYWgMxT+gh2f1wx75MtEPZYEs/ZLyZ0gn1QU5G/BLhGmXbuq
         frGmg6qE7ui0gKiLoXUVnYmRDhGSZjCTwAs5PsYDeZWCsevg4te9TtC1v6+EI2nvUy7x
         Z4alHaSkvOaEu9MTbc3w9lWiCow+D4IIwtyEAJn9yIJW3GSVk4B4oLVV225h3Hdxc5dJ
         R4Vw==
X-Gm-Message-State: AOJu0YzotkOiK2Md2emYYOCeDkmhet4scdPdCxOlhX/gpiPQG6+NfvKZ
	e2tM05XMzDSVBRVzKoSpK4OQa2hyjNU7Sr8q+3TYUW0CpA+ewnJ7QiRGAehwEyVyht0UOD6I9nV
	qKyYhYtEF0PBI/3jP7SiIKnD9DpQe261jVKars48umSOL8IRIhar55mtM3hc/tjGrN4n+PAX5ut
	Pu43xbW19VSrQ8NYby5EOyNJ12jais5Fog3TsszoA6Hb9/8WSOPucbhFRfLrQ5VF9gpKcjuvlOm
	uG6wQ==
X-Google-Smtp-Source: AGHT+IHlAWUl/6xhfzZLqge5+mtkzOWOXTSZQKntjfye63eE/1sMNIDsJdEGUh7DCOLnVMK90ja1kBMWTjMKXb6+Bxua
X-Received: from ioay19.prod.google.com ([2002:a6b:c413:0:b0:841:802b:8e24])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:2b85:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-8445b53e7d6mr104251439f.2.1733187625111;
 Mon, 02 Dec 2024 17:00:25 -0800 (PST)
Date: Tue,  3 Dec 2024 00:59:20 +0000
In-Reply-To: <20241203005921.1119116-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203005921.1119116-2-kevinloughlin@google.com>
Subject: [RFC PATCH 1/2] x86, lib, xenpv: Add WBNOINVD helper functions
From: Kevin Loughlin <kevinloughlin@google.com>
To: linux-kernel@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	pgonda@google.com, sidtelang@google.com, mizhang@google.com, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

In line with WBINVD usage, add WBONINVD helper functions, accounting
for kernels built with and without CONFIG_PARAVIRT_XXL.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/include/asm/paravirt.h       |  7 +++++++
 arch/x86/include/asm/paravirt_types.h |  1 +
 arch/x86/include/asm/smp.h            |  7 +++++++
 arch/x86/include/asm/special_insns.h  | 12 +++++++++++-
 arch/x86/kernel/paravirt.c            |  6 ++++++
 arch/x86/lib/cache-smp.c              | 12 ++++++++++++
 arch/x86/xen/enlighten_pv.c           |  1 +
 7 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d4eb9e1d61b8..c040af2d8eff 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -187,6 +187,13 @@ static __always_inline void wbinvd(void)
 	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
 }
 
+extern noinstr void pv_native_wbnoinvd(void);
+
+static __always_inline void wbnoinvd(void)
+{
+	PVOP_ALT_VCALL0(cpu.wbnoinvd, "wbnoinvd", ALT_NOT_XEN);
+}
+
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8d4fbe1be489..9a3f38ad1958 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -87,6 +87,7 @@ struct pv_cpu_ops {
 #endif
 
 	void (*wbinvd)(void);
+	void (*wbnoinvd)(void);
 
 	/* cpuid emulation, mostly so that caps bits can be disabled */
 	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..ecf93a243b83 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -112,6 +112,7 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
+int wbnoinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
 
@@ -160,6 +161,12 @@ static inline int wbinvd_on_all_cpus(void)
 	return 0;
 }
 
+static inline int wbnoinvd_on_all_cpus(void)
+{
+	wbnoinvd();
+	return 0;
+}
+
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d3aa1d..c2d16ddcd79b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -117,7 +117,12 @@ static inline void wrpkru(u32 pkru)
 
 static __always_inline void native_wbinvd(void)
 {
-	asm volatile("wbinvd": : :"memory");
+	asm volatile("wbinvd" : : : "memory");
+}
+
+static __always_inline void native_wbnoinvd(void)
+{
+	asm volatile("wbnoinvd" : : : "memory");
 }
 
 static inline unsigned long __read_cr4(void)
@@ -173,6 +178,11 @@ static __always_inline void wbinvd(void)
 	native_wbinvd();
 }
 
+static __always_inline void wbnoinvd(void)
+{
+	native_wbnoinvd();
+}
+
 #endif /* CONFIG_PARAVIRT_XXL */
 
 static __always_inline void clflush(volatile void *__p)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fec381533555..a66b708d8a1e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -121,6 +121,11 @@ noinstr void pv_native_wbinvd(void)
 	native_wbinvd();
 }
 
+noinstr void pv_native_wbnoinvd(void)
+{
+	native_wbnoinvd();
+}
+
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
@@ -149,6 +154,7 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
 	.cpu.wbinvd		= pv_native_wbinvd,
+	.cpu.wbnoinvd		= pv_native_wbnoinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
 	.cpu.read_msr_safe	= native_read_msr_safe,
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7af743bd3b13..7ac5cca53031 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -20,3 +20,15 @@ int wbinvd_on_all_cpus(void)
 	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
+
+static void __wbnoinvd(void *dummy)
+{
+	wbnoinvd();
+}
+
+int wbnoinvd_on_all_cpus(void)
+{
+	on_each_cpu(__wbnoinvd, NULL, 1);
+	return 0;
+}
+EXPORT_SYMBOL(wbnoinvd_on_all_cpus);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index d6818c6cafda..a5c76a6f8976 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1162,6 +1162,7 @@ static const typeof(pv_ops) xen_cpu_ops __initconst = {
 		.write_cr4 = xen_write_cr4,
 
 		.wbinvd = pv_native_wbinvd,
+		.wbnoinvd = pv_native_wbnoinvd,
 
 		.read_msr = xen_read_msr,
 		.write_msr = xen_write_msr,
-- 
2.47.0.338.g60cca15819-goog


