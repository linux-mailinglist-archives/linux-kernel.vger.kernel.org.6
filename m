Return-Path: <linux-kernel+bounces-386009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949D9B3E06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED653B218F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC541EE00D;
	Mon, 28 Oct 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvYyDMYj"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427618C02D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155932; cv=none; b=oTyIxrNn1DSjYxKYieHuHHSZsoGrVgLGrdqku5uEAYWJTwpmQosmNcy2RsfEZzb79g6OiUcsyFzZOcsw7sJ2i3v2wJBINBPd8X300TMWtgsNlqLbCuBD70QQ+8k3bs/3xkPJ2bmcA67ift3ecTkuJhXmO43dcWikG+hgNCzq6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155932; c=relaxed/simple;
	bh=OKc+iU530BpPmkhR7DEU839Nwnoqh+MtpDrGUcBE2Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVg+tcRwfg3z51x+76B5K6C9qzFFS9QDaeZOvS6rMMM3iNxgCpHyA+PYzOYeknuhCjWAslPj3YBCillYGSdqvtM2HxoQXj/CFpLsjfXO/vMfnUIWK2BRByyt7dI5NRsiVGXNQVr+5ew0l/D5w59wCRt3Ps1coqGLdyxG741jYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvYyDMYj; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a46d662fccso1591036137.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730155929; x=1730760729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKc+iU530BpPmkhR7DEU839Nwnoqh+MtpDrGUcBE2Sg=;
        b=WvYyDMYjAox5Knzr1Uoyos3TJTQGXys2Y7tBsNI55U0/eiYMd9HhzVcFFsrhXoX7Hb
         wXSZoxi2TyqSWkSVQ8vy2WTWZLWxSKgdXtIz+P7biGZZcFnBuqepDpLF8m6JkbgloYnS
         pLINP+jkH2UhqGhdQm83omnYKrt5O4BZxB5ZKjt1TAZIKFkT6vbYXlJpXpIbqzIDDBXw
         sXp2kyO6lBS5D0bFOb9a4NUY8f/S7QR79UJHCtoI9jeAUYtLo/YliYj5CsBj6L8SQ1WT
         JaSssvTadU6jQnsN9piD1zGGFtXZNe/fvg7aHbraxu9hbapVlDwNpcazzn/ZoH/5EZdC
         mLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155929; x=1730760729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKc+iU530BpPmkhR7DEU839Nwnoqh+MtpDrGUcBE2Sg=;
        b=Sdu5KtMmjoxiqZBna9zD0I2WTeKxgxniEo5IXNCzMYHC+pvvZPG+btXxYRVmX5wlEv
         RoLvpfPHEL2I1REEVYc5e/EQQyQs4HrRimhih65pm+03oxfklzHqKAxTrTonSOZnazLJ
         Mdxr1V8hbPL2MglzAj0TGHjbE4ySi3/SmKyelzQaqU018GGhlCYBAk4E9fFGZbXtHc3E
         WZoGDDHSen4jxgNNqfeKac0er0wY//P0w8CRa3fSuR9tDzGWmuwaZReOoaZ2DGtndOmy
         RqS0cVRlCZHSaoGTegVrYHyBVmNBkJqwFOgzNGRr1Uff7CT1V9aulm0GeTY4QsyS1kdF
         D/hw==
X-Forwarded-Encrypted: i=1; AJvYcCWsiBRlI3eBeKkd2Hf/zUee9Ak73Q2dcPm5XqsR8ryAKOFXW+8bEosOb5T8tAPT6/DbRq/eZGN8R1EgNDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXMbJv79u7pZ4JUS3ZA/KZJgHOpkp46vPEaA7Lq10C1u3nBru
	ywI7PjlOIUgGiASJvpFN8Ej2lDtNUH8XRaVVRK7eQOFNeDiDueVNlCJp6l4aKIiUpiZuwUMhLdQ
	7Zb285o65sLHlWU9mR/jxyim79x0=
X-Google-Smtp-Source: AGHT+IEAqiNXTrHzMLvn16UEbhWXfSAvlmRUo8YE31JdE86g+2eUJ8Cqe7C03H3RxktffuNkqtVMMC8ghvWTV7gyBSc=
X-Received: by 2002:a05:6102:390f:b0:4a4:7161:609 with SMTP id
 ada2fe7eead31-4a8cfd4fb57mr7913376137.20.1730155929259; Mon, 28 Oct 2024
 15:52:09 -0700 (PDT)
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
 <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com>
In-Reply-To: <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 06:51:57 +0800
Message-ID: <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 6:33=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> > > > By the way, I recently had an idea: if we can conduct the zeromap c=
heck
> > > > earlier - for example - before allocating swap slots and pageout(),=
 could
> > > > we completely eliminate swap slot occupation and allocation/release
> > > > for zeromap data? For example, we could use a special swap
> > > > entry value in the PTE to indicate zero content and directly fill i=
t with
> > > > zeros when swapping back. We've observed that swap slot allocation =
and
> > > > freeing can consume a lot of CPU and slow down functions like
> > > > zap_pte_range and swap-in. If we can entirely skip these steps, it
> > > > could improve performance. However, I'm uncertain about the benefit=
s we
> > > > would gain if we only have 1-2% zeromap data.
> > >
> > > If I remember correctly this was one of the ideas floated around in t=
he
> > > initial version of the zeromap series, but it was evaluated as a lot =
more
> > > complicated to do than what the current zeromap code looks like. But =
I
> > > think its definitely worth looking into!
>
> Yup, I did suggest this on the first version:
> https://lore.kernel.org/linux-mm/CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDn=
sdwM=3Dg9cpAw@mail.gmail.com/
>
> , and Usama took a stab at implementing it in the second version:
> https://lore.kernel.org/linux-mm/20240604105950.1134192-1-usamaarif642@gm=
ail.com/
>
> David and Shakeel pointed out a few problems. I think they are
> fixable, but the complexity/benefit tradeoff was getting unclear at
> that point.
>
> If we can make it work without too much complexity, that would be
> great of course.
>
> >
> > Sorry for the noise. I didn't review the initial discussion. But my fee=
ling
> > is that it might be valuable considering the report from Zhiguo:
> >
> > https://lore.kernel.org/linux-mm/20240805153639.1057-1-justinjiang@vivo=
.com/
> >
> > In fact, our recent benchmark also indicates that swap free could accou=
nt
> > for a significant portion in do_swap_page().
>
> As Shakeel mentioned in a reply to Usama's patch mentioned above, we
> would need to check the contents of the page after it's unmapped. So
> likely we need to allocate a swap slot, walk the rmap and unmap, check
> contents, walk the rmap again and update the PTEs, free the swap slot.
>

So the issue is that we can't check the content before allocating slots and
unmapping during reclamation? If we find the content is zero, can we skip
all slot operations and go directly to rmap/unmap by using a special PTE?

> So the swap free will be essentially moved from the fault path to the
> reclaim path, not eliminated. It may still be worth it, not sure. We
> also need to make sure we keep the rmap intact after the first walk
> and unmap in case we need to go back and update the PTEs again.
>
> Overall, I think the complexity is unlikely to be low.

