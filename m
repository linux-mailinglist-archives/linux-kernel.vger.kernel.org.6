Return-Path: <linux-kernel+bounces-347600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170498D69F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E957B213BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585091D07AB;
	Wed,  2 Oct 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J93Ei7pT"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12E1D0799;
	Wed,  2 Oct 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876457; cv=none; b=UA/NXdabIzsWvjZNLS4bMXyi3WMezK7cMjXNpEgKz1bmJ3DqcoqFa/0lrRtDpwkhcNiSGCjR9As7Lk8tWBevk0+uiPemWg8EMFGb3F3do5kuymcyn4J64Joqo8OvKVvZodXhdXAaJDpJkSC2DCAhHShGlsJPZLU4imgu+41hPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876457; c=relaxed/simple;
	bh=MGbljW2NottrNSAhSB4a+cfEJzt0Ob4zin9XmuK8H5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhXopo7EFhYptfuaBXkzmDqm4KJ4/HxsvmB9cVa8Gcwp3bDC5VfJu3XGJ9u+EgQZoZGnWnpKx6/U4GKzp18kOpnQgej7n2I+DFkYgZsqMUXBkM1DE9vz0MM3s5uht1r+ljzAaH/lz12pmWKyVRf9zZVt9XXEeLnMZfCILw4FkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J93Ei7pT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so4142641a91.0;
        Wed, 02 Oct 2024 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727876455; x=1728481255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y9oauhirN0KQRPoirRNWuGNmXj1mQSgjpi+qn+VYo2E=;
        b=J93Ei7pT8ETz1khfavYo+mDKn7ESR5vb+rDmcPr7kag6Z+PmUV637s2ImaFz4eXZiS
         rV1DtW7tTV/893Ckan5G/0d/kZ0UFP8fUVKJnRYGt0f3jeHX4eMEKe1+CtaA5FdU4EDk
         88BBDTKyc+LwcKhw62vt/TLygWDIYuHm9fOS3dg0XGXtTNJqybwK3F0U+yz1wXIMkntg
         ffVfmep4fqp+M57FHIXUJqj/gSQ9qWUIs74tykERLpqPKrbjKFgAuEGornthcG9981pf
         wAZSXLGxhcKyy2yxvTjCLkrx/PVcH/BvMGDdgthXsGo3eDBagFpU4H5nVK8Gm48NSygc
         tAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876455; x=1728481255;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9oauhirN0KQRPoirRNWuGNmXj1mQSgjpi+qn+VYo2E=;
        b=Yf2jhZlgYcWulfmTDixHsyL1L8oSapRiaUt+FaYOZcZl1Yl+BkDlEar2C0pNNvsJml
         +lK9URlID8MOlEekMZNSxxZ+tLyxiW5U/N77DSPbVr4rWWGxGvKlMV1EOP4TV7CIung5
         /Zxcc1O5icguuS0IDIyfUZ1Q7gXS+Uzkr99PsnzeUzWG/bCxK8avwycF7wBK2QvwWEyK
         38ZIfhblPOux/cVY0EHaSlBFTb+d3hnph2Qumkj5fRIsMxACLBvfaUjvxrQWBPL7OUJi
         pdg/FWSielB7uD8r9n0x7UeY5IKytlGPx3wbssWsjXGV2jkggZ45VAwRb1nrKJazZA+M
         Kxtg==
X-Forwarded-Encrypted: i=1; AJvYcCULc5VsGJEmHAWiM5ppw0BAQs45QxyOsypGdViWZS1+dDKk96YG4glwCcdV1otax1FfRxe7nVzktU6/UZs=@vger.kernel.org, AJvYcCVqle5Gxr7ko9vETodM7L3mb3yjUoG7fzeI9TDLTeY0H0ZiodowOT/Aec6DSny8vryiiFV5rucORFU=@vger.kernel.org, AJvYcCWfWkX7BkvJm8fWkpxiqanvQX+4zmwcrZoVn54vgfUFBlJMhCnaR8z5jeZgpv6vOyQuRckGeSV7xdRqcMS1@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlUrMpR1S/+Dy1czwtKe14Vzsaa/RYovmJysxRoFCwjR1W4fA
	c3Yq6dbexWDlxBz/NSdN6WEkbEG52acj/UnSjmeCLFqm6HB2hevn
X-Google-Smtp-Source: AGHT+IFPc//pyK3P/UDKGVr57Xqzo08bl/v/UzGj8G6/FKqwi9dDv7QLrI9ovH/BJt1cqGXeDLLJ4g==
X-Received: by 2002:a17:90a:fe06:b0:2e0:ab57:51ec with SMTP id 98e67ed59e1d1-2e184961338mr3883282a91.30.1727876455140;
        Wed, 02 Oct 2024 06:40:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f770b30sm1547645a91.15.2024.10.02.06.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:40:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <97baf22c-b66d-47a8-9f5f-33a348ef5eb9@roeck-us.net>
Date: Wed, 2 Oct 2024 06:40:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Fix typo
To: KK Surendran <kksurendran95@gmail.com>, jdelvare@suse.com
Cc: corbet@lwn.net, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241002105845.172101-1-kksurendran95@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241002105845.172101-1-kksurendran95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 03:58, KK Surendran wrote:
> Fix typo in Documentation/hwmon/max31827.rst -
> "respresents" to "represents"
> 
> Signed-off-by: KK Surendran <kksurendran95@gmail.com>

Subject needs to include the affected subsystem.

Guenter

> ---
>   Documentation/hwmon/max31827.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 9c11a9518..4a7d12934 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -136,7 +136,7 @@ PEC Support
>   
>   When reading a register value, the PEC byte is computed and sent by the chip.
>   
> -PEC on word data transaction respresents a signifcant increase in bandwitdh
> +PEC on word data transaction represents a signifcant increase in bandwitdh
>   usage (+33% for both write and reads) in normal conditions.
>   
>   Since this operation implies there will be an extra delay to each


