Return-Path: <linux-kernel+bounces-517467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E535CA38140
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9733AA9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D64217730;
	Mon, 17 Feb 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+B51uWX"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE621771D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790091; cv=none; b=sbdmfcRW2laovjlAUdmp+Ic6S7WYsA1JPxeDq1+Vk3FekHdsrLzTURxbVBacphiE9Mnb8lChvCrDCGovN1MTziwAFPPkBqMYVjSdky8DzoSsADvz9Gn2Kd7LAZgwTsw4S00MIjxVLsClng2z8otwlsBWn+2NVFoGn4PJ0h1QznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790091; c=relaxed/simple;
	bh=C9+CS3+xrz35ggieBD8mVagEUZNBCKGB2ypBhzW4meQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuYFkh8TaGDb+f846QKiL2WgBgEMD5nHJcyRgwuMumJyuBgVgBl7nKmQPcvOeRXq+CQraDiD+xxtqe8s+rB2slZQYH/gk/0MiBiUS0OadT50SFM081hQThcaiPvjetUTo5dGGlZoBjt9ICa8mbU9kPTzH+I8ImfMEZxcU+UHVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+B51uWX; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-220bff984a0so74366075ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739790089; x=1740394889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svM2c3liAXz7zcfaXHI1zWhEfVZlndyzyMr/crIaP/E=;
        b=m+B51uWXeDAYKz3BykEM9sXVGNZfxr7kXKuKA30/Cbg2JbKp8WtnAkYn0xKE1DeaWK
         Q4uVWxgkijVJRz+uKypYIkc9zkwne2ttBNTnHtXjZa5pcftcAgNMRpbkqH5OFdRwcliG
         gJckD4e2LuGfKvomeIXeCvZwE7QGBguRXHTxFfIC3d1SvxZ7Q6ge0bj+Fb8Pnj6jRJPq
         BEqB++uVd8P+n0yQnzo56ZXcqU5y7fb5N6pCpKBJM7D8yVQwQmLj7JmwK/HmQDZy9OoL
         +6iTI2RpI0rnWoEZdpBGoHJ4DL77RnassI5/+J27zJQAFHlsRIkqVbOO3UFSbmT4/lBX
         WebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790089; x=1740394889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svM2c3liAXz7zcfaXHI1zWhEfVZlndyzyMr/crIaP/E=;
        b=c0jMaCL3uZQWkH840oK8sqo4fCSgStx/bUtT+eC6uvRwFFgLOVFetGL62cvyoQqLtl
         30SJD37GfeNkpn8hnMGq9KA6u8oOSLFbeOP/UAYG8i8HiHVjhw2hr+7WO+SBUxGEL74r
         qetZdbDrH9nhJ/8/tv0qwHtNX96ZCXIPoj10yeSt6ozVjrOmy0QPUNNJUCsVRs74bhlW
         8/tEkNAZoR6+OwfULvxXlwh3dUkL6XkR217+R6l7Lj+4wsg3KLR6J+ceX/97PK+MyoML
         JPUVYyVBNp946GdiWQQXVfxgYbszD2ak5pxpuXU84216xifZp8b1WtnOyAMG4XDe/x6H
         PuUw==
X-Forwarded-Encrypted: i=1; AJvYcCUTvWGI/2X+RAJH5clKBog/6/57nyCc6oLpS9EWMbymUSltmZmYD6EI05C+OiH2BbSP718kLNKfAGrEM8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Bad27go5C8lvXhY75ZRxBbSVl6b97kn+wJWVOJwCpr6Q6iMU
	IOxqWHpcvbOESnz/CFjBIGDnxJ6GTDDDwxHXk2Edk8d37aZcOjpG
X-Gm-Gg: ASbGncsy/PGf4pE67EltYTIhTuvSzv416ZVA3saA26/fCG4nDtqQuZcVgdhpkfePIsC
	KZhrkdLy5lQWCxwpvlatwvbq0nvvFEJ6kVzwLFWKOF9boGUM8wc2JxVkE5Ybw7xUntTU3ip+fzo
	i04waMa1XDxpJnDg+1s8bJ1/JAataX2pe2PuuqOOiuxuMaEuH3n7cMrMbwu8mk7wdqao8gR4wue
	v+66KFIwaQNBgOX00mEcZ84A06VGWPmk8UaChneFyz/dj662rw45WAg5/dQLZsE2KXuH2bmdRK2
	NN1P/YhvoO0qrPOWmnjfyA+WecdUdIO7QQ+7BMmQtLD/eHksDHtkpn6RObeYim54Qrau
X-Google-Smtp-Source: AGHT+IFuFsKek5k7IV6yigvBBWUxtJuImh3iXjUHxjIvlw+dQW9yJsW9SniM4dh6dGgpLHPHefr/Mg==
X-Received: by 2002:a17:902:d507:b0:21f:dc3:8901 with SMTP id d9443c01a7336-221040a9a19mr146759395ad.34.1739790089314;
        Mon, 17 Feb 2025 03:01:29 -0800 (PST)
Received: from ?IPV6:2409:4066:d04:319e:1d76:db25:b6bf:4f52? ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d016sm68401275ad.146.2025.02.17.03.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 03:01:28 -0800 (PST)
Message-ID: <5c6b9e9d-e360-4da6-aa82-2090efb1290b@gmail.com>
Date: Mon, 17 Feb 2025 16:31:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] [PATCH V2 4/4] staging:gpib:agilent_82350b: Fix
 Indent issue with block
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kuba@kernel.org, dan.carpenter@linaro.org,
 rmk+kernel@armlinux.org.uk
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
 <20250217103046.54294-5-kumarkairiravi@gmail.com>
 <2025021742-shoplift-arrogant-937f@gregkh>
Content-Language: en-US
From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
In-Reply-To: <2025021742-shoplift-arrogant-937f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/17/25 4:09 PM, Greg KH wrote:
> On Mon, Feb 17, 2025 at 04:00:38PM +0530, Ravi Kumar kairi wrote:
>> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
>>
>> There was a empty line, which was causing the checkpatch script to think
>> it's a single line statment, after removing the empty line it's no
>> longer asking to check that line.
>>
>> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
>> ---
>>   drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
>> index b6871eb3c8..1d644d000a 100644
>> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
>> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
>> @@ -228,7 +228,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>>   		return retval;
>>   
>>   	if (send_eoi) {
>> -
>>   		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
>>   					      &num_bytes);
>>   		*bytes_written += num_bytes;
> The subject line is really odd as this change has nothing to do with
> indentation :(
>
> thanks,
>
> greg k-h
Yes, I now realize it  ;-; and will do better next time, btw I came here 
from your foss conf video on YouTube

