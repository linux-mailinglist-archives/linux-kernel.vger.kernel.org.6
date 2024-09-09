Return-Path: <linux-kernel+bounces-321247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC8971663
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734B3283C32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE461B652C;
	Mon,  9 Sep 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezu/1mY3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AD1B5EA9;
	Mon,  9 Sep 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880674; cv=none; b=j8G2he/vSnX7muAbZju6G7i3bNFzbyol7OvFb2wyMFrDKIEtcmTfjMgTbpuy20Iwo1On2hs1BT4UTAqHEK5VUU0djhwM5F0mcMnIEp3wBo35zZJodPUoFEPae048vY9KKQnhk5AhhtFKvU0LwQ60HHgevBCfmgTxBvewL65xyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880674; c=relaxed/simple;
	bh=ggGsm9G/nI6YzF1q4ufx4104j5XsYa+DgvCH9YkOdNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maSZ1xRFzpejG7hm28of1kwnvjf1xXyn2uJ4QvmVA208XHpXWMcnnR7i9VH5iShIvh/vV5C03EkXxcqd5e1PW116wVneLF30r43OwVMvAmRR66keN1qZ9+LLw4RzD2sgAI/SCdXb9Sa0acfb45A4ix1yyFAEv4dvLopp0iK5cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezu/1mY3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c6187b6eso2546324f8f.0;
        Mon, 09 Sep 2024 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725880671; x=1726485471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ac2yXOZiCXwloTVcKuDSBoURmprD1nlIC0/ih4MiacE=;
        b=ezu/1mY3snLnY932dAXwmasuHkqUeDy+AGQvNPRvSM3NthplFX7zrwV9SgxYg0j4x7
         dOu4ywux93qzMTkpz7yla0IXcSuS+2tEfaAkeG1lPhsuUwDRHOxqF8Gfn+lzP5bpkfS8
         aDc5ze8z9jBzi/IPu/hujc3SvG1hba456vgcPotkM6wjdkKIGClYetQIPv+JWJv98RxD
         b2vE142Pnb2mn2AwOOX+AvJLTpnU7ORo2hw2cbBmRP7Pr3VGV13oiADpLUMB3+bGqyDY
         P7ljKOvHZpY4dricGe7T5oHORnKLx/pwKuCKEzLzkHzwWVyfHh/Ja/2Fj7uIi9DLJ3Ff
         OuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880671; x=1726485471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac2yXOZiCXwloTVcKuDSBoURmprD1nlIC0/ih4MiacE=;
        b=RvdsXz8j9CvsdaR+smrwtjnrFYD7wkh+sfUmSRgcTfaVJ7ILNV1iIuD+zeCeLcJkIm
         G9vlA1HuZwQfpEK6Y1iGNdXt3jfW/qtpJUmoI2d+K2rmC1U9goUHMe1ZWD6AbsCUNGUZ
         sR5km1hrJef8Xwe0D4FIp2Px+KIxQLyHGA2qjV0RLD4il5mpHRooc++6DOFORmJHxX9m
         u6Jb0+InVLLbUyFj8pbwS97Gl4xIKGWs3UNMcR48IvtrZPTmhaVct1LdqWlsvZ+kJmt2
         2ZWAkb7HCC3uWkPyEurtqOPCGcfZBvDVW5WqBoS3QJwmjdWg9Xf2q+ScHgHN6SvvbVFG
         3Cfg==
X-Forwarded-Encrypted: i=1; AJvYcCUrJ0WXYiNdDYcvdIrS2no2UuQ6EoTZ1Bq3QeLpM/6XOov3CAjC+tyEvPkn2YSnT95RfVA/vyAHoYPRI50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3R5MdoZbkvT3Ktq9hw9MOEfqbCfSTuhGHTFsrtvKFz7ft04p
	y7YQEtM+jkxbNUxo/MD5K/UJV+c1a+llFi+u+eRSqvS+zx2hb1Q9
X-Google-Smtp-Source: AGHT+IFeNMDfA/EgZ3KmAFjCS1KMtqdNkQe5X85FjQhVG8wjXuygLYBWiBY2NKT2YLUfyiH5+vktUA==
X-Received: by 2002:a5d:6608:0:b0:374:cbe8:6f43 with SMTP id ffacd0b85a97d-37889600838mr6389654f8f.33.1725880671329;
        Mon, 09 Sep 2024 04:17:51 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.7.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956652e8sm5847477f8f.30.2024.09.09.04.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 04:17:50 -0700 (PDT)
Message-ID: <9903db96-1960-4715-a1e3-1d477003e92f@gmail.com>
Date: Mon, 9 Sep 2024 13:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mt8183: fennel: add i2c2's
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
 <20240909-i2c-delay-v1-1-4b406617a5f5@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240909-i2c-delay-v1-1-4b406617a5f5@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/09/2024 09:29, Hsin-Te Yuan wrote:
> From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
> 
> Add i2c2's i2c-scl-internal-delay-ns.
> 
> Fixes: 6cd7fdc8c530 ("arm64: dts: mt8183: Add kukui-jacuzzi-fennel board")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>2

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
> index bbe6c338f465ee7c11bfbfc30767bdb142706480..f9c1ec366b26607581c116b364cc2f80f8621a57 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
> @@ -25,3 +25,6 @@ trackpad@2c {
>   	};
>   };
>   
> +&i2c2 {
> +	i2c-scl-internal-delay-ns = <21500>;
> +};
> 

