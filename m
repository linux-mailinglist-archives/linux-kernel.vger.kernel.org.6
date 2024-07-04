Return-Path: <linux-kernel+bounces-240488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649A926E45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A5C1C21D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB918B04;
	Thu,  4 Jul 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ckQVvqLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D0A41
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720066668; cv=none; b=AxOwtBrAn3YzjVhGdoG1EBOiR19Dhz0kmeHfhmOSHuOx8kXD1fPgll/pzAHqaWFGLdtmPBm7x1QJSEpbySTf+koMUsKKn25qYi8W28t8Yg/BWMx2qlLtV6EdlzgNhGCWRLMNUuXOHfU8H92kk8Da6GjphDWrLMGEUpFYYXcSVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720066668; c=relaxed/simple;
	bh=MvX6R5LGq7R2mMtSy4fm+Mo0pdlHCKBxHeBLpb/gBZM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X/bIehmh1x4L1ODyoMoC6+djRwKMUHTLQp7vvXKme0mvBu7FdAnhJ+jsI2eOKO4ixVY/X/w7NuDM+jFX30EWPdIOMcoiA8HPi+zizOPJU1UUvWlfKS08Y51ETBbPpr7qfm9hzN9zeM8Xa3RzQzkYCr6fMRFtTJYUAMYz2Jb991o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ckQVvqLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3387C3277B;
	Thu,  4 Jul 2024 04:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720066667;
	bh=MvX6R5LGq7R2mMtSy4fm+Mo0pdlHCKBxHeBLpb/gBZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ckQVvqLKN9jGiKBjpoGUmuFgh/ye3+0SPJ4aKzYbKQW6C4f06vGPxS2SkKHVDGByX
	 rtTtPGe9E/+BdjMsKkTIMzktPhHvwCU4YrUEGJLsImzrBJRUPI1LIRmqbGs1h8x3G6
	 7HsruYqjoE//zLN5NL9iEGn92wTE8+WglgjeTBcQ=
Date: Wed, 3 Jul 2024 21:17:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
Message-Id: <20240703211747.97e7740df8c9d91de324c5ce@linux-foundation.org>
In-Reply-To: <CAJuCfpHvNjFQYU0zHOuang2mNOLNHHiNfaWACPWuP4mSMX_OmQ@mail.gmail.com>
References: <20240703221520.4108464-1-surenb@google.com>
	<20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
	<CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
	<CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
	<CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com>
	<20240703205415.de49467352601290c9fb27e8@linux-foundation.org>
	<CAJuCfpHvNjFQYU0zHOuang2mNOLNHHiNfaWACPWuP4mSMX_OmQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 21:07:56 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Wed, Jul 3, 2024 at 8:54 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 3 Jul 2024 20:46:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > Ok, I confirmed that the warning is happening due to the access to
> > > "current" from alloc_tag_save()/alloc_tag_restore() functions. I guess
> > > when these functions access "thread_info" variable:
> > > https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm/thread_info.h#L96,
> > > compiler flags that because the variable is on the stack of an __init
> > > function while alloc_tag_save()/alloc_tag_restore() when not inlined
> > > are from .text section.
> >
> > Well, is the warning legitimate?  I don't see why an automatic variable
> > of an __init function should be considered to be .init storage - we can
> > assume it won't become an invalid reference while the .init function is
> > executing?
> 
> I don't think it's really a problem. __init function is executing, it
> calls a function from .text (say alloc_tag_save() that was not
> inlined) which in turn calls get_current(), which returns a pointer
> somewhere inside __initdata. That should be fine since this can only
> happen during init stage. If this call happens after init,
> get_current() can't return a pointer from __initdata. If it does then
> we have a much bigger problem.

So I think you're saying "yes, the warning is legitimate and this might
be a problem, but it isn't in this case, so the checking code is OK so
let's just work around it"?


