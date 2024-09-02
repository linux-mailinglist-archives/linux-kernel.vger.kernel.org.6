Return-Path: <linux-kernel+bounces-311623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF6E968B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B388A283B34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFB1A2644;
	Mon,  2 Sep 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZOnisWJ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB81CB50D;
	Mon,  2 Sep 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292185; cv=none; b=RZhJzl0RMosZSxHbhSYFT145plvWzM7BXwFUtrpWHI1sYlm4MJvT7xFiLgWGxvZkvrlw33sgpeKaIXPPAYarw6t0croN/b9RHkvVIRui3JBwx9DAqhh87P6dGaR54VzM3iGcyCUgVBVGxOLfQ21hKzMuFUUqCkIeom2oSRIe4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292185; c=relaxed/simple;
	bh=btTUig4yvig19JXis/q6m3s+CbYWl61S/TJpo5tJKkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1JyKxx0z7pTJ8/XP0iG8FBMeBshbKKKzfQs4DwXuzqO1z4zA0PYt5rn8HH0D2s6V1XSVoNgIigVZbiwvytTX+kEyfrIwjnypPxvix/MjAXwNR8CpSOWOqJeJEL2e0S3SL22uZKfuCcTIpN5KLmPksrDTec7UOriHRXxHT9Eu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZOnisWJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86883231b4so527678566b.3;
        Mon, 02 Sep 2024 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725292182; x=1725896982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3h2EurFym/sQNYIHHNko50ySAciatxZuiR1HYEGZyY=;
        b=CZOnisWJ6kr28fRyOwwmzbBIq0DVw3YhkDJNSjg863cAjazEfLQnecvxWA8eGCZeKd
         LH1teXFvTrf/mB8WLBTWNXsTr+ArnU04rnoAAq5XjjlVna3op6/0O9XkVDhjj8lgxcNt
         HhrHDGsYCBLQwXl5B0y5slFqMGeoy8WuWgv/jZyL86zjFRjWyS0Lz1Roy/YZlCG7LfzO
         n7E04KrAb1aR3eEVOD/7RSSrUjQQ1i5E1lkqdvCIVIwYhyxT89kggNrogHO9A2Ev6VHs
         jxp9dF1jSFtI/xhKC9ttQwrH9rUxJSPxI/HdUppoNzICdhBCOGsiFsKQ9XiZIk7jGFHA
         kqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725292182; x=1725896982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3h2EurFym/sQNYIHHNko50ySAciatxZuiR1HYEGZyY=;
        b=kbgcpcqq+xI6AbIhnXR2LTe+s1Q56OYu4+8DbL+Ry0+RwE6jGHUWGyayE4fMZrQNzG
         snjiHNIb7+z941auoyxSDIYsmS7yxytssRMkKaeiEUx8tPxLHzSBndfWW8yUeSsAeV5Q
         u+q8gROavWdS/SmE00RcnepIcqZHBGI5P3amYrWFdFSSLwKJltDJxCkXKBMcJoS5hGgQ
         ZrrnkAkFRZj1qBOeacVRwBfCIDknp/z0UsU1FXnEvGfY14CTlWNcwgmj4cpq8FIj98Ew
         zDpeqnBZ1kO404cAR8x0TN0N3b5Q1N/ecHo5LbNvYJBAHCJ2U64n1bE2c/JB4+Umg0pv
         /Y2g==
X-Forwarded-Encrypted: i=1; AJvYcCV+GX0PUENSx6+8i/tcEnXTbhBT7ugv7pYm2eBxK/w57PTDJQUgdL0graHC9peWt8dkwoJvS1VN9ACj@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2+J6qRn5biGn3ksVUGlsj7XW/gDn0uvXWTO8lejrHlBZ4iCX
	P3DiTLeVujEevGdlvyHq88kJeDlB+epuvXdKBNRFmLqWOWfhDsYq
X-Google-Smtp-Source: AGHT+IFkrMJAr1bIVCDfHMNzWboGCkoQxUavu8RvYaOR3yduP93g/hvF/6pCzpzirPQjSCGSIj7GBw==
X-Received: by 2002:a17:907:d24:b0:a86:700f:93c0 with SMTP id a640c23a62f3a-a89d879c339mr476503866b.35.1725292181400;
        Mon, 02 Sep 2024 08:49:41 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891963c1sm573331266b.103.2024.09.02.08.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:49:40 -0700 (PDT)
Message-ID: <dad2df65-4321-497d-bb39-e96ca3df9bf1@gmail.com>
Date: Mon, 2 Sep 2024 17:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 1/2] arm64: dts: mt8183: add dpi node to mt8183
To: Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Pi-Hsun Shih <pihsun@chromium.org>,
 Jitao Shi <jitao.shi@mediatek.com>, Fabien Parent <fparent@baylibre.com>
References: <20240819120735.1508789-1-treapking@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240819120735.1508789-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/08/2024 14:05, Pin-yen Lin wrote:
> From: Pi-Hsun Shih <pihsun@chromium.org>
> 
> Add dpi node to mt8183.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Applied, thanks!

> ---
> 
> (no changes since v1)
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 267378fa46c0..266441e999f2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1836,6 +1836,17 @@ dsi0: dsi@14014000 {
>   			phy-names = "dphy";
>   		};
>   
> +		dpi0: dpi@14015000 {
> +			compatible = "mediatek,mt8183-dpi";
> +			reg = <0 0x14015000 0 0x1000>;
> +			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DPI_IF>,
> +				 <&mmsys CLK_MM_DPI_MM>,
> +				 <&apmixedsys CLK_APMIXED_TVDPLL>;
> +			clock-names = "pixel", "engine", "pll";
> +		};
> +
>   		mutex: mutex@14016000 {
>   			compatible = "mediatek,mt8183-disp-mutex";
>   			reg = <0 0x14016000 0 0x1000>;

