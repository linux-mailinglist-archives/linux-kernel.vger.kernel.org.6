Return-Path: <linux-kernel+bounces-261289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F193B53D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185D11F22AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81D15ECEA;
	Wed, 24 Jul 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnT6ZlhK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A80219E0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839759; cv=none; b=Opb7eMDXBkgHof6xHlPoFAF1TwnFbLvfEajTdCeWQ0qLLthA4x2GseO0aHADHbPC/Q03vvE6G7+SXY0bNTc6KHIVWxtc+UH8UhzmhQVAOia0p/TvBc/HWefJzDVNQFxcaQb40QsavYgmbT3CscKiTzvi78HpHEN4kg/XFBlPjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839759; c=relaxed/simple;
	bh=FqPmnPvkXsNLqU723bsoiovxks5vbJ26J89jMhJn3o0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oXxslUwGsL9MROdt1TymnFCLH6TjOY4WMQ+BfjN0gnjfQvh2gkwfzmpyBqIWyZvdF/Xj3dKA36Z386by9qjNFyX/y0NiwLlGCRyrbcRPqICmC9fXSWLpQB5fx7XMwpConUAKjEVYBo6ai7Adt8uv6uigJSaxbe+RpdNJm6j2+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnT6ZlhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F208DC32786;
	Wed, 24 Jul 2024 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721839758;
	bh=FqPmnPvkXsNLqU723bsoiovxks5vbJ26J89jMhJn3o0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=nnT6ZlhKXcJogU2JNoQO8vRFRfgIntS3zQyCIB8hKIQKEMMcPkXt06BKYhdY1/FCg
	 fNYA0WVdQLMczaNHZgkHLfgKdW7i+9UbXJRSKBHHuqNQKMF+a04+RQMOp5OQ/0uVQz
	 DTj8ewQJdG2G0zX93xqKFdsrhmD06zi6JYD6qlFc51mHqyNGm1/BT+4YDKE3q98q0V
	 frpVKrnzgt6HMFcUcakldWuKGERZBe91hKGzYGXT57WtVkvm+pkrPql90Gl6CkPqQo
	 tIDiwn/oUhKQOoh0/zg3LnfI8nsnk/xzQEh2FIG2tE3BFHwBVckG125wNXDlwniQUf
	 ZOKYsy6Aggq0g==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D59191200066;
	Wed, 24 Jul 2024 12:49:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 12:49:16 -0400
X-ME-Sender: <xms:jDChZrVEG_-n829d04f8NobiJZVkZdFAyR8uJ7S6gFP61rST0ciufA>
    <xme:jDChZjn7KLNnTu-XxMNdpXosGStBJbgH9cI2K9a2ybG-B442H7fwfeY5Xo9g_Clu4
    G-AE3hEHJB-MTrkX1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:jDChZnaFFBg5C0yIADp152HiZKuF_iyJAYMBa4ZZrKd_3mUO5tx8dA>
    <xmx:jDChZmVDUFIIrTDoNtRYJIc9JoniF1Gv-UUd52i3LxXCaqaNxWcNaw>
    <xmx:jDChZlk0GRy_MVKzXoH0oaAbCSknLwJ2rUv220RAyEFF2R52LjLvgA>
    <xmx:jDChZjfctYyAALIdXLaLTrdrganxhnlYQH25O45aWRhjGrDVvKg70Q>
    <xmx:jDChZvG-mXRVzT2s998nrBWv_ZjtlfrHPygtikdR3zgCML4gGXve4-DN>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A420EB60092; Wed, 24 Jul 2024 12:49:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef130c0a-b82f-472f-8c53-f7ef4c236c44@app.fastmail.com>
In-Reply-To: <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
Date: Wed, 24 Jul 2024 18:48:23 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "David Laight" <David.Laight@aculab.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>
Cc: "Matthew Wilcox" <willy@infradead.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "'linux-mm@kvack.org'" <linux-mm@kvack.org>
Subject: Re: [PATCH 4/7] minmax: Simplify signedness check
Content-Type: text/plain

On Wed, Jul 24, 2024, at 16:30, David Laight wrote:
> It is enough to check that both 'x' and 'y' are valid for either
> a signed compare or an unsigned compare.
> For unsigned they must be an unsigned type or a positive constant.
> For signed they must be signed after unsigned char/short are promoted.
>
> Order the expressions to avoid warnings about comparisons that are
> always true.
>
> Signed-off-by: David Laight <david.laight@aculab.com>

This patch gives me a 10x speedup on compiling arch/x86/xen/setup.c,
taking it from 15 seconds to 1.5 seconds for a defconfig+CONFIG_XEN
build.

>+/* Allow unsigned compares against non-negative signed constants. */
>+#define __is_ok_unsigned(x) \
>+	((is_unsigned_type(typeof(x)) ? 0 : __if_constexpr(x, (x) + 0, -1)) >= 0)

I don't understand why this return '0' for unsigned types,
shouldn't this be

((is_unsigned_type(typeof(x)) ? 1 : __if_constexpr(x, (x) + 0, -1)) >= 0)

?

    Arnd

