Return-Path: <linux-kernel+bounces-364077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF6499CAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01311C22191
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217A1A76B4;
	Mon, 14 Oct 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="FOXrXD9Y"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731C19E806
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910898; cv=none; b=OZBdPTATzHtDa6iQUtjVZ19W0xGNu5xZC9HpQfmdCxgwo58bVbBIOevrGOxdzqSQxXfCl0yDK4ITbvg3RK37D+q3p1iO4YFVwylyNnk6BazMfSnV0v0H4rfJNpM9bv6n50ySdB42UpKWw/6ao0ne9oApTPrlBwK59hVhjneGM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910898; c=relaxed/simple;
	bh=++dcIeDFDIn2Ao7fa3l8I6kCkaljhMOysKS1UQX8IyI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qdkOB7c86c6gMBuMnLwjy3skybX07VVdYWBlPtEagrjJWwR7Sdj1HL4Flwl5sdfoTHmOOUvwBtLxnSuoCzdu14h0ns7isMc9t0DCRpRXgzF6ixeGJ1fJaj4bTCcK5BJDkGefBeECqa9rbCYJH2rfMrmIpt05NtU9qIZgFOHuOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=FOXrXD9Y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1205e0e03so185479385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728910895; x=1729515695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RHxE4BwKc3ZjDQztQ5oMassHpRi7zp5cvhCSidmTTk=;
        b=FOXrXD9Yi/AC4n/KEvhIWyGLWXnG4sepYNGZby9xrlR/v6XwIcOI/iIzL5e7NUrcDu
         ILAh2+lJTnxrJ4cmTobwt/sXB8MB1JzuHRpIP4jzsYED1gIFKzHNPkcQ9L2x+m4cBF7u
         kXArpHKo48BKhUVTU74QM8XdLSnEcs0kEQNbRx5W05zNWhPoDH3CEK9chaS88bZcCUUQ
         eSc8iGcC443wWVUiqtHrxNE+Ib/520SZWzQFyd71tQTV+EYF1pqAqM4FPaSORewwOits
         zH7x7SvRNAtbtwgObgnv6RlD1Ro8mDXoBymEsI8ZIGZFX1NFCxakc8nnApFmwV2wNX0T
         UQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910895; x=1729515695;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RHxE4BwKc3ZjDQztQ5oMassHpRi7zp5cvhCSidmTTk=;
        b=qqpffRGnsXbKk8i9y/blhShskWVKoAPwsiMBf+M8t0jzRvIBbxa+yzqpcczSGb+GY+
         d9nh8mLemSTFfl4QJ+71RhpWw/spRbMjMp/JBIrsEcz8wh6vOyWynjkCA7wk6Dh3fTVK
         0vzU6gFLQlzD9YKAOS98WbmHkangGFywNeH/9g/dpoIL5Vn9YlexmmlQ8VW90LJ+d9ig
         MJSP7oCjvouZft88vgmAGzTs3gZefsYLtmE9W824/V9H3iNN44mnOhwFPds1NF5wcNUl
         Lbo5AHeBOFUYsT8aj6gEwCtu/1zlDdqhPetW+kOsMENAvYDLz5ph3Xcfbjd84hZrv1WE
         w2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5F6yrBl1nILfB3al7+qeXvSD1tBP/7V6YYJ+Z9Bax6KIjpGYp56M+cHgLD17olxEvmYuoEhdJhS9hb2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJpZHIBJ8/bbtaVZaSdjAHBhmcDJe02+EjWSPKo0EjGzeHkVh
	W+82QY5IyJJneg2WcIaDJwBoUie1u09kdaeGpK34Ry+fIL0tYdlAxbzdVDfpgBYFaaMMu76DBWQ
	M1vg=
X-Google-Smtp-Source: AGHT+IGh0QuJA6b0OOwNfoiRKhU3ExuhAHzAqesdDNj776vJw3RQWyW54B6RNyGsIvJBrvQs2fM8Ww==
X-Received: by 2002:a05:620a:190f:b0:7ac:a077:6a1e with SMTP id af79cd13be357-7b11a352f87mr1621830785a.9.1728910895574;
        Mon, 14 Oct 2024 06:01:35 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497d799sm413618885a.117.2024.10.14.06.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:01:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] dt-bindings: rtc: qcom-pm8xxx: document no-alarm
 flag
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Satya Priya <quic_c_skakit@quicinc.com>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241013051859.22800-1-jonathan@marek.ca>
 <20241013051859.22800-3-jonathan@marek.ca>
 <gpika7a5ho36gx3pz7k5t4rz5spvpnmnvzs277r64z2npdmfmg@4vcmw6x5zvwn>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <f3b4bb12-d025-1cc9-6dbd-04913b951425@marek.ca>
Date: Mon, 14 Oct 2024 08:58:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <gpika7a5ho36gx3pz7k5t4rz5spvpnmnvzs277r64z2npdmfmg@4vcmw6x5zvwn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/14/24 3:34 AM, Krzysztof Kozlowski wrote:
> On Sun, Oct 13, 2024 at 01:15:27AM -0400, Jonathan Marek wrote:
>> Qualcomm x1e80100 firmware sets the ownership of the RTC alarm to ADSP.
>> Thus writing to RTC alarm registers and receiving alarm interrupts is not
>> possible.
>>
>> Add a no-alarm flag to support RTC on this platform.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
>> index d274bb7a534b5..210f76a819e90 100644
>> --- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
>> @@ -40,6 +40,11 @@ properties:
>>       description:
>>         Indicates that the setting of RTC time is allowed by the host CPU.
>>   
>> +  no-alarm:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Indicates that RTC alarm is not owned by HLOS (Linux).
> 
> This is not even properly used/tested, because you disable the RTC
> entirely in your DTS.
> 

What? The next patch in this series is enabling RTC on x1e using this flag

> I expect here unified property for all Qualcomm devices for this case.
> We already have "remotely-controlled" and other flavors. I don't want
> each device to express the same with different name...
> 
> Also: missing vendor prefix.
> 

I don't care what the property is named (as long as its a bool 
property), if you have a name you prefer I will use it.

The existing 'allow-set-time' property (also related to HLOS permissions 
to the RTC) is also specific to this driver doesn't have a vendor prefix.

> Best regards,
> Krzysztof
> 

