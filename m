Return-Path: <linux-kernel+bounces-434563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40F9E6850
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6314B1885620
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC6F1DA0E9;
	Fri,  6 Dec 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWp8B4XH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB51DDC35;
	Fri,  6 Dec 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471861; cv=none; b=gBV+KBFmc2UK8FP1+Bt8j6/6Ij8hSt9hQt6+jrhSqDlRIYpsMSZS1rTKo7rpx2iuGKnPvUMc6YqWm7sH39EcL9l48NVUseCGSwFLUIDtBYVbBlFZwYhumc90iti21Obi75ZQFN2Tm87fOWYjAvDJ4roGfVDyu2Ab9Ljf3t9R/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471861; c=relaxed/simple;
	bh=8OrMea/xIU2cwzPlbMQkP7OcK7sxWVxVmB/AxQnACV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMgzurmFsbVs1coVDJX+sLMkfyipWueOCcEegUy8XGOP8vOigyW6hV8+/AJAzX2iLMLQ/FUj8VPwOFfDHmRGQaY79qEEjAP+a6EgJ0H/zhYnleIbx5g3LZml/ZhsMs+eJhrSVY/IiTaFb+bpsjishBumRePjkYv1+VCwgNKb840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWp8B4XH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7258cf2975fso1561911b3a.0;
        Thu, 05 Dec 2024 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733471859; x=1734076659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7DETPLh5NU5fGD9XXgwxH82PGpe+Abr3cYt0MEQToEo=;
        b=kWp8B4XHcubrOjK8K8r+9b0apiKyQEKEbxPUicoh8X/YkTrqFLDy88ogmR/NApP198
         OFxCdZEQUH/PCzmCot6uxw1JiTtQP9WsE3M3yQ6XS305Y5VC+xikYNT3zKCxexYof1ld
         kJqImIaaUgNSKFeanPAHUZgfn9yf5atzylT6rJVl22vVS391SfCuxkEJdmZEmiQ6ES1o
         97ObHB3IHZqLnwzcYQqdOJpt8Gf2exB4TSwV3ZCHR8inBND9prDGE3cwP08gwsNoBlTl
         fcSjbu4IsvgKE7bXGzPFLHmIkfHApo57iBzuGAAlkqbXXoGY5tpDbBosVCRI1de37OjQ
         4X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733471859; x=1734076659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DETPLh5NU5fGD9XXgwxH82PGpe+Abr3cYt0MEQToEo=;
        b=NNk43ALYdOeTcdvxaY6l/dqmvpzG5UQPWBjnupRDamMSUGjXEH0pzb4pRyWeXtCjyM
         E9NA8tWnmR824fgI+iRp97V70Pz9XostzI1RTL/Rbbaf8Thxqs0aPdPhXekiYg1soZ7n
         3wSyzM7apdSqhGxBVt3Gs8Dm7YxoSifgzY/vlDxnNZgdb7M9BenH0w41trLGGYY4FyyY
         gjmw1UgsFdQFmk3DwFZYCLi0526Rod2GAb7gPgCyQRogrRMpYt6GyzdVeGOH+Pj9fGHP
         hd+b7ECFyXOHxYwlzmZqBQcW2NyQ8Tl4ES2RsrSM9W/jJzkK2VnDEIrpMSr16Xw5Idb5
         J1kA==
X-Forwarded-Encrypted: i=1; AJvYcCV5aMvBzha0L5dK2zRH5m3UjovfqNFZEUNPEtrdJi6bucYyWczbWef3LXw3z5iHXuwFEjzxtAS24KPlNg==@vger.kernel.org, AJvYcCXVPQnUDDKS/sJgEseOM3YN/8q/84M+JWd9wzc+AJxjEzPRsHR+oDYFaoq7LhE23mtjtwmIBcrBxMUIk1iR@vger.kernel.org
X-Gm-Message-State: AOJu0YwaniiJUUcHdN9LtInt4F8ym1oV5FA6QgPWqIjgkPt5EOGdX46Y
	aKqKFw3X38sS+3oIKA9/tEPiEweVPfphuffjwbIwY4FfHgcFatOh
X-Gm-Gg: ASbGncsy4Qp8RHnvFxpIbrZBV4JWerqpp3R+8plbZFsuQxG0O9FKOOZ393DltXBo5gW
	RzOOUsbzxhZe4g9LFM4D5GKxLj0fIjMCQgB5e1T8U8kjubKUbRVUsHxPyhgHhn0epNMcYfqerAI
	3xzRJtrRiMkkI91UGOFdv+7Tdi/I9yAcnbQPrcef1X7g+oBUVhJn/mSrmbJTSd50dGZjNFQTLeX
	pCltGbhHYVck5anON55sftK5+3T2DLmFFnbGGT4ZiUf2wIBTsUJY1QGsyUX0WY+mx5ecLcY328g
	HU2p2mVVCbgn8eNeUQBmMGM=
X-Google-Smtp-Source: AGHT+IF7mviBvc5rZ6kHRodBPhWtyVuJ8NEqADmHP8RTrsYOuZfv0gozUu7KEexDPV2xAvwjjothKA==
X-Received: by 2002:a05:6a00:b46:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-725b81f81a2mr3414793b3a.22.1733471859266;
        Thu, 05 Dec 2024 23:57:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ca9d1sm2478549b3a.23.2024.12.05.23.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 23:57:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57aa83c3-c063-44f7-ba66-c252e3984aa7@roeck-us.net>
Date: Thu, 5 Dec 2024 23:57:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hwmon-next] hwmon: (pmbus/tps25990) Remove unnecessary
 call
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
 jbrunet@baylibre.com, linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org
References: <20241206062839.313292-1-dheeraj.linuxdev@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241206062839.313292-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/5/24 22:28, Dheeraj Reddy Jonnalagadda wrote:
> This commit addresses a structurally dead code issue detected by
> Coverity (CID 1602227). An integer is returned early in one of the
> switch cases causing the later statements to never be called. The
> return statement is removed following convention in the other switch
> cases.
> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>

This has already been fixed.

Thanks,
Guenter

> ---
>   drivers/hwmon/pmbus/tps25990.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/tps25990.c b/drivers/hwmon/pmbus/tps25990.c
> index cc0f5c7cecb0..0d2655e69549 100644
> --- a/drivers/hwmon/pmbus/tps25990.c
> +++ b/drivers/hwmon/pmbus/tps25990.c
> @@ -130,7 +130,6 @@ static int tps25990_read_word_data(struct i2c_client *client,
>   		break;
>   
>   	case PMBUS_VIRT_READ_IIN_MAX:
> -		return TPS25990_READ_IIN_PEAK;
>   		ret = pmbus_read_word_data(client, page, phase,
>   					   TPS25990_READ_IIN_PEAK);
>   		break;


