Return-Path: <linux-kernel+bounces-292905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5595764F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1763282725
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720015958A;
	Mon, 19 Aug 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpxX4Dyr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CE158DC6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101293; cv=none; b=dhyKwue5uUagfXz2XalB4So1JIK1bnH3EcI/nv0SavQtiuZ0duxDJKjkP87En1NSEKILaWQTo7qyvXsx0ellvyj93zqHggqttxRJm0BPAU7CmVnRaCnh7n4RYG9xz4YrDEuFStEUOlnqymSPxCyFwi1ybLf0if5X1WiW0v8Dnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101293; c=relaxed/simple;
	bh=9nGvuwlRQu0S17GK6GfDerT6hOCftp2JKcZU9tc/Pes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzMfUAN3U8FUu83gM5cW7/TUjcuLCI/ukwS4ETOMJJizKPNJ/GAVAts36kqroVb5jtH56kKLfK20gbhxyv7QuHa9fdkMQyrEu9EVUKF+LznOIvhE2R0vLVymjsWKyoTD5Eitu4iOe6zb4xri1UxtfpZEMX/4WIqWsBAIGevhLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UpxX4Dyr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso3407870a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724101289; x=1724706089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kS98d2vfhYOcN9u5k0d2TgxE3S48keIqZP/bIunh0+w=;
        b=UpxX4Dyr8cW4qbiqGdFKJlfwEu9mJcky+Vzi9PXQYolXVigdT2XT6o6LRo9BxZavqs
         x9NiNo2iYfq+INUx3NyFEGQtVssZy/ZMpWQsJlwhbIob/4XFTbDQfrvsgCXnwBFKnXe+
         BI0hT+DamItNGsDah40QllNgCTK2z6cUPl1iUmwkrNCKjpGJ6ueWaLQ4O0l81W8xef84
         EqvLaC1hM5gy8dZoK+BoyBZSnETMPHFf6awGtqmlKDSfLdwYydM0I6+aR24Oqj//aYfu
         h3auvCzAOkoT8kJjCCttOSQzbQ3z7elaxUK287CYs0XVPxOwMQMN4wb5kzWRVX+E2/KS
         zdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101289; x=1724706089;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kS98d2vfhYOcN9u5k0d2TgxE3S48keIqZP/bIunh0+w=;
        b=qFK/S2+AgQNgEeZG5ktrJ4oH7WhVNx/MKwtcwN84S/FJH5NxwkvkWIaiUb98e5W3JL
         K62fnJT7rWDEYckgvTuv8Un7GGJLrI1jpqHCZVkSriRwhxLD5xRIM3aUoWxXryQE0rHJ
         /NVDx6lc1hwGp0vZi+oQAALbbArxPNCzMbdAQyOqefi60uAOcPMvtuS5AorQvtR0GJG4
         wihjzqg7qCIFOvFLptJbxFJwGG6Usn+amG3lpBX5grAHnaOf0zh/5OEsOxe6cdmkiTnm
         OM1FxfxsDPZwTmxsxZXh6zN0qeiD4ajguCOlQugrGJ1lt5MlNVuMJJz75RTZ5GkcbPqp
         /3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUxZ/tv6OcBhrwIyJN12QYOSAueQ5Z3DBJ7XGfCn8bsL7ugBVcHKLzQZ6zfBBWYQePAxNP//OIyVP7AKpUfblGa2gQOTvjoTd7/mjU+
X-Gm-Message-State: AOJu0YwgSXpigj4Wf3rIdHEeCdyDmab5qTdiPLAMRZW7C00c17CzxIN+
	zPgrP/LMnYzUdNDSRf6iYZdhH1i+qAojHKtcpq/geW6b/Hw/Gt9qkyBH/G1TIpk=
X-Google-Smtp-Source: AGHT+IFB5FCwUDcslwOYJ03bIRyZ6VmN0b5gNAAWbzHasC1PJvgkSwFM7yiqhd5Mf7Os32MV3+RRoQ==
X-Received: by 2002:a17:907:a47:b0:a86:4377:98df with SMTP id a640c23a62f3a-a8643779da8mr85869866b.57.1724101289020;
        Mon, 19 Aug 2024 14:01:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6777sm683955566b.10.2024.08.19.14.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:01:28 -0700 (PDT)
Message-ID: <1a7def3f-a19c-4f1c-845c-a3854c165995@linaro.org>
Date: Mon, 19 Aug 2024 23:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
To: Judith Mendez <jm@ti.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>
References: <20240819204352.1423727-1-jm@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240819204352.1423727-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 22:43, Judith Mendez wrote:
> SK-AM62A-LP is a device targeting automotive front-camera applications
> among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
> to power the SoC and various other peripherals on the board [1].
> 
> MMCSD requires the PMIC to be setup correctly before setting the bus
> pins to 1.8V using the TPS6594 driver interfaced over i2c.
> 
> Currently, the following could be seen when booting the am62ax platform:
> 
> "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
> "vdd_mmc1: disabling"
> 
> and a failure to boot the SK-AM62A-LP.
> 
> One solution is to use initramfs [2], but using initramfs increases the
> boot time for this automotive solution which requires faster boot time
> parameters.

This is a defconfig, not a distro/product config, so your product
constraints are not really relevant. You are supposed to boot defconfig
with proper initramfs with necessary modules.

I don't get why people mistake defconfig with their product stuff...

> 
> Another solution is to change MFD_TPS6594_I2C to built-in, that way the
> PMIC is setup and the regulators are ready before MMCSD switches to UHS
> mode, this is the preferred solution since it does not increase boot time
> like the initramfs solution does.

Use initramfs. Several devices, e.g. most Android ones, have fixed size
of boot partition, so size of kernel is important.

> 
> [1] https://www.ti.com/lit/zip/sprr459
> [2] https://lore.kernel.org/linux-devicetree/5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org/
> Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")

No bug here to be fixed. You miss initramfs.

> 
> Signed-off-by: Judith Mendez <jm@ti.com>


Best regards,
Krzysztof


