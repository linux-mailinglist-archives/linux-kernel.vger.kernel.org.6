Return-Path: <linux-kernel+bounces-281666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53494D9A5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F412B21D07
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007E7288B5;
	Sat, 10 Aug 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUVfSrnD"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D291DA58;
	Sat, 10 Aug 2024 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723251867; cv=none; b=usgZ8ZoDuezr+FK1AhleFbG2SqVqjieNvW9R5AuVpEpb3y+8ev8VSq99B3QcD93qNAaTMKRKCymXUNgFqccrd5XaZhQ9mbM1EDT3Lvm2IBPsfNwebE4porSnKpvaJ+RWhOavPRN57IJ2NStOnlF9CXG7hb6h0ok3P5Y+zDdCm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723251867; c=relaxed/simple;
	bh=8UQ6Gh5JmTBWQc8KqZpDbl+68IWTdtUmmYvg4y4U8t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4gYbWC7Oz9eQCfasFb2ZZ8s86FxcVD5ku7HZIFryk4znXfuW8bp1w2Ggp4B/NuJirz1gVY8sDxlWO9Cv+bCs/zOHYP26n1yKBRnqH7+Mxqq8Bu8rDwumzaZD0MrRUSV/2+UgeCpNXgCGNqTnj8oiwo1OQDxd1zWuOo/0Nbmir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUVfSrnD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-369c609d0c7so1946935f8f.3;
        Fri, 09 Aug 2024 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723251863; x=1723856663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxH8ZI6GvvlQj37P1FOk5R8rQRGuhYdScgrObjHN0VM=;
        b=GUVfSrnDHGwfuem14r1B8CKiu3C7r94SQRaV5hHlLFAKNyaJdOr8s6+OTzEkY+0zwH
         pFMd/FKn68AhOa7eV8Nw0SE9jjXhNTg6TXo8Fer/OZ7uvZymORHZmDOL2yBHWE7c0SZ4
         VHzQR157O2BRDxME8h2a5gqY9Y2gA6hh9lBEKonP8LE/Shic3/ihyBK0H+qDjBvW3RXT
         Oz7WCzKl3ffUdxuT1cl5wfTCUg8kPcRJYEpVd7b7/mpgp7GunLwC7Mdl89jzWlW5TLba
         aekO/PoKpgZHNCJtqfO0+kkWXwYsSQkau/CfqV1jVCeKInxco3Fm0rpzOLVhPanoIfvR
         NOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723251863; x=1723856663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxH8ZI6GvvlQj37P1FOk5R8rQRGuhYdScgrObjHN0VM=;
        b=BdBtpVwlWV51llLokMH27UvPXh+j+KLKqZSHfAWjVUvq4hKRH46bFTdYAwIVqU3DAG
         zv+EGUGMmHBJrPs5Vec7XYFEt4TWcEyMEjqqCRxIhDMQo20mOYNyD3NnVQunGcTX4fUC
         ILbKa8+VSlwofiTMJmbvqwmrue/yAI9a2efT+yrLNl+Ckq9AEmCpYaK90nO6oadQ6neh
         ZL1fE/55iv+5Qh5z7isGqk2MmlW4nm2dtM++COz8fz6a00iu4QB029mBYC2z5vrTU7oA
         bs2+agiITcZ500Z780to0U8uQwm43HQAk7lgArn0RcQqOWbZPX73u1e+8FKbHEUIdDzw
         qNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpbltlXpneh84JnpVPOjOpG2SYsOn/Pbay6pNlLpFzsO3iyF3MXUsFyq3odrBX/72SfRdIqKBZNlhB37limtvTwo0Xa3bexdUQpvGwmNTeChQgVjMmjrGGMK/Hbjs2IJ1g53d8xb4OL3g=
X-Gm-Message-State: AOJu0YydYTyTFBsfAd/mxgCLuFt3xLoLn8eBhkYZbTs28VCf5cNV3e2q
	d7BRMa7POymrPf9rsQEykqpAo6hcV2Nhfdh1KriuS2W4Ze1uMO9K
X-Google-Smtp-Source: AGHT+IGHMqxtIRrNI8/9flAsYnKITLakK0Q+G95RCtqROL5xrwBxOIv1gMPdqfVaILhtlwrnZ+4EsA==
X-Received: by 2002:a5d:540a:0:b0:360:75b1:77fb with SMTP id ffacd0b85a97d-36d5db7ac26mr3031551f8f.8.1723251862517;
        Fri, 09 Aug 2024 18:04:22 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750e57fsm10102405e9.12.2024.08.09.18.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:04:21 -0700 (PDT)
Message-ID: <4464d0f5-1a40-40b9-8d53-7f0d75b9d062@gmail.com>
Date: Sat, 10 Aug 2024 03:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Konrad Dybcio <konradybcio@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 1:35 AM, Konrad Dybcio wrote:
> On 5.08.2024 1:08 AM, Maximilian Luz wrote:
>> Some of the newer Microsoft Surface devices (such as the Surface Book
>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>> Module (the embedded controller on those devices). Add a basic driver
>> to read out the temperature values of those sensors.
>>
>> The EC can have up to 16 thermal sensors connected via a single
>> sub-device, each providing temperature readings and a label string.
>>
>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>
>> ---
> 
> Gave it a shot on SL7, some names are repeated and one sensor is
> totally busted
> 
> /sys/class/hwmon/hwmon66/name:surface_thermal
> /sys/class/hwmon/hwmon66/temp10_input:32200
> /sys/class/hwmon/hwmon66/temp10_label:I_RTS2
> /sys/class/hwmon/hwmon66/temp11_input:31600
> /sys/class/hwmon/hwmon66/temp11_label:I_RTS3
> /sys/class/hwmon/hwmon66/temp12_input:38000
> /sys/class/hwmon/hwmon66/temp12_label:I_RTS4
> /sys/class/hwmon/hwmon66/temp1_input:43900
> /sys/class/hwmon/hwmon66/temp1_label:I_RTS1
> /sys/class/hwmon/hwmon66/temp2_input:44000
> /sys/class/hwmon/hwmon66/temp2_label:I_RTS2
> /sys/class/hwmon/hwmon66/temp3_input:47300
> /sys/class/hwmon/hwmon66/temp3_label:I_RTS3
> /sys/class/hwmon/hwmon66/temp4_input:-273100
> /sys/class/hwmon/hwmon66/temp4_label:I_RTS4
> /sys/class/hwmon/hwmon66/temp5_input:31300
> /sys/class/hwmon/hwmon66/temp5_label:I_RTS5
> /sys/class/hwmon/hwmon66/temp9_input:37100
> /sys/class/hwmon/hwmon66/temp9_label:I_RTS1

Hmm, on the SPX it looks like this:

I_RTS1:       +31.9°C
I_RTS2:       +31.3°C
I_RTS3:       +31.4°C
I_RTS4:       +28.3°C
I_RTS5:       +29.3°C
I_RTS6:       +29.3°C
I_RTS7:       +29.3°C
I_RTS8:       +29.3°C
VTS1:         +30.2°C
VTS2:          +0.0°C
VTS3:          +0.0°C
VTS4:          +0.0°C
VTS5:          +0.0°C

So VTS2-5 seem like they may not actually be connected, but the rest at
least look somewhat sensible. I'd probably still keep the names as they
at least might give an indication what the sensors could be for.

But there's a good chance that we're missing something on how MS
envisions these sensors to work exactly.

Regards,
Max

