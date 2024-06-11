Return-Path: <linux-kernel+bounces-210143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19948903FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217861C238E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F94224C9;
	Tue, 11 Jun 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/1sVA1o"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FC1EEE9;
	Tue, 11 Jun 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119287; cv=none; b=Z/+V3Hg/btA9BaXj0D3cn3C+5wz2p9kiDhXMSauAnxCGg8Yd3HfYPz716dqFtFWWB49SWnIPf/TFvZMIUf7ptZtElHYpdbCFiKs56CXuCD+jn39zdwH5E7Z68i26JZv2Hevd/oiGjvxdCUKEQF0MyO4mSt4MyerrMERlt6i4KbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119287; c=relaxed/simple;
	bh=RKdGsIGcMB+U3eh22pDCIx5Wyp3C7YRCx+y0o3pEol0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9qPbXKDey6nHc6UiR+RVZ9i3NVW0GmUxSi+MgRB9d8GR2MW3RXELDOio3/gcopxPEXNdsGdPp0jQZ4ewMRVl6L1ouFgnhtTTCgIJKlGFEuWzNbnukerigwRruVHuexwK3xytYWWWQP77jnwJll+PxSVljgT1IU2tl7H1TIMTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/1sVA1o; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df481bf6680so1220354276.3;
        Tue, 11 Jun 2024 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718119284; x=1718724084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J1kYTsVFHvV3hNTS3A7aiLsXfJGmt9YdVx0hwX8mjlg=;
        b=k/1sVA1ojkqDICVAcgp941dpM5JDIqEB4eFZINTuA/iBm6oGunf+X4zy+q7IowaxiE
         xW01CDLSeHYsxmbXmPLg1fw4Vot03E2hnikvdHLfhdEw/0LyyN25tkR/cbKYs42L4EZ5
         E/OEwX83pZjClPgbccvWZ6fasO1/Pu/dPRd0uPnaNr874bBgpz6PV8Ii6Z2cfU/emS4c
         I9h6AE2fNcas9SVnPI/f7TlLAS2FhPKkZtIc+ZkcFZZWNyixQrJtRWYyaKnSPvVyDHcv
         cV1QyzN/+QJ4I2JVZafKJ0hOdh5nqm8HatEjcm15X+DuiA3aw+32/qi3gRplIq0Ro1Sp
         epLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119284; x=1718724084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1kYTsVFHvV3hNTS3A7aiLsXfJGmt9YdVx0hwX8mjlg=;
        b=aOfMg1ayhiYm6BJmFxEouPdoBMcCk7yIlp1kB+E/Dpr/YE7sGRH+B/rNaHDiGEkoir
         s+IzvNq58ut4MOYLCXLdhwMzd7CvrFr8hhoT+9A+yDy+CrnHYheUbXFltu2U1WDREyJw
         a/oMeIZ7wMTMY7po7M/UH4tCO1Ln6s1YSyuk7BR1iofBaav3eRmleH9FxLm0AUoiW4+B
         KtPWdqUt2lEJTFWJoCTcT/Vt9A+Wx5ps4x5g2TfIKY0eygmoeOElO5rDuD7YQAwihnCp
         GiT4eJytZ6H5wIORXt1vfJVMTuLgV8+3X6i4JZ8T8CWNafix120m7rWKqsxXUYsioH1/
         wo/w==
X-Forwarded-Encrypted: i=1; AJvYcCUHSvOaE4CTHdirHQt3OLqMSvHOPVO2+RoctXUn1dSzStVpCfRLtRRcdkCpOzEyA2dOcxwWr3DFl1r5G/MgMiIPou2fd+hdSHNwIexaGBZ43xrQ/x8vAvg8o41FdIlgSpAfhGTP7Sdg
X-Gm-Message-State: AOJu0YxE6LOXtYiS5xf3cYC3eOKmH6d/Ggb0ndli53168DM2l0efKaJO
	POZY/xBATn6x5vK9nk0nk70xWqCT+6BOeQ/I3CCXYMobq7HGcUu4nPpdDZiTBZDRPsIHUqCdHRA
	tc44+PlxfDHlwEsr7kNIhnCafWw2NySVy66qITA==
X-Google-Smtp-Source: AGHT+IFqOX8dyvxGqZZ4ezrnpN/DGORkRIJkUVTMjkZlrD7I9/dvJuLZhiP27fCx9HyGLrYhprvuvCKtFYnXNJoSX8I=
X-Received: by 2002:a25:660d:0:b0:dfb:1460:b5b1 with SMTP id
 3f1490d57ef6-dfb1460b9e3mr7565693276.1.1718119284571; Tue, 11 Jun 2024
 08:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-3-flintglass@gmail.com>
 <CAJD7tkZAkzUfbXY3C0QOGqCyjQZeiuGzkZac4hmogOoh=yoZsw@mail.gmail.com>
In-Reply-To: <CAJD7tkZAkzUfbXY3C0QOGqCyjQZeiuGzkZac4hmogOoh=yoZsw@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 12 Jun 2024 00:21:13 +0900
Message-ID: <CAPpoddf0ysCG=s5ixbOZkXjmcB0t_eqLOs9xhdqZHiWnYY4_Wg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: zswap: fix global shrinker error handling logic
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks a lot for your comments.


On 2024/06/11 5:27, Yosry Ahmed wrote:
>>                 unsigned long nr_to_walk = 1;
>>
>> +               if (!list_lru_count_one(&zswap_list_lru, nid, memcg))
>> +                       continue;
>> +               ++stored;
>>                 shrunk += list_lru_walk_one(&zswap_list_lru, nid, memcg,
>>                                             &shrink_memcg_cb, NULL, &nr_to_walk);
>>         }
>> +
>> +       if (!stored)
>> +               return -ENOENT;
>> +
>
> Can't we just check nr_to_walk here and return -ENOENT if it remains as 1?
>
> Something like:
>
> if (nr_to_walk)
>     return -ENOENT;
> if (!shrunk)
>     return -EAGAIN;
> return 0;
>

ah, the counting step can be removed. I will change it in v2.

>>         return shrunk ? 0 : -EAGAIN;
>>  }
>>
>> @@ -1418,12 +1425,18 @@ static void shrink_worker(struct work_struct *w)
>>  {
>>         struct mem_cgroup *memcg = NULL;
>>         struct mem_cgroup *next_memcg;
>> -       int ret, failures = 0;
>> +       int ret, failures = 0, progress;
>>         unsigned long thr;
>>
>>         /* Reclaim down to the accept threshold */
>>         thr = zswap_accept_thr_pages();
>>
>> +       /*
>> +        * We might start from the last memcg.
>> +        * That is not a failure.
>> +        */
>> +       progress = 1;
>> +
>>         /* global reclaim will select cgroup in a round-robin fashion.
>>          *
>>          * We save iteration cursor memcg into zswap_next_shrink,
>> @@ -1461,9 +1474,12 @@ static void shrink_worker(struct work_struct *w)
>>                  */
>>                 if (!memcg) {
>>                         spin_unlock(&zswap_shrink_lock);
>> -                       if (++failures == MAX_RECLAIM_RETRIES)
>> +
>> +                       /* tree walk completed but no progress */
>> +                       if (!progress && ++failures == MAX_RECLAIM_RETRIES)
>>                                 break;
>
> It seems like we may keep iterating the entire hierarchy a lot of
> times as long as we are making any type of progress. This doesn't seem
> right.
>

Since shrink_worker evicts only one page per tree walk when there is
only one memcg using zswap, I believe this is the intended behavior.
Even if we choose to break the loop more aggressively, it would only
be postponing the problem because pool_limit_hit will trigger the
worker again.

I agree the existing approach is inefficient. It might be better to
change the 1 page in a round-robin strategy.

>>
>> +                       progress = 0;
>>                         goto resched;
>>                 }
>>
>> @@ -1493,10 +1509,15 @@ static void shrink_worker(struct work_struct *w)
>>                 /* drop the extra reference */
>>                 mem_cgroup_put(memcg);
>>
>> -               if (ret == -EINVAL)
>> -                       break;
>> +               /* not a writeback candidate memcg */
>> +               if (ret == -EINVAL || ret == -ENOENT)
>> +                       continue;
>> +
>
> We should probably return -ENOENT for memcg with writeback disabled as well.
>
>>                 if (ret && ++failures == MAX_RECLAIM_RETRIES)
>>                         break;
>> +
>> +               ++progress;
>> +               /* reschedule as we performed some IO */
>>  resched:
>>                 cond_resched();
>>         } while (zswap_total_pages() > thr);
>> --
>> 2.43.0
>>

