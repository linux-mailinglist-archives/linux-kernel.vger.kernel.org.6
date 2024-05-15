Return-Path: <linux-kernel+bounces-179349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C718C5F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84344B21C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AD1B7E4;
	Wed, 15 May 2024 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCWWRTZW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3318635
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740167; cv=none; b=kIwxPW+9co4a2U0h8F32I0NIojBiW6Z50ydYhH+F7KZxjJhgSpfCi1ZpKa+knJ4AyyFZwth4SWTrYIllm/yDhGECbUUi0cIeaK8GzBTnGmh7lbsD4ns1+bUmC1evmWkxAtCs7QkaTDFGqGzGdZDeNBog07+bLq53hwrX1VN9a4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740167; c=relaxed/simple;
	bh=Jstvl0Sw+tyHgtAutAqkp2d9laKunvjsUdOnBXtcPPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLFkutWfVTbm7/91ETqayH/6KDFFKUaoKBWF9H4J4k/Mz3OXwFk8InhzzYBP/zPTTMjR6QH7vf+QYwqiHPYP3Uud11/3/BKqYe291CwrDnWxlvSi07TaAJgius02W5RZMAHy2wICE3zOs1i0AH+E7XseWnnZgBETL69efmexw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCWWRTZW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed012c1afbso49882155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715740165; x=1716344965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIgpUa8KxyLUmcPW5rdHLb8CzpDEUu73pDtvEeNol/o=;
        b=dCWWRTZWTLEGlgL3oCwzZu2M/Gv+vP297wf1sdVzzo6X/OYnQpJb9kiXCew0Dkx+xk
         uh3TmPwRjF3xGM10ARhbdpi9/G9AUvfPoA+X/J2b57vJOIjW7Mjs5TTYCKb/wAc7fAiz
         m9brwTlIMT45epm1IBzuDWu83B5EFRsPUCD2ca9d8aVZOrQ8WzWoH8BncdPBJT+gd9Ab
         B8AvAdB5pXuiCX0q5CS5fZugPLzhhSnbPTkqGIpPYMPrc2hOM88MxLhn0ksvRZoRiZZo
         y+mHC/nBPAzBJ2mYelJwQZB/c1pC6VEt/BnnEGO6wxv/FaRRIUJNeWNiVi2ZFJsRMc/f
         Ys9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715740165; x=1716344965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIgpUa8KxyLUmcPW5rdHLb8CzpDEUu73pDtvEeNol/o=;
        b=jghdzrGYjuTo9+1KBKEAq5L7djk/VjhZ9L4S28W2gWDDKCBbOboxZADGksHFgAIndC
         iE8KnbPTV7aRtZj5tOYnN/jjd/HoBaj6KbzK6jdXFhpt7lFUk5nLhnvH21/sxau2+HjN
         KHSelSh6+/mJcy24BcwYhtiT3oPgYq57XlZdmsvWFt+IITdtLd6SLAQE3Znvs/zZem0s
         QAKei/lT2qmxDD/MXhJFp/7ODYUm5HItIFcpYGGjqs9khqwho8SQ19cWZ6qH4Ya3CJ4e
         dwrY9NJiVKIldoCaq3tWbO41qb9ELtmjsG5VWvZuqpkwOj4j6zSffDjY+EgXbOvnMQwv
         NX7g==
X-Forwarded-Encrypted: i=1; AJvYcCUbFckf1OzxjP6TFLMg1PZLBtqHvuuRxs/7ufpwJyND++AAG4kRb0lptBza8LdE2w2R6bQVGxRy8e0c+bpaAymYBH3lp0GU302tGjBE
X-Gm-Message-State: AOJu0Yx/Fl2MbPK1HpOPo9JI/m+VjVTOUkgBkYSLA2ekqzRAfE0zJimm
	KAwNBFXLxt/zPnSLfDk90GxA5hk1NCE29A1h3z7ali7xqFbjqAcp
X-Google-Smtp-Source: AGHT+IETFi8DKe3FtKXom1fBYbrA1Dew9V92VfYordZI22nsUhMyQZEwc1CmQQPcxQYcjYoeLbYaLw==
X-Received: by 2002:a17:902:f648:b0:1e4:6cd7:30b3 with SMTP id d9443c01a7336-1ef4318d311mr217684985ad.23.1715740165386;
        Tue, 14 May 2024 19:29:25 -0700 (PDT)
Received: from ?IPV6:2804:431:cfd2:fcb9:629f:d1de:f0d7:c9e8? ([2804:431:cfd2:fcb9:629f:d1de:f0d7:c9e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3e26sm105562555ad.43.2024.05.14.19.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 19:29:25 -0700 (PDT)
Message-ID: <768c3e38-724a-42d7-a51d-16044bc69ed5@gmail.com>
Date: Tue, 14 May 2024 23:29:19 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: meson-efuse: Replacing the use of of_node_put to
 __free
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240416011751.93016-1-marilene.agarcia@gmail.com>
Content-Language: en-US
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
In-Reply-To: <20240416011751.93016-1-marilene.agarcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2024 22:17, MarileneGarcia wrote:
> Use __free for device_node values, and thus drop calls to
> of_node_put.
> 
> The goal is to reduce memory management issues by using this
> scope-based of_node_put() cleanup to simplify function exit
> handling. When using __free a resource is allocated within a
> block, it is automatically freed at the end of the block.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
> ---
>   drivers/nvmem/meson-efuse.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
> index 33678d0af2c2..400a9a075e53 100644
> --- a/drivers/nvmem/meson-efuse.c
> +++ b/drivers/nvmem/meson-efuse.c
> @@ -42,20 +42,19 @@ static int meson_efuse_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct meson_sm_firmware *fw;
> -	struct device_node *sm_np;
>   	struct nvmem_device *nvmem;
>   	struct nvmem_config *econfig;
>   	struct clk *clk;
>   	unsigned int size;
> +	struct device_node *sm_np __free(device_node) =
> +		of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
>   
> -	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
>   	if (!sm_np) {
>   		dev_err(&pdev->dev, "no secure-monitor node\n");
>   		return -ENODEV;
>   	}
>   
>   	fw = meson_sm_get(sm_np);
> -	of_node_put(sm_np);
>   	if (!fw)
>   		return -EPROBE_DEFER;
>   

Hello everyone,
Did you have a chance to look at the patch? Any questions or suggestions 
about it?

Thank you,
Marilene

