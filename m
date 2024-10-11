Return-Path: <linux-kernel+bounces-361178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28B99A4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0EA1C22F75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2621949F;
	Fri, 11 Oct 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qa1B0Q94"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B5218D6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652371; cv=none; b=KbvV4ZYswrrNOGFP/YaHuC/4Pewf1kL0dM3V/bA9z0XpphJ972Q503gm8NcnXOmo64fvPoPDBe9FKID10nwbu9UD2D4dz1xV39JMNPVTrZ5aC5YPa4OoTVubZV08Zwg27D7rkSEz3HcWuleOaDyoqAzzamNGKd6H57wMo7f7Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652371; c=relaxed/simple;
	bh=my2VxRQrXUGJdn6lj6aDPWYkyYR/YcYNoSYt8mDZti8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dlre0PJpUY+vYw3fTmDjwNzxvA2N2Vza8GVuOfxtess9mXlgvoktkF2uVzMX09bpnLvdAqc17mFoZX0+q10G9xyuQI5xcNRcFpRf4jz24kTNvf8VsA/+BRsa/PwbCy8h8i5dTDU6KzoNEc5EIZHvEWG0i0vs/L+AbrCmSZyuN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qa1B0Q94; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8377fd76196so36526539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728652366; x=1729257166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjBvdCrJy9AjzpnGvNRYO/januDKQlvw/jXh8GXjiJ8=;
        b=qa1B0Q94tEZmPXciEeIRUzIKUDEUfbdJyESpg0jA6inM+mEY6PLdN+8Za19dpaBbds
         pl9Pvakch/lQFyycOeepF3RKQ/6q+eGAWrOoRN1MQWEU4ZHVM7dR3nRKZCYxbHKSUH47
         H331aph3ryzG1dQZX13uhypzul2Vv8XuB6d2RfVLCKzfNl/CHnxCI29UvJ9Da0WPWQPE
         lWjhkIFd6UkERtmwC7RgBqtJhK7GOxpZwjYpfO4Vtdk0zym1VXyR8bfWVXgCbR3LTOA/
         LoBTLQ/KaTpO3KJKvZdNhd8XawF6xySLlkZQ3vfjOKxOAyR5j6rVXw1RVUpPGruB/Nf4
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652366; x=1729257166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjBvdCrJy9AjzpnGvNRYO/januDKQlvw/jXh8GXjiJ8=;
        b=YqHndP5Di3OB6IoHiz6CP7UozbVtSrjZwfLX4YV9aAyZ9zzPNxYTSCzMC0uxVcd4Tr
         KOhyiOh5Ac/x0OC4M5KfJ0v+P3OxmjTpwzvF1ffEmyQdmnKSvkisGLURMcA8tEJVAZzU
         VN3MwaOzz99xNQrV5cLWoIYdNzAPK6HToeP930wT/dUdcT57tds2QnU751ODr8wkDWUl
         oNkxMu9swzybsgzwRhmQmx44gFyaG2Q7ftYXJrVRFgurw8VAhlTyVKRtucyi670xI1dd
         gtXe3k21PZJabdnQKx0AVj0gBGb9jT8Lahl6gNj5JhJQbla3wiUHBwth0wLw97/c1VAs
         Kg2A==
X-Forwarded-Encrypted: i=1; AJvYcCVid0GPEqVupr49gt5Mkl6XVQficSgLA2RVEQtFAC6n/k2kkjKr5E10UZ0hMHiMUBwIr8oAqib8Kqt2uoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vY6t/elpFbwunMVch4VjLjnObz2KqtSVMZ5dSEl1m5u9VU5j
	jjufrZ5etRYT8GmTAM+yn8+gRkBJfVZPGMIIdmkf887c4uk4+mO3BpbQjWZm0lc=
X-Google-Smtp-Source: AGHT+IEtFfHEv9wmZhEEa3otACwtmvnXlmBWNr+mm/Vzer9DqTyJNJvCgM0xkf3v0OQ9WdwaWhkU+w==
X-Received: by 2002:a05:6e02:160e:b0:3a0:4db0:ddbf with SMTP id e9e14a558f8ab-3a3b5f5cd14mr15928995ab.8.1728652366239;
        Fri, 11 Oct 2024 06:12:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9b11c3sm634588173.10.2024.10.11.06.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 06:12:44 -0700 (PDT)
Message-ID: <1b4889f3-3140-4855-8c74-f0c9df7318ca@kernel.dk>
Date: Fri, 11 Oct 2024 07:12:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] elevator: do not request_module if elevator exists
To: Christoph Hellwig <hch@infradead.org>, Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, "open list:BLOCK LAYER"
 <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241010141509.4028059-1-leitao@debian.org>
 <ZwjgrwSw2vUVP2cp@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwjgrwSw2vUVP2cp@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 2:24 AM, Christoph Hellwig wrote:
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 4122026b11f1..1904e217505a 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -709,13 +709,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
>>  			    size_t count)
>>  {
>>  	char elevator_name[ELV_NAME_MAX];
>> +	const char *name;
>>  
>>  	if (!elv_support_iosched(disk->queue))
>>  		return -EOPNOTSUPP;
>>  
>>  	strscpy(elevator_name, buf, sizeof(elevator_name));
>> +	name = strstrip(elevator_name);
>>  
>> -	request_module("%s-iosched", strstrip(elevator_name));
>> +	if (!__elevator_find(name))
> 
> __elevator_find needs to be called with elv_list_lock.

Doh yes. Breno, I just dropped it for now, just send a v2.

-- 
Jens Axboe

