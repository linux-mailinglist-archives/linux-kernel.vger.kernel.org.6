Return-Path: <linux-kernel+bounces-267231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C63940EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4F9B24D34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9561990C7;
	Tue, 30 Jul 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6nTpmsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5C198E88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334278; cv=none; b=KSLI72G4ECNJbBAgzmOidaNxF6DgcNp/lX4dnAQVNsmq0UVD3eDpZq2t6tQpFhWagFj7NBm/1w7g6j2XV/PCAmF40HrLqTkFp/Kaz7dlWla3aBe3pmkgYtOP1ykcOalvygiF8e7iacGlWYZU3rPE/oSQhr84XQVkBUzxLDdAfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334278; c=relaxed/simple;
	bh=pWtd5ufJwbu8T0nenKU0dt1FDubCPi1BqdpCJAfG+Dw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WjUFKTOu1Vtp/vdo/r47qxCvDRio9t5Q0uTXyxql13g2qmpOLgPmLNQP4B5D9K1Q2VbpCYsU3noRT7P2pNqhLJAEccSfSfw9J5qqJ5eEmnQOwT2SHFN6xrZMHpRWvR+tCrVoY7Qdm151Vwx37wKJ5G9isbGLrG28zI1S8gakr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6nTpmsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605EC4AF0F;
	Tue, 30 Jul 2024 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722334277;
	bh=pWtd5ufJwbu8T0nenKU0dt1FDubCPi1BqdpCJAfG+Dw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T6nTpmsS13RyRnVy4mJY7pj3Wvu6M/nUImepwXmML8WBdQQlQlbA88Twg50lWUOp2
	 1Cy6i7TK3rc4x2P9bpNZ74XUEzU8bOpEZRc5SU3UTcMU13KExw3fNmSWQMlSoofYXf
	 KEiye1sxHblaI8dEEXhtOhs4fvYxo1/HgmulS4b2B0jkqvXX1IUmiGK9NF8yjjT0Hr
	 dwA312DcKm3Z7gEl+DjzMJzEFjUuH+Z0mdKZ1M2xtgf7vhnkhLI7hn8Wjve7YA8edq
	 xMerJ5lZ1iqpe3ztbJnSxv1d9i7X8pIhVfz5jRi6SYehnRA5JzXh75XYUzYDNrzgCv
	 7etKvLsD4ZK6Q==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AC8191200066;
	Tue, 30 Jul 2024 06:11:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 06:11:13 -0400
X-ME-Sender: <xms:QbyoZvbrJsP-a1AMAG1dM-MuX0VWKpy_D00caUYGn6HZV7i7-ztFAQ>
    <xme:QbyoZuaXTzKJaGqdH_TYj616_C_w3iSBuw7A8_pK25ItPvbGCaBX19Fv1ZNUyj2Ky
    nPrw1w7HRkA2hvm0_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpefftdduueeitdfgveeuudeikeduudfhffejjeejudeuffdtiedvleduhfeu
    gfdtgeenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:QbyoZh-pxGFel4_jBY-H0glXVrN3eTcbl1JoMiRJQuTWGhdfkqsXog>
    <xmx:QbyoZlpIJWDEUskwwgF6i-eIerkxZX2afoW9gJ7oO718e8i8s40jTQ>
    <xmx:QbyoZqpuHGoXs804mEUpSh0FYNKHIxx94olD16RNNwlK1qFrrBYsfA>
    <xmx:QbyoZrR2JqtW_AFLk9SZk-hdKEhOdcF752-Av8NfLsdHkWKMaHA9EA>
    <xmx:QbyoZirUk2ZzYlWDeNCC2UavSQpX_fBQsNndeBWbvFwR-Xjlb_ZxB1vK>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 772D5B6008F; Tue, 30 Jul 2024 06:11:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 12:10:41 +0200
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
Message-Id: <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
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
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 05:59, Linus Torvalds wrote:
> On Mon, 29 Jul 2024 at 16:21, Linus Torvalds <torvalds@linuxfoundation.org> wrote:
>>
>> Attached is the patch I have in my tree right now - it complains about
>> a 'bcachefs' comparison between an 'u16' and a 's64', because I also
>> removed the 'implicit integer promotion is ok' logic, because I think
>> it's wrong.

I'm giving this a spin on the randconfig test setup now to see
if there are some other cases like the bcachefs one. So far I've
seen one failure, but I can't make sense of it yet:

drivers/gpu/drm/i915/display/intel_backlight.c: In function 'scale':
include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_905' declared with attribute error: clamp() low limit source_min greater than high limit source_max
include/linux/minmax.h:107:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  107 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
drivers/gpu/drm/i915/display/intel_backlight.c:47:22: note: in expansion of macro 'clamp'
   47 |         source_val = clamp(source_val, source_min, source_max);

See https://pastebin.com/raw/yLJ5ZqVw for the x86-64 .config
that triggered this.

>> I don't think a min(u16,s64) is a valid minimum, for exactly the same
>> reason a min(u32,s64) is not valid.
>
> Oh, and I noticed that it screws up the 32-bit case, and that does
> need a workaround for that.
>
> So here's a better version. The patch contains one possible fix to
> bcachefs for the type confusion there, but I'll wait for Kent to
> respond on that.

That's still a typo in the 32-bit case, right?
I've changed

 __builtin_choose_expr(sizeof(ux)>32,1LL,1L))

to check for sizeof(ux)>4 for my testing.

    Arnd

