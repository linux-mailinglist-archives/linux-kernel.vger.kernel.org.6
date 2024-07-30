Return-Path: <linux-kernel+bounces-267299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6BC940FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B611F237C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C294B1A072E;
	Tue, 30 Jul 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQX9eekP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEF19E812
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335823; cv=none; b=irykbN6oRnux4MaEMqq1aDjBvSEknlwlVEk6gBVR/J3VdXKXtqlfhqhIP2TbtGvWTMzON/EtFQa41kEm7kxeItVMC3WWKWhY4TbZJvh7WN5P0R40ZqnbqrX/fUaJLhNvj1231j0H/uuJpcHcefnFU5lbnsSVAj6n1P+MsUu6VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335823; c=relaxed/simple;
	bh=kJsK2HC7bilt/BSEHQJYcDnbRJxZyZ9cUgXggKXJ2U0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pq8cmqXOwi1ehyLo8hIyeVwKYXy3YIBkfS8uHZr2Oh5oJqGYp7xOqfKDB7/eEEhFkGpDDXu/dlAIAHqt8Z/OrP+NrTWDn1EE0oX7IQ1FwqnlcWCqthQwjCbeHgFnIO7yb0pmrv9fxby/oCE+5oIuyuwAtEDmB3rniHxD4rEmRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQX9eekP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E24C4AF0B;
	Tue, 30 Jul 2024 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335822;
	bh=kJsK2HC7bilt/BSEHQJYcDnbRJxZyZ9cUgXggKXJ2U0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fQX9eekPKzL8SjCldhl8puy0JLxz9/qnacUsJGL5wQZhZNkVtqyf/mTwrc4GoGuOm
	 P2lhf1HUze39nU71gKiwarbEsd4ss5qVc8GDEurWtGAn0buJarYqV9YT/dqm1kDUO6
	 Gm+2p3z4RwL3LEVimneNfw4Evr08PEdKxQJ9zqOhc1/1h+E5nfCr5Lh+XDHdNM+Ry7
	 YBENQhgqdN4X0b9ZgFTBRvrpSdBBhndb88wqNpAWIXqHe/c3i11LAMoftYVNIpXK/o
	 nEg+EwtYEhg6ONos3bZIpPvFqv4ZoOzfS+JvID0mMVbAc7wiAn38kTqG4yUS2IlBPX
	 ODvaKcJXwMt3g==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6CD821200043;
	Tue, 30 Jul 2024 06:37:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 06:37:00 -0400
X-ME-Sender: <xms:TMKoZjT6RNzC7EzuUgZBm1u4HtazRMYuhpFQfQB0YlJ5sQDyqItsMg>
    <xme:TMKoZkxcD8pLLwJ8VqbL7OL-pGxZfxFyeD9Pbg7gaP4bakp83tUStsh0icDUVqiQR
    OV1uhcjvNAfeiUMgX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedtudeikeeggeefkefhudfh
    lefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
    gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
    gvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:TMKoZo3s5soEcAv-a-ndwUgEqXgdukdR14OxHECaPTaTIwBKd3JFLw>
    <xmx:TMKoZjDSuHnZANeBO4MuVOBBMjPUxVMUoQktYarvaxXu3cYIaL9l3A>
    <xmx:TMKoZshiDIECZs4Hn4_i_JY2P0PAKWSwC7kunmNDwQ9tOmmuVAXlQA>
    <xmx:TMKoZnpbTBRWT2TQ-ErMO5evYU0kSY6DTJp6NkURp4kcWO-Jj5YK_A>
    <xmx:TMKoZnggyNECDIGjDELuuptf-qLAG5qPEP2HEgEh1-6a9Z0a-a4nG7ZV>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 400F5B6008D; Tue, 30 Jul 2024 06:37:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 12:36:39 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Torvalds" <torvalds@linuxfoundation.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Cc: "David Laight" <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Message-Id: <d9c9c4ac-c3b5-4936-bfd7-13d7260de33d@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wg7ip=Uu+xg+d7-vKS1Yt_hJHg+fJKDYgp-8W0BncUncw@mail.gmail.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <2f1be7ee-2d70-4dd3-bfa2-1b94a4fc5a66@lucifer.local>
 <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
 <CAHk-=wg7ip=Uu+xg+d7-vKS1Yt_hJHg+fJKDYgp-8W0BncUncw@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 06:10, Linus Torvalds wrote:
>
> Of course, I never did any build timings. I'm not sure how much it
> actually shows up on that level. A couple of bad cases won't be *that*
> noticeable when most cases aren't too horrid.

I did a little bit of build timing last week, which confirms
exactly what you expect here: On individual files, the difference
can easily be 1000x faster, like on that arch/x86/xen/setup.c
file, but overall the difference in build speed for an allmodconfig
or defconfig build was between 1% and 3%, depending on how many
of the extreme cases are included.

Of course, it would be easy to take one of the extreme cases and
add another expansion that then drives the memory usage and/or
compile time up to a point where the build fails.

       Arnd

