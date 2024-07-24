Return-Path: <linux-kernel+bounces-260779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176E93AE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A27B21082
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849814C59B;
	Wed, 24 Jul 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ1onFNc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD914A61E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811077; cv=none; b=g6/FhSdpYwp62xzxz+E3FtDG+KNDP16W6rq9XyVg0eWEfX5Yde2zaHeYUwR+QlwfIW3OMWep56VG6bKZGPnVBX+hmAtxDUvLx2gHsUQSkgAstFAVaa5fIJwMpbn4Ht1S/PxFUjaMMCFzNbIDqFFZ3cjIyp/o95Q/jHwKBhp6KF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811077; c=relaxed/simple;
	bh=16ld9DZqEwyZoRfMYqZqjWOMC+8ShJzWuY/QRyLtU80=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=srRfxPny4RVgrankuNZ3GB49UpMcNYczWvCfZUUsJ3Q82cot3IcEQylNn8I4wFsLd59znJk1FQF+BxNFoEGm3Ne8+ooG37KbwA/Y3G53FmD1Ey/aIgCFUJZYBgptrORw4Vgev1e9FAIOeZjq32S10GeWYWkKd5jFbirJnt0/J1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ1onFNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F3C4AF0F;
	Wed, 24 Jul 2024 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721811076;
	bh=16ld9DZqEwyZoRfMYqZqjWOMC+8ShJzWuY/QRyLtU80=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=jQ1onFNcR4Yyg0jc9K7q30wxYSifuQ/UPXnT7uJj8p9+wKWYl7v7elB9snXjgMS5d
	 jKkff3jA0kVuQnWo2Pwhhz3F2jVYgDGKHRfprkqf6ZicWg9+T4fPFCWAHvzYCxhhNs
	 fQaULRcJBV7/wTo3lJs3OZf33Zn6Rp405Nq6+Cch35wzUkRgMGj6RghH96RpCE2cOr
	 UIe9OIAKj3N+Cvg++mXkP0sqmV6ZFJ06/iNGJ0DkHwDENhLFDOQHkBTZJwgpar7nOD
	 A0eyVCIpd5joi4NBR86yz5rKbQiVCR0RHNDORIwVvGIIzxGgSUf3O1xRv7pFI4cF4y
	 D366WSz4cj8ww==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AA96A120006E;
	Wed, 24 Jul 2024 04:51:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 04:51:14 -0400
X-ME-Sender: <xms:gsCgZsbnLpIB6XGu_Ntdlev5DcqH4HcASnwksdpnPUDwLwx8V7q3aA>
    <xme:gsCgZnavsghU0XuT42wZkotmzgBhN0SnTRckVSqwVRXPYrYg6JMmKnvrw3aZa7GR7
    FutXl5PMkNimC0ly_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveevtefh
    feejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:gsCgZm8R4UllEcviVm2A8_dRcSNc5pi-d3cxFDMW2Fwu0k_Eo2p1kg>
    <xmx:gsCgZmqStUNeZZ-4sRDMz6CvWhm1k57SP2GJ83Tgf6qVJd3T8cBohw>
    <xmx:gsCgZnpX1hdIkiky7xDhKjQQUsI7oxa4iBuucQu9VclXmsyW0hLPZQ>
    <xmx:gsCgZkR3Oaq6bWke6-xRGS3Qwm4WTvHpaVv9bYeZ-l8AECO-hvXZmA>
    <xmx:gsCgZnpx7HgMJq-J8a1yePeQO-3OFGkxUA4EvVQhGMbDULSvlCiXxS1Z>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7DDBFB6008D; Wed, 24 Jul 2024 04:51:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2a1024f7-af7f-474f-8b1c-aa5e0d4bd17a@app.fastmail.com>
In-Reply-To: <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
Date: Wed, 24 Jul 2024 10:50:54 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Juergen Gross" <jgross@suse.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Laight" <david.laight@aculab.com>
Cc: "Matthew Wilcox" <willy@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 pedro.falcato@gmail.com, "Mateusz Guzik" <mjguzik@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Build performance regressions originating from min()/max() macros
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024, at 10:14, J=C3=BCrgen Gro=C3=9F wrote:
> On 23.07.24 23:59, Lorenzo Stoakes wrote:
>>=20
>> And resulted in the generation of 47 MB (!) of pre-processor output.
>>=20
>> It seems a lot of code now relies on the relaxed conditions of the ne=
wly
>> changed min/max() macros, so the question is - what can we do to addr=
ess
>> these regressions?
>
> I can send a patch to simplify the problematic construct, but OTOH this
> will avoid only one particularly bad example.

It's probably a good idea do change the xen/setup.c file anyway,
as I haven't found any other file that had a regression this bad,
and it only needs a single temporary variable for a 1000x speedup.

For the overall kernel, I see at best a 2.3% speedup (20 second=20
CPU time) by replacing the current min()/max() macros with a version
that drops both the constant expression output feature and the
assertion, measuring an x86 defconfig build, which has xen
disabled. On a defconfig+xen kernel, that difference increases
to 4.4% or 37 seconds.

Removing only the constexpr side requires a handful of fixups
for x86 allmodconfig to replace min()/max() with something else in

drivers/edac/sb_edac.c
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
drivers/gpu/drm/drm_color_mgmt.c
drivers/input/touchscreen/cyttsp4_core.c
drivers/md/dm-integrity.c
drivers/net/can/usb/etas_es58x/es58x_devlink.c
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
fs/btrfs/tree-checker.c
lib/vsprintf.c
net/ipv4/proc.c
net/ipv6/proc.c

This gives about half the speed difference, the other
half comes from removing the assertion, but that is not
a good idea unless we can replace it with an equivalent
assertion that works on the unique_x/unique_y variables
instead of expanding the arguments.

     Arnd

