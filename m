Return-Path: <linux-kernel+bounces-269033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC6942C93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF771F25E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0A1B4C37;
	Wed, 31 Jul 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPqAc69K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980D1B4C27
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423026; cv=none; b=XYOA3u1k83YvX/EYhI+7fu/Jld4dMukvnuPkdEIBGBPF3Gq+b3W2UtCrEjcSisf7HZq82lqJvGnqBm+P4kS2g06lzfOrTqjkDR56aSLxmMkWcNqCoJOm32xHLtrxAPLh/nrjBY/26CDiXfqLsDtIJ5CLYZRe7aPo/kjzUL/nQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423026; c=relaxed/simple;
	bh=nJwjqDsM4QBH53oTWN75MaWGhKgioDRUggs5DDAXk94=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HfcR35r3NDQds1hrqlL9C/6snRYNIl1NtOT2crnm/AeOSFuN9NrfliByWq6QdH4uMoaTXdjFE0nFbyyzxb/wKGeJ6+R4bxWcc3uI2uei2v4ejxc7RQquvElCVC4Rooj3Fdo/9zHrdXZ6ll1+hOrfw7mOiufsNwzfB0OFWB8h1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPqAc69K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF9FC4AF0F;
	Wed, 31 Jul 2024 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423024;
	bh=nJwjqDsM4QBH53oTWN75MaWGhKgioDRUggs5DDAXk94=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rPqAc69KUB8xLuNASnWhnK46NQrD1x8czhwKAc3ccT2UYtkW7FszdcZ7g/fgBU2qz
	 XJgTtwhs2TGzPKGXymXzMCI9GgKFnFtgaI5cSg1l5U/eQxJw5LsjD/YoOCLXR7HSED
	 vfMiNCCplb6NqGG2f3IuFLqHses6CbsQhNndHuSqXeDVK7DbfVbzMvil9x9CBUIWmt
	 mSW5EkLUXBO6mkR25LP2iuf5AJudAzlRB1R+p1RNtugFnAj4pojQEnPn94ZxUZYTh9
	 2Ur6uJtkonBI34O5NfrETisKycq+R8/UUrL6aFzinXFSEpBilG97z1NsQfIU03IUyp
	 0AstuYxWF5+IQ==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EE5BF1200043;
	Wed, 31 Jul 2024 06:50:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 06:50:22 -0400
X-ME-Sender: <xms:7haqZjlyX-tyJG-WyPL5_1bXaPkPHq8ZdHOXjamG_XiX6vdINtxbRQ>
    <xme:7haqZm30xPrTRLRg1aSaw3lofHcoKCReUuMep8E0HGiCPfwfYnM4jFlIAU3eZne3H
    QcJQo-Afl6D0ENochU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedtudeikeeggeefkefhudfh
    lefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
    gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
    gvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:7haqZppYUovhfv13TfH3wDvgxehhp_3Xwa2A0zcLdvVnExfgl6ETuw>
    <xmx:7haqZrmBhcy1_LRo97CoZaTuDX2VdR1srFVouRkmvIyUrUbG5sBJ0A>
    <xmx:7haqZh02NEh2bdzYOEZ6TTE-lsnUqDrvysQufpjoaAuqVKW6wLuGQg>
    <xmx:7haqZqu0ezBqkkzwbrUHGbmXvZhzBCnF1vsPwShbwy4Pi2y1YrNsHA>
    <xmx:7haqZlUgPxPIl48N834xFz7CwcfOrf-8icK-4R35vZvDx4WAYLsV8N2s>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C98C1B6008D; Wed, 31 Jul 2024 06:50:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 Jul 2024 12:50:02 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "David Laight" <David.Laight@aculab.com>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-Id: <828437e5-ba9c-4062-a086-1d69aace5d14@app.fastmail.com>
In-Reply-To: <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com>
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
 <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
 <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
 <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
 <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com>
 <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
 <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com>
 <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 31, 2024, at 10:09, David Laight wrote:
> From: Linus Torvalds
>> Sent: 31 July 2024 00:04
>> 
>> On Tue, 30 Jul 2024 at 15:44, Linus Torvalds
>> <torvalds@linuxfoundation.org> wrote:
>> >
>> > Does this work for you?
>> 
>> It seems to at least build cleanly here, but I'm not claiming it's all
>> that great.
>> 
>> The nested __cmp() is still rather less than optimal from an expansion
>> standpoint, but at least it expands only those unique temporaries.
>
> That is the main gain, IIRC Arnd did suggest splitting it but that is
> a relatively small gain.

Right, I suggested a split version earlier, but that was without
the __careful_op3, something like 

#define min3(x, y, z) ({ __auto_type __xy = min(x, y); min(__xy, z); })

I think Linus' approach with __careful_op3() is better here because
it handles more corner cases with constant arguments, otherwise
the two approaches are equivalent in how they expand the arguments.

Doing both __careful_op3() and another temporary won't add any
advantages that I can see either.

     Arnd

