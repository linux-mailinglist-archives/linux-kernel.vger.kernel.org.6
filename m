Return-Path: <linux-kernel+bounces-275803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5CD9489F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174DB28682D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC8166313;
	Tue,  6 Aug 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QTxM5zhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJN1CAeT"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934F116B386
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928823; cv=none; b=Up3MQdLiOyzEsgOtmG/I7ZU6WrWJM5r4+krtTEP9EhMJCl0RyQEYjMiTULis69GpsEsT3lsPK8k6AD22DegZr5acmXRAuz26OO5+lSoP8d5t9vh8dgCLjEjeDDHsOuC+hgweOakJueVsoFC5hqxdVLcnq2YAll4cyXRDc4ot/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928823; c=relaxed/simple;
	bh=6Ke637poCP3H7nVjMrlHmXbYedgwNC+WpvtdybEwmzI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Skhx6Nt5HBqXhk511bS0z6k5XZAMrhpQdczLWBT03b2bgqL/PqffrlUao6+lJQ21oDwiEkPxkNFSWD9CrjBeCtbumgjZmjA2obzRw4RPWJARKu8Ranzvu+/YhK39Vfj2mau2SXfzqf9ulGX52Ub/5XArpWnWB2T2I6xVPR9NevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QTxM5zhc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJN1CAeT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B66891151B22;
	Tue,  6 Aug 2024 03:20:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 03:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722928820;
	 x=1723015220; bh=yVNzO8LiAkUMI0H0VxC2gmXpB6LFEvG4VZGhh289CKg=; b=
	QTxM5zhcOY1QuM3L9gnBTk6w3F+WFzrPB3z8rVyFF4vVzpURUyCS4RMkRiNOAupu
	Ta7w2EnQppHaB9iK8YXooqCNA2xktuty3XpkouMPD0XyuOM3VxbwlziO/A9sIwax
	xDo17PBWIox1QmCPS/PcjOFzPw+ddyoTb+eJ08TLzFySVPxWgBYB1U/Z1ee8mkMd
	2U1DzwIKBkthE5QJXjsZPvrOnHJCwCN/E2MfmLK8gjMBd6Tlpq+BbTk1VuliBu5K
	vMIDOGRt/3nb0sWJvhfLamKrUfTYmda+mykowvfkfyEvYZwU7Bou/9GmWakco33C
	QiRujLlVhGJ+9L2ebBmsKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722928820; x=
	1723015220; bh=yVNzO8LiAkUMI0H0VxC2gmXpB6LFEvG4VZGhh289CKg=; b=s
	JN1CAeTYBPYnntTSEHIj3xZK0Q+B+N34KT3hXsP5r2jrKl1WFmgQHa1ZErkxyQS4
	F4S66u+JesxFuPsZ2SUQwjGOG6tXCPxISGkmqswAx/HkkDckMY3npqWRgmfKOA0m
	mjhdRrMgLy6asoN588n7mNvr4TmULSEyLTv8Hgyo5gtLhXVJ3iyWmv5+6ciQt5L8
	4tX2igqoPGVd+gBXHmuoUDhJ2oKsbSB+B6EdHSPtt8mHbHmV7L7c2wN8X+EcbsNv
	nakZNSLkpsqYRA+unPcw4ibdI8VK5+Aty/s+1P5xGfrBmSvsm/PD/f2Q+7bSi4QM
	NAgw0Oeu6EH7k+LZspONw==
X-ME-Sender: <xms:tM6xZiPQfi4YTOO7I1AJzo4pb8AZbtowqX8tBgS7uO8gc0hYl84Tng>
    <xme:tM6xZg8tOD3O8SNjYhl0rD6f2ZXuDWXwuG_luxyCXURX1Ezz-S2Va2hz-DHxkeb0P
    kaSDsn72_XQA9mUPCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:tM6xZpQBmwwcMKO9_An6R7u2ZQs_t4c7DEyNBg3BPJSoJe_UwpdP5A>
    <xmx:tM6xZisQvrI382zVT19a6tCLqb3RKuTpVJIKbTMOosP6Ou4N8UGG5Q>
    <xmx:tM6xZqdIW0seACvTAgJzgVcI8m6Fpy2NBkMcx-goACj04qWNp1hFJA>
    <xmx:tM6xZm2V_mU5LF9D8hLLAedOaqRd11UP0XirdNUzbDQfRsC-s20ahw>
    <xmx:tM6xZgsZ0_jvJKtFXB_CZDToT47aRJd4YhIHU5T--GVj4xovKFjPVJBF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6886FB6008D; Tue,  6 Aug 2024 03:20:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Aug 2024 09:19:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Linus Walleij" <linus.walleij@linaro.org>, soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <3f7971e1-0576-417b-8aaa-c06e1697908f@app.fastmail.com>
In-Reply-To: <20240628180852.1738922-4-dmitry.torokhov@gmail.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <20240628180852.1738922-4-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/10] ARM: pxa/gumstix: convert vbus gpio to use software nodes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jun 28, 2024, at 20:08, Dmitry Torokhov wrote:
> Switch vbus gpios from using a custom GPIO lookup table to software
> properties using PROPERTY_ENTRY_GPIO() constructs which closely mimic
> device tree gpio properties.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I ran into some randconfig build failures with this one now:

> index c9f0f62187bd..b9eddc691097 100644
> --- a/arch/arm/mach-pxa/gumstix.c
> +++ b/arch/arm/mach-pxa/gumstix.c
> @@ -100,26 +100,22 @@ static void __init gumstix_mmc_init(void)
>  #endif
> 
>  #ifdef CONFIG_USB_PXA25X
> -static struct gpiod_lookup_table gumstix_gpio_vbus_gpiod_table = {
> -	.dev_id = "gpio-vbus",
> -	.table = {
> -		GPIO_LOOKUP("gpio-pxa", GPIO_GUMSTIX_USB_GPIOn,
> -			    "vbus", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("gpio-pxa", GPIO_GUMSTIX_USB_GPIOx,
> -			    "pullup", GPIO_ACTIVE_HIGH),
> -		{ },
> -	},
> +static const struct property_entry spitz_mci_props[] __initconst = {
> +	PROPERTY_ENTRY_GPIO("vbus-gpios", &pxa2xx_gpiochip_node,
> +			    GPIO_GUMSTIX_USB_GPIOn, GPIO_ACTIVE_HIGH),
> +	PROPERTY_ENTRY_GPIO("pullup-gpios", &pxa2xx_gpiochip_node,
> +			    GPIO_GUMSTIX_USB_GPIOx, GPIO_ACTIVE_HIGH),
> +	{ }
>  };
> 

This is missing a few #include, the name spitz_mci_props[]
is wrong for this file and the array is not referenced anywhere.

I assume the gumstix_gpio_vbus_info needs to be turned into
an swnode, but I haven't figured out how to do this.

Based on the recent board deprecation discussion, I expect
that there are no users and that we will remove this machine
early next year, so we don't need to care about making it
pretty now, but maybe you can send a patch to make it build
again.

    Arnd

