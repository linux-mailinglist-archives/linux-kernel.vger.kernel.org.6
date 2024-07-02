Return-Path: <linux-kernel+bounces-237170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A054D91ED07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DCE1F220E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15468168A8;
	Tue,  2 Jul 2024 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcJiD0eA"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05794101E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887965; cv=none; b=JxwEYk54olmRmiBPtpC8XikaxQEWmwTYWhXyTdY+/DSdzEhYRzTb4mHCP9MhGsD7ci9JF5hDwmMODFfIG0hKP4ux6xAfMzQX1PAfFoLnUdQOzoxr+Hkx4+R1/JfpnwIEWW+ioIPCgW9hunneiNe8OPlFwJPHHCS05vbeAepLSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887965; c=relaxed/simple;
	bh=7Z7CIwnVD3fUWHBRwgkTmBi4xTXBf89pQ+Gq77VaXGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1ABgDuZXinfDnmHbKc78nmgNUqEf4c9J+z0fPyUb0nSjYQjnqznwUyN93U3vYK9a+hy6NZXEMbdsa7aU5dEercdXAbJpOUh8WZzP88KX+ud/72w6JpI5Mm/2y3TrM3V/1GB4hpotRVH4zWu5J+fWi8YaBTTF2wVk+vcjUzeEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcJiD0eA; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d55c0fadd2so2332709b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719887963; x=1720492763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3lEWYpEQ0u157KzPKxKmCWgqmP/a8V9vZZyg5+xH9M=;
        b=CcJiD0eAK+9bIzlGN32o36aV67kELYh6gGlulknV70JtTD2W/D+u/LAiZmBAgYCvgX
         96T6bxaJXAp4fE6GgjAJmy0SHW++emfaXeALYjGBSmA5HkfABH1pnoNuGNIA25uMUMQW
         6TV3wiHlO29XUsU64YjmL6BZNEAglxz6L3kPKau0wb9YYaaanVOv3GRXtkP94elIdxes
         oMrKli/xdoFV0tL2yQdGatM3XGffojZNdnXGtauvrnWBx8RGrj2O5Fw2J23dcoZa8BnF
         q9eS5rLWyx+R2iGIhiSK/JO3UvwUunyCYrN+NtVSMly8+tePoVmbrEtVMdLjPclnpLLg
         eU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719887963; x=1720492763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3lEWYpEQ0u157KzPKxKmCWgqmP/a8V9vZZyg5+xH9M=;
        b=NH3dDJU4O12SPeokUfIvfCSM1uNR6pZ9cAkcm0CFoHkVAoWJu6plRIaLyDp314fkPV
         y8/3G5NCa3Y3SYjN+eeqnWkZwRcfpQfcCUwsdty9gxkVC+GFYJA9CAAsHoz1PjIg85fH
         MJWX86m4luiUFoC9yiPw9Wiml4CqHfXwxtmwjIuhwDgoP+Fm9m/RDZCYnleIUTgEeThy
         HVghGBe1bK7S0uv2LRFbs29PDQp7y3/uwv16xHaJJs9oj0ZHzL53dbNoFgKyoMWAdClX
         1zu/84Bh8a369oB/ULifFxOROboN3N11BwdoTRlzDyzPMIUPEq4i7pui0JRnNzkZavB8
         Jh8w==
X-Forwarded-Encrypted: i=1; AJvYcCV0eQMKPcLmebYqqpSJuQl4UbPQfPL0eADHBAev/ST1qbBxLMxKB6+sobAncJ553Ijit0ZNcUjrddI9+8uimSm8SjIthceqEfaAdEXq
X-Gm-Message-State: AOJu0YzBToSGGtSnYu3PZUoe7DE8N2l8yJRz69ZC2s1UymXHJC/RsT/1
	OZCmDOPJSHd68jdIrFC85yGVsv5fhqTw+kdECjWQJtWo7O0RQhyp
X-Google-Smtp-Source: AGHT+IEAXUBXZvanfqBdKOQmDlkM19SZ1HTtLQH73FVrZU6UsVt/2OHVNLMzLFwU5up12rC77vUGHg==
X-Received: by 2002:a05:6808:1a24:b0:3d6:3450:7fed with SMTP id 5614622812f47-3d6b4727127mr8682432b6e.39.1719887962880;
        Mon, 01 Jul 2024 19:39:22 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b584624sm5765279a12.53.2024.07.01.19.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 19:39:22 -0700 (PDT)
Message-ID: <560c58be-4741-49c3-b47b-b154f564d148@gmail.com>
Date: Tue, 2 Jul 2024 10:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, alexs@kernel.org,
 Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com
References: <20240628031138.429622-1-alexs@kernel.org>
 <20240628031138.429622-2-alexs@kernel.org>
 <CAB=+i9RSCkYyqo-qXJNRKjUig7s5ZMGWCKmur1nNcD3KkFnhUg@mail.gmail.com>
 <4418c5c6-60f3-408f-a4ea-8d8ba1cc8afd@gmail.com>
 <CAJD7tkZebGv1Bd+T6u3UL5buf8J9RFh0y_kC0ZJjBRT3NdNOBA@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAJD7tkZebGv1Bd+T6u3UL5buf8J9RFh0y_kC0ZJjBRT3NdNOBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/24 9:42 PM, Yosry Ahmed wrote:
> [..]
>>>> +       union {
>>>> +               /* Next zpdescs in a zspage in zsmalloc zpool */
>>>> +               struct zpdesc *next;
>>>> +               /* For huge zspage in zsmalloc zpool */
>>>> +               unsigned long handle;
>>>> +       };
>>>> +       struct zspage *zspage;
>>>
>>> There was a discussion with Yosry on including memcg_data on zpdesc
>>> even if it's not used at the moment.
>>>
>>> Maybe you can look at:
>>> https://lore.kernel.org/linux-mm/CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com/
>>
>> Thanks for notice.
>> The memcg_data isn't used for zpdesc. And I have a bit confusion since Yosry said: "I think to drop memcg_data we need to enlighten the code that ...". So we actually don't need to have this unused member, is this right, Yosry?
> 
> I think we need to have it, at least for now. When the pages are
> freed, put_page() -> folio_put() -> __folio_put() will call
> mem_cgroup_uncharge(). The latter will call folio_memcg() (which reads
> folio->memcg_data) to figure out if uncharging needs to be done.
> 
> There are also other similar code paths that will check
> folio->memcg_data. It is currently expected to be present for all
> folios. So until we have custom code paths per-folio type for
> allocation/freeing/etc, we need to keep folio->memcg_data present and
> properly initialized.

Hi Yosry,

Many thanks for detailed comments and requirements! 
I'm going to add this member in next version, maybe tomorrow, unless there are more comments for this patchset. :)

Thank a lot!
Alex

