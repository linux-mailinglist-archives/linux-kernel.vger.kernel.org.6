Return-Path: <linux-kernel+bounces-234647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE791C8FD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C74928242D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FDF80C07;
	Fri, 28 Jun 2024 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZoTPtvXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F677F10
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612956; cv=none; b=bya2mdcmLSp5E+iNiPO7W8+RcXvE2/MZmOpzTjeOb92Dy3QBk485e4DLySFUhcwD4Hpoqbujz8gLvmM5mKnSx78jubU4bZ3MUk4GGlv0K6SAA+8GQg8J1qUWcOtShD45/bBaduDEq9XGVtW2Vl3b44Wd6f40yL+6BIzrJt75T2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612956; c=relaxed/simple;
	bh=9JiG+W1RoitdV4CQAEh6Mi32SytrVqC36+nls2G9Qek=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tMJS/+NtJGlsPVsn8pWlJ4SwT95yqqen+n5+PbGL1pt9/n04ooXmFy7ezPX4JYTZkJ5LMJEF2gl0mtrvImYqMP4ZX9oT4jpSSmDwQ57MNhR2XUKzV8JrLdObugPa93i3c0KaJ8qdBGbkOB6fr9HsHXRHm5cXHvm8N3q0GtjTI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZoTPtvXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D11AC116B1;
	Fri, 28 Jun 2024 22:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719612956;
	bh=9JiG+W1RoitdV4CQAEh6Mi32SytrVqC36+nls2G9Qek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZoTPtvXlKXAgBI4OWehhvEQg8KTwVhpwKAscV+OxTLH1OI8Kr4Qv1WUQucNFZC8xQ
	 JAroWpTWN2KpWdfv1g/+Jl4cmnhnqVnaHfRmzAsbHN6+7mYeL1u54qT0mOH4Bt6YjP
	 u4EizRJMUE9khRwMJm01ocYCxZ5SqfEYin6wCIIA=
Date: Fri, 28 Jun 2024 15:15:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mul_u64_u64_div_u64: make it precise always
Message-Id: <20240628151555.93232b84d1135ad96066471d@linux-foundation.org>
In-Reply-To: <9nr61164-o95o-s47s-33sq-ss86499p6sso@onlyvoer.pbz>
References: <39o9pnn4-p22s-rp4p-067n-83s18o5prnpn@onlyvoer.pbz>
	<20240628142025.50ac4c92bfd2034668a0cc22@linux-foundation.org>
	<9nr61164-o95o-s47s-33sq-ss86499p6sso@onlyvoer.pbz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 17:46:33 -0400 (EDT) Nicolas Pitre <npitre@baylibre.com> wrote:

> On Fri, 28 Jun 2024, Andrew Morton wrote:
> 
> > On Fri, 28 Jun 2024 15:06:20 -0400 (EDT) Nicolas Pitre <npitre@baylibre.com> wrote:
> > 
> > > Library facilities must always return exact results. If the caller may
> > > be contented with approximations then it should do the approximation on
> > > its own.
> > > 
> > > In this particular case the comment in the code says "the algorithm
> > > ... might lose some precision". Well, if you try it with e.g.:
> > > 
> > > 	a = 18446462598732840960
> > > 	b = 18446462598732840960
> > > 	c = 18446462598732840961
> > > 
> > > then the produced answer is 0 whereas the exact answer should be
> > > 18446462598732840959. This is _some_ precision loss indeed!
> > > 
> > > Let's reimplement this function so it always produces the exact result
> > > regardless of its inputs while preserving existing fast paths
> > > when possible.
> > 
> > I assume this was tested with some userspace harness?  It would be
> > interesting to see that so that reviewers can see that suitable cases
> > have been covered.
> 
> I do have a user space test tool but it isn't pretty looking.
> How should this be acceptably presented for public consumption?

Well, the fancy way would be as a new lib/test_XXX.c.  There's a ton of
precedent for that.  A less fancy way would be to paste the code into
this email thread ;)


