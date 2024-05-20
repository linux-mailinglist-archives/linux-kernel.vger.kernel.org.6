Return-Path: <linux-kernel+bounces-184035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0328CA1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E31C1C20BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B3139CFC;
	Mon, 20 May 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0z3VlvvD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46F139585
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227981; cv=none; b=U3zAtg0aykyVC54AepBM8+nvBtJckpOSfMCZdDczjXVrQvbVduNocCwF4SbDb0vA/Luqh3ucCv+g5tm/vRAJfrYBPVDiO1UDUoBZTnr7Tii4z2VGBWfWnplcw2bj4ecpIFjlb/sBbd8YOp8QJ2ay9XCZclDLtNdqbBqTKCFb4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227981; c=relaxed/simple;
	bh=nXHVpzniZOysYzfW/CV68jHMygH8DnBCyqgjKkOhtNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzKNiLrWsiAhXctthTT0K1McdTH/2D1mlvtyJ5sIUgMZfc0kcb8SeeM+uGkRJvcX/FL9OBjBfu8yv7DjSsLOISU5OJbX4Drj7xBAtgJcl3DExAurOGOUyA271e4zesE8n/uqQaGNzkLtnGgAdN3OPRACE9AdzHJQvCYOra+/Gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0z3VlvvD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b4348fb84bso9929048a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716227979; x=1716832779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VlfduVinRWM9m0GyTF5hGISStcVx0wfGxxyrYdGA6O0=;
        b=0z3VlvvD7WIs+nd39R88vMlTDYuzWtx3Jh2fDvO6BxcbwxelBgtK+CliHde7Z64+vP
         CZ9Epvi2bYuTxqWmuLEupmXjELSXTaVQKpUnNFgocuN3RHswHk3lnX/8iBA3Vv8Rlfyy
         3xm2jBDe5gmrKuBsaMnvIWxMtDvaRJdrUQBlMTtHIjD1Qg0fGvWTyagQBSdTe1b8qNVP
         EcC/0jZ7G9zaywvbIJhv84zoKQGH+zXgoezen9+DlMNqHiaa4ujYw2w9DHNAkMR1Rwvr
         0mlZ4HPJohuzdVXQK7secwLogaOfI2S/2lq7maJH6gSHbNqKin6rcpcFO3d0WdGaYS7t
         heig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227979; x=1716832779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlfduVinRWM9m0GyTF5hGISStcVx0wfGxxyrYdGA6O0=;
        b=qTJEGpg0qhcy4zXapnk3DpOxl0O9FcA76Q+7SVpuXqB0aIjTWj8CXHFhYJIxLTDuJM
         +qF7tm+nmdHE66PGBSeMgSCl56FH1/3F6573VpxVJQXKNO9Pi7kNeP3WYDvT9gvdD5ur
         Ai/NNNrbcTpoEGaTc05CjblvfC5sYsDc3y5ZOogIVTDmLO8yBZ/SLOCX6qahieMmOhcJ
         U7oPFY+bV/EvNkS3Q85b40tIs5wU2j6pOpYZwgEmrKMyQBjo3TGqlgYuX5tfZj/CxlNo
         1Em3gZBv00kJ6YdOmOzb6S6b5hq9Bh2RZAaNSUxWi7p15v893tjmFvvI0YwO742ZIxuK
         g5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVph2WojxLBt/kADtr7vG7DBuzVbP69rRCX0PmJepRvuphBM6XaLcn+SFRBE1UvxotfY8TU5oG9oLYuYKY1gOseDd9wXu8ScPd0JiDV
X-Gm-Message-State: AOJu0YzPoqbcEqGb3MVmGG8jUsrpl8i3Szt8Rh20zsmH/yhJh2RWY8Ft
	MQ4MOHFWdRWP50Z2WHm3xlfyXw1otyd8yYEZx179SyQNbI0P5APUchpimoTkZ7uVM4VroTrCYsm
	GQA==
X-Google-Smtp-Source: AGHT+IE2DqlU3D5hQsMzthWvSFDNrYVJ0U+lM4nqHPlKffjstwVS4slgG1nG5ISlW+rP4RrEbCyLl7Dgr9o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9408:b0:2b9:78b9:fefd with SMTP id
 98e67ed59e1d1-2b978b9ff83mr52559a91.7.1716227979228; Mon, 20 May 2024
 10:59:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 May 2024 10:59:19 -0700
In-Reply-To: <20240520175925.1217334-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520175925.1217334-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240520175925.1217334-5-seanjc@google.com>
Subject: [PATCH v7 04/10] KVM: VMX: Move MSR_IA32_VMX_BASIC bit defines to asm/vmx.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin3.li@intel.com>

Move the bit defines for MSR_IA32_VMX_BASIC from msr-index.h to vmx.h so
that they are colocated with other VMX MSR bit defines, and with the
helpers that extract specific information from an MSR_IA32_VMX_BASIC value.

Opportunistically use BIT_ULL() instead of open coding hex values.

Opportunistically rename VMX_BASIC_64 to VMX_BASIC_32BIT_PHYS_ADDR_ONLY,
as "VMX_BASIC_64" is widly misleading.  The flag enumerates that addresses
are limited to 32 bits, not that 64-bit addresses are allowed.

Cc: Shan Kang <shan.kang@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
[sean: split to separate patch, write changelog]
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h | 8 --------
 arch/x86/include/asm/vmx.h       | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b14434af00df..7e7cad59e552 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1168,14 +1168,6 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
-/* VMX_BASIC bits and bitmasks */
-#define VMX_BASIC_VMCS_SIZE_SHIFT	32
-#define VMX_BASIC_TRUE_CTLS		(1ULL << 55)
-#define VMX_BASIC_64		0x0001000000000000LLU
-#define VMX_BASIC_MEM_TYPE_SHIFT	50
-#define VMX_BASIC_MEM_TYPE_MASK	0x003c000000000000LLU
-#define VMX_BASIC_INOUT		0x0040000000000000LLU
-
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index e531d8d80a11..81b986e501a9 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -135,6 +135,13 @@
 #define VMX_VMFUNC_EPTP_SWITCHING               VMFUNC_CONTROL_BIT(EPTP_SWITCHING)
 #define VMFUNC_EPTP_ENTRIES  512
 
+#define VMX_BASIC_VMCS_SIZE_SHIFT		32
+#define VMX_BASIC_32BIT_PHYS_ADDR_ONLY		BIT_ULL(48)
+#define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
+#define VMX_BASIC_MEM_TYPE_SHIFT		50
+#define VMX_BASIC_INOUT				BIT_ULL(54)
+#define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
+
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
 {
 	return vmx_basic & GENMASK_ULL(30, 0);
-- 
2.45.0.215.g3402c0e53f-goog


