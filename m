Return-Path: <linux-kernel+bounces-335178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF097E248
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D121D1C20E36
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ECFFC08;
	Sun, 22 Sep 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ4kosgc"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B7B652;
	Sun, 22 Sep 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018580; cv=none; b=MvI3srfMXLQ1fLAw22an3mvcT/4otMTzC40Wt+FBbZBSrrpi5bMg6awRPKlkZA1oBP8BMXJTCp5kHmh+6d0od2kFM5ujbghuu5/0QOd8GcYXO6QasrNRLZ+ifOWDuYXrmdtvdI0FR1fIwfpva+sBj6elNsSvMr1BjEvV7ZK/3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018580; c=relaxed/simple;
	bh=vEks30XG+J2MzciQrA/QX7ue128ALxFN/tguqw4FM2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/h6ws7zahXCaKrwIciuSQlpL4orit1QBTCIVrj5/7ZhdThNcJA9g3Z+SYlwRsYV8EDAvA8hSxT5rurK57rNBrNa4t244XzwYROMrEVU0mrQ/KrVae7ckP8h3cZBlIDwzaNAacInKYm/ooQQu9vHjeGhfKXNVKpi1QNp/qE4/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ4kosgc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-713aebfe8b8so295672a34.1;
        Sun, 22 Sep 2024 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727018578; x=1727623378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0rK5v0Q5x3GJhtFt709TlT+VjbeaoHoLjvE3G3gB9o=;
        b=EQ4kosgcIP29jkqqGgcLkJ0Wq5ZRasN/N58rY9KvDQKiboT8P9n63rx0AREqNF7eCy
         TIU+ncGat3iMwsRktrG7cDoZcu1w57MGAPmpuxKqyzyGzgUHG+8Udu8Wi627Fzu6loWa
         HbGBagT7zQTrLApWXR4d4OtHcLVl6cp1Y21pwOlRfunOvkEy3eHRKwZ1u/svPmMU3ciq
         jUsePvM6oG7i61IUzMKjz0jDrCSSw3Mobm8tOSWt6G/0aIP9Df7PPhR1Grv7JXVsFqIC
         BbISJLGovaXxlcf23APWhtWFCE8znRicFiSooi5OZv9JPfNI2C/1k7SeiaJsNrorC/G6
         NczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727018578; x=1727623378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0rK5v0Q5x3GJhtFt709TlT+VjbeaoHoLjvE3G3gB9o=;
        b=CuqpxGhFSTg608ufrrLP2xj0YILbkDxfdkz6zanTx3O2CpXBUWKLZhQtkTpaxldWyJ
         W/RcnbXgLAWzoHcD6Yi0svC/ttj7d/agUqLjjNF3yDRUpZzh/0RbmjPNJga4DKDO0Pb4
         k+TRE0NOaadBKQUPR+Fkw1QRZd5vkGjcQQUJhsi9hu7pR5f8JwIktXv7vKJyrflBpYZM
         q7PnQpl14lZfNzqgc4YoI+Ru2K0/M2hrYfgxQIWsWE6g8ej1Cuw0QCAnfFo7xU2/a+Sc
         Ku+n5P4uaPC4/SNCxiUjJlyBW4aw+SAk5nt6H5Hp/pCFyy/Tz2DJ+Xlcr75thkFjCNe2
         DikQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfm/mXwczk692SOk0aud0buOcZQmqkS2XXMNErSLZVfkdwiqt10sxIQlWwCL69h9Qk8pJF6JbuYIJmBkrz@vger.kernel.org, AJvYcCUr/uKxiF5Wdb0hi5eq1kDxVL6JUslWhwcCUPRBoQdERiKgjx3fJ8qe2JN650XkyQd3vsZ6Amj6hRfXHctshSA=@vger.kernel.org, AJvYcCUrqFRveh4PcsX7wV3/5+1YzmVH0Z841LKTuzye4sHKCm+XNHERldhwCe/WNsxeuXu6lAhZ4zu1KcQ=@vger.kernel.org, AJvYcCXAUTTKN3idRNfsa8zblUFOAZZCKY+1D4HF14sh2sfMoVORbpO4wJ8zVsF1pj6WBP3XB13CzR6KP7mw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7t5dlI4BEh2cGJKtrJDbMqSP9nNGxQ7AVZW5aLnLKF+88+9HC
	7plm2H9+6gAltSEzTaJt6qD1OUR1PGJ+Y5Mn7tDDgxTl4luvwDjU
X-Google-Smtp-Source: AGHT+IENQHPBnNnxGrZL657GF5Q0NATAuF6B3WDHGqqmXLVTCWJK8uRt0HBsBkTQVDSfIAt1300t3w==
X-Received: by 2002:a05:6830:4124:b0:704:470d:a470 with SMTP id 46e09a7af769-71393557ff2mr4484784a34.28.1727018577674;
        Sun, 22 Sep 2024 08:22:57 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71389bb318csm1646334a34.59.2024.09.22.08.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 08:22:56 -0700 (PDT)
Message-ID: <f6fd25ce-5eb0-4c3c-927c-ac6022b3c21f@gmail.com>
Date: Sun, 22 Sep 2024 10:22:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel-docs: Add new section for Rust learning
 materials
To: Dirk Behme <dirk.behme@de.bosch.com>, corbet@lwn.net, ojeda@kernel.org
Cc: alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, bilbao@vt.edu
References: <20240913153824.161150-1-carlos.bilbao.osdev@gmail.com>
 <3a421753-07fa-451a-90fa-e04d1a731b1a@de.bosch.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <3a421753-07fa-451a-90fa-e04d1a731b1a@de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/24 00:33, Dirk Behme wrote:

> On 13.09.2024 17:38, Carlos Bilbao wrote:
>> Include a new section in the Index of Further Kernel Documentation with
>> resources to learn Rust. Reference it in the Rust index.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>
> Many thanks!
>
> Two minor things below. With these:
>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>


Thanks! will add fixes in v3.


>
> Dirk
>
>
>> ---
>>
>> Changes since v1:
>>   - Added two more Rust blogs proposed by Dirk Behme.
>>
>> ---
>>   Documentation/process/kernel-docs.rst | 131 +++++++++++++++++++++++---
>>   Documentation/rust/index.rst          |   3 +
>>   2 files changed, 123 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
>> index 55552ec4b043..b56c2adcb954 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -72,17 +72,6 @@ On-line docs
> ...
>> +    * Title: **Learning Rust the Dangerous Way**
> It looks to me the that it is called "Learn" and not "Learning"?
>
> ...
>> +    * Name: **Linux Plumbers (LPC) Rust presentations**
> Here I would add the year "2024" somewhere. There have been previous 
> LPCs and most probably there will be some in the next years ;)


Thanks, Carlos


