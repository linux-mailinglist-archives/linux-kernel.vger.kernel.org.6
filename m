Return-Path: <linux-kernel+bounces-309953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E390967262
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA31C21617
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3E25624;
	Sat, 31 Aug 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YslcUk6Y"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD21CFBE
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118294; cv=none; b=tieF/gWSmzASbsNJE4ViWIQqCPBY9bMCyFMKHiyqBW36tPqlJG4j4488yfJcEvoPR0lLdXcmjPB3Yx6KXzVzXzkHgfHtOfPUDhL7HjlvP4A7zWIImCCVOV5o/MaEkcUHdhecUFOiF2Miwx78lnPqfds75OikTknUcQ1XTPJ0MYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118294; c=relaxed/simple;
	bh=I59zsQ6QDYn2BmE7tLRFbrgQRGFZIRMC4ejMVwM/98g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JLDT6q+N4opba/SS9CW6Q1Ck9yE64QfjiZc/iaHGt0HOSjqfgW0i3n9BIFMnJ46ZPA5mi8e8L+CKGURbJQUWkeBH19fg28w5ZzblePB/isJL9rN6z/gZauAewSKrrJ7iMnWEWG5QrTT+vR1Ckoh7uhV0x2zONxtz8U2+yQldFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YslcUk6Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so23116205e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725118291; x=1725723091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CEOjK3+I6m6XV07ddXyAN85PV8Q65Umk8iIBSqhSAg=;
        b=YslcUk6YIzKvrEvIwxNJvCpiWal+c+dNs9so+6oIcD98DxPcqG7W1NHJMrZYt8/s6R
         dCsNfLNP0/l656J4bZ/+vW+DUeRzuUr7531zXdse+EqY7DyCgkDQLZ61HEz7+Pp2A4Tz
         +BEvE/VUgGe1RCSLlfJ6XayKwGgLOp20KVLqU0+pWAdE2jBsJrohkp1qQ3htI6R8GOGF
         XgBSo7i8Ufvq0a7pUre5D2eJGiwBfLS/4JvAv0+tpcVWVuKccKOTR78JVMQxk9j7P3Qa
         WUozmO+1XuRl4G4UhNixVEAPTM3jA1SHP2dOrPaTEMXGnJVzvwRilWpqISsC2rmxA98w
         Dbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725118291; x=1725723091;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CEOjK3+I6m6XV07ddXyAN85PV8Q65Umk8iIBSqhSAg=;
        b=wlPk8HUwQNIkg/4Wh0eh+mj37DoU2qqi1CWD1OAyEHKKppO4R788lp06YqC4hZvp5L
         mhsd6wEdJEkE8v3FLTgIsDfBsDnPud30byiHoJjPxky94VL4czFuMY0oYXjoal9FdMxO
         ugs9W5VIC2VED/swj28sj13ymR/p/uK0Pl+BDSJw3PD5ELTcjd/ImeBH9sfiAYFHqkti
         RYm5XUEJ5V0/ymOrToYlAuEm+M/hBkiDbWXSmAJakWRcSLZ80FjeyKjjrxxUc5BCqhsG
         6G3T5PdrymCRfuL3ClRYWIrhywPXxX5dmNgZSHJWdOQ7zqsofc7yQtEgrEHRvqK9Q5fv
         Yr8g==
X-Forwarded-Encrypted: i=1; AJvYcCUHeukhW4Y0SybBf3SGfKOXz/Sk+KacM1yCz3JoVdhjrvSgbUDlzXlfa8VsZrPq3QZKT+DgUCktUojIwp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVtQxFCKG+2I2Bl90cNNofM6mQ7t3oR6p2muHsrXlqJXCtJNF
	kS6X5fe+4BYs+VN1QIyqOv9AOFHqwkY27CcrCc5y8LqOqw+nLuKCoKlHyQQdid0=
X-Google-Smtp-Source: AGHT+IEtXhnWcJIqV3twT2kpt1vTDEto7JbVHcOrgywhbCWyeChW/zqbdIf9e/yto9DDK2RIMg4Zug==
X-Received: by 2002:a05:600c:4455:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-42bb0262d4emr74545385e9.20.1725118291319;
        Sat, 31 Aug 2024 08:31:31 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a4dsm78783175e9.12.2024.08.31.08.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 08:31:30 -0700 (PDT)
Message-ID: <85f08de3-4718-43b8-abfc-7bc70dc8700f@tuxon.dev>
Date: Sat, 31 Aug 2024 18:31:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/12] nvmem: microchip-otpc: Add SAM9X60 support
Content-Language: en-US
To: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-5-ada@thorsis.com>
 <6a234b6b-ac4c-4fa8-8809-df56327f7b9c@tuxon.dev>
 <20240828-unworried-borough-b5738c8216f6@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240828-unworried-borough-b5738c8216f6@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,

On 28.08.2024 11:09, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Sat, Aug 24, 2024 at 06:53:53PM +0300 schrieb claudiu beznea:
>>
>>
>> On 21.08.2024 13:59, Alexander Dahl wrote:
>>> Register layout is almost identical to sama7g5 OTPC.
>>
>> Can you please mention some major differences?
> 
> - SAMA7G5 has an additional bit SECURE in the OTPC Header Register
>   (OTPC_HR) not present on SAM9X60.
> - SAMA7G5 has an additional register OTPC Secure Custom Address
>   Register (OTPC_SCAR) not present on SAM9X60.
> - SAMA7G5 has an additional field SECDBG[7:0] in OTPC User Hardware
>   Configuration 0 Register (OTPC_UHC0R) not present on SAM9X60.
> - SAMA7G5 has three additional bits (SCPGDIS, SCLKDIS, SCINVDIS) in
>   the OTPC User Hardware Configuration 1 Register (OTPC_UHC1R) not
>   present on SAM9X60.
> 
> All are currently not used by the driver.
> 
> Is adding this information to the commit message sufficient?

More than enough. If you can do a summary of it would be better, I think.

Thank you,
Claudiu Beznea

> 
> Greets
> Alex
> 
>>
>>>
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>  drivers/nvmem/microchip-otpc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
>>> index bd3383eabdf6..b8ed7412dbca 100644
>>> --- a/drivers/nvmem/microchip-otpc.c
>>> +++ b/drivers/nvmem/microchip-otpc.c
>>> @@ -271,6 +271,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>>>  
>>>  static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {
>>>  	{ .compatible = "microchip,sama7g5-otpc", },
>>> +	{ .compatible = "microchip,sam9x60-otpc", },
>>>  	{ },
>>>  };
>>>  MODULE_DEVICE_TABLE(of, mchp_otpc_ids);

