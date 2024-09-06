Return-Path: <linux-kernel+bounces-319158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60096F8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825ECB2324E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343D01D3652;
	Fri,  6 Sep 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EdxznCNI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B81D3650
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638037; cv=none; b=N3ONb8oEl0qzxOkvtb8UeGkDgdIj0fc+QF9me1p6COe8DY9htykU9k18Ib0kb4WZ6y/qZ0n8kUu/DSqoWIovCVcTO6mFUoav94D8nxeJBDtIcUpdBQT6YkqErOsQ0b9y05ieGL9peRIH983uCy/dCPCczqbRfkwrLJlxyCoMobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638037; c=relaxed/simple;
	bh=o0MznKshQJgBs5nWI2XoOX4AsBYGuttamKL1DUIopyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulCDdX4F+w0uoVqOAA0FAMNUPQro3n49yq4zq0yRXTjD2CmDaKzaVtWkuK8LJ+mARF+8aNJe6FNZpeuHtUNjmVVfxuQjmVsvrqg2Kmrv7Ufow2INJ6+jIajUogQTjxBIC/uJ0PfOo6gcyHuCUJUZappAAqgBtLdFKbwgUlZXh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EdxznCNI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so16827535e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725638034; x=1726242834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NC6Cf1A5zM/7S1X0dCOTWrmEp/YKRHomNRr1wAJwj6w=;
        b=EdxznCNIIfqzj+0VlBd+7J1aT1y/glqrZs/uOmPBdVJQR1c4f6UUiQLxLOh2V/LEFF
         GseQtg9suYLHCu4C1GU9Cc6pBP+PKV/ZdhiDHo7xH26Pzgf5JuCyDQufuqhSvAo5nKVd
         iGeqqwSJBq5spXfKmc0M9YpvTEYUlyT4AZuKHdUZn/DqnDhN0y1FsSE8nGKyaTJYJwD1
         EQfREDmKrExnidtJ5YKCl4Cp/xngLiVry5sUz4hlSpp6n4sIofUt1n6opNN7IhBcJFtm
         ulYV4QrDCh8xqiyb3rhbCyPDrQ4l6lR8DXSlC6dwB9P598hgyIhpldP+oEUH7Zh0Dkhg
         BwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638034; x=1726242834;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC6Cf1A5zM/7S1X0dCOTWrmEp/YKRHomNRr1wAJwj6w=;
        b=IZIci2leXgeEzQ2CqTOuM5rErXoIRVZxIE8tKteQI2J8yGC7Cx2GYF3XXd48WjFen5
         k6xtouxtr7FbMdDoOI9tkHTL390w/c+7o7gyUF2wH8dnCeomUZnvf7C2q11C+l9Tzhwq
         hGwlivtiwyVx9Pu660MJbyPmw4ClUCtm+49vPs6U0ThhJeuvkOizgdgXlN2Wk437ssvC
         NC6O5mzdg0Vo9/VgNaOqDtEVf1Cp1UGcP5YuaGWd33UoH4CXa9KvYm13jkCV0rNov4QE
         u4WvaIXZHG7fUlIbYOYk17BEJWTVAWe60LF3JukEch08+da7cl2QWZi5T+WyZKiDCF+8
         No0g==
X-Forwarded-Encrypted: i=1; AJvYcCWa62/wyV144KjtV8OdMHa22N89H6CGMmWzaip9qzZ1h+nDGVhslQfNa21cDl++05AB1BsignhQB4+DeAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimlVtNhtiFG1vT1CL/4gDSYJl2jCbSEScj1/NWvST/UXBSHmt
	H5+bZ1UHJ7lWShTiUV1dZR/4+1J0Swy+AWPcjTNlqCbVAuXkssqzax6Mc5/zn9dEQSjp4nzhM5V
	exXhu3w==
X-Google-Smtp-Source: AGHT+IHaSnady74DJ1oEcQaHcxLA4uOPiZb6C4vhozW1nZbyNOH4GbF0OP/WL2CRSWsgv9G05aJ9MA==
X-Received: by 2002:a5d:4388:0:b0:368:334d:aad4 with SMTP id ffacd0b85a97d-378895b7bdbmr2264093f8f.4.1725638033585;
        Fri, 06 Sep 2024 08:53:53 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca06005bbsm24296915e9.30.2024.09.06.08.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 08:53:53 -0700 (PDT)
Message-ID: <e295e004-891d-4865-b1c4-3cef93976245@suse.com>
Date: Fri, 6 Sep 2024 17:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: s32g2: Disable support for SD/eMMC UHS
 mode
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Chester Lin <chester62515@gmail.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux Team <s32@nxp.com>
References: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
 <20240830113347.4048370-3-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240830113347.4048370-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/08/2024 13:33, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Disable SD/eMMC UHS modes for NXP boards which do not set VCCQ voltage
> supply to 1.8V by default, such as S32G274A-EVB and S32G274A-RDB2.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 1 +
>   arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 9 +++++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index 7ab917f547ef..b9a119eea2b7 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -39,5 +39,6 @@ &usdhc0 {
>   	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
>   	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
>   	disable-wp;
> +	no-1-8-v;
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index 8739f63771bc..aaa61a8ad0da 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -45,5 +45,14 @@ &usdhc0 {
>   	pinctrl-1 = <&pinctrl_usdhc0_100mhz>;
>   	pinctrl-2 = <&pinctrl_usdhc0_200mhz>;
>   	disable-wp;
> +	/* Remove no-1-8-v to enable higher speed modes for SD card.
> +	 * However, this is not enough to enable HS400 or HS200 modes for eMMC.
> +	 * In this case, the position of the resistor R797 must be changed
> +	 * from A to B before removing the property.
> +	 * If the property is removed without changing the resistor position,
> +	 * HS*00 may be enabled, but the interface might be unstable because of
> +	 * the wrong VCCQ voltage applied to the eMMC.
> +	 */
> +	no-1-8-v;
>   	status = "okay";
>   };

