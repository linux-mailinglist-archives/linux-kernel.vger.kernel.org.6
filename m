Return-Path: <linux-kernel+bounces-333083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3997C33A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCAF1C21376
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152413AF9;
	Thu, 19 Sep 2024 03:56:12 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECDFC0C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726718171; cv=none; b=IVCp/PoEzqPgYtUE8lRrfDzWkYqgc90J/Sr74a4KW8JDvMBi2X0vVqF/mPClmT+ueR3JPAKoCRyJ3O/bCqvYttwBzjjYIDywEIQe3U65hBXL+G5TnhZawR82QVoOMfZI1YqdbPXFZv/NabJSWakRgo8heEvIs6Hv2WS5ww0kGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726718171; c=relaxed/simple;
	bh=G5we9Nqv7E53bk0XKMCfGDfZn+E/ZqGhdcgww17a+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsbvZQKrhDWfaQgUayBmS/dpiImDQGI726gc1voPGBrw9BFx9gxSNvu6RT1KAoWcMgmNFqymGlWvy6aftAxB0UbCMTyattppgatXnRMbj2KJo+N8wIi8QS+ql4/iXQbEpUqLw+3fB1h40e67Z6fwcL9JkN1SENggd0EUiQcLPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz7t1726718080telposq
X-QQ-Originating-IP: V5NafoQtd2r3EER7QhH+pxJhBzkw4FTZ0iHW6xRwIMY=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Sep 2024 11:54:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10480147457873423502
Date: Thu, 19 Sep 2024 11:54:08 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn, luming.yu@gmail.com
Subject: Re: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
Message-ID: <040533E1233A67C4+ZuugYFMsPMaDAjI9@HX09040029.powercore.com.cn>
References: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
 <87wmj8pbte.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmj8pbte.fsf@mail.lhotse>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

On Thu, Sep 19, 2024 at 01:22:21PM +1000, Michael Ellerman wrote:
> Luming Yu <luming.yu@shingroup.cn> writes:
> > From: Yu Luming <luming.yu@gmail.com>
> >
> > ppc always do its own tracking for batch tlb.
> 
> I don't think it does? :)
> 
> I think you're referring to the batch handling in 
> arch/powerpc/include/asm/book3s/64/tlbflush-hash.h ?
> 
> But that's only used for 64-bit Book3S with the HPT MMU.
> 
> > By trivially enabling
> > the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
> > common code in rmap and reduce overhead and do optimization it could not
> > have without a tlb flushing context at low architecture level.
> >
> > Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> > ---
> >  arch/powerpc/Kconfig                |  1 +
> >  arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 arch/powerpc/include/asm/tlbbatch.h
> 
> This doesn't build:
> 
>   https://github.com/linuxppc/linux-snowpatch/actions/runs/10919442655
> 
> Can you please follow the instructions here:
> 
>   https://github.com/linuxppc/wiki/wiki/Testing-with-GitHub-Actions
> 
> Which describe how to fork our CI tree that has Github Actions
> preconfigured, then you can apply your patches on top and push to github
> and it will do some test builds for you. Notably it will do 32-bit
> builds which is what broke here.
thanks, I will take a look and do this for next patch before posting on mailing list. :-)
Ideally it should also include qemu boot tests for targets that must work.
I think we could also need a powerpc yocto recipe as well to make patch test more customizable
and reproducible than fedora/Debian distro. I've been searching for it for a while, but I couldn't find a useful one. Maybe I need to come up one of my own to facilitate the ci test bot ideas.
> 
> cheers
> 


