Return-Path: <linux-kernel+bounces-417362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B839D52FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04048282245
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C001DFD9D;
	Thu, 21 Nov 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmRG4+Du"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A91DF742
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215212; cv=none; b=VugVkMIZesad2Zr/arCU6Nxu5UhsUuxTgN7qCH2fCs6Y5KTLIspnhwhpTywcZ0A0djbBBBPrXRj9y4M14+nlmJfZIBUhrCphWzkKiy8BbM1iZ/Js+TuLTBhUU424WTM53RD2YJFNU/INrQJ2BHQASjFic4Fkps1tyZwIhi20by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215212; c=relaxed/simple;
	bh=HIwgyq0n9Pc6IQ1JW0mNNbc4Q1w8gUiM8GLpxz3MNio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uqauNA4MCwbNdLmVqrtCgaKxeeeR7MykYsrIUoitJe+1Ke79IvlkZhjl79S6tEQ1mWlV3DTkP3GCj8IVE/k86dLTNRZLCdWCbI+B90poRI8mVzewmvOw/obvA5/ysQKDoP2SCEzkAIhKLJW8X9blT2vihZYiUwVItWMXLJhXnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmRG4+Du; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8794f354so21237667b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215209; x=1732820009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=179m8kOvQfRqP37wmtAhsMQnswgm0gukoWaPbObarIY=;
        b=ZmRG4+DuMWNCDnDdrGbuILOaPLCIfuysnoc2coDwQ9tvZBu971oWt8QGQk/v0ZG8SB
         lh5yW9bVqyx41EYwpRhDt36BkHYVPtwoBFU9mOdt9BI4okKYZTl0Y60nUhZiUkXKkGnc
         93ejV7dIWXIb3QafDV6dDwcIWoxGsGmwlBmk9vUh3e2EZ6aRHGpO823QSDtTPjf1VWTp
         4K7z+Gd2pl7/RRaZ/yK1kZVyAxuPbfBXYG55UrptpxAvdQNMc1mU7XR3ZDQL1lPPiRtY
         hYJwGYmF0PTApfT5w1xPuVXyEkO1p2x06sKtUegp7cX4vLjMdy0J7luuiyXrV9yV8mXw
         aBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215209; x=1732820009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=179m8kOvQfRqP37wmtAhsMQnswgm0gukoWaPbObarIY=;
        b=lOe8WyP3KRFP4Q58xKJWK54WumtPW6/H9Wsfhqs3HRkfr6M6witc861D0y6/AsSxLI
         IEDxB5u7kW8KiGmVJFVlOiXWZqzJ9f+XsPUdbHtEitMPhN3p1QUTZLfXpHOxOdmA75x9
         0BQOrg9TpwO2spsXApmZ5vrGoRDwfXfLJh53wOG6BQp1fAwUdiwTP8rZF0/WCBJ6rag9
         HEGp1KLImjCzzEmuW4V4y1FXeNBQ9+XzF6mQgS7tkeyph1i29YlCQDgbBsN7+mAQ2dLY
         7PLias/9vbSn2vNNjUD9P61CU1d7rBkeqhP1VLi56VqDiH5zmdZzJFSGVPa70JLWpncL
         Ov4w==
X-Forwarded-Encrypted: i=1; AJvYcCWeAZVk/UZUm/VvMDmPZwO+SF/T7ne4/U9Uaaec5IF1OqpzLovMvn3a+SW1dEAWAiFvfE1cOS5Bi4Co67w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0j9SiZNCph67ziTtFZBC0u2vCWIPmTrYHmsKkcKCJLSCn++va
	50M3pwk9tqPrSJ416HlNO977UTPiChRosSpdMMKnTq51YXlzRUsvsADnaBw4ET+izX4k+sH55Ra
	tJqMNUw==
X-Google-Smtp-Source: AGHT+IHDdAZrVVVtQkbNY+ODhRentmxWbP6Rfzn5FkbIRQBeRGy86k9mMoUCty77jPdE55ldMhNkDkbK1cVV
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:690c:4b07:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6eee0a26d5emr29857b3.4.1732215209587; Thu, 21 Nov 2024 10:53:29
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:59 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-8-mizhang@google.com>
Subject: [RFC PATCH 07/22] KVM: nSVM: Nested #VMEXIT may transition from
 HALTED to RUNNABLE
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

When a halted vCPU is awakened by a nested event, it might have been
the target of a previous KVM_HC_KICK_CPU hypercall, in which case
pv_unhalted would be set. This flag should be cleared before the next
HLT instruction, as kvm_vcpu_has_events() would otherwise return true
and prevent the vCPU from entering the halt state.

Use kvm_vcpu_make_runnable() to ensure consistent handling of the
HALTED to RUNNABLE state transition.

Fixes: 38c0b192bd6d ("KVM: SVM: leave halted state on vmexit")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cf84103ce38b9..49e6cdfeac4da 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -994,7 +994,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
 	/* in case we halted in L2 */
-	svm->vcpu.arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	kvm_vcpu_make_runnable(vcpu);
 
 	/* Give the current vmcb to the guest */
 
-- 
2.47.0.371.ga323438b13-goog


