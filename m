Return-Path: <linux-kernel+bounces-315546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21996C409
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11F11F26C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243A1E1302;
	Wed,  4 Sep 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9GiyQKL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EB1E0B68
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466896; cv=none; b=oNzs6Fp8GsF3dpIZeOlDTRV/ZIdNyatp56dh+Ea9cw754533gerucOPy2Cl2CK2+EZ5S9kcbwBLtsz6SJ4fG/A8cDoG71Ddxy01ALPdxTbSMVfOfGRRpVK0vW8MHnTgbWixq7Hrqjd4fyRIi6VoUPvn2XuhSTFx1YEe96mLVM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466896; c=relaxed/simple;
	bh=AyfG3KoGcXrBS4bIRc1AeimFWz9VioSHNRiORIfm/l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgfyI891DC3pyESyOtLlfEayqmYOItybiBQOHmGTKEFNzIg/a+9H6YpvctuWjy8cReA4wdHa1dwliOep3NpeT2nf5mKcBTrCPqmUOaVv14mUXd6eO64FqkbXzUxCpktlzm9E1GpeV3qJ/XL1bbfi9AaTweQdyhadGppd2IF0Dvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9GiyQKL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725466893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AwjcN6g7I7OiaNfGEcM52WOUchfEeuKfK5Y1ugnA5o=;
	b=Y9GiyQKL6L5iFp2v1FzFJMw9z48+oRklUfRw2bEjETTdY4N9ihynbWh1u9O++Jkfow2qXG
	PW0DnwWT4zgJJ05ooOwOetoz/8NeqpFsnjvKIGwLYYKro/Jc6VCfp1IVA4Ck+QLnLFuwLw
	HBf/rzKdtI+a1JuArM0esQR/yXVzGS0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Z5TYVDWjMm-Cdn9Q-4Hv0g-1; Wed, 04 Sep 2024 12:21:32 -0400
X-MC-Unique: Z5TYVDWjMm-Cdn9Q-4Hv0g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c247f815b3so831080a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466891; x=1726071691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AwjcN6g7I7OiaNfGEcM52WOUchfEeuKfK5Y1ugnA5o=;
        b=ZN6tihfFg22Hwpyd258C/nGuXJ70kvy/EdxW6mcX9cj/1tSpVS7QMkkEZ/Mpu59wGN
         ycBaXpKgCjOaDKFsGgBeIHD7g98h/0Opf/noKiMocbj9V7C0mVST14V1mazCykrwGVtb
         Np3jQ/an2VyDUvC0Rr0N4nP0CdMxjKI0oWSpZiDatrh/t/2QyJhTjhYMuPVDUzsqMVb1
         pYa1CyZhjHrZyKxGxzu8woJvTSyGuGCbOfxQ+SgVVReax4yOaDH7WAcZs/M1TWFTb7Nb
         e+IaBgSyX7upPwwGkj9mlruWBfWXpUadqrDe/2J0XbTtAW3bJ6+tmO+w+eG2pLzmom24
         GYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/rDTNEmUkiwfGX6UlCp9y8SeXZdsEFA4WzHzuJK7k9axsgi+joUZr1/lAc5HqbfH07tkSJsnov6HLCUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyMky7h/iSDoLMLFW98HAriiWo41I0LLyj0iUn/tn8EeXcRwS
	amhL26Ze2/sHYKoaScQpQeIfjYt6z6Lb38lqpkPcKsx5NPdbOuwBq0CYP9uTpIjAvp4aY7FYVN4
	90aj5l62sNrqfX/qw/DHvBx5ElJ4MKjsUAjXxnvgpS45Ujz7/rs/J9e6LFE0ktw==
X-Received: by 2002:a17:907:9812:b0:a86:9fc2:8395 with SMTP id a640c23a62f3a-a8a3f0ef2f3mr269132566b.11.1725466891233;
        Wed, 04 Sep 2024 09:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbBPX1+w5oRxOTBh0kbwluzQ4Wje19SWHUnMncqtuLGzNshFcLaHUrTGFhkiYagd9cssatKg==
X-Received: by 2002:a17:907:9812:b0:a86:9fc2:8395 with SMTP id a640c23a62f3a-a8a3f0ef2f3mr269129766b.11.1725466890709;
        Wed, 04 Sep 2024 09:21:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c68sm10143466b.177.2024.09.04.09.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:21:30 -0700 (PDT)
Message-ID: <3b37d693-f465-46ac-b857-ed907420ebb7@redhat.com>
Date: Wed, 4 Sep 2024 18:21:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] extcon: lc824206xa: Fix build error of
 POWER_SUPPLY_PROP_USB_TYPE
To: chanwoo@kernel.org, linux-kernel@vger.kernel.org
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240904161537.37460-1-chanwoo@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240904161537.37460-1-chanwoo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chanwoo,

On 9/4/24 6:15 PM, chanwoo@kernel.org wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> commit 0d9af1e1c93b("power: supply: "usb_type" property may be written to")
> changes POWER_SUPPLY_PROP_USB_TYPE from read-only to writtable.
> In order to fix build error,

Thank you for preparing a fix for this. The commit which is breaking
the build actually is this one:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?id=364ea7ccaef917a3068236a19a4b31a0623b561a

Codewise this looks good to me, so with the commit-msg fixed to
refer to the correct commit, this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-lc824206xa.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-lc824206xa.c
> index d58a2c369018..56938748aea8 100644
> --- a/drivers/extcon/extcon-lc824206xa.c
> +++ b/drivers/extcon/extcon-lc824206xa.c
> @@ -393,14 +393,6 @@ static int lc824206xa_psy_get_prop(struct power_supply *psy,
>  	return 0;
>  }
>  
> -static const enum power_supply_usb_type lc824206xa_psy_usb_types[] = {
> -	POWER_SUPPLY_USB_TYPE_SDP,
> -	POWER_SUPPLY_USB_TYPE_CDP,
> -	POWER_SUPPLY_USB_TYPE_DCP,
> -	POWER_SUPPLY_USB_TYPE_ACA,
> -	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> -};
> -
>  static const enum power_supply_property lc824206xa_psy_props[] = {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_USB_TYPE,
> @@ -410,8 +402,11 @@ static const enum power_supply_property lc824206xa_psy_props[] = {
>  static const struct power_supply_desc lc824206xa_psy_desc = {
>  	.name = "lc824206xa-charger-detect",
>  	.type = POWER_SUPPLY_TYPE_USB,
> -	.usb_types = lc824206xa_psy_usb_types,
> -	.num_usb_types = ARRAY_SIZE(lc824206xa_psy_usb_types),
> +	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_ACA) |
> +		     BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
>  	.properties = lc824206xa_psy_props,
>  	.num_properties = ARRAY_SIZE(lc824206xa_psy_props),
>  	.get_property = lc824206xa_psy_get_prop,


