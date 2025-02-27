Return-Path: <linux-kernel+bounces-535674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA15A475D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297AC188EB04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B282192E7;
	Thu, 27 Feb 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aFoFfPFj"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32553E23
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636510; cv=none; b=JV9cQsOYPLGWTgMEsx5nzf2wTm6AbvXA5mVG5YcRMqT2gSd1wSyZP647FX3av5FlmrfYviDjnhGRwELiuTRhAotyAQmjpYOwkMjhPC9E+AOvCGQ7Y8Wiq83y9mhdWfu/6MU3SFnRcONvt7/sfaSWxmAcj65y0JlW0XOt9vFcFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636510; c=relaxed/simple;
	bh=9qHQwG/jH4v2hSOB5u9qYkiVsAp/QLoX8s57aRwldGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IajY2ZDjVt6wDhNbNMrurgjvfyxdGIWAVJsE/q5Gp1HSFySoMCbkMF1Cl90lWPSUxOgEwlWyXbPWvGbwmCduz+0auK2oIRBlWU0jqqyj1nqzz6oh4YSP0/65aY69CUG+q/3COMrLhCggfMN3RlIhxfKt9KL3KPNArmiyjZv9TcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aFoFfPFj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471ede4b8e5so2776501cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740636506; x=1741241306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPz1Jtb3iDmlzLw3YyOfEPl0dmoA/8jm1qHrEBiYBV8=;
        b=aFoFfPFjK08FhidN+/lzzH5pohCdgCpU7FAegOQmrWdJoORIAm0Y0LIdtjrlJHzguA
         nyNcVjxsBYlFThLjL9sZIS8X2lQlGOFcqEpUB+LLHhJEsroE5sYKQLlXDtGKgFRog8eL
         BJeyc+6IlMp3X04WbsNX+DWYWvZTGMosLN2R3pnc0odK0i0CDVF3PTC3JzWDLq1x+512
         7N2/vsfwkQrJs4DZelIemVU6158HQ4Awa7yAxXgaeBXxi+di3hZRF5XIxWizg5886zdr
         VNB40Rp7dBc9rTJusv4kPDUt5aGZ4H1CgTXN6Uu3guhERr2m5VM3ikFV10BFtTCtUfw+
         pfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636506; x=1741241306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPz1Jtb3iDmlzLw3YyOfEPl0dmoA/8jm1qHrEBiYBV8=;
        b=ARUYqFZyZQ+FtaGc3yWG+hB5+SW5eYVvwfTXMbD1XJk2+HfXKwe0OyS1HRkPnfSYTo
         IkU9y6SpQmqu5X4KTZHtFRO9VVIVWCzzGqvlc36KYGfuL3iYe0RZQ6Gt/1Bbnt4ePlvq
         /5zDrjw4Pvp+6lWvFh8fp8k30pmkhx3jntPrG+6X6vx2IM6aFpc8V70/mpgkU5i2fbn2
         GND6ttKz7etdlcBkGaXpOJSSHb6ln5ILbc5WIsWJmYkqpfypVIsqsUaePLQXXErdnDbj
         LmSv9d6wJpHkwJeFGdIBRkyAbc61unhLXx7xO++04QMXdkWDtsC0odNTU43ox6i1fRio
         z5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpGhZ4lkp4ssQEc/YJhjViHCi4jFxSSlVaYJ7pnFIpkk2EnSvxjEfjoP8+8pKaixjdpckWAGiU2uYk6Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY8fn/6OIKoNXROA6EJ80obASC9nrR8gpa97WnT8sZ9OH3CxZ
	t14N28DOYGwBCTPyFqPl+QAw1sJNeFfVrmV0ZkEAIhudmtPLNZR0qa0MM+KuTxLJbJuolddYFgs
	U
X-Gm-Gg: ASbGncveAEjL30nByM+wJIf4iRHVb/BRUQn/eb11tQDiJLyQcxdMs3KNhQ2yycMpETv
	DOh13ZbbQsjUqCVU+EGxdsuijNeZG05sLkU1sEJaAyZvGOqvPs1edgXR6rDLSNUconwfxyq667M
	DPGnSGvf2+XEaRp3qqU/WcQyYyxxase50fIjJU8/jTUqwz4M8/f1VwmWfckTVJtdjX0WMAi1Jck
	3YlxRIWljIsjp1NoLW/IYzulyiFS/9z9ePaS3TDlrMOQ2i7cfletXwGz+pIsQyBd8W+CbfvMccS
	qVrpeRa9TI7BTxNPn6162Zst
X-Google-Smtp-Source: AGHT+IHh3l/pbd4U+HZO31M9X7egjzLQA2am+j8f66WkAfpl/b+8JFLXkEalx8BJVXBHXv/+SxiZdQ==
X-Received: by 2002:a05:622a:24c:b0:471:ef27:a30d with SMTP id d75a77b69052e-47381365f87mr79384461cf.40.1740636505919;
        Wed, 26 Feb 2025 22:08:25 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a1f2csm7429221cf.13.2025.02.26.22.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:08:24 -0800 (PST)
Date: Thu, 27 Feb 2025 01:08:20 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PT_RECLAIM
Message-ID: <20250227060820.GC110982@cmpxchg.org>
References: <20250226183013.GB1042@cmpxchg.org>
 <a77923d3-ce26-4e29-bb98-b908ce2355c2@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77923d3-ce26-4e29-bb98-b908ce2355c2@bytedance.com>

On Thu, Feb 27, 2025 at 11:04:51AM +0800, Qi Zheng wrote:
> Hi Johannes,
> 
> On 2/27/25 2:30 AM, Johannes Weiner wrote:
> > Does PT_RECLAIM need to be configurable by the user?
> 
> The PT_RECLAIM will select MMU_GATHER_RCU_TABLE_FREE, but not all archs
> support MMU_GATHER_RCU_TABLE_FREE, and even before Rik's a37259732a7dc 
> ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional"), x86 only
> supports MMU_GATHER_RCU_TABLE_FREE in the case of PARAVIRT.
> 
> Therefore, PT_RECLAIM also implies the meaning of enabling
> MMU_GATHER_RCU_TABLE_FREE, so I made it user-configurable. And I just
> thought that as a new feature, it would be better to give users the
> ability to turn it on and off.

New *features*, yes - something that has a significant enough cost
that clearly not all users want to pay for the benefits.

But it's hard to imagine anybody would WANT to keep the page tables
around if they madvised away all the pages inside of them. It's a
great optimization, what would be a reason to opt out?

> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 2761098dbc1a..99383c93db33 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1309,16 +1309,9 @@ config ARCH_SUPPORTS_PT_RECLAIM
> >   	def_bool n
> >   
> >   config PT_RECLAIM
> > -	bool "reclaim empty user page table pages"
> > -	default y
> > +	def_bool y
> >   	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> >   	select MMU_GATHER_RCU_TABLE_FREE
> > -	help
> > -	  Try to reclaim empty user page table pages in paths other than munmap
> > -	  and exit_mmap path.
> > -
> > -	  Note: now only empty user PTE page table pages will be reclaimed.
> > -
> 
> Maybe keep the help information?

I don't find it very helpful :( Which "other paths?" It doesn't
explain any pros and cons, and why anybody might choose to enable or
disable it. The Note repeats what's in the sentence before it.

Maybe I'm missing something. Could this not just be an #ifdef block
inside mm/madvise.c, instead of living inside a new file with two new
config symbols?

#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
...
#endif

Is there an arch-specific feature that it requires besides
MMU_GATHER_RCU_TABLE_FREE such that only x86 supports it now?

And why *does* it require MMU_GATHER_RCU_TABLE_FREE?

Documentation/mm/process_addrs.rst explains why you need rcu, but
there is free_pte_defer() that THP was using long before x86 needed
MMU_GATHER_RCU_TABLE_FREE. It seems to me if you could use that, this
feature would also work fine on architectures that do not generally
need RCU for flush & frees otherwise. So is the main issue that there
just isn't an explicitly deferred variant of pte_free_tlb()?

If so, this is a fairly non-obvious dependency that should be
documented. It would help somebody trying to port this to a !RCU
mmu_gather arch.

And I apologize if all this was discussed before. But if it was, the
conclusions should be in the changelog or in code comments. This is a
very delicate synchronization scheme that I think deserves explicit
documentation somewhere.

