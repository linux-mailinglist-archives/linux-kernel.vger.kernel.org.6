Return-Path: <linux-kernel+bounces-289007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48A954133
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD35DB21C57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFC80C0C;
	Fri, 16 Aug 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAH7o54G"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394510E6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786267; cv=none; b=R6c7BmDX8DmWtBzN1MVQ99l0ng8vaKPeCs6bF8U7jTQZwaX3FGjtsZNal4pudoy1iV6cfR/LVY6Gfz1ws7w6L5tijl/Dqd85ZTLEWNbH1ld1iiGBY9HWqklk3Y2+qec2Do/9EptObVsVUp8Isf9edD2v4YyN/g6ZpryWUJkyN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786267; c=relaxed/simple;
	bh=6GUkHZwBNnR51Aii126JvWC28qwhtfh2JU+gilgUB5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgJimkyGdvItbNtDwK/7J8h7DaMccAY7AMxIcNCWnZZoIE3Ov2KNMqs+96FsHK6pnzCo9TepmOFc14rYK+Lht4CG2kTp/hiSKC4GbJkPUCBXteX9eQI388Ah5eHvf6A1X5FSf2+FIMvTCH/OmuxSOJHxg36QgmMZJrbw8VICU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NAH7o54G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428141be2ddso10640685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723786263; x=1724391063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BtfQbihcuyfTpJUU46dQhkdodQ8lCIP3FOIcF+lOVfo=;
        b=NAH7o54G1hHlWdOYE+J3OCmXbof35XqUUH28zNH3sqLPzVdKzWRoyoHEHI0B3Es0P6
         E62r/1rNl8ANu2pGBNZMiY4CryJHHlaqZ1TLx7rkS3pbbwWBzuMxh19ctdFzOaz2xpCC
         H62HkoMKVAAwqQppHP/vmcoZlES4v+rImZanFjUG2OK7wofoDvGnBkS17AUvPwki1NAA
         7rMVasymaakyIzQl5zTWO7rWCoZQzgWlCRXK3RJq69fhOq6elRloEuVwv9pOxEXy+nIx
         bFDSfXzkmOFKb86QumC6pTXSaILFyzjdBaMWQ9BerdN4Sns3KfeTM/TihBiFuoAp/8UH
         HyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786263; x=1724391063;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtfQbihcuyfTpJUU46dQhkdodQ8lCIP3FOIcF+lOVfo=;
        b=BGLD7lxgQubaJM0MsmkeC7fGQp0ngvAc8FOPTb9oD1SW8TDHS03E8K9QWuIzW0zHOd
         7YgzbZlHsUT54Bqak6dxl4wUDy6T0IzFsGuNRIIcP0fxc3MXeEmzfn4FbB6+Jm0e8mYw
         738SkpNMiYJ/1ncjvj50yQPViLUT9aw0Japj63usSSBghZe4o2dgi/w5YUVtJj/uFD/o
         l5mo0h+p50v8TJD5tjzsO5FrJAwkjl40hx8Jbao66HTy8oqTnVBsisDwX5/SHwIctsGO
         rSW6H5WfhmI0H8OhMcXCDETGQX8DZEMkULU5QeFvfv+ZNbff4VPZy6iKQhjVxmV7rBN6
         x8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWC6WNIpCgrWilQOOIocLjClObKzecQscuPXgokLdb2rE53niDL6f26aLgUH53rChPpZb+dEbYIfaF5vI5m6ZIOaGtL7szAfz4ebEJO
X-Gm-Message-State: AOJu0YxZHw56on+z4LPJ1iWAVgOxECg90bwKYs62KDz5qys+TkGMjhmF
	qUnPltWmTRRFJgbYkWuaG8LtbCEZzhDlvyV8qwnBezhXcPPAcuL9yBEJq2tSwJY=
X-Google-Smtp-Source: AGHT+IHOyL9i3883tv51RFn0qGmMTh04idmMgAsCgawmFxjuKNVivdf9iIbsSyRVGb0dpwtJI52+Zg==
X-Received: by 2002:a05:600c:6003:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-429ed79e6d1mr9451395e9.14.1723786262283;
        Thu, 15 Aug 2024 22:31:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19839sm68496905e9.6.2024.08.15.22.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 22:31:01 -0700 (PDT)
Message-ID: <d72c9acd-dbcd-4c78-94d2-c0a0e854c5fa@linaro.org>
Date: Fri, 16 Aug 2024 07:30:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: dwc3: xilinx: add missing depopulate in probe
 error path
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, Vignesh R <vigneshr@ti.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240814101848.67501-1-krzysztof.kozlowski@linaro.org>
 <20240814101848.67501-2-krzysztof.kozlowski@linaro.org>
 <20240814233122.i7anp7a3p5xnl5tt@synopsys.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240814233122.i7anp7a3p5xnl5tt@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2024 01:31, Thinh Nguyen wrote:
> On Wed, Aug 14, 2024, Krzysztof Kozlowski wrote:
>> Depopulate device in probe error paths to fix leak of children
>> resources.
>>
>> Fixes: 53b5ff83d893 ("usb: dwc3: xilinx: improve error handling for PM APIs")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/usb/dwc3/dwc3-xilinx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
>> index bb4d894c16e9..b7613a106da6 100644
>> --- a/drivers/usb/dwc3/dwc3-xilinx.c
>> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
>> @@ -330,6 +330,7 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
>>  	return pm_runtime_resume_and_get(dev);
> 
> If pm_runtime_resume_and_get() fails, then probe will fail. We should
> probably cleanup in that case too.

I will take a look.

Best regards,
Krzysztof


