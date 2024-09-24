Return-Path: <linux-kernel+bounces-336565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A279983C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A34283D18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00445005;
	Tue, 24 Sep 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUV58L8D"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A2BE65;
	Tue, 24 Sep 2024 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156366; cv=none; b=dPBcUkfdK0eHhqq6RTB0EhLzrYalQSVhuH3kWf8Xx1Yymu6LFrKVOvd2VLlyD+cM3ItmkeObOLrmwixvWoOXZC9Hr6hdWpkaJFta2Wpjr5Lvw5ush2Ve+HtZh0bSROCke/tbqYrmLQN9KHTH1/Zavdj/xWoMvPEh2q+IDrOly7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156366; c=relaxed/simple;
	bh=HmFNeeOOL3EaZEd7ff0cFgchD1mUgCV+76wQ5iHNdYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to6/IE5TWVF3d0RtqR+AIKlIgoDG8PCQjhbik2lpC7CU+QHJEetNkAXsCJ0PZGdEOZwvEAwIuhP6oCkKAPt7x4y5eaQiRAN+W5RVdshcVte92fox7V2sxqsFLPxCDaUYoT4XKZX9K3KX1iHpWdKrPCT0S1Kb/lUCvJQ7jZQW4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUV58L8D; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so4085584a91.1;
        Mon, 23 Sep 2024 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727156364; x=1727761164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7qBFDR+1NB8qSnRI7FLCbTljhTD0DeN+GeIzr5GI2VE=;
        b=JUV58L8DcfB3cw1gs796FQZHRBPC/GN8sk9q9lKfrTCPIvlX159jGOrO2oXoxxeHWL
         kB8E+OCuv8/MhfLASxJ5uo0WSwl2x68XPeoP23lthWhaz9MGoLgxNj16SXOIz9Yp8C8v
         7+CQXnbMiEAfElJ5IPtjWjjLsJBITrc+jx2cS8v8xuZSr2ysCo4EkGx+Z2XqGBm1FadW
         +1SYmZnzPHGQuPQlRb6x5U+B2sa1NsivloasEWpCrgHyesadSwX54XnTrkgTxTjZvDGp
         kSACoT1sIjkHAbonfd0147OS1q0E3a4mwn62v9Se2507EmPh6ztQE6xXL5v7G8c4i6rV
         lhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156364; x=1727761164;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qBFDR+1NB8qSnRI7FLCbTljhTD0DeN+GeIzr5GI2VE=;
        b=vDp576kfdEjLr33513tl/WRuKvz/04zGfCBj1rq5iQ77AjOQEBngAwB7e+ZDLptCkJ
         TZK3QPmrUbSZCbAzJgmo50idwgWG/9DVUHZzkOmVbb3imsYKcuIyHQYhBKKlOhkpMLdU
         k7VVO1D1rpipCyplGmQKb8pzMXLf71KQCzGxX5gT2Hi9mCUTiNTXQUD21EHGsMzjeUA8
         IGPmI2My2+cgoXrhbgN4O0gp7tPjVQsSttx/Dulv2Z96jtZyQND1v4yBiB9oJr7Jv8q6
         Nn3mdeXD0umRF+b7ALcLZ4D1gDccAviHavqIJFD9+Tr6r3YVW5f2PirBcvmTnrNj5Ykv
         XrXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3n3edZ27/e0+w7LryJX0oh9C5ttIlEG92T5VQ04LblhnNZ5VKzOGb+1xadN6dj8Z0mgbmMTC9XKQ@vger.kernel.org, AJvYcCXz19q1AvoKeWvhq1UkXCjiYlVqIinba5fwplQsfCFgMl5y7GBtHgoELQ0cP9A1NJLB8L7HJbfuyz4W2U8K@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2EARfKiOFtGWJIABDS0yvHYWu51K9h/OtQm4iER9rdd4l2Ld
	NCjGFQYbXy3dGWmbfUNlsO4yeBOkVKmds9PlhBEO2V6W/GZhlCu+
X-Google-Smtp-Source: AGHT+IEmSkS54OhSLgjWXY7AiCKgAKzGqFAOf0nqG61wL/jWo5txwSti1TvxgRPBUWbQVSTSUnTb8Q==
X-Received: by 2002:a17:90a:e601:b0:2cf:def1:d1eb with SMTP id 98e67ed59e1d1-2dd80c02ae6mr17238479a91.8.1727156364059;
        Mon, 23 Sep 2024 22:39:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e05900709bsm578599a91.37.2024.09.23.22.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 22:39:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56b7aec6-bf8c-4547-bec2-e0df25489f77@roeck-us.net>
Date: Mon, 23 Sep 2024 22:39:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: add onnn,adt7462
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Conor Dooley <conor@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Yin <peteryin.openbmc@gmail.com>,
 Noah Wang <noahwang.wang@outlook.com>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 Khanh Pham <khpham@amperecomputing.com>,
 Open Source Submission <patches@amperecomputing.com>
References: <20240923093800.892949-1-chanh@os.amperecomputing.com>
 <20240923-private-grower-af6a7c1fca09@spud>
 <c536f43a-56f8-4cbf-99a0-fe3b54a42886@amperemail.onmicrosoft.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c536f43a-56f8-4cbf-99a0-fe3b54a42886@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 21:17, Chanh Nguyen wrote:
> On 24/09/2024 04:23, Conor Dooley wrote:
>> On Mon, Sep 23, 2024 at 09:38:00AM +0000, Chanh Nguyen wrote:
>>> The adt7462 supports monitoring and controlling up to
>>> four PWM Fan drive outputs and eight TACH inputs measures.
>>> The adt7462 supports reading a single on chip temperature
>>> sensor and three remote temperature sensors. There are up
>>> to 13 voltage monitoring inputs.
>>>
>>> Add device tree bindings for the adt7462 device.
>>>
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>> ---
>>> Change in v2:
>>>     - Add onnn,adt7462 to the list of trivial devices       [Guenter]
>>
>> Is this really a trivial device? If it monitors and controls fans, how
>> come those do not need to be represented in the devicetree? How is it
>> possible to tell the difference between monitoring 1 and 4 fans without
>> the extra detail?
>>
> 
> Hi Conor, Thank you for your comments!
> 
> The chip is old. The driver was added back in 2008.
> 
> Really, this is such an old chip that it would make more sense to just leave its driver alone unless there is a problem with it; this is viewpoint from Guenter.
> 
> I'm using the driver and the device tree with only the "compatible" and "reg" properties; now it's being good for me without any extra detail.
> 
> Guenter, Rob, Krzysztof, and I discussed making the decision to add this device to the list of trivial devices. You can get more information at thread https://lore.kernel.org/lkml/20240918220553.GA2216504-robh@kernel.org/T/ (Because the commit title changed between v1 and v2, it's so hard for everyone to find it. Sorry! I missed mentioning the link to pacth v1).
> 
> Guenter, who supported the driver development before, he suggested me add this device to the list of trivial devices.
> 

Historically it was ok to add an entry into trivial devices and extending
it later if/when needed. That was still widely done at least until very
recently. Maybe that changed recently. If so, sorry for bringing up the idea.
I did not envision that this might be a problem.

Can you live with no devicetree entry at all for the chip ? That is of
course less than perfect, but it seems better than trying to design a
devicetree description for the chip only to never implement it.

Thanks,
Guenter


