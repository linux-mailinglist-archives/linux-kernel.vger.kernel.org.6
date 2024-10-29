Return-Path: <linux-kernel+bounces-387736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670E9B557E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94ED1F22F48
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42620A5E6;
	Tue, 29 Oct 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="meSvuq7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdICr+8A"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D27209F48
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239535; cv=none; b=AetvFMqNox84spjzKIoX5DPLXhB1V5zB0Gqw/JmFcKN/3cblZ0YncI9A8+NQyJXK8FWhfYAVFMYGg/CL75PkxhSBzwHgtyPhshIUvuyJwMfFCQlb0GsCnKVK8z8W11AP+v2IGzZYoqt9LevnNpEI+/8KNGCGth6ay+7Or4mEcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239535; c=relaxed/simple;
	bh=FUzLpVk2SjmD7kYZP/f3grFAvpnpbJkbL/Twh/CuwK4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c+Ejb7Gxua0+SDzyWvSao1Lfc3WibqdqkNFJZojYm+hj9pYzNh7hsz491BHByBq33iicFgKXec/xEzYYdjVDZrDQmmuHyi6BT+nbzHgy1XQz4m2D5fpe5M5M80i7R8aGwMbzLZ3+XDbB+fxHVuCfedREJkesef3HajjDBVD+T3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=meSvuq7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdICr+8A; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B53A13800E3;
	Tue, 29 Oct 2024 18:05:31 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 29 Oct 2024 18:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730239531;
	 x=1730325931; bh=VoJG6qEfHgbubgRZ79e+rYNmNmfGfefqzVZlAcAw9EY=; b=
	meSvuq7IuWaXueBYn2EGsdXgPfGwajLZ+aXFTY4OvUuxEq5r3JJiOG2IqEC4ppNb
	13Q/VIIHEfHsYsCtSnUSdrip2jECD6v497BamHwccBXsLowYjREem/uqjXbkG2Zl
	znHQdhlA4UP8HxWM1XB1eh9iMrYIPpTQ0v39UMybxJM1IZp6lZnSn8lJEyjRXXa6
	y6kj7qRJ4b/L8Hnz3scNKRgBGv+QlSB3lvQECUVqMU9zqLYnfRMouI2VeOwz2xgc
	/o8fudtHgOo7hAR5nqDj9EqmhXyrvI5GldW8zH/4fquYbRPVxJJ9k4QVbMR0DHcs
	rMHh9Bau9tT/m9EDAG6n5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730239531; x=
	1730325931; bh=VoJG6qEfHgbubgRZ79e+rYNmNmfGfefqzVZlAcAw9EY=; b=E
	dICr+8Ay1syjWlGokR4DVLVi9J0MCkE84d++khjKuUPWjA0LDcDXs+gKITSwYOZr
	rMUrLOZyMRpsw6H+/2xRyDjB8NMO3LRxXdLi0NEuuFJER2d0kByFsxapD6R87xdM
	v82g6z6J19tndO5Png96CAJxWTcweqa8sibVYxU0n6sbkK9AEjJkIlZ5dgVrv7WU
	x2hqjp6gULs9Pf5rSPQdB0deBgxl57FU5L+ZCFNgHOI86cBER7quJRtC4XNFbOY8
	aMad/IUef6vviDs+ZRHKp+x1bcvLo43V0a4aye42bvk+hydP0foKxjAz14ZqBAL5
	7To2sY09qsNh51AoZ1lhA==
X-ME-Sender: <xms:K1whZ6n1jv5lq9Q6taVXu00TweQ12ybkkDByDkWdC5qVCPsehjNNRA>
    <xme:K1whZx2LViHzQkkS97UUxN5quvB2Gs3oe6Audcr8EuNNmAI3Hvl66yWnI0LZ3_10F
    1JBheg791I3ILaQDvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgtphht
    thhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthht
    ohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohgvqdhksg
    huihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K1whZ4qh8U7tPvA8yl_y1xO1NVp1UxvJ6FyaEaHExiXIz02d6J68uQ>
    <xmx:K1whZ-kvH5ADd7w1ytEd0fjQwM_36NqO9dZPqD1rAm9Fl8F5R-fNzg>
    <xmx:K1whZ42AYtcVyV5YG4vqGikSotg2UnOf7KG3zDyBYLB6h72jY00PTg>
    <xmx:K1whZ1sGUn1yesrsipqarP43R-D-Gv2qpO4yG9l0rEEM1CJlnUTPAg>
    <xmx:K1whZyoXORwUOgyDK9d2GjAKx2UAWzqpVrhVQCyAaJHnopA0mWqZx2Tv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0ED7E2220071; Tue, 29 Oct 2024 18:05:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 22:05:10 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "kernel test robot" <lkp@intel.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <1d6a10ca-3d86-452a-bdba-03a1204dd232@app.fastmail.com>
In-Reply-To: <87ttcuzjy7.ffs@tglx>
References: <202410290639.TBG289SO-lkp@intel.com> <87ttcuzjy7.ffs@tglx>
Subject: Re: [tip:timers/vdso 11/13] include/vdso/page.h:15:39: error:
 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean
 'CONFIG_LOG_BUF_SHIFT'?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 29, 2024, at 21:18, Thomas Gleixner wrote:
> On Tue, Oct 29 2024 at 06:38, kernel test robot wrote:
>
> That's actually not the culprit. The problem exists in mainline too. The
> actual root cause is:
>
>   5394f1e9b687 ("arch: define CONFIG_PAGE_SIZE_*KB on all architectures")
>
> The config has no CONFIG_PAGE_SHIFT because nothing selects a page size. The
> the original code had:
>
> if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
> #define PAGE_SHIFT     13
> #else
> #define PAGE_SHIFT     12
> #endif                        
>
> But the Kconfig magic changes made this depend on various other things.
>
> The patch below cures it, but it needs an eyeball from Geert.

I have previously suggested a similar but more extensive patch
to address the problem:

https://lore.kernel.org/all/CAMuHMdVC-FUSA5C9aNrvP3=RaRWrchhUEC5UYcSGMz_ep1PEhg@mail.gmail.com/

I can rebase that one if Geert still wants it. I think I sent
an updated version somewhere but can't find it now.

> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -21,6 +21,8 @@ choice
>  config M68KCLASSIC
>  	bool "Classic M68K CPU family support"
>  	select HAVE_ARCH_PFN_VALID
> +	select HAVE_PAGE_SIZE_4KB if !SUN3
> +	select HAVE_PAGE_SIZE_8KB if SUN3
> 
>  config COLDFIRE
>  	bool "Coldfire CPU family support"
> @@ -30,7 +32,7 @@ config COLDFIRE
>  	select GENERIC_CSUM
>  	select GPIOLIB
>  	select HAVE_LEGACY_CLK
> -	select HAVE_PAGE_SIZE_8KB if !MMU
> +	select HAVE_PAGE_SIZE_8KB
> 
>  endchoice
> 
> @@ -46,7 +48,6 @@ config M68000
>  	select GENERIC_CSUM
>  	select CPU_NO_EFFICIENT_FFS
>  	select HAVE_ARCH_HASH
> -	select HAVE_PAGE_SIZE_4KB
>  	select LEGACY_TIMER_TICK
>  	help
>  	  The Freescale (was Motorola) 68000 CPU is the first generation of

Part of the problem here is that this simpler patch
then just causes different build failures for the
same configurations, since m68k kernels cannot successfully
build when no platform is selected.

     Arnd

