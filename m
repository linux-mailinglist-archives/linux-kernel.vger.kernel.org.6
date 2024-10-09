Return-Path: <linux-kernel+bounces-357995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F49978F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A929E1F2372B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876601E32A4;
	Wed,  9 Oct 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="WivgpZJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7Vy/u3C"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDB18F2FC;
	Wed,  9 Oct 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515486; cv=none; b=m6Q2S3k6C/kc+Iqw/HjdQb8FzT9dElvOBqs/Oo00Xr6zrv1QdokIIWDKvPkB+l5O7m+KLYyHuonwHz3+PIQueDzf3P2Jj5EvV/XMRaFoKgkhdqILhbKZjCPXxRsMl/9dsnusfCCNYpPMaPno6QxcgyJUion5LGIoOuGq8WydGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515486; c=relaxed/simple;
	bh=l4oKUFrW4lmzGYDKWMYkL/e1BuB8+vTVtVHwhIhs7vo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=clU5N1ELNCl9T0TiFihYWS0dUece+a4HO3sRGdFUt5ITkTShho9BVslMTDNHHgKo9y1tus49ruvFzv8JAsFBcos5mgepdZzwLAACuKN/BE+SaS9wkBzISnALcHgAVLmtoIivHaHCgA2P4HorCWL/ceRSV9JjMumQBC+6RAcsgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=WivgpZJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7Vy/u3C; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3220C1140143;
	Wed,  9 Oct 2024 19:11:23 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Wed, 09 Oct 2024 19:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1728515483;
	 x=1728601883; bh=Y0i7adaokPwtvUUCZ6jWeYXB53TyTzR0n+FD0+0wALA=; b=
	WivgpZJFcguR3xdtSQhydWGGQP3/DV5YxsseXvHfiteyFx8zrxunoCoHeYvabZOJ
	A3gPYfAcWkYmVZYFrJaFgP2l/bsEpCNMhM6PdkhZ8UPoiYgA+RMcosxy73P4/CW+
	AGkrD5R3s+BwAS/zEPSOtkgz0Zv/WQ+TGRxpQgRYCRGPTEWC7nJRQ/3jmvqBBEw+
	SeHDT+2MULjWAy2NoKKsTxbmG2poeNZ+DpAKw63W2WrO79IXQYTp3BV+M+0OxH8Y
	k2WWYk18KxaSfE7t/t9mF6dL/Hc3X/KkzdQFB/c9iDwpPKzPcur5DpttcUig50bE
	KC5nfpKXBRn54H7W98kSgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728515483; x=
	1728601883; bh=Y0i7adaokPwtvUUCZ6jWeYXB53TyTzR0n+FD0+0wALA=; b=c
	7Vy/u3CBSZJA+M5xuJZeN/EUdeFX6TpVqBGTBZxnb3HIkxmeOAXtqLf/0O8txVED
	4Km9+WTsLvkNEIuR/M+KIs5w69QHtxoSQyVVbb1mygfM64DGofbNAa2LqA/peQ2x
	+A2ytCfz8VWmEKMWG3eOEXTFK13v3i6ZdvXk91kwkI7eap/syevoxHr1N4ACyLOL
	bqFVCa7D2viEcAlETPkn6au0mV3ewpaYie0HKjRfjZeV3CTG4aQKbDlLZuGs15Fg
	SRMrS6jtglurAC3GF61ZGkgcBn+0/6/HKR8Q9ldlo5DMILIRxy0iK/Q+LjYBL3zb
	vMUj8M0lfGOzYmeyN0VeA==
X-ME-Sender: <xms:mg0HZy7Zepu6JLU8-Bd0kcpb2DzDuz7OlSeBjGMN71ObGAwUzUvEvw>
    <xme:mg0HZ77oy_Sano-utenRqNsyuIu0dPu-BewTuaVnNrORHtqjoeGWZOrDv35XVH9R0
    gs_PhU8bw9ki612Vgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpeevteelkeefueeuleejveetueetvefggfeuledvhfdv
    gedvheelfeelkefhgfetheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhho
    nhgvshdruggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtph
    htthhopegrsgguuhhlrdhrrghhihhmsehmhiihrghhohhordgtohhmpdhrtghpthhtohep
    hhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrthhfohhr
    mhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mg0HZxcldbjKcve210pptAqe9nLDPXmMTwhKCkVfXkQF4ecUQtWzfA>
    <xmx:mg0HZ_LgSjG1PoBRc9hwVYX9R7Sw2rWMjHcL7auMWa6aVQHv_MPwvQ>
    <xmx:mg0HZ2L3VrryJKRgrkxFaREP_M75Kzr6ZPFXz1bnKKfPQjpHCE385A>
    <xmx:mg0HZwz9hwQ8gDh6cQpbs_WGh6MkC8Fpa1Tjw2oi8X1XnX3zbJz03g>
    <xmx:mw0HZ7E4mXmnUVUnOI0sF-imexg-XHfG4JFQVpQ4SQ6T58XWCszDeg-T>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FC403360077; Wed,  9 Oct 2024 19:11:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 12:10:48 +1300
From: "Luke Jones" <luke@ljones.dev>
To: "Abdul Rahim" <abdul.rahim@myyahoo.com>, corentin.chary@gmail.com,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5cb4ed29-0039-432a-be2f-629aa7e1278c@app.fastmail.com>
In-Reply-To: <20241009230558.51892-1-abdul.rahim@myyahoo.com>
References: <20241009230558.51892-1-abdul.rahim.ref@myyahoo.com>
 <20241009230558.51892-1-abdul.rahim@myyahoo.com>
Subject: Re: [PATCH] asus-laptop: prefer strscpy() over strcpy()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024, at 12:05 PM, Abdul Rahim wrote:
> The function strcpy() is depreciated and potentially unsafe. It performs
> no bounds checking on the destination buffer. This could result in
> linear overflows beyond the end of the buffer, leading to all kinds of
> misbehaviors. The safe replacement is strscpy() [1].
>
> this fixes checkpatch warning:
>     WARNING: Prefer strscpy over strcpy
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>  drivers/platform/x86/asus-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-laptop.c 
> b/drivers/platform/x86/asus-laptop.c
> index 9d7e6b712abf..d460dd194f19 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1832,8 +1832,8 @@ static int asus_acpi_add(struct acpi_device 
> *device)
>  	if (!asus)
>  		return -ENOMEM;
>  	asus->handle = device->handle;
> -	strcpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
> +	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
> +	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
>  	device->driver_data = asus;
>  	asus->device = device;
> 
> -- 
> 2.43.0

Looks good, thank you for doing this.

Reviewed-by: Luke D. Jones <luke@ljones.dev>

