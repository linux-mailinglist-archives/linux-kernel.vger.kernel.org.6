Return-Path: <linux-kernel+bounces-361009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36899A252
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910721F267F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126321643B;
	Fri, 11 Oct 2024 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiThJzl/"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFA21500F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644751; cv=none; b=VrrgV6WFGND14w7TZ9vrDuMqW5s2D1XEOfUzxhfY6aWyObYL69DsdYqAYBPE+lgGDFhAvJOOzRK9sAGWrBPMSrxrDuBE2hk7vzIG138fr3N67zOt2e4G8pVAKHOcrOzljelkjQxiGkFYuQdgAOpV+qv6Qj24L+CZ594ROnL/cuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644751; c=relaxed/simple;
	bh=MAT4MJsNqVEX+ttJ14T4MGW7v1Xk3VTTlXvZoIWQKH8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ArrV3u8oUV3T04RVJw45OtKTMJ972se23v5yPlAwLqAuTSl53jJ2WIEcRAO3lyNF1CcOafGnHThUmcWgnHYDc3pb9M1w+zmBUzTB1TQs/ssDR4/CpmMKF+kRsyqfgMResYkpZifvtNq9g60HIgIu7LTmcbtiHvtQpz3+gGIUyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiThJzl/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c544d345cso13891375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728644749; x=1729249549; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lP8AzkLPJlBDrSbaT5Bauc0dziSDSxAksJ1QNpxy4E=;
        b=QiThJzl/Plubb97Zho8tCh+Mc78xR9zt3J5rY+MjclBs6jMjEHVJCmjW7IUpJZHj3U
         vpjnjhkTKZBw9GLWmsVbXtOqoY9xu7dZkTWhpRmoaKGNteOpakA1+qpJuyrtZJJUBeui
         +RlgjTyxlH6mjHfHZrFKEvtyphPKQDRO9PlWepth7PVOrXhbPeFLEU6psj3FHCH/EaLN
         qyqFceZZVHGkwjf6TpYeX6nLU8cfCUaCA/C6VZ/5D46m4yh0dJPyjzqngz9HFdrWbE4i
         tDX9TjKXeJVBId95Gn4kS8dK9DlicA2bi6Nc+mgDk/tl91Deq4F3S+yjiiMjb49DPtaw
         U2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728644749; x=1729249549;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lP8AzkLPJlBDrSbaT5Bauc0dziSDSxAksJ1QNpxy4E=;
        b=IHy8vUS4Y7eD+1/KbEm2C1PA1CGSnw+Obg3fjZ/oMfhIO+lkKZbNU5VL2t89N8kHjy
         0Zk3f3AH55zDFBDsHlyL9hbVFka581Jhn2dVHhijhF5HTJloN6VR6WCwJaU+HSqE8g58
         zsqJP91mWUMU23qKpCvRCBXaTn044DJAU4EYQVGYDm9rETs1FPVdrxDjnf0RfQOyknvC
         o08L1V0+9svzYnfbgcFJTuozaYSI1C/f1K6QcB1dc7LCEQGgQ5SNg3BmsXEHQTQdqTbK
         yjN94K6DYKdkSAG6ItcsvX3+DkEacnc7ptMuIiATgL5LgNrwiYLv2gbmVVsRvuh2PlFZ
         V6RA==
X-Forwarded-Encrypted: i=1; AJvYcCVfptj+oz8QMJ3z742gjNiLixOH9vBiZ2075Pd/l46KUYRI7IG/wfMmyvb5yiZzmPmcDr2OVcllHgDVCAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/798T3VNTjbvDe4AFieOcXfMOD9SYE71JJSGJqmuVkSGdOhV1
	4CeoK7Bv4bvN+Fssq1RBYV7zwrqlMh572mrMkmHQLE0lT7nuclBa
X-Google-Smtp-Source: AGHT+IGxXL/GkLsEq8K5RCKB5q8Ci7ka8sCfDOJo9Ybqw500oUx4Vul/sdxip4R7mV6DPgcAMTFT4g==
X-Received: by 2002:a17:903:41cc:b0:20b:a409:329 with SMTP id d9443c01a7336-20c80442c36mr107526735ad.5.1728644748610;
        Fri, 11 Oct 2024 04:05:48 -0700 (PDT)
Received: from dw-tp ([171.76.85.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c3510bfsm21757195ad.294.2024.10.11.04.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:05:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari
 Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, David
 Hildenbrand <david@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin
 P Bappalige <sachinpb@linux.ibm.com>
Subject: Re: [RFC v2 0/4] cma: powerpc fadump fixes
In-Reply-To: <87zfnb54fe.fsf@mail.lhotse>
Date: Fri, 11 Oct 2024 16:30:31 +0530
Message-ID: <87bjzq3nw0.fsf@gmail.com>
References: <cover.1728585512.git.ritesh.list@gmail.com> <87zfnb54fe.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>> Please find the v2 of cma related powerpc fadump fixes.
>>
>> Patch-1 is a change in mm/cma.c to make sure we return an error if someone uses
>> cma_init_reserved_mem() before the pageblock_order is initalized.
>>
>> I guess, it's best if Patch-1 goes via mm tree and since rest of the changes
>> are powerpc fadump fixes hence those should go via powerpc tree. Right?
>
> Yes I think that will work.
>
> Because there's no actual dependency on patch 1, correct?

There is no dependency, yes.

>
> Let's see if the mm folks are happy with the approach, and if so you
> should send patch 1 on its own, and patches 2-4 as a separate series.
>
> Then I can take the series (2-4) as fixes, and patch 1 can go via the mm
> tree (probably in next, not as a fix).
>

Sure. Since David has acked patch-1, let me split this into 2 series
as you mentioned above and re-send both seperately, so that it can be
picked up in their respective trees.

Will just do it in sometime. Thanks!

-ritesh


> cheers
>
>> v1 -> v2:
>> =========
>> 1. Review comments from David to call fadump_cma_init() after the
>>    pageblock_order is initialized. Also to catch usages if someone tries
>>    to call cma_init_reserved_mem() before pageblock_order is initialized.
>>
>> [v1]: https://lore.kernel.org/linuxppc-dev/c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com/
>>
>> Ritesh Harjani (IBM) (4):
>>   cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
>>   fadump: Refactor and prepare fadump_cma_init for late init
>>   fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
>>   fadump: Move fadump_cma_init to setup_arch() after initmem_init()
>>
>>  arch/powerpc/include/asm/fadump.h  |  7 ++++
>>  arch/powerpc/kernel/fadump.c       | 55 +++++++++++++++---------------
>>  arch/powerpc/kernel/setup-common.c |  6 ++--
>>  mm/cma.c                           |  9 +++++
>>  4 files changed, 48 insertions(+), 29 deletions(-)
>>
>> --
>> 2.46.0

