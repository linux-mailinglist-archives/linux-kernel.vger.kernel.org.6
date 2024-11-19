Return-Path: <linux-kernel+bounces-414474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2409D2899
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C454280F62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3612B93;
	Tue, 19 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao3TtGDl"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF541C2DB2;
	Tue, 19 Nov 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027718; cv=none; b=LSPEkV7R286gAZB0CDZMWw2f7ayfpg723QD4tZVAepr00cn6lE5sPhP1co0uq5s5qMLi9LoXBu2u8ytJQJX7libLuXqJ8j/+VLXcQIGIV7Mn744DBm6x8DkFlQ2bGOi+pM0Q8yNhgC1GWBpTErDWiOX1805DbuudNM1k6W416qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027718; c=relaxed/simple;
	bh=QwXazWoy598N3VgFKCHfM0hYK8XWUSqsa/+EeMwukxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Va33DQ4vc5pLQjoR4jTlRrgYbT1tzi6yPx2uix5Gm1MygXmqMSBYi/6x7ftE271zavaly5HNLY2bLBEVr2jmZzCmjsDjMJHXT47jsQU+9OgbV5IBbEhpX97TufZV1bRapEDz2JKwqts0yMfqtFwid9F6lioPj8imQLCg4p5xTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao3TtGDl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbcd71012so35978395ad.3;
        Tue, 19 Nov 2024 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732027716; x=1732632516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DaMH2QP1l4aE76EMFi2/9XAhs9mTPBcV8Y2KJeK/Ks8=;
        b=Ao3TtGDldlshGu8bsLWvUIlOo+yRnduMhwC9zTaVbMgOX1WB59h7dlzVypVCyGEHvl
         3O5oYncY4Xvc1iIlHgMNKDer3sksfngstJHXHa63vGH7bPAxS+7OXZkHnpEIpJMKAEnl
         oAAa6TAnj1l7TfKErhSBYanJ0V3kJqTHXhzV1VlpKACnObCcJMAYW3zMmWW9yVcgYkYz
         0Xhsw30h5ROi6w2KnEtckBee4vtJU7yRZZvshGfBfsWnmBgzin/ZbSYC7iUAggHI31wn
         ctAr2+/iIUVw6gALTtdVx1udpFbJ1KUY20buuDli5T/emB8qs298fw165Nemey/k/24y
         laAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732027716; x=1732632516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaMH2QP1l4aE76EMFi2/9XAhs9mTPBcV8Y2KJeK/Ks8=;
        b=f+FOEbF09f60q08uX7KrDuL1btDS5obxHLVTjG0dv6HxS9CnyV0h85qi4q932XGO7v
         Wcmc2/Myg87Qb4TVHAJ+EfWXEBG0x/wG/lOuwgbSK+afU32oSCpAyfuEHtATQ8ThLmPW
         O60adKkoeH3Ic4Os10TxDWouCqOJ16a3c+u/nP5cGN0mQaMYFQ5Plku0W8fmdkQGEEH9
         9ol3LZjRAsT/eurr0NOAfBaiJtaRkdbpfXWy5UBvLwDrGUgIe3Wjd49YPaAX/QUObGDY
         rV+uqNM3GVALiJj+ycbxk9dj4Pc2uEsBGUr4i8WSW96n8omj/JbMGGhMXYb5hT8k864A
         EpgA==
X-Forwarded-Encrypted: i=1; AJvYcCUAetQ8fmSqW2P6ymflC3nMi6kXK8C9KZDmDTIxTK59xZN6TIRKj0V51ElOAe9WG2jhVh61gf87u72u@vger.kernel.org, AJvYcCWF3JvCISolEY3j7GwRW8LMnBHULO1ARhEUrnWqzMN7MNKDO7ZpfLWIdPmjAgkEq+hMkIBJKjvGh5f165vF@vger.kernel.org, AJvYcCWZlynApk32oNRWYI019w+yiPUHWWDqo50f5Gk9sx3MrHttM4RqvLQYCL9p8zxFtm4kfhbMp8o9ZMtzz3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1j+UaoqfByxa7QuLzg1ufNS6gsQ71Gxbn1EM77CAxHudx1n5
	0Z7mL+CokCjfLnLEBYYisDrkOH/7nqDrxVD7jIanQOrVtnYysAv2
X-Google-Smtp-Source: AGHT+IF+WyabdPwFDmryetYzkUSnDDB5CNGZqmS8ChYI0ehtLBd6JmjIELBZ9myTtNIxiiXCTsuIoQ==
X-Received: by 2002:a17:903:189:b0:20c:968e:4dcd with SMTP id d9443c01a7336-211d0d6f249mr170849345ad.7.1732027715530;
        Tue, 19 Nov 2024 06:48:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2125bec05acsm9834175ad.32.2024.11.19.06.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 06:48:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4856f639-5b44-47cc-a257-47a30ad3fb5c@roeck-us.net>
Date: Tue, 19 Nov 2024 06:48:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: (sht3x) add devicetree support
To: JuenKit Yip <hunterteaegg@126.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jdelvare@suse.com, peteryin.openbmc@gmail.com,
 noahwang.wang@outlook.com, festevam@gmail.com, marex@denx.de,
 lukas@wunner.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20241119140725.75297-1-hunterteaegg@126.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241119140725.75297-1-hunterteaegg@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 06:07, JuenKit Yip wrote:
> add "compatible" property for supporting devicetree
> 
> Signed-off-by: JuenKit Yip <hunterteaegg@126.com>
> ---
>   drivers/hwmon/sht3x.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 650b0bcc2359..2ac1537b3e3e 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -954,6 +954,19 @@ static int sht3x_probe(struct i2c_client *client)
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>   
> +/* devicetree ID table */
> +static const struct of_device_id sht3x_of_match[] = {
> +	{ .compatible = "sensirion,sht30", .data = (void *)sht3x },
> +	{ .compatible = "sensirion,sht31", .data = (void *)sht3x },
> +	{ .compatible = "sensirion,sht35", .data = (void *)sht3x },
> +	{ .compatible = "sensirion,sts30", .data = (void *)sts3x },
> +	{ .compatible = "sensirion,sts31", .data = (void *)sts3x },
> +	{ .compatible = "sensirion,sts35", .data = (void *)sts3x },

This either needs to be "sensirion,sht3x" and "sensirion,sts3x",
and the matching entries need to be documented in the bindings document,
or each individual entry needs to be listed in the bindings document.
Also, this patch should be patch 2/2, and it needs to pass checkpatch
without warning.

> +	{},

Unnecessary ",".

Guenter


