Return-Path: <linux-kernel+bounces-333490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3697C98C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405091F23297
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538B19E7D0;
	Thu, 19 Sep 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cEkP6PDQ"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAF19DF5F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750346; cv=none; b=kbmOUPYB02ZegTgC3KE6Z235wjaIHksFlyuMvgPvt1223C24OA4xsd2rAsaQr4QS4Goe6X8y3L2+GpqxIjOXMuAJj5+G9XzBa9QAOrKhuJMshlCr+rufCKItOi/zDfMdGlSma/jmIUXUQezhnTpOIf0XU2m5MtsW5FBDLRyBJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750346; c=relaxed/simple;
	bh=cMEmpzX38bdh1pLdWmdrhsen+4ruiQJlBB3j29UORZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EhJl8AE+xxI4Cpjh5qkevL/2BmNFp2XhmfA6d7BUalJ2oaTj0GFuFfYTLcumH/8CVP/CqhmuEf8BeiyfEJEbj5z0T5HPPc+hn4KvOI298nVg5q0w1/XxUrkxEStGc/yL/OU2l/0+nSxWtCxrzW8rIBJ6pV3fM+CzvKQfpl/X1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cEkP6PDQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726750342;
	bh=YdfaTvkQDBi4PXl8ldsfHZrG66LfS85qUpPVnUW7PhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cEkP6PDQe/cGBgTv9xjFn5FgrS7hVSmWVy0zMzRWqw09WZXJO0jznZ8GNsNkK4Tud
	 lP3vMJ9RHxCdEFxHBY8sK6jHAtIV2x/sm5uYnl+1VdEn8W33TfUUNJc/EB2XgzVFFp
	 QulvhH0tGFKYz3ehJ1BRy6PmIgTt8oD6Fb6WB4gnqotpOWgM8zsEauceb4CzuY/dxO
	 QqgMehIOEd3FRkx9N1OK7ceGLK3yfe+j6kyvopQ3pE/1F/eUacccfnLtluJ88tYwhm
	 IZ0/jc9OWlX0UJOwL1T9CQDHLxnQbwogGSY6JOK/CCkNsRaAvPSXcT4XtqeTrr5fG3
	 A0v6Ki80FR4lQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8b5L1MZhz4x5M;
	Thu, 19 Sep 2024 22:52:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Luming Yu <luming.yu@shingroup.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, jialong.yang@shingroup.cn,
 luming.yu@gmail.com
Subject: Re: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
In-Reply-To: <040533E1233A67C4+ZuugYFMsPMaDAjI9@HX09040029.powercore.com.cn>
References: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
 <87wmj8pbte.fsf@mail.lhotse>
 <040533E1233A67C4+ZuugYFMsPMaDAjI9@HX09040029.powercore.com.cn>
Date: Thu, 19 Sep 2024 22:52:21 +1000
Message-ID: <87ldznreka.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luming Yu <luming.yu@shingroup.cn> writes:
> On Thu, Sep 19, 2024 at 01:22:21PM +1000, Michael Ellerman wrote:
>> Luming Yu <luming.yu@shingroup.cn> writes:
>> > From: Yu Luming <luming.yu@gmail.com>
>> >
>> > ppc always do its own tracking for batch tlb.
>> 
>> I don't think it does? :)
>> 
>> I think you're referring to the batch handling in 
>> arch/powerpc/include/asm/book3s/64/tlbflush-hash.h ?
>> 
>> But that's only used for 64-bit Book3S with the HPT MMU.
>> 
>> > By trivially enabling
>> > the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
>> > common code in rmap and reduce overhead and do optimization it could not
>> > have without a tlb flushing context at low architecture level.
>> >
>> > Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
>> > ---
>> >  arch/powerpc/Kconfig                |  1 +
>> >  arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++++++++
>> >  2 files changed, 31 insertions(+)
>> >  create mode 100644 arch/powerpc/include/asm/tlbbatch.h
>> 
>> This doesn't build:
>> 
>>   https://github.com/linuxppc/linux-snowpatch/actions/runs/10919442655
>> 
>> Can you please follow the instructions here:
>> 
>>   https://github.com/linuxppc/wiki/wiki/Testing-with-GitHub-Actions
>> 
>> Which describe how to fork our CI tree that has Github Actions
>> preconfigured, then you can apply your patches on top and push to github
>> and it will do some test builds for you. Notably it will do 32-bit
>> builds which is what broke here.

> thanks, I will take a look and do this for next patch before posting on mailing list. :-)
> 
> Ideally it should also include qemu boot tests for targets that must work.
 
Those scripts do qemu boots of pseries p8/p9, powernv p8/p9, 44x,
e5500, g5, and mac99.

It doesn't boot full distros because that's too slow for Github Actions,
so it doesn't catch all bugs, but it's better than nothing.

> I think we could also need a powerpc yocto recipe as well to make
> patch test more customizable
> and reproducible than fedora/Debian distro. I've been searching for it
> for a while, but I couldn't find a useful one. Maybe I need to come up
> one of my own to facilitate the ci test bot ideas.

I've never used Yocto, not sure if it does/did support powerpc.

Buildroot can build powerpc images with lots of packages included.

cheers

