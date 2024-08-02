Return-Path: <linux-kernel+bounces-273054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29C946413
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653842834B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD56D1A8;
	Fri,  2 Aug 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvfoDdEd"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422264F615
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628286; cv=none; b=GdV8pfSqFOu/Wr08PKuCveZYNMjOlQaBdJZiEj2WExVCTq/ykPCayQLz3W4pMc1yn5Q9aXUwHQcVtPotm/vliypcbza6PJ1e2AalyoU6Y2quf3pf4QjAxOMowp0NJ0MoocG96NVmbGX9e7kcLU3HXjgE5fMYcXy8rp/5DSPJb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628286; c=relaxed/simple;
	bh=zql+KU31olSPyMQGIOOmlA41hrQI7991hIRTrHnkF5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIEPhoWPOEoDi/yT1HGnGGBHFF6xn3TBe0697sblHTHFAlipm0sOpszEWsUWS1GzPOEPLMcdDGMnM3Y8QiwY2fa6Rgjhg96/EGnS4rSGL/cxhWdnfQA1jSRD6iLlxyF1ic6rHGIyUAcpb0OSdq3TA9xxZUh995FLDQxw66O33P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvfoDdEd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e9e4dfbeso13185417276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722628284; x=1723233084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=j3MDuI39zu1XA4gRdGvyMxqjMSntoDT90qhT0kUFZqs=;
        b=RvfoDdEdubGsBZqZvhW7Mwi2ErJo/qjP2Dc430keGlJ4PbjVJ+396w4eXSD62UNmt2
         WTJGpuLtEZJcKN0qUZF1J2e3l28yUH9j/TvNSDAtA843Z6W59goEPq8Kl60flLVuXCKW
         t1vaFZ6RArUF9ojfUtVUaKggx9Wz8T6gERL1oClnZD3FmuF4GED045x7NBdF3Ni07+Xm
         dUXCF24Jd43HLSqOuX8LS25M1UawDTHoZfSBdDR/Qq5w4et58tv84mPSVfvAzluVBwJx
         l0TGP1hVNtUJ+F9bC0hU2YVJykcivKxtTKQBDNlwynuYMN+Uv2HgCk0i6gOASzRkU+lu
         wbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628284; x=1723233084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3MDuI39zu1XA4gRdGvyMxqjMSntoDT90qhT0kUFZqs=;
        b=knM7qQRaUEZLIYdAEP9RDjy6b/r4avf5ohsLZmuhG8ZYlyYrGwZFcD/oz0eScvlaa0
         211GlioeLkgzqgRw7bLn5BLAoBxOizUZ+McEZyWXWQaNVKI6Gq0/gFnss/C4v205lb22
         2u0yJrOvbyT4q+p7C6XMy6ITKjkcwDuC3kDApCWBsAO5ffg9xH4hnzXBHX7NyPQdVLKl
         6pdiThR/+nh0oJ6ttirUw7zbl4g+WTA/KwW4/q75QbMs003LfdEEChBzTLj/Hw2pYipy
         IH4ljp4RjBDEFWhW7ZcAuCeYeEz0lrPWzUTu8jjkhioW9dwD+hR+3JdDXHc4gnO7s2Sn
         mO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH5RO4rMotj4IivrRPAyGGrEiA+lGevP1GJReKrY1fbad0bLIPySPrbnasmaBJMowGZg0T4LKWoJnLxGOD8SisnVv6dRehwCjHDl8Z
X-Gm-Message-State: AOJu0YwkYyEhcvSHK9SDNqMgdCmz4ae9bnzmsfdKcV5jCMgvT0K4ElDD
	L3ok3NUXjmUKAr8jceQIcSLzeEsYC+nj3Gb3DndgXMmmg7+r6tA1gPTvvrBwh+4dWw6+mIpG6DR
	Bog==
X-Google-Smtp-Source: AGHT+IHXmtQ4fn/w4A9o1IxjByT19mNXJlLz8OGSPq2+ASik931Ksxoz9M3ugqUoQtYF2Bf10ojDjPLGf1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:405:0:b0:e0b:f69b:da30 with SMTP id
 3f1490d57ef6-e0bf69be1bdmr634276.9.1722628284272; Fri, 02 Aug 2024 12:51:24
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 12:51:16 -0700
In-Reply-To: <20240802195120.325560-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802195120.325560-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: x86: Re-enter guest if WRMSR(X2APIC_ICR) fastpath is successful
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Re-enter the guest in the fastpath if WRMSR emulation for x2APIC's ICR is
successful, as no additional work is needed, i.e. there is no code unique
for WRMSR exits between the fastpath and the "!= EXIT_FASTPATH_NONE" check
in __vmx_handle_exit().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af6c8cf6a37a..cf397110953f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2173,7 +2173,7 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 		data = kvm_read_edx_eax(vcpu);
 		if (!handle_fastpath_set_x2apic_icr_irqoff(vcpu, data)) {
 			kvm_skip_emulated_instruction(vcpu);
-			ret = EXIT_FASTPATH_EXIT_HANDLED;
+			ret = EXIT_FASTPATH_REENTER_GUEST;
 		}
 		break;
 	case MSR_IA32_TSC_DEADLINE:
-- 
2.46.0.rc2.264.g509ed76dc8-goog


