Return-Path: <linux-kernel+bounces-575364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF85A70183
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EB219A1235
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781E2627F9;
	Tue, 25 Mar 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqVurBCK"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA718BC3B;
	Tue, 25 Mar 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906806; cv=none; b=kjFjvS91zF9hGWf0JhC/XtjrQN2Pm339LxBkfgKeOpNTlfH4S68WzPPUZYbEsDg2rCiBRC6vBB2EFQG+Nx84sVRAeJkh26mVvM7GV6a0CETiMH9DSdjhJCWRrqKNHwJUiutep5/Zq4xDwMWmX53dsoidR0F8/RxSGwfx1vJthFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906806; c=relaxed/simple;
	bh=kNEU5Ty6m4T1RSoMTaERB61oyU0WcjBnDwB9tcH+z2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PQ91uFYzGyBnhhxhbZaoH5o0Qpd2GZ3v6ZScEEeazjD8kljlJVBbFhoX3+kqA1DrFIG3bEZreEEvDxZzXNTHbYEBnTNAZADBS7EPc1Pf3bOUNm6Hrt/rLemIoIrn2wk2Ev8RpyS/pEVMZr1U68t6SYEzvEH0269UvF1CHxgTIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqVurBCK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22409077c06so115714665ad.1;
        Tue, 25 Mar 2025 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742906804; x=1743511604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aInV8hQRf6vE66+NMLSQP/qvF3TWUTWoboKCTyFkzPM=;
        b=cqVurBCK0x7Q+k1pnRBoUjkWGH5OecP+EM+qk6SH0Jf1hjhyZy5VMJP8Z6R1Waac+G
         m7rvojm0tpdAi2Szxmp53gvEqqhUjUNnmXoYPjBT2G2UkN7c+FT1myjBXxFHaZKeVii8
         JhKlZIvvMoas6NmvYDPb/TesAJjF2XHfVamQg882j6TmioMvTBdCzNRE1mQfL9DjDTMI
         eSKwSUz28/setAJmW7KQmuicLfC2CvHCDFQ35et6G88+sGUZaiL3l4KwJqBeUK/nHNjc
         S6Rp6gLfPoyBPhkfChVhh49men70o8zGfISTgbEkWDO9rDalMzmUIKZO6doCaKZIE6me
         L4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742906804; x=1743511604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aInV8hQRf6vE66+NMLSQP/qvF3TWUTWoboKCTyFkzPM=;
        b=DftW359UB/Ip/LLPc1EhKsmfOUJ4k+kLF8LEO2qTPSr5QTq565LHlslq433da3WKDr
         A3TQXYb/SX0NLCTJhIp94QU25UKiOPkLeF9yzHWLf6yOTpfRtk4jRoLVyZqdxM+fRp0N
         KZ8fUzLD9nMp0MLbGSgwyU3NOH1igIiJq5nsUetnqgyPe4oaXA0iyuY6hOszRcdF4P7d
         ToTFS68qqrKCmYjJVCsYAJP4a+CsWf7GbMCnv+IeyLqRPKeSpmpVp+4uFHd3UVT5xHIe
         RUGoIqFxz89TvO3g6xtSEUB4ubGGL26MT3nOkA6+LIRF/wDEyFFZuhrViDQGCv6GallQ
         e7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUV1HI/pZAJOrN7PeyqqTXDG1Nc0a7oHTtMY/XKw3/ry9w2gy7VAmch3Iq858LW4K+xwTgIgtnIUPnDwIfC@vger.kernel.org, AJvYcCX4KKCHZ7ldf4SDC95jOynlkbSq7hEf5vgYa2xSem5hY349yBXde7IfKeeE/nTsA+1Z6awpKSi1rF/nLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62iOnAL0oQ1jHGPCDUqdCWkUvxfoV7Rx2Yi4lCuRLq92/2yWP
	oJT54/cOR/PEmyr9QJE+OsUOyqrV/ClIlE86wiQmQOf2MhEvipbgy1BunQ==
X-Gm-Gg: ASbGncuu2BYbGZJMkIb5ehJkRc7JUwVwsufkVlYsXDXWsTThC76/ZHrrCnXPfWTGJBe
	Jhb/KPstJOdg6ubwhV7ZQWF8px209AqXJtnKS/66JXQq18lE1VhnG99E18Hap4BzLq749fLOJgw
	VZkVJ0RxaMO6Radc6POEME19shBIU5g5lGjj/dVDB9piSlKba/uvjXwr9i7pb9edIaNimdldLl+
	8PheeUbx9QFSXy4yUyYxqO3/jvoBl0PcNIVV5vdQ9FWi+TF6zYevfwAIoVJPQiP3GcWBgLVAXdK
	3R+vmdMwcDzZ/erTzZMgV9aVv0thQbjP6apqTFcL6yGxU1sa27KYGRjv7vQN2KUNdGfW4s1L15Y
	81cKylXfCWpjBxX9ysw==
X-Google-Smtp-Source: AGHT+IHubCkNkdQqRNq5surmbfP8w4wYu7OFK+dLjG2tjH+9mevggwzoNXlK5cwjzNF04EQLZhkBkw==
X-Received: by 2002:a17:903:178b:b0:21f:6bda:e492 with SMTP id d9443c01a7336-22780e09daamr305388055ad.35.1742906803769;
        Tue, 25 Mar 2025 05:46:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45f35sm89273125ad.90.2025.03.25.05.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:46:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <78352732-6494-4c29-a79b-879a8898bac5@roeck-us.net>
Date: Tue, 25 Mar 2025 05:46:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add support for CCD temperatures in AMD 1Ah CPUs model
 0x40..0x4f
To: David Hows <david@hows.id.au>, Clemens Ladisch <clemens@ladisch.de>,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z-KQHKm0nBWvYNI1@archibald.hows.id.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z-KQHKm0nBWvYNI1@archibald.hows.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/25/25 04:14, David Hows wrote:
> ---

The subject should start with "hwmon: (k10temp)". Also, it should really say
something like "Add support for Zen5 Ryzen Desktop" or similar to better
describe what it actually does.

Every patch needs a description. Please see
Documentation/process/submitting-patches.rst for guidance.

Thanks,
Guenter

>   drivers/hwmon/k10temp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index d0b4cc9a5011..cc2ad7a324f9 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -502,6 +502,13 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   			k10temp_get_ccd_support(data, 12);
>   			break;
>   		}
> +	} else if (boot_cpu_data.x86 == 0x1a) {
> +		switch (boot_cpu_data.x86_model) {
> +		case 0x40 ... 0x4f:	/* Zen5 Ryzen Desktop*/
> +			data->ccd_offset = 0x308;
> +			k10temp_get_ccd_support(data, 8);
> +			break;
> +		}
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(tctl_offset_table); i++) {


