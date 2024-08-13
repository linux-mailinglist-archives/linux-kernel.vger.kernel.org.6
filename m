Return-Path: <linux-kernel+bounces-284750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9569504B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728AE1F233A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7017D345;
	Tue, 13 Aug 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="r26n4vCU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHpSXUKz"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC51990AD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551310; cv=none; b=NXVtKyUqPQPmmGxB7lCHAUlcuAbaJ0BkPAWPdP6CXSnUOyrTpS9ivao1wRIjeWemiePZl3tWSbWsWgYJYDUkrwnVIBoKc8vufW4MKyS8Aiuj8rDY/Cija11x8F0fNRwa63HRBSOiDyvUVZfbARPhhgsMshMB6A6pZmIdtMyGarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551310; c=relaxed/simple;
	bh=dx796VhjmO843byt+mnLduUbr/0a4t5ggKZEQlfoaI4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IPkuFcR8FRegfPQXz3LXrXE1QBqEwbYJcVrxvwAKvP3p/RCBt0p7wlOf9eSl4aCaQPzlITsYy0U5A5cssGgLgbENycx+GMiS0Nf+X6UcsG2LkrBKKI8XjaWuHtEYRPJILDlwAPGZknJWsrsGzpzMbHSSLzSg0YVMJiAtxZ2PGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=r26n4vCU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHpSXUKz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7CA4D138FD8B;
	Tue, 13 Aug 2024 08:15:07 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 08:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723551307;
	 x=1723637707; bh=hf+XpJftr/yARgkX8SCc/syV29CdeZlrpAmAw+8JxVk=; b=
	r26n4vCUogWVf2cfYIS9OPG+yQMg33JuMc1B5ckaUnYCT7bmVUxVDb3sRMuEnMvs
	Z5ojRRZ/oxGp06OuC5JGHbnfpU/6vh98hHZ6F8o1oPOWcgJg3bWRRfiruzx0yuEo
	171j6gikJ2AusSs5q24wJP3PdpXwCmwGCXikU84jVSt45T+VHz02AqG+FT8wyeVo
	nIoLGcnEmULNeLVn8hquakzvkc6wI3k3y8SME1NaLHRuEXwNLzo8GGmQ+LBN1J09
	qWOpytwiGm7BdPMRYLMNfq90fSditRrEBeQ34uVBhXxlJv4iJIYDVR3kSG9Qui3m
	VUtZUhE1Bqejc/nuQc1qdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723551307; x=
	1723637707; bh=hf+XpJftr/yARgkX8SCc/syV29CdeZlrpAmAw+8JxVk=; b=B
	HpSXUKzgZ8ccy0tQipw9XF5ByuEDZbmamh5k2XjUxqpiriifJX217IuhUli7BzEW
	V3cEQGN8DnYoDN8+zenJy0TmEOFK8HET+mEAASfqmwmL18uviUgMMoyQwuNDv9mQ
	R3+Y8rTCq5qgF3VSSrKM16wNsuuqDNgdldSZhHjCsqvPdbg1W3y82KWE8Vs2MiGV
	LJGC44fcNEEn9imm1r9ljZQ62LflkNegTokuDYolX8L36+KVBodtJBgJ8B4R+BaU
	VWUKHM/VBwMLHCkMzB+S2CHO2FXVQOW/7CuDFKYgg0Y3umNRMd+jVB1k+Nu8Gj+h
	qczgP7NQsM6I+Dk2zOocg==
X-ME-Sender: <xms:S067ZlNjc7VsViLKIIUPGjbAXrt1Vd_7rbcLLS6TPzzJABf69CQM0A>
    <xme:S067Zn_417_xg5Yw2N4whdZCdaw1OPYtkzXV47MfZEivC8TeX7fGfKuzY0zbtcaBM
    l81tzyN0wtg-VxaB6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrthhtihdrvhgrihhtthhinhgvnhesfhhirdhrohhhmhgvuhhrohhpvgdrtgho
    mhdprhgtphhtthhopehmrgiiiihivghsrggttghouhhnthesghhmrghilhdrtghomhdprh
    gtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonh
    higidruggvpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:S067ZkRAq-a5fdh2Zzrq46pRqjxD_ELvUDcBV0ADLJ88gWlNaZE8MQ>
    <xmx:S067ZhvhOo485zf36GbI2AFhQc2TifsWg3EgIfkhR7yDT6FJcY06xg>
    <xmx:S067Ztfed6Ae0RTRO4995h-EiHc2PUrmVqasbmYgzFi8mT2oZ6rmQw>
    <xmx:S067Zt2nWWZJa551YteGo9Qgl8fb8NVFnxuKUyTNszX8SIc6LVi6XA>
    <xmx:S067ZlRDHMY3NP8nwdP2MpXuXdJXnsbPVJX3cpuWFxdtktSA5LULiVj_>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4E8F419C0089; Tue, 13 Aug 2024 08:15:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 13:14:46 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>,
 "Matti Vaittinen" <matti.vaittinen@fi.rohmeurope.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Mark Brown" <broonie@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <f6aa806f-41fb-4051-9ee2-f039cd4fe0ce@app.fastmail.com>
In-Reply-To: <c3379142-10bc-4f14-b8ac-a46927aeac38@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <32d07bd79eb2b5416e24da9e9e8fe5955423dcf9.1723120028.git.mazziesaccount@gmail.com>
 <27033022-cdbe-40d9-8a97-cdc4d5c25dbe@flygoat.com>
 <78fabd1a-0c68-4e23-8293-89c56eb9010b@gmail.com>
 <c3379142-10bc-4f14-b8ac-a46927aeac38@gmail.com>
Subject: Re: [PATCH v2 1/3] irqdomain: simplify simple and legacy domain creation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B48=E6=9C=8813=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=881:02=EF=BC=8CMatti Vaittinen=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
>
> On 8/13/24 13:54, Matti Vaittinen wrote:
>> On 8/13/24 13:19, Jiaxun Yang wrote:
>>>
>>>
>>> On 2024/8/8 13:34, Matti Vaittinen wrote:
>>>> Move a bit more logic in the generic __irq_domain_instantiate() fro=
m the
>>>> irq_domain_create_simple() and the irq_domain_create_legacy(). This=
 does
>>>> simplify the irq_domain_create_simple() and irq_domain_create_legac=
y().
>>>> It will also ease the use of irq_domain_instantiate() instead of the
>>>> irq_domain_create_simple() or irq_domain_create_legacy() by allowin=
g the
>>>> callers of irq_domain_instantiate() to omit the IRQ association and
>>>> irq_desc allocation code.
>>>>
>>>> Reduce code duplication by introducing the hwirq_base and virq_base
>>>> members in the irq_domain_info structure, creating helper function
>>>> for allocating irq_descs, and moving logic from the .._legacy() and
>>>> the .._simple() to the more generic irq_domain_instantiate().
>>>
>>> Hi all,
>>>
>>> This patch currently in next had caused regression on MIPS systems.
>
> ...
>
>>> Do you have any idea on how should we fix it?
>
> This is quick'n dirty but do you think you could try following? (I hav=
e=20
> only compile-tested it). I'll also attach the patch as I have no idea =
if=20
> this mail client mutilates patches. I can send in proper format if it =
helps.

Can confirm it fixed booting!

Thanks for quick fix.

- Jiaxun

>
>
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> Date: Tue, 13 Aug 2024 14:34:27 +0300
> Subject: [PATCH] irqdomain: Fix irq_domain_create_legacy() when=20
> first_irq is 0
>
> The
> 70114e7f7585 ("irqdomain: Simplify simple and legacy domain creation")
> changed logic of calling the irq_domain_associate_many() from the
> irq_domain_create_legacy() when first_irq is set to 0. Before the chan=
ge,
> the irq_domain_associate_many() is unconditionally called inside the
> irq_domain_create_legacy(). After the change, the call is omitted when
> first_irq is set to 0. This breaks MIPS systemns where
> drivers/irqchip/irq-mips-cpu.c has irq_domain_add_legacy() called with
> first_irq set to 0.
>
> Fixes: 70114e7f7585 ("irqdomain: Simplify simple and legacy domain=20
> creation")
> Signed-off-by Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   kernel/irq/irqdomain.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 01001eb615ec..5be165399a96 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -300,7 +300,8 @@ static void irq_domain_instantiate_descs(const=20
> struct irq_domain_info *info)
>   }
>
>   static struct irq_domain *__irq_domain_instantiate(const struct=20
> irq_domain_info *info,
> -						   bool cond_alloc_descs)
> +						   bool cond_alloc_descs,
> +						   bool cond_force_associate)
>   {
>   	struct irq_domain *domain;
>   	int err;
> @@ -337,10 +338,9 @@ static struct irq_domain=20
> *__irq_domain_instantiate(const struct irq_domain_info
>   		irq_domain_instantiate_descs(info);
>
>   	/* Legacy interrupt domains have a fixed Linux interrupt number */
> -	if (info->virq_base > 0) {
> +	if (cond_force_associate || info->virq_base > 0)
>   		irq_domain_associate_many(domain, info->virq_base, info->hwirq_bas=
e,
>   					  info->size - info->hwirq_base);
> -	}
>
>   	return domain;
>
> @@ -360,7 +360,7 @@ static struct irq_domain=20
> *__irq_domain_instantiate(const struct irq_domain_info
>    */
>   struct irq_domain *irq_domain_instantiate(const struct irq_domain_in=
fo=20
> *info)
>   {
> -	return __irq_domain_instantiate(info, false);
> +	return __irq_domain_instantiate(info, false, false);
>   }
>   EXPORT_SYMBOL_GPL(irq_domain_instantiate);
>
> @@ -464,7 +464,7 @@ struct irq_domain *irq_domain_create_simple(struct=20
> fwnode_handle *fwnode,
>   		.ops		=3D ops,
>   		.host_data	=3D host_data,
>   	};
> -	struct irq_domain *domain =3D __irq_domain_instantiate(&info, true);
> +	struct irq_domain *domain =3D __irq_domain_instantiate(&info, true, =
false);
>
>   	return IS_ERR(domain) ? NULL : domain;
>   }
> @@ -513,7 +513,7 @@ struct irq_domain *irq_domain_create_legacy(struct=20
> fwnode_handle *fwnode,
>   		.ops		=3D ops,
>   		.host_data	=3D host_data,
>   	};
> -	struct irq_domain *domain =3D irq_domain_instantiate(&info);
> +	struct irq_domain *domain =3D __irq_domain_instantiate(&info, false,=
 true);
>
>   	return IS_ERR(domain) ? NULL : domain;
>   }
> --=20
> 2.45.2
>
>
>
> =E9=99=84=E4=BB=B6:
> * 0001-irqdomain-Fix-irq_domain_create_legacy-when-first_ir.patch

--=20
- Jiaxun

