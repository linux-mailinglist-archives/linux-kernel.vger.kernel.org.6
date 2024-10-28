Return-Path: <linux-kernel+bounces-385325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA69B359E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302CC1F22F10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CA1DED6E;
	Mon, 28 Oct 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pay5G7sV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A11DED54
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131311; cv=none; b=DlfMDbuSa8jDZCtPSh8hvx2ginO5g7v7zHfqq64amaO9pcysVY6N2gDxPVdzECWbYxKrTxUyTsckwLLCnlhHh/QrgGzIwhq+WuAgXog221/AJtImUumFeOGrStOxQmfIvorXj3pAf8l/bzmgiUT63bh1N+ttm+uGFKJOUq2mzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131311; c=relaxed/simple;
	bh=7PRNa+uQzRKDZOo/peK7GEezP1r6PlJrVhbHzVtCDD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KePTkaAoA4wc9lC5s7WuqQ0TmiAIiuDSo74qgalDf4SSDgf3AdbJ/BLhNUrlMZ9j05ea+lBLLoyMGdjxSbFyKpPrskkbUrYpxqZSSGaPL9B4cJYRnzmJFLK5YfWRuihV47PmYnkP7yOag3YXbxsOytIrOZQ+ujyM+eQhsGSkmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pay5G7sV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so7348084276.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730131308; x=1730736108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r02bHDcQ9tRemd8lnxwsawjLvScs8VGZuPjD+oM8q8A=;
        b=Pay5G7sVGRk7lZ4U2mLLuVB2WbBKDDdMjILAYb8IF7MVO2z4M9mjicrXyQSfpUeIMX
         lci/LRt6KYF3lM7gAKMIhHAhGk0Wt8oPWsQ3hHuWGL05zg2mFe1NUC9dfYogDfgnMCbG
         wOA6jtVdenJr8Y0jqFsTGMVSHL9Hgm27GlIwKndyZ3ospRtxwHLb/GSd/l2svu8wJwrz
         lIoDubslXLQBRZ6RKmQbqkQDX7WI3XVRu55/yC0f1EEvAst9RszwzfFNTK5dmzVFmGvY
         nREhdojBH1rEUempstGVxgC3//zV6nrJnqsY/9mHK0odwCI6w4WaszljbdaWAt4HeHQc
         u3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131308; x=1730736108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r02bHDcQ9tRemd8lnxwsawjLvScs8VGZuPjD+oM8q8A=;
        b=G71WcevVNLTvurpFxOs18FerCM6Xtnaas4VZXkb9gmgLHsWOz386Z+iTQkzM0yWLe1
         l7EaqobkuUHDTHoAPllNv9OCxJHrMqOZ5b/MOn3v3TMth1OObGFIODQpOxDGFXbzW2T7
         qmcn9lBUDKJk+pIxBzfBUXysEuPCHkODTLwIsh5A3Rx9F3v9br1G7PKnPyxjq9LbkUac
         qCRijki4d9JHcsgnLuRvNHbfAbFZhj3qzzayB8E5kjqU4DNlbd1vxtZe4x4NGxlyodL0
         ZlUHj2aIhhkT0GrN7Fq4TWuskbURKm/zwdgUrv/hiuNRPLBvEtBBrEP9hSNE0KzIAJmR
         qA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVdOmTv5hGl55e0TSMBOJNLhWWzoCoNLEjXhyAvNBCdFyZsqECLDtdMjz2ntW4t6FsG5vMRj/pBd5D9UOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4pKUF4WZs8uXtzIGFpj1aXEf6+NJ1l7nYYcRg9hl7zLH+fcb
	rKE/6sLC4Vd6nuQhN97CyAYQjXV4EGWZC2HoxQfMai0zUfPxo/5cR8J54vRXf07KSjGg/K6NeI5
	smQ==
X-Google-Smtp-Source: AGHT+IEKUP2ZAMuHgHcmbZspRBm/ZQWf9eWaTd80Q0jLh5BNLTlzUUdtWo+08mkzloiLxpY8tEw/bnordWw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:7810:0:b0:e2b:d28f:bf28 with SMTP id
 3f1490d57ef6-e3087a48962mr44938276.2.1730131308346; Mon, 28 Oct 2024 09:01:48
 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:01:46 -0700
In-Reply-To: <c8e184b7acf1e073c0d6cf489031bc7d2b6304b0.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729864615.git.namcao@linutronix.de> <c8e184b7acf1e073c0d6cf489031bc7d2b6304b0.1729864615.git.namcao@linutronix.de>
Message-ID: <Zx-1ahdKLH3o2MHj@google.com>
Subject: Re: [PATCH 04/21] KVM: x86/xen: Initialize hrtimer in kvm_xen_init_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 28, 2024, Nam Cao wrote:
> The hrtimer is initialized in the KVM_XEN_VCPU_SET_ATTR ioctl. That caused
> problem in the past, because the hrtimer can be initialized multiple times,
> which was fixed by commit af735db31285 ("KVM: x86/xen: Initialize Xen timer
> only once"). This commit avoids initializing the timer multiple times by
> checking the field 'function' of struct hrtimer to determine if it has
> already been initialized.
> 
> Instead of "abusing" the 'function' field, move the hrtimer initialization
> into kvm_xen_init_vcpu() so that it will only be initialized once.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> ---
>  arch/x86/kvm/xen.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 622fe24da910..c386fbe6b58d 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1070,9 +1070,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  			break;
>  		}
>  
> -		if (!vcpu->arch.xen.timer.function)
> -			kvm_xen_init_timer(vcpu);
> -
>  		/* Stop the timer (if it's running) before changing the vector */
>  		kvm_xen_stop_timer(vcpu);
>  		vcpu->arch.xen.timer_virq = data->u.timer.port;
> @@ -2235,6 +2232,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
>  	vcpu->arch.xen.poll_evtchn = 0;
>  
>  	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
> +	kvm_xen_init_timer(vcpu);

I vote for opportunistically dropping kvm_xen_init_timer() and open coding its
contents here.

If the intent is for subsystems to grab their relevant patches, I can fixup when
applying.

>  	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
>  	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
> -- 
> 2.39.5
> 

