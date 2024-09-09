Return-Path: <linux-kernel+bounces-322095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141D9723E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5C0283CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B118B48F;
	Mon,  9 Sep 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Oege0iBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yt3Tnure"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E718B46B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914594; cv=none; b=mbBSURv7oLkmNENdELM2dWvGLviEKVd+tshTVJggJkZb8+p5R77P8sAzRc4VyA0IT8lzSRIJNF146+TiycwPMtp3j4QgQXg3YuP14tY5XaFA7GjBzir1dnyjMy920vQZS/4ONIXoU47hVXcm3GJL4NTNxZ4De/NB4CtFWvknRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914594; c=relaxed/simple;
	bh=fIetD5QJrL1r/lJhwyaLiRNRlp4jCX8fUbwbhCln5k8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pyEOm17eDpStpG0b/yvhuT2BdTPuwPpwWfMXR1ZVnbIKxO7cut2+yWmhB1uWzk+XJkfaA8YqEOlPC/HA04Ut7HuNR9kgQIXY09ewfT1dVNM7BvLEGu+bIb7s5Fi7DluzBMIQAghAcPD6a5sCMow4/RjtpP1T+J097MJMZRzv//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Oege0iBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yt3Tnure; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8109913801F9;
	Mon,  9 Sep 2024 16:43:11 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Sep 2024 16:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725914591;
	 x=1726000991; bh=DMtOFdHnFia/5nYaAaOQk2PtM52mI11VRy3Qvnxac9g=; b=
	Oege0iBc1AUFW0+63y3hVAtYJ0GXoyGHZe9Clo4nCcHQb6SEww1F+k53srI0Ofd5
	reVIS6WZ8QdzNT3r5EMPHeKaDjgJ9iwKCiB741PHqyD2MNszoib/0IcrkEVrSQWV
	wAS7v5TNbGG63zTyxy3IP/QcBktZvzuWIkPCdOfQigc5pv6uMnIJeVnmUHq7oBuA
	qt/bSGes0inFNnsTbn7GqgPjz5tmj0SKw/6iSPRsrH1/0Bpvizp9xPUgGGJn/kBU
	saNEIogp3BiCRSrZl6uMr30EdQaTGhKXWzEmHamuQab9nG5WSW6gcfBF+/DgQ09v
	YZJ/HHTeHaJ15BdP3YD38A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725914591; x=
	1726000991; bh=DMtOFdHnFia/5nYaAaOQk2PtM52mI11VRy3Qvnxac9g=; b=Y
	t3Tnure0uniZCMN19u6tj2uIVjraT4Mw+6OtynZAZ3oSS2MFssIk7KFpzCekSqdc
	JYf+2yQVpdI9OIEluW0Ra9TPYavi4VbHHUJfdrp8SJITvMcVp2F//9h5fQrhhEvb
	dgE96v3j62YN+RmTCtEG5sylX4xR6EdINp6vA6d3VERPmIhGN4xjSw45y1LdDoTV
	o/8blvIge75AN41GjegOiLVr2n/ij5l670NCMknF88fJZKxF5UWLzoNmc7F8XcH0
	lBqm5c0I0WGqGXSKEJ/om83+M6gVuQtX8uoOrt1aRyQU6dMozyFM1gI66mo8xpMK
	Lfshkzb29q0xtw9EIoFTg==
X-ME-Sender: <xms:3l3fZn2jTSjDiesFheyqUxDehuiaSd8nrSWg-WyoI6R8vg0yHVw-7g>
    <xme:3l3fZmEGI09VB7zewtwFn7vDcif0nIp_KnsL2rOrDjOA91F70__IxUZplrvgJ-bQx
    pw8lh6gvg39FbW5iM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnshhhuhhmrghnrdhkhhgrnh
    guuhgrlhesrghrmhdrtghomhdprhgtphhtthhopeiihhhouhgthhgvnhhgmhhinhhgsegs
    hihtvggurghntggvrdgtohhmpdhrtghpthhtoheptghhrhhishestghhrhhishguohifnh
    drnhgrmhgvpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghp
    thhtohepnhhphhgrmhgtshesghhmrghilhdrtghomhdprhgtphhtthhopeihohhsrhihrg
    hhmhgvugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhgvvghssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3l3fZn41cSAbsH1HxgHlLgQjLyJNd8glEX1HP3kU8bhXx7eTXIJtmw>
    <xmx:3l3fZs1mTl_FJz5Qox4qlJRVS_ssutcQYuTd1UTWhfk8su-FyM6KyA>
    <xmx:3l3fZqG3_cvKF6H-S9NFv1jwivx3X5PFInNRCbDwECTmuzs3Q8NsDw>
    <xmx:3l3fZt9xVDXGbyvCvFNoU4fgIrUcOft1EXKWnBf0JHVf7qwzFEqOSw>
    <xmx:313fZoVOftlAO755ZSBL5G9M5y4pMe6HLe5dHz7ke8YDyBMGnDVkw1oh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6309B222006F; Mon,  9 Sep 2024 16:43:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 20:42:49 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yosry Ahmed" <yosryahmed@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Nhat Pham" <nphamcs@gmail.com>,
 "Chris Down" <chris@chrisdown.name>, "David Hildenbrand" <david@redhat.com>,
 "Mike Rapoport" <rppt@kernel.org>, peterx <peterx@redhat.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Kees Cook" <kees@kernel.org>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Chengming Zhou" <zhouchengming@bytedance.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Vitaly Wool" <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Message-Id: <85524814-6256-4f83-bb59-879debf26646@app.fastmail.com>
In-Reply-To: 
 <CAJD7tkb9q-_MHFWdM7+KueFS9LJUWsvqHdDmFnpgNahyjv+8+A@mail.gmail.com>
References: <20240909202625.1054880-1-arnd@kernel.org>
 <CAJD7tkb9q-_MHFWdM7+KueFS9LJUWsvqHdDmFnpgNahyjv+8+A@mail.gmail.com>
Subject: Re: [PATCH] mm: z3fold: deprecated ZSWAP_ZPOOL_DEFAULT_Z3FOLD as well
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024, at 20:29, Yosry Ahmed wrote:
> On Mon, Sep 9, 2024 at 1:26=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>>
>> -config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
>> -       bool "z3fold"
>> -       select Z3FOLD
>> +config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
>> +       bool "z3foldi (DEPRECATED)"
>> +       select Z3FOLD_DEPRECATED
>
> Thanks for looking into this!
>
> I was going to fix this by changing "select Z3FOLD" to "depends on
> Z3FOLD" instead. It makes the warning go away in my builds. Does this
> work for you?

I had also thought about this but decided that this would
make less sense from a user perspective.=20

If it builds in all configs, I won't complain though.

      Arnd

