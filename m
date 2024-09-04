Return-Path: <linux-kernel+bounces-315993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6876996C98E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29DEB22819
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB514901B;
	Wed,  4 Sep 2024 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF1MTSbF"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE405256
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485457; cv=none; b=jaVnlJj1iRzXiEC+6FLccDiT0XHGGLCs2AMhZ2jat2r1ciW2Zezj8N4aVrd4tiocIobFYGvUOm1yW0g0CHQ8AmPsr9HB7OmodAQI9CKgF0FhhgSOqsPk/K8+lexfpxdoHgcLp96bUWT+LMxfc87ml+noJcEbpvt+0l6zoWbXqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485457; c=relaxed/simple;
	bh=/Twejya4ofaV/XGsM8U4QNGFYh7oquMwM5NvGtav5fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sR1ItrSWddesIEYrRWoKzyUctlauAVH0aTCxTgL1iZKRyCMew4LYobg3WYAEVaUh2F6w0b7A46ITwbXlRtdCBpJv3KYjBR7/3vPEBcVJ6kA+wKnWbLI5XJtaUSMOpDYxxJnMYJJ9EixSH9TrluYx21MgxcN1XMvS9QLa2KoB/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF1MTSbF; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so9075317e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725485453; x=1726090253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JN4bE8jclhFv6JirVFyZhIdpQd8kyvfFX4fWNrpVWw=;
        b=WF1MTSbFNQB6uLpQVMMfyPnYhJutpfE49ne5Qfi8fU1W86cCnwglzWj90cZ8g3Puw2
         +hM/YSsaMfX5kRy7Bi/3M8mfSLsXvNcHxRAaVXUP6OeC1uVQpK+oL+UBL9pJNb0Pukhx
         NPZF71eD+Y10gyUP11OpcdD0FpXyVgBMgXZA9GZT4okFbx5XcCDzpvzpcpD6PH0UbEBg
         5LJZX+tuZ5IovME28BfjDfccMM2KweU4P1h9St4PFeqquohc/i84PKRddEJG2FRl9zZb
         RCTG3Rvz9A0XB1Ujs7YkCFkKotE4ObIkkGVlIPMvE2b2iMUVfVKlRXZmlE+puqSjPtan
         eETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725485453; x=1726090253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JN4bE8jclhFv6JirVFyZhIdpQd8kyvfFX4fWNrpVWw=;
        b=NoWENl1qUNqddc+6Oaf5d0eyML5abRhOLANwNi4JFG043ZxIaTy9GVPkz87cjBlLqD
         CQNJRWvm+Bz1PHPV3sCZZbtPvjUytDy86KOu9Erh8FP0fL/XbOqLBd0WjyiD7Er6qL1V
         14Z0Wk1OqjKweSiv57XLbgwjkIcZgfwXU0kP92i0Ws7ez1NtKe1pZY+WY3wRn7b+gVfQ
         /c8epKDBfBEHFCHmkfq0EWziKEmBK86uC0IP8g14ji3vYUkaq5X8Do1Agq4LKlxR+z8n
         H172iAOtJpZ1nhk+clb/Xk2ujkujrC34f925ZdNmDCKlBQMBQKB2jdU8LUe0aAQ8ZA0v
         8aMw==
X-Forwarded-Encrypted: i=1; AJvYcCXgGoK73AarLWCWqpLcLr+w2GJo0uuclB3mbI6FdQ0ojlSEp/gLqDgua26PYju7faXyQlZm5NgvwE4nBV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhehIOzgHTj66xHLq5SYEDX6ZmgPxTytvpsiU+Y/xJCW9zkg2W
	62YKXMukOk3NBgJ2OD2URfHv77zKwJ1/zUzuT/hMvFjB7d9T3thm
X-Google-Smtp-Source: AGHT+IG0tniSQcrQSldmN8MKaTIhxe3baGNMEW4jzewRc3ynPJmCPJHXKqdteOYJPUHfSHcr44zYPQ==
X-Received: by 2002:ac2:568c:0:b0:535:665f:cfc0 with SMTP id 2adb3069b0e04-535665fd186mr2538903e87.32.1725485452549;
        Wed, 04 Sep 2024 14:30:52 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56c501sm352958a12.52.2024.09.04.14.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:30:52 -0700 (PDT)
Message-ID: <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com>
Date: Wed, 4 Sep 2024 22:30:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
To: Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song
 <ryncsn@gmail.com>, hanchuanhua@oppo.com, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, hch@infradead.org
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
 <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/09/2024 23:05, Yosry Ahmed wrote:
> On Tue, Sep 3, 2024 at 2:36 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Wed, Sep 4, 2024 at 8:08 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:
>>>
>>>>> [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
>>>>> [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>>>> [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 00007ffd619d5518
>>>>> [   39.158998]  </TASK>
>>>>> [   39.159226] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> After reverting this or Usama's "mm: store zero pages to be swapped
>>>>> out in a bitmap", the problem is gone. I think these two patches may
>>>>> have some conflict that needs to be resolved.
>>>>
>>>> Yup. I saw this conflict coming and specifically asked for this
>>>> warning to be added in Usama's patch to catch it [1]. It served its
>>>> purpose.
>>>>
>>>> Usama's patch does not handle large folio swapin, because at the time
>>>> it was written we didn't have it. We expected Usama's series to land
>>>> sooner than this one, so the warning was to make sure that this series
>>>> handles large folio swapin in the zeromap code. Now that they are both
>>>> in mm-unstable, we are gonna have to figure this out.
>>>>
>>>> I suspect Usama's patches are closer to land so it's better to handle
>>>> this in this series, but I will leave it up to Usama and
>>>> Chuanhua/Barry to figure this out :)
>>
>> I believe handling this in swap-in might violate layer separation.
>> `swap_read_folio()` should be a reliable API to call, regardless of
>> whether `zeromap` is present. Therefore, the fix should likely be
>> within `zeromap` but not this `swap-in`. I’ll take a look at this with
>> Usama :-)
> 
> I meant handling it within this series to avoid blocking Usama
> patches, not within this code. Thanks for taking a look, I am sure you
> and Usama will figure out the best way forward :)

Hi Barry and Yosry,

Is the best (and quickest) way forward to have a v8 of this with
https://lore.kernel.org/all/20240904055522.2376-1-21cnbao@gmail.com/
as the first patch, and using swap_zeromap_entries_count in alloc_swap_folio
in this support large folios swap-in patch?

Thanks,
Usama

