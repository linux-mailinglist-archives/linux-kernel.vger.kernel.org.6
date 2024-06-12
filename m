Return-Path: <linux-kernel+bounces-211921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CD9058E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061BEB2654B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E1181321;
	Wed, 12 Jun 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNkfpfZq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D6181306
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210091; cv=none; b=uZI7IuuNLLQ6nwAqV0arRp+yIs+h7IQBuqzlas+ZGOpxQvyb1kWjWy7qRVzL57Kc4ZE2tRNmVKjSNskhESLuXCKyOttA7jHArn0o1u6tA739Tu+55e7wA/7Te2ZizleDJYIoVwLr5X1GibidQIwlGfMP9JLn87M3dqA5t8GZ/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210091; c=relaxed/simple;
	bh=xz2aYF7s/vSmUzBNAYwC6WNY9Tg2z5UGrhYhKernEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5gXiS/zbqjSwu+L8UgIK+dIM1xThYf73re3d8gm35h9urYByAhrnw/Heb4Yv2BSHJuDbasbo9bHkiIjqOSQeUq2Wswx2CpZw3ynOQwCHRrZDDBj0jaY3BoIM+FYFgl4DI6leGSd94EoeH5SV36m6DJt4facXgUShxknsBLEX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNkfpfZq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c72d6d5f3so5643064a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718210088; x=1718814888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtSsz+KOnqb1J9OrnqyEU8J0Ssy5VLPANqhbhuShfVo=;
        b=VNkfpfZqwl23H5PVjxe4N4NMieThuUCIifYys1W4tFieS9yZ/M9N6AUyX9q7UM5xxw
         eqTANJRKCgkHFrgBr5+Mi7uePXYKDQKnboxIakbjAffJogTrGFC5JzXsoM0F5co2s9Od
         3zB/NZ8uG32yP0vKeFfX3EExJrNL6DQjEHVsWitpmcSNQmdChh59d4SAP+iX1wvYsj3n
         4QdJ3G5Yx/h2nE2dYC10boqgm3YYnwBY5pCDN8JugYea/JR2VAyBnqC26XevyoWzpxSZ
         2Nfo1f46pWmz1p/cTmYgd5hWfdpiax7l/p79ChtwPtF6vFpqDb1/qeH2XrdL3rnkp+HH
         JAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210088; x=1718814888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtSsz+KOnqb1J9OrnqyEU8J0Ssy5VLPANqhbhuShfVo=;
        b=WpXX352rDa6i5schfbNLGrB08fyfYiRRryWW310ACFMG8riJN2ANi4pkHHIJiKjUOO
         /71aSFJ1nz3C/jrzIoUVh2HX4MBhJWYFsLIQK4GDHIE6pse1EjqwUpivUNiLmViYtw3Z
         YK6yvlQCglJcllJ2fpv+M6getK/zeLNQF3Pvtf9ZafnMdTyzZr99mjGDbwGthlAAtX5T
         GDNmMcAOLl4TMCBMxxyDdpR1aYSRFtXzvPx8KbTsh9a5lVxoJPa5tRLnq5mwvzDw088L
         1my1s0hAs8fmxxta/eKIO6qQcxJu8f+w1vgAuAYrRkJ61/SmKWd2z/JCLqptkIdJMiiH
         T0hw==
X-Forwarded-Encrypted: i=1; AJvYcCX/DqULgNZUypNRo8EiEP7M/UyC9ejubnWKOhaEgbpLCZK6KeLYP7vu9NT8GdvcHGi/40HdT0yaWxwTYRYekNInnFsaBTxVfGWkR+8/
X-Gm-Message-State: AOJu0YywX90ssLbQ4Y3OK11TIXIILzCaTNTmeSvj8lEIwtBwXLFbeUdS
	bCUbMU37XkQTaL0knJxEALCC8X6tFLSl0Xek1AFt/OUixBGnxjne
X-Google-Smtp-Source: AGHT+IG4uT61eIvoyqMgpgqvyw2H4NUbmEO2X3ZoJOvV42tIdhVbDOeKNtg7d9o2zC8TdNhQcH5fmw==
X-Received: by 2002:a50:9fc1:0:b0:57c:73a7:da08 with SMTP id 4fb4d7f45d1cf-57ca9762e87mr1461728a12.21.1718210087921;
        Wed, 12 Jun 2024 09:34:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:e76f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7cf18193sm6461175a12.50.2024.06.12.09.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:34:47 -0700 (PDT)
Message-ID: <4ed7f644-46c3-4a48-933c-04364c10484f@gmail.com>
Date: Wed, 12 Jun 2024 17:34:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mm: remove code to handle same filled pages
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, yosryahmed@google.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
 <20240612124750.2220726-3-usamaarif642@gmail.com>
 <CAKEwX=Nh4hudrcqj5-a4FhE7kZRTKWZs0aq64b0KPnu3Dm=QaQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAKEwX=Nh4hudrcqj5-a4FhE7kZRTKWZs0aq64b0KPnu3Dm=QaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/06/2024 16:09, Nhat Pham wrote:
> On Wed, Jun 12, 2024 at 5:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> With an earlier commit to handle zero-filled pages in swap directly,
>> and with only 1% of the same-filled pages being non-zero, zswap no
>> longer needs to handle same-filled pages and can just work on compressed
>> pages.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   mm/zswap.c | 86 +++++-------------------------------------------------
>>   1 file changed, 8 insertions(+), 78 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index b9b35ef86d9b..ca8df9c99abf 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -44,8 +44,6 @@
>>   **********************************/
>>   /* The number of compressed pages currently stored in zswap */
>>   atomic_t zswap_stored_pages = ATOMIC_INIT(0);
>> -/* The number of same-value filled pages currently stored in zswap */
>> -static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
> Can we re-introduce this counter somewhere? I have found this counter
> to be valuable in the past, and would love to keep it. For instance,
> in a system where a lot of zero-filled pages are reclaimed, we might
> see an increase in swap usage. Having this counter at hands will allow
> us to trace the source of the swap usage more easily. I *suppose* you
> can do elimination work (check zswap usage, check disk swap usage
> somehow - I'm not sure, etc., etc.), but this would be much more
> direct and user-friendly.
>
> Not *entirely* sure where to expose this though. Seems a bit specific
> for vmstat. Maybe as a new debugfs directory?
>
> This doesn't have to be done in this patch (or this series even) - but
> please consider this for follow-up work at least :)

Yes, would be good to have this . There are 2 things to consider: where 
to put it in debugfs as you pointed out, and where to decrement it. 
Decrementing it will require to test and clear instead of clear zeromap 
at different places, so might be a bit more complicated compared to how 
zswap_same_filled_pages is tracked. I think best to keep this separate 
from this series.



