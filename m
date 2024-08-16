Return-Path: <linux-kernel+bounces-290434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A090C9553C4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5F21C2107B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22635146D53;
	Fri, 16 Aug 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/n06B5l"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54080034
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850955; cv=none; b=MFvKYWeAy5oM9DKErZQ/Wa8KDAI9ymfmi/5XSXO2xztFzJSCp3gd4g8keD1HtV0Z5pA8fISBGyVHuqBSk0krVev5ObWlffzOx1oo0H/0F4EM2utg2Fk7NhLNJONa8sdb/JGHcNePPGwBkoj5d5d7WAw4Ovuv78uFhfhe6UiMyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850955; c=relaxed/simple;
	bh=Bt0YMJRmw8MNOul/135L3smUMgVwn4BpfnuHVrP+vwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIOaq8V5dYUZ6UBlWXNschpPs3o8A8EzKusOfS3TQv9OdzmVUebbRnoRFdAcvxJUI/VrOhYiLuwoaWoqk58w50t3XO9zr4tLqip8cFW3nfIh8iiVOHiyepihOSTlLFATxYQ/K3lmzTzsoc6W4bxg4uc+qQJnB8eCInvzCe1U88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/n06B5l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e118098bdb0so2560652276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723850953; x=1724455753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUfZiEZ/zWC4oS/2guG5kwxGPBzTqwm8IwXvGlxoeJo=;
        b=L/n06B5lKScocWuqQM0nJLuKcoLCPjNhJDVxgQGzR4xh9ZP7E2jnE2RPcTVUUxjrEX
         eL88UFKQg6Xpa51R1Bfz1emZCfJiP4dqkTp8UfEfSW3oPKQSDokLgOgmYWKIRep7pULk
         rGqML1UU0YurNzRFH09eqeP1prtO3v7QdOHUWd0goM8JntHNuNY9vR04E8VsWFhGgY9u
         wU9bEJjk9mr0Qlxhz+gHnpvgedP8+L8kZ54tmMo6gRKYYktInCkMJGs1iwTx+o50MPxh
         QRXYhOeDJ2rZLAKxrhp78ucjPqWiOrShsKGd9h6SAK72nL1pzcJfUicJtzggoTyyoByE
         1ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723850953; x=1724455753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUfZiEZ/zWC4oS/2guG5kwxGPBzTqwm8IwXvGlxoeJo=;
        b=gJcRV5UccUJGlt63lR1z2IrPoeoo5tUMtbFIvhffbyEiAhyADD8lkoFAucUNVFxgYJ
         0sk1XvLy2+/6eTeUkVvAXoJO53Mp3auIptD3HqjHHZZhwK4/UdXbZxWGx+NPnD7HKjbg
         r1Wph9OXCpPgOVuojmGVvR09hx2J+x7v08pAGaVpjhNFngEeVix1y5J7ZYcbjsY3iG6F
         w0skzTEn5oWZm125pVUd7r/HlFEODsEYPYC4GhqjQDeT23ed8pLebTekGONYhZBijcGz
         7i1EWTZV39Lhdb2KGNQJXhICOkcbOHKGAyFOdU1DpNS1XKU29+Od2XsS2vcf2Vl+QQaw
         W48w==
X-Forwarded-Encrypted: i=1; AJvYcCUCxibFAVKNipmWuk4Gm5wCZH22MRi2jkmtMDQTcPlR0I/4buU+X9/nKxgBWu+k16C2vC6s6i+ZiHxr47Tk8/YFvXwT9Mq75Qs+PrZG
X-Gm-Message-State: AOJu0Yx6OvZIfI+kh/HlkOy8NmL4rRmOOSYZTmdeL3Q6SqLV7gOXgXTW
	hznYYNpobHDPdeXpRh2tdicewyeBFDVQV2Y/jo4aXIXcmBs0pDYIAaG+ibqDGTtiglxwsIREb8s
	3Vw==
X-Google-Smtp-Source: AGHT+IEWb94aAO5u4fTb/3R3D/23R8YCTqJ4nqrJFUMcRxNYZoeVejVsFCkWl54WRQZOieysZmSQkPHXweQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:c4b:0:b0:e11:ade7:ba56 with SMTP id
 3f1490d57ef6-e11ade7bf1dmr63773276.7.1723850953027; Fri, 16 Aug 2024 16:29:13
 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:29:11 -0700
In-Reply-To: <20240812171341.1763297-2-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812171341.1763297-1-vipinsh@google.com> <20240812171341.1763297-2-vipinsh@google.com>
Message-ID: <Zr_gx1Xi1TAyYkqb@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Split NX hugepage recovery flow into
 TDP and non-TDP flow
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 12, 2024, Vipin Sharma wrote:
> -static void kvm_recover_nx_huge_pages(struct kvm *kvm)
> +/*
> + * Get the first shadow mmu page of desired type from the NX huge pages list.
> + * Return NULL if list doesn't have the needed page with in the first max pages.
> + */
> +struct kvm_mmu_page *kvm_mmu_possible_nx_huge_page(struct kvm *kvm, bool tdp_mmu,
> +						   ulong max)

My preference is "unsigned long" over "unlong".  Line lengths be damned, for this
case ;-).

>  {
> -	unsigned long nx_lpage_splits = kvm->stat.nx_lpage_splits;
> -	struct kvm_memory_slot *slot;
> -	int rcu_idx;
> -	struct kvm_mmu_page *sp;
> -	unsigned int ratio;
> -	LIST_HEAD(invalid_list);
> -	bool flush = false;
> -	ulong to_zap;
> +	struct kvm_mmu_page *sp = NULL;
> +	ulong i = 0;
>  
> -	rcu_idx = srcu_read_lock(&kvm->srcu);
> -	write_lock(&kvm->mmu_lock);
> +	/*
> +	 * We use a separate list instead of just using active_mmu_pages because
> +	 * the number of shadow pages that be replaced with an NX huge page is
> +	 * expected to be relatively small compared to the total number of shadow
> +	 * pages. And because the TDP MMU doesn't use active_mmu_pages.
> +	 */
> +	list_for_each_entry(sp, &kvm->arch.possible_nx_huge_pages, possible_nx_huge_page_link) {
> +		if (i++ >= max)
> +			break;
> +		if (is_tdp_mmu_page(sp) == tdp_mmu)
> +			return sp;
> +	}

This is silly and wasteful.  E.g. in the (unlikely) case there's one TDP MMU
page amongst hundreds/thousands of shadow MMU pages, this will walk the list
until @max, and then move on to the shadow MMU.

Why not just use separate lists?

