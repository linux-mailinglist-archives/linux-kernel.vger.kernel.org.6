Return-Path: <linux-kernel+bounces-523751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0CA3DAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8D816F67B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49C1F150F;
	Thu, 20 Feb 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iub5bwes"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFB1F1508
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056598; cv=none; b=nt35r9ZGQwp8poXulNPrSNuhWJDYIzi85ZQ0rQUMSFsg0rGRpCdevO7tB5SaWWeGW/olm5qem0rr60MqCwms5WXo1V/Oal550eqx48ze2jDCVmMGUPgLnp8PR3svGqTiet9p1RqNYg82aLNC1XsE1oejIPxFW7ocToccikWjrCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056598; c=relaxed/simple;
	bh=YDHwi4ZX5NpJ4uSkg1+T6EW70u8iGD5w+2zjSD2xUS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwyTB0tMRbw7NFrv9PIdOc7QDL8XBBchSKjNq5+SV3SFR/FKXoxpBFez/9OYTL7ZW5U99XLuSjx1S1Bg/+glYCZVvpXliD2TPZjajYaA1GkSFH6pNNnsMCX8DUze9bRH8wVx5PwLT8nVMdB7pAn05hoS/zkXC8avGVdWua5rq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iub5bwes; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so460025f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740056593; x=1740661393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYNHFwLBPMiuE6a0KUHaSz0Gjwcyu1dBkTLSZJgvMTY=;
        b=iub5bwesx4FCETIe3OW6PcioSXL7eq+8khnswL+YH0xCodZ4X5D9jltrRpgDKzBEFw
         3NZ3GV/s+kR0U01pktpcyzLrEWkAY75RdAm6V9wZXFW54D0Sn6tZePdSHwEEonah658B
         1ioeNbGw4/4paNwXmbQ+z6c7jYIumgkPxU2uxIOmxHSJfxagACjtARaOwssLfQHNd02w
         74f4orE1c1cy3XzI8kXYa6H1CBNROjcK9/seLJXfvO5cYiupUWuAWU9ciXCvBzx2J5Au
         1Vb4oPaXUxiy1pkUyFcIrBpnzEHJW9a/0rXp36RDbGJ+pEbitZUQ4s0OvecL9VY+QGU7
         nW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056593; x=1740661393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYNHFwLBPMiuE6a0KUHaSz0Gjwcyu1dBkTLSZJgvMTY=;
        b=V/WWAX2sGKcLCDPGLdMLrRRGW0GXK69Z0q58OUQVEGT7KMAu+cjp2CtTO3kPtr/6dw
         p4jPHvsi9J5xhSu8hWuGZml8iuI4DsLrSzhlIbZmMuyn4Zm8srekELdZvxNYZEW/9pPG
         9wQ4vc9modJT4vmASpkzISpgMLG/jzv41P5AaWRbEArxXnAshRKPnnf7FQhoxDbG8o3R
         hPVGUw6TDKdzK5V7nkwXfs5X4XCIDOtR83uMK9yjOk0r1uESLU3EVks3LMowF4j4tiF4
         RC60kLWHju3lpJNaBc0HdXvDlqN5x2Si3HcL2no2j8iv2RhSJwW/S3SDRlyHuVsEZq2H
         MHqA==
X-Forwarded-Encrypted: i=1; AJvYcCXb9vy47JhugoAP/KCPTUEYYwItdOl1oZ8oQWrMPthkzlKjB09i4R5GdcEUpgUdaf2pt0Y5qPNsI1eu3MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzycpYCgyw+aRgH8CPuVKxuiLU/iqfe2S7TFDcXwONsG0RcrOg
	wN6uS0Ab9EwYdHX02be3cktFbStEnHOJWPB3wzCtwyCavGDXr+yKMs8r0J6ORbI=
X-Gm-Gg: ASbGnctFK8VsLc4U4wTL0B8k2cIVnymIM9XxkP2Vq0UU55ixWdkZZO+qGiIQSHCbJjR
	KLm3v3Bb8rEb4XMKJva33buLyx/1CCpA7v3+FZz9wmPT5AIfiNEJUKbTzDbZjHfLI+TqYNfNjql
	JzLVbKPsMMPJTvhi7EbiWzmgTDyqq5Vnxh02K09atttTiy1vU17HSVBtc8GrIVjojAFkz5FcXcS
	ifMDN9okLX1xOPl99sLOStqVAqY9t0twRuM3+IaVXU+fgfA9U/Y884LBnu5MFuQVuJa7qdEOjSF
	pVwmN1keyor1FhBexntmPs6KQ6XvBE7WFrgCRTu1S2KHKnwbOfzeLonlD3gieYg=
X-Google-Smtp-Source: AGHT+IE+oBz+Bsv3JgfnD0JtZwzb1aLQt0+zm+GoaoUPVnk9517cD6yzlHLB/acLlXqZ8+4BcP2iaw==
X-Received: by 2002:a05:6000:1f87:b0:38f:3073:708 with SMTP id ffacd0b85a97d-38f33f11888mr20574908f8f.3.1740056592485;
        Thu, 20 Feb 2025 05:03:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:b630:86ab:c45b:5c2f? ([2a01:e0a:e50:3860:b630:86ab:c45b:5c2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm5976564f8f.21.2025.02.20.05.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:03:11 -0800 (PST)
Message-ID: <c77e60ea-0a5d-4e27-bdca-e5b4f5904781@baylibre.com>
Date: Thu, 20 Feb 2025 14:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: config: ti-sci: Default set to ARCH_K3 for the
 ti sci driver
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Andrew Davis <afd@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250218-ti-firmware-v1-1-7a23aacfb9d3@baylibre.com>
 <20250218140537.wfagt3spwkcmc3uv@cushy>
Content-Language: en-US
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20250218140537.wfagt3spwkcmc3uv@cushy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/02/2025 à 15:05, Nishanth Menon a écrit :
> On 13:57-20250218, Guillaume La Roque wrote:
>> Defaulting the build to ARCH_K3 for the TI SCI driver.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>> Link to comment done on last serie [1] we come back on first version of
>> series[2] to not use imply but set deps on ARCH_K3 in driver directly.
>> An other patch will be sent to update Kconfig.platform when this patch
>> is merged.
> It would be good to expand the commit message providing the rationale
> for this.


i will do , thanks for review


Guillaume

>
>> [1] https://lore.kernel.org/all/20250123-timodulemailboxsci-v4-1-b1a31b56f162@baylibre.com/
>> [2] https://lore.kernel.org/all/20221122202245.449198-4-nfrayer@baylibre.com/
>> ---
>>   drivers/firmware/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 9f35f69e0f9e..109abe063093 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -215,6 +215,7 @@ config SYSFB_SIMPLEFB
>>   config TI_SCI_PROTOCOL
>>   	tristate "TI System Control Interface (TISCI) Message Protocol"
>>   	depends on TI_MESSAGE_MANAGER
>> +	default ARCH_K3
>>   	help
>>   	  TI System Control Interface (TISCI) Message Protocol is used to manage
>>   	  compute systems such as ARM, DSP etc with the system controller in
>>
>> ---
>> base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
>> change-id: 20250218-ti-firmware-1b7c7f485e5a
>>
>> Best regards,
>> -- 
>> Guillaume La Roque <glaroque@baylibre.com>
>>


