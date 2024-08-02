Return-Path: <linux-kernel+bounces-273019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF78294636F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7422228382C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D01547D1;
	Fri,  2 Aug 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xjWyUzkZ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEA165F1F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624925; cv=none; b=fRkgDimyf0410L32TwS/I+mZnD6styInp+gl9QgPgodknlGNpJNRvjbEMpNKTfOF3++htftChrFcI/1ZWBob3Gvv2vCntZHRtYWAbh3TGpGyeqIWcgUgrjmU3WkhHp5QxgSFchkkcK4N/kcRGaEyovYXw/+oUZ3Xl8Ok/4IRS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624925; c=relaxed/simple;
	bh=kjmltdsCXgKPMkW3IMsblXwYB48Jaerc0S/NQl7JwnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HcYeFs6nNEbK+JL9NTEG7gSF0tB084BGHT5/73oMNW6TQYF2OC1puopJWwBGMmeD0wk7WQcQvs6meT2OMQf99fT4JdxbHjLGb6ZApPkOS86mEu3seQT3auLk6vSJcgjLptSz7XcuwcqFZru2VUwFIgkTZDpKHo16VPit7HvYhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xjWyUzkZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7106fcb5543so1100526b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624924; x=1723229724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=we0IZnPi8qUdBH21Q34g43aYFvRsaJnFKoOJjzQh/Cc=;
        b=xjWyUzkZNKxNtn+r2nW2p9Bsf/fIsdIwzcjl37OTGwZJcnW8v4FNXoaK7g4GJXFktK
         w81tDg29tOA0sS3NnLeqcL8HfJ23vTiwvZRdjyTYgM1/N6PkT7Eu/0wL49VvvozmJuIy
         igE25Y8h4D3eIcePUzjekGlUeHoH5SA1eB2sKyGKC88qOxkHSai0TzW+Lj+qxNNcQtIY
         Rw/iQQPaTPkTqdxvSTQ4oTv7acxrAOdT7QsOCKKhQWbHoLmIfT1gX65TnuAFYwsuE5wP
         P2fbEwvXuFPj1+cKpYaPuNzbt9eKxYkiSEvv1vjf95RgTutYcQhrg0UIsv+CourmxOpi
         R9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624924; x=1723229724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=we0IZnPi8qUdBH21Q34g43aYFvRsaJnFKoOJjzQh/Cc=;
        b=OFbU+vpmO6Y9DYJNWd6zGQNdc6To0IKnsMJ2Tw5kKOY/tKrB/PknTjnpQKABo3+iqS
         R128iOErIL1rdHKx1gPM2RKmjj9Akd9jDQYI/Qzn+ajHEBR5fyUGU3xnWSotW/ApOJer
         2aQDeJZG+QrV7LGmoOq3hfXFuZ6bqeRezkFEbYoF0Bzzgw4AYiWGrGXFaSj8YAdvaOlF
         OWind6ImAgwa3Jk09bXQOgdlmGz0UNrameMM+rEHprF1Ls6l2fVhpi+LdRLJGRIWHYuK
         GjnnXsoqzUdKTfMOnyF3U+apNMaQrs8yXse2NLKScGaHHgBLDeYWGMpnsbsZFRenusHO
         ez6A==
X-Forwarded-Encrypted: i=1; AJvYcCWw9rOlrVM9H+m9bGBP9/Q0MfljQPyn16UKntOrj1t/FuWKgnMd/Y1lihPTI4mv543//cHv3Eb+gvFDK1voxAPTm28IqxqFB/2PPC55
X-Gm-Message-State: AOJu0YxuMgO1FVq0WtFRBQD5SH9/ndtbGp9aAEtEZQrQUG9LcbDKYZDL
	8Pxq0nh91M/XXRfw6PRjGxJY/CeyOJwjn4CQtdrjpFAITcDfxRvt3Kp6jlANNucaz2mPrTPhvVL
	k2g==
X-Google-Smtp-Source: AGHT+IEiVUyg3cRTenUl1DMYkpNViP+8/KEgruSIT0O6BErR/eJJeNw48joChrB8Tb77n+YwJBdtgeqOjr8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f0e:b0:710:4d08:e41f with SMTP id
 d2e1a72fcca58-7106d08296emr34497b3a.4.1722624923625; Fri, 02 Aug 2024
 11:55:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:06 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: x86: Reject userspace attempts to access
 PERF_CAPABILITIES w/o PDCM
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reject userspace accesses to PERF_CAPABILITIES if PDCM isn't set in guest
CPUID, i.e. if the vCPU doesn't actually have PERF_CAPABILITIES.  But!  Do
so via KVM_MSR_RET_UNSUPPORTED, so that reads get '0' and writes of '0'
are ignored if KVM advertised support PERF_CAPABILITIES.

KVM's ABI is that userspace must set guest CPUID prior to setting MSRs,
and that setting MSRs that aren't supposed exist is disallowed (modulo the
'0' exemption).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b52d8f3304f..dbb5e06ef264 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3803,8 +3803,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.arch_capabilities = data;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
-		if (!msr_info->host_initiated)
-			return 1;
+		if (!msr_info->host_initiated ||
+		    !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
+			return KVM_MSR_RET_UNSUPPORTED;
+
 		if (data & ~kvm_caps.supported_perf_cap)
 			return 1;
 
@@ -4263,9 +4265,8 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = vcpu->arch.arch_capabilities;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
-		if (!msr_info->host_initiated &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
-			return 1;
+		if (!guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
+			return KVM_MSR_RET_UNSUPPORTED;
 		msr_info->data = vcpu->arch.perf_capabilities;
 		break;
 	case MSR_IA32_POWER_CTL:
-- 
2.46.0.rc2.264.g509ed76dc8-goog


