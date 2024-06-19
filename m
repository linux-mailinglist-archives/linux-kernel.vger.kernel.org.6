Return-Path: <linux-kernel+bounces-220709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797CB90E5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D004A28341D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA157A158;
	Wed, 19 Jun 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kwr3YvHq"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E675FBB1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786243; cv=none; b=IWaYtPFp+vTTzU96v4nCzYJNTTD6ILoLillnb2VXQj11mVGWz8S+Or+PZzFYzyD3o9MnH+3S1N60hkDicd8ylv+YFamFfR4NpiHH0SpuMvHP57Zm/0jpEL6G65Zi0hGm2BdQF7Rs2NQwTTGoJKQq39Uys0F+yasDPhc4Y+wHqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786243; c=relaxed/simple;
	bh=BHEK+UuXHETOtR8n/yrUW0gSo/V81ImKqFkQv+oPdgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVJohYlee1Ih257YTpd1P1qXe3ccSLbKYZI8u+N5r/g4gRMLS65N6UoSeZhPzTYYHKEbsa2ReJTWejX5LgQZofoIa2E5/8kO7Yp7Ch2sqm37Qwusx6xH6h2AWOTYPsF5GedgtHu/thQS0qGqH6pgI9k/UpOBgRaTSLAS7x1Wuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kwr3YvHq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mhocko@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718786239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7numITJvHh+6j+se1peXK1jwyYEH767i6dTlNLJqsIE=;
	b=kwr3YvHqA6Igf+xN+cml8e9jMR26AWvOSTrxTCj4bFrIAccwuh0IBOpvmplT4hpQw/gqom
	zQG9XcIwmLAqTDZexaFxu6aoXsmcNK76kewr9xEox2YGqbvWtRsin34pDn8eyJifTxs5+L
	IAzMt27o4HXfF3w5yhHtSxvYDRoHAMw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kyle@infradead.org
Date: Wed, 19 Jun 2024 01:37:16 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <5xkoffvdpruisl2fo2wg4e5vof6ajvlszhohp2lcyr5ysv4nk6@yuqpqchnaxmi>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka>
 <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
 <ZnKXNuuQRwNxRe4z@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKXNuuQRwNxRe4z@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 19, 2024 at 10:30:46AM GMT, Michal Hocko wrote:
> On Wed 19-06-24 01:03:16, Shakeel Butt wrote:
> > On Wed, Jun 19, 2024 at 09:19:41AM GMT, Michal Hocko wrote:
> > > On Tue 18-06-24 14:34:21, Shakeel Butt wrote:
> > > > At the moment oversize kvmalloc warnings are triggered once using
> > > > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > > > detects the first abuser and then ignores the remaining abusers which
> > > > complicates detecting all such abusers in a timely manner. The situation
> > > > becomes worse when the repro has low probability and requires production
> > > > traffic and thus require large set of machines to find such abusers. In
> > > > Mera production, this warn once is slowing down the detection of these
> > > > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> > > 
> > > Long time ago, I've had a patch to do the once_per_callsite WARN. I
> > > cannot find reference at the moment but it used stack depot to note
> > > stacks that have already triggered. Back then there was no reponse on
> > > the ML. Should I try to dig deep and recover it from my archives? I
> > > think this is exactly kind of usecase where it would fit.
> > > 
> > 
> > Do you mean something like warn once per unique call stack?
> 
> Exactly!
> 
> > If yes then
> > I think that is better than the simple ratelimiting version as
> > ratelimiting one may still miss some abusers and also may keep warning
> > about the same abuser. Please do share your patch.
> 
> https://lore.kernel.org/all/20170103134424.28123-1-mhocko@kernel.org/

Do you want to propose this patch again (after rebase to latest) or
should I take over?

