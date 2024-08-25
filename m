Return-Path: <linux-kernel+bounces-300343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C195E29D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48358281E08
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA96BFB0;
	Sun, 25 Aug 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBJAlGQy"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B62837B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573607; cv=none; b=mCmAgmntw+LgsnGcxc+Kcz3v2mj3J1VDf4w4ZhR0IUKvS+ZNxovFC+KbXUXtpVwgQaE74v3uM52HMCmhwmWpm9co1ialV///iGNsf38iIf2J+QMEZiIqxPkKK8lNZJApY1yhUq8jx4r/22U+T+i6+kYekCuiy5UeMAErG41CD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573607; c=relaxed/simple;
	bh=SHBNGs6nn3QGwEz2EkHLl6q3ZvdoDOGioeL3/3TxkKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDzpAvHdJQoYj0zjVkCYe5Fm0wf4GJQguzzye/ur6JSHlttHma3TrPAKNbeabeizMwMqDGUzKEMRCFJBJ+8UpqDrGj7n35Xyeeh54lLvuihmSmVXrqInv5AKYtBkEhNdfdp5h6cqF8c+sI4Wls8wBV8vkiA0wfCCketOrar7f1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBJAlGQy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3718ea278a8so474085f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724573604; x=1725178404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ITK0HFbFHliZoF59JxFYdp4nn3GH328FIrQJYLnEIkg=;
        b=eBJAlGQyQRpjW79intIHN8SEg9ctc1gI0lkUbuoroLz6RFayeRxMZ5EjgcdPxF7NRv
         Z55Vi7ShSVDQ4FB8RKJfULVnH8mdqd6AlWEXkBj4GOwLvZC04FVxKp/Is/NE11Icg63j
         JCi2K087CGkudtd+qQv9joIAK+gE0LZTfL4krjY8G10EBqKhwiPd58tB4rkkgtAUOMUY
         /X132IzWp0oHTI6yW+xQlCf7Se5Xdmpqf0T+dVC2T+sTgG9tII5T+p1s5iitfY7jORjy
         XkY1VTvk3nEBpvEhi8/wI+5dQWHJoB90xCse6BFSBPJmICPd+/TR0tdAtfszncvLFBXk
         kydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724573604; x=1725178404;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITK0HFbFHliZoF59JxFYdp4nn3GH328FIrQJYLnEIkg=;
        b=mka+hC3wMyiUKxkEpvyqGW8aCah8hm+9dycS6sYf/MEqmTnqDNRsfCX9onzpdld3b+
         smMhQTzlYE9UJzrWNce/F+d3oQ2doRRk4aIE1oq1GxQV6dKMlQZ0FhiKkXB0F+qbtwSj
         9vRnL+UOYJEAvr+b22x62Cw9rF9njWiQlklmO7zTFhYFERZUNCTiFguMxIQapEac+W6k
         facaMSUtav5MqZQKeDZ5jab3maDyoizSoBrXFkig643hU7lAj3NAipqfN5Efsc6+xCbE
         QaiDzRjFstxNPG1ds1tRLxF/qeeRioQP0iogkWNI7zNR2Ltdr7DYvXGSFdTqtEdF4TQD
         BP4A==
X-Forwarded-Encrypted: i=1; AJvYcCUaPnDROL3EfZJAGXoxZe11sTWFTjPt2CwbBinhpcchjJXBaMuv6Ob50lObBaYo8ZbZoivOI6pD0VPhxjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RoXFDOZSqN6+cinah4NnXmdxXenkupx7IPb90EhppGMYv4BQ
	vPXscy8c6gYIAfAcUHGqDvC9/z5WpyUrZaMaHecIfWulxaZQfRep89GDdKOO9vU=
X-Google-Smtp-Source: AGHT+IE0rQ5gTDmF+PEUeAD4bdCX006kmQFqfDBA+PnlIbWdSgw9D/zdbLOgGaAFAvA6Oc7ya8RphA==
X-Received: by 2002:a05:6000:1842:b0:36b:3394:f06f with SMTP id ffacd0b85a97d-37311900b7fmr2761757f8f.5.1724573604276;
        Sun, 25 Aug 2024 01:13:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5c4sm8147679f8f.78.2024.08.25.01.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 01:13:23 -0700 (PDT)
Message-ID: <bad910c9-debb-421b-ba2c-5b214e39159f@linaro.org>
Date: Sun, 25 Aug 2024 10:13:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] memory: pl353-smc: simplify with
 devm_clk_get_enabled()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240823-b4-cleanup-h-guard-v1-0-01668915bd55@linaro.org>
 <20240823-b4-cleanup-h-guard-v1-7-01668915bd55@linaro.org>
 <20240823125637.00007fe4@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240823125637.00007fe4@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2024 13:56, Jonathan Cameron wrote:
> With change below this becomes unconditional as we'll have already
> returned in the loop for the good path.
> 
> Might as well use dev_err_probe() here as well to save a few lines.
> 
>> -		err = -ENODEV;
>>  		dev_err(&adev->dev, "no matching children\n");
>> -		goto disable_mem_clk;
>> +		return -ENODEV;
>>  	}
>>  
>>  	of_platform_device_create(child, NULL, &adev->dev);
>>  	of_node_put(child);
> 
> An additional cleanup looks sensible here.
> 
> Push this last bit into the loop and use 
> 
> for_each_available_child_of_node_scoped()
> 
> Assuming you don't already have a patch doing that :)

Yes, this could be simplified, thanks for the hint.

Best regards,
Krzysztof


