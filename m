Return-Path: <linux-kernel+bounces-262346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07C93C47A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1C1F2282C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2C19D083;
	Thu, 25 Jul 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XiE51TIG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382519D8AA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918400; cv=none; b=WQtIjRCUkkGLAI2yKWoEr1Dpl9VFmCvlqHEKFQNbUhlILRjlRF6XB7SaL/KFOh+bWO8pHgu2djIp0Awha2tOVKFkPgMpDsBYIZAVKo3d7roJkeriQHPERf7ilWxFfBID5xjcLSbq/FSvuHDHEer1RhReGxunSUX+qn57D1+0vBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918400; c=relaxed/simple;
	bh=0jprevtwm97HPlvDbJ8iak+QX7zBxOzWXvkyqSqMkaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipj1HcK3jrAWIAscInzn5PnQT1KoYgu+umh2HiNZNaIvBCIjA/c679PLyJ4EsCFgdVZ5B8T3z59WKJMb1gAOYjWVgpyUd1t53j2cTYMEzPmMLXO/CKmt4OmyGj9D/wxjNu6MSNs8pfKQyQII+E4AN9NCzLk/mN8cbIfG6PNULjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XiE51TIG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-369f68f63b1so597415f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1721918396; x=1722523196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmNcaMBYjNffFp8Y9eqYmsbKgIfRFa8ntga4/Bnlk8U=;
        b=XiE51TIG0QSwxM6R7gAJhuGIKhU8Wwv8LqrMssvrQkEr9uGbDiE2G6iX5nrP6LGlVR
         YjfWORVvdZzJJBiIMFOoW3I1dZdcBxoAm1XqJ/NQJ1ulUKmYi8UAkvhswnD6NQNryhDy
         Oa4/mk+XZxRMPm05/HOalEMueflQllHl1JTSXhKOgZt2auJez+pYDWLS8Gcfl/E8fN+L
         BZS1nZ+3Y+jCvbX26wUwkE6BsZcvAMuH25wjjebmIOeUV2l0Y4FAiI9gOrNLudTElrtv
         YbUAJxJznlKZidOwZFj4ctT7xQ4hr5EpWmdAJcB89SPA4gpmqwdhh69R7qHyJVQqnzJL
         outQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918396; x=1722523196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmNcaMBYjNffFp8Y9eqYmsbKgIfRFa8ntga4/Bnlk8U=;
        b=hwn9b0PGLDsBx5PCYzuTk2Ozv9WMKqT/m0iG9XnW0nMXd3CL12LXOuEF7BHJXa/2At
         ssB2KCwGft2scw8dhcOcSHPCOLzZRu9Kowv+wD0ND/lxUaHQjGKipIgiHuXsGccW8aER
         slCuyjNtEWhzg9AEddLiKEE96UnCSfQCCWrrskju4lJoao/GfjNyFjGTDMuBG7//eWf6
         /tjWJAa0qzM6l5eFOa7bPp148ttO4uJA0nthSWoVo2gnOgPaYFfdW5sLar9VTX+AQ/CF
         xDHjPYy8xs2yIedCtpbZbnK3WUKLsyo6eRe1BdIS+vyxjFObePX2iCtLfxLzppU1vpxv
         /5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXauIsTs8qYg6O/OqHog6cJOPHxmvDPouUmy5xQqkRZSANT3r149QTUGj5VZ50ko2elBTnlRQU2K0EBS/mF8i0fla53H7lxqk4IhKRt
X-Gm-Message-State: AOJu0YybnJH1YeCfZgVXox/Wgi/qzc5tCT0lUE4I7OSP37RhrQI0iwJz
	xrDAqG2ZgAtShSJzMEU0xaq2DH1dpd4QvLo9D9fcheTw+t2lJ3RE27+ptTsBgWU=
X-Google-Smtp-Source: AGHT+IGf7oywhAAEa3IVVaOAoTIXoWXB5zTQ9uLQU8Ixr/J7YCMLGoCiSQGBGBt7sL48QVY7/UM+8A==
X-Received: by 2002:adf:fe0c:0:b0:368:6596:c60c with SMTP id ffacd0b85a97d-36b3639dc76mr1767102f8f.30.1721918395512;
        Thu, 25 Jul 2024 07:39:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dc2sm2403560f8f.77.2024.07.25.07.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:39:55 -0700 (PDT)
Message-ID: <97233c2e-78ff-40a0-b808-6929deff4427@tuxon.dev>
Date: Thu, 25 Jul 2024 17:39:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Return -EINVAL if the pin
 doesn't support PIN_CFG_OEN
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240723164744.505233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240723164744.505233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.07.2024 19:47, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Update the rzg2l_pinctrl_pinconf_get() function to return -EINVAL for
> PIN_CONFIG_OUTPUT_ENABLE config if the pin doesn't support the PIN_CFG_OEN
> configuration.
> 
> -EINVAL is a valid error when dumping the pin configurations. Returning
> -EOPNOTSUPP for a pin that does not support PIN_CFG_OEN resulted in the
> message 'ERROR READING CONFIG SETTING 16' being printed during dumping
> pinconf-pins.
> 
> For consistency do similar change in rzg2l_pinctrl_pinconf_set() for
> PIN_CONFIG_OUTPUT_ENABLE config.
> 
> Fixes: a9024a323af2 ("pinctrl: renesas: rzg2l: Clean up and refactor OEN read/write functions")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 632180570b70..3ef20f2fa88e 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -1261,7 +1261,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>  		break;
>  
>  	case PIN_CONFIG_OUTPUT_ENABLE:
> -		if (!pctrl->data->oen_read || !(cfg & PIN_CFG_OEN))
> +		if (!(cfg & PIN_CFG_OEN))
> +			return -EINVAL;
> +		if (!pctrl->data->oen_read)
>  			return -EOPNOTSUPP;
>  		arg = pctrl->data->oen_read(pctrl, _pin);
>  		if (!arg)
> @@ -1402,7 +1404,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>  
>  		case PIN_CONFIG_OUTPUT_ENABLE:
>  			arg = pinconf_to_config_argument(_configs[i]);
> -			if (!pctrl->data->oen_write || !(cfg & PIN_CFG_OEN))
> +			if (!(cfg & PIN_CFG_OEN))
> +				return -EINVAL;
> +			if (!pctrl->data->oen_write)
>  				return -EOPNOTSUPP;
>  			ret = pctrl->data->oen_write(pctrl, _pin, !!arg);
>  			if (ret)

