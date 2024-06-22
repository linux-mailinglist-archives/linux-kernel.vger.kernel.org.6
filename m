Return-Path: <linux-kernel+bounces-225832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2619135DF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B721C2235E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E34C634;
	Sat, 22 Jun 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPh5KLbP"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCC224DC;
	Sat, 22 Jun 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719085396; cv=none; b=ORkPe5n0iBcvTzOsIYWXYm/fteQoh49W9nritSVwk4a46g0ha5HHnaA5s9OFNuGUaW6LHmRSSRkUL1wNRXSX4i4V1fOolV/KL94Cxu/efYxinQOfMqcT7AagZmOySbY1hYml+53LZ9QvZDyd4dbI1+GYQxwzweLz/rsKV2Gxj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719085396; c=relaxed/simple;
	bh=dQldVRC72cr0XyyBUwZo1OZNeKQ164uIQyFzWO+bCh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gor0pn7xcNiyKWapuSHG+t97OeMF4thilp3Wm5mYBzx0I1L28JsVyWDbiTOj+aE9CsnZmSBwIxtSG5YeYsMNGWhHoFXxItZCey78g2byD+hizKV8bCNeAAzL6du9Se1Ze5fQr101UYlfM4j6xyEeERcQqj85zrRzuf3FfZZ+KYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPh5KLbP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9c36db8eeso1575592b6e.0;
        Sat, 22 Jun 2024 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719085394; x=1719690194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQldVRC72cr0XyyBUwZo1OZNeKQ164uIQyFzWO+bCh0=;
        b=TPh5KLbP68xgF6aW+t9wthYfMbWEe7BqfIjcdEhTe155sE55x/y6ngxOqPteovlDN4
         uciv6lLzHLdatu5Jdug9lDSch27kCUxcbM4t2KomzEDZdpYzCUD9yHnQbeviwaKh2C43
         mw6z0tYmB/OLPCkISd5lakle39SM1CQ1dxNdES+EQ1sDuSy0R8nVaN+txm0EfSH3DKVY
         AFgehSg05mpu8EcKSgU9Y82SuaabCFhEw4Xy/47mIXAiOv+HRGkdG+rtRLUEOFFuvZ9t
         75xmJscrUNR/A3+KEylXBixWW/vc2M/DVFmjC11pM8zdBVJVcraGeHXCepBhNaF7CKgH
         Y04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719085394; x=1719690194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQldVRC72cr0XyyBUwZo1OZNeKQ164uIQyFzWO+bCh0=;
        b=jjN0tGsPOfAqaoBl7DkQGkb97WdDFznmukXcVsdc/a/vVaqyBo7MXJxVJfjnv5W0l8
         rxX7/mlrk/8enBESK6wpXoF8SGJKZWKv5w/EfeBOD18ZDhtzPSDcySKHUkP6cLKuEV3j
         QFifL9Uabc3dJuWLBCrYz6wu8MBCI21xSmXd+S1OnWkZfAMrbgBsE9fDuRN8ZyYu9oea
         e6oz6xygzQEXcFwtvjQcozQlUovlDOxMCSIipQ21YJkZ58sT+dtac+WoHnkhTkt7ydNE
         BKAS/JWyCnXwCkqPWbjcij1wJMVZxgvTw7rttBI1ptTcGiBazEmwVEouaPdg3fULba75
         uydQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1mZLo4qy08s5LXlJuChh2JcK1OhSsmxae9py7h+nM4/odouUqA2YFF7kzZXpFfovuBEOCkoatvtSMqO6tnaYtCJOPRJO44LQ/Y5zH
X-Gm-Message-State: AOJu0Yy0dOCNar64cJW/xQRV61dVjA7KURiIWuc4GwSVjVqDBBeZWpf/
	ABmReJhJkG4849VfBMj1WqmwzycXBDhZseVR8+MeDgqXuUR9f3ud
X-Google-Smtp-Source: AGHT+IFSSP3/nKGqql/NzQuA/ILxzOfYTe/dPTzOtB6zHTvnitqSkhHgbj2MP5e3mT46JSDwRJBQtg==
X-Received: by 2002:a05:6870:d20a:b0:254:a2c2:d3cc with SMTP id 586e51a60fabf-25d06bd771fmr729249fac.19.1719085393740;
        Sat, 22 Jun 2024 12:43:13 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7009c60833csm694706a34.46.2024.06.22.12.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 12:43:13 -0700 (PDT)
Message-ID: <e6bf0675-f542-482d-a861-000772b1d10e@gmail.com>
Date: Sat, 22 Jun 2024 14:43:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
 <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
 <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello folks,

On 6/12/24 17:17, Randy Dunlap wrote:

>
> On 6/1/24 8:03 AM, Carlos Bilbao wrote:
>> Extend the Index of Further Kernel Documentation by adding entries for the
>> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
>> on the second edition of Billimoria's kernel programming book. Also,
>> perform some refactoring: format the text to 75 characters per line and
>> sort per-section content in chronological order of publication.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>> ---
>>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>>  1 file changed, 44 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst
>> b/Documentation/process/kernel-docs.rst
> The 2 lines above should be on one line, but fixing that doesn't fix everything.
> 'patch' still says that it's a malformed patch.
>
> Carlos, please check Documentation/process/email-clients.rst section on
> Thunderbird, especially for line length and line wrap.
>
> I'm still looking...


I followed the instructions for Thunderbird but atm I'm tired of trying to
make it work. I'll just go back to using 'git send-email' for patches. I'm
resending this patch like that.


>
>> index 8660493b91d0..6f3e290abd22 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -3,27 +3,27 @@
>>  Index of Further Kernel Documentation
>>  =====================================

Thanks,
Carlos

