Return-Path: <linux-kernel+bounces-266498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F29400AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3611C22642
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864818E750;
	Mon, 29 Jul 2024 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsUQWEbR"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0C78C98
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290177; cv=none; b=ekZ3ZFR5dhJWK4807oRdPeOumNBSXgxrDsWfNGjI8sJR/sm8klOo6CnOqdxYz3v7gz0GaApRTvY733gJVP0yQ3Rs7K/fuqTjIMAjZ5Bb1NhrLwvVhy+KDh/jdqdVAYViaO++AZHU9YuReS06fQWeCE8sP7GrcrDfvjhe9GD76ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290177; c=relaxed/simple;
	bh=PIuiCaoHZtISd3fdMRW2nSa5tNKyombrxRvx9WOkYSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuOnsknmCjCKb7opvdMsVgSW1p/g3h63hnrYeAk1C5FL724nlW/T2Cu3W3Wur6jTOGBa8fmzo0GDGTOwlljnOmqiNySHHE9cpVZO5G0lMc7b5ehOWqVd3fgOZW2B6X1llNqdsubsH0jhouC6Q8yRZmSH96/7gp6WThjKc8DAd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsUQWEbR; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4929fd67c7bso677784137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722290174; x=1722894974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buKYfD2vEc4bJOlfBlCE01OD2iMJ6++Hrcgkg0+V6g0=;
        b=NsUQWEbRkPpp06gFwqFyZHT5BO+2/RpSfw4YVb6RjrhLOOW4hgs3FAYlU4WdFwoMNO
         88H5/wLNPR6XI3ym/FQiLHXs2kk47N0IsxKaWXObjutYXf1GEJ6ikIot4o2Jnm7AmEsU
         pTnLzG/YSgiM96+M7IBt7uOnZyxzY+vu+8YhBJxmeYaQV91g8N7sNyojlZDrbhlAWGE4
         4kHntJXS8mqOnmFcP4HazCpnfJvRqm65eRS8RZzCgs6QgixX1l9GSyQ2VqZp96+0vVVM
         J7mR9D/WvVHQbOF07kU8VvkKZTP6Run10GE0lM1YNMrVdKmk5U6FzJt/D2D1axxhzB09
         5scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290174; x=1722894974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buKYfD2vEc4bJOlfBlCE01OD2iMJ6++Hrcgkg0+V6g0=;
        b=sB9+Vby50Njsy5fLQ2ccMCOtEGSlLfFg0vJN9gAPw7nPd8v0q0o33xq3wy8hnvP1mD
         kc8yj871ThvVIAmHyP28R0cniDb1SnHkDzGb+umjsGYzSiiwkhaN2bo44b+Su5pRmghF
         jkPM4Lh7GRGpBMWqfBAs1MjYAYHscltpnWG85ASeZVkOGyAhp4YIAlQS0bmwXWgWdtLh
         ZWVd0DxjAuPJSKkTKd8GwjwRFaVPiwhYW2gYuLw2j+YKiLTJMmSpdvBgyzhs5GSYjUfL
         Rs/5owk+pMW9AQGfKlMi5PBLRZZYorxNk8YdjivotUTjrMcfpzLYAf29C6QxW5isVLRw
         5h0A==
X-Forwarded-Encrypted: i=1; AJvYcCUSurl083jVbaGX4KUcIDuozl3G4IjSzjF+Vx7wKRj91uRnnOVAbpYArNZqKTzsoIDAFVY3u+iqSTPtmqFXI6xzcDLQGkLxY8nf3ocQ
X-Gm-Message-State: AOJu0Yzr0cPt81vVx+cWSmdvsMY1MuVXJyIqgAWhTXwVeot2kWyxlozS
	C8Daivm3teBl+UZKCKeXP72oO1wvNXUS+ocBWcg6fv4Fu2auNTtCavSDBvU9gjSS6xmy3sq1vje
	c+2oMmxyNGIr0oVZIunxHYpHphu0=
X-Google-Smtp-Source: AGHT+IHz+04Nm+a7KXjZa3Dhb86GCyTqxzeBIw35gjeoXs7Tw9QapympkWZYNkDA8b9tTILb177mq2VC3NwQ3U6nJJI=
X-Received: by 2002:a05:6102:3589:b0:48f:e5d1:241d with SMTP id
 ada2fe7eead31-493faa40575mr11169360137.14.1722290174336; Mon, 29 Jul 2024
 14:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org> <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
 <CAGsJ_4wxUZAysyg3cCVnHhOFt5SbyAMUfq3tJcX-Wb6D4BiBhA@mail.gmail.com>
 <ZqePwtX4b18wiubO@casper.infradead.org> <CAGsJ_4zXfYT4KxBnLx1F8tpK-5s6PX3PQ7wf7tteuzEyKS+ZPQ@mail.gmail.com>
 <ZqexmNIc00Xlwy2c@casper.infradead.org> <CAGsJ_4yqLVvCUFpHjWmNAYvPRMzGK8JJWYMXJLR7d9UhKp+QDA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yqLVvCUFpHjWmNAYvPRMzGK8JJWYMXJLR7d9UhKp+QDA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 09:56:03 +1200
Message-ID: <CAGsJ_4zFVrJ3BVDBBAD5mSQgZybsig5ZoT6PVyohYAbZt9Ndnw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Jul 30, 2024 at 3:13=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Jul 30, 2024 at 01:11:31AM +1200, Barry Song wrote:
> > > for this zRAM case, it is a new allocated large folio, only
> > > while all conditions are met, we will allocate and map
> > > the whole folio. you can check can_swapin_thp() and
> > > thp_swap_suitable_orders().
> >
> > YOU ARE DOING THIS WRONGLY!
> >
> > All of you anonymous memory people are utterly fixated on TLBs AND THIS
> > IS WRONG.  Yes, TLB performance is important, particularly with crappy
> > ARM designs, which I know a lot of you are paid to work on.  But you
> > seem to think this is the only consideration, and you're making bad
> > design choices as a result.  It's overly complicated, and you're leavin=
g
> > performance on the table.
> >
> > Look back at the results Ryan showed in the early days of working on
> > large anonymous folios.  Half of the performance win on his system came
> > from using larger TLBs.  But the other half came from _reduced software
> > overhead_.  The LRU lock is a huge problem, and using large folios cuts
> > the length of the LRU list, hence LRU lock hold time.
> >
> > Your _own_ data on how hard it is to get hold of a large folio due to
> > fragmentation should be enough to convince you that the more large foli=
os
> > in the system, the better the whole system runs.  We should not decline=
 to
> > allocate large folios just because they can't be mapped with a single T=
LB!
>
> I am not convinced. for a new allocated large folio, even alloc_anon_foli=
o()
> of do_anonymous_page() does the exactly same thing
>
> alloc_anon_folio()
> {
>         /*
>          * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
>          * for this vma. Then filter out the orders that can't be allocat=
ed over
>          * the faulting address and still be fully contained in the vma.
>          */
>         orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
>                         TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1=
);
>         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
>
> }
>
> you are not going to allocate a mTHP for an unaligned address for a new
> PF.
> Please point out where it is wrong.

Let's assume we have a folio with the virtual address as
0x500000000000 ~ 0x500000000000 + 64KB
if it is swapped out to 0x10000 ~ 0x100000 + 64KB.

The current code will swap it in as a mTHP if page fault occurs in
any address within (0x500000000000 ~ 0x500000000000 + 64KB)

In this case, the mTHP enjoys both decreased TLB and reduced overhead
such as LRU lock etc. So it sounds we have nothing lost in this case.

But if the folio is mremap-ed to an unaligned address like:
(0x600000000000 + 16KB ~ 0x600000000000 + 80KB)
and its swap offset is still (0x10000 ~ 0x100000 + 64KB).

The current code won't swap in them as mTHP. Sounds like a loss?

If this is the performance problem you are trying to address, my point
is that it is not worth increasing the complexity for this stage though thi=
s
might be doable. We once tracked hundreds of phones running apps randomly
for a couple of days, and we didn't encounter such a case. So this is
pretty much a corner case.

If your concern is more than this, for example, if you want to swap in
large folios even when swaps are completely not contiguous, this is a diffe=
rent
story. I agree this is a potential optimization direction to go,  but in th=
at
case, you still need to find an aligned boundary to handle page faults
just like do_anonymous_page(), otherwise, you may result in all
kinds of pointless intersections where PFs can cover the address ranges of
other PFs, then make the PTEs check such as pte_range_none()
completely dis-ordered:

static struct folio *alloc_anon_folio(struct vm_fault *vmf)
{
        ....

        /*
         * Find the highest order where the aligned range is completely
         * pte_none(). Note that all remaining orders will be completely
         * pte_none().
         */
        order =3D highest_order(orders);
        while (orders) {
                addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
                if (pte_range_none(pte + pte_index(addr), 1 << order))
                        break;
                order =3D next_order(&orders, order);
        }
}

>
> Thanks
> Barry

