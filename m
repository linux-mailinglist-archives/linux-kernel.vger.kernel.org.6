Return-Path: <linux-kernel+bounces-321420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15B4971A39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4EC286799
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50FF1B7917;
	Mon,  9 Sep 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BCAMgWpv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5661B78F7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886906; cv=none; b=azRtK0VwNLD6BNoHiR61OO7qDTG51/y/JW3PdGrTUq7IH6+U2u99YSD7JrBXoD6JHagM4CL/1wsLnko7E3ZmRg7Y/iCSGvY0k0IfLhYDmVcPpw4MKqV9l+9lq2R9pgjnITW38rvlrAVa8e9HjeO5pAlGeNgKTig2n/qLiJCRwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886906; c=relaxed/simple;
	bh=kemG0iWRB01BAfE2KwMKfnzpCqvQn9ew36PslWva8OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhN32wJE+GsFtEeYMVrTCrYtOKZuyVIU6ZKavRGk5qcPZeqqNxAq4lsTUuZSqPUNgRhvj8fx4/DIvZtjt7ef2iSgPf2lcBQnwIIpY6aydV3PMv7LiBHBas1Ck/DDT4o9VIZ5z0q2K+wuQByBt0QiWkAheZE0vlL7237Z+/+bxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BCAMgWpv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb806623eso9205815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725886903; x=1726491703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umZi9yP51lcJ8RnrYZCo5jDOmCTZJdRYUd8lcqv4bzE=;
        b=BCAMgWpvniDBlm+5hNNdodfM5gRQlDX+8wPycYhidtB2ULZmUQFpE5qqZ18Qd+aj09
         Ue7wC2mbQTtLdWGgPxr9Cdte3O2PVHJBqdXsfsFLsK1YJGQOhfadZU5mf/2g2/NvgK7J
         eZkqaPrq6BPCz1oYMZ0osPiBbjJtWV1WXOGw1yQyKxbFYMhZPi/bF0E1T78X7xjN62pn
         gAyCCgESrXxHBOOPDu44u0V0JdEohe/l+SVAGqc3AXq/ba1n5YXnArxJ9ddhdpJhl3e+
         4fwMG27xWZeEX4nbYfYGZQshRrutMb9bZ5v4u80TUuTVL3TZAQUwdzy+15ty9463FEwo
         LVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886903; x=1726491703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umZi9yP51lcJ8RnrYZCo5jDOmCTZJdRYUd8lcqv4bzE=;
        b=cBSDuFlzSTdzq+g3PDsRWGRHj5W2VB9OhCvWZZG0KXYpEu0etGryxIzGINtvMdDO79
         LQnRvr/yar961POLx32JoyEB/RXmSDp/zWG02OR6+QEk0b38UaW4XHTAO3YVSFhc11r7
         EIB31Rh0fHmSJjADrRw72y+0AHDy4CjDxtKePVmVKRwofqzooQbde/AQHZel0seeFdS8
         +SjFiGFUBvkTf2ygiXlh81I8cSTSH50ndoMb4ZOL1sN9aSBROjW14jhopLIUqZjtUt5g
         RiNUlL85UJANisyxT7OZkXUhtsOAwnI3oFNQYgfBqJDUTexXPnVKIe+2mSyhGl8ngM5K
         fMbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWlgoG4I1Jr7LdxdtUQYjyflqJTaO7jM92vu8mo8JMJi0gJfsxloYKPmpqpj4EXgy3kO+GLXLmD5/8oE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24ZpSN5Sfo2E9VMf5l8ocBPyZKLDzkwmqnEDGA5CEymTxLbZo
	xVBza/gd74rCdzta+f7P/30hH2yluSThCNLEwt29gFezPXQ015pryAwrvYTDee4=
X-Google-Smtp-Source: AGHT+IH9Romwpgt1JE9YYIpT65omJV/odmabpcbADjq2kLQrDj02YgN6/FmS8gS8gLzsLuEGe2rV6g==
X-Received: by 2002:adf:ec0c:0:b0:374:cb5c:2966 with SMTP id ffacd0b85a97d-378896a94aamr8655060f8f.40.1725886901672;
        Mon, 09 Sep 2024 06:01:41 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956652ddsm6040100f8f.29.2024.09.09.06.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:01:41 -0700 (PDT)
Message-ID: <ce36e6e6-2e56-489c-be15-5a2d84d035b0@baylibre.com>
Date: Mon, 9 Sep 2024 15:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ASoC: mt8365: Allow build coverage
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-7-7ad0bac20161@kernel.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-7-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 07/09/2024 02:53, Mark Brown wrote:
> There is no build time dependency on anything specific to ARCH_MEDIATEK so
> enable COMPILE_TEST builds.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   sound/soc/mediatek/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index e6f7a5a49794..3033e2d3fe16 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -301,7 +301,7 @@ config SND_SOC_MT8195_MT6359
>   
>   config SND_SOC_MT8365
>   	tristate "ASoC support for MediaTek MT8365 chip"
> -	depends on ARCH_MEDIATEK
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
>   	select SND_SOC_MEDIATEK
>   	help
>   	  This adds ASoC platform driver support for MediaTek MT8365 chip
> 

-- 
Regards,
Alexandre

