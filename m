Return-Path: <linux-kernel+bounces-300098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C2895DECA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC2A1C20F89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B551714C6;
	Sat, 24 Aug 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d+Mrv06h"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC536124
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514838; cv=none; b=LvWM/cc8wEGJ9DkFwiiFy67hi68kRyX+ZbwzYGUYozt53kdbRLCC1JibdXJfHPEnG/GY/UVhp+mA2WWTHLRgnpZleEJlgcZvRI+cctqOqZY/Vf2j5ews5BOpE3P8u2EY0gOS4elc8zEG1zM2StFnJs+OUWPquFbE5Z4CpfVeBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514838; c=relaxed/simple;
	bh=eZwCHFaK83Pk8cBPTmY04gzAYrkyw0p4RSuC221SbE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izzNAvh3gVXLO5PRERLE714Np17IyAbSN6VPBquoynu1soYBGevrizaluJhf9qBsTDmps4kl2Q4VWMgSsqoENSTZAXKUtbHM1wpzzsX+gUsw2k23vIrrh5Zk8IzYdkbSf+TKRo/LbiZw/8tt49A2SsjFvG4JXs8XZaDrM/cSh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d+Mrv06h; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso3633472a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514835; x=1725119635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rI8zyZMDPlp0E+TRP5vsDLFEWRVi3w2uJfICD8aPjx4=;
        b=d+Mrv06h2v0mPYrP/a77u7/89fNuhe3eSi2E8ZupA8S1+bH8GFSEBNXoX8o86Sbu8e
         DhNe8rWmFl0NAxrPg1A3ZfZQZp1BmVlAX2CzNjxp5M7DlLcnB4Soz/j+wBBxCApnV4mp
         OYpCvpYJjLwrecbDcW9DkCi11QgxNm/mjmswQrsvQKr3BvfpQQVkNKNAp/hgedH+E2li
         8FqbUyG6VjUWbdf6IICPd2Mi8XXAubkJr1FjM3XOR0Rs6+nWvHY5pt+cArraYm3GW4l7
         NuHNAaKc9+9iY+R+thxEaB2QvMibCrkmZVOj/B7lX+d/o1YNlQjsN83m9AEQ7/vXSCxy
         F4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514835; x=1725119635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rI8zyZMDPlp0E+TRP5vsDLFEWRVi3w2uJfICD8aPjx4=;
        b=MGxuivIW73i3Sum6QA+lG7qBMccixSk8BoOPKtpgfJaAGmdMY0+YrP0NJ+G+kLHzbh
         IZLNMQWmq0Zk8L2csOAaODkS22K7Fn+hiaGrGnvfJJprxOCTOBQcZwS36MYSicfoDKd3
         dPeNm6vXbTzeLP2JUAgwQ6oJ5OD0juVgoa6iYBNHQGQ1UtFPbb/sFWK5TgOG2wrDa73q
         0B5s1baeDN5FKYFi5HD//6P1ljNl3G71EwpRvVyLz53nHoLHOTAmBOJYlkfPgfAKgQbe
         FGP9DvjcO+B9knVGGjFkVOeNbYtKs9mXP7VsZ6ElOgVhqPKkpMGmewfetPOriAfCNtW8
         1D9w==
X-Forwarded-Encrypted: i=1; AJvYcCWaPqp5R26dofw+xwaEaE6sDeTn6Q16VmwcQtCCP0z2RcPauJwtBU+ezKzJUOzhvkaKajTmRTg19Fr3j+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YweckAi62i+JReAqsRULT6wpA8L2Qwv0AE2b2gRnETU2H4uVnDm
	j7Ak/CAW9emnbY76aqhNp4DOKwTKgeCsfvX8xeo6ohfNroyotx0g7btAHHfDrqc=
X-Google-Smtp-Source: AGHT+IHdVieXWL+We0P8P43fQh9DqWzftDnSlHUVujJnh/eOwXF2Q+eAaQN4jLT7LE8PsKKCcpm6zQ==
X-Received: by 2002:a05:6402:13d0:b0:5c0:8ff7:e672 with SMTP id 4fb4d7f45d1cf-5c08ff7e789mr2433515a12.22.1724514835180;
        Sat, 24 Aug 2024 08:53:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:53:54 -0700 (PDT)
Message-ID: <6a234b6b-ac4c-4fa8-8809-df56327f7b9c@tuxon.dev>
Date: Sat, 24 Aug 2024 18:53:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/12] nvmem: microchip-otpc: Add SAM9X60 support
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-5-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-5-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 13:59, Alexander Dahl wrote:
> Register layout is almost identical to sama7g5 OTPC.

Can you please mention some major differences?

> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/nvmem/microchip-otpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index bd3383eabdf6..b8ed7412dbca 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -271,6 +271,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {
>  	{ .compatible = "microchip,sama7g5-otpc", },
> +	{ .compatible = "microchip,sam9x60-otpc", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, mchp_otpc_ids);

