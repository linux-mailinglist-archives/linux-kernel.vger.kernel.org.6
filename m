Return-Path: <linux-kernel+bounces-240550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6697A926EBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C01F23163
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552984204F;
	Thu,  4 Jul 2024 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vOVDrwxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56460747F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720070221; cv=none; b=qzRzzt2KYoTCgD9eTWfqkgfhMpynRC9yH35rNm04pBVyWFl/N5sVt/fA2OOOqTz4LsbjrZ7WpkrOOTCNYWI2Cc/S6AtTPTKWw0kbpzi0BA+oo328IrXwxIECZ/SCYjo3q2Qav0QK5SxvV70HJM5uoxmERmvvwp9mRLlGd2nPNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720070221; c=relaxed/simple;
	bh=NxIBgDf8lY7/9rluvoBPS1mXccymCe9/5oaD4lp81T4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KKwI6xMntuxkRDSyLQ5FYi7a5mJ/LZcGaKJH9Ye4572dwjII5L1Cjxqtl0bMJ+z6PNYNXoL7VMzLP42DnQaGUFft8DJ+7h9uXawDlklLF0iccC5L86JkzuNR3CbWSVH39D7ybADVfLwnT769w9Du5VCfoeEMqy6iyeE2Cz2pB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vOVDrwxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D4DC3277B;
	Thu,  4 Jul 2024 05:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720070220;
	bh=NxIBgDf8lY7/9rluvoBPS1mXccymCe9/5oaD4lp81T4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vOVDrwxc5jeYT2v2IXqBSPB+/5bScmMuv2kGE+QYnuhCP+Np+L118H8y12iKOX5SX
	 umk49LVkEWARzgQL7ANeyCJG1khdM9E+SvGd1wqRiGbHCj9FP/oOKrO/YRL7tqxGPF
	 sAsw6P2Fv0PEeVHLCT7O0GdzJS+FCFI96WGwBfRo=
Date: Wed, 3 Jul 2024 22:17:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
Message-Id: <20240703221700.dd699b48a395bdc27ddeb827@linux-foundation.org>
In-Reply-To: <CAJuCfpEO3Lo9EZGQtdPUeyycbNwqJ7zvHq2N9nzd_Cc6pARchw@mail.gmail.com>
References: <20240703221520.4108464-1-surenb@google.com>
	<20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
	<CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
	<CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
	<CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com>
	<20240703205415.de49467352601290c9fb27e8@linux-foundation.org>
	<CAJuCfpHvNjFQYU0zHOuang2mNOLNHHiNfaWACPWuP4mSMX_OmQ@mail.gmail.com>
	<20240703211747.97e7740df8c9d91de324c5ce@linux-foundation.org>
	<CAJuCfpEO3Lo9EZGQtdPUeyycbNwqJ7zvHq2N9nzd_Cc6pARchw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 21:25:30 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > > I don't think it's really a problem. __init function is executing, it
> > > calls a function from .text (say alloc_tag_save() that was not
> > > inlined) which in turn calls get_current(), which returns a pointer
> > > somewhere inside __initdata. That should be fine since this can only
> > > happen during init stage. If this call happens after init,
> > > get_current() can't return a pointer from __initdata. If it does then
> > > we have a much bigger problem.
> >
> > So I think you're saying "yes, the warning is legitimate and this might
> > be a problem, but it isn't in this case, so the checking code is OK so
> > let's just work around it"?
> 
> Yes, that's my understanding. If get_current() always returns a valid
> pointer for the given execution stage (during init/after init) then it
> should be safe to call it even from a function residing in the .text
> section during init.

Make sense, thanks for confirming.  I'll await the v2 series, if
you think it remains appropriate?

