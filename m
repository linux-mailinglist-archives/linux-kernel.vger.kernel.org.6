Return-Path: <linux-kernel+bounces-274161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37535947434
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540BD1F21818
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854113DDB9;
	Mon,  5 Aug 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwpTEhkS"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC086639
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830795; cv=none; b=bc/AtTpPu0JeFqKRu0KV3gkDig2HTkrjB30SQRZ/TIHGzwA0PTazBvjPgDejlOgxkhbP7LZszY25wwKvlkv/8Pc3e2prsAzFVHcoK5zHMMW6ClSFkS1GAJAqV4oKPe+CgP+182YGEtPq7YCONEmfH0oJaE0QXM1RL8LWR496y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830795; c=relaxed/simple;
	bh=ehL47d0lsfsYFQhTJBy19hwakABVvILnu9b4raPmBZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMdJCM1F8vfLEZv0a/CtaxM7F6Pd+mnRvdHlyMtuZwLJbWeshyl/VXZNpdLMOSPDgDZEuBDphI49dgs/OMrWB42XWoCboVMFACP72qFnDv9u/FJUEFM7QLGJjsaY/9zcroRolwO2T97KcnOXfzs75WrTCN5o7CGX/S71lcshy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwpTEhkS; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db51133978so3007811b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 21:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722830793; x=1723435593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZz7aCpy1HBA4vgqr6AeQQ+pHA2VfSG/mVzfZbDGy2w=;
        b=HwpTEhkSInA33LQuErP3rMpduIIu1XFbeWFur/AdfsF5Kj2zRMNhhg88cHFint8LgD
         Ne/PCm1HSqAI4deCZJQjzA2tLrfaNQeI1krtG0Rl30WCs0aENjF3Ey140Jeah/RxbOEH
         gnYmYKIfAxbna3HkC1glys5x8rpl6YtSGeF7jg/coybc3hqkhQoaudz50KNjQr7E/ZZZ
         t+551UayC8Ye66fyvuqdo3xFo2woientfX4ud++5CjS6CIzo4z3ltGieXs5i0jxUPZjG
         4xCihUv7Kschl8rR/0r5WesS9rzTeN4jRb7Ci3yAmj0JNS0HPxRWL/gJJUIMH0fgT8k/
         /xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722830793; x=1723435593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZz7aCpy1HBA4vgqr6AeQQ+pHA2VfSG/mVzfZbDGy2w=;
        b=uNugEO8LBjksmr/syiAoTFcBeaUc6GmEvBQihKrDsJvdpC23gyUkPRxs3pa0Q7UUoc
         3oH5E8y664Y+WpQ9iSWH5uP9fbxvyIhiS96hcv8y8byRg0XRweTT7WOqjoar1CGbevPw
         kOkUllFqSavT6oYfwmlbTjygBj0bPVA8/FtR49Adh5HyH60qHVHOojmNVGmYkxbkULYp
         nnU8Y3AzlIs4oOp/MgVp7XdH5EQ5WCRDxQpkk4X0YmtlwDo/67dw7Xeuz3gELe4n0PDR
         8yXhCUPthE5HnUUx+rJTKd+EJm37+My9kKToPfMXtjPw4fVYpxwM/g4I6nKP1psjV3bs
         m98g==
X-Forwarded-Encrypted: i=1; AJvYcCV9FrQ15/kwQhXkUo39ixdz1Wd5hYgGeajgkBuxqcAVXzVWRlZl5ODUkbtZuswhRa5WNbvjz+RLJlDE9imp4m4fbZLTgTlqoEMfy+gf
X-Gm-Message-State: AOJu0YxgzOWRwPf6dOCXXMWUDC7TdGhDUy7Jen2WbCaOuN2sY5fADv7G
	fEc1KrRnicJBS5opDZphFVvadgyO31jvVF00O1f1Fn8Ezxqbfl5E
X-Google-Smtp-Source: AGHT+IH8H2t6d728eqQpqYiPMm504erXGDTfSuZO4EiKAu+wRv6YWmsqgS+1YvbU9xciFQx6HxYySQ==
X-Received: by 2002:a05:6808:23c4:b0:3da:b3b3:191 with SMTP id 5614622812f47-3db5583db96mr12607801b6e.48.1722830792795;
        Sun, 04 Aug 2024 21:06:32 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654beb4asm3846714a12.88.2024.08.04.21.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 21:06:32 -0700 (PDT)
Message-ID: <c591405b-3034-4a55-8664-e0c8ea393b79@gmail.com>
Date: Mon, 5 Aug 2024 12:06:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/22] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Vishal Moola <vishal.moola@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-2-alexs@kernel.org>
 <66ad2ad7.170a0220.3a8e93.6a32@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66ad2ad7.170a0220.3a8e93.6a32@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 2:52 AM, Vishal Moola wrote:
> On Mon, Jul 29, 2024 at 07:25:13PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
> 
> I've been busy with other things, so I haven't been able to review this
> until now. Thanks to both you and Hyeonggon for working on this memdesc :)

Hi Vishal,

Thank a lot for your comments!

My pleasure! :)

> 
>> The 1st patch introduces new memory decriptor zpdesc and rename
>> zspage.first_page to zspage.first_zpdesc, no functional change.
>>
>> We removed PG_owner_priv_1 since it was moved to zspage after
>> commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
>> page to zspage").
>>
>> And keep the memcg_data member, since as Yosry pointed out:
>> "When the pages are freed, put_page() -> folio_put() -> __folio_put() will call
>> mem_cgroup_uncharge(). The latter will call folio_memcg() (which reads
>> folio->memcg_data) to figure out if uncharging needs to be done.
>>
>> There are also other similar code paths that will check
>> folio->memcg_data. It is currently expected to be present for all
>> folios. So until we have custom code paths per-folio type for
>> allocation/freeing/etc, we need to keep folio->memcg_data present and
>> properly initialized."
>>
>> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> ---
>>  mm/zpdesc.h   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  mm/zsmalloc.c | 21 ++++++++--------
>>  2 files changed, 76 insertions(+), 11 deletions(-)
>>  create mode 100644 mm/zpdesc.h
>>
>> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
>> new file mode 100644
>> index 000000000000..2dbef231f616
>> --- /dev/null
>> +++ b/mm/zpdesc.h
>> @@ -0,0 +1,66 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* zpdesc.h: zswap.zpool memory descriptor
>> + *
>> + * Written by Alex Shi <alexs@kernel.org>
>> + *	      Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> + */
>> +#ifndef __MM_ZPDESC_H__
>> +#define __MM_ZPDESC_H__
>> +
>> +/*
>> + * struct zpdesc -	Memory descriptor for zpool memory, now is for zsmalloc
>> + * @flags:		Page flags, PG_private: identifies the first component page
>> + * @lru:		Indirectly used by page migration
>> + * @mops:		Used by page migration
>> + * @next:		Next zpdesc in a zspage in zsmalloc zpool
>> + * @handle:		For huge zspage in zsmalloc zpool
>> + * @zspage:		Pointer to zspage in zsmalloc
>> + * @memcg_data:		Memory Control Group data.
>> + *
> 
> I think its a good idea to include comments for the padding (namely what
> aliases with it in struct page) here as well. It doesn't hurt, and will
> make them easier to remove in the future.
> 
>> + * This struct overlays struct page for now. Do not modify without a good
>> + * understanding of the issues.
>> + */
>> +struct zpdesc {
>> +	unsigned long flags;
>> +	struct list_head lru;
>> +	struct movable_operations *mops;
>> +	union {
>> +		/* Next zpdescs in a zspage in zsmalloc zpool */
>> +		struct zpdesc *next;
>> +		/* For huge zspage in zsmalloc zpool */
>> +		unsigned long handle;
>> +	};
>> +	struct zspage *zspage;
> 
> I like using pointers here, although I think the comments should be more
> precise about what the purpose of the pointer is. Maybe something like
> "Points to the zspage this zpdesc is a part of" or something.

I will change the comments for this member. Thanks!

> 
>> +	unsigned long _zp_pad_1;
>> +#ifdef CONFIG_MEMCG
>> +	unsigned long memcg_data;
>> +#endif
>> +};
> 
> You should definitely fold your additions to the struct from patch 17
> into this patch. It makes it easier to review, and better for anyone
> looking at the commit log in the future.

Thanks! I will move the struct part from patch 17 here.

> 
>> +#define ZPDESC_MATCH(pg, zp) \
>> +	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
>> +
>> +ZPDESC_MATCH(flags, flags);
>> +ZPDESC_MATCH(lru, lru);
>> +ZPDESC_MATCH(mapping, mops);
>> +ZPDESC_MATCH(index, next);
>> +ZPDESC_MATCH(index, handle);
>> +ZPDESC_MATCH(private, zspage);
>> +#ifdef CONFIG_MEMCG
>> +ZPDESC_MATCH(memcg_data, memcg_data);
>> +#endif
>> +#undef ZPDESC_MATCH
>> +static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
>> +
>> +#define zpdesc_page(zp)			(_Generic((zp),			\
>> +	const struct zpdesc *:		(const struct page *)(zp),	\
>> +	struct zpdesc *:		(struct page *)(zp)))
>> +
>> +#define zpdesc_folio(zp)		(_Generic((zp),			\
>> +	const struct zpdesc *:		(const struct folio *)(zp),	\
>> +	struct zpdesc *:		(struct folio *)(zp)))
>> +
>> +#define page_zpdesc(p)			(_Generic((p),			\
>> +	const struct page *:		(const struct zpdesc *)(p),	\
>> +	struct page *:			(struct zpdesc *)(p)))
>> +
>> +#endif
> 
> I'm don't think we need both page and folio cast functions for zpdescs.
> Sticking to pages will probably suffice (and be easiest) since all APIs
> zsmalloc cares about are already defined. 
> 
> We can stick to 1 "middle-man" descriptor for zpdescs since zsmalloc
> uses those pages as space to track zspages and nothing more. We'll likely
> end up completely removing it from zsmalloc once we can allocate
> memdescs on their own: It seems most (if not all) of the "indirect" members
> of zpdesc are used as indicators to the rest of core-mm telling them not to
> mess with that memory.

Yes, that is also my first attempt to skip folio part, but I found we could got
6.3% object size reduced on zsmalloc.o file, from 37.2KB to 34.9KB, if we use
folio series lock and folio_get/put functions. That saving come from compound_head
check skipping.
So I wrapped them carefully in zpdesc series functions in zpdesc.h file.
They should be easy replaced when we use memdescs in the future. Could we keep them
a while, or ?

Thanks
Alex
 

