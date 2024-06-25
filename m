Return-Path: <linux-kernel+bounces-228537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64691616D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368D71F246F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFEB149012;
	Tue, 25 Jun 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WHyYKXIv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041241494BF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304454; cv=none; b=MN8MAxH/rNnL5ForlmwvuPTWCV7nVemOIDfEv9/xlm3DovtMlOYV4MjS53EumVajbuJsRu9FlOs4uXYMcv7o9itKthAKEaTGqSTcMinaKDAPISzh9yieIrn3oqlppNLGSK40h6IchcoRLoSc6Diwj3GkSlHO1ZNJHqwS+JHHMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304454; c=relaxed/simple;
	bh=L65BVw1IfGXIpPCpLltvH1Pr3HFst845zg0oA4nj5mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dRb4ULXj8hYd941u+UeMtBxktT9c8XRIvlBkh3EPa4usoHWFELHb1CpE7a35HKSNgoEs2UgbnqyroHo0rtn9lSuQPXPmff4+s7IcyIgsV5mfalAW6ORbfQI2XYw56O3aiyR+qD4BCGWg55X/yH9D4K4AxWbouF3G/kcuVcpe0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WHyYKXIv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9b364faddso42616845ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719304452; x=1719909252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaZTDIj+9Ci38w0UviyVOkLNbmq1P63k6Hrc4PEaBIQ=;
        b=WHyYKXIvYcAyMKoh7U9a8t32uMg+96ofqooWfSHIaU7Xt94z6vPpIa+gf0+lzNTLrU
         xzzw2viaMe6xOLta5XYilw7EYFS1Y/EHs/8ZjzCI6RFP31hxkWmNteHbnX25vHwAEcby
         /+PQHfNnwd8/vOEMY5jsVpFC2R3GC9dv5/Luw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304452; x=1719909252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaZTDIj+9Ci38w0UviyVOkLNbmq1P63k6Hrc4PEaBIQ=;
        b=ss2dntu4p1O/Vwi7CWNVTdBDcWYGu/8af01J2TjXw4u1VeCvF4+ZPSWNuJhpzcoGGL
         xWbLdd54ktF8jiSJxTWHqsF1Eu048xNthQ05E1PXeHDvS1m1UTzaTiN44AVQHaELc8L9
         MmBhhJISLJ5otMAN8vFmoZ0ojlueLloxmt0/uI3LkkcpSHPfC+KMmi436RV63OGxA+Vj
         HqMmd0K3vwq21Hxq0cyz4AAiT5qFbLlsswvPZC9BxolXHHCWN5xLNQI1Xk7rf8tEkpdu
         UFA2jS0ebLXSrvuTzeuLNRKYb9aVocPS/pWjm/HU/anKB1II6uGaZB67HIEYANESnT5S
         Z+/A==
X-Gm-Message-State: AOJu0Yzr1gzuTqzCMdbY1Bn2L4AsDEVw41De8VNRYS4Z1wWelYPW0uhK
	qQjWdusYnetK4KAmxmrI8rBMpVpTEGLxu8Z5Q0xvWiR+scJ7HrLLU354FEjPF4iiZPrTFWKmGGk
	qwGQvmsdaIRbchYjQPWgUsBWnZ85VgNrnZTktxIHEXOumVjTzBxdi0i9v6iRq0arXcj7F5FkxnX
	p6BfgF7Zl074Mcbz9vdE2ykdtJzqrWEYf5lPwGheiYhaW5GxadfnrU
X-Google-Smtp-Source: AGHT+IFvtgAjlj7uBPVh9T4VXCJSxzqqWolw/cxJnogKrJancnYPlW73KylsMYsJMzjjVEBypTPkHA==
X-Received: by 2002:a17:903:234f:b0:1fa:3428:53ba with SMTP id d9443c01a7336-1fa34285bb8mr71977385ad.64.1719304451837;
        Tue, 25 Jun 2024 01:34:11 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f027fsm75937105ad.6.2024.06.25.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:34:11 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	ajay.kaher@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Alex James <alex.james@broadcom.com>
Subject: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
Date: Tue, 25 Jun 2024 01:33:48 -0700
Message-Id: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caller of vmware_hypercall_slow() can pass NULL into *out1,
*out2,... *out5. It will lead to a NULL pointer dereference.

Check a pointer for NULL before assigning a value.

Fixes: 	666cbb562d05d ("x86/vmware: Introduce VMware hypercall API")
Co-developed-by: Alex James <alex.james@broadcom.com>
Signed-off-by: Alex James <alex.james@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 55903563afd3..16da970499f2 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -72,13 +72,13 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 				    u32 *out1, u32 *out2, u32 *out3,
 				    u32 *out4, u32 *out5)
 {
-	unsigned long out0;
+	unsigned long out0, rbx, rcx, rdx, rsi, rdi;
 
 	switch (vmware_hypercall_mode) {
 	case CPUID_VMWARE_FEATURES_ECX_VMCALL:
 		asm_inline volatile ("vmcall"
-				: "=a" (out0), "=b" (*out1), "=c" (*out2),
-				"=d" (*out3), "=S" (*out4), "=D" (*out5)
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
 				: "a" (VMWARE_HYPERVISOR_MAGIC),
 				"b" (in1),
 				"c" (cmd),
@@ -89,8 +89,8 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 		break;
 	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:
 		asm_inline volatile ("vmmcall"
-				: "=a" (out0), "=b" (*out1), "=c" (*out2),
-				"=d" (*out3), "=S" (*out4), "=D" (*out5)
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
 				: "a" (VMWARE_HYPERVISOR_MAGIC),
 				"b" (in1),
 				"c" (cmd),
@@ -101,8 +101,8 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 		break;
 	default:
 		asm_inline volatile ("movw %[port], %%dx; inl (%%dx), %%eax"
-				: "=a" (out0), "=b" (*out1), "=c" (*out2),
-				"=d" (*out3), "=S" (*out4), "=D" (*out5)
+				: "=a" (out0), "=b" (rbx), "=c" (rcx),
+				"=d" (rdx), "=S" (rsi), "=D" (rdi)
 				: [port] "i" (VMWARE_HYPERVISOR_PORT),
 				"a" (VMWARE_HYPERVISOR_MAGIC),
 				"b" (in1),
@@ -113,6 +113,18 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 				: "cc", "memory");
 		break;
 	}
+
+	if (out1)
+		*out1 = rbx;
+	if (out2)
+		*out2 = rcx;
+	if (out3)
+		*out3 = rdx;
+	if (out4)
+		*out4 = rsi;
+	if (out5)
+		*out5 = rdi;
+
 	return out0;
 }
 
-- 
2.39.4


