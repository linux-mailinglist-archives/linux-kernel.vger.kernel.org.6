Return-Path: <linux-kernel+bounces-424140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725C9DB0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA28281211
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E61ABEA5;
	Thu, 28 Nov 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="us+LS7wO"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976781A9B56
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757721; cv=none; b=Cm/KTI3cYxpriMzcuIIrNP6E8sO+89HzAfo/nnugrINMS5hqm8LNpXNKNgvG5Wujm1wFEm8V2QRcM1wtO0HVkdy6WRno+0Q+56MmLk0u589G3WzkPTWr+FJ4vGsMUN0UpqwRRYuExhrXQfGozn2hUGin+IQfQV1sBuflwrSf3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757721; c=relaxed/simple;
	bh=p3CBzhkm6ujU4s52ZTEXum8M/Hl6dyxVOGgM/SCeLYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B91yF9wWda66nfAa6aWfcNjdVQ68zzn7k7II2LrF2piWRvjRXfZUY61Mwuk75t3Qv0H5mH80X/0gtWDCZqz8krdeJZZSZcB0BD6dGLK/HLbhvN6vUdEzBMMcj3uM7WPEMcI4TYhaCQjMtZ0SmCNg7eha+mzB2r+e6oB1xqD0RMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=us+LS7wO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea5447561bso338141a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757719; x=1733362519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gZJBOmAP26+0yF/bEhrb3rRX/4R15M+YqMVdFmFdghQ=;
        b=us+LS7wOwWyTFD1Y0pQmV2cFsogvUO+pXs52ig6hkj2TxrGbDbRkLSiz4x+FwGfFUZ
         p8YD7vnr0zykd8tkovHP5QATnQeRDMiKLBCrNFzE/yV2R4+oGL2oYM7IFv2HGohZnEjJ
         B8b5FGBlkqdQ4tsP7901n3dTcNFm+OdUdw83ziYHnTP03A3PAnRoGBIOOWhoaLrmK+ah
         LV39KBO4yKfpVrhXGv+l2U0hJ8y8fc8CtU6jZqrxFyUm8KMWupq2K1OesGUuZpECkgvZ
         34b/x2bVOXglwYAI4bkdcP5FICf/J5/0DcIGBzPzFY4okLai1aMXPhUnn29gLTzdMSKf
         j4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757719; x=1733362519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZJBOmAP26+0yF/bEhrb3rRX/4R15M+YqMVdFmFdghQ=;
        b=jFCclBJGOSHu9Q9rd/kF5Rv6sHSWDz1+MHTw4czFeJnH2EAzDj3whkn9teKJRr1T+/
         BoeD1swuHMekoKlYCqeXq0yKaipOdSsXiVqDIkLBDwRlIfynvmyQpSdT0T8nQME8YDyB
         lvKEJe0vpQ6tUlgGDAVyVItZb09cKcgsbakAENbwlvwg5wULdfBLJZhKD3UD1gUmPuzV
         KzFOfIWFMu98E2FBo4DxsJimnO3zQxVxg9yugmcAH0t/KxR4e60oO8+7RUzoUcA3bKuE
         WWwf+QVk9VqegLZ0ZoDYsno2qm6nVqfput9+OJQEaLlfreRiwgdJDCfYLMePk5PI0AuX
         Sv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2bbdoFSOs8BTePtTlOLy6p7Pd2ETEKP0AiKvWlN7UqoESNPwmi7/CLomvihuofy213oSUTYnN1JAXkP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDJF15P6MXfc5fu4kK5YszaqJjor3ssOntymR/N6h6Cc1eSYU
	S9tjEy3ZAHcXJcTL0u7BFCL67QTAIol7eJNZIaAfM6fPieSCCe5mf4eaY8opFnK/uIkvmoQ4fBq
	SlQ==
X-Google-Smtp-Source: AGHT+IHoBRCOykd0M/JG0OnOX96GiVjTOBq+7QjcigybBzm1eoql7wNABr53Ji6d8itQZ8cWe3pKz5HSf/8=
X-Received: from pjbli10.prod.google.com ([2002:a17:90b:48ca:b0:2e1:8750:2b46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1bcb:b0:2ea:4e67:5638
 with SMTP id 98e67ed59e1d1-2ee097e3b21mr6975530a91.35.1732757719107; Wed, 27
 Nov 2024 17:35:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:54 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-28-seanjc@google.com>
Subject: [PATCH v3 27/57] KVM: x86: #undef SPEC_CTRL_SSBD in cpuid.c to avoid
 macro collisions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Undefine SPEC_CTRL_SSBD, which is #defined by msr-index.h to represent the
enable flag in MSR_IA32_SPEC_CTRL, to avoid issues with the macro being
unpacked into its raw value when passed to KVM's F() macro.  This will
allow using multiple layers of macros in F() and friends, e.g. to harden
against incorrect usage of F().

No functional change intended (cpuid.c doesn't consume SPEC_CTRL_SSBD).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 73e756d097e4..efff83da3df3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -644,6 +644,12 @@ static __always_inline void kvm_cpu_cap_init(u32 leaf, u32 mask)
 	feature_bit(name);							\
 })
 
+/*
+ * Undefine the MSR bit macro to avoid token concatenation issues when
+ * processing X86_FEATURE_SPEC_CTRL_SSBD.
+ */
+#undef SPEC_CTRL_SSBD
+
 void kvm_set_cpu_caps(void)
 {
 	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
-- 
2.47.0.338.g60cca15819-goog


