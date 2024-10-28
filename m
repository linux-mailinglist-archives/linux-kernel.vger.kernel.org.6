Return-Path: <linux-kernel+bounces-385981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F346E9B3DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433A3B2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4231EF92A;
	Mon, 28 Oct 2024 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6zVQHIV"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9781EE02A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154793; cv=none; b=lms866nxKg8wIl1Sm7sIkigLZ0gn4G8tr3PazsJOHEJU8cqWqLFHdvfZZR4fGWCmqnquqZpv+r8lvT8RBnCBWBIo5Baxkp0QPj5xgUDd/pwBw6vjl3RAHjmBtxJtN/MQn4JFBkeQwJybUeglP8rs3UHnS9iqIt1hNcXMQpnnm9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154793; c=relaxed/simple;
	bh=IlreXH8S/kqYldkIylSBxVIyiDInNqbc8GoTCBhULZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTcJfQI3lrtCxg522ugXBHxBaCdGt2G7DxGjO2KyCVBR9p4ofuHg7VUhCrWy7UjVHo4FZxKhE1U/XOBHRHQ+zy43r2YnldbBIijfKpET5MdL5uwSVIwcTW96+rZUpVWz0mrsZ5P6iCnPZ2oadeJmTpXS/8jMRycksPxFcjZ9bg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6zVQHIV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so33394486d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730154790; x=1730759590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IlreXH8S/kqYldkIylSBxVIyiDInNqbc8GoTCBhULZA=;
        b=N6zVQHIV1CSJH2zzhIdZpmCejXxBoplZyZn2gG2yw/rRAtl/3hWvSLf+NawSL79p7b
         R3F0XIpEEzh9lvGYuN5f2xjg/XBqO+TePZF27hz5yVYtQQmSQA9CPc7i9G6MThM6mP0o
         KSw/RDgVuavwOxQgswgukp1nSJ38Uwn/AiMEkE6EwFXhtYfY33BTiOtQbKKOBum5tURz
         twVuq7JoIzpfn8qWtbV90rgpye1aR29fgZ+8/o+MrL1AJIoFihYu1R6A6RCjYqvljdw9
         XUnrQmNlUFr1OqIyX0kfhlnmIOHsT96y4ZO+I2zqb8b1aIup7BiBzD43/Cwneei87Ttw
         gR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154790; x=1730759590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlreXH8S/kqYldkIylSBxVIyiDInNqbc8GoTCBhULZA=;
        b=UNMTFn641NnVVSAExPDtPcLX3Fpdyde7T9ZSDM2SD2PetjHa+mckv4wpyvLCiX5cP7
         4pdd43zNziaJyb21zrjSZ0BFN1FhuTHPt7xC/JyQ78AM6DlMdNTaXxfQewznSgVQzaty
         S5mudPImJvJk5pJ4FPVrUcQzCv6pmIA8EkIyS9IGCAyiJX8EoPa7bmH1uX4f/ziSWoO+
         ixreLN52H2aFy0hgcib6QenAPWiK6pjYXgyZPGrv6RpXPi8El6Glmx9yKae+ONZIEPSd
         tAtq18qxCP6jSghIsoml9M5eDTxjrYXSTexZ7MkJeylgfxKwztt9Q2695Odv3ENU28R9
         ytBA==
X-Forwarded-Encrypted: i=1; AJvYcCVVZNtSVqJ0J/YfvjzWTcjam3C6bbJ8tw3Jy9nM6qgc9HUkXN0DglhCkMlpTEMjEa3T4pAH4P5xEt32suc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwltqDRU5S1qOh0mgknI1zDu9dZresrpxxLYjzzl9jYtyTYPtcy
	FUOzjxueZ6Ke5IHu6yziAiN8cSNZQ5k61l+qSfPCANGsOd73KAkTJPpFhKBf7zj9I1w0YTxEad3
	7wcRSfRcwVp5728CJ3zjdchw3VeiPA/ESmYkQ
X-Google-Smtp-Source: AGHT+IEvj0UDWD9cBgGXsz6dWYQYrij2iHnYvSWbpQKcdZqIgNnWa6rgDt8EjP+Rek8fDWlUW0Bw5GnI1Lu4m6zeLlQ=
X-Received: by 2002:a05:6214:5a0b:b0:6cc:2d3c:6472 with SMTP id
 6a1803df08f44-6d1856b4898mr139737096d6.14.1730154789998; Mon, 28 Oct 2024
 15:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com> <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com> <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com> <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
 <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com> <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 28 Oct 2024 15:32:33 -0700
Message-ID: <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"

[..]
> > > By the way, I recently had an idea: if we can conduct the zeromap check
> > > earlier - for example - before allocating swap slots and pageout(), could
> > > we completely eliminate swap slot occupation and allocation/release
> > > for zeromap data? For example, we could use a special swap
> > > entry value in the PTE to indicate zero content and directly fill it with
> > > zeros when swapping back. We've observed that swap slot allocation and
> > > freeing can consume a lot of CPU and slow down functions like
> > > zap_pte_range and swap-in. If we can entirely skip these steps, it
> > > could improve performance. However, I'm uncertain about the benefits we
> > > would gain if we only have 1-2% zeromap data.
> >
> > If I remember correctly this was one of the ideas floated around in the
> > initial version of the zeromap series, but it was evaluated as a lot more
> > complicated to do than what the current zeromap code looks like. But I
> > think its definitely worth looking into!

Yup, I did suggest this on the first version:
https://lore.kernel.org/linux-mm/CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com/

, and Usama took a stab at implementing it in the second version:
https://lore.kernel.org/linux-mm/20240604105950.1134192-1-usamaarif642@gmail.com/

David and Shakeel pointed out a few problems. I think they are
fixable, but the complexity/benefit tradeoff was getting unclear at
that point.

If we can make it work without too much complexity, that would be
great of course.

>
> Sorry for the noise. I didn't review the initial discussion. But my feeling
> is that it might be valuable considering the report from Zhiguo:
>
> https://lore.kernel.org/linux-mm/20240805153639.1057-1-justinjiang@vivo.com/
>
> In fact, our recent benchmark also indicates that swap free could account
> for a significant portion in do_swap_page().

As Shakeel mentioned in a reply to Usama's patch mentioned above, we
would need to check the contents of the page after it's unmapped. So
likely we need to allocate a swap slot, walk the rmap and unmap, check
contents, walk the rmap again and update the PTEs, free the swap slot.

So the swap free will be essentially moved from the fault path to the
reclaim path, not eliminated. It may still be worth it, not sure. We
also need to make sure we keep the rmap intact after the first walk
and unmap in case we need to go back and update the PTEs again.

Overall, I think the complexity is unlikely to be low.

