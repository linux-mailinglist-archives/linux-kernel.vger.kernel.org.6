Return-Path: <linux-kernel+bounces-298513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6D95C846
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B18EFB251DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07F14A090;
	Fri, 23 Aug 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ESSgLe3x"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451332C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402446; cv=none; b=PMz75zxoUMWwRM/Byi/CGytoeePAQIfUjm+uf8CA1BhRH15wQr4OroTZrhMEbCnA4zy5/FAqA/QEvo+g8p0HzxkmT+9ZNvkWWOKnBY4hWOJ5jzS+9BVTtWnfuyYMktoiFPNFZ+HYgib3+F4p9NK+lUaY6Y3Bg+KQE+yZX6Gzfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402446; c=relaxed/simple;
	bh=3Lu0q5LE4JQFeJoFtGj8FZCKVCJ+bPdGS586sH9yOco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMThsXOYpWA6Q+WmUM3a3d/JS3mq47KMYl4u4WWDLfs4vCKm42beNnMOPGEXqYMnmwbr6YDy9KtOeDYEtKvJRLYYHik1E8tLQRN9XkmQBFquch+GOHJLGtBzSx1i+lxTGRHGUc1dhTqoWENRns/SrDYhJCGSgbqAE6i64yG6If0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ESSgLe3x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a81bd549eso154866866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724402441; x=1725007241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fG9KNjBoDmO8zW0C42AiccF/rKtpUpUCjugH/PuwWu0=;
        b=ESSgLe3xxgMVsQDzDEOkRtpf6Utu7PkuRRdKUktTtrTApdTkyk7/yLAEFm6KtkmsgA
         QMEJjwGEBpPDrBRT1TeKtkiYPOAbEaM4ayqQYBpgYXwSJRigcTDIemd0PTn6/thWUHAR
         EsNRBIta/y81CqHbkY2G3LgyNmfwVGV6ovbd871h+cuOIgBGnJuf9aJYQ8h/Yqd7DYSL
         p1VEuZhVu8AkVE11tE6Jdk/mh1d2EmPT5eKOcbwyqs8LLEhgfgJJl3OPxElYg9xz9nKZ
         NYSmNXgZwCegojNsxGDL4AmVLcvz/De12W/FH8jIzwdwHINwFsfzaMZ7vrgZuu+xMVXI
         5Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402441; x=1725007241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG9KNjBoDmO8zW0C42AiccF/rKtpUpUCjugH/PuwWu0=;
        b=uKSPB37VmmNuFtlZUK3D6X8JkhDDc0KKBdfc3w5r5ty2/f7lSNFonaGIxFJMPwf4Nx
         thILH/Lp8kzZhhM00K+a82VQ/F7Te8iviby8V7yhCL2rDjkYhQrUBovx/wuYYSo5/q5C
         tBKZGpbcSNIqW7egX5yf9HN1E4s+2diz89SYwZyUeCJz6MmCq4TfBn3jXpw2AYkHfWiS
         FgQZsBdmdsvisGXQtS5TD1bzSk/H34FUrBUOL2DnJ7z4XduqbWaEvrue8OZIa2YbuKYy
         ukBvzX02uHHuum8RoUwQX/pXHmG3ceBbJ1UzxjMKg9jMX04E3ZY5V2ZPAp+XN1CJPPDD
         3nsg==
X-Forwarded-Encrypted: i=1; AJvYcCVhnoFB4s0ztGtREBnyjNfGxrcZmWnKpAN4IT9NYKaaqANjenhOdFvJW41eSgDCjQDDv94vxF+lgFiNXGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNJiXVoIluqkCrDT0JbNmqM5KO0gDN/0ud0Bu8JoHroEdnmQM
	Ml6RuH3ywTjfiiqiu6isRWpIeycS0bHxp3Muvra+dAECMnzIQa2axZxStTh0n2g=
X-Google-Smtp-Source: AGHT+IELJdt9NWz1Qyq2a+tw+U6RVfRhf7Xtr1odkIop07urXH/CbabXuHZJspnO7+6yMIrduwa9BA==
X-Received: by 2002:a17:906:da82:b0:a77:dc70:b35f with SMTP id a640c23a62f3a-a86a54b694dmr101050966b.58.1724402440963;
        Fri, 23 Aug 2024 01:40:40 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f29004csm229783366b.46.2024.08.23.01.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:40:40 -0700 (PDT)
Message-ID: <59f4d28b-5b9b-427a-baca-739fc03a5cc1@tuxon.dev>
Date: Fri, 23 Aug 2024 11:40:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-9-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346B5C5D9AA883B7736A5C3868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB11346B5C5D9AA883B7736A5C3868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 22.08.2024 19:59, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Thursday, August 22, 2024 4:28 PM
>> Subject: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add support for RZ/G3S SoC. It needs its own compatible as it uses 2 reset signals and it cannot work
>> w/o both of them. To be able to fully validate this on DT schema, too, the RZ/G3S uses it's own
>> compatible w/o a fallback (as if the fallback will be used the RZ/G3S will not work anyway).
> 
> Other than reset/ power domain approach for handling USBPWRRDY signal
> 
> Can't USBPWRRDY signal handled in SYSC driver directly? Since SYSC driver init happens at very early boot stage
> Check for USBPHY control device availability and handle USBPWRRDY signal there??

In theory, it can be done this way, too.  The downside I see at the moment
with this approach would be that the USB, PCIe drivers will not be in
charge with handling their signals, there will be no direct dependency
available b/w SYSC and USB drivers.

The HW manual doesn't mention anything about the power consumption of the
USB, PCI areas based on the state of the signals from SYSC, so, I don't
know if there will be any implication on this if the signals will be just
de-asserted from the SYSC driver.


Thank you,
Claudiu Beznea


> Cheers,
> Biju
> 
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> index 8b64c12f3bec..08b18d7de7ad 100644
>> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
>> @@ -93,6 +93,7 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
>>
>>  static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
>>  	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
>> +	{ .compatible = "renesas,r9a08g045-usbphy-ctrl" },
>>  	{ /* Sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
>> --
>> 2.39.2
> 

