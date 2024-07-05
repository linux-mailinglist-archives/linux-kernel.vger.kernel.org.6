Return-Path: <linux-kernel+bounces-242801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE47928D58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9C41C2165B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9C16CD0B;
	Fri,  5 Jul 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="feHjoKai"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372667E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203024; cv=none; b=WD61Abl8U9anozTr609ITGsIF5PAjCp8N9zpS3a7Aq4JCipBvJZgpg9JLhER9a5YocDmkvzHI0W5eQ4lA4nnZBKKyK6yyx0IX769NWcBn0yteF9R/S5Oc+UMKzJQ5hXW5VSCocR50ARlqSmnFp2d1j88AuINdw8/CxQhnBYtFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203024; c=relaxed/simple;
	bh=7dKVWzFhqcdwTAHOJrZFlh1/32PUtLe6VOINCqyYYYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exIM8N8LJKM49CZZ8hSxq6EWTTnw5EjifjmLnO2upNJ2fczSrWnH9MnzJ4QJFrJa8uQy7szM596rF1zCfSd7CMbyNVwzqkhuWNxYMx0wj1z4ZV04H5o8uiN5ccqdM3hts3uIdoYVfJ0LCeh5vboLw6OwOVtdrJ3VanM5Dupr3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=feHjoKai; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3745eeedc76so1320015ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720203021; x=1720807821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfT5A5m5TRLHFfKNa8cuOS8hGTJVflloANcGwiwozfY=;
        b=feHjoKaigA4hda6M8oRT38NPslkL20bqHY8XMWCMG1nP7n0degNaJDJXeqW+P7AoP9
         78yy7E/q1sDgBbletxsam+lypwnGdbEQvsqkn45fZfNcu3QJ0PhdgdyEusp4RND1dG+V
         bxZuwMVlSwMp75+oALsrI84iramCI+Dhn+ehY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720203021; x=1720807821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfT5A5m5TRLHFfKNa8cuOS8hGTJVflloANcGwiwozfY=;
        b=Dgtq7QOGIYwOJEhZhWN8AmOFBGuobcd6zChOypwNWacI9Ah0qn/K8MUbIRydz724Hx
         R8quWuZK556Cw6TNNLeEd8pnn8ScH3f+lbAvkIGiZOx+PhH4pGkRNY8uEzzm/Xl91J9n
         IVJKvk5yKzFzkqKh6QZjDonUpdQjFdGF7fj0i/UqWHIXCikCON/TEul7JXdjWHMpBTmH
         o0UVRTBeFdzfWs5FLawiScXuiatfF+nqwAfl7Kljaaapcro8Zo2Hjbz235OsUwc6dmYc
         vCKK4KMj+Kt0P4nQdX0+LOi1KRmzlbua4lwNhG30lP5UKAGSpA4N77K9RfjUCJ1ZOZEY
         7cnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOnF7eloUhg5ybhoHyxLf71cbo1633kVBRi1I2RLKQah69BomCBQ7tjf6PxmRCF9l13HgJJJ8jPAahr3ofDvLYzy7JfRWx4VhmjBWL
X-Gm-Message-State: AOJu0Yz9shV8LAlGFfRCX2AQLVXKZpMNdZnzLWvl2Tl6yZe3r1S4+a6Y
	b/s3fSTiTWOqXv7G9sMb+eJjJTEU0rmhJQmt0VEVRKtMU98hqldWJ/z/q9I8SH0=
X-Google-Smtp-Source: AGHT+IEmjNDu/+i49etUyMQh25KpJihMcsAHI7NWFylJpgwGEGQ9bSlSjqPT+ZyYcP/4mAxoJLiM4Q==
X-Received: by 2002:a05:6e02:13a9:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-383953e23c4mr71729995ab.0.1720203021379;
        Fri, 05 Jul 2024 11:10:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f41329sm38763435ab.50.2024.07.05.11.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 11:10:20 -0700 (PDT)
Message-ID: <38852b52-7ea5-431a-b946-b0dc6bb54e7d@linuxfoundation.org>
Date: Fri, 5 Jul 2024 12:10:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] selftests/mm: remove partially duplicated "all:"
 target in Makefile
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
 <20240704023324.83564-3-jhubbard@nvidia.com>
 <9b59fc84-2d78-4304-9f39-3a495e438af8@linuxfoundation.org>
 <da35faba-b6c7-42bd-86a1-57328ebc9ad8@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <da35faba-b6c7-42bd-86a1-57328ebc9ad8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/24 11:58, John Hubbard wrote:
> On 7/5/24 10:53, Shuah Khan wrote:
>> On 7/3/24 20:33, John Hubbard wrote:
>>> There were a couple of errors here:
>>>
>>> 1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
>>> to be built. However, lib.mk already does that because it assumes "bare"
>>> program names are passed in, so this ended up creating
>>> $(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.
>>>
>>> 2. lib.mk was included before TEST_GEN_PROGS was set, which led to
>>> lib.mk's "all:" target not seeing anything to rebuild.
>>>
>>> So nothing worked, which caused the author to force things by creating
>>> an "all:" target locally--while still including ../lib.mk.
>>>
>>> Fix all of this by including ../lib.mk at the right place, and removing
>>> the $(OUTPUT) prefix to the programs to be built, and removing the
>>> duplicate "all:" target.
>>>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>
>> Why does the summary say mm ?
> 
> This is a mistake. I was also preparing some mm work at the time,
> and typed the wrong thing.
> 
> Could you fix it up to s/mm/vDSO/ for me? Or if it's easier, I can send
> an updated patch, let me know.
> 
> 

Send me updated patch - it will be easier that way. I saw the note
about getting these into 6.10 - As soon as you send the patch I will
apply them and send them for 6.10

thanks,
-- Shuah


