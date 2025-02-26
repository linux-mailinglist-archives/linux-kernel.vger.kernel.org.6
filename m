Return-Path: <linux-kernel+bounces-534748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39154A46AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB78E188A285
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FA238D2E;
	Wed, 26 Feb 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyQQPcAd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C739239573
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597009; cv=none; b=K8xrKT/ZJhnCzeyMehgufaBlorh+evdj/hf0BXBZ21AAsHalQU9SfXrC0iWb2jiaP/TLzocH9fPF54f8GQEr5IoyC7tl7rGuAu/ncp3OmRO1uAol2nRsF3feC8sHnhi3XpxR7AklbTxirDvZh235aS8hqkTPrWKal3z5Me/UkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597009; c=relaxed/simple;
	bh=vNIB1Hk+ftHd0PmNoa5/tzFlgptXk+FeOKK8Mczu7A4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrdGUSP5bXCjst26NecFiVwbgtZUsoL/8QzLReQJ6FJcON7hyFH0VZzVHZvCpeXvxp4awd5usbkKz/r9QG47/tUUAY0oVy3aiOijBLgAYqaowXVtO9b4XUVf1pev4UPdk3+dZL8vRXqLWGMmPOZ6YLwAod9jS6AUUR61Hecyjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyQQPcAd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso1332435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740597005; x=1741201805; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQXlwKW3fq22hjGTADQg3o4ICJGGdHwqlJHIeiJps70=;
        b=cyQQPcAdWSnimFMMlrPjHXdP96RJYtyX/8ffMJ5G0FXRk2+BhXZG8U2b699ROW9ljQ
         9X5YxrdvnakK9HULN3ChKcVPXC6v2ACXJWaHyDCtCC8D3bb5g6OPVUEsNKJyHWejOd0L
         Zt3CvyCOs7so/qF8SwpturCV0ZP2MLrqQRKw0LI2gZWn6+Rdv66ctFSbNHnqQrs64vFA
         f9YL5mePq4fNPEx1bayriEmcaC74SazXpKfE/l+XJUTw+Do5GJSsF7ejAKFgZ5mJm6az
         9M9kbiJekNJ37iug3ez+m7xVfdWsEhaKEo+xGO/KYXkXh/0GxB7yvFC0WkLI5Adqy4lI
         5Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597005; x=1741201805;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQXlwKW3fq22hjGTADQg3o4ICJGGdHwqlJHIeiJps70=;
        b=MtzYUcVd49sns+m0NEsR7DFMZAAmikaGB5cTtlxcIDQAiV3OLLVliaSZ4BvZisaRuW
         3Omeewu/uNowihQSoPm9gxgmqQpXor/cmPW4wVmbxDClZSfkNkvRU2DWzYJZRO57xse9
         ADkkh/UL1sXWOx52KSFa4pOz4JLe+8In7UCzY0BXsOIBN/bSpQCzR6pZ+BaLsS0moQc8
         z0uVgmj5WLEUiV0REwLsOrz3Cq+rZ/SoBcQOO3BExxicCSSTaN92xW5JNIaKY+Hn8oF6
         nxpqP9o2Z2tLn/J3eHLByq/q0Q5q2zgg/Ca849t2ZmoJ8LlSq+crfiI8zycSOsvNpOHJ
         DR8w==
X-Forwarded-Encrypted: i=1; AJvYcCWuTzVUoS7qhJ0323mh3vmC7qiEVO3yxaYbt8tWDbYaWgHc2m5Z058YfaJrcvTIB3q9Z0/k5gBTAd3O4kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjfUobJtLu7KlyodCQtAY7GKFYoizvxeSaUY5BkgzLs5NUX3b
	gbcEHgRIOdYzjAcudNI2py9+qm49hSQNg3ZB4GVWuWiPZ8g4/9aTDlKlTFnkTcN+rW5yQWKGklx
	K6B0=
X-Gm-Gg: ASbGnct5d+T1FNRG8wQyulzgry3gB6HWMkITrrMTpxVnCstoPVDEa1GarMIG74wsFM5
	k3hsO2wwTD2frMSEkahFlQ1Fs3AInzaIsqs5c3tKpbvV8C5Ta4PabxBqOHBL3MVy5ZB0L05KPsP
	LGxPq6AJhAK/XU3jUoDz/Fi1pt8H3CutZVfvDCdovvlmiHEFzyQb5/enAJL+6wC0koRKWP8Xdu5
	LHWCJM/jlf/xGL39TdnQ+RjX21wxe5nObfBoBHPJi9jeYSG+KnAMIg3296i4zAqvobW8+G5hSuH
	LS1uCbB6nYCw1UO4mRU5TZ4lexLNjA==
X-Google-Smtp-Source: AGHT+IGa0oSIpnReOtNhlKYec3e5C0bkQn4YQGivV5J+eMq+hw7AG5nh0vwPYPQ8XEjaZUwX1ZbW4A==
X-Received: by 2002:a05:600c:4753:b0:439:9a28:9e8d with SMTP id 5b1f17b1804b1-43ab0f313a0mr77194455e9.12.1740597004640;
        Wed, 26 Feb 2025 11:10:04 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549db4sm30545825e9.35.2025.02.26.11.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:10:04 -0800 (PST)
Message-ID: <135bdfc38dad8994b94318174a970fd22dc87f45.camel@linaro.org>
Subject: Re: [PATCH v2 2/2] power: reset: syscon-reboot: support different
 reset modes
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2025 19:10:02 +0000
In-Reply-To: <20250226-syscon-reboot-reset-mode-v2-2-f80886370bb7@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
	 <20250226-syscon-reboot-reset-mode-v2-2-f80886370bb7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-26 at 16:44 +0000, Andr=C3=A9 Draszik wrote:
> Linux supports a couple different reset modes, but this driver here
> doesn't distinguish between them and issues the same syscon register
> write irrespective of the reset mode requested by the kernel.
>=20
> Update this driver to support most of Linux' reset modes: cold, hard,
> warm, and soft.
>=20
> The actions to take for these are taken from DT, and are all new
> optional properties. The property names match the existing properties
> supported but should be prefixed with the reset mode.
>=20
> This change is meant to be backwards compatible with existing DTs, and
> if Linux requests a reset mode that this driver doesn't support, or
> that the DT doesn't specify, the reset is triggered using the fallback
> / default entry.
>=20
> As an example why this is useful, other than properly supporting the
> Linux reboot=3D kernel command line option or sysfs entry, this change
> allows platforms to e.g. default to a more secure cold-reset, but
> also to do a warm-reset in case RAM contents needs to be retained
> across the reset.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> =C2=A0drivers/power/reset/syscon-reboot.c | 88 ++++++++++++++++++++++++++=
++++++-----
> =C2=A01 file changed, 77 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/sy=
scon-reboot.c
> index d623d77e657e4c233d8ae88bb099bee13c48a9ef..1d3d8a3265ae8005c685b42d3=
e554bd8bb0047ea 100644
> --- a/drivers/power/reset/syscon-reboot.c
> +++ b/drivers/power/reset/syscon-reboot.c
> @@ -14,11 +14,29 @@
> =C2=A0#include <linux/reboot.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0
> -struct syscon_reboot_context {
> -	struct regmap *map;
> +/* REBOOT_GPIO doesn't make sense for syscon-reboot */
> +static const struct {
> +	enum reboot_mode mode;
> +	const char *prefix;
> +} prefix_map[] =3D {
> +	{ .mode =3D REBOOT_COLD, .prefix =3D "cold"=C2=A0 },
> +	{ .mode =3D REBOOT_WARM, .prefix =3D "warm"=C2=A0 },
> +	{ .mode =3D REBOOT_HARD, .prefix =3D "hard"=C2=A0 },
> +	{ .mode =3D REBOOT_SOFT, .prefix =3D "soft"=C2=A0 },
> +};
> +
> +struct reboot_mode_bits {
> =C2=A0	u32 offset;
> =C2=A0	u32 value;
> =C2=A0	u32 mask;
> +	bool valid;
> +};
> +
> +struct syscon_reboot_context {
> +	struct regmap *map;
> +
> +	struct reboot_mode_bits mode_bits[REBOOT_SOFT + 1];
> +	struct reboot_mode_bits catchall;
> =C2=A0	struct notifier_block restart_handler;
> =C2=A0};
> =C2=A0
> @@ -28,9 +46,16 @@ static int syscon_restart_handle(struct notifier_block=
 *this,
> =C2=A0	struct syscon_reboot_context *ctx =3D
> =C2=A0			container_of(this, struct syscon_reboot_context,
> =C2=A0					restart_handler);
> +	const struct reboot_mode_bits *mode_bits;
> +
> +	if (mode < ARRAY_SIZE(ctx->mode_bits) && ctx->mode_bits[mode].valid)
> +		mode_bits =3D &ctx->mode_bits[mode];
> +	else
> +		mode_bits =3D &ctx->catchall;
> =C2=A0
> =C2=A0	/* Issue the reboot */
> -	regmap_update_bits(ctx->map, ctx->offset, ctx->mask, ctx->value);
> +	regmap_update_bits(ctx->map, mode_bits->offset, mode_bits->mask,
> +			=C2=A0=C2=A0 mode_bits->value);
> =C2=A0
> =C2=A0	mdelay(1000);
> =C2=A0
> @@ -45,6 +70,7 @@ static int syscon_reboot_probe(struct platform_device *=
pdev)
> =C2=A0	int mask_err, value_err;
> =C2=A0	int priority;
> =C2=A0	int err;
> +	char prop[32];
> =C2=A0
> =C2=A0	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> =C2=A0	if (!ctx)
> @@ -60,12 +86,52 @@ static int syscon_reboot_probe(struct platform_device=
 *pdev)
> =C2=A0	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority)=
)
> =C2=A0		priority =3D 192;
> =C2=A0
> -	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
> -		if (of_property_read_u32(pdev->dev.of_node, "reg", &ctx->offset))
> +	BUILD_BUG_ON(ARRAY_SIZE(prefix_map) !=3D ARRAY_SIZE(ctx->mode_bits));
> +	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <=3D REBOOT_COLD);
> +	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <=3D REBOOT_WARM);
> +	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <=3D REBOOT_HARD);
> +	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <=3D REBOOT_SOFT);
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(prefix_map); ++i) {
> +		const char * const prefix =3D prefix_map[i].prefix;
> +		struct reboot_mode_bits * const mode_bits =3D
> +			&ctx->mode_bits[prefix_map[i].mode];
> +
> +		snprintf(prop, sizeof(prop), "%s-offset", prefix);
> +		if (of_property_read_u32(pdev->dev.of_node, "offset",
> +					 &mode_bits->offset))
> +			continue;

It should also check the %-reg property, and it needs
to use prop instead of "offset" in of_property_read_u32().

A.


