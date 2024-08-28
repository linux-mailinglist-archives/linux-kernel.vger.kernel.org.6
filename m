Return-Path: <linux-kernel+bounces-305379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8627962DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574961F213AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524E1A3BB8;
	Wed, 28 Aug 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPdSkMo3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B519FA9D;
	Wed, 28 Aug 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862932; cv=none; b=t7Z7Q9RoTy9sbt926TOj547VfGlkRxINN0jndKGkQCIM5EvfEhrGNIO21IH/avVNSl/ZfjBAgkSYHrWae2gEleiYpUhqLussBkmvbi1l3cQOGEFmSv9UG42HkJ10D4e+vKkV8hIzbqj4mRygk82TAKm21VI9P1FvDKQIqYxnG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862932; c=relaxed/simple;
	bh=ZgRO8Jpty6xxA8cviLcFTOZN0qftgs+KhbYJLt66oNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZx4SwFDvI4sqtviH6VfxRxp8pXyO8WJfIaeIpJGZLiyv5q9yhXspQXQPnWF8mEvaUuh14q1behT4g/Rgju/VQ/LmcEiJnMya7fs3U+kXB6EcnW+uVmdUWL3j2tZZmvD9vuDlWO9E8AYZ1eyeg8qN0ygLvFWztq8mFDLE2UoQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPdSkMo3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2023dd9b86aso55385565ad.1;
        Wed, 28 Aug 2024 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724862930; x=1725467730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d8i8GlN5QVFw93QvJqdcR1C6AVi8olJSBAn40+qINUs=;
        b=CPdSkMo3C1H2HT5BoOA888aVAVlvTWW/bz41Ns9kPRAlOwCoht8uAgKbnvHLNwT48N
         IQp509ivoK5CYRQeDZUeVi3W+kISbJ2deYVC1dlHLVpQxXBSGEi+JgwHEpEjXEtRtYCs
         o/SrGBvT1LLUMZ/AuXu4nLTuyi5OsBpn4hYA4vu1KwNUztlNU8kqhPQx86KXxKHa+dXS
         ehHa+Q8SJkpzhHutqQUS+6GeOgWE/KsgVKdaDBt2aKR930PqOnifUNupxmGojvl+tp+0
         afQmatm1b0DEisX7x/EkVKjeXU8aXImRF0C7F1Dfyc4EkxCM+k8pi/9ejGIbCMDGuML0
         wBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862930; x=1725467730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8i8GlN5QVFw93QvJqdcR1C6AVi8olJSBAn40+qINUs=;
        b=dTKp6aBTFG6LFqOEJcf0RgwWmcDhhFW0nBejJoW0W55QhBJ3p4+L/ae2m2qdZX7ySg
         7c8JpzKeSrvpT9GEBRwr6+MUbMjUvttqWodCqA1jleGNrI2IBUhw/hc6tQzWOAmRaj9v
         TgESt2kX/xvQQLnew4zFyFX5MhKMBwyl+yMiXx9MpscXy2A+g8be7nmzrbzU3Bxgaz7/
         tA3AQ4Bk6SBC5tSN3kZu9qxqMl97f10LFlaW8Vd1ijjJ9sjsXbqUjO68TREgqp1c35O/
         0tvePRXppZEpNPaMHIIixddkrtskT/yLdk1hCv/jaOkqvgUm0srhX1dxoWWIloq72hRn
         9N/A==
X-Forwarded-Encrypted: i=1; AJvYcCU7uYHo/OEC9iqPpIFDajeDSziaSYzvgBZol/4b9bi2DJePDo2N5Zo+WQ9i2+i3ngAKqE80c7Axao7szZIw@vger.kernel.org, AJvYcCWiqdLaDHjvH/cUYga2rf+Bsd6owRRgxJTEai6ujL0/hOb4WvcReZgxBZkpg/B073v6Gmq+u0dxJd+IyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZW2ZW6DWwmswL/cl2brGnus4iH5lr+9NorzWMf/r/+IbJ7FYR
	3jy+j1tjItXCGBZH3J/pBazFjBHhbzPFX2vfQLJI7lZfr0l8d9pD
X-Google-Smtp-Source: AGHT+IG8PEl9rhR62gy5WfW0aep9F5GFGPKjCTFH8y8xSsCR9jY/J1weI9/He3AYjmkhuIQnneYs0A==
X-Received: by 2002:a17:903:2c7:b0:201:e49e:aaf6 with SMTP id d9443c01a7336-2050c237b14mr664985ad.19.1724862930115;
        Wed, 28 Aug 2024 09:35:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855ddaeesm100845745ad.124.2024.08.28.09.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 09:35:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9535722-6e16-4927-9aa0-974c4028537f@roeck-us.net>
Date: Wed, 28 Aug 2024 09:35:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (sht4x): add heater support
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <790f67c3-84f4-441b-bd80-0c11f002af5b@roeck-us.net>
 <20240828160511.307768-1-apokusinski01@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240828160511.307768-1-apokusinski01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 09:05, Antoni Pokusinski wrote:
> Hello,
> 
> I've been thinking on how to approach the problem of NACKs received
> from the sensor while the heater is on but I haven't found
> a perfectly satisfying solution either. This is due to the fact that
> the device does not provide any way to check if the heater is on/off.
> 
> 1. I guess that the simplest possible approach would involve sleeping
> in `heater_enable_store()`:
>    
>    ssize_t heater_enable_store() {
>      ...
>      mutex_lock(data->lock);
>      ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
>      msleep(...) /* for >100 or >1000 ms */
>      mutex_unlock(data->lock);
>      ...
>    }
> 
> This way, the user would have to wait for the heating to complete in
> order to read RH or temperature measurement. However, I find this
> solution unacceptable since it's completely unnecessary for the user
> to wait for the heating to complete.
> 
> 2. A better solution could be possibly to use a wait queue in order
> to defer the job of enabling the heater:
> 
>    struct sht4x_data {
>      ...
>      struct work_struct* heater_work; /* This would be initialized
>                                          with the handler described
>                                          below */
>    }
> 
> The task of sending the "heater_enable" command and sleeping would be
> performed by the worker function:
> 
>    static void heater_enable_handler(struct work_struct *work) {
>      ...
>      mutex_lock(data->lock);
>      ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
>      msleep(...) /* for >100 or >1000 ms */
>      mutex_unlock(data->lock);
>      ...
>    }
> 
> And that above mentioned work would be scheduled
> in `heater_enable_store()`:
> 
>    ssize_t heater_enable_store() {
>      ...
>      schedule_work(data->heater_work);
>      ...
>    }
> 
> I think that this approach with work queue is better since the user
> doesn't have to wait for the heating to complete and the RH or
> temperature measurements can also be retrieved without the NACK error
> (even though the user still may have to wait for the heater to be
> off), since the `data->lock` mutex is used to guard both measurement
> reads from the sensor and the heating in `heater_enable_handler`.
> 
> I'm worried though about the situation where the user writes 1 to
> "heater_enable" while it's already enabled. Since the `work_struct`
> is already on the queue, the `heater_enable_store` would return an
> error and I see no easy solution to this for now.
> 

Introducing a worker seems to be overly complicated to me. You could
store the time when heating is expected to be complete, and use that time
in the read function to determine if it needs to wait and/or if it should
trigger another RH read request instead of just reading the RH measurement
from the heater command. Something like
	if (still heating)
		wait for heater to be turned off and measurement completion
	if (heater was active within [select period of time])
		read RH directly without additional request
		clear heater status
	else
		if RH was requested recently
			report previous RH
		else
			request RH measurement
			read RH

This would also help with the heater_enable problem: It would just do nothing
if the heater is still enabled from the previous command (or maybe return -EBUSY).
If there is some additional requirement by the chip, such as that the heater must
not be enabled for more than X% of the time, that information could also be used
to determine if it can be enabled again.

Thanks,
Guenter


