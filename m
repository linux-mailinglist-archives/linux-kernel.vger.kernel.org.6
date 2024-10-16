Return-Path: <linux-kernel+bounces-366965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E941B99FD02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A663B246EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC086BA3D;
	Wed, 16 Oct 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNRxxStX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79F5695
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037833; cv=none; b=hDybUC4VsdHWPPKCZwk4/pH/RclpR/29o+Y4ZzaDnALDGBrefCYGjKwklHA4eEyosCCWE0GbYOmg4NkvhPljIUqsAZviLw/xMNPkCWKZ1Y/Ru5Doy5onTMws6dEYgA9nmE+HdrbcgW6hr0KQh/w7hdNple/iSSowoDzvFu0wC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037833; c=relaxed/simple;
	bh=Oi12u80iF5a5zrEGBQ+EomOdDgJDclTmP2OMI5Lmhfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j6GkAZYLxTphIX1zcd7KQWJ3NddzHeubGMstNlZp30zmR59vYpZZwkAq7oTozKIpqmOVh7q8HMC1rjMirLIILaJP/Ley6Tihp0lrnn9wgmGDhK5MUO1mUj1D++/mXvrvb68YZrhdkGFHo5xVBe649u4xnMFrSCFu53oh/2tx4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNRxxStX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4787441276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729037830; x=1729642630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIMG7wiGkBXbsz5ZL09Q+YNC60/nBpUsB21eUirnxYc=;
        b=nNRxxStXHWAFGxv+5gtbQLnMPMyFZ91UyL5+xZbbBfslz2fvvwyafOfJRK+wJ+M7WJ
         sP3OXVLBAkg/GNaOxiyEdrsE2NgytUY9EqEWwqzCscNHlbSgzrLzkjEtta1Czdb70EMt
         pU90AwSuDkSgzFJwtAmx4vT8eV8AFN+/oNdWoS6yx8F9p4qVhASSZD1fV+0C2Qye/Ay5
         HCUkHeUI1ARN/7gRgJQ7k4Y+/owICFcEqfdjXAA/EygfvzTUVjJeJBWFJrVpxPLQJ1u+
         K77WZ3NiY0qf6pHse3j9jw1ajOkDVkAc5LKM+WviEhuuFp/i/SqpiEr0+PFVPFeQBoJx
         jIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729037830; x=1729642630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIMG7wiGkBXbsz5ZL09Q+YNC60/nBpUsB21eUirnxYc=;
        b=t8ua7YOANZihCeu66fvMG8UgnY+4wHUjdv7XpePtfSCpG05zO0ff+Ge92MoO/WQZ4s
         cigKTjYRXt+O2hbmJYpHTyhluGjxlRIEAXctDJ9eZ9VJcOzEmjdhZ1jt99GjOMNpcPDm
         5A6RN0Ctadoznosg3QoN8MkZwmnon/nHUdvJLE8oFNE0ToA96eeEunYFbu/jlIo436Zw
         lIw9Cgx0aqvLEnP/obHFzJNTbmf/JyGXxmh29Pm2VYmRuyia1uCsQDUpLYFSrXcdFbIS
         74gY53jtbvlguAn0mWw9u76QXUBSLmAv3j09jh8UOjh2dNVrrxeM+bRRhALD442OEXJM
         EhWw==
X-Forwarded-Encrypted: i=1; AJvYcCVGmCZ5JY5k6t9CkHd7npSxBudS1XGNXTj344gBHsg4flJHjGA2b5vuXsTU7jZU6rBba0c6wGZt8jeK5TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZP1dIOyYQ6aFdMNaOFo3+SLZFu6A1F9bPzb2yKcweWHQc8Xi
	/UIslsvDepl7GsO5B+o9BSQSo3uSIefKVr1cakpnm3KiFpkAr4803eL5GVRy6GddQGYG1OtyHnT
	fJg==
X-Google-Smtp-Source: AGHT+IESdjRpRsglMZAGnwe25/AC94X0z+KtVW2TonxYtzy/w7rLciLkqmEjL7Nihu4PZvz6UnIexnCj2oM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:ad64:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e297830baadmr1006276.5.1729037829792; Tue, 15 Oct 2024 17:17:09
 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:17:08 -0700
In-Reply-To: <20240821202814.711673-4-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240821202814.711673-1-dwmw2@infradead.org> <20240821202814.711673-4-dwmw2@infradead.org>
Message-ID: <Zw8GBOtvNhPhSzuw@google.com>
Subject: Re: [PATCH v3 4/5] KVM: pfncache: Move invalidation to
 invalidate_range_end hook
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mushahid Hussain <hmushi@amazon.co.uk>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 21, 2024, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> By performing the invalidation from the 'end' hook, the process is a lot
> cleaner and simpler because it is guaranteed that ->needs_invalidation
> will be cleared after hva_to_pfn() has been called, so the only thing
> that hva_to_pfn_retry() needs to do is *wait* for there to be no pending
> invalidations.
> 
> Another false positive on the range based checks is thus removed as well.

...


> @@ -261,6 +239,14 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>  			goto out_error;
>  		}
>  
> +		/*
> +		 * Avoid populating a GPC with a user address which is already
> +		 * being invalidated, if the invalidate_range_start() notifier
> +		 * has already been called. The actual invalidation happens in
> +		 * the invalidate_range_end() callback, so wait until there are
> +		 * no active invalidations (for the relevant HVA).
> +		 */
> +		gpc_wait_for_invalidations(gpc);

I'm not convinced scheduling out the vCPU is actually a good idea.  At first
blush, it sounds good, e.g. why consume CPU cycles when forward progress is
blocked?

But scheduling out the vCPU will likely negatively impact latency, and KVM can't
predict when the invalidation will complete.  E.g. the refresh() could have come
along at the start of the invalidation, but it also could have arrived at the
tail end.

And if the vCPU is the only runnable task on the CPU, and the system is under enough
load to trigger an invalidation, then scheduling out won't provide any benefit
because odds are good the processor won't be able to get into a deep enough sleep
state to allow other logical CPUs to hit higher turbo bins.

The wait+schedule() logic for the memslots update is purely about being deliberately
_unfair_ to avoid a deadlock (the original idea was to simply use a r/w semapahore
to block memslot updates, but lock fairness lead to a possible deadlock).

If we want to not busy wait, then we should probably do something along the lines
of halt-polling, e.g. busy wait for a bit and then schedule() out.  But even that
would require tuning, and I highly doubt that there will be enough colliding
invalidations and retries to build sufficient state to allow KVM to make a "good"
decision.

If you (or anyone else) have numbers to show that blocking until the invalidation
goes away provides meaningful value in most cases, then by all means.  But without
numbers, I don't think we should go this route as it's not a clear win.

>  		write_lock_irq(&gpc->lock);
>  
> @@ -269,6 +255,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>  		 * attempting to refresh.
>  		 */
>  		WARN_ON_ONCE(gpc->valid);
> +
> +		/*
> +		 * Since gfn_to_pfn_cache_invalidate() is called from the
> +		 * kvm_mmu_notifier_invalidate_range_end() callback, it can
> +		 * invalidate the GPC the moment after hva_to_pfn() returned
> +		 * a valid PFN. If that happens, retry.
> +		 */
>  	} while (!gpc->needs_invalidation);
>  
>  	gpc->valid = true;
> -- 
> 2.44.0
> 

