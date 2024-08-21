Return-Path: <linux-kernel+bounces-296040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E071795A4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25344B211A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1BD1AF4D3;
	Wed, 21 Aug 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+DmIQvA"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AED14EC66
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265232; cv=none; b=r658iKk6oNTAAKNEOu0yU3pfImXDyp7EwVgJ1FriOFlj7QPbhIh0jFZpqnJWqdtMHESZUTDpN+NXSmT+LfVz1ZGpC6ucmdNF0Wn1o8M03zLOE7sa/kBaJWo7LQAO7FNKxt0R3eCeiPFVWVc+7eDiiNMLVz/IhuOHCUCQpVRhUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265232; c=relaxed/simple;
	bh=ejBW706/fxpfVahIdA3apLNioyS53P3ulVN0iIYtl58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inaQnLKEZANfpy6TgDeutO1uCUe0OHOEeN2EUSiJAl+XOTSTMDJsEzMlBFDLCet0M9fM6tn76cmxggQBLuBCu9tVp4pkCYdTFvAJtgcj5k4fvsTfFgX1xq7UuPrQ830iJSKi71PJU+HQhSOZ3PNI5kAlJXKV3MyS3FOqQMNC1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+DmIQvA; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-498d7a1f734so344475137.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724265230; x=1724870030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkPLy1f+u1P9VM8tUYo55oFGiMqeB60eu+E98u0669Q=;
        b=Q+DmIQvAKlZTsxao/inIqvlkVASK6hJlEQuKNDGJIqDrhU+HF1EzHUnh6NqZec7K9Z
         g2j+btOEpcXk+iqiGuvZDHRYAukBPh6odCYMo8gewHja8qI+L+dv4+g33nsuTeRft6f1
         mREDJ/7Hhbmkt0RJTucHNN6wKNaMbD/aBlP8irZuQx0TyalIz2rXxNQMuz+tyEQQjSz6
         7O9H+bcGgIQKefbMojXZogajNJGtdKO9U7LOJEld6aW+wRuHltVwOL/pshg9FoT890V2
         7bwneAEIFPmTmpYWq9aE6gvrDlN8Sl2e1dPkH55JbOasE+dzEdNnKIKv71jj1JZ989Wn
         CRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724265230; x=1724870030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkPLy1f+u1P9VM8tUYo55oFGiMqeB60eu+E98u0669Q=;
        b=T9KkPXwSgmtUAl9kDmLPCpVPQ3wnhCTRtKOmN3v9oGSk+japTPSKxldgOW/Qyidut7
         9vbp2dbuEzQaimuM73y5bfs035A2muDm00TPPt3svRy0JiExh9zrXzHV3G8oJGQFAODs
         /jJpj7x3eamaD1a78N0HzOlKNHlR9Qv7doonZVYbTJ0Jbg8PP0QlRNIUweTheN/pwDV2
         IHIweHDhuOYcTVrcS/zmgoin4ytO2JwZ/Ikctg9QmIRGKXoQlLVkqK4XvKKTbOG12Vp0
         +vfoq3JqL9vqOebAZIlFb3eYCroS81dfuLY14soy0Z6D/KWrEMOvAGpt2IRFjA2ajfF7
         Ehlg==
X-Forwarded-Encrypted: i=1; AJvYcCW5nFG/r2wIVdsRoOQwC4DnsMLQzZyPAbYKXxWuaCWpILHy8Rul7IMfzdVcDpup5oNXe2qmwn57ZIzOW5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QlLFoouZ5U5Vl4VnEoTv3SYSTlqbLABo7aZDfO1Cs9xNOS2e
	8f64psDtBAh7ACdk6Kpf87EKsQRSFEH6R0hU5lNuvUZ101xFvpP1
X-Google-Smtp-Source: AGHT+IGjveudB+Kg2dz5OMk2f9JaWyFZ8Dz9cqlG0M1Yidau7P0ija0blJs15KkCG2h6Lym0ajd5fQ==
X-Received: by 2002:a05:6102:3ec2:b0:492:a16e:c83 with SMTP id ada2fe7eead31-498d2f527a6mr4485894137.18.1724265229821;
        Wed, 21 Aug 2024 11:33:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::4:d08d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe4b00bsm63331256d6.65.2024.08.21.11.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 11:33:49 -0700 (PDT)
Message-ID: <0b8e22e0-7ba0-49ac-9e05-8f473b3c8ee3@gmail.com>
Date: Wed, 21 Aug 2024 14:33:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when
 skipping folio
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, yuzhao@google.com,
 david@redhat.com, leitao@debian.org, bharata@amd.com, willy@infradead.org,
 vbabka@suse.cz, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Johannes Weiner <hannes@cmpxchg.org>, zhaoyang.huang@unisoc.com,
 Rik van Riel <riel@surriel.com>
References: <20240819184648.2175883-1-usamaarif642@gmail.com>
 <20240819181743.926f37da3b155215c088c809@linux-foundation.org>
 <29e481af-b5e1-4320-a672-8251f5099595@gmail.com>
 <CAGWkznFLUcyyqW9yGA-Sy6+Y22yqt0C5cWkxZnpq9VarPiH7gQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGWkznFLUcyyqW9yGA-Sy6+Y22yqt0C5cWkxZnpq9VarPiH7gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/08/2024 01:51, Zhaoyang Huang wrote:
> On Tue, Aug 20, 2024 at 11:45 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 20/08/2024 02:17, Andrew Morton wrote:
>>> On Mon, 19 Aug 2024 19:46:48 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>> lruvec->lru_lock is highly contended and is held when calling
>>>> isolate_lru_folios. If the lru has a large number of CMA folios
>>>> consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
>>>> isolate_lru_folios can hold the lock for a very long time while it
>>>> skips those. vmscan_lru_isolate tracepoint showed that skipped can go
>>>> above 70k in production and lockstat shows that waittime-max is x1000
>>>> higher without this patch.
>>>> This can cause lockups [1] and high memory pressure for extended periods of
>>>> time [2]. Hence release the lock if its contended when skipping a folio to
>>>> give other tasks a chance to acquire it and not stall.
>>>>
>>>> ...
>>>>
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1695,8 +1695,14 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>>>>              if (folio_zonenum(folio) > sc->reclaim_idx ||
>>>>                              skip_cma(folio, sc)) {
>>>>                      nr_skipped[folio_zonenum(folio)] += nr_pages;
>>>> -                    move_to = &folios_skipped;
>>>> -                    goto move;
>>>> +                    list_move(&folio->lru, &folios_skipped);
>>>> +                    if (!spin_is_contended(&lruvec->lru_lock))
>>>> +                            continue;
>>>> +                    if (!list_empty(dst))
>>>> +                            break;
>>>> +                    spin_unlock_irq(&lruvec->lru_lock);
>>>> +                    cond_resched();
>>>> +                    spin_lock_irq(&lruvec->lru_lock);
>>>>              }
>>>
>>> Oh geeze ugly thing.  Must we do this?
>>>
>>> The games that function plays with src, dst and move_to are a bit hard
>>> to follow.  Some tasteful comments explaining what's going on would
>>> help.
>>>
>>> Also that test of !list_empty(dst).  It would be helpful to comment the
>>> dynamics which are happening in this case - why we're testing dst here.
>>>
>>>
>>
>> So Johannes pointed out to me that this is not going to properly fix the problem of holding the lru_lock for a long time introduced in [1] because of 2 reasons:
>> - the task that is doing lock break is hoarding folios on folios_skipped and making the lru shorter, I didn't see it in the usecase I was trying, but it could be that yielding the lock to the other task is not of much use as it is going to go through a much shorter lru list or even an empty lru list and would OOM, while the folio it is looking for is on folios_skipped. We would be substituting one OOM problem for another with this patch.
> Other tasks can not get folios either if they can not use CMA after
> the reclaiming even without the original patch. I am ok with your fix
> patch except the 'if (!list_empty(dst))' puzzled me.

The 'if (!list_empty(dst))' was there so that if the spinlock is contended and we are still skipping, then the shrink_active/inactive_list can still use the ones that are in destination, rather then continue skipping.

Both the original patch and this fix substitute one OOM problem for another one.

>> - Compaction code goes through pages by pfn and not using the list, as this patch does not clear lru flag, compaction could claim this folio.
>>
>> The patch in [1] is severely breaking production at Meta and its not a proper fix to the problem that the commit was trying to be solved. It results in holding the lru_lock for a very significant amount of time, stalling all other processes trying to claim memory, creating very high memory pressure for large periods of time and causing OOM.
>>
>> The way forward would be to revert it and try to come up with a longer term solution that the original commit tried to solve. If no one is opposed to it, I will wait a couple of days for comments and send a revert patch.
> I mainly focus on android systems which have no such scenarios as
> server encountered. I agree with reverting it if this fix can not be
> accepted.
>>
Yeah I think the 2nd point about compaction is a bigger issue, we can try fixing the 2nd point by clearing lru, but the first point will remain. I will send a revert for the original.

Thanks

>> [1] https://lore.kernel.org/all/1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com/
>>
>> Thanks,
>> Usama

