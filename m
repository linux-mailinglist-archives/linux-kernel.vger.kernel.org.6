Return-Path: <linux-kernel+bounces-182467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7D8C8B92
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F190C2807BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63CF156238;
	Fri, 17 May 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeP9VDvf"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837115538F
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967650; cv=none; b=JtocjnD7lSRZq2PgU8eS1XXU9erS1C8C83cEjQtE+DZ1H76gsK8KmhxLIYPSsJjczoK4ZiDHN8N5YTJOPTfXFAlDiHytf+5gTN8K5JqxLHSvODiBrdhpmTFcEZYcB2tv+58HBB1i72Dn+HU8m8E9jiN8LgW6ZkQBYcOVva4umak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967650; c=relaxed/simple;
	bh=MOt7a7eVZjErDMDDNmU9MZ31JPtIJ1yFe6IZvXt2XBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJ03mOcLxv76DotaITXW52e4blJt+cx8azsz0EOcHtmOt5JWisyAZ7ljQlVf2vHkuFnWbliiG0cZJkPI/Gz7xbBaKHkvF66PvcEeHn61FbLbHvDIYII0NZbkYc2bDaa4+mPULL3iLMyOZ08zNMr2bNicgibY+1Scf78qzPvA/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YeP9VDvf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61d21cf3d3bso164443907b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967648; x=1716572448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fU8sq/AkEJ2xM6e1kKBCrj+vGTO6zKbUVxTUOdmW3f0=;
        b=YeP9VDvfIq02/yUcAv0lztPJvC3x0XGxUL69wiwHw/LJ7ZCBHVfgWA9M66Md7WpfuJ
         EtcdQSv2vq9kdNsGMIigY0QvjoxGylkxtXwBuwS1fuz9Q8EXz4gv1G6eP8EHTJkshktt
         fTRcRFAqS9w0jCvUCS1wOlX2nMPMJJVFyYerGfAuU6MCRbmKLXrXwXPx0XT6VHM3XgVx
         0OrDropj1/PQWq83OYEBupDtu1m8uIotS9wTV3IOk9Ww7w+aukmumNFgW/Ck4aqbjWAK
         BI5j8JEgaUGuApM6SrixJ1Q6WdsoLWKUXq3OoMqrGJFfqKXMPXei58ZuiUFef3F5XW2k
         xvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967648; x=1716572448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU8sq/AkEJ2xM6e1kKBCrj+vGTO6zKbUVxTUOdmW3f0=;
        b=dUKzLamKop54fwEg+CP0vED+fi5I/J3b20gA0MoQVSwTsVJbpVWn+dHnVnkWp0Jem2
         cBDL18Viq+8vKFqvu8FHRopYwsjsuRD0w2hI0PpkPoEHJhCxmaBarYJ02oqTktK9pJEt
         HEOeTlkTuF8IufLu7tLrFV4d0eLc3SBnkd7ZBvH0eRHatHzTQwrjV6e7uOq7XGQCjuaj
         tyI3llQiTTStnUWUwkMo/HPrVwtshZn5Wshp/7hP3EsreDCh28Wjlajokv1FItcsO97R
         3uNNMeJ2aJME3GtP5FYpY+umpPNlmaxpcExcCEnANqIaj9OdhUiqKib0bSFuMf0QNJH3
         7LNg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5n/lr8zNBesgxtJ76bcyESkYdLtFaNSvu1LyTikI1fy3iVSoEQ6fYmqOrcN9MQ+3Q93ZihG/eLXdr8jJFjWBU5jxpmk3aMI++/jH
X-Gm-Message-State: AOJu0Yw4oLEuCyYXav4Z/ft0fG49tn6GBVheqeSliHb7iUTb5enCKTOR
	aAXmuUUTOrZpHIghX3ZEIsCxMG7YCeksYtmZ0qoGdJBg3NUa/Tg43dS5iYdFpUqxGzo+EWEUYmk
	TQA==
X-Google-Smtp-Source: AGHT+IGvBB4ynVI/ZC3TlbuQG8qS/BEUmawxsUd8thzmy3BsKmQ5z6aH5Ogto2uOeUGRdD1Ol0+z7FiImJQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3804:b0:61b:1d66:61c4 with SMTP id
 00721157ae682-622b016d66cmr45344297b3.10.1715967647859; Fri, 17 May 2024
 10:40:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:11 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-35-seanjc@google.com>
Subject: [PATCH v2 34/49] KVM: x86: Advertise HYPERVISOR in KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Unconditionally advertise "support" for the HYPERVISOR feature in CPUID,
as the flag simply communicates to the guest that's it's running under a
hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d1f427284ccc..de898d571faa 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -681,7 +681,8 @@ void kvm_set_cpu_caps(void)
 		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
 		F(XMM4_2) | EMUL_F(X2APIC) | F(MOVBE) | F(POPCNT) |
 		EMUL_F(TSC_DEADLINE_TIMER) | F(AES) | F(XSAVE) |
-		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND)
+		0 /* OSXSAVE */ | F(AVX) | F(F16C) | F(RDRAND) |
+		EMUL_F(HYPERVISOR)
 	);
 
 	kvm_cpu_cap_init(CPUID_1_EDX,
-- 
2.45.0.215.g3402c0e53f-goog


