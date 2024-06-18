Return-Path: <linux-kernel+bounces-220266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032F90DEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9040C282125
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5C8178392;
	Tue, 18 Jun 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vz7l7V0c"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55915EFAF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747099; cv=none; b=TlLbMinO65ZOGO+7plq/LMR780j+Cw8c4Zp+nNtPHVfXIOFsHNgduSIXsqn5foGhfoQIJvRsWrQrdPqudw2RTvFykCnZKSd7gQBHUT2r2oUo3MvQcOlvc27CKvZOVOo5Q9OUeCaXsyisntKloPHNKgaf475IDDAxaX3r6+kgWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747099; c=relaxed/simple;
	bh=gId4orCa/JOXK3q3Kck/VFy0ePAe2kz9NpyEEWCDqtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYCQWkrtVaFyVQxbYpBqgd1DGfGmdTOsCMUf8sSxtYd3lw9a3FG2M8scmTIcP+K1cWrCiVRjxKcUmC7yuegtDDeB3KJbAgt0qZJhKgrhKR9glp1ZE5LDroZ7ImscQbaUlA2lWPn6kpzqMIPCyTvN4eK+W3dp3IIEHcjLTI+7mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vz7l7V0c; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718747095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sl3r7qFXSTfIPLR6mrssV5UaH6X9IXUMqBHU7WeHJiA=;
	b=vz7l7V0cdcctJxk18BaT07puv2bpFnkpUzjI8VF23NSsUxJIADWGEbrhzaU1rwqRhcVD4U
	ib04qbRyhfEIIGF43Q98gfZNJfgfnh1Xn/R5eUQkIQrOxRsMAuxNWxJqLIqT5MSKooNCF3
	CL8wvyat2gK4h/VlaebogM3Wfu9DUk8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kyle@infradead.org
Date: Tue, 18 Jun 2024 14:44:50 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <y3gigynfp23mzrhcflt6hpna4hwphetyt6azwhsv2rblaklzat@jtandhtvbmdi>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <CAHk-=wh97fGxpyzKTUCrug_uhrLHJHh5W4wLbLkZ9cJSFh7RHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh97fGxpyzKTUCrug_uhrLHJHh5W4wLbLkZ9cJSFh7RHQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 18, 2024 at 02:40:10PM GMT, Linus Torvalds wrote:
> On Tue, 18 Jun 2024 at 14:34, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> 
> NAK.
> 
> Sadly, the RATELIMIT cases are useless.
> 
> The normal rate limiting is basically "burst of up to ten, every five seconds".
> 
> That's going to completely swamp things and hide any other issue.
> 
> If we ratelimit it to "at most 1 per hour", maybe something like that
> would be acceptable.

"at most 1 per hour" sounds good.

> 
> But honestly, I do not understand your "first abuser only" complaint.
> There should not be *any* abusers. So just fix that first one already.
> 
> If you have more than one, you have bigger issues. So what is the real
> reason for this broken patch? Why didn't you fix the first one?
> 

The issue is the turnaround time to fix the first abuser and deploy the
fixed kernel to big enough fleet to find the remaining abusers. Usually
this turnaround time is in months.

