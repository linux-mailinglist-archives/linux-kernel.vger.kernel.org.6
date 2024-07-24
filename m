Return-Path: <linux-kernel+bounces-261306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF293B582
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206891F24331
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325315ECE6;
	Wed, 24 Jul 2024 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvUd741z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDD282FA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840636; cv=none; b=hzBo38Zh0V2jhXxpJPSUL/9b0vDhT7Q2WxYxFWI5fPT2HwWUiS6i5ujt7OOzNxoxAod0uO7EUmyKUAd0bmJ/QK4tI4s+Cb4Ye8GsmV865ikTor7bxIMFlXOgOaaqDR9AywTtUBqH5DGdkClQcKxZsOCmh0uUxW6YNKx8CwhwYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840636; c=relaxed/simple;
	bh=smkGN635WhWDUOwM+//l44ZCUmX0jZ/3ahNcGTJchAs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LfDRUYmFRmkoy+Gwg4M5pMA//kDUO+Oi0RHH3AhDOM3VXXjZYbC73J10L06ee0fh2g+Zf51ixSepfY0Vl3vFYswSPtGsbBOfviMcCM6Pf3GhKPornp923n2d0MuHanMrdH5CuXB5FCUOkF2PgkwGCOmEfv4d7n0PLunYj32DqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvUd741z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDADBC32786;
	Wed, 24 Jul 2024 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721840635;
	bh=smkGN635WhWDUOwM+//l44ZCUmX0jZ/3ahNcGTJchAs=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=IvUd741z876Cjp69kwtWot0fHuqsFZwvfkzmQXszddBJN3jNTd5BYvVFnbcoscL3h
	 Itekye0Lfan4nV1Rz+dM4VLBM7s24V1lFhxbS3R1C5ALEsm8X92c7J++1ESf1QV+GE
	 5us4Gkl1fpbGg01nQHrCuLo7JoWugR/ty4sxu+CWLhIFD4a6EOOBVvdimPHeUT+KJH
	 StRC5PMVrRxb0VbO5bp8cfkjW0/v8/WqzffnA+QchxO13CoXrZFQhyNDIYd/YMPEWM
	 qIMOX/xiHXI7DESPAxwocg/Cc5aC4/CtFbdCkn7VkDKaMzVVJJGE0j4usSs3I5/Ces
	 P1DuUJOFBebKw==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6A9091200043;
	Wed, 24 Jul 2024 13:03:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 13:03:52 -0400
X-ME-Sender: <xms:-DOhZlXdD4KSkzIdhQE_68_ZlB-lSID9qiSDn8HXv2oQBfDvCqBFFA>
    <xme:-DOhZlm37amT2PlhDp7O_uMMhYV4geJ8IZmp3YzVFN8ZBJwY7pZ7ARfYdAk3XX3tB
    s0Y46am69lwWnuFusk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:-DOhZhZfXRiEZmmtGYsQI6F4pxzWE0cVfDERbRYIaqSjeA4JZB48gg>
    <xmx:-DOhZoWsWkTgZveXy1bV01g0rtDmfbO-KW2ZoibaRFUSGaeOMmOGRw>
    <xmx:-DOhZvm2ei5XJMb5h6NRCZDLLyFnFL7NB7dWt4dJcvA8FX3oSFrjiQ>
    <xmx:-DOhZlc6Fic4-mMgGXWWhUDhIC-3UI-_tkmvTrmEs3TzLBkNTRuRMQ>
    <xmx:-DOhZpGSskkWLkqzxL5wcndF5hxkvQ5IJhLyJXC9C21AeCqt3AnJCU_z>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2B4A6B60093; Wed, 24 Jul 2024 13:03:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1bb3d09c-3b34-4348-8d6f-bd867704625c@app.fastmail.com>
In-Reply-To: <3484b7fcd2c74655bd685e5a7030c284@AcuMS.aculab.com>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <3484b7fcd2c74655bd685e5a7030c284@AcuMS.aculab.com>
Date: Wed, 24 Jul 2024 19:03:31 +0200
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
Subject: Re: [PATCH 7/7] minmax: minmax: Add __types_ok3() and optimise defines with 3
 arguments
Content-Type: text/plain

On Wed, Jul 24, 2024, at 16:33, David Laight wrote:
> min3() and max3() were added to optimise nested min(x, min(y, z))
> sequences, bit only moved where the expansion was requiested.
>
> Add a separate implementation for 3 argument calls.
> These are never required to generate constant expressiions to
> remove that logic.
>
> Signed-off-by: David Laight <david.laight@aculab.com>

This brings another 3x improvement in the size of the expansion
and build speed.

> +#define __cmp_once3(op, x, y, z, uniq) ({	\
> +	typeof(x) __x_##uniq = (x);		\
> +	typeof(x) __y_##uniq = (y);		\
> +	typeof(x) __z_##uniq = (z);		\
> +	__cmp(op, __cmp(op, __x_##uniq, __y_##uniq), __z_##uniq); })

This still has a nested call to __cmp(), which makes the
resulting expression bigger than necessary.

The three typeof(x) should be x/y/z, right? Using __auto_type
would avoid the bug and also remove one more variable expansion.

Using another temporary variable, plus the use of __auto_type
brings the example line from xen/setup.c down 750KB to 530KB,
and the compile speed from 0.5s to 0.34s. 

 #define __cmp_once3(op, x, y, z, uniq) ({      \
       __auto_type __x_##uniq = (x);           \
       __auto_type __y_##uniq = (y);           \
       __auto_type __z_##uniq = (z);           \
       __auto_type __xy##uniq = __cmp(op, __x_##uniq, __y_##uniq); \
       __cmp(op, __xy_##uniq, __z_##uniq); })

The __auto_type change can also be applied to the other typeof()
in this file.

      Arnd

