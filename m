Return-Path: <linux-kernel+bounces-560523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5DFA60604
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1F0177EED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8021FAC40;
	Thu, 13 Mar 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqWWjmq1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08421FAC53;
	Thu, 13 Mar 2025 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909019; cv=none; b=BnJ2vcGTxIewlDrKuDspfihdbPUppz/kh70w/tq7OgrIgmMlfhSAigCamS/grcvk82s8m2+sbzQueN3yrl6dDwnm70QL0orcolGl5zuzibfJpbLyzRvmWI3vYX8jpgIExKvICxVzM0VD2yczO2fKJgkUo7YRiY1D78as+BF9JdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909019; c=relaxed/simple;
	bh=heNQMoaASzMgnAGg8FIo6sshUkCJ/+HlHZD3xDULFps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb3EaOx19h9EKb1v/L2FhDodIg31PurmDCgkYM6bijvbCqK79VZ7xrZ2KRZt5bDGktRxTxOnqL+zyyE1MeOjdpERSUC7H7G431AEfYPL5k78Hg04HdaVzfNWW1eU3YAw3ObWh5u6JBvjWPA9EmuTBf3T1Tsbm23MtNYQgyjBePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqWWjmq1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22359001f1aso39600085ad.3;
        Thu, 13 Mar 2025 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741909017; x=1742513817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pvZ3NjvDQucP+b6gUBiGyaTJOTqX9NynS/VORumDxWc=;
        b=eqWWjmq1GEZCrruMoyYQrf4pcXNuf7rYre72S8APxtXJdo6t4dp3d9+1KFf52Gr2G2
         nL4aNI0Uyj7rXRL72WTzEh+arzdxhlBKfBdiOGUhrMmV3eAs5/fXnVzXvJqP6KIFVRIx
         g9ucYfA5S/kxowp/gHahjtRx8zdYJnwD5A1GmNhOL5wFxjvrdkg8zQ1f7E1uEFUXKEQ2
         FVZ4LNMUGbXre+P2CZGmkwapFB/4HjkQtUjHbYgjxG3aijpAAuOJf/O9cBbbUkb4SXsE
         QEaV9TTFI/NGaWRQNAdyQ7yz7PMLVfsfcEMibX1OFNemRzjAlQnf8CrYbdsiroTyEe1R
         F+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741909017; x=1742513817;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvZ3NjvDQucP+b6gUBiGyaTJOTqX9NynS/VORumDxWc=;
        b=cCNOQM/x9e60PxKp1zPFagPzyYNdvqY4fQqe5j+iX1f2Cv3GLBjpqBPDqwFRcpIi/P
         Qwwb2I97qWJCgraLldnhdyfQ85oowpocqq2pNVs2340fjuWk5+haK2+Q/6bWRTuVoY+c
         5m3VUs5XzeDh7BL/lfxjJ3XQAKIwJmHwdCET0CN6LDIR7XK40TUhOKlcG2xpQKzJ4EO4
         8xjTb20NllOvPjtf3i7uDpx6XogINTj/v4FP9xzukkfrxiAWbyzP+4vrNugxFDXlmKAC
         BOTgkGqwu4emrPPCR/qBB1MOoKik4MzHfGSHNMOD9Vp2dJRkoAeeIrMqi1G6XAqVrnva
         T2UA==
X-Forwarded-Encrypted: i=1; AJvYcCUt2UZaFF1a5kq3iRWDgsHgfl98a045eZwWnYJ4deNTcqK1LlWCu4eltd/WxQSnQ9iPaxzx98CGwED/sxLs@vger.kernel.org, AJvYcCWzVuF7rVTGjUqL9pYQDS4h+750YxyN8/0F004ykMTTt1YLL5hh8wtA5RrSIqMPYMKf2u+xa/wPYGPZMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlFDzErL0/4aBYXW5+1UFqxO6ibLLilru8FwAt4BJ0+0d5l28
	Gh5Vyn4q2Tq32ioEHMV66Q43u0HM4PJvJc9AdwoNQ+a9beOkZQcA
X-Gm-Gg: ASbGncsV6WEK4vMZLbSfjQHIs9H0t8DyXD0Xa/s6q0KPVw/yJBUdYTg62g6BikIeUZ6
	D2RNA30vRmcIBJqAssRScL44kwxBWGwYZWiW4kROBKUNfEOXB3qJvXI2K6IFR/6mC3YOIctajTf
	pY3hKldFG8oXXwUx4y05pWI1lGP+bMYJqj5zxXKS+J0Dicm6UJfM9j/sX3J5MJ+DWiRXP2vZJWD
	cU4yWj/K0HJivxRMitayNZDRzNettErgA3tYZCgrJkApDOXDRs9c2JVghavc1HGzCY7qJm0vb9C
	jLLicGs+7nEFHb0QpOi0gdIiAKveDeB3+JlHtquLRiEwbTPuXxUXLR38Vlj/TZTvhkw0boHRmWe
	Q2znIgXJTKdsW1Rt0SA==
X-Google-Smtp-Source: AGHT+IHFyhH8wq5/B3eBtB/BDaMT4VJzJIcP4ftczyi30Yl5qBqAadO5cNDN3vyAqKPlRi6a4pnncg==
X-Received: by 2002:a05:6a00:2daa:b0:730:8a5b:6e61 with SMTP id d2e1a72fcca58-73722311dc6mr474300b3a.2.1741909016890;
        Thu, 13 Mar 2025 16:36:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b2bfasm1976914b3a.177.2025.03.13.16.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:36:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <523fe47a-73da-4eec-80b7-61408e0ba27b@roeck-us.net>
Date: Thu, 13 Mar 2025 16:36:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
 <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/13/25 09:24, Thomas Weißschuh wrote:
> On 2025-03-13 12:47:43+0800, Sung-Chi Li wrote:
>> Implement the functionality of reading the target fan RPM setting from
>> ChromeOS embedded controller under framework.
>>
>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
>> ---
>>   drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
>> index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
>> --- a/drivers/hwmon/cros_ec_hwmon.c
>> +++ b/drivers/hwmon/cros_ec_hwmon.c
>> @@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
>>   	return 0;
>>   }
>>   
>> +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
> 
> int32_t is a userspace type. In the kernel use i32, or even better u32.
> 

Seems to be pretty widely used to complain about.

$ git grep int32_t drivers/ | wc
   43662  192381 3555402

Also, in comparison:

$ git grep i32 drivers/ | wc
     820    4009   68486

Guenter


