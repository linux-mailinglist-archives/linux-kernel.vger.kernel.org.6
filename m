Return-Path: <linux-kernel+bounces-510700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8870EA320C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5323A6187
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C475204F75;
	Wed, 12 Feb 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hMOJ2RoM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA51EE013
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348258; cv=none; b=RaKWVtMbT66tKxWCGPSbwT/oRwDXQR4LLs1py/mUjpV9QD+EhJCS9Yw2grjYpn3cwdhowB/vwZJrPbY+EKNkeLQSIOU/Mbh3d7HGbsFcFOBXOo9mN1CEFm/pWuLoEha7otA/wcCaDlLXuxJFBUD/tFP/rQ/sb8uOdKkPGwSkN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348258; c=relaxed/simple;
	bh=02CCZl7slFJBM7+CvoMMp8JDrE/5IxKvqidgK1BFCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCeoCuRMtftTnWZLKxs0OIrUliqgecTCmyTn1crr6eOrCoX5X6/0Ve8gxij9uk+ZfS+NdKsI/irG5XpWvAm+jimqjJLmWflH+pbvcMRO9MZxlOw13V8Rmoulw+dOM4NxPKtxQ8/oRpT/BNgy7Omx8T/OAA8l6FAB59hQvolHYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hMOJ2RoM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7e1286126so293689966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739348255; x=1739953055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOol5WNPvENS3vdMhBYm0QLh74/mNhfhqG7fppgba9k=;
        b=hMOJ2RoMBuQemaOI05YGiIDlAsbwxLdTnwKywI8AAZZf890QKt/ahq4OVDMhjo+Wq0
         gkD+B6bWAr4bnfY2s5XiRW0MOHhYVbmvvgbJjW2m1ne1AL2iZ+NoxKjXNVCjMYqCDroT
         K2bPJTyae/MnWb2FS5vBfbzc6mxgaPBSe4elodiplJRWsrajZm8tGwK99XIcRUlHJkEe
         CLokPnXn9dxpfcGxUkLnNHLhq9nRfBc1v6JSQHPF595CTbiovLEB8b3VEcVMWes7P6aS
         m/ls+uC0xAlkrU6LMmh9p0xSE7kak70X5Yl9sQAm5unPyptW3aBJRVoc6pjbIRgMT6Mf
         KqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348255; x=1739953055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOol5WNPvENS3vdMhBYm0QLh74/mNhfhqG7fppgba9k=;
        b=pJzjCqFRRKp3ljG2XHQHgglUVSeL/W51mrDLTfNLif3NhFiy+f3YbIteUzNIiuaCCA
         8/czXSXte3LYvQ+8zHNXoSaLijM8fNw251T3PwyzBysbGf8ihTrCQ5117/Q+08JwcTGD
         XEPZqeTQUajDmlLgWZRcEVZ5rYEfjCsk1+bWxWKbpE1Mg3BtjwlyePskLjfIkyWbmffZ
         l/yxYLZLlfq1ENZBXCzUgdNaBcmrYTPtF3mw40upX3K5ZCWoPuGrSuRD3gmAYxM/41iq
         vsSEt3GZxENzmwQwLHkENd3DzuiPDlMUmpXVGwxGqScMelKxaRfddsraRbdJk/zbrXpJ
         xdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrlo2hPt/RQq1E0BrUnYgO2yfQ5OrUOVEPL2mzqWsWpplnoGpVviqQYNiQsvgMEe8FQ4zKuLSN23IuQVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTPB+kshK1cjdigj08mwGclGz3U7AFbIjurqIAqAWVGoIUGBP
	PWDG7zBeUZkfN9nYqpRyxnKl93rVys+ZqpdRXWU7p+fYnsY8m7V7YCVKQLls2eA=
X-Gm-Gg: ASbGncsG0BXovAe0vA7+hq1gCldyMmik/xuQ7Rzs1hTn9j00Cf8QHa0TlkGxvnrMeRo
	kEBds/weiV/2RhEGEnQ3dcGiaGG9ab2FV8B4UmHziIWX/n48UQbvQtoXskwrGZ+zVq1PQEUY63f
	QPZH2nMzhTWEaQUZr66qSmJGhPgZLIzScgnBpj328e0EE8SJgIXsAkBbIKVJ6L2ci11KdbYooHG
	+kGrITeBU5xybXUIKCbQUMtnVWKqA8GU/r8Q4sS13/wa/LZK4JPpuiaKa9+tJzZG0k4bi54rT3x
	/FHEd+gPSpXQTxr49PRMjkwE
X-Google-Smtp-Source: AGHT+IFErQwXqSNpK/6FrEzXPnkJQuSUwq8b4aWjOCfP5LHsMYbCFirtlFlujhvTW/ijh8+yT3EyjA==
X-Received: by 2002:a17:907:60d0:b0:ab7:c3c9:2ab1 with SMTP id a640c23a62f3a-ab7f34ab9a0mr174668266b.50.1739348254554;
        Wed, 12 Feb 2025 00:17:34 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b4724caesm694239866b.145.2025.02.12.00.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:17:34 -0800 (PST)
Message-ID: <8ad7636f-af6d-417f-8801-66530ff67c1f@tuxon.dev>
Date: Wed, 12 Feb 2025 10:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] ARM: at91: pm: fix at91_suspend_finish for ZQ
 calibration
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 Li Bin <bin.li@microchip.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Andrei Simion <andrei.simion@microchip.com>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <4e685b1f1828b006cb60aa6b66239f2c0966501a.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <4e685b1f1828b006cb60aa6b66239f2c0966501a.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Li Bin <bin.li@microchip.com>
> 
> For sama7g5 and sama7d65 backup mode, we encountered a "ZQ calibrate error"
> during recalibrating the impedance in BootStrap.
> We found that the impedance value saved in at91_suspend_finish() before
> the DDR entered self-refresh mode did not match the resistor values. The
> ZDATA field in the DDR3PHY_ZQ0CR0 register uses a modified gray code to
> select the different impedance setting.
> But these gray code are incorrect, a workaournd from design team fixed the
> bug in the calibration logic. The ZDATA contains four independent impedance
> elements, but the algorithm combined the four elements into one. The elements
> were fixed using properly shifted offsets.
> 
> Signed-off-by: Li Bin <bin.li@microchip.com>
> [nicolas.ferre@microchip.com: fix indentation and combine 2 patches]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Tested-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Tested-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Tested-by: Andrei Simion <andrei.simion@microchip.com>

Missing your SoB tag.

> ---
>  arch/arm/mach-at91/pm.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 05a1547642b60..6c3e6aa22606f 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -545,11 +545,12 @@ extern u32 at91_pm_suspend_in_sram_sz;
>  
>  static int at91_suspend_finish(unsigned long val)
>  {
> -	unsigned char modified_gray_code[] = {
> -		0x00, 0x01, 0x02, 0x03, 0x06, 0x07, 0x04, 0x05, 0x0c, 0x0d,
> -		0x0e, 0x0f, 0x0a, 0x0b, 0x08, 0x09, 0x18, 0x19, 0x1a, 0x1b,
> -		0x1e, 0x1f, 0x1c, 0x1d, 0x14, 0x15, 0x16, 0x17, 0x12, 0x13,
> -		0x10, 0x11,
> +	/* SYNOPSYS workaround to fix a bug in the calibration logic */
> +	unsigned char modified_fix_code[] = {
> +		0x00, 0x01, 0x01, 0x06, 0x07, 0x0c, 0x06, 0x07, 0x0b, 0x18,
> +		0x0a, 0x0b, 0x0c, 0x0d, 0x0d, 0x0a, 0x13, 0x13, 0x12, 0x13,
> +		0x14, 0x15, 0x15, 0x12, 0x18, 0x19, 0x19, 0x1e, 0x1f, 0x14,
> +		0x1e, 0x1f,
>  	};
>  	unsigned int tmp, index;
>  	int i;
> @@ -560,25 +561,25 @@ static int at91_suspend_finish(unsigned long val)
>  		 * restore the ZQ0SR0 with the value saved here. But the
>  		 * calibration is buggy and restoring some values from ZQ0SR0
>  		 * is forbidden and risky thus we need to provide processed
> -		 * values for these (modified gray code values).
> +		 * values for these.
>  		 */
>  		tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
>  
>  		/* Store pull-down output impedance select. */
>  		index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
> -		soc_pm.bu->ddr_phy_calibration[0] = modified_gray_code[index];
> +		soc_pm.bu->ddr_phy_calibration[0] = modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDO_OFF;
>  
>  		/* Store pull-up output impedance select. */
>  		index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
> -		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
> +		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PUO_OFF;
>  
>  		/* Store pull-down on-die termination impedance select. */
>  		index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
> -		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
> +		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDODT_OFF;
>  
>  		/* Store pull-up on-die termination impedance select. */
>  		index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
> -		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
> +		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SRO_PUODT_OFF;
>  
>  		/*
>  		 * The 1st 8 words of memory might get corrupted in the process


