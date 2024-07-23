Return-Path: <linux-kernel+bounces-259663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E8939B17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D271C21BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52CA14E2E3;
	Tue, 23 Jul 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="R/AJStE6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNBov5Au"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4714C588
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717231; cv=none; b=jqI65ciMYkKJl+ch/AgjEWp7gZvvodcgqCbZ1gOQWhx78SLE+zANA6xTyHfTLow6t6yPLAi3myRcgurMhbkkwZlZEncgDZ5HX4Q+5WyX7iC6/55hN0xNWNnZsZ6gM1qyQ/IwjbeBUTiEVA7ktPjXu4b4xI4eIqNnJoLkVQ0S/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717231; c=relaxed/simple;
	bh=rdsl43wqViNyOkcSob+ypx/bgmSJeTjyX/tPYHtox2Q=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=s2y9DYFyBT9H7rj485eCQL/j6rY1Qs7iUDBpEROlFCt4EO63+GnQV2UNg/ZAyfAfccMcSfLjI3RWxUFtSrFzr+PC9nzj+eBb3lxWerrTifWSzXUIyZgiUjcCUx0jubvbVLIOiV6rn7WJmNE+o8y5m4wTL9U6jr9Afj1cKtfGkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=R/AJStE6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNBov5Au; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2119C1140178;
	Tue, 23 Jul 2024 02:47:08 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute5.internal (MEProxy); Tue, 23 Jul 2024 02:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1721717228;
	 x=1721803628; bh=s07so1DLRy4G0iBOTj15rTc5zGbN0MeWZMyDnJgS5y0=; b=
	R/AJStE6B4apXHYoj6yADOE4yfkSFR3GJ42B68lCaQvbedvfdT00hLU299zvgXsj
	QOmPV8F/BocwvTX2Ys6kkn60x4T6UzeWml78kPLsojhBqbE64Sr8WnuXedugeX2E
	PA4tSHz4xHGxVAQfg0dRgHMEsQIUGOBRKJsJyMEWn0+EUnpuO0yZ3wwcBEB7p8UN
	oJu9BPFE356lwgmffhi/vOrfTa8JFCk8ukIUVzPueRJpAsas4YSnGlh+N/AUefvT
	hrLFKkgbigOw5Txh1eBxGpm4pJhXzUdgS9KTvyLJTpmr9YHSw4Vc8EiVU9hYkw7g
	1gGoJpkiGppj3OxthjeacQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721717228; x=
	1721803628; bh=s07so1DLRy4G0iBOTj15rTc5zGbN0MeWZMyDnJgS5y0=; b=D
	NBov5Au/idvtLYdhHJy5rx5vnqYC4JlNOu1lsi8C1qjoAWEY4dyatejg8sb/fJvT
	cLKRGpM09kz4me1c7d7DOFOjm6PPC4AlXUZY+6i245L+cg4M0PTl2ad2gjdhWojI
	OVBbxJDEqmDUH005SxRbEORCQFMghwdCvtspBe6dnqcxEFh2nSgrcjr9zW9TAjfq
	1/i8KDtahYkVvNv5iGw4ZmSz0nvfkpcGzyVUe9PXnzvNUbLUKndmtjoDggqJdcf6
	BhmAXFaksOpK0zJy/6ajogmsyfzFwdgklkDQcqsC8TFBEYERs+A6Ix85EnkKLUln
	eJSbJdmgJ5V26ZmKcPzkw==
X-ME-Sender: <xms:7FGfZjNRiMvhlRnw-vd2guoIBEg2W7I48eEHYEM7TT6s36qd-oHu8g>
    <xme:7FGfZt-A-H5l3byi3-j5U9dPvX1BVIpAlHwyvj4T4_dwlhYsKvLfgQoQPEZgFSXCN
    FCflmmFbj8kSEDDT-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheekgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:7FGfZiSRi3qo54BMR6eEbO9G2VA2rnwyY0E-DJUS4QBTqX91YpP4NA>
    <xmx:7FGfZnuQ5tsd7VuVJB7dcBYV1xTBccUYriuMUGNgtcBL5aZQvlRpzQ>
    <xmx:7FGfZrfKod79ETiKWo110hXDCRkom7iJzldbTkPmtNQEpMtLYlzZQQ>
    <xmx:7FGfZj1Wnjrd3jgjGssG3vg3O0wzIkwaBemisccFz9WA7UidG-6Upg>
    <xmx:7FGfZjRpyFS7RWzDcmD4Nw3YkHmLu6JAwGQKlRTN_Pv6VnFI8U5U7Dz8>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E8AA719C0069; Tue, 23 Jul 2024 02:47:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <46775654-4c2c-4048-9f1d-bd464bbca25e@app.fastmail.com>
In-Reply-To: <20240723064508.35560-1-chenhuacai@loongson.cn>
References: <20240723064508.35560-1-chenhuacai@loongson.cn>
Date: Tue, 23 Jul 2024 14:46:47 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Xuefeng Li" <lixuefeng@loongson.cn>, "Huacai Chen" <chenhuacai@gmail.com>,
 "Miao Wang" <shankerwangmiao@gmail.com>
Subject: Re: [PATCH] irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B47=E6=9C=8823=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=882:45=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> lpic_gsi_to_irq() should return a valid irq if acpi_register_gsi()
> succeed, and return 0 otherwise. But now lpic_gsi_to_irq() converts
> a negative return value of acpi_register_gsi() to a positive value
> silently, so fix it.
>
> Reported-by: Miao Wang <shankerwangmiao@gmail.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  drivers/irqchip/irq-loongarch-cpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongarch-cpu.c=20
> b/drivers/irqchip/irq-loongarch-cpu.c
> index 9d8f2c406043..b35903a06902 100644
> --- a/drivers/irqchip/irq-loongarch-cpu.c
> +++ b/drivers/irqchip/irq-loongarch-cpu.c
> @@ -18,11 +18,13 @@ struct fwnode_handle *cpuintc_handle;
>=20
>  static u32 lpic_gsi_to_irq(u32 gsi)
>  {
> +	int irq =3D 0;
> +
>  	/* Only pch irqdomain transferring is required for LoongArch. */
>  	if (gsi >=3D GSI_MIN_PCH_IRQ && gsi <=3D GSI_MAX_PCH_IRQ)
> -		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTI=
VE_HIGH);
> +		irq =3D acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACT=
IVE_HIGH);
>=20
> -	return 0;
> +	return (irq > 0) ? irq : 0;
>  }
>=20
>  static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
> --=20
> 2.43.5

--=20
- Jiaxun

