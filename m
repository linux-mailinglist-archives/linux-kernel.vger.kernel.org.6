Return-Path: <linux-kernel+bounces-311625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11D968B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F4F1C22882
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4C1A2644;
	Mon,  2 Sep 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKDu4cNz"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F661CB50D;
	Mon,  2 Sep 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292244; cv=none; b=T8oWROqVIP1EHI6hv9Qfjcj/MrJrnTJQvTMPFNoFDJJEFWohOgmutgWrO2nmj2646mTSBdp2aJYAhmJY012tyE7Grs0Qe2WC+aG+pn3fJEp6ZhOsEut05N2BK3cv9lbL6QQ+C9Tdok88XYuplTPsBGcO62wmmpuouPzL5PCq1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292244; c=relaxed/simple;
	bh=y3ndkjOdhpSPMHB2ih4PPVXSlMawTsh0hPOEWJ35ENc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhlVDJYB33IXwI0cDUD7FZxOoaWlHGkOI7BWn4c2S2szFJVJX8Ra1uLv4I4FvMPUG8zzTLxBCUy8KC7ly5lnn4vIkCZ7gGbSi1ePbZ30uLiHSNLbKsihlthzaAC4RWwlT9S8XD8OSyjvkCZZ9RCt0EhJj3056dPKWcLTnTD9KC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKDu4cNz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53345604960so4928452e87.3;
        Mon, 02 Sep 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725292241; x=1725897041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfR441/z2KXRbtRPvcV5jaQ/+dlUWdH1GL8QEmA05xU=;
        b=VKDu4cNzws/nU6rJv3BZlfxVoGzv+WgfkpvGqel4NzBo6uPPxNnB/aLhemXaZ2in85
         1tBrBvzhpO4PX5T1l3K6OkLU2yXOOFNOS7shs1HAsiaIdMAv+9ubD++yB5fLrevT/fJv
         5J0XwRkNq7XfOpFpEtGqDOAFMlQFcB9ctwxSFgQQWhKxvbI7x+z6K1p6Grq68ycMg8vj
         O6tgBa9rgn9IOyUMq/uyDYfY6wXJQfQ3FzG/uzWMpsLxTuYWJMn6qVA1JvKPFBYwBxVi
         7Zn/z83RBR33xOUOM0ihpxHDKkVYq6Q7gegR2g75N3KhrXXgSC15k+qj7kmvgJf6/pEk
         EC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725292241; x=1725897041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfR441/z2KXRbtRPvcV5jaQ/+dlUWdH1GL8QEmA05xU=;
        b=vZI03j4N8eHb+KhYo6rWPhMwHAUw7luaq1L1JS8zNRcHjNLHQoExYXHBgahAaXEQxf
         mPabFMwKuFd55jI/i7pfdQJLGwZSjIcIUdjCP4GDw0DjJeTikGRArfYZ9yinm137WyCp
         fzsW0LTOmjZe84a0Ow9x+EDJjDux9h3AYzCB95BmopHd8+eUQTrlNjr8N75IueRYoWqX
         w+O9Ilv0Ew4n7tbJr5VpK+oW3+147I61R1LvTY7j9YxObqH979aJZw0D9uDiScp8Tpoq
         Zi4Pt5u7W47vkerD7IGKJCBbTrGNoFIIQ61zgJ0Es5OAbISfmCb40Hmp/PYzDzFcaxGZ
         vYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3hbncnSH8+67JbBEfqYORNXEKRa5M9ciDImhi/f7o/dIty9pp513dCT4V3K+I0UgmH57SW00i7yBWGMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjc6CKCFoJmpNgRtFVQJAzvbEXrDyaIxXga0+XnLyC3aGAQyT6
	0w4BLqhpGQ1/ZHvPF+D/88UChthgd9u2OTEt2ppOoV5HPuvhk31s
X-Google-Smtp-Source: AGHT+IGBu4sXdVkP/DfgdJUulgeC3nRnKuj4BLMXI2x7OZ5cdEIkk/9G5JXSziB5lUuUgi07UyYq6Q==
X-Received: by 2002:a05:6512:68b:b0:52e:f367:709b with SMTP id 2adb3069b0e04-53546b93fb3mr8150957e87.42.1725292239827;
        Mon, 02 Sep 2024 08:50:39 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196715sm571049866b.113.2024.09.02.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:50:38 -0700 (PDT)
Message-ID: <b0d83115-db4f-4c3b-9cfe-e889b1410c44@gmail.com>
Date: Mon, 2 Sep 2024 17:50:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Correct clock order for
 dp_intf*
To: Chen-Yu Tsai <wenst@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240802070951.1086616-1-wenst@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240802070951.1086616-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/08/2024 09:09, Chen-Yu Tsai wrote:
> The clocks for dp_intf* device nodes are given in the wrong order,
> causing the binding validation to fail.
> 
> Fixes: 6c2503b5856a ("arm64: dts: mt8195: Add dp-intf nodes")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 989e8ac545ac..e89ba384c4aa 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -3252,10 +3252,10 @@ dp_intf0: dp-intf@1c015000 {
>   			compatible = "mediatek,mt8195-dp-intf";
>   			reg = <0 0x1c015000 0 0x1000>;
>   			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
> -				 <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
> +			clocks = <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
> +				 <&vdosys0  CLK_VDO0_DP_INTF0>,
>   				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
> -			clock-names = "engine", "pixel", "pll";
> +			clock-names = "pixel", "engine", "pll";
>   			status = "disabled";
>   		};
>   
> @@ -3522,10 +3522,10 @@ dp_intf1: dp-intf@1c113000 {
>   			reg = <0 0x1c113000 0 0x1000>;
>   			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> -			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
> -				 <&vdosys1 CLK_VDO1_DPINTF>,
> +			clocks = <&vdosys1 CLK_VDO1_DPINTF>,
> +				 <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
>   				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
> -			clock-names = "engine", "pixel", "pll";
> +			clock-names = "pixel", "engine", "pll";
>   			status = "disabled";
>   		};
>   

