Return-Path: <linux-kernel+bounces-374920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6409A7203
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936191C224AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFEE1F9A8F;
	Mon, 21 Oct 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRiQBRdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5471991DB;
	Mon, 21 Oct 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534242; cv=none; b=riLPWNCF737ghym+XUrfJrBva7LPFBkMyRtZk47Gc3u7TaaRHqPRh4eHw1su/WWCyENRJpTg90vDDyReVEF24Fm+RxS4GkEGiHZKREezVW417cNdRvquJH0voLHY43oJRH7X9FkjmUfOlNsdz/D4Q4+kmPuAh4I3moUqMrmR7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534242; c=relaxed/simple;
	bh=CBgC9eWkV9C9p3t76X8O0OvYkMZi+9HgKwTurKO8Pns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1zbga/8fC9gEXXMT7IgoQ8RNqUAD9UB0OmPS60DXtVoBLJWIwY206UrD12+07oVfUuwqDDdvocs9nrIF3Mm+G2ajjbTrNfJY7Ob6rA91+7nB1OrxjXs/QxG8mWg0GsV+FcZeGxKAXVYNBy3eTck9tY6UB7VG9Vfsb4S92tiq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRiQBRdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE5CC4CEC3;
	Mon, 21 Oct 2024 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729534241;
	bh=CBgC9eWkV9C9p3t76X8O0OvYkMZi+9HgKwTurKO8Pns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRiQBRdgAloQ7YO3QTyu2FqW6F38NLSc+H1/ZClGxfOyd5PWmuDWM5ruAYyxRWVAG
	 3iZD3oYMnbslxRMvxqt1hZIsaYTfUr2D+6SMVJQGSbm/nsi20st7+mF5Lr/88iIF6f
	 hkz1Ir2as6HZg25Dkp3w9mfHf77gJHvFRVsVVN9Nbu+2l1/iUaTqqFc3/WT17p8IpA
	 C2ThGIfcDHYzB9gUe0m7giC8ZRo6442Kxw8uSXVR85ckdLyEXO0cMnHzTGl8fxGwa5
	 IeqEOTDqE+mjJ+eElZbxPi18/F4MEgrba15JZ8UKPQ8WyW322Jlp9FDYapKDmczu4b
	 lw28GMvBpL2GQ==
Date: Mon, 21 Oct 2024 11:10:40 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxaZIJh61cM3fI76@bombadil.infradead.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <e27ab2c0-ddee-4fc2-a41e-70b4a7775127@acm.org>
 <ZxaPnk-uC7-A-f_e@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxaPnk-uC7-A-f_e@sashalap>

On Mon, Oct 21, 2024 at 01:30:06PM -0400, Sasha Levin wrote:
> On Mon, Oct 21, 2024 at 10:24:53AM -0700, Bart Van Assche wrote:
> > On 10/21/24 9:07 AM, Sasha Levin wrote:
> > > Current testing:
> > >   - LKFT: https://qa-reports.linaro.org/lkft/sashal-linus-next/
> > >   - KernelCI: https://t.ly/KEW7F
> > 
> > Hi Sasha,
> > 
> > Is blktests included in any of the above? If not, please consider
> > including it. During the past few years we have noticed that the
> > test failures reported by this test suite are most of the time caused
> > by kernel bugs. Sometimes issues in the tests are discovered but this
> > is rare. See also https://github.com/osandov/blktests/.
> 
> Hey Bart,
> 
> I don't plan on doing any tests on my own, but rather have our existing
> CI infra (kernelci, LKFT, etc) deal with the actual testing part of
> things.
> 
> AFAIK KernelCI if working on adding blktests support!

We can automate blktests with kdevops today, if that's desirable let
me know.

  Luis

