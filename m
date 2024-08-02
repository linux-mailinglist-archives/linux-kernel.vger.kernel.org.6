Return-Path: <linux-kernel+bounces-273021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA6946373
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C53283972
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA846175D49;
	Fri,  2 Aug 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gc/YGKGV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF32166F3E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624929; cv=none; b=dVxD1GkFWA1qacR3xknL7NrQWOzJnLfl4LJOjCebDxIiltSyNGadcajsAsfyqgMb0uOjvxWjftPGs6CBGbggF0L/G37YEjVB3X9RL5Z6g7rZxDZgCC0zuwVXwGYKBgllatwsnC8+5g0z/Cg4ZCE0Is66u94L/oaIUn/mLaBWqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624929; c=relaxed/simple;
	bh=G/B6WUt3Y43Ka6gRSs9wrMo/WyNhvm5mHZGpnxZk2As=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFLvKQ8Ow1sXda+C7g2KxvvfcsAT8MGe/e8/DbnLcQpcNp3elno/jsGNxbacifZ/LeAaLsul3L2YoDCKPaA3diOi7/7nWKmWRyGbJu5oZJX7WYVIHNwPgLxZT9/6UoF5x5JoKsYxJK9SrjE/dkx4FhJXCBcRRSk3Q09UdGb/1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gc/YGKGV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so6137288a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624927; x=1723229727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HOLp5fYsCIx/0E8sk/NBfI4RDAGs98gxBhfbvXYogHI=;
        b=gc/YGKGV6n7c5Fcjucw55JZVBUqE9JweyYPwZ6WeQnjnMgM6RJ/L4AqF4cRaDiJr8S
         vvXY/dfk3SLCspJae4MQLVuZi6bgwdO4wG3nVastrAIXgkc1V8wQCh01AK2/W75MYk+o
         Iy4pfG7EDnmeVerresdv4FrFGhYfK/1eVNA0y9WJxuIVD+YiEk2XqY5mHjH3L86Fe7tN
         A4rICrJ340CWsJ3VdF9nscFEZfTgQ3muCZFzb3imEOAijorBWpDwMS5KzgcEyvC3MV7K
         uVdidnvP9ugmqY61zPgxOz8U8IRvKVN1rhUAIl2dJEfsuVHdy7uPEIk7RUULY/IZLqgq
         QCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624927; x=1723229727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOLp5fYsCIx/0E8sk/NBfI4RDAGs98gxBhfbvXYogHI=;
        b=F8iatIqrp3MtBzyKQoEqbH/pxXDmrIAOP/igN2Mw2XXFZX888zUHreKUOLW8+zf1h2
         +OfJ9rcBK37j2G3QXpAIS9ZFKLKF/u+zFDtdECECAJRTNNznjOevcyVpVlsInLR3IN0U
         GObX7T6v+aMkDEGDUyBf06euk6k/oVvKoi45EjObsEvPY6Suv3s/45oL/hYyigE0VJ74
         UIYdo7lyRyMjVrG+rmum7BhgOaqCJT2wonQloNTRHjEkrkoCHfH6cA7enNoe3PHOhmYH
         VUOQMpjyBJEeFeT4Vavi/NCSw04qeHUhffLCMmzvNJCQj8p9SyHL0dyI9TziKTNpDiID
         C/gw==
X-Forwarded-Encrypted: i=1; AJvYcCWOQrvDi/SVJfP7yGcmRwTQGrWaZ6v7PIRPD78fX5ALULX6C69Ez4wsakbo/rM9go84hgilUSzpG7S2oA+8t40rl/UyRKTStZytBO1r
X-Gm-Message-State: AOJu0Yzb8p8CYdyBOO2RYtDgbw3dRC5Z1UJLjWcuRBX1M9ZdIBxLysfS
	V2Z92wpfEumKfCpvPPYiuuE3/GI9U1ZzzdwJNXsHHPQVZW7H/A58rMTDQdjUrpC3xzupeHivQBG
	0+Q==
X-Google-Smtp-Source: AGHT+IE019EkY48Pq6FtmDruiJuBqNgMOwrM//OALnsTngQLGRuIf226VPF4zumYJFi8ByQW2CBB5ZWNB4Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4643:0:b0:75a:6218:3d10 with SMTP id
 41be03b00d2f7-7b747451bdfmr8868a12.5.1722624927159; Fri, 02 Aug 2024 11:55:27
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:08 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-7-seanjc@google.com>
Subject: [PATCH 6/9] KVM: x86: Reject userspace attempts to access
 ARCH_CAPABILITIES w/o support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reject userspace accesses to ARCH_CAPABILITIES if the MSR isn't supposed
to exist, according to guest CPUID.  However, "reject" accesses with
KVM_MSR_RET_UNSUPPORTED, so that reads get '0' and writes of '0' are
ignored if KVM advertised support ARCH_CAPABILITIES.

KVM's ABI is that userspace must set guest CPUID prior to setting MSRs,
and that setting MSRs that aren't supposed exist is disallowed (modulo the
'0' exemption).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dbb5e06ef264..8bce40c649b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3798,8 +3798,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vcpu->arch.microcode_version = data;
 		break;
 	case MSR_IA32_ARCH_CAPABILITIES:
-		if (!msr_info->host_initiated)
-			return 1;
+		if (!msr_info->host_initiated ||
+		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return KVM_MSR_RET_UNSUPPORTED;
 		vcpu->arch.arch_capabilities = data;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
@@ -4259,9 +4260,8 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = vcpu->arch.microcode_version;
 		break;
 	case MSR_IA32_ARCH_CAPABILITIES:
-		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
-			return 1;
+		if (!guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return KVM_MSR_RET_UNSUPPORTED;
 		msr_info->data = vcpu->arch.arch_capabilities;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
-- 
2.46.0.rc2.264.g509ed76dc8-goog


