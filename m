Return-Path: <linux-kernel+bounces-219999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E690DB56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E320283B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B0156F21;
	Tue, 18 Jun 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHr+daw2"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC8156C6B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734214; cv=none; b=R5hB05p3P8QIPuih+uaOS4dhj5bOSKKFaGzNW01+LH/nzYW165deZdihl027CLYra8v8+oGR6jagGfra0RgrnZNxP+xxibnbOQv2gRPkEIHhaFI/zzhYIqxvGhjNvMIzEh3AvAKTJQi8vbw/gfmn5Dob8rtL26gOQLoFLHZBkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734214; c=relaxed/simple;
	bh=rbJs8MNAFE8VWRdIQYKsP31mA+TYArgJV+Rm6c69Uo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEq1JTYZfkBqWLc4WK7hj7bJoWcyuG2wo3MeX1/xrXVdMrwHHbZFgz/Ac95rwlVOYgAdVLl736C6X7RliT+TUOH6J4P+vjpmtnD0Kz9nUfYMdO16m0gKFHTRnOFKS5XzpYxw3+VOJ5Rh6RvZahxV20ChGQ9xsm2ixV/8gvCryQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHr+daw2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-705fff50de2so57937b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718734212; x=1719339012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tksP8iwOTDl5VporpnBvdxtHrBevWiA9FB09E64Mkfc=;
        b=AHr+daw2288lJaL35c9tGTqTt+DSgYdALHj/qCmbEF23A8/y5yA5yscdJ14RedbnFC
         i0rpu+X9H5uCjHjMfpxVi4cbzNI8dSkrHa4CUyUb+FASyfBfXfxgOtwOCgiXqRk/7DuG
         4PMCKBdAFmRNxFuNtcO87fNsO0ue7NlQnbum6TgJkhFcdY2TaqbOS2SO5o9mxBC/0WeD
         H/CAX/frdKJBvJOXq/PhdmeBICOIaPSCiz0d6TDBdMb458tVIjz1dciQzCCeHDsPUgwL
         +gwpMeQ06WRuuO/9kzSt5n0eQ1+G2PGm5U9FX82X0/QkgByoZzMIVT9KpEVpF/WzWLCI
         FKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718734212; x=1719339012;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tksP8iwOTDl5VporpnBvdxtHrBevWiA9FB09E64Mkfc=;
        b=CBcIBfAWcFyqxa8nMLxoCsIfsHJ2QTjk2D5mdUzuSfP2N4ngPD4D3Upp/W+G5lf5SZ
         4qrScdW4TFmvci4XsO6aXNmZ+WM1PpmUF/8cJodad3srXRKZ2bX1nqQqvlgKzW0GFIzL
         q+wt1JAxBsGdsazZjXABJUFMjIJfOUa2JPHqJpww3nGUiF9Z+wDHaomEC+lIfDMH8L9m
         tkqCXXWR5BthMhIY/zADZGSyWAARguUAcE12rSQy8HE1zo1jM5RF1QOZ4zWnLeVgLrM3
         MKmH3nNYYDbphO1gDxX+DQs+LkahNdLw/yiVsPBtgDJoZukibQZTND5uT2b31R/3M17e
         s41Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM5bgnPUT13ACgHacnq2/m2M2XE8uNLJHa8J60eGQ1or3huvaSt4qNZbelguRVYnGd+QgWkcwL92a4bC9b4aiw+wllpNNVPCi660Z0
X-Gm-Message-State: AOJu0YyKtQpU/CykqpMcDvQ17ANfINvYq1qkQnRDn1Uf981BU1demny+
	+eobEShcjki5M6C+YsGRTGG5DH/qR7s1OC2H2XOFYA5FC9tP7bRP55RsDg==
X-Google-Smtp-Source: AGHT+IHDHF118TZfIHIIpEuJTLKU2jjQrbOE6fdjOkoKVtxM2BHw9JPhhH9vAjSNy6wGXMZZtpaSsQ==
X-Received: by 2002:a05:6a20:3b98:b0:1b8:af57:7bba with SMTP id adf61e73a8af0-1bcba179d0dmr786532637.15.1718734212238;
        Tue, 18 Jun 2024 11:10:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b788sm9267506b3a.164.2024.06.18.11.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 11:10:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5e070081-8757-4384-989c-25f6e0cfa7e7@roeck-us.net>
Date: Tue, 18 Jun 2024 11:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Page select register restrictions in regmap core
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
 <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
 <44d4fce5-2ec9-4f62-b7ac-a317c7d843db@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <44d4fce5-2ec9-4f62-b7ac-a317c7d843db@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 10:45, Mark Brown wrote:
> On Tue, Jun 18, 2024 at 09:14:56AM -0700, Guenter Roeck wrote:
> 
>> Anyway, this may be all irrelevant in respect to regmap support.
>> It turns out that at least some i801 controllers don't work with the
>> access mechanism used by regmap, or maybe the spd5118 chips don't support
>> I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't support
>> auto-incrementing the register address and actually reset the address on byte
>> reads (i.e., subsequent calls to i2c_smbus_read_byte() always return the data
>> from the first register). Since regmap doesn't have a means for me to say
>> "don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports it",
>> I may have to drop regmap support entirely anyway. That would be annoying,
>> but right now I have no idea how to work around that problem.
> 
> You can set the use_single_read and use_single_write flags in the config
> to ensure registers are accessed one at a time, that restriction is
> moderately common.

I'll give it a try.

Thanks!

Guenter


