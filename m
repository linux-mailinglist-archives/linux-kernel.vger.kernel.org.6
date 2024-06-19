Return-Path: <linux-kernel+bounces-220663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B605990E528
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463ACB2357D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04678C71;
	Wed, 19 Jun 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NEnCXcDV"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AEE78C62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784205; cv=none; b=bBQdo3q7o0DRdY92lJQtIFqp2wX0E0dj8n6RQtZ8h9yRYQIO+dzQfZz1zQ6xNnE/OBMqEPjM9PBbsbrNfV8fhTAktCAl70O26OUM+8/bkpoxfEmyPHxrP/Tce9MH3mcDcTmddBzyBqgiFx+43IArr1k3indD9+mF9YR7GcczNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784205; c=relaxed/simple;
	bh=zf6+eJ5kAOjk6f/rMxFO6vwhbf3l6uqfDo9iY5kLruY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2u6b+VOi1C9UDxfPNI36kP/NMgFIRqcsQMCafYf9R9M/fkJc6zNTxzYDu+/kwL+9wulfuDoMDoeh+qg53Qm1l2jI5PLcinCu3s3ehDuizGUnqv8mhxaDUCSBe+9IN/YLDUm1pRffiWWRXzRCdL0RG8n2leelmyAghANvazVFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NEnCXcDV; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mhocko@suse.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718784201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8L+tqoaWJl1XwNkhBVVMTi0+mCHVQ9FGNyYAra2Ol1s=;
	b=NEnCXcDVag/2SJT2OM5h0I6lAS1C9ug+nsa8AnNRWNCEzjq+SGJSiXWm04splwx2xkewGZ
	DjYYr9kiLKtcPiv6jS7wlHUc0/X1BNmoCe7hCVX1mLFJEmsuFCFHouSvSrdXBIdKhsYVlw
	OP99D4PhPZaHMFBFCafWoJL60mLscdQ=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kyle@infradead.org
Date: Wed, 19 Jun 2024 01:03:16 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <ajp536dpkss32kmjihcfbl4ulunfho2odzw4ghwfekw2yv3ctt@fh62fmyxwwcs>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <ZnKGjdw8xkMZG0oX@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKGjdw8xkMZG0oX@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 19, 2024 at 09:19:41AM GMT, Michal Hocko wrote:
> On Tue 18-06-24 14:34:21, Shakeel Butt wrote:
> > At the moment oversize kvmalloc warnings are triggered once using
> > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > detects the first abuser and then ignores the remaining abusers which
> > complicates detecting all such abusers in a timely manner. The situation
> > becomes worse when the repro has low probability and requires production
> > traffic and thus require large set of machines to find such abusers. In
> > Mera production, this warn once is slowing down the detection of these
> > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> 
> Long time ago, I've had a patch to do the once_per_callsite WARN. I
> cannot find reference at the moment but it used stack depot to note
> stacks that have already triggered. Back then there was no reponse on
> the ML. Should I try to dig deep and recover it from my archives? I
> think this is exactly kind of usecase where it would fit.
> 

Do you mean something like warn once per unique call stack? If yes then
I think that is better than the simple ratelimiting version as
ratelimiting one may still miss some abusers and also may keep warning
about the same abuser. Please do share your patch.

Thanks,
Shakeel


