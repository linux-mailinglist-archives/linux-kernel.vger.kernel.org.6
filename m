Return-Path: <linux-kernel+bounces-182466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B458C8B91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D775281950
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EBB155393;
	Fri, 17 May 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUseT+B7"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4E1552FE
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967648; cv=none; b=YNC+HR5nD6ux6pxfFfqbGxTukwdwRp7FMNiMYnBjlsM3GPf5H0Jz1dIzeGyRR7CcvIyRUko9XCvJrbloVR9TNhi9HcDpVKNATH8Y/8hHb/sXsvFKo+lCx35aFNixfZQajf9z5iRs45TrgsmAxC/f0+6AuGzNzCNdbC6bHCnC8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967648; c=relaxed/simple;
	bh=6O5zygWVSQQH/nffvcjVp4lF6K9NInxF8jIHE/Q/ytY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pu4GJ5zmM83lfPyyvCdnKTSrtcaHP+8r9qjPx8ewN29mlh28CVE/Im5xC0VbDC3sxXHZ6qhWXJ3ZTXhtA7LcDoEoaSsqk8k65QnC4caP3oNg+oupJ/mKhje9Um1KDLtyrBKjjmOJ4LDjGHyxij2pfWUv21aaCF3VIM2b40gV8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUseT+B7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f44dcb8eb0so5528143b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967646; x=1716572446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nreJM2bt6oXkxkEymPqKgBXxGBAexzLG9b/YnglUi3Q=;
        b=dUseT+B7XR84r1jQ+wkrwg1K71NkU8A0tZnSZbHZp751Tg4fkttp6YsS3REdyMKTdm
         1tZahKe7yGDPt1hvwt/dypen7cr0IQxyIRBKMsOZ9s9qiaEPduQxxQAEuLto9NltiksK
         DD6vl8SqcaDnCd+exLliL3PF58rOfkS4y+buAu48ACgUXREQpb5wHuKZs3DPm9JmEPJO
         qZpeJbOv3fF88s4zDkaWXJtQYiJtaAyQ8dRoxePv6YIaSPF9K6O9RcFN0kI1nRUYi5GL
         s9C7EZHPO762fg3fea8LrBQ2BRauvnh80ZBlaPkZ3VMIPNTNGQ4CQz+o2syCboQtkpc6
         eCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967646; x=1716572446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nreJM2bt6oXkxkEymPqKgBXxGBAexzLG9b/YnglUi3Q=;
        b=bnKM+qJMwnv+5E0u+cOPx6UQeBH3rK12F9L8Thq/Xi7IbQj6RpSfVJboQcevXq9NxZ
         dvs5SM6grzCNyb+Le5H2M2OjLPAddHGSShGpE1lJ6W1zCrvHY7hlbAneCgTweRmrjR4J
         +ecHtPlvR76DTNEQr26dOmQrFB3BwBQ1PatmB9T1NI1E6AHHisLXVFLvVy42tVHRKNnP
         3NsLVQn3S9EWMTAbvm9jtQmDJtJJrkoc5VPWPwRrZrx9t6CEJ+mXPz03tVg7f8IXKaIK
         lMboaen8cIuRUnj5HoadK05TsxIwtqURoNh71cpI5seZD+B8HltTTTev/PLljygiCB+U
         z84g==
X-Forwarded-Encrypted: i=1; AJvYcCUuI5PqLOGkTIZbeMmCeHUmZYQValTlc5kPsmTCMaXW17foL4fh7nVQMFLgNZxoSI0n/NrtLNrYGlFUh7JBbhMxYtHAEwEnRYKu0IFv
X-Gm-Message-State: AOJu0YwgcKZq1QciyLI3Ct+qjuUD/gZW/mcbM8jNnhyfiha4PEnasaq2
	c54LeTlhAxbm0wzvSaCyRF4i1FLSuqdzl+eW1H6gDmys9Hs52G9WVKFi1cErkunht3Xr8Ug2F5s
	q0w==
X-Google-Smtp-Source: AGHT+IFmawUBVJdPJ3QUS6uqz/hHuFguNWZUdWd5BOUEdENLjgo0sMjJzs8oQCio1oZVBmI1L+qvdc98qs4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:17a4:b0:6ea:b073:bf40 with SMTP id
 d2e1a72fcca58-6f4e03374bemr1037250b3a.4.1715967645992; Fri, 17 May 2024
 10:40:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:10 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-34-seanjc@google.com>
Subject: [PATCH v2 33/49] KVM: x86: Advertise TSC_DEADLINE_TIMER in KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Advertise TSC_DEADLINE_TIMER via KVM_GET_SUPPORTED_CPUID when it's
supported in hardware, as the odds of a VMM emulating the local APIC in
userspace, not emulating the TSC deadline timer, _and_ reflecting
KVM_GET_SUPPORTED_CPUID back into KVM_SET_CPUID2 are extremely low.

KVM has _unconditionally_ advertised X2APIC via CPUID since commit
0d1de2d901f4 ("KVM: Always report x2apic as supported feature"), and it
is completely impossible for userspace to emulate X2APIC as KVM doesn't
support forwarding the MSR accesses to userspace.  I.e. KVM has relied on
userspace VMMs to not misreport local APIC capabilities for nearly 13
years.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst | 9 ++++++---
 arch/x86/kvm/cpuid.c           | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 884846282d06..cb744a646de6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1804,15 +1804,18 @@ emulate them efficiently. The fields in each entry are defined as follows:
          the values returned by the cpuid instruction for
          this function/index combination
 
-The TSC deadline timer feature (CPUID leaf 1, ecx[24]) is always returned
-as false, since the feature depends on KVM_CREATE_IRQCHIP for local APIC
-support.  Instead it is reported via::
+x2APIC (CPUID leaf 1, ecx[21) and TSC deadline timer (CPUID leaf 1, ecx[24])
+may be returned as true, but they depend on KVM_CREATE_IRQCHIP for in-kernel
+emulation of the local APIC.  TSC deadline timer support is also reported via::
 
   ioctl(KVM_CHECK_EXTENSION, KVM_CAP_TSC_DEADLINE_TIMER)
 
 if that returns true and you use KVM_CREATE_IRQCHIP, or if you emulate the
 feature in userspace, then you can enable the feature for KVM_SET_CPUID2.
 
+Enabling x2APIC in KVM_SET_CPUID2 requires KVM_CREATE_IRQCHIP as KVM doesn't
+support forwarding x2APIC MSR accesses to userspace, i.e. KVM does not support
+emulating x2APIC in userspace.
 
 4.47 KVM_PPC_GET_PVINFO
 -----------------------
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 699ce4261e9c..d1f427284ccc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -680,8 +680,8 @@ void kvm_set_cpu_caps(void)
 		F(FMA) | F(CX16) | 0 /* xTPR Update */ | F(PDCM) |
 		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
 		F(XMM4_2) | EMUL_F(X2APIC) | F(MOVBE) | F(POPCNT) |
-		0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
-		F(F16C) | F(RDRAND)
+		EMUL_F(TSC_DEADLINE_TIMER) | F(AES) | F(XSAVE) |
+		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND)
 	);
 
 	kvm_cpu_cap_init(CPUID_1_EDX,
-- 
2.45.0.215.g3402c0e53f-goog


