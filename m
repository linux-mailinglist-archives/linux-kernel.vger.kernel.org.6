Return-Path: <linux-kernel+bounces-210090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E62903F30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1179D1C232E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D91EEE3;
	Tue, 11 Jun 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frgUxWWB"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6021D55D;
	Tue, 11 Jun 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117422; cv=none; b=pJyd1cfAnzPA7fhgFQAITXHTb58yDHyFFssrufkUsDwRZLs9Ka//pebTfsGCa7qIkM9uhqjWQlBoZaXHRmD/3ZIbf8CL54r8z5BVD/djm2lsUUloJ7W32gce5Lv0CtL1AN1iJt/SZdjawaDONiw3YJw6zsOHImWlalNE6qzTQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117422; c=relaxed/simple;
	bh=fW0OUd3l3X6VCU+uy+ikOdkB9oHd5fhTSpWL92/meHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1UbF1OYza8OTZfnMvsrWNIUVTG2B0cIKKlIolmYFoNPV3IKMTRFnwkrsFtVPE4nveF0RmeGNolrYr7d0JpORkjcCP4Owl5v5V96FGaBW+Fi3SjxOB5bQPTCIhgvZuHkKF79Itpkub9bGFSpNVa5LqS1ECxAIsTob0OF6sWr9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frgUxWWB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfb05bcc50dso1031043276.0;
        Tue, 11 Jun 2024 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718117419; x=1718722219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1hblv3agIvwTk/x1XoXFXapGpQD81CwVBOihZsPGt8=;
        b=frgUxWWBEQ64cHWEuQhax4VTnrKHL2EjFyIiUY2sgqkgGNcgkxu93H4w3IHhsQBsX6
         Ebb9D/zJkly2s9TugLPsks8lfHu0XIVEkXDxVAy34zMKrkEeYGlwdg1T3JqpujfsxS3b
         O+I+gkHdovprfgJf7HnnWFXL3l7lOlnJnYCUppAwAntZtgydTHpOAG0iP84XAWJGWP0i
         D0BWd/WxC9Gc5D1CLNE8TDrxTAlVlTKWvKTDdLotvqvJRpVOPg6H/k+FxaISGFDhq1w2
         MozgH5wDffVyGmmf1nInHfLmszoykwFR6mMmzz8BSyg6VVgrsm4fGHbZCcRRz301wYDy
         88yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117419; x=1718722219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1hblv3agIvwTk/x1XoXFXapGpQD81CwVBOihZsPGt8=;
        b=rnkgjaVSpaCWrvnxb9bDcmWfDPcJbgy4ZVfx9TfMbmRJxaQd5O1eVXV5QQcsPDuY19
         Urqh9lYKnPIp6RKvnAGcantsempiqKEcOwjWhLZt6KxIkcvwRYgvt9pDkl0YcNNTHsUj
         w6WRtVB9THXv9qXZWk3ihNpYHIiwlTlbykEDrSZuRpCI+XA13qxG2yy9l0Sq+FXtoRtD
         RoGHrvJlaiBycwej3HfwtXTPKrMO/q2GSrYgfaUcTGPp0TxgqosobkMRQOVpaJ8HTeP0
         sBpihI2D9FEwLba1KblPSx6RrvUhbtmT7eemeXHVXMrmm3j5VdAsznj6uaXUx65C1ybg
         Caig==
X-Forwarded-Encrypted: i=1; AJvYcCVofZr6bv4icu5P8SWXaIwNED/zKpCAEmMvua1v4GZFhh3Bh3skDOyQq3hNOk3LOCRyRwqu+wzyIJWPftnyZIrMNrFWyQuwyawbpSl8svalxNJcptlbtTdLNr7VrjbmYXaLSAJ3m4gA
X-Gm-Message-State: AOJu0YztwRgBjWa6dFK/YwvO7WoadaApoqVWgqPSC+aJeNm/IgiiRL/E
	geQ9Hjrbt1Ii+0ZSlLRuF3r/9gJo/EqBAXGlwX9Z1kH94+dxO/iw6RV6ktdEiTbfEMFolsz1inj
	Q3lO48X9f90krAh0od08ZaHTQXbw=
X-Google-Smtp-Source: AGHT+IEb3wyhuol+lxmZz3nl7yKGiwmyQfS5wDx2sbDZU27ZRE9oyfdLN5TTOen6rp6hy+UZ15vYv+tX187CVJMxKLA=
X-Received: by 2002:a25:ae96:0:b0:df4:d9ba:2b6a with SMTP id
 3f1490d57ef6-dfaf658dd97mr11330173276.14.1718117419380; Tue, 11 Jun 2024
 07:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAJD7tkaKaMpni2tA_G6DhiRLdV+O3AmXE81JyKY=PEN54o=aAw@mail.gmail.com>
In-Reply-To: <CAJD7tkaKaMpni2tA_G6DhiRLdV+O3AmXE81JyKY=PEN54o=aAw@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Tue, 11 Jun 2024 23:50:08 +0900
Message-ID: <CAPpodddsnOF7nKX-ijsujAcnjvLHB2UTyyZknc6uTgb3UWXY2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 2024/06/11 4:16, Yosry Ahmed wrote:
>
> I am really finding it difficult to understand what the diff is trying
> to do. We are holding a lock that protects zswap_next_shrink. We
> always access it with the lock held. Why do we need all of this?
>
> Adding READ_ONCE() and WRITE_ONCE() where they are not needed is just
> confusing imo.

I initially thought that reading new values from external variables
inside a loop required protection from compiler optimization. I will
remove the access macros in v2.

> 'memcg' will always be NULL on the first iteration, so we will always
> start by shrinking 'zswap_next_shrink' for a second time before moving
> the iterator.
>
>> +               } else {
>> +                       /* advance cursor */
>> +                       memcg = mem_cgroup_iter(NULL, memcg, NULL);
>> +                       WRITE_ONCE(zswap_next_shrink, memcg);
> Again, I don't see what this is achieving. The first iteration will
> always set 'memcg' to 'zswap_next_shrink', and then we will always
> move the iterator forward. The only difference I see is that we shrink
> 'zswap_next_shrink' twice in a row now (last 'memcg' in prev call, and
> first 'memcg' in this call).

The reason for checking if `memcg != next_memcg` was to ensure that we
do not skip memcg that might be modified by the cleaner.  For example,
say we get memcg A and save it. When the cleaner advances the cursor
from A to B, we then advance from B to C, shrink C. We have to check
that A in the zswap_next_shrink is untouched before advancing the
cursor.

If this approach is overly complicated and ignoring B is acceptable,
the beginning of the loop can be simplified to:

        do {
+iternext:
                spin_lock(&zswap_shrink_lock);

                zswap_next_shrink = mem_cgroup_iter(NULL,
zswap_next_shrink, NULL);
                memcg = zswap_next_shrink;



>> @@ -1434,16 +1468,25 @@ static void shrink_worker(struct work_struct *w)
>>                 }
>>
>>                 if (!mem_cgroup_tryget_online(memcg)) {
>> -                       /* drop the reference from mem_cgroup_iter() */
>> -                       mem_cgroup_iter_break(NULL, memcg);
>> -                       zswap_next_shrink = NULL;
>> +                       /*
>> +                        * It is an offline memcg which we cannot shrink
>> +                        * until its pages are reparented.
>> +                        *
>> +                        * Since we cannot determine if the offline cleaner has
>> +                        * been already called or not, the offline memcg must be
>> +                        * put back unconditonally. We cannot abort the loop while
>> +                        * zswap_next_shrink has a reference of this offline memcg.
>> +                        */
> You actually deleted the code that actually puts the ref to the
> offline memcg above.
>
> Why don't you just replace mem_cgroup_iter_break(NULL, memcg) with
> mem_cgroup_iter(NULL, memcg, NULL) here? I don't understand what the
> patch is trying to do to be honest. This patch is a lot more confusing
> than it should be.


>>                         spin_unlock(&zswap_shrink_lock);
>> -
>> -                       if (++failures == MAX_RECLAIM_RETRIES)
>> -                               break;
>> -
>> -                       goto resched;
>> +                       goto iternext;
>>                 }

Removing the `break` on max failures from the if-offline branch is
required to not leave the reference of the next memcg.

If we just replace the mem_cgroup_iter_break with `memcg =
zswap_next_shrink = mem_cgroup_iter(NULL, memcg, NULL);` and break the
loop on failure, the next memcg will be left in zswap_next_shrink. If
zswap_next_shrink is also offline, the reference will be held
indefinitely.

When we get offline memcg, we cannot determine if the cleaner has
already been called or will be called later. We have to put back the
offline memcg reference before returning from the worker function.
This potential memcg leak is the reason why I think we cannot break
the loop here.
In this patch, the `goto iternext` ensures the offline memcg is
released in the next iteration (or by cleaner waiting for our unlock).

>
> Also, I would like Nhat to weigh in here. Perhaps the decision to
> reset the iterator instead of advancing it in this case was made for a
> reason that we should honor. Maybe cgroups are usually offlined
> together so we will keep running into offline cgroups here if we
> continue? I am not sure.

From comment I removed,

>> -                * We need to retry if we have gone through a full round trip, or if we
>> -                * got an offline memcg (or else we risk undoing the effect of the
>> -                * zswap memcg offlining cleanup callback). This is not catastrophic
>> -                * per se, but it will keep the now offlined memcg hostage for a while.

I think this mentioned the potential memcg leak, which is now resolved
by this patch modifying the offline memcg case.

