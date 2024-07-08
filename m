Return-Path: <linux-kernel+bounces-243911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16900929C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A891F20EED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A71946F;
	Mon,  8 Jul 2024 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fzG1gRqm"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9D13ACC;
	Mon,  8 Jul 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420333; cv=none; b=tuDz8uFP7CL91DJajQL89BnOgk+UaWQaKX/MsUxfPqJjGL/XFQSq88IpqwbNEfmqGMlklGP67IbW8XetMHXFh75ySjpsBwBOxd9vL03fjxazk2bjPbhYs8ZL+mpf9i90uBreYgvSmpiUpFvmKcU57V/qE34s5PCAvd//far0GHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420333; c=relaxed/simple;
	bh=MfvnS3Fr/pK2xtlWcPjC9k8Ba/za3rBMtC1UX2N6TEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIZlebAL7coKd1/dSsLY8rqtCizrJdan5tW11bVHyR946G+tlBrP4Q6mORNoMoGqMFuvFZFaMxXQkrRGtW5TH4jEhrzYdVPz3h/iSjHNhmX00Z0kJYu9RSlCgEkorURwVN8EjCSkxFO/JcTQAXs3oxqLoos5Dm8W9uD6vM7qpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fzG1gRqm; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2FCA240002;
	Mon,  8 Jul 2024 06:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720420329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zswb2gaNk97IllrUQU0TFGiZRh24Vb8Y3fvPz5plUKU=;
	b=fzG1gRqmIDEWc3fYATYksDzGI8ZrqUI/CfhwYuLiIopj8ghqO3wCtDZ8/imikhLkjXIKPs
	W1ITFue87n7DHbcqz3vN/DgUebRyjMCbCjUuacSWTzUa9tycPA51XtiNbr8mG9b1IMwBrr
	jACBN/4ZB8B8ft3woQFQGgpODB+DvdCeeAo2x/4SwoG+0WzTT9eafTX7J6NWCdPlUZSjew
	McPfkYaTTzZnY7HfxW97VqLGF8T88JivBP2KWitplNheLfKK3+QUu+3Evs76sq+/8i790u
	Ua3TZXSml0RTF20SvzP8zDvUccqmeJVPu6bHLiP7xCZGkFo6DxFC3N08HOnXQg==
Date: Mon, 8 Jul 2024 08:32:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
Message-ID: <20240708083208.322f4418@xps-13>
In-Reply-To: <20240705225821.13196-1-zajec5@gmail.com>
References: <20240705225821.13196-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Sat,  6 Jul 2024 00:58:21 +0200:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> U-Boot environment variables can be stored in various data sources. MTD
> is just one of available options. Refactor DT binding into a layout so
> it can be used with UBI volumes and other NVMEM devices.
>=20
> Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> I'm sending this PATCH without Linux changes to see if this is the
> right approach - for developers and (DT) maintainers to review it first.
>=20
> My previous attempt (see above Link) turned out in refusal so I'm just
> trying to save some time in case this one goes wrong as well.
>=20
> Hopefully the included example (which I really think we should add)
> explains well how I think this binding should be used with layouts.
>=20
> If I get some positive feedback I'll work on V2 with actual Linux
> changes.
>=20

I am still in favor of this change. I know from a binding perspective
it might be questionable; but from an OS perspective it makes total
sense to deprecated the old U-Boot env "device" driver in favor of this.

Thanks,
Miqu=C3=A8l

