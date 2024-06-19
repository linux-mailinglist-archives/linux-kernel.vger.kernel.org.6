Return-Path: <linux-kernel+bounces-221557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC9E90F570
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95920B227E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AFF155C94;
	Wed, 19 Jun 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AXDSTMfk"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846A41C69
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819281; cv=none; b=GHNrEzS4hKsXAveQpq7Iw1E+h9sZPcppfCQuBt6Ujl/VRymYo+G1jIuJ2t2zqITM7fQs2QXwdLwugzlrC506qCX7U+p+Ko72+nlXEvNmLMnjPbXAbDVTZuf4hdthMP6/OeNx197lm2Gz7i3gAW9gXRMJ1bgHwilHFZE5G6ACmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819281; c=relaxed/simple;
	bh=jnQNEtVezKGMuCelVhsIXdC8qmM0neatMpvt3Q3wYPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2Bg3ltPkuz2LhqX/PdTaBbyiZVo1vCKNNMiEXOG0rmFvTc0NSg0Ixv1SZzQnJUUWMunB7wZTJ7Oy5dZon2F1QXpoUTvbymnbSacMsnKDb11q9bLQvexbj9/H6RMruO5uEG//tUpmY02y2COHiZFu+1+KjJ37QLYvjwxr1OcSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AXDSTMfk; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mhocko@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718819277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I36DV95vqg3WqUSWDkFF1xu/gEicJbY8yx8D+wSVUZc=;
	b=AXDSTMfkK8VrfSMgByU0uszIDqYXPWzUNL7x80mmYOZFY2TVPKas1ocvhN7g8qXV8qpwiR
	WPoRoZJysjCsATvhAoEYNCJglBpDR0cCYsaZj+i7iAsAvH5l/evuh0x0ACe/KjLkni78rN
	WUpmDuKMt8vlWNQNxh2ZTCkAOpkhw1I=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kyle@infradead.org
Date: Wed, 19 Jun 2024 10:47:51 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <20240619174751.7r2s7iojxbaxpqlw@linux.dev>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka>
 <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
 <ZnKXNuuQRwNxRe4z@tiehlicka>
 <ZnKbR7IOd0b6GDBI@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKbR7IOd0b6GDBI@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 19, 2024 at 10:48:07AM +0200, Michal Hocko wrote:
> On Wed 19-06-24 10:30:46, Michal Hocko wrote:
> > On Wed 19-06-24 01:03:16, Shakeel Butt wrote:
> > > On Wed, Jun 19, 2024 at 09:19:41AM GMT, Michal Hocko wrote:
> > > > On Tue 18-06-24 14:34:21, Shakeel Butt wrote:
> > > > > At the moment oversize kvmalloc warnings are triggered once using
> > > > > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > > > > detects the first abuser and then ignores the remaining abusers which
> > > > > complicates detecting all such abusers in a timely manner. The situation
> > > > > becomes worse when the repro has low probability and requires production
> > > > > traffic and thus require large set of machines to find such abusers. In
> > > > > Mera production, this warn once is slowing down the detection of these
> > > > > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> > > > 
> > > > Long time ago, I've had a patch to do the once_per_callsite WARN. I
> > > > cannot find reference at the moment but it used stack depot to note
> > > > stacks that have already triggered. Back then there was no reponse on
> > > > the ML. Should I try to dig deep and recover it from my archives? I
> > > > think this is exactly kind of usecase where it would fit.
> > > > 
> > > 
> > > Do you mean something like warn once per unique call stack?
> > 
> > Exactly!
> > 
> > > If yes then
> > > I think that is better than the simple ratelimiting version as
> > > ratelimiting one may still miss some abusers and also may keep warning
> > > about the same abuser. Please do share your patch.
> > 
> > https://lore.kernel.org/all/20170103134424.28123-1-mhocko@kernel.org/
> 
> Btw. the code has changed a lot since 2017 when this was posted so it
> will likely need a lot of massaging to rebase. Also I am not entirely
> sure it is ok to change WARN_ONCE semantic like that anymore. Maybe we
> need an explicit variant that does this per-call-site warnings. It is a
> notable difference between library functions which can be called from
> different callpaths and those that are used from a single place. I do
> not have much time to dig deeper into this but if you want to take over
> then go ahead. I still think this is a useful WARN_ONCE or in general
> do_something_once semantic.

I think a separate variant like WARN_UNIQUE() would be better. I will
look into this.

Linus, please let me know if you have any concerns on the approach
Michal is suggesting i.e. a variant for warn once for unique call stack.

Shakeel

