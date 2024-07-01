Return-Path: <linux-kernel+bounces-235544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811D91D66C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0370B212BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145CF4FA;
	Mon,  1 Jul 2024 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G90xGLW9"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD857847B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803024; cv=none; b=HyAsI29vfFLoTRSyMpfe/XwdDqQ3qQajz7ELtgzUyhe5HB7f7jkrc8ODV0Ek3rlzubyYKY8+wDWZsZwMBhbwEhyznOcgGPaJtcM/N03MNjxY+NgjYFqCb2QFa8uvID+fjy+PMm8T+4HOJQ3omkfok6Nj5uYvmlnB0dm8R+n5SeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803024; c=relaxed/simple;
	bh=4G80SnsXT9QeFmG4xTVhGhnOOnBRmchXah5sDWW1lIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVfRS/iHhUjjKJuWX7Vgy2Rofu5rh/Mm02v1nYl1NQZr1hE3cfICjEOJmxW9RYb20d0KszxqZ1y/Jo8WukqUt7mHEDkPTpphLZZ5CFlMj0/DXux+OIwNmqujZw6bS2Rw/dDZ5Lom7YEkGFlIAR4PcUrXnQEee2xx0JkJlJGaxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G90xGLW9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-710437d0affso1235586a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719803022; x=1720407822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hylkKysnQs2URCgI6f4H+azXob1gJRcDJ2yV/tK5m6A=;
        b=G90xGLW9kb8jHLaLq6+c5xRa0ZathjkRLqKgkK97hjOgyMmqMrtlZSgnKHpNIvho53
         zfnjTDL85Xp9aTf1pMk2SPr6sPkV7HeuxrCvJNEM5iOO+6XY3M/I5wLeaqQzAtqV6b0+
         PVafDomDZq4PGOBlQDNTcY5XZhwNtiZVSbCIDoSXuF74nUoKM3lyyB/iiYwbm1Pc2S8s
         1M81i3ORIY8lI4rZRD7LUSpssM96eEE/C8/eOJ5M3CjcxwXQiM8PBGXe0C8RDyf9AyGl
         FkFEYuUdhgjCkBQogrnkLuDDq2DeWVp/7F9nlT8JrPRBsXfqIF7Gnv4XV62Gg05na0MF
         C6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719803022; x=1720407822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hylkKysnQs2URCgI6f4H+azXob1gJRcDJ2yV/tK5m6A=;
        b=scduMfpNPGgNI8rIlQc9GWgy/N2xhPTqSNwBEB74wwyXYsi/1mNxGOesyaChUsNeI2
         Az2PJDFPimVcJ7h7ER8iIBcxGFjKCPZ6pb7Ywo7qQYfnN+V7Kf4L8A6Zdh20WdxAoeV4
         yu+gwHQhDIuKKV8mujWbXlVT/DEDKff0l7DbBulApZGNGzlrXiZH3fUBveaEk46+uky6
         WM7V4FoWs2Jdn9V/+i0RDy416Cd0aSnwDBjoEK+ZtX10sEsuhbps3RGTQS5pkyR6tNng
         qMJeE6x2aqAKepBKTPLz8suqC34OV22aRvquYvcvIQ5VHhk3YkFq09KIG0IiGKLseEjS
         Z8wA==
X-Forwarded-Encrypted: i=1; AJvYcCUoW2/+K9+vquioBuUkMx1n5/olKW0HHw5yEADH9zy2YcxMabJjoMaLEDkiQ6OYzDJuiHZ/QQNfxY59eAKdRH9YAGUpni5q6KjiuZHz
X-Gm-Message-State: AOJu0YzQ5GIGl0uldwxwFuAng43BJc+Hkuvs0PJYKggOOtDGOb7PUF/h
	ky1Dl4/pismDaQgGo1rU/CcyviD4C/tYRUYJ4++cRDBuetTpnyI3
X-Google-Smtp-Source: AGHT+IH6e/ptwM0Xw24RgpyigCdn0UuK5f4uoERcJeojQn8zh/yEM2jskzW7a0hTX7CbMa7Ug9F6YA==
X-Received: by 2002:a05:6a20:7348:b0:1be:bf38:7b1b with SMTP id adf61e73a8af0-1bef61201a6mr3630670637.33.1719803021915;
        Sun, 30 Jun 2024 20:03:41 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac2f03acdsm52584645ad.302.2024.06.30.20.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 20:03:41 -0700 (PDT)
Message-ID: <4418c5c6-60f3-408f-a4ea-8d8ba1cc8afd@gmail.com>
Date: Mon, 1 Jul 2024 11:03:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com
References: <20240628031138.429622-1-alexs@kernel.org>
 <20240628031138.429622-2-alexs@kernel.org>
 <CAB=+i9RSCkYyqo-qXJNRKjUig7s5ZMGWCKmur1nNcD3KkFnhUg@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAB=+i9RSCkYyqo-qXJNRKjUig7s5ZMGWCKmur1nNcD3KkFnhUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/30/24 9:45 PM, Hyeonggon Yoo wrote:
> On Fri, Jun 28, 2024 at 12:06 PM <alexs@kernel.org> wrote:
>>
>> From: Alex Shi <alexs@kernel.org>
>>
>> The 1st patch introduces new memory decriptor zpdesc and rename
>> zspage.first_page to zspage.first_zpdesc, no functional change.
>>
>> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> ---
>>  mm/zpdesc.h   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  mm/zsmalloc.c | 19 ++++++++---------
>>  2 files changed, 66 insertions(+), 9 deletions(-)
>>  create mode 100644 mm/zpdesc.h
> 
> Hi Alex, thanks for your effort in pushing this forward!
> 
>> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
>> new file mode 100644
>> index 000000000000..a1ab5ebaa936
>> --- /dev/null
>> +++ b/mm/zpdesc.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* zpdesc.h: zswap.zpool memory descriptor
>> + *
>> + * Written by Alex Shi <alexs@kernel.org>
>> + *           Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> + */
>> +#ifndef __MM_ZPDESC_H__
>> +#define __MM_ZPDESC_H__
>> +
>> +/*
>> + * struct zpdesc -     Memory descriptor for zpool memory, now is for zsmalloc
>> + * @flags:             Page flags, PG_private: identifies the first component page
>> + * @lru:               Indirected used by page migration
> 
> maybe Indirected -> Indirectly?

Hi Yoo,

Thanks for comments! Yes Indirectly is better. I will update it in next version.

> 
>> + * @next:              Next zpdesc in a zspage in zsmalloc zpool
>> + * @handle:            For huge zspage in zsmalloc zpool
>> + * @zspage:            Pointer to zspage in zsmalloc
>> + *
>> + * This struct overlays struct page for now. Do not modify without a good
>> + * understanding of the issues.
>> + */
>> +struct zpdesc {
>> +       unsigned long flags;
>> +       struct list_head lru;
>> +       unsigned long _zp_pad_1;
> 
> for understanding, I think it'd be better to replace _zp_pad_1 with movable ops,
> because mops reuses this 'mapping' field.

Right, 'mops' looks a bit more clear.

> 
>> +       union {
>> +               /* Next zpdescs in a zspage in zsmalloc zpool */
>> +               struct zpdesc *next;
>> +               /* For huge zspage in zsmalloc zpool */
>> +               unsigned long handle;
>> +       };
>> +       struct zspage *zspage;
> 
> There was a discussion with Yosry on including memcg_data on zpdesc
> even if it's not used at the moment.
> 
> Maybe you can look at:
> https://lore.kernel.org/linux-mm/CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com/

Thanks for notice. 
The memcg_data isn't used for zpdesc. And I have a bit confusion since Yosry said: "I think to drop memcg_data we need to enlighten the code that ...". So we actually don't need to have this unused member, is this right, Yosry?

> 
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index fec1a39e5bbe..67bb80b7413a 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
>> @@ -13,17 +13,17 @@
>>
>>  /*
>>   * Following is how we use various fields and flags of underlying
>> - * struct page(s) to form a zspage.
>> + * struct zpdesc(page) to form a zspage.
>>   *
>> - * Usage of struct page fields:
>> - *     page->private: points to zspage
>> - *     page->index: links together all component pages of a zspage
>> + * Usage of struct zpdesc fields:
>> + *     zpdesc->zspage: points to zspage
>> + *     zpdesc->next: links together all component pages of a zspage
>>   *             For the huge page, this is always 0, so we use this field
>>   *             to store handle.
>>   *     page->page_type: PG_zsmalloc, lower 16 bit locate the first object
>>   *             offset in a subpage of a zspage
>>   *
>> - * Usage of struct page flags:
>> + * Usage of struct zpdesc(page) flags:
>>   *     PG_private: identifies the first component page
>>   *     PG_owner_priv_1: identifies the huge component page
> 
> the comment for PG_owner_priv_1 can safely be removed as it's not used
> after commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
> page to zspage")

Right, thanks for info!

> 
>> @@ -948,7 +949,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
>>                 set_page_private(page, (unsigned long)zspage);
>>                 page->index = 0;
>>                 if (i == 0) {
>> -                       zspage->first_page = page;
>> +                       zspage->first_zpdesc = page_zpdesc(page);
>>                         SetPagePrivate(page);
>>                         if (unlikely(class->objs_per_zspage == 1 &&
>>                                         class->pages_per_zspage == 1))
>> @@ -1325,7 +1326,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
>>                 link->handle = handle;
>>         else
>>                 /* record handle to page->index */
>> -               zspage->first_page->index = handle;
>> +               zspage->first_zpdesc->handle = handle;
> 
> FYI this line seems to conflict with
> bcc6116e39f512 ("mm/zsmalloc: move record_obj() into obj_malloc()")
> on mm-unstable.

yes, a new commit made this conflict. will update this in next version.

Thanks
Alex
> 
> Best,
> Hyeonggon

