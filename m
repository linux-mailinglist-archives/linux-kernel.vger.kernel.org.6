Return-Path: <linux-kernel+bounces-174696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEFC8C130D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962B5B20E83
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BB4C96;
	Thu,  9 May 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2Q8Qnnu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E564A1E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272561; cv=none; b=j1z1QOtWW1+gFr2GyZ4OXEkrDaeakynYjyH7/VmgbIKpgEDKtCRH6qVFLQMWPjaxpBb3rPKwaogc7F8ipiuztVazTr078pD6ULPqAX59IwfVw3HiV851k3tM3+6zJslFsL5vfxnIk/pM71sIJv+FmNL5jdnmfzL/GHNIdFRgO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272561; c=relaxed/simple;
	bh=87bp7rOhrqwnSubPXK+LN1e3D61Ah/S325tsXWPIZGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6VeCo2S9DETbwfPOh267qBjja36Kqfq0YEq5LL6GEFH9VGa+wL5LfikqcL0amAHvPa5LmjNOsNWFhYpNndozXBKLDExJgA3yVaCxyeyMfkOz2M04dcsRteIlbLAMQwo6KrKtdqa9v/Gp3aYd64+mioK1fCtYeVxThlaGAXxBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2Q8Qnnu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de468af2b73so1812275276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715272559; x=1715877359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw2S8aMsSqYdON9wuYedcQx5DOc1DfHVFQCMk+J37cE=;
        b=P2Q8Qnnu11sEtRxdK42sxv/06HpQkOBMUqsUp75z66uULW6Nj4T5UXjckP9Szpg6gY
         9r/dfsd+f4GsChJEASbx6tyG90VmVrtf042F2utitlq0kAhJ0aLIdSlfiAje0fN9Eo6K
         DL4mTvU8f6+DBU1U/Qf20vzUKKScZX4UHTehJaXlkut9lVYn+S9LHITP1QLut16LaH0L
         WK3j/csGfIZdCUSBgQ3NtDQoFt+MqiiCUrg/+BU+tzgvTtE5A+gwSVanVpQ9k+mudRnK
         qetZLQ0K0vT3WsnpK0s68i+W2Ah8NeyJfOuY0OkEztQtjMONG16ty8Gh82MZ5N4MSDbe
         yyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272559; x=1715877359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw2S8aMsSqYdON9wuYedcQx5DOc1DfHVFQCMk+J37cE=;
        b=a1P5BV12iYmN+f76yo5H7BGgTc0kmful/Ay5ApE69YYJtk+55hL/5KDKJEQFdxL+Gg
         bcTCrahug6ZgyHfY9ugd4Tbhhkv+NAyv7jP4e9HVfJLDeCc5F9Gyb8ftiJahyCVV1/9g
         mtTDdy7I0ZOiFOD1oW5rG1tcGHfRCynLfFz0tkEl1NhcIOvzNDt6XQDfiLHuu5SQAi1s
         Vl5wml7pTYRK7AM/6eAC7CX899NJJKm1LDN4+pBrVX1cn/NMQKf9otUboCUtkFvEXdKz
         kXZxiZ/bxhPDxCnQHXy++v8TmXmUZKX147UumwL3cEVEyRsn2dz2/hk/9j04AiC7z+Yf
         qfGw==
X-Forwarded-Encrypted: i=1; AJvYcCUChD7SfQUjfgTEjLocfVRXx33x+crODRsIwFdvpen4h1KTQkdOr9fPMPLdbd6v/ML9f51hK+yy6qEqbWn8BBdCQpIZyPK7QdyA9mPx
X-Gm-Message-State: AOJu0YycnnVSFEv6xLTv6739WmINUVXAJNtcb/oix6w9g4gYF7tIwmoK
	6OANw0XY527oO0PHoUImaWQX++CArG2HMtJwXLZ3i19fcJ6+8/XHYguBNK5YQb6NmBftBmhAR9c
	vSw==
X-Google-Smtp-Source: AGHT+IFoKoT4p2eM5fgOn661sHqE65PS3MBIpAxxHcbHhckzhgqXx+gWzNwUX4idLZLXJC6IJ3QKfsk8log=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr7282276.9.1715272559399; Thu, 09 May 2024 09:35:59
 -0700 (PDT)
Date: Thu, 9 May 2024 09:35:57 -0700
In-Reply-To: <9bd868a287599eb2a854f6983f13b4500f47d2ae.1708933498.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com> <9bd868a287599eb2a854f6983f13b4500f47d2ae.1708933498.git.isaku.yamahata@intel.com>
Message-ID: <Zjz7bRcIpe8nL0Gs@google.com>
Subject: Re: [PATCH v19 037/130] KVM: TDX: Make KVM_CAP_MAX_VCPUS backend specific
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 26, 2024, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDX has its own limitation on the maximum number of vcpus that the guest
> can accommodate.  Allow x86 kvm backend to implement its own KVM_ENABLE_CAP
> handler and implement TDX backend for KVM_CAP_MAX_VCPUS.  user space VMM,
> e.g. qemu, can specify its value instead of KVM_MAX_VCPUS.
> 
> When creating TD (TDH.MNG.INIT), the maximum number of vcpu needs to be
> specified as struct td_params_struct.  and the value is a part of
> measurement.  The user space has to specify the value somehow.  There are
> two options for it.
> option 1. API (Set KVM_CAP_MAX_VCPU) to specify the value (this patch)

When I suggested adding a capability[*], the intent was for the capability to
be generic, not buried in TDX code.  I can't think of any reason why this can't
be supported for all VMs on all architectures.  The only wrinkle is that it'll
require a separate capability since userspace needs to be able to detect that
KVM supports restricting the number of vCPUs, but that'll still be _less_ code.

[*] https://lore.kernel.org/all/YZVsnZ8e7cXls2P2@google.com

> +static int vt_max_vcpus(struct kvm *kvm)
> +{
> +	if (!kvm)
> +		return KVM_MAX_VCPUS;
> +
> +	if (is_td(kvm))
> +		return min(kvm->max_vcpus, TDX_MAX_VCPUS);
> +
> +	return kvm->max_vcpus;

This is _completely_ orthogonal to allowing userspace to restrict the maximum
number of vCPUs.  And unless I'm missing something, it's also ridiculous and
unnecessary at this time.  KVM x86 limits KVM_MAX_VCPUS to 4096:

  config KVM_MAX_NR_VCPUS
	int "Maximum number of vCPUs per KVM guest"
	depends on KVM
	range 1024 4096
	default 4096 if MAXSMP
	default 1024
	help

whereas the limitation from TDX is apprarently simply due to TD_PARAMS taking
a 16-bit unsigned value:

  #define TDX_MAX_VCPUS  (~(u16)0)

i.e. it will likely be _years_ before TDX's limitation matters, if it ever does.
And _if_ it becomes a problem, we don't necessarily need to have a different
_runtime_ limit for TDX, e.g. TDX support could be conditioned on KVM_MAX_NR_VCPUS
being <= 64k.

So rather than add a bunch of pointless plumbing, just throw in

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 137d08da43c3..018d5b9eb93d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2488,6 +2488,9 @@ static int setup_tdparams(struct kvm *kvm, struct td_params *td_params,
                return -EOPNOTSUPP;
        }
 
+       BUILD_BUG_ON(CONFIG_KVM_MAX_NR_VCPUS <
+                    sizeof(td_params->max_vcpus) * BITS_PER_BYTE);
+
        td_params->max_vcpus = kvm->max_vcpus;
        td_params->attributes = init_vm->attributes;
        /* td_params->exec_controls = TDX_CONTROL_FLAG_NO_RBP_MOD; */


