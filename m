Return-Path: <linux-kernel+bounces-353174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C89929C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75164B244D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E518BB91;
	Mon,  7 Oct 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TLWixq3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2lRSxn1"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C311D2202
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298810; cv=none; b=F1qSWkddQJOq3GGhsawjQv3clmC++ZyqXyz7SMtO/YzaARQjW+W4XknFnJ3ualvT2OvSJuolSZaPZ7ctiYhkuE60jFNwHQBSEy88IdL63OSmUUzHXcFh67uL1q8Ye4BtIgcOTDi21wMsHvltXK/37DcQaKII3NZbeN5F7gf4Yyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298810; c=relaxed/simple;
	bh=gsUIIFQ2kJLap7YJA4bt95KXin0UQbhqHD/HQqNSzVY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=thVIpphpfap+zaCZdpwN4LHDj3SYeyG8Pbn0VLTWu4f+VI3q7Dw4ZLDPIoV3C6P4+BxTyld8YH4qIoEUWikctrvsuOMPoAMLOyFwMLWlEvjW+lESHeAWc3i9s80PYw/xH/Ld+i3zWs+ZkkxIxibHWKeurpQjnkiEvjRuLGDK1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TLWixq3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2lRSxn1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 762E41140287;
	Mon,  7 Oct 2024 07:00:07 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728298807;
	 x=1728385207; bh=wHQQ3CtPzaNwT8vvr+ODBL4XR/DCWeqQIesx5U5vdTk=; b=
	TLWixq3/kRnVHaIa03ViuH6w42CBH0mDmg4mlNABz8WzTcdbR4uh7/aCTDe3O1sa
	hBaJrktlHx2bj5QHlGgTyE8i8fuVjS9Vh5bwy7a0nf1AjKsQYKTktdXc4fDOmrkT
	MzXOx3NlXJ0x/polzcNcL3NN+Ybuay3U8EatBDvy9Tuq3pOKU3ExQEo/q2MUY+IX
	qhWtzB78roAGTk4ofIEIE6C46riTWB99ndHltgH0RV/ZBi8knoUlIGi/65sSb/EB
	yvbyPr8E81L3xbZVCk8NwkZ4x/ieiQSwtufGZ6zA7yBl30Uxtw/zKDukCNORszWP
	vaUhlitJaMq9OZMIVA1pSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728298807; x=
	1728385207; bh=wHQQ3CtPzaNwT8vvr+ODBL4XR/DCWeqQIesx5U5vdTk=; b=V
	2lRSxn1xclx8X6LlPsSs3OqSAWUk0jChb26x361HI8xGhVR0OIQbu9nJ+0jzUz8Z
	3ePW0HC8pVvEdgNwqCSo4DLioEwmZBXLS5I6ve1HMKKBchrOtk+Rg1eioZuR5qTw
	n+B5weRVCcBy8DuFffRZiFCuQmPfmbMu+FcYzPGm4PeyMCpI7K7688p91fjoWg5H
	9MIzvaBSKNJYjF/GL9n1sPXdEm2EL7e2hq2xuYMY/U0C+qPqVqJnxQlxxc7AXEOg
	huR/XhC0KYUlesL1rJjb//IGKRppx5u6M0QrZqp8QH6LwsiqMUbjnGF4fIUMR8Kc
	+3OI59PtjGZ4j4soRBaZg==
X-ME-Sender: <xms:Nr8DZ6EwEIUFVMi5TRhdbZxdUD6t38WOIgyUerVSzPPEBwdweiC8YQ>
    <xme:Nr8DZ7V29-3vhSnprKWw_VA5QDF5cKubC2S10PbI2dnYa1o_5XYN-DVhNnkGUFxfd
    2dqi2SuyQolcQio64A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohephhhouhhtrghoudeshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhkphesih
    hnthgvlhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggvnhhnihhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtjheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:Nr8DZ0KBQAMM7UNoqnw4rHPWL1lK9XmNEoJuRlNujwEMKW5_UzYlMg>
    <xmx:Nr8DZ0HBUwAkfk8XWpeTdp2rdW3JvKINT6yTy1DssDYEYkaZ6rRbYA>
    <xmx:Nr8DZwVzeSU5bpaVCc9DveEmMTXOE2l1H638QHlUkfAcR5FV_63kLg>
    <xmx:Nr8DZ3MTj_FTAnCjYPjHbalGq-ZuGK80UyAxq-1A8DDb0Ds88kIC9g>
    <xmx:N78DZ8lnSmJ4v6ZP_kqG7YAmSXOlOYghQN8_9I1XNnSoa7-t7E1_PZvT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BBAD42220071; Mon,  7 Oct 2024 07:00:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 10:59:36 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>,
 "Christoph Lameter" <cl@linux.com>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Will Deacon" <will@kernel.org>, "kernel test robot" <lkp@intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Hou Tao" <houtao1@huawei.com>, "Jan Kara" <jack@suse.cz>,
 "Jianhui Zhou" <912460177@qq.com>, "Yury Norov" <yury.norov@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <98957f9e-aa9b-4d8c-8254-968905e85023@app.fastmail.com>
In-Reply-To: <20241007104348.ImJPXDl9@linutronix.de>
References: <20241004095702.637528-1-arnd@kernel.org>
 <20241007104348.ImJPXDl9@linutronix.de>
Subject: Re: [PATCH] preempt_rt: increase PERCPU_DYNAMIC_SIZE_SHIFT for slab
 randomization
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 7, 2024, at 10:43, Sebastian Andrzej Siewior wrote:
> On 2024-10-04 09:56:56 [+0000], Arnd Bergmann wrote:
> How bad is it, to have PERCPU_DYNAMIC_SIZE_SHIFT unconditionally set to
> 13? If it is bad could we restrict it with LOCKDEP and PAGE_SIZE > 4KiB?
>
> So maybe something like this:
>
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index b6321fc491598..52b5ea663b9f0 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -41,7 +41,11 @@
>  					 PCPU_MIN_ALLOC_SHIFT)
> 
>  #ifdef CONFIG_RANDOM_KMALLOC_CACHES
> -#define PERCPU_DYNAMIC_SIZE_SHIFT      12
> +# if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PAGE_SIZE_4KB)
> +# define PERCPU_DYNAMIC_SIZE_SHIFT      13
> +# else
> +# define PERCPU_DYNAMIC_SIZE_SHIFT      12
> +#endif /* LOCKDEP and PAGE_SIZE > 4KiB */
>  #else
>  #define PERCPU_DYNAMIC_SIZE_SHIFT      10
>  #endif

I think that's fine. If you have lockdep and large page sizes,
the percpu memory area is entirely lost in the noise of the
overhead you already get.

For your version:

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Arnd Bergmann <arnd@arndb.de>

Can you pick that up for rt fixes (if you already have a tree)
or send it to Andrew for the mm tree? Feel free to take my
changelog text.

     Arnd

