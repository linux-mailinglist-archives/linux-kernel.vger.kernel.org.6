Return-Path: <linux-kernel+bounces-436954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A379E8D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8D5281411
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBEB215079;
	Mon,  9 Dec 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZICHNYSW"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AAE189B85
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731793; cv=none; b=NWIwIXu0qjQ5Itan70oEeN8gd+QfPSipD5WkLHFXHH2M7gs71YCgZmnB19UOEjjV0h9axUIFa8MkznSBjEQixiM4YT4X+8/kEiVmwNH1IbKuHQM3JlEukrp70tEjAFrOJdoFm5kcb7HefAxTv3v31cjpHPYCg4L0a6LdP5XUmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731793; c=relaxed/simple;
	bh=bTlUKmsoMOzEvxrGN04YaVbSTksx6eKcaRhQiB6r534=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDRjCZULdZrqz00/qK0aPncUAuEEpBqO7cbOTjA3o0zr0MQj+QBpkL7717NUU7KQFMYtc/J+vAd/N4kFY4TGxMoTSn5Lhd5lKNg3T2+WKntH55ucOhi8ZDSU2+GzFL6JKY8DrR6QwXV3gCcJDYbCJL+qYZ08dapc1M+yFj1gYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZICHNYSW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216281bc30fso19119685ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733731790; x=1734336590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NdQ5O2vQonQclvkjtZYysDW46zSLw/q1gwazzsyZ6s=;
        b=ZICHNYSWthG4tO7PVb241VJ0DaSb/AJ7Sg9tv9OC+zfwNAxLzZa63MNyUMKhcjIa7k
         T97T/IJ/PobXhmdsgUIQ0RR2okCLJm4R/iutKfytTevsRj/lYxkYwZkVqLyXcDo2Fgtq
         iPHluTd7YMIsadTuI1VxyKgbtE55rO2ZjPL/CAXYYdOj1YKwwWdF/IDRrH9u2c/8SZM+
         AlaBpSBUp5xU6aj6mxhO5wGUso3v5Y9wIH/8pN79pHhB6NRy+N2opNiv+bPgRXfQJbZa
         hepyOMagHfurYdxN4PPgecBgSIcp+beC3AyRoZlakotkT1StBiwVTQBWEf0yDJfuBATe
         gHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731790; x=1734336590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NdQ5O2vQonQclvkjtZYysDW46zSLw/q1gwazzsyZ6s=;
        b=gfpv4s9lgKoZRSZM+fEkFy/1xp9jMAo9joJwStkWnNk131X/uN7MmxANh37OAuCYzi
         I2pzynTqGicrppjVipOsIhfTEdsoVv3CToXQxFNpn0aEkeArgmuASZdKx0QuxDBYhFta
         rZu9Z46nlWJCGNiwU0FSAQZYmuORRXvmY3uJolR/wosKAjSndzXlbSq7V1lEkODW1/IV
         pJJ4rXCxGb0xThBlndsc89d/VIor04EmwNE5mCrMH/HnrxsxYyhJgrfs+1KLV+2+UXMx
         A4GmDVDO36Oai/g6UC/k8DBDKBT3HLlZQvkVSr9GalzDpV7j2u64Fc9gClC9eh8+9LyG
         BXHg==
X-Forwarded-Encrypted: i=1; AJvYcCUdp+xwRRkN0qq7laJsBiTy4ehQnKh2MbGdXcAW8rthzI55zmoTpeylYlHJxKYuN36tOAxIS1pBdMZPGnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xnsqI9BvYa4bf+5KcFkQfn9qrJ6HY+XoUgrTyvXNUfS7Yf3Q
	m1I/Xn2URHOGgUJz3jUdXerDbhDKWz1WhcKOT1S7WS+AU2K3YGJqvgNzjdtnKo8=
X-Gm-Gg: ASbGncvNsXTE8Wkj4fiYdz8G/3sIbKRG9GXFKoCrkxDBIysR+FwtM1QCKz22TgInN6w
	uJH30uoFh+PGBJ0cGwI5mGRhr8C+9kXO7LybN43wT0X5pMVeHSg5p78BU+8701HOoBGJ78TZjqQ
	2qmJZTpWgZUm4TcEMcnKR/L50epcwNjpU0r47bTDdVlB8LnkBiZYYbrfqOm7HW4ga3e70Udts9X
	+716icYjvoKsXKx8lZtPFzS4y0h2QIoR9yVA7r6YkytVJ2gPjyPe4K0qcfywKcXtnnd++oarUE=
X-Google-Smtp-Source: AGHT+IHLCoaTt3If3YcXuwHtYWReORVoIyan6nGF09oVg5MCbEhq0REgi++8LMxzHzGkNtjK3fEi0Q==
X-Received: by 2002:a17:902:c405:b0:212:996:353a with SMTP id d9443c01a7336-21614d53f0dmr188429125ad.12.1733731789995;
        Mon, 09 Dec 2024 00:09:49 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0b587sm66633025ad.211.2024.12.09.00.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:09:49 -0800 (PST)
Message-ID: <70f78ae0-481f-4096-af82-fe5a9f131eb3@bytedance.com>
Date: Mon, 9 Dec 2024 16:09:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>
Cc: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>,
 David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
 Hugh Dickins <hughd@google.com>, Muchun Song <muchun.song@linux.dev>,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org
References: <67548279.050a0220.a30f1.015b.GAE@google.com>
 <51849c40-1bd5-49bb-ba2f-15cd06f45f48@bytedance.com>
 <c3379af4-cfc3-41e8-89fb-1ad5292d952a@bytedance.com>
 <CAOUHufZDYmU8cQrwfvVnV3HUrH4aOULniNXvvQVHLsHUjhouAQ@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAOUHufZDYmU8cQrwfvVnV3HUrH4aOULniNXvvQVHLsHUjhouAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/9 15:56, Yu Zhao wrote:
> On Mon, Dec 9, 2024 at 12:00 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:

[...]

>>>>
>>>> If you want syzbot to run the reproducer, reply with:
>>>> #syz test: git://repo/address.git branch-or-commit-hash
>>>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>> mm-unstable
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 83fd35c034d7a..28526a4205d1b 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -7023,7 +7023,7 @@ static struct kmem_cache *page_ptl_cachep;
>>    void __init ptlock_cache_init(void)
>>    {
>>           page_ptl_cachep = kmem_cache_create("page->ptl",
>> sizeof(spinlock_t), 0,
>> -                       SLAB_PANIC, NULL);
>> +                       SLAB_PANIC|SLAB_TYPESAFE_BY_RCU, NULL);
> 
> Note that `SLAB_TYPESAFE_BY_RCU` works by freeing the entire slab (the
> page containing the objects) with RCU, not individual objects.
> 
> So I don't think this would work. A PTL object can be re-allocated to
> someone else, and that new user can re-initialize it. So trying to
> concurrently lock it under RCU read lock would also be use-after-free.
> 

Got it. Thanks for pointing this out! So we should put ptlock_free()
into the RCU callback instead of enabling SLAB_TYPESAFE_BY_RCU for
page_ptl_cachep.

>>

