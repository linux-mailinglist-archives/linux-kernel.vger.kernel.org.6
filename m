Return-Path: <linux-kernel+bounces-301005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3D95EB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91561C20F74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED4A12E1EE;
	Mon, 26 Aug 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="imz1V3K4"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D5745F4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659834; cv=none; b=P/Q5BMaVOeJXgvKycQ44uICG1CiL5tlfqsFwRDW225025t1hOSfMVc4IO4YR4cIMzzDHv1S97npdL4Fs5rTQwY/3doCwUAJCrdsnBd3D81KQR3JGio54c2uOkRw7sw0cnt/lHC7omCi153wdu0flzRS0qnWU5p6pXiKyC8nXDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659834; c=relaxed/simple;
	bh=6lpJOX2wQcfQfgb9L2kXLhZnOi/RN0HysX+vpZTaD8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksRY6xNNS2qDcdtAoms4heUSNly0NXLp6aoeV56a+hBjuDe+UIVVoNOrglVfMlpQo2H3qF5aoqpxtIxGGwO2USK0Xx7RE2cYLDjlFUXlF+u2AzLFnjMvVMPrV/BCWBlYaLACuornlSnwEWQgD8v8AMwQUUjvvUY0FUS+qNn6P2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=imz1V3K4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43F691BF206;
	Mon, 26 Aug 2024 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724659830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw2pERuoyzjKSrNRb9ZbpaKk891LMp5POS6wV70qvdM=;
	b=imz1V3K4SwOZXznVz2Cyy2MWXjbnDJm8kzyvy7ZqUkIqqL388yTEggbXxohTQZLkqTCHvW
	2nfWplpMqZtqU4AsqOpC/lGv6xbxc//CSgL2q6a9cLETQHGZ1vNq2Kg0l+mZdcdR4UMCoK
	BGEIo3VsERrHQro3X9E1YmUNsGsleG9XVgpfGfYuGYITjD7eQ1vBO9S+f8IIo5PmLuD1/O
	n/VABECXQUp+fzc+S9Y7bd/q7v94ax5k96zQu8rVRsjJ3fsdQwUsM9vdG3AK2bmvumSQR2
	u3RCo6t18olZgFX2BmAtwuf/Hn/e8rc9Ysx8suSuRRy2f/FZK6dGLgCVQCLqKQ==
Date: Mon, 26 Aug 2024 10:10:29 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH 2/2] memory: pl353-smc: simplify with scoped for each OF
 child loop
Message-ID: <20240826101029.5bde327c@xps-13>
In-Reply-To: <20240825135001.48963-2-krzysztof.kozlowski@linaro.org>
References: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
	<20240825135001.48963-2-krzysztof.kozlowski@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Sun, 25 Aug 2024 15:50:01 +0200:

> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
>=20
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/memory/pl353-smc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
> index 994c7a792e34..28a8cc56003c 100644
> --- a/drivers/memory/pl353-smc.c
> +++ b/drivers/memory/pl353-smc.c
> @@ -74,7 +74,6 @@ static int pl353_smc_probe(struct amba_device *adev, co=
nst struct amba_id *id)
>  	struct device_node *of_node =3D adev->dev.of_node;
>  	const struct of_device_id *match =3D NULL;
>  	struct pl353_smc_data *pl353_smc;
> -	struct device_node *child;
> =20
>  	pl353_smc =3D devm_kzalloc(&adev->dev, sizeof(*pl353_smc), GFP_KERNEL);
>  	if (!pl353_smc)
> @@ -93,12 +92,13 @@ static int pl353_smc_probe(struct amba_device *adev, =
const struct amba_id *id)
>  	amba_set_drvdata(adev, pl353_smc);
> =20
>  	/* Find compatible children. Only a single child is supported */
> -	for_each_available_child_of_node(of_node, child) {
> +	for_each_available_child_of_node_scoped(of_node, child) {
>  		match =3D of_match_node(pl353_smc_supported_children, child);
>  		if (!match) {
>  			dev_warn(&adev->dev, "unsupported child node\n");
>  			continue;
>  		}
> +		of_platform_device_create(child, NULL, &adev->dev);
>  		break;
>  	}
>  	if (!match) {
> @@ -106,9 +106,6 @@ static int pl353_smc_probe(struct amba_device *adev, =
const struct amba_id *id)
>  		return -ENODEV;
>  	}
> =20
> -	of_platform_device_create(child, NULL, &adev->dev);
> -	of_node_put(child);
> -
>  	return 0;
>  }

Nice. I didn't even know about the _scope() variant. Thanks Jonathan
for the heads up!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Cheers,
Miqu=C3=A8l

