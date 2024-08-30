Return-Path: <linux-kernel+bounces-309127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D6196667F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA6128662F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963C1B81AB;
	Fri, 30 Aug 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMMjTld4"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988C1B6553;
	Fri, 30 Aug 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034137; cv=none; b=NZlEbfHoFGvmWzKvWmLJdcUVuxiNWDyPr86Uigwvd7S8iYdTvR4v4MsR9uIapA44v7K5+QhjklfdgrJ+jcVtiuNgssjWjLXHh7RGhnER0ob6TG00DxPzW6RFCnqT6vad+FOKjfe5eyxd+CRcQjnkGM1H2shgqOeXZX+rGl7G4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034137; c=relaxed/simple;
	bh=sCSR7DekWhYoyEXdsoaR8lnGPtCDDPAbMVUFxTFA1NI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bnMWDDI9lJuVjtsAkLpSnpgtDZ1Dvx56Ws5Oai7Mheue3p8pcsn7e7yBNFnp6uuWUe2we5KuvpDWIsgFMGM4PfrFdfoqjRT4UJuLW0BRViMA109qj/W+iz2TFPOcObLiixaSTVGi/8zU5Oxp7Bl4NNqsn4poQVur1qrcx2xdgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMMjTld4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7143ae1b560so1179104b3a.1;
        Fri, 30 Aug 2024 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725034135; x=1725638935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pC83zwCCufOmhK1B55Wu64mlHcrImo/cGCyO+/g5l6s=;
        b=PMMjTld4MjRZfqovEFlI6oaKCnrsMqV6vRpr/a8gWA1PKMZHaSW2OvLwmgvowh/R5Z
         fdR/cgXqoliMuKHtzamyPhKrZFtpGFKuipX1RjTTa7ySf/vhQn079kQv/kat+M3keh0A
         hkp8B/KnHaycHycUYpCw79pA8AmyhAGM8+RIws4kDSoaENiHNdoXyxt2tNoMi3E/tFMm
         oEia8JZyg9lK+EDL/NDK1QyLtLkDosRDYKB8F0AEuWOTynae/bFWt3+kBknedWnOlSzw
         KklcWGEKMjJzs/rK9SBFbA/w+fRxHNfFoOxmcyEqJ3o+QmV2MgE0hn3OG01LwAzbTJ4P
         UQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725034135; x=1725638935;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC83zwCCufOmhK1B55Wu64mlHcrImo/cGCyO+/g5l6s=;
        b=QPsE6ui5CsMw1M6N96uGN635viWELswe/m+1POlGhhYLFcaun/+dH3qJZzQ/9WMlJr
         gajYjkcATwAtCG1JKlNKk51Ati5M6HCuegta1bzqfOM7NXnuINgJRPmv3flT6CtG1fXw
         qriDqjtes1Xi6hBe0LSDqVLcWAXTLX39oaPddHmnPklA6pO2wdfHm4qTh5L9Niom0EaS
         SPMKBcmDXD7tv3+JezmFOpgk5Xa6PCGNXhyEpq/NugqAU11QfpPhwlBnSaNSfQ5I+D7J
         XWWUsH7ZacLGeOrWTFFexo0v52iyw/VPTcZe9odivHvwMt6CTpG5RxaiTe2dLDNIstxp
         kvig==
X-Forwarded-Encrypted: i=1; AJvYcCWRtQ8ohOoHiwbesoie5VK2fwCQredF05lruxhTSEBggdzrRl7E8a298DRmq328xo6Ia7v5402bJK66Yg==@vger.kernel.org, AJvYcCXR9xhp0TXdFHK0Zy8slTmRcHNtdvCzz/d11Mu6yvozbAwV468zK9oQWX6fC92H5wKVGOodQ4hdfDmyWh9q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+H+7fuFaVrMXU6PiQxWQzYLFsXhRjiL99ordQphMmIpdj5U5
	S4/1biznrDMiPTWj/MPOlEthjRt0gp3FT9F8ac65WxX3YsEoWgiv
X-Google-Smtp-Source: AGHT+IHYDJEAciZjgbJbvBeCgZlYM2Md6/5R2vTjcFNCFYNvDyxjK1/y7McNhymZfC9S+f9mH1j17g==
X-Received: by 2002:a05:6a21:9185:b0:1c6:a65f:299 with SMTP id adf61e73a8af0-1cece4fcfc2mr84075637.21.1725034134712;
        Fri, 30 Aug 2024 09:08:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a9a44sm2945166b3a.68.2024.08.30.09.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 09:08:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
Date: Fri, 30 Aug 2024 09:08:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
From: Guenter Roeck <linux@roeck-us.net>
To: Wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <935f564b-fa3e-4cdf-bf12-19b897369a07@roeck-us.net>
 <20240822074426.7241-1-wenliang202407@163.com>
 <0a1df032-dfb6-4a26-a27d-14cc301cf12c@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0a1df032-dfb6-4a26-a27d-14cc301cf12c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/24 15:50, Guenter Roeck wrote:
> On 8/22/24 00:44, Wenliang wrote:
>> Thank you for bringing up your questions and suggestions.The SQ52205 is a
>> part number specific to the Asian region, which is why you might not be
>> able to find it through a search. I'll provide you the website
>> (https://us1.silergy.com/zh/productsview/SQ52205FBP).
> 
> That page does not point to the chip datasheet. The almost identical
> page at https://us1.silergy.com/productsview/SQ52205FBP does.

... and that page is no longer available. Given that, if you really need
support for this chip, you might want to consider adding support for
SY24655 and/or SY24657 since public datasheets are available for those
chips. The EIN and ACCUM_CONFIG registers in those chips match the
definitions in your driver submission, so at least at first glance this
should work.

I noticed that there is also SY24656, which appears to be register compatible
to INA226/INA230.

Thanks,
Guenter


