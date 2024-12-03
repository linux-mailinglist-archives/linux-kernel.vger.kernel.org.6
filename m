Return-Path: <linux-kernel+bounces-429608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FFB9E1E84
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F495284DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0111F1302;
	Tue,  3 Dec 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbvYWHwv"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF731F12F5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234336; cv=none; b=bt0G5X16dr4ikm3JlEnUgH64yb9cHpTaRrfOj7R4/ac6EIRJVJSihehMX+b/CjQN8mSGFd5E9dNwFiSQh1iv/pqPK5aB36LJM897+7UixBxAAyj9wCuuWSfGg+PqX7Hr7TgSe/bmCqtirZvnTXoZ+h0EFi/A8mhNEscqXe1a5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234336; c=relaxed/simple;
	bh=6dEqPUs5K4bB2dQUyVBwVGzoJYQNt9tuDsj42WejH0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0U2q2FTkDCxEJ7savo4EbKQ/gyPQiOgcy5jLsQY9A/lVQvk6A0aumNeQoAsWwCkU5G+syyOy3u09FILmsYlTWh9Kdz/m+ex9vpaKXWL2Gt5H1hm4NonJ38PjnNPxQkFD7DBSD2t7P/WsYN9LyvTh46IaO5NRFl31GcbunH0EtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbvYWHwv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eeba477fcaso52094777b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733234333; x=1733839133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82D8O0HOv8JGic0DdXIn0oOsVY3gzgfEUZJmdO7wrkQ=;
        b=VbvYWHwvn/T8J0nJ2Fm7JRr3CUEl5AzuaAuuhRqXzMPwkxx8FI8X0Rj+vdtYIllQWp
         2GvIEPAI6CBhjBSh1DG0EVqveSO6SokYOGToeJH7krz40jyasWByoYtoUTbddAOUfFUH
         M/XDYXCV+FNWO65OiMy2bV58xCXdwXg46frmd2egt2GnO/DGlVshBHhZPJASR/K2/v56
         ImD+yWIZc+qXmZYNSgmY54dX1r0N52X2ikCMo7sRX1kPEUTVqYs1l5XxItZpUfXaVB5s
         TqZkZqDY2P2akT7XoI4npLLm/A53lOhDHZPmi0Ro3Ga+QxaDP+JPDOvqHZ2/buSTDYXb
         ZcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234333; x=1733839133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82D8O0HOv8JGic0DdXIn0oOsVY3gzgfEUZJmdO7wrkQ=;
        b=SaKQeZl7XEHJlvFWl9FFSTxZy4rCU1KcvOwiZsdQ0ZJ6m/0Q0R2P9hzpHIzMFKdKN5
         ULvp21Ai4IVeE1lYr1ZLvG5U/ajytgtdBWBVRPHMi6nntjG09ZgAaWUk9RxSnkE2UC2B
         30iP8S2gRFr/kbWTpEOoumQcR/9gxoOvWcSd1DsZVRoIKcqXIcqYklGgKnrg3EkE4zMh
         OJDsJiORQqbpK0BLZxGWx3Dqb1qeCZcrIN7aNnVQ8kiEjAaE6+PJSmrEohzD6uBtkCzA
         Dpu3lRk+UKZi1VdlmIMYV2BrKCGpSXI8PtcbRFXMGDz3RCJjtvqjmFO9W854mWUZew7S
         GL+g==
X-Forwarded-Encrypted: i=1; AJvYcCV/uwHLy/5hJi5D32vpGkqhq/3sWGNCM25Fh4wPbo7oiztvnyNJXkXdWpVhJ9K9NY2k8Eep3ghn3uTr/Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC19xA2gRHN5uOhWf/5skInDmJ9fDFcUregykcmwb4WzYRQi1N
	bkgnpZGBqmmm0BtJlsnIsdNMbTs9gtISQwvFYjIUDiTytzJsu7TY
X-Gm-Gg: ASbGncupQWV7cw/n0EPZFBCWbN7X0YOU65aYI0ewIa+8YGDsnMxqzFZhRyYHzDBf57i
	JwGaH1cpiHqv5W70GA0j9Bv5m7+V4CAz/m7UTeIWXd+4aWag6R+dSpSYtJ2JTxXjdjpyk1dcQ9q
	+1pe2665AAhtNfG7+QdS02cC+aXkpr8bSXXLExA+b2j0XscvHsLF2EUbHJvpnjN7VAbKxLHpcPp
	GGYmdzjPToc3CGhRMmsY0ZZDmsRMCN9clQoomRpNr3/BFz7exVBkg==
X-Google-Smtp-Source: AGHT+IFapS3M8R2hWUiWN5geS60S69v4zurEsMeAIaVtBWniw/Z1YZ7i7lR0HSh4L77K1qboyR8LPA==
X-Received: by 2002:a05:690c:6e13:b0:6ef:a4ec:f698 with SMTP id 00721157ae682-6efad17804cmr34473667b3.3.1733234333625;
        Tue, 03 Dec 2024 05:58:53 -0800 (PST)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ef4db290f3sm27377887b3.20.2024.12.03.05.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:58:53 -0800 (PST)
Message-ID: <8f87ec15-9aaf-47bc-9255-5a6ee721552e@gmail.com>
Date: Tue, 3 Dec 2024 21:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Vishal Moola <vishal.moola@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240902072136.578720-1-alexs@kernel.org>
 <0a10e61b-f0e6-4423-996c-7884c93af65f@gmail.com>
 <66d8bd3e.170a0220.18832.0206@mx.google.com>
 <674e1324.170a0220.377d6f.b6ed@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <674e1324.170a0220.377d6f.b6ed@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/24 04:05, Vishal Moola wrote:
> On Wed, Sep 04, 2024 at 01:04:11PM -0700, Vishal Moola wrote:
>> On Wed, Sep 04, 2024 at 02:54:14PM +0800, Alex Shi wrote:
>>>
>>>
>>> On 9/2/24 3:21 PM, alexs@kernel.org wrote:
>>>> From: Alex Shi <alexs@kernel.org>
>>>>
>>> ...
>>>
>>>>
>>>> This patchset abstracts the memory descriptor used in zsmalloc by zswap/zram.
>>>> The descriptor still overlays the struct page; nothing has changed
>>>> in that regard. What this patchset accomplishes is the use of folios in
>>>> to save some code size, and the introduction of a new concept, zpdesc. 
>>>> This patchset is just an initial step; it does not bias the potential 
>>>> changes to kmem_alloc or larger zspage modifications.
>>>>
>>> ...
>>>>
>>>> Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Willy
>>>> and Vishal!
>>>>
>>>
>>> This patchset could save 6.3% code size, and it's a nice abstract of zsmalloc
>>> memory usage.
>>> Is there any more comments, or mind to give a reviewed-by?
>>
>> Please CC me on future versions. Most of the zsmalloc conversions seem
>> ok, but I'd hold off on further iterations of the descriptor patches until
>> the maintainers decide on what/how this descriptor will be used
>> (i.e. our end goals).
> 
> I apologize for leaving this in limbo for this long. This patchset is a
> prerequisite to shrinking struct page, so we should get this memdesc in.
> 
> I think it's safe to assume (since we've heard no definitive goal from
> the maintainers) that in our memdesc world we want zsmalloc + zspage to be
> similar to how it currently looks today.
> 
> Would you like to rebase this on the current mm-unstable? I'll re-review
> it in case anything changed (and can then give you my reviewed-by).
Hi, Vishal,

Thanks a lot for the review and kindness, I will try to do the rebase in this weekend.

Cheers!
Alex

> 
>>> Thanks
>>> Alex

