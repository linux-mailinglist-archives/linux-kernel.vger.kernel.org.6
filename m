Return-Path: <linux-kernel+bounces-213934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF76907CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301CE1C22CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85914B965;
	Thu, 13 Jun 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE4JWSWw"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26839137758
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307504; cv=none; b=Xk5wb+8gOtLJ3RtYaQlhXwt8x3bhRBvnW0PnPSB3qzaLsfGp/RwyrgdvnR6S9GooYcvmQP1NT+t4xCt7p9Havj1F7h1506JkfqXIGxjD1tAlrIhadLc0eqlxIrapu5dNgVuN/WI6L2sP+F6C/b5Vb9FiHAk8ioaWtXr7h6Oqcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307504; c=relaxed/simple;
	bh=TR4cAm5xNK5AcGmAj98ChxZtgaFF/ujYrlwuTqic8RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2JTmbqsLwO1SSguX/O0+G6XBsa8AKLYGozAK3BdPJQJDVfDFzQh+6MX8OLo1CGiLs6bLkg8tyxwfrY4qBVzZZ22vBbOv9Sj3HoTeTmS0+sn+J1qp5Ltyexmc3EGFMwc2ioWWH4/Jz7SG3tJTgmymXAKFeaAEdxwNFVD5GaoqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE4JWSWw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42198492353so11390225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718307501; x=1718912301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkVryrNJA6CiSEHBBoY/tn5Xtb/QS0Aw+i138p1q7mg=;
        b=LE4JWSWwFiQ4DF7wcVJ0w+SRrJeH3CShHWPEnQ3yC1BfXviDHKS/cE7GJI8qPcOA8y
         T0u1GjCT0pmPh9AiFCz8CKVYO4ZUFvB24OtrmRHId3fDnxa83+uJck5iISfx88ic7gIV
         BS4Go4hknoUESmCOglqMgxAGoR7frRfrB/oijnalIGnaJ2GPPLa6Cc26BdeOtKaajdcZ
         fZ7k+7JFlrUUjXUsT4uwkr4NBG590y3QofSM8M3OCw/kHlwsvd2xRhyfdRs9ZJKdMVyy
         Rx/rrD0Vmb6e0Z3NLn5jOqiGxVyinzBzn9/o3lWT3javkMuiSvUVPib5ewsPZ9NQzI8y
         N+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718307501; x=1718912301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkVryrNJA6CiSEHBBoY/tn5Xtb/QS0Aw+i138p1q7mg=;
        b=CtCPuqUY4qyJgwcCUFy7Ts/1kPG02AqNF9LO7CYo7NwDH4q0Ult5Pu4IU6oyPIWYDW
         RGFOHTNHSyeT00kqH9jFaG18SZFQUTtbruFCmESswkurMukfqBvc6nv6RP+ZD7AUm9Cb
         hOONJYLZKOLivB+yCFR8f4GO2rLKtFCjN75hYBWhzcdhM0B1U06Ma81D5RvthE4vwEya
         0hWIhVbOxoB4TrQ94yQWvvMya8ilqayQA+yHHxRrNLix57a9YijR5x1FgqBLMLjNXGKd
         8tt8s+V7ZTU4hF6Q5ThqKAyJw9BDtDYw0/imYn9L6ISFYR/AN9YILzRfbW3jdXaLbNot
         czfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+2ANjoDYCXjkCfExXdYIzWHquUFEH2vHRzx2mGLriuEmCa0M+thyObpkok50GwDrm7h9d5tUZ3K7dyCSVNRhaPHPnloPt8XS7qzKz
X-Gm-Message-State: AOJu0YyfjD/hVerZEAD78nfJ+cLluYePdfieDZ9YgjdoCMA4qXmj8TFY
	AewgNoiuHikuWfnQNHSu6cVWojThGatTNmi2NVfQsOe0GQimz08a
X-Google-Smtp-Source: AGHT+IEnEqeoMG/JJxTOMZkZ/oBkHUfBTCamWig8WosWNOft6m9a3oO84QR7RMYwtkq2b2NIi81fxA==
X-Received: by 2002:a05:600c:4f84:b0:422:683b:df34 with SMTP id 5b1f17b1804b1-4230484eed9mr6166685e9.28.1718307501137;
        Thu, 13 Jun 2024 12:38:21 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f61280f6sm35170855e9.27.2024.06.13.12.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 12:38:20 -0700 (PDT)
Message-ID: <8b155ba8-ff53-4202-b2eb-afe73db77d7e@gmail.com>
Date: Thu, 13 Jun 2024 20:38:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
 <20240612124750.2220726-2-usamaarif642@gmail.com>
 <ZmoBf6RPJzC2RaqM@google.com>
 <85804484-9973-41a1-a05d-000833285f39@gmail.com>
 <CAJD7tkYBxN4uAHLacAx=m2+B9zPidz0V5pGP030yvNYLTnk=VQ@mail.gmail.com>
 <0572d8b1-3b17-45a8-bf75-f66e19216d38@gmail.com>
 <CAJD7tkYGFsYbbbHp3+MMHTuxNcG_Z+i-5TCo3wieVArcra5wmA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkYGFsYbbbHp3+MMHTuxNcG_Z+i-5TCo3wieVArcra5wmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 13/06/2024 20:26, Yosry Ahmed wrote:
> [..]
>>>>>> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>>>>>                __free_cluster(si, idx);
>>>>>>                memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>>>>>                                0, SWAPFILE_CLUSTER);
>>>>>> +            for (i = 0; i < SWAPFILE_CLUSTER; i++)
>>>>>> +                    clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>>>>> Same here. I didn't look into the specific code paths, but shouldn't the
>>>>> cluster be unused (and hence its zeromap bits already cleared?).
>>>>>
>>>> I think this one is needed (or atleast very good to have). There are 2
>>>> paths:
>>>>
>>>> 1) swap_cluster_schedule_discard (clears zeromap) -> swap_discard_work
>>>> -> swap_do_scheduled_discard (clears zeromap)
>>>>
>>>> Path 1 doesnt need it as swap_cluster_schedule_discard already clears it.
>>>>
>>>> 2) scan_swap_map_slots -> scan_swap_map_try_ssd_cluster ->
>>>> swap_do_scheduled_discard (clears zeromap)
>>>>
>>>> Path 2 might need it as zeromap isnt cleared earlier I believe
>>>> (eventhough I think it might already be 0).
>>> Aren't the clusters in the discard list free by definition? It seems
>>> like we add a cluster there from swap_cluster_schedule_discard(),
>>> which we establish above that it gets called on a free cluster, right?
>> You mean for path 2? Its not from swap_cluster_schedule_discard. The
>> whole call path is
>>
>> get_swap_pages -> scan_swap_map_slots -> scan_swap_map_try_ssd_cluster
>> -> swap_do_scheduled_discard. Nowhere up until swap_do_scheduled_discard
>> was the zeromap cleared, which is why I think we should add it here.
> swap_do_scheduled_discard() iterates over clusters from
> si->discard_clusters. Clusters are added to that list from
> swap_cluster_schedule_discard().
>
> IOW, swap_cluster_schedule_discard() schedules freed clusters to be
> discarded, and swap_do_scheduled_discard() later does the actual
> discarding, whether it's through si->discard_work scheduled by
> swap_cluster_schedule_discard(), or when looking for a free cluster
> through scan_swap_map_try_ssd_cluster().
>
> Did I miss anything?

Ah ok, and the schedule_discard in free_cluster wont be called scheduled 
before swap_range_free. Will only keep the one in swap_range_free. Thanks!



