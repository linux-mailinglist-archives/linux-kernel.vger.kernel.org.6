Return-Path: <linux-kernel+bounces-558967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CEA5EDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3032189E20A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3891E493;
	Thu, 13 Mar 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m0BaHy0M"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1551D25FA13
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853714; cv=none; b=I8qDsgphOHtT/9IUAkKR5Yff5eNFqnMIQXka6xX9kRqDuwmmd6Su4rp5oed5HXqX+4e1Ms6IF7siovbrbdQkEDEVGG5XYgAcHmLC1lzr/WFaMd4FerSAejt7WbnPTBLDfNamGiNeGPReDtPqJ9ZMSbugQd6PulfJf+mpd9GkluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853714; c=relaxed/simple;
	bh=Yc19Zr46Q9hoNsGqw5wHAAmH//beAVYed1TFdUX6soc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX5z5m+g3tW9RiVUiTkbE1Z1vZpaAiKWCZXlbYDXPSGbuTxqC36cvgP82+bkxTn6lmfBBKfpb1dlTKbMmh6kjFJvjfogun7wFM8GpuRM9lwf4wFhMnZAC9bPSTQkGCfsZMQONoRBCOaTMaMUJbMdXZvXtpUFXa+kHlGwqdN9w74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=m0BaHy0M; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d4502ca096so1609135ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741853711; x=1742458511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zp8y94UhZUEACB7TqzzlRpM4uzvhufLGfU6PVFDtss=;
        b=m0BaHy0Mo9CRlnDo7onzOJRWazZqMxVSORIL5UYN+hVw4czImvi6C5jFMOEN5SsnL+
         kqptCFUkdW5mnHIWPt6yj6sKKmDrWeBsp5PpvHt/cTB4ycr2Y3OexYVgOMRTu6dOYOI9
         u9ukLPHRCtYO5MMPI4toM0PuK8kUbbV2Gg4gFpMWOkG4ouhJU1Wd6g+kIhMS1GGy3lwy
         V6LfrQAXdW/52lXrsPb8/mVMk8yJmhODqhhOlKcPbjEHfbgilMHIlkF5dUZ3qOEVqeYa
         hmhmNSIuiEQje2SK89mHjnjFBnB90i3wo6msTeujav0OlMDjnlltJu5YGjjp5N39CYOy
         bMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853711; x=1742458511;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zp8y94UhZUEACB7TqzzlRpM4uzvhufLGfU6PVFDtss=;
        b=BUwS1yYsCbNVLZqcMYhDFjEFI/DXYcqhxhx4kv82yoMUZl80tenL3ytZ7wdu92uAsG
         9wg1Z5F7xv2pDu7iE/y1pxxfynD6Gq0wF8sZOvtOG91Kr4O6GyH83/BV6KVXcbaxh70c
         FGRDCsznk6jIpwz2Zu7JmLby437I9YVpV1TnZG0HjhnBq724wmyFCrkE+xbhPzLp5ml9
         oz2p2XaSxdiDnKGdgSUOcRfkKuoVmBqS/J75NpR9Pf0i4eiSxnjxArIH1kM8Hc8xSJbI
         s3YGFsZdodz0SwN1zCHDZqZ7m0cUSuEukcdD5s6yBzqAarEFhf0BLXHZh6nN3dT7hOwQ
         RzVA==
X-Forwarded-Encrypted: i=1; AJvYcCWKaOBP8NaTfBdtDpWaLn+tComvskM2czIFmZwGFzTdz4hDEiC1h8aYy84+3n0XsOe3u0SB2R828DerhFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBr9zYzN4sAUx+QZN2m6IeOwQWyITvyRX5OHTR+L0DYxVeEidc
	6HKoXIdbWJ4KspGZgRYwaXqWe2ods6u5b3p/oN6uHE2B+10ztM6VLGg2irXf3wM=
X-Gm-Gg: ASbGncu6NBOTo20UtQWSihigh4kV+msyUfp63RjUnfkPbWEFblT0pzsba5Ysjv8Je5M
	h6yV9jfVqfRZ2FvgyZ/cx7LZ6AkxTjJvQFYHfvnOZB0lcKFM8k7rN8bKjKtKp/lPZRX8TPSDZKL
	BgnU3ooC0N6+Z2fz4krhYDntaurUz6UGRlwEvWzV6alA7eh2/UpSIaMZdZHWrlC+bygFvdZ3TPT
	AXfVr0G8wlqE4S9qEkGN0Q6wSnpf5cv5m3duKCJB56bf9TdpWLs4vG1cPlV+/zUohS9JvukLYcW
	OOcmEtCOA8+zZF2SHFvSqbjg88nXfWtTHmH2PCYcXDNLhvhIJo5YOqoM+qZigQpUI6fkDPrh
X-Google-Smtp-Source: AGHT+IEZzp8PPH96NPX1KFV4JopgGuWHkLcCnrS6Ve2nlvM2ZsgakuGkYSRd4eUdHSshmqdOMBXrfg==
X-Received: by 2002:a92:b710:0:b0:3d4:6ff4:260a with SMTP id e9e14a558f8ab-3d46ff428d9mr65574915ab.2.1741853710972;
        Thu, 13 Mar 2025 01:15:10 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6475cfsm2559245ab.13.2025.03.13.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:15:10 -0700 (PDT)
Message-ID: <2b240ccb-e18b-49f1-ba15-7c7c6c647bcc@sifive.com>
Date: Thu, 13 Mar 2025 03:15:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] dt-bindings: riscv: Add SiFive HiFive Premier P550
 board
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Min Lin <linmin@eswincomputing.com>,
 Pritesh Patel <pritesh.patel@einfochips.com>, Yangyu Chen
 <cyy@cyyself.name>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Kanak Shilledar <kanakshilledar@gmail.com>,
 Darshan Prajapati <darshan.prajapati@einfochips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner
 <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>, rafal@milecki.pl,
 Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>
 <f6601929-3d1e-49ae-8120-c3005f99e57b@kernel.org>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <f6601929-3d1e-49ae-8120-c3005f99e57b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 2025-03-12 7:55 AM, Krzysztof Kozlowski wrote:
> On 11/03/2025 08:34, Pinkesh Vaghela wrote:
>> From: Pritesh Patel <pritesh.patel@einfochips.com>
>>
>> Add DT binding documentation for the ESWIN EIC7700 SoC and
>> HiFive Premier P550 Board
>>
>> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
>> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> 
> 
> This Rb tag appears everywhere, while this is a v1 and it was not given
> on the lists, so I want to be sure this was not some blank tag added to
> series because someone said "yeah, lgtm". Was it really review as in
> *reviewers statement of oversight*?

Yes, to be clear, the series has my:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

per the reviewer’s statement of oversight.

Regards,
Samuel

>> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
>> ---
> ..
> 
> 
>> +
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 25c86f47353d..901d0e0adb25 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8572,6 +8572,12 @@ L:	linux-can@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/net/can/usb/esd_usb.c
>>  
>> +ESWIN DEVICETREES
>> +M:	Min Lin <linmin@eswincomputing.com>
>> +M:	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
>> +M:	Pritesh Patel <pritesh.patel@einfochips.com>
>> +S:	Maintained
> 
> If you add this entry here, then add the path for the eswin binding.
> 
> Best regards,
> Krzysztof


