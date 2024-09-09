Return-Path: <linux-kernel+bounces-321264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59434971699
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1232D2816E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7FB1B653E;
	Mon,  9 Sep 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD6/D+xd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5B1B78E8;
	Mon,  9 Sep 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880730; cv=none; b=sNJ24lU56FY99VXqJhmo9VBDmt6lzaiAjlLQsHTQOWLlMvrBvOKbsNq2UMaA54TtvQKuhkQDYofM6Y3NAh3wUqcqC3JvcrqTUyibvtA4z2D/e9HNb39hcD4jH7yeXA3tSI7dEzIQoIJGzwXIE8nCkZ18Ty03lelPyX3OiicWFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880730; c=relaxed/simple;
	bh=8F13Oq1vTNNyq7jRh8XnYi0x+Z00WNGmMU8YOHuX2cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsQlhh5GhbaKmSYuSGOiiO2E/WGh9oujuwNN8mP8D3Ex+a0rvXTc4ZGcBjyNPwDkIGG7sYETLNAoS49JnSgUAHz/quyYRjIDeCAvEUz1b3tyMbOhwftxMbKG5M1kZ/l5m2xTdq2OZYqCBNufC/sk+rcEttGnw2vQopWRpKYV5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD6/D+xd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb806623eso8090745e9.2;
        Mon, 09 Sep 2024 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725880728; x=1726485528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6G+JGSqnaSCmD/h+CX0bavz4T0upTphKGU3mEBW/Pcw=;
        b=fD6/D+xdX/+WJKyrgnMcZdY1xgiYchiRFJ1ip5NHqUnyhqUJrLPYLhGPNRy8o4etLz
         oaS03xKrAGH/7qFefFfBB4392xY1ivCptB63GxxGsHouBmWv8BBZFyyonWY6rL9BRiz3
         k3aBFGFQ1vDLyg4aNNsOAsbWQsTqfHIfgKlbBOWyncHeT0mFvpJxqBp6V8EvWeUN7VdR
         z3B9wBMuCm/aH/H+pWlG0kdt1VdY1NGOy1d2NSgHBg8AL/D2Ul50GQumoNMNdZatOyFu
         Wcg6V7L3BakDdexECMJLqsEtM1abQ5/KlC+y/ZVy5LQo760kvMuunfM4sTKJ1VJRXveQ
         5BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880728; x=1726485528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G+JGSqnaSCmD/h+CX0bavz4T0upTphKGU3mEBW/Pcw=;
        b=s95UPRH/Q9jJa5n6TCaMLLIO7jnvr+DGRk1gBRy/qFk1uEOLyPfhI7jA54ZyXFj95D
         fQvNnhb2EEUQzIky/ObmEYtm1FdKMbRmoA4M11u5dWBwVWlz3hXGXf71/4eTqbPaNn7v
         MMv3GGfOqi5SD9muVU1iH5uEDeS+oS4gnjW702EXqFVddlvIVU7rwqRUmeOaFZ06Gcf+
         PiHvrjoup7jlz3leIzchFwYCU48hz8iKCii78x7Ph/Ul0tWXROJ5byqy91ZyofLzaHSZ
         oPG0hf5ldxRbR5jMamVhxsqUV+2QMM/RIGk/RnwZQg0TUGwjVw2gYJlncNSnpE3ONq0S
         dg3g==
X-Forwarded-Encrypted: i=1; AJvYcCUuFzAdDeeVEc3qfdWzcb+fY6ekIqCiYWE8n9EWeX12ah7m0zMEYk3LRdrlq3xHgjAzHGz9sLg58DsLI5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeKcXlmAqE3k2TXXmkX7St6sDsRZg0ylyJN7sZ+vYGAAEVVz9
	5IoaTvDPLL4BD9bhhr2G5RswkwdDLOK7qYMvtNzVLCaUUbyKAlXE
X-Google-Smtp-Source: AGHT+IHLCrmF9H9WFbqMqJjwlPU+iWHBGYMATOXbE8EfRhGKYVPrhPWzTjmn+DPqhqhE+EWC/3HbjA==
X-Received: by 2002:a5d:4851:0:b0:371:8e0d:c1d9 with SMTP id ffacd0b85a97d-378895ca826mr7835657f8f.19.1725880727590;
        Mon, 09 Sep 2024 04:18:47 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.7.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb334bd00sm52323175e9.41.2024.09.09.04.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 04:18:46 -0700 (PDT)
Message-ID: <af3bf83e-8bd5-4349-8647-a2cbafb5d7ec@gmail.com>
Date: Mon, 9 Sep 2024 13:18:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mt8183: Damu: add i2c2's
 i2c-scl-internal-delay-ns
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
References: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
 <20240909-i2c-delay-v1-4-4b406617a5f5@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240909-i2c-delay-v1-4-4b406617a5f5@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/09/2024 09:29, Hsin-Te Yuan wrote:
> From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
> 
> Add i2c2's i2c-scl-internal-delay-ns.
> 
> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> index 0b45aee2e29953b6117b462034a00dff2596b9ff..65860b33c01fe832f3a4b2e21d24ea6b4f0cba2b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> @@ -30,3 +30,6 @@ &qca_wifi {
>   	qcom,ath10k-calibration-variant = "GO_DAMU";
>   };
>   
> +&i2c2 {
> +	i2c-scl-internal-delay-ns = <20000>;
> +};
> 

