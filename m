Return-Path: <linux-kernel+bounces-520093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A7A3A59E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B9163531
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F11684A4;
	Tue, 18 Feb 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT2G3Ujk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972392356C2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903470; cv=none; b=rcxyd2VLI0ArhPc5DsqPCdWVbYpYvIc+BpvearQYbGKjM3Vv+IoEW8q7u1m9cGsKaeZN0RWY5Mf+GSrd6OtViJXxPQBlwvSRZy/BP3M2+dapepq8DO++Ji0PjAlW+AlMKJ1WocMzY+zlTCy4CZC0okIM4bDhRpuZRS+mWLGgtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903470; c=relaxed/simple;
	bh=+LPVHWyDaUixco2SPXwXJBNg92wgfmhIb1Lrq1bCkxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0CsdxEEFrN4mYct8W8MN//OuHcXVQXcCgX6Yj2HUWx6HphDfm4v7tH6ezO6FpjYHn7QVAYI5wxec4WE7S1zEhF8wWzzY8dmUFqnEPOIC5NdyzDi/FqGLsei73JCIlGwSbt36FonADd70Do/p1FypeXTESTBSbR565iE3oLHTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT2G3Ujk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4555C4CEE2;
	Tue, 18 Feb 2025 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903470;
	bh=+LPVHWyDaUixco2SPXwXJBNg92wgfmhIb1Lrq1bCkxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tT2G3UjknM8dWWKwZoogXaZwUJeNo6H353XD8wbZm6uvPLnPhZTNaL2pIeAc+8/LB
	 +t5uN02t+iFjfVjnIXeLKgQ5tQ1dNuCOQqqr2W/isbLDVKR2CospAf8Kk9bRDsWW4G
	 3GCquKP/iJ0UsewjOe3Twsgs8LNnVkpXOx7AW5NVUtuAuHWeI2+VqMMgoXsgGbcsiI
	 psDMtjEOxvAwhlZLJs99xSQlA8IdOL6LgAXiMgO8cwvJuX6CvPgBhgkjhKEMqJ+eZk
	 CloyTXAxmtxIvQZzK7ZVfuXg5/q/+4r2/hZl+NojhPj1FDK1rGiI1z46SOeugPGRbA
	 4CMGRVik+0tgw==
Date: Tue, 18 Feb 2025 10:31:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
Message-ID: <20250218183108.anuqoojsgkjxwfai@jpoimboe>
References: <20250218092538.1903204-2-ardb+git@google.com>
 <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
 <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com>

On Tue, Feb 18, 2025 at 06:44:23PM +0100, Ard Biesheuvel wrote:
> > If I understand correctly, this is fixing an existing bug in loongarch
> > and any other arches using PIE, right?
> 
> There are no other arches using PIE as far as I know. But it indeed
> fixes an oversight in how -fPIE is used in the kernel.
> 
> > And it has nothing to do with
> > objtool?
> >
> 
> That didn't stop you from taking the previous fix :-)

The whole point of the previous fix was to fix a bug in the objtool
annotations.  Unlike your patch, it didn't have any intended side
effects.

> > If so, it feels like this needs to be its own patch, described as a fix.
> >
> 
> Fair enough. But better to drop the previous patch from the objtool tree then.

I think we can do that... Peter?

And just to be clear, you'll have two fixes, right?

  1) Make loongarch .data.rel.ro.* actually read-only
  2) Fix objtool C jump table annotations for clang

-- 
Josh

