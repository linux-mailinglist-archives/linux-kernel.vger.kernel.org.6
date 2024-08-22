Return-Path: <linux-kernel+bounces-297860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FCD95BEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3121F23DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44D1D04A3;
	Thu, 22 Aug 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1zPviGEg"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF613CFBB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353517; cv=none; b=VLgU3GSBGNcYCcyWSaXtstQ9mZbRMUrlGdTZqAoccAxE17DuLCQgQdmswqDGSOA9JjOcqWr7OEE4/dQbozw2RNcBw95zaLFwA9JduFn/rBMnISXxIC8UXZciLSQnnyPLqN2OuP2SPv7Fvepy4Vn6YfC6nsdchLLPef+bV2LFW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353517; c=relaxed/simple;
	bh=ZBZhkowMn5+x66e+SOC5mEJVdaBoAitW0wGhgEv3tDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=beg28gUW1gMBgItkdTqHre01e8G20Cl0/wAX0BtNlY1x1AJNTjPRfc1KewebqxMieLxpyqMC7Ol2OcbkCRAAB8ku8anoLjJoUr84uZfEq0qOEsWGFfPA4OsQmVwIphLII4sjNfEZU/TvxgvZetfVe0iOveknAn7785hCMvG1Qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1zPviGEg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20383bf72easo12542885ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724353516; x=1724958316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=58oWs9xmURa+ECOnRoG429b/eHW85IJdtjG2bgCyQgk=;
        b=1zPviGEguoPokRH1CT36H4tqr0VZa+C0bGdcEwzxJnQ9SfVssHZZ1WwMmG1xIcYvxl
         yNs12FiN75sxb7g1MwNdgjit9rF7L1ASp53/sNL9mYlfTQfURTbNyZc96KL3tKXzqfF6
         OkIahk1YnMWiB4GEXk9tidkOegraP+5MH/Sfdwp3kNdIaEYdtuFfuJ3WNnOWCV7D0DcO
         xAReIjOg/gcW3RrRIDJvgQk56BEDf4pGUuADjfQz5r/QXeRK+05pCOUxMuD/mMu3SecX
         5/cZSl2FUhfXtZNtPVzK8JJLKwTkN5jiA7L5/6DQmT2o94pGcrq8l/lUqRBMjLizxjAJ
         x7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724353516; x=1724958316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58oWs9xmURa+ECOnRoG429b/eHW85IJdtjG2bgCyQgk=;
        b=vftnSm4wM++X+mDBN0+Vf+su19CEP0O+YTyGdQsrCCCOSHhcsWWfByBjq5AGG5wuYK
         AWKSBwSux3xO1Nbrd/18L8leUySLazIHxIJgKnBWwbR3yJ0Xt251dE8y29AjIh3M/cJL
         8O+Li5AfsyXWZnJZBxnfeviZ8lTiFI70YseZsXXRxXHZ9ZTHo27QVb+DoL7HJC1O3v9p
         /6h4H7Rq2zWP+TxRWfxDvTZKl3dn867tzknJhogZnvIRPDR1u1UVKTlefDMjNHmt73A6
         Pc00XawSuU9o2UCouJNY1Ewz95xAGt1tV3Naj7iBDGoSjolnaRtkeFHzuTwmBEYGtJvi
         /Png==
X-Forwarded-Encrypted: i=1; AJvYcCXRT4lYrHYF6rspBQuPEk8M6WwOgsDkSaTmfvGgnuWpjMOKOKGhgagCIViWunRf9XQ7Q1whCpjMt7DBGSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo16jPZHGBWi63H3txRF6PyNw+ddWtY/AXjBwTmY5d4LH/hcVG
	0Z98EnKDpbvh9dVfwAt9W78AqyZdEhJudjq3OJDkkDHUU+aWCHa5B4yJDmbCacmInxsl/i+RUOR
	RLw==
X-Google-Smtp-Source: AGHT+IGM5uynL7SoMEHdJTIPPMd+V7/5UAogAqGnMIDSbW29tAv0e2tHI6A8j2oe7Ik2dIV9It/aDj+g/ug=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c402:b0:1fb:4b59:d0f5 with SMTP id
 d9443c01a7336-20398a06131mr44225ad.3.1724353515430; Thu, 22 Aug 2024 12:05:15
 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:05:14 -0700
In-Reply-To: <20240321082442.195631-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321082442.195631-1-d-tatianin@yandex-team.ru>
Message-ID: <ZseL6kZ436EGuS9H@google.com>
Subject: Re: [PATCH] kvm_host: bump KVM_MAX_IRQ_ROUTE to 128k
From: Sean Christopherson <seanjc@google.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yc-core@yandex-team.ru
Content-Type: text/plain; charset="us-ascii"

KVM: for the scope

On Thu, Mar 21, 2024, Daniil Tatianin wrote:
> We would like to be able to create large VMs (up to 224 vCPUs atm) with
> up to 128 virtio-net cards, where each card needs a TX+RX queue per vCPU
> for optimal performance (as well as config & control interrupts per
> card). Adding in extra virtio-blk controllers with a queue per vCPU (up
> to 192 disks) yields a total of about ~100k IRQ routes, rounded up to
> 128k for extra headroom and flexibility.
> 
> The current limit of 4096 was set in 2018 and is too low for modern
> demands. It also seems to be there for no good reason as routes are
> allocated lazily by the kernel anyway (depending on the largest GSI
> requested by the VM).
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  include/linux/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 48f31dcd318a..10a141add2a8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2093,7 +2093,7 @@ static inline bool mmu_invalidate_retry_gfn_unsafe(struct kvm *kvm,
>  
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>  
> -#define KVM_MAX_IRQ_ROUTES 4096 /* might need extension/rework in the future */
> +#define KVM_MAX_IRQ_ROUTES 131072 /* might need extension/rework in the future */

I am not comfortable simply bumping the max.  Yeah, it's allocated on-demand, but
if my math is correct, the means a max of ~8MiB for the table, plus another 8MiB
for the tnries.   And when handling KVM_SET_GSI_ROUTING, KVM will have 2 tables
(old and new), and another 4MiB for duplicating the userspace array. Those allocations
are accounted, but that's still a lot of potential thrash.

And KVM's handling is also grossly inefficient, e.g. reallocating everything just
to change one routing entry is awful.  Maybe painfully slow updates are fine for
your use case, but some OSes have a bad habit of round-robining IRQ destinations
on a regular basis.

So it might be "free" in the sense that it costs you nothing to get your use case
working, but there's very much a cost for KVM in the form of technical debt that
someone will have to eventually pay for.

I don't have any concrete thoughts on how to make KVM's implementation less sucky,
but I do think we need to give it some attention before increasing the maximum
number of IRQ routes, especially before increasing it by 32x.

