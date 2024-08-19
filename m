Return-Path: <linux-kernel+bounces-292253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03463956D17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21041F25DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973516D4F1;
	Mon, 19 Aug 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi1CNL9z"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43C16C844
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077368; cv=none; b=SEdinIsazjfEE0THFLqd2JpRbKfRHjtI7944+et2f+2GMUr/P8I7xTYvhtCRESrDFUMpj24O6UAQaFqvXK9g0TxtDjudLdsVDjZCqv67KH71v0aJVHuTdejW97Wm6srTfAMslySFrS6qqhywmzxZpi7M8GfDB1Shft03huAr/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077368; c=relaxed/simple;
	bh=v11Nb6/Y8y/UysALAeY42DDuFkS+2grtMmmrTiJ1E1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/A4mHYrh/zhnuQnVtipnxI/0QgWs7SlBW2/YFbfhpTjOqo+kMvIpDCxtJ0gIfJvP6KgNnAFudc2jTA4ylFxdMKEcBT8hyk+Z0Hv+poaOHib7yooCa99HAWF965qADrNDR01Paih/0SJyIxQa6zgb762bYCATVpmtg+IdVd49K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi1CNL9z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a50313f785so247734785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724077366; x=1724682166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nhkr7iqFh3RzbexiAe8kbSaRnIYZ6ohJ8NbUkCceiNk=;
        b=Xi1CNL9zpvDawaEo1NGNiS2F7v6diq8eeeVNh47ZHvQ81Q7MvOToesUQT2fOdpNg/n
         x530wbTqd6U0ncwrt4Un9npkal4VC+bSuzIU1Y1DItU0BhE46xStHZw6xrQiBZpUZ9U6
         DOvFHvsIA3+O9lqxUlZaFlzSp5wAWosQCztl2F4ZFAn+Q/Z2qNCE3/Qt5PzWQVmyXgQN
         mv5sIcCkHk2G2n8oCaeOSlonyHQsXEdXRXGYhNV9IeXW5rXf++LNVzOhhDlQxzQvVfEH
         d8SLoVK1UMoLOnWpu+wQHY6WFpo5lJ8bGoZPnyDg5HwzxCNNR8Dtq0JKXbgdS/Pu+iCd
         K+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077366; x=1724682166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhkr7iqFh3RzbexiAe8kbSaRnIYZ6ohJ8NbUkCceiNk=;
        b=pa6pOLH4NKkoEIB5t4NpOYJGtSMHBgQUiX3Ft5gUoNKb6XOtAuxkZroJs8K1qyBHpu
         89VFWCYfiRPbOHT9qUc+3hE2Prcce+w1UsmJMpgv4HyMfSZ5GsCqBgJTse74WgQrJ0WP
         oRR6zeOSgNsF858HYleQgQMWTnpqh5tgOFzzUWALzDB933tQv7I0qD0RmzStXDfE6nvK
         C1LL5RUn3Aq8+l8sR897zE4sUPJ8kNRmariDj/uO/Z9/T+27mhpM3ZKqGyVVugWHHNcz
         nH3ACt7puZsg03G+xeTTsBSns+NRbQRnsgh98egjel32ax31thGw+vkxWi5cZL3IfwVh
         laKw==
X-Forwarded-Encrypted: i=1; AJvYcCUjxDgliFz4nmZYIg/hbnleU1jWna6mxCj2UTZLcf2FELKQhdC53fG/VlV5YbQuR+Oz7K3dYbHgQA8/C8G1vgq/zK0K24vnuKatCDf6
X-Gm-Message-State: AOJu0YxIh/F2bOmYegLCuF2b+4fUBsinXwxMOt5ZK6B10gPQJ4TwrYpl
	cgOSXQb5D6cUdIuXzc84OBKweBPdlSiS0M7eNtHr27Sg+ePXmu0w
X-Google-Smtp-Source: AGHT+IHkF23CUAgzsBPLP4cpgRYRq2jqu90osR1mDQck6JGw0rpnWCeZrHevD+ptagafaKP5T3G9Mg==
X-Received: by 2002:a05:6214:5c41:b0:6b4:fea8:6bfc with SMTP id 6a1803df08f44-6bf8949f60fmr88519896d6.10.1724077365747;
        Mon, 19 Aug 2024 07:22:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::7:e1ca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef0267sm42825436d6.113.2024.08.19.07.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:22:45 -0700 (PDT)
Message-ID: <b5f8448a-daf2-44d7-bcad-b66ff2908e63@gmail.com>
Date: Mon, 19 Aug 2024 10:22:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm: collect the number of anon mTHP
To: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 hanchuanhua@oppo.com, ioworker0@gmail.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 v-songbaohua@oppo.com, ziy@nvidia.com, yuanshuai@oppo.com
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
 <c817bf05-a9fa-4fb9-b8c6-a1de5a44e59a@redhat.com>
 <CAGsJ_4xaTSu2_F3VaR7Y3bOz2+W9XRU9kS3j7Hatojc6ocpOWQ@mail.gmail.com>
 <CAGsJ_4y30MVPDrE24okwxi5MYwM6o1ZnK0Vdub+DoEgWnM6+FQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4y30MVPDrE24okwxi5MYwM6o1ZnK0Vdub+DoEgWnM6+FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/08/2024 09:52, Barry Song wrote:
> On Mon, Aug 19, 2024 at 8:33 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Mon, Aug 19, 2024 at 8:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 18.08.24 09:58, Barry Song wrote:
>>>> Hi Andrew, David, Usama,
>>>>
>>>> I'm attempting to rebase this series on top of Usama's
>>>> [PATCH v3 0/6] mm: split underutilized THPs[1]
>>>>
>>>> However, I feel it is impossible and we might be tackling things
>>>> in the wrong order.
>>>
>>> Is just the ordering suboptimal (which can/will get resolved one way or
>>> the other), or is there something fundamental that will make this series
>>> here "impossible"?
>>
>> i think it is just the ordering suboptimal. Ideally, mTHP counters can go
>> first, then the new partially_mapped feature will rebase on top of
>> mTHP counters.
> 
> Sorry, please allow me to ramble a bit more.
> 
> The nr_split_deferred counter is straightforward and simple without the
> partially_mapped feature. Each time we enter split_list, we increment by
> 1, and when we leave, we decrement by 1.
> 
> With the new partially_mapped feature, we can enter split_list without
> actually being partially_mapped. If the MTHP counter series is processed
> first, the partially_mapped series can handle all cases while properly
> clearing and setting the partially_mapped flag. These flag operations
> need to be handled carefully.
> Currently, I notice that Usama's series is clearing the flag unconditionally
> in all cases.
> 
> In simple terms, mTHP counters are just a counting mechanism that
> doesn't introduce new features. However, partially_mapped is a new
> feature. A better approach might be to handle the counters first, then
> ensure that the new feature doesn't break the counter.
> 

I am ok if the series needs to be reversed, I think the difficulty is for Andrew to tackle my series, yours and Yu Zhaos, which all seem to be touching the same code, so whatever makes it easier for Andrew I am happy with it.


>>
>>>
>>> --
>>> Cheers,
>>>
>>> David / dhildenb
> 
> Thanks
> Barry

