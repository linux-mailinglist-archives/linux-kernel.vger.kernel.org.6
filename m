Return-Path: <linux-kernel+bounces-424159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682EE9DB123
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AD6164D68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90F1CC8AC;
	Thu, 28 Nov 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2o6rFoB"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4B1CC154
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757754; cv=none; b=fVZ7u5rAwS5B4qB44jiWeqiQbCHxIVPQCeWgrsxVsordvuBlrhiPT2SWMkiDdy6Py1cf2zndVK7mboqyZrdyueCXKZI0V42pWxHfujm21u6EoLRZrEAQWXFmeb2qBOpq34sXjDU/bK3oqr+OV6UnBL1f82Psr+GGrghSSKWq2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757754; c=relaxed/simple;
	bh=GusLaDboOc2Zwu/wHDpZ5mNIh6wjAzVVGs0J/ZdamGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nS21LkwbAorJrtOpuKmBIEjwbh6bdB352ihp6hHsZ/pCIYagXgBrwoyohJSo313+pQbV6cQMVBIKN8tdQgAWW3OoxS6V1ZKC/wCABRKzm1z6FyijsvoCnkaGmDUpWROuepl7kqpTE0aOtkB1CXSsq5Oj0GUm8b0V0fQ2ONwqu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2o6rFoB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea8baba60dso361458a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757752; x=1733362552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TObQrL7LGuqxhzdSaJ7V+btqB2g4TzQqJQbV2qpDafg=;
        b=P2o6rFoB2NaaBoyZ8UxbYfcE0Lh88bl7vxCnxYKLXZ+b6xPUlvve92aA5he+TznqTQ
         OfVIUNUtCme7xKHIeZzD4yNpOKOKhsUnI4Ei7o3aP4D9MuB+Z/2B9gnWuMS8uau9jwaV
         UhnROrTMyp6r1JKnyhMi5gRPChFK/JqHh9vY/jKsfdRIUIbgDKyrrzX8GyW114DyE6vI
         Z59kAe5J/OCr7QA9IrkkEIsiU/mf83d4MmxAkHAQzJCQI2fWJ0gCYjru5TbWjTZKlAlm
         nb5u5agf/AMxgPDpSIhUBG6Sz8J/JbCX/c0VC+FI69W4RbEEh6gR8g0cPimPRNCdsppm
         mmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757752; x=1733362552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TObQrL7LGuqxhzdSaJ7V+btqB2g4TzQqJQbV2qpDafg=;
        b=M1s6lEgf2bUZER1qcvMjKnrqh8fTy3PG0gI4NCfQ18pTgNUSBJbZliO1N7bNYh25be
         jnVhQnkUOd8kub1cp+Nw9EElld5F07Wd+d9FCev5HTgL3LT3bSXoCGOU++aYm4WM9Osy
         2QKAtepHXqkEVnXco51MN5iRnFoL7ELSAJFdcKRUZVMJOPd7KMqke0WjoEED7MMtvmUJ
         dUiT7AfD50xAlTHyDj+s3G3S9f9swl3tTgN/Se6LmDl59u5Q6w8H139JhN+Cg+SoMpSM
         WECldbleESmtRbTpLLvgwGTDt6gt6gXBvLr5Uv6yvPq4BNoizhubGOIiHeSQds0WwLZP
         DdlA==
X-Forwarded-Encrypted: i=1; AJvYcCX4lhezBFzFZ5VrLe3j6KCagwVn1EeToIaxXPLhMO3Kck/n8C+IaGNV6iAQZwyh89FXNzqPB9q105Z4Y2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iXiHK7Djkv9bg55WwK+DnFZomaOcekQtcpKLzD08McrV6KwV
	bNkwF0EGjq3rhWmAAusHgfsMairYaDWGzDENozTDDV4xkQ0L3BHL9hqxqJeVPPKmGX9/Ii00cD1
	0Aw==
X-Google-Smtp-Source: AGHT+IFxVo5QhhnwvJ9ut/LfVQKAmUeRoyod7xZep582o0DXmEnoC8hsdWrEXWsjkKMXBel57MvjaXCxv1Y=
X-Received: from pjbqj5.prod.google.com ([2002:a17:90b:28c5:b0:2ea:9f2f:2ad9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:1e0:d1dc:753d
 with SMTP id adf61e73a8af0-1e0e0b3fa1bmr8265692637.27.1732757752308; Wed, 27
 Nov 2024 17:35:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:13 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-47-seanjc@google.com>
Subject: [PATCH v3 46/57] KVM: x86: Drop unnecessary check that
 cpuid_entry2_find() returns right leaf
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

Drop an unnecessary check that kvm_find_cpuid_entry_index(), i.e.
cpuid_entry2_find(), returns the correct leaf when getting CPUID.0x7.0x0
to update X86_FEATURE_OSPKE.  cpuid_entry2_find() never returns an entry
for the wrong function.  And not that it matters, but cpuid_entry2_find()
will always return a precise match for CPUID.0x7.0x0 since the index is
significant.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 16cfa839e734..7481926a0291 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -291,7 +291,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
-	if (best && boot_cpu_has(X86_FEATURE_PKU) && best->function == 0x7)
+	if (best && boot_cpu_has(X86_FEATURE_PKU))
 		cpuid_entry_change(best, X86_FEATURE_OSPKE,
 				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
 
-- 
2.47.0.338.g60cca15819-goog


