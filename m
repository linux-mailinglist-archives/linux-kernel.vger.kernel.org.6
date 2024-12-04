Return-Path: <linux-kernel+bounces-432128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D39E45A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6621675EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03791F540A;
	Wed,  4 Dec 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FrdYlFeL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoC372Si"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F451A8F8F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344035; cv=none; b=lUFQp0FbFbQFy5nW/JTqtyj+50OmxUecKxht5oqZG1DuSZTvqSE4DvSnyTyscNzGIKZE3PBoI+VRUPJxeusyqTmei4gWBmRm2NyAJBG72vvvKdb6SrgyNLG7JOiK9so4VjuNJWLbqMydeR8H7Xf7RT21wVooKO0nTswCFbe3ZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344035; c=relaxed/simple;
	bh=YWDz2rw/VtBBgEToElJfhNzUPUB8iv01GQ/AnhJtj1c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GJE1j2VF5X0j7IPdmXqrI8CNIi+u2tcPg+m7x3OiBKdJQ3ut5ncChL5BzwL3SyCZUibi+SkbvfuMwMoutY8TLsz6goOt4YjQjpMQEVX653kNNQmj7XmAaAJ5y1spKt1aNdZKV4FdEpbi0ltN3yAqG3Jg8NiwYo5zvAmdhIHXwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FrdYlFeL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VoC372Si; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F1BC2540175;
	Wed,  4 Dec 2024 15:27:12 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 04 Dec 2024 15:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733344032;
	 x=1733430432; bh=d/fqbdyXYnQIJkEL5wpCgS2ho71pEmrqZ+q2QHL1fOQ=; b=
	FrdYlFeLhfoeRdtirln57jR5Av7M2mhiXk1RK4sQqU1eV4rYPojGXm6Bd+No+RsT
	7kRVAD2ILiSrkWxTFawm1S9UbSxW2oJsxp+LEgHbBw50+uxIbPe69Swlc9b7KVVn
	TmhglNH7Rnya9yHsMPWaHflYCBruCgap9tfE1h7EZMYciMFOhH62zmvOC3s6JO66
	SyTr6eW2wdMpmzyHlBOZCsy2Q1sSIxxW1erO9+b3qmHvNAE2hWwGTqVIsk0TzWeu
	EJJL2lp8mCG023rpEpNRfwID/FtCfTVUcHDq0I/jcjiF7iv5d02UXLjT9jhi3mgm
	mH6CtScgTNpZtq2ihvkmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733344032; x=
	1733430432; bh=d/fqbdyXYnQIJkEL5wpCgS2ho71pEmrqZ+q2QHL1fOQ=; b=V
	oC372Si1Xbq82FWMKiSgZVH987rt9xlUdu2yTfv55aJ0cnIYy0bOc1dItZPDGQo7
	VBxCKjNmpyYPjoJE8O8l9d2LCHePC/K6cF15UMgBuVuOa9GEvWjjf59AxT3prwmh
	xOOyQZuV0GRw5fyDNRLy4DSiQ33zNLdmr85PGH8au3g0cbqBFZBuyCtaA1IKXxkX
	8tToZKBE3wTl1AfThVQfXGWtsS3j7jx/0jgylEQFYDYArBNLKvlyAG67GYRnzan1
	EVTh/DuFdCnAZsDILRtaRvrYyWcRc4KGdpBDtojDRE0i03S+APUvKHjDB8OHmW4H
	znr1r7hCbgpf+NQFLkfsA==
X-ME-Sender: <xms:H7tQZ79FpT8Pc0Ntgw1ZETNHL_2xt2cGcLzpMbXiYmJvemL3Z4X58w>
    <xme:H7tQZ3toEsxYaEcnXp8WKAyPH95dLHkOTQas8MciC--mnJv2103NlbbRpw7_Hfi7y
    jIrABHhEQS7EN-c9KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugi
    drohhrghdruhhkpdhrtghpthhtohepthhonhihsegrthhomhhiuggvrdgtohhmpdhrtghp
    thhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtph
    htthhopehrohgsvghrthdrjhgrrhiimhhikhesfhhrvggvrdhfrhdprhgtphhtthhopehh
    rghojhhirghnrdiihhhurghnghesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhdrvghrihgtshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehsvggs
    rghsthhirghnrdhhvghsshgvlhgsrghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprggrrhhordhkohhskhhinhgvnhesihhkihdrfhhipdhrtghpthhtohepjhgvrhgvmhih
    sehjvghrvghmhihpvghpvghrrdgtohhm
X-ME-Proxy: <xmx:H7tQZ5BWeWD_YPsFYKwnrKXokpfiayhhnMTUvmGmsbEYxzSBJUgAOg>
    <xmx:H7tQZ3enEgmF5hy_GYpeecwGa6kYYDqqVuqhUoTWRt7lWJ9dvp3eng>
    <xmx:H7tQZwP8XW9NxY884Y6hTXO4JybHckMsHyn6EG2dim0ofmVR-bpIZQ>
    <xmx:H7tQZ5mbGUl9ICwIcGUm9jejpkqaagJmRzjlcGyTHQ_TFN8zI9ZghQ>
    <xmx:ILtQZ7G3WRj8VnTGKxAWXRVfuq_F8fmgDN1kN6guJY_QZpMpTJ3jycM8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F0C12220072; Wed,  4 Dec 2024 15:27:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 21:26:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Andrew Lunn" <andrew@lunn.ch>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Daniel Mack" <daniel@zonque.org>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Jeremy J. Peper" <jeremy@jeremypeper.com>,
 "Kristoffer Ericson" <kristoffer.ericson@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Mark Brown" <broonie@kernel.org>,
 "Ralph Siemsen" <ralph.siemsen@linaro.org>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Russell King" <linux@armlinux.org.uk>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
 "Tony Lindgren" <tony@atomide.com>
Message-Id: <7ff7afbe-938f-4eb3-b970-331a177c7348@app.fastmail.com>
In-Reply-To: 
 <CACRpkdYws_rfGPe--xj8d4Gu1pON=_T2sSAoTi3=sMz7wpSFHQ@mail.gmail.com>
References: <20241204102904.1863796-1-arnd@kernel.org>
 <20241204102904.1863796-4-arnd@kernel.org>
 <CACRpkdYws_rfGPe--xj8d4Gu1pON=_T2sSAoTi3=sMz7wpSFHQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] ARM: rework ARM11 CPU selection logic
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024, at 15:02, Linus Walleij wrote:
> On Wed, Dec 4, 2024 at 11:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>>  - Eukrea CPUIMX35 reference platform
>>  - Freescale/NXP i.MX35 Product Development Kit
>>  - ARM Integrator/CP/IM-LT3 with ARM1136J Core Tile
>
> I can't test that, I doubt anyone can. I think this support can
> be simply deleted unless there is some QEMU support or
> so.
>
>>  - ARM Realview/EB with ARM1136J Core Tile
>
> I will check if I have this one, otherwise this can probably go
> as well.

To clarify, these two do not add any maintenance burden.
Yes, we can probably remove them, but we can also just
keep them around for as long as i.MX35 is supported. Once
we drop i.MX35 it makes sense to leave only the ARM1176
CPUs supported in ARMv6K and reduce the possible feature
set.

       Arnd

