Return-Path: <linux-kernel+bounces-239780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617C926539
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346C71F22345
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DBD181D17;
	Wed,  3 Jul 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="Q5QwtNd9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E731DA313
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021577; cv=none; b=JDWxSVXqUYx1iO7Bw6SQ0bifIFw3CW/5VEIoTctWogiAFNxLLKaZt8ilXY1YpAcldvq1RfoMIKwEdOR58ZvNDQ+qrjFWq4+q2lN44pFHBz5cX1vq5cYvKpmc9QjMnhjxSQXgI6F6TrSpbPJ667fIbA1Z013FDa6drX5KskqxlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021577; c=relaxed/simple;
	bh=emwNi/2rPBeIsOy59YI6Jwa18nf34XK/b89Sx8kse2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1UmQiqPk/h4G8V14NvS15GtJgV9bd+5KpuEvDP8UrDRd6xnIH4GDiVVxzn6JgNG7NbO9OmZTZSzKRZZXFLAmSejXNPyhHAhtj1j4+gDwZCdqWDGuJxpnKIWQ24ulpyTZZ1uxmgbGfhq8eK2cDc4yKg880k6EV5MEOY9TIpNbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=Q5QwtNd9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424a3ccd0c0so39698335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1720021573; x=1720626373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7/gFAhznzpNAWI6NkIrZ0PW8u+h0zxYFkNHn43o1zU=;
        b=Q5QwtNd9aX2MZGHwb7FZI/CLgn4o12ETj2GOpl999k7GvkaVucL638iKSeRvr+ASNT
         yq/f+DWQ1oqdSox7+t+KuQeilb4+TfKSeWtr42j4aH7LUd6n/Z3Liet7ZgiR/uqUNtaW
         Pob6ihIociVxZKTQUSVU1fyFbKeX1DV7TQz+o4nQAQsMUVzCoegZlxa6aintqSxSTvVN
         FTuKJnfk1NjHcSWNDKQcnH2amvkHhw6jnxQFT0+CF5gqVzWk/swRn1X7rl0fNdBasZ8a
         0KYXq5lhI5qN6Ez1BRxF8lFNz+U0RCD8CRlBfyzsLkUq4KedNRJBwS63ioHmOYpvdo5L
         ITWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021573; x=1720626373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7/gFAhznzpNAWI6NkIrZ0PW8u+h0zxYFkNHn43o1zU=;
        b=Ym6zdeQKhf5KYg28hzB5Vbn9YqACorlMXiNQGw/f+9ShLHX/6MwQqKJWBVmVAK1rnH
         lncFL6uHCbgWAt6NwNx1mZbfmEbHldRjBu4EYHlfjJuy5VqfACnoFUK+5pRX8kfm7Y1D
         Hjn/G8VSj2k3pIWKLpTp2UKowvqOo51TfrS7x/45VLwI4LI83cNBmZ5uyq9cjoJnO3UV
         UdZ5lH7PQfIg3axRUAar1/1fOTEa+0/D3IGR0Zm0c8lYf9SSMAWgsBNWXHBH8xbrmaEh
         jsVMLpa1X8aVx3cDDhHkf5jrsdjW/21PCCIQkOAheHp4Xt+uMzUC2g2FQ8dyjadSAng7
         3Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCXINx52wcp4UaIuDAQyKCsZ1i9xgUKehe7nE2LValOnwAtbxrhQ15QfHjDigYm32k8OQLY+mGrSh4t8lYRqMg7hPfOzYkSacCuKQLQ5
X-Gm-Message-State: AOJu0Yw5MGShH/kaY34IPZtGfsRI3+gztPr7KlXxQQx9s8qssrwIGrFX
	SW4xfodThd32eNXJqyp52pTvEKxPZDe3gaCp+UJRJ0wmpzf50coTF2JbpZPRAWQ=
X-Google-Smtp-Source: AGHT+IFuL5KzU+S+e4FeheICJ54uOi4mNqyUXkxrWh4v1QZ7M2h2Jlo1KmpiHL64N118Mk1lWMmU5w==
X-Received: by 2002:a05:600c:314b:b0:425:622e:32f4 with SMTP id 5b1f17b1804b1-4257a05fa23mr87451595e9.26.1720021573017;
        Wed, 03 Jul 2024 08:46:13 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42588492b4fsm104348865e9.4.2024.07.03.08.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 08:46:12 -0700 (PDT)
Message-ID: <00676ba0-d2ba-48ce-8b8e-8c1d81a4c24f@nexus-software.ie>
Date: Wed, 3 Jul 2024 16:46:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure to stop CAMSS stream (sc8280xp)
To: Johan Hovold <johan@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZoVNHOTI0PKMNt4_@hovoldconsulting.com>
 <49b2504f-e5ab-4ea9-aefb-bc9c7f71f5fc@linaro.org>
 <ZoVqT0jzro8s4NUC@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <ZoVqT0jzro8s4NUC@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 16:12, Johan Hovold wrote:
> On Wed, Jul 03, 2024 at 03:30:09PM +0100, Bryan O'Donoghue wrote:
>> On 03/07/2024 14:07, Johan Hovold wrote:
>>> Is this a known issue with CAMSS or is something missing in the sc8280xp
>>> integration?
>>
>> A known issue on my end,
> 
> Ok, good. Do you know already if this is a generic CAMSS issue or
> something with the sc8280xp integration? I believe I heard someone
> saying that they had seen something similar on other Qualcomm platforms.

It seems generic but, I only really started to see it on x13s, then 
again I use x13s as a semi-daily driver...

> 
>> I also want to root cause intermittent sensor
>> startup failure, before switching on the sensor upstream for more common
>> use.
> 
>>> The issue was there with 6.9 as well so it's not a (recent) regression.
>>>
>>> Probing the camera sometimes, but infrequently, also fails with:
>>>
>>> 	qcom-camss ac5a000.camss: Failed to power up pipeline: -13
>>
>> Yes this. If you recall on the pm8010 I had mentioned to you about a
>> wait-time to startup the regulator - thinking it was the regulator
>> causing this error.
>>
>> More likely the GPIO reset polarity or delay needs to be tweaked in the
>> sensor driver.
> 
> Ok. Seems to happen quite rarely here. I have also seen a probe deferral
> warning (which should be suppressed if it's legit) that may or may not
> be related:
> 
> 	ov5675 24-0010: failed to get HW configuration: -517

Hah odd, I haven't seen probe deferral myself - perhaps not in the intrd 
for my laptop.

> 
>>> and I'm seeing the following warning on every boot:
>>>
>>> 	i2c-qcom-cci ac4c000.cci: Found 19200000 cci clk rate while 37500000 was expected
>>
>> That's hanging around for quite a long time 19.2 MHz is a perfectly
>> valid clock, useless error message.
> 
> Ok, but please do something to get rid of this warning as well. With
> too much noise in the logs, people may fail to notice real issues.

ack

---
bod


