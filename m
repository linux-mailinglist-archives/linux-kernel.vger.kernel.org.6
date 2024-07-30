Return-Path: <linux-kernel+bounces-267661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D87941412
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6811F25257
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618F1A08CA;
	Tue, 30 Jul 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJWlb+Xg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3991552FE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348912; cv=none; b=SnonDlpbEsefWiwU0Os7liVWgRNogaouVpu/SQ3PUo2Xtl7784NXY09x34umgUjud6UUMGLlQ926ma92wfc0i53CLWxnk3R976KDolfWwYMPczD8ePpzVyUkU6tMSbsZJ5qui/rYEKHjihxhv+gJFV398U3IYNUX9YJAwcTey4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348912; c=relaxed/simple;
	bh=ZPO4ikQfBugP0guGLRtP7Q+yMIz304qmBzCHuYNaMuA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=typMU+KIfbk51isgNLmQVlNRtStZIarm7gPot0cqGtBQjzB9BQuXwAM+MBf6aHoLI04sUKoBE1Wyv6QEvwkx5+F0idafocIRQSooP9WKMha1PqkBjl8jTK/wXPk76SvMT/bkn+O1wgGPXzNT0dRc8RUWBcSLK2G9tj05H2/lLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJWlb+Xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD4BC4AF0E;
	Tue, 30 Jul 2024 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722348911;
	bh=ZPO4ikQfBugP0guGLRtP7Q+yMIz304qmBzCHuYNaMuA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iJWlb+Xg7mVa/+fUNvcnHf38OrJAtxlNuAfbAxyqovYGqmLYpdKvuZzDjNZPGPHqh
	 Qt+otPl+u2bC0SutV0+4jRMo+5SvZPErFQqleT64919EXa32pdCLhuhty4L8yy5Mwy
	 H7mxMyvORcpSUWen6Qo6Wnw6D5W2Yo/9w7ZxgkLOBkymGYy9hZZD3Zn1K7yIlFVkfv
	 Ej3qLIBGV4ayMQi6eJbWPNeJvHcWJtT3bT/NAMQl2Z2NLQO53NZoUAjynqecu5QjyH
	 EGO00vfkm88WKG8n8K603hFRWObVv5l79Xtj4GkcI7DY5lthBSWU0YXpLNy6fElbR7
	 LGUze3PZ6uiQA==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4E4441200068;
	Tue, 30 Jul 2024 10:15:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 10:15:10 -0400
X-ME-Sender: <xms:bvWoZsBkvwXl8QQrXxDGfky2SweE1hgieiDUA6vkuI0BNGKrjfzIXA>
    <xme:bvWoZuiB-A8SNuQ8P-Uk8rzZit51OmkfHSUwlQH3UqdV1aIMWMr-FDtw5xowuMflA
    Ij-WYTMA_qG_v2u_mU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpefftdduueeitdfgveeuudeikeduudfhffejjeejudeuffdtiedvleduhfeu
    gfdtgeenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:bvWoZvkXxvr4sZiasiUpw4oAsTiuCWiKvKdVOkNxZgwnJkUZvOgRFA>
    <xmx:bvWoZixXUQxpAc5QcfSCD-2ytDEhQaABkDeQO1zfQjXNpTPAb-zb7g>
    <xmx:bvWoZhRqxxMJk8GmUbzMtGe_90v9MRrAfwCNhjVFKKrBDW_kCljUIg>
    <xmx:bvWoZta-jDjCMtUOnolv897SKlfEE2OCzY67wfMVgDWFstXTM9bWEA>
    <xmx:bvWoZqQWR3uH1oOeW91HazTbTIXkKxxEpUSTCX8GIbs-Gbi1r3yL8mNJ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1CB3BB6008D; Tue, 30 Jul 2024 10:15:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 16:14:48 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Torvalds" <torvalds@linuxfoundation.org>
Cc: "David Laight" <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Matthew Wilcox" <willy@infradead.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Message-Id: <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
In-Reply-To: <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
 <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 12:10, Arnd Bergmann wrote:
> On Tue, Jul 30, 2024, at 05:59, Linus Torvalds wrote:
>> On Mon, 29 Jul 2024 at 16:21, Linus Torvalds <torvalds@linuxfoundation.org> wrote:
>
> I'm giving this a spin on the randconfig test setup now to see
> if there are some other cases like the bcachefs one. So far I've
> seen one failure, but I can't make sense of it yet:
>
> drivers/gpu/drm/i915/display/intel_backlight.c: In function 'scale':
> include/linux/compiler_types.h:510:45: error: call to 
> '__compiletime_assert_905' declared with attribute error: clamp() low 
> limit source_min greater than high limit source_max
> include/linux/minmax.h:107:9: note: in expansion of macro 
> 'BUILD_BUG_ON_MSG'
>   107 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),            
>                 \
> drivers/gpu/drm/i915/display/intel_backlight.c:47:22: note: in 
> expansion of macro 'clamp'
>    47 |         source_val = clamp(source_val, source_min, source_max);
>
> See https://pastebin.com/raw/yLJ5ZqVw for the x86-64 .config
> that triggered this.

The above seems to happen only with gcc-13 and gcc-14, but not gcc-12
and earlier, and it's the only one I've seen with a bit of randconfig
testing on that version.

There is another one that I see with gcc-8 randconfigs (arm64):

net/netfilter/ipvs/ip_vs_conn.c: In function 'ip_vs_conn_init':
include/linux/compiler_types.h:510:38: error: call to '__compiletime_assert_1040' declared with attribute error: clamp() low limit min greater than high limit max_avail
  510 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
include/linux/minmax.h:182:28: note: in expansion of macro '__careful_clamp'
  182 | #define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
      |                            ^~~~~~~~~~~~~~~
net/netfilter/ipvs/ip_vs_conn.c:1498:8: note: in expansion of macro 'clamp'
 1498 |  max = clamp(max, min, max_avail);

I can reproduce this one with gcc-8/9/10, but not gcc-11
or higher.

This may be another case of __builtin_constant_p() being
slightly unreliable when a local variable is constant-folded
based on a condition, or with partial inlining.

     Arnd

