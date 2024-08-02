Return-Path: <linux-kernel+bounces-273020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D37946372
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7D01F232B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B916BE23;
	Fri,  2 Aug 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDw3Ddam"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE76166F20
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624927; cv=none; b=PBWyGa3zAghAokGitHr6LRi6VViskF/sHu/XihSqu1ML+MPlRPCeEdJN8ZxMq/kmOIa7sEgCF51werLXzCKT4UvJlEEGgOMKPTw+/mdCVKm+/tme/bZQP5SH/c3RXIEfcUbC7ojJO2W1dEwGHRNF2m6qTvdgYHxthf1kf4ziSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624927; c=relaxed/simple;
	bh=LDOaWJALh8LIEd1qVXVH8rc9BOsSwO8ZCATmsDwRVXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bM6u3GDMhUYj14Wa50sGaA2OFhmOw9RtsLL9h95Pcu4ODG23xPfT1SzVn+JgL/jyZ+CjdvWhhAVZEMkZj8ypMDPf3785EQ+FkZgzJ7RPNPxg5lq/fd07uuYXbe5nGC0EB0i2/jq3t+XAnTRFwep+y4KitZ0nqd+U7grFNf0Pvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDw3Ddam; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be1808a36so2207100276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624925; x=1723229725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FE77h25ouI+MvHqHcKNFD0Aq2a2Ny5IL+xeLrJLvY5s=;
        b=PDw3DdamHXrRNXvwvIcYifvgTmEBS7X4Qz3hQbuupkM4SxaQvUxRqWmNPiNZn6TkwV
         2KlvUdUokRBQ3NOmBly0C8JlQl30QB1HhGQbINRnKscyNvDvXi5Rd6cBkew4+4zi21rf
         k5OWASfQzDPhRJwC+AIoQ3GYiSi3xAFNcBCC/U80SN/7xS8Cj8mT3dXeNwdLAOD3lLsB
         2NBSihb4gqzMo9hulpm1SF6toxxRBv9B+U81l09nmYVxy0iMpAS6oLYl5ySOH/uXtxMV
         zSR5Tagz1TQ0ndVVt8qSagsobAp2KiCHq81diK6LuUalEtOpG8Y5z7XlQd/s6AQclKkt
         0w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624925; x=1723229725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE77h25ouI+MvHqHcKNFD0Aq2a2Ny5IL+xeLrJLvY5s=;
        b=Nq+x09RwozkT3Toj6VgJqfg6/3acpAaaLRrkIKmUgU7xxNhUsz4cMUesXzhBvcx1MD
         C+lfzBdCEoPE+oddjZTYRBl2KIqN2LVEcM+kYasdxS0IdhMAf4QyXe/OKEbwEfibUTIw
         fSmOzrdI50ERoUTZSM6kXPJZ7O8yGf9BBxqrVq+9qkrAKE7AGtqaja0D4UAkhobnDHdb
         ffAhUf2FY5tr4Kc2SW86omP0IRcfTUmu8+LhM2tJsI7YSY4JJZeB7crJlQoTR9wHTlIZ
         IK1mtyX9cRnntdygoail9c/Ol7U6aBKRwAVlADWdPVKAp0tKwlkyoUcaq3fPpz2/vzy4
         jEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsHQ0iboSLmXT/SZFYVwH8xCXrHAiY7DIDp6ox3Maku1c+t1KH0YLqDDgzJgxRS5mIbrfoPXpPXmCoc44kV8Sd69sBdiyOOq9k7Rtz
X-Gm-Message-State: AOJu0YwzShLbsIipn4K5y6mlbl9cd7lNBfrjtbfPf/djkG3e10aiLwKg
	+ep/0bMeCS7aADAzg3SZAgo0Xh9DZc/Ng8JWjMp6qJRUbpe0kgygTnk6sFUjFcUOB56W2Qg9T9r
	K0A==
X-Google-Smtp-Source: AGHT+IEzFcg9v5dqpL46Kk3NBRRR4k+8FlZyX8gqz3k2cnpL3lAj/Gmokl2ZzR9H5/8TOAiTDCSBElhz7Yk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154e:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e0bde3ec6a5mr266556276.9.1722624925601; Fri, 02 Aug 2024
 11:55:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:07 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-6-seanjc@google.com>
Subject: [PATCH 5/9] KVM: VMX: Remove restriction that PMU version > 0 for PERF_CAPABILITIES
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop the restriction that the PMU version is non-zero when handling writes
to PERF_CAPABILITIES now that KVM unconditionally checks for PDCM support.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c1d06f800b8e..f636d811bdc1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2460,8 +2460,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx->pt_desc.guest.addr_a[index / 2] = data;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
-		if (data && !vcpu_to_pmu(vcpu)->version)
-			return 1;
 		if (data & PMU_CAP_LBR_FMT) {
 			if ((data & PMU_CAP_LBR_FMT) !=
 			    (kvm_caps.supported_perf_cap & PMU_CAP_LBR_FMT))
-- 
2.46.0.rc2.264.g509ed76dc8-goog


