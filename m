Return-Path: <linux-kernel+bounces-274313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A39947668
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AB51F21A85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572A14A636;
	Mon,  5 Aug 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrFfne3E"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC32149C68
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844535; cv=none; b=Dr9T4W8ei/8iozJ2p8qBW1ijNDahpo9OXXpMuv3e89DQZR6sOrDMkWhW9QiNHizER6x3ZUvmjw42it5JtKvYaJNk1OSDimDOkNxsLiKr0pu7l0cQ0Z+vgg+Fp8GjC3eo6sugDA/W6R+9LpKEeH0dMDEvnodOOcTzWeHjfsNvraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844535; c=relaxed/simple;
	bh=sLXElQcjQ3ttN+DrTuQtsXEZOC4cHKcErHZifpai9M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpGW00Z9r+QvQJuBw7lLIP1hS30vO8AEKasgEJWzlUyaCCUwNA17qfOC8QH92NyrtNgka48xIuDdI7ATb2fTJipv1YALtBuzyiqYxUJ6VYceZxuQScG/QoUyfo0o2MLhE0QUTuvVaVHFPV7mGQSi0eILwuXkt4ntZrgcBniTkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrFfne3E; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso8844428b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722844533; x=1723449333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INBENEtf4sdxfdchPv/wrRAKQhXwHBlUGH6Myn4Hj0U=;
        b=YrFfne3EcSNJe3/SFmD4uOLRln7cgAYpckcZfli3d35Qn/amzbxtYwP76KeP1YxnC2
         pAB5+nmQqXLf0Lt2en6pV3uxuuZfoi/jNgfbS6gGK2MN3y3ONQ86gZxXr+NILfRpaxVK
         cm8z9PM9vFDH8MLIVLLqGxtKVS0Ukb/ldgPqN9U39K+eGe5gHpKZZqp4OknwRG3YxxN9
         wSbS6COzxENADt5QKnPp9OkOZVfxKNEcYISowIug1FWNjYTAHBfx36B+UNbV4C0GFxsb
         eCxfY5CCcKHisxeLrEfsUycDohQqSqjl4qMiHey/hVezSgbST+vVALmZN2ddlfdYnBUY
         WOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844533; x=1723449333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INBENEtf4sdxfdchPv/wrRAKQhXwHBlUGH6Myn4Hj0U=;
        b=Ob80RPKTmAqNzu5ml9Mo7t7DGZUlTBGPQ9w0sC+Ao2AWpZl2Jq3ri/ErfKHEsrVxm7
         P2PVH1GgBKK3HYYW5Vbem7G2FXbmTTssQuHGOTmlFGbblWBeXX7ujoiCBQ5Z1n7aXTsq
         szX/Bt4TXoXPn1AFP5S2VKNVG74SF8B3RzGaoDk4NFAydv2YuvlwcQnVj2tbY8wGmvUC
         aHefBxJAVrYnLPGBGhP/RaUMiMjiBFy2uav4/i+9TMarWKjhs3yvuwykZ42imWNqdcdP
         38j2bj4CUx+vYuFmTJHCi5H29hVxoW68e4Ah9E5kPB1MPqGmpJL0LRpAVVbI62pv9wfd
         zQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVONYpHYixA5++6WWFajbWi1cl3RZmdtOFQznEPSWy1PuGLmZhsl5j5EdFHlsIEV9bAWJ8LYIH9BxMho8QlGJlF0pCoH1Mrj3IpXbUX
X-Gm-Message-State: AOJu0Yzig5M1XF428Bv9ARNauf+OqJ7CPBwc641jNtyUBVU3OWWMbb57
	BtjWOsSn4lV/ifA0GSvnyQVbD6MRtd9s5Qq5ucDkRNtiG1KcFsXa
X-Google-Smtp-Source: AGHT+IEm3Rcm4osaFEAsMYUwXciCtGrImm7N8IUC8MOcp58RnKdugY0jprOQ2qWR6+LenWmhOhIIyA==
X-Received: by 2002:a05:6a21:7881:b0:1c4:a5fe:321b with SMTP id adf61e73a8af0-1c6995820ccmr16935214637.18.1722844533220;
        Mon, 05 Aug 2024 00:55:33 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f59c51sm61401375ad.67.2024.08.05.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 00:55:32 -0700 (PDT)
Message-ID: <aa39c73f-ed97-42be-901b-4730043ca4fb@gmail.com>
Date: Mon, 5 Aug 2024 15:55:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/22] mm/zsmalloc: use zpdesc in
 trylock_zspage/lock_zspage
To: Vishal Moola <vishal.moola@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-3-alexs@kernel.org>
 <66ad2d2d.170a0220.668d3.6c80@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66ad2d2d.170a0220.668d3.6c80@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 3:02 AM, Vishal Moola wrote:
> On Mon, Jul 29, 2024 at 07:25:14PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> To use zpdesc in trylock_zspage/lock_zspage funcs, we add couple of helpers:
>> zpdesc_lock/zpdesc_unlock/zpdesc_trylock/zpdesc_wait_locked and
>> zpdesc_get/zpdesc_put for this purpose.
> 
> You should always include the "()" following function names. It just
> makes everything more readable.

Thanks for reminder, I will update the commit log.

> 
>> Here we use the folio series func in guts for 2 reasons, one zswap.zpool
>> only get single page, and use folio could save some compound_head checking;
>> two, folio_put could bypass devmap checking that we don't need.
>>
>> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> ---
>>  mm/zpdesc.h   | 30 ++++++++++++++++++++++++
>>  mm/zsmalloc.c | 64 ++++++++++++++++++++++++++++++++++-----------------
>>  2 files changed, 73 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
>> index 2dbef231f616..3b04197cec9d 100644
>> --- a/mm/zpdesc.h
>> +++ b/mm/zpdesc.h
>> @@ -63,4 +63,34 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
>>  	const struct page *:		(const struct zpdesc *)(p),	\
>>  	struct page *:			(struct zpdesc *)(p)))
>>  
>> +static inline void zpdesc_lock(struct zpdesc *zpdesc)
>> +{
>> +	folio_lock(zpdesc_folio(zpdesc));
>> +}
>> +
>> +static inline bool zpdesc_trylock(struct zpdesc *zpdesc)
>> +{
>> +	return folio_trylock(zpdesc_folio(zpdesc));
>> +}
>> +
>> +static inline void zpdesc_unlock(struct zpdesc *zpdesc)
>> +{
>> +	folio_unlock(zpdesc_folio(zpdesc));
>> +}
>> +
>> +static inline void zpdesc_wait_locked(struct zpdesc *zpdesc)
>> +{
>> +	folio_wait_locked(zpdesc_folio(zpdesc));
>> +}
> 
> The more I look at zsmalloc, the more skeptical I get about it "needing"
> the folio_lock. At a glance it seems like a zspage already has its own lock,
> and the migration doesn't appear to be truly physical? There's probably
> something I'm missing... it would make this code a lot simpler to drop
> many of the folio locks.

folio series could save about 6.3% object code... Anyway I don't insist on
it. Just want a double confirm, could we keep the code size saving? :)

> 
>> +
>> +static inline void zpdesc_get(struct zpdesc *zpdesc)
>> +{
>> +	folio_get(zpdesc_folio(zpdesc));
>> +}
>> +
>> +static inline void zpdesc_put(struct zpdesc *zpdesc)
>> +{
>> +	folio_put(zpdesc_folio(zpdesc));
>> +}
>> +
>>  #endif
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index a532851025f9..243677a9c6d2 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
>> @@ -433,13 +433,17 @@ static __maybe_unused int is_first_page(struct page *page)
>>  	return PagePrivate(page);
>>  }
>>  
>> +static int is_first_zpdesc(struct zpdesc *zpdesc)
>> +{
>> +	return PagePrivate(zpdesc_page(zpdesc));
>> +}
>> +
> 
> I feel like we might not even need to use the PG_private flag for
> zpages? It seems to me like its just used for sanity checking. Can
> zpage->first_page ever not point to the first zpdesc?

Yes, the PG_private is only for sanity checking now. But zspage.first_zpdesc
are still used widely and must point to the first subpage. 
I believe we could safely remove this page flag, maybe next patchset?

> 
> For the purpose of introducing the memdesc its fine to continue using
> it; just some food for thought.

Yes.
 
Thanks a lot! :)


