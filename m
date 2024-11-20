Return-Path: <linux-kernel+bounces-415074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9F9D3142
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4A3B23994
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282665258;
	Wed, 20 Nov 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNmtWRmQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B63D76
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060930; cv=none; b=WVWylPfuPVet5TTK6MKSVix3iTF/qa/ZwHd1acd64xHPWm+/UDEDq+0M8gygV7S8pSaORqj3r74FxNdiKucHoZF/3ysy2uQfw+3bfjL9p/GTaEB6qAbIezCUmYlmqL8UPNuk2tq5ZpkWDrQ1rZ+jRved3NRGKX61We8IqJHYfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060930; c=relaxed/simple;
	bh=6eSbAl5FxUhHK1DKcGvLpF4HXeWf54bvNabH8TdZgBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMdv/8mcZOlUqySrqNC2VPnSAQUVaTneRTWFFJTAypNhoaNoEF65XmyjhedCJPUy2CpclnoNpWpOMku866n0g2cyMvzawid4OxQhNZld1gSgQOLv3Qe0xkPC6cPkyuBC5wu7yhB46R/QbA4xKMsm2zhReadw/CqUR8GAUMS5Yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNmtWRmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE6BC4CED7;
	Wed, 20 Nov 2024 00:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732060930;
	bh=6eSbAl5FxUhHK1DKcGvLpF4HXeWf54bvNabH8TdZgBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNmtWRmQwCCbcH4y9iyi3y77wGGr1YM4u69EoeDhV9j90w1iDxPe1EqHVm0XoAtG7
	 vHV2OexSRT+WAq2KX72cjJczkoO3iUk+V0bMar7lBjfPOh22Bz5M/8eSGaKTh4QwKv
	 Mue7yHz8SR4hQZygO5B14Ylk9WKpYrRg9GVFf8lWEUOtiLF8T98WtKWNyQy+d0s2gu
	 up4Jhk3m3pVUlwD3WGBfH+sze2/nBwk4EoX14Z9sqXK1p9lCVwAv3ZvlZYYvI2gtW8
	 YZzJLZZtez/iPHBURYJC31T/6QRLF0L0S3Hsn0s5xjpZmxyN97k6lH1HTImfmGpyHt
	 hoQVRFFZl7xMg==
Date: Wed, 20 Nov 2024 01:02:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] locking changes for v6.13
Message-ID: <Zz0m-19axUhZb_1w@gmail.com>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
 <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 18 Nov 2024 at 01:03, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - <linux/cleanup.h>:
> >     - Add if_not_cond_guard() conditional guard helper (David Lechner)
> 
> I've pulled this, but I'm unhappy.
> 
> This macro generates actively wrong code if it happens to be inside an
> if-statement or a loop without a block.
> 
> IOW, code like this:
> 
>     for (iterate-over-something)
>         if_not_guard(a)
>             return -BUSY;
> 
> looks like will build fine, but will generate completely incorrect code.
> 
> Honestly, just switching the order of the BUILD_BUG_ON() and the
> CLASS() declaration looks like it would have fixed this (because then
> the '_id' won't be in scope of the subsequent if-statement any more),
> but I'm unhappy with how apparently nobody even bothered to think
> about such a fundamental issue with macros.
> 
> Macros that expand to statements absolutely *ALWAYS* need to deal with
> "what if we're in a single-statement situation?"

Indeed - sorry about that, will sort this out tomorrow.

Thanks,

	Ingo

