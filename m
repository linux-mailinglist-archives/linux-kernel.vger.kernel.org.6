Return-Path: <linux-kernel+bounces-380018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D849AE76B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A523AB26314
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35C1E32AF;
	Thu, 24 Oct 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP0GIMSM"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD311E25FA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778740; cv=none; b=s/sDQ9TMW/Vf6hH64UUtSsCd28CYgrboxCWe0VyLGDxEliD+HJmx4s/dNSvP/MRSLWmgvDaycDNg7j9ZBJ9wcdUe1jYHJvoRglKR0/mqexDdfff47f+Vtqfs6k5QsJxF7uqEst9pQMPEv5MlVkYRIegKU+IHd5aQ4XRGAgo2wTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778740; c=relaxed/simple;
	bh=S3lPUHZxZcitD5vGldNcH8q1olxAVdARqDvzLDhUyfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9jGLpnAxsEeoLXdXmfJlNpDkjQUopzx7BbBd0U1IbRxR4AeL9bCPLNJpztJugNP9lYsDxpn8TU01UgCQje9G3Ymp/YThqRci/T0dY/0Ss7RgWzQQAEy1jm4zzArF1TRD54cs1+j35RPPdWU2PqnR5djUArrRnBiXGYpwH5CbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP0GIMSM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315baec69eso9935465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729778736; x=1730383536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSr0bR4jeW/qu6kyO0At8mOuFzxheAiGNDGN+HknWVI=;
        b=nP0GIMSMG30tc2E37ztnEIrsDmcnh2cT6alI9xmHppIPBdO0rByzal7v6xx7eG4Nca
         gBowBlReZg4n89ilnJEoxwqX8vkCb45LsGLdFf4tiYaFr/tAJHXl0VaHDG/Eev845bxn
         IiTpDkr3XqvXwHBklMoDeB6xWZoyLCxqVqGdjN3LkMsyuZg2zLLi09OkQA2tLE2TebNG
         j7fyWxTMIj704CiNROIu+Q8eXKuhBfQb+qW0Ack+J+UmJT8m2epduo6MUHcigBT1Seuc
         U/4U9g4DPkBj6GoGTI5oGJiwtLeqcYS3nN57nQY5wNZh2KjyWSgl6Txj6rzzFv4DL8Xi
         qIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778736; x=1730383536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSr0bR4jeW/qu6kyO0At8mOuFzxheAiGNDGN+HknWVI=;
        b=ij2RIibR/8K8meNhn43QxWEzmqLpo7GIqhvMkKYy8Ksz56X5d98NClTnyxy6Vb37FJ
         at7dJ4VZDw3ifB7Q39YJ/xRQFsRR165DDDYn3AI47NN0p+mVPTblU0cTEiy7Wg3xiySZ
         8GCIaEKoqN83OXLeR41zBaTViN2r/NzrydqpN7aLPSsFjFSNSkR7XyARU95jxrJD71r+
         961TwVpBHDfkqH/DtR+e3ky0DTR3BzblwftbBL5aej7KYAZNZl9wmULs01Z6UBP417zs
         dgCYi+i7w5nEuZFAFDnF7/MN+UJaMrt8GZ2LNU/c6o1CWqHAKC+Qwrq2/k7A6C49DJnd
         asoA==
X-Forwarded-Encrypted: i=1; AJvYcCUFir3CkFnd4XyHu7JiucWag1x3ws17Qbrn2PN5cIMV9UPBxHnZeqR1976b+RYA28g685UsRk4zIgIfprc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhSDSR49nLBiBGh2YzGhjEWIp5Ql1AR69gC7Fgbi+qhnmZEbm
	ddZoFIpfYai7OEIvQuBlFi+6bwT6beN6MgTzWAlH0D/mmXibJqoN
X-Google-Smtp-Source: AGHT+IGSFO1aZ78o1YBUyhJmGM3h2q+RJq7aOXte960dZQYLamOXgiV21UZq3FsDxN0JL9SBebA+lg==
X-Received: by 2002:a05:600c:5802:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-431841ee182mr47961375e9.4.1729778735662;
        Thu, 24 Oct 2024 07:05:35 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.34])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186bd693fsm49008385e9.2.2024.10.24.07.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:05:35 -0700 (PDT)
Message-ID: <363880be-dfa3-4cfc-8d7d-613092c36dd0@gmail.com>
Date: Thu, 24 Oct 2024 15:05:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] dm ioctl: rate limit a couple of ioctl based error
 messages
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241024110431.1906858-1-colin.i.king@gmail.com>
 <51915860-4a32-b563-c000-d64e1df6702d@redhat.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <51915860-4a32-b563-c000-d64e1df6702d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2024 15:01, Mikulas Patocka wrote:
> Hi
> 
> I'd like to ask - have you experienced these errors? What was the process
> that triggered them? Was it some robot that tests syscalls with random
> parameters?

I hit this when running stress-ng's dev test, this exercises various 
ioctls for race conditions.  It's not a major issue, just a corner case 
found when I was running some stress tests.

Colin

> 
> Mikulas
> 
> 
> On Thu, 24 Oct 2024, Colin Ian King wrote:
> 
>> It is possible to spam the kernel log with a misbehaving user process that
>> is passing incorrect dm ioctls to /dev/mapper/control. Use a rate limit
>> on these error messages to reduce the noise.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/md/dm-ioctl.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
>> index f299ff393a6a..d42eac944eb5 100644
>> --- a/drivers/md/dm-ioctl.c
>> +++ b/drivers/md/dm-ioctl.c
>> @@ -1912,7 +1912,7 @@ static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
>>   
>>   	if ((kernel_params->version[0] != DM_VERSION_MAJOR) ||
>>   	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
>> -		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
>> +		DMERR_LIMIT("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
>>   		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
>>   		      DM_VERSION_PATCHLEVEL,
>>   		      kernel_params->version[0],
>> @@ -1961,7 +1961,7 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
>>   
>>   	if (unlikely(param_kernel->data_size < minimum_data_size) ||
>>   	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS)) {
>> -		DMERR("Invalid data size in the ioctl structure: %u",
>> +		DMERR_LIMIT("Invalid data size in the ioctl structure: %u",
>>   		      param_kernel->data_size);
>>   		return -EINVAL;
>>   	}
>> -- 
>> 2.39.5
>>
> 


