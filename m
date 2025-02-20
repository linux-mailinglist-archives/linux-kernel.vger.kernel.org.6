Return-Path: <linux-kernel+bounces-522742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21849A3CE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B39174FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FADE182D2;
	Thu, 20 Feb 2025 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+vzltJU"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5E1401B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010867; cv=none; b=DeojBsAkno/DsxsiMkzFTxxa4hEzhaO4E1AamQIaAxqjqoMchNSIOTxqAh49H9cqWAULw0edmeodNZ9EOl4T57XC2Clod64wQlE6zUe0+EpPgKy3nrEgYENNGJtbJ7Ac9VZzJ9OGLIqtLqS2e5EXzlqtirFWNqd6/bp03rmKPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010867; c=relaxed/simple;
	bh=Vafoa5OwANQEFLxHZMa1sseFFv8SirYpi6Kiu/i7pKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIx2IrBzQwWlsBnKVTISX0O8MxsVOKGwKqvMax5ONyofDhOPGJhnzEVBlnEgEp+1uamWtDLB84cGU8On3ytV1WsyORPupVxtXT56oFDKZIUZA1tXKlgDS7e9uQmd5DhcIBF5//0Wvdi/70oBGuYEFKzawOsEPVT/jTNQxG1r2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+vzltJU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85592116ca4so31133039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740010865; x=1740615665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTXpaO4+K/ihpL6ctYpafi1phHWLap4rLnsZzmvcnEA=;
        b=O+vzltJUlefTFgF7b0RsGfe2O0yWo4bROA9RgBn6DULbR/SABxRcAILlwomCUqPdIQ
         uUBLknsEhlR1/zYLl7b2H44N3Kj08wyx8SYgaExdHNgo2ozuN91xmOG73gJEk7ESfKde
         2xR/p4+dWB+IoCNBAwwlNXhsFvJPbLYn6jsHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740010865; x=1740615665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTXpaO4+K/ihpL6ctYpafi1phHWLap4rLnsZzmvcnEA=;
        b=xVhpYyRwoVTK9VPe4ybybpSxw6WB7HzuKkBX6xJP9yYeRiYu/3VB69drpTtL8T38Nt
         mHRxnRWtROqsxKOn+mMd1Xy5YS/MykzGjX9d85hcfxuS5+QXKseU1veqY5pgL0dGW1+7
         cX8GZ0DrFn4cJpLF9UQz1iZov01YLengjEmGh/I6VlPdNddYjlg5UdNuBH0NEVJ33dsq
         8kVHmzrCy5b0lTmWreBORAe8cc/3RD3qOy5QNIdDylrkBNVgUkZJRawhNH9uI6cjbRBj
         FrzSAwwRlay0y9p6D7aMBlX3QWgSeE8QnpE5ZoJuuVYXoD6M7wQvWE6LnxwwmcT9eqs5
         QfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzDQduGQRrKR4RKSxC6AUKUXGKJF0l8Yc4X7EzbG50OGczkDaHuoJq4D5QlTHiFOtBf1YCDUv4Lcy3CZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrD10/NkTmDgkXhCQlIqrV89pU7kZyqn4DrkpOLCq+c0+4m93
	t3WvLigyyI9sJM2aeCI+rqPyMv3HmuqctzUWBT8cLXWIyyoxCsdzAFioLK9DZFo=
X-Gm-Gg: ASbGncuYIwV/q0kK7X8l8THhxnOwM2J+8u5svN4509VQ5HcPlssVraE5oFdV0EOoEKl
	7YlF3Z2KjyjcyFxAk2IudDzMqzyDR5WwK0C2zfaL5Qi9UGEEno0a7JvqZAKVcQKNTqFJRxyq8wh
	QNMQoVeu25UeKgi2ruwtbkgnHOl3vdyt5gXvHYcrIjyt9dJRlcpzSseprHTMxN/ARYnDyJZkeQ3
	G+keBdoppXIqK05GfpcJH8KL3ZU14o/W5vE/NeeUqJ7cgdVFujNd0m4CfyjtJPAlrVmg20qQbBc
	j1/LA3OvutCLtZTDb6TtQwMq0A==
X-Google-Smtp-Source: AGHT+IGOFm+eurbtjTZib2LsV62SpasWGtB732Q5WFUESbn8UR8ZxF+4k+li7iTbV6abcZaE92X7pQ==
X-Received: by 2002:a05:6602:14ce:b0:855:5eba:4073 with SMTP id ca18e2360f4ac-855b38a3ceemr610560439f.0.1740010864882;
        Wed, 19 Feb 2025 16:21:04 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8559ad419f3sm130237739f.4.2025.02.19.16.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 16:21:04 -0800 (PST)
Message-ID: <5051c252-f1ef-4731-b0cb-fedfcda04d98@linuxfoundation.org>
Date: Wed, 19 Feb 2025 17:21:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vim2m: print device name after registering device
To: Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>,
 Matthew Majewski <mattwmajewski@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250219190501.295976-1-mattwmajewski@gmail.com>
 <ym5q2cpn2lxk7sarylnf4o3ztvtnb47wroxdiibdsp6yz4gt2y@jfyfo2ekmdmj>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ym5q2cpn2lxk7sarylnf4o3ztvtnb47wroxdiibdsp6yz4gt2y@jfyfo2ekmdmj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 14:58, Uwe Kleine-Konig wrote:
> On Wed, Feb 19, 2025 at 02:05:01PM -0500, Matthew Majewski wrote:
>> Move the v4l2_info() call displaying the video device name after the
>> device is actually registered.
>>
>> This fixes a bug where the driver was always displaying "/dev/video0"
>> since it was reading from the vfd before it was registered.
>>
>> Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>
> 
> A Fixes: tag would be great.

Matthew, there is no need to resend the patch. Just send me the
Fixes tag and I will update the repo.

thanks,
-- Shuah

