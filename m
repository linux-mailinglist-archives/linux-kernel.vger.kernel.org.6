Return-Path: <linux-kernel+bounces-425206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415009DBED8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89F0281A73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7370145A07;
	Fri, 29 Nov 2024 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv1m8uX+"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E13C3C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732849664; cv=none; b=i9CgCF5T7M9uYNKeMT9wD5t1NXMsh6VUwWexzdJpZT3WRzTo/r/DZ8d28qnRxeoKejFVeKKpBCdfQEpgx9SUtpbhOKPplqHAFeuIeEL8hytjq+du+NnW6q3ZUEerkxj8dwQSvijlHS7zRhnhkBK33ABVJIZG3N32WRRBUzV1pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732849664; c=relaxed/simple;
	bh=qbmcWklC0mutfB4sluim/jp2j2DA3AOzKMLAikYqaCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVN2oc/k0vuNrCfJE0nmm4gZN0kqJkf8w+e2l7Q/S9orwDKpJas9eWnxPJzj3NIEiuRfaUUylF7/Rl0i4bSnz3J21vV6nGKRuwExpdg/2bHWrwe7xcLgkUcWO6h/cbFK85xYMqXxsDt4of29BbMTaj7rpT5SoOefIxCDkxzZHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv1m8uX+; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5154fab9889so324426e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732849661; x=1733454461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PxQCJ6IM1PdfpwcUesdeHaMzC0q6d8jho6vb/GjvMs=;
        b=iv1m8uX+ltF6PyK4e3jGKzYgbcvwh63x1EPVVgxYcQ4djMiG95RdGHBjDn0ncOp0/s
         XwwiqyfGYSdZQoZzQMuxihZbgYbtr4EOgrBNDRSgT5xhvrGaYvF2TrLvPx7uKbAkUWlM
         KkhO/BMHUF6prV/vuTGGWNW4r7qPf3KE2f21XBTzC0cPWDIYTYm++4l4PeYoLGqQS/kw
         hqXSzt9dyWA9VRO8WPZc93oqwW9+RkO7Vuc8DQwUfhiA99L4ZbFBYvf2pU+755+SZE88
         Z+z4A4KpV+Jmw7NKxLmR975tgQbz9NDOjAZwWRTy0b4RhmFAZzEmVVr/gVpRlREi9y0u
         aNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732849661; x=1733454461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PxQCJ6IM1PdfpwcUesdeHaMzC0q6d8jho6vb/GjvMs=;
        b=ZXDJd1zt5sC5wIA+mVM7eVzzkQ/lsLTBOmUmjtoYC0lqOWml0ieT/ya4GTDT6ZE2LW
         f3/F8WsZSkmNgsEht2a6YqUiWQa6uNr7qPMauwhAN2+MsFuBQI0BT6dO5coOV7a8pDhz
         qPxjAptuBdnOiEJFtghDeSyZO7Fux2OzJftioldiVHX28AqmmXt9SNnWxUaIgVPodKFK
         4UFtuKP23tafQx7PrsR2eLrKLNvc2HyPGlmpb0bDcp2hzHkynAS4naicxTypo7P8wu5z
         OzdQKF4kP1gRr7z0jFOJ+2rloU8IiGp2Gp4BNVEJdxk2434p+XNnY/U0aSyTKJXhnfiR
         s0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/x7nro91ZzazsrXxLaKBtHZtZofXhbHUmBcd69fsnSZeXdBkK3nEFid1m2XdqML3hEnXDG9GP+Z3tWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qKtoVnfVquFbfHQu5HNshlJAnIK31c847SCQq/ol1qNza9ry
	uutU8+xmksZMI0sLaDlrXYsEKtvqPsw3SCjfLWIizlMaEQ/1JWK7QrS2DCPsnNdK4Ijr/5jGR6s
	ZBL5UEmltn5MqqQo+SD4ygGTbd0M=
X-Gm-Gg: ASbGncuCMCsOGY+5OwJWGt0FI7WxfT3h4QOASpqUpb8HKO3qgnRBwvqhH0HyDih0h69
	egki+Kvzbnwi0vDvbU4sg7fbuLPZ3fqVz
X-Google-Smtp-Source: AGHT+IEuhffoilVAynztg0PraImdh7qfFg+O+uctebKpKqpDYUbkAQXxfUdbtefy6lqcVLRrM6np0YGYmPWCIDO0ROE=
X-Received: by 2002:a05:6122:2a41:b0:510:185:5d9c with SMTP id
 71dfb90a1353d-51556a3e2b4mr11871026e0c.11.1732849661348; Thu, 28 Nov 2024
 19:07:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com> <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
 <ZzrA5nXldoE2PWx4@casper.infradead.org> <7e617fe7-388f-43a1-b0fa-e2998194b90c@huawei.com>
 <CAGsJ_4yA5graSSE3cBf_RB=cGc3hLpcB-3pR9ymVfzKx_dg3Zg@mail.gmail.com> <bf98a80a-2be0-413f-8a7a-34bb17f053cc@huawei.com>
In-Reply-To: <bf98a80a-2be0-413f-8a7a-34bb17f053cc@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Nov 2024 16:07:29 +1300
Message-ID: <CAGsJ_4zqL8ZHNRZ44o_CC69kE7DBVXvbZfvmQxMGiFqRxqHQdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: chenridong <chenridong@huawei.com>
Cc: Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, david@redhat.com, 
	ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 3:25=E2=80=AFPM chenridong <chenridong@huawei.com> =
wrote:
>
>
>
> On 2024/11/29 7:08, Barry Song wrote:
> > On Mon, Nov 25, 2024 at 2:19=E2=80=AFPM chenridong <chenridong@huawei.c=
om> wrote:
> >>
> >>
> >>
> >> On 2024/11/18 12:21, Matthew Wilcox wrote:
> >>> On Mon, Nov 18, 2024 at 05:14:14PM +1300, Barry Song wrote:
> >>>> On Mon, Nov 18, 2024 at 5:03=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> >>>>>
> >>>>> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> >>>>>> 2. In shrink_page_list function, if folioN is THP(2M), it may be s=
plited
> >>>>>>    and added to swap cache folio by folio. After adding to swap ca=
che,
> >>>>>>    it will submit io to writeback folio to swap, which is asynchro=
nous.
> >>>>>>    When shrink_page_list is finished, the isolated folios list wil=
l be
> >>>>>>    moved back to the head of inactive lru. The inactive lru may ju=
st look
> >>>>>>    like this, with 512 filioes have been move to the head of inact=
ive lru.
> >>>>>
> >>>>> I was hoping that we'd be able to stop splitting the folio when add=
ing
> >>>>> to the swap cache.  Ideally. we'd add the whole 2MB and write it ba=
ck
> >>>>> as a single unit.
> >>>>
> >>>> This is already the case: adding to the swapcache doesn=E2=80=99t re=
quire splitting
> >>>> THPs, but failing to allocate 2MB of contiguous swap slots will.
> >>>
> >>> Agreed we need to understand why this is happening.  As I've said a f=
ew
> >>> times now, we need to stop requiring contiguity.  Real filesystems do=
n't
> >>> need the contiguity (they become less efficient, but they can scatter=
 a
> >>> single 2MB folio to multiple places).
> >>>
> >>> Maybe Chris has a solution to this in the works?
> >>>
> >>
> >> Hi, Chris, do you have a better idea to solve this issue?
> >
> > Not Chris. As I read the code again, we have already the below code to =
fixup
> > the issue "missed folio_rotate_reclaimable()" in evict_folios():
> >
> >                 /* retry folios that may have missed
> > folio_rotate_reclaimable() */
> >                 list_move(&folio->lru, &clean);
> >
> > It doesn't work for you?
> >
> > commit 359a5e1416caaf9ce28396a65ed3e386cc5de663
> > Author: Yu Zhao <yuzhao@google.com>
> > Date:   Tue Nov 15 18:38:07 2022 -0700
> >     mm: multi-gen LRU: retry folios written back while isolated
> >
> >     The page reclaim isolates a batch of folios from the tail of one of=
 the
> >     LRU lists and works on those folios one by one.  For a suitable
> >     swap-backed folio, if the swap device is async, it queues that foli=
o for
> >     writeback.  After the page reclaim finishes an entire batch, it put=
s back
> >     the folios it queued for writeback to the head of the original LRU =
list.
> >
> >     In the meantime, the page writeback flushes the queued folios also =
by
> >     batches.  Its batching logic is independent from that of the page r=
eclaim.
> >     For each of the folios it writes back, the page writeback calls
> >     folio_rotate_reclaimable() which tries to rotate a folio to the tai=
l.
> >
> >
> >     folio_rotate_reclaimable() only works for a folio after the page re=
claim
> >     has put it back.  If an async swap device is fast enough, the page
> >     writeback can finish with that folio while the page reclaim is stil=
l
> >     working on the rest of the batch containing it.  In this case, that=
 folio
> >     will remain at the head and the page reclaim will not retry it befo=
re
> >     reaching there.
> >
> >     This patch adds a retry to evict_folios().  After evict_folios() ha=
s
> >     finished an entire batch and before it puts back folios it cannot f=
ree
> >     immediately, it retries those that may have missed the rotation.
> >     Before this patch, ~60% of folios swapped to an Intel Optane missed
> >     folio_rotate_reclaimable().  After this patch, ~99% of missed folio=
s were
> >     reclaimed upon retry.
> >
> >     This problem affects relatively slow async swap devices like Samsun=
g 980
> >     Pro much less and does not affect sync swap devices like zram or zs=
wap at
> >     all.
> >
> >>
> >> Best regards,
> >> Ridong
> >
> > Thanks
> > Barry
>
> Thank you for your reply, Barry.
> I found this issue with 5.10 version. I reproduced this issue with the
> next version, but the CONFIG_LRU_GEN_ENABLED kconfig is disabled. I
> tested again with  CONFIG_LRU_GEN_ENABLED enabled, and this issue can be
> fixed.
>
> IIUC, the 359a5e1416caaf9ce28396a65ed3e386cc5de663 commit can only work
> when CONFIG_LRU_GEN_ENABLED is enabled, but this issue exists when
> CONFIG_LRU_GEN_ENABLED is disabled and it should be fixed.
>
> I read the code of commit 359a5e1416caaf9ce28396a65ed3e386cc5de663, it
> found folios that are missed to rotate in a more complicated way, but it
>  makes it much clearer what is being done. Should I implement in Yu
> Zhao's way?

yes. this is completely the same thing.
since Yu only fixed in mglru and you are still using active/inactive,
the same fix should apply to active/inactive lru.


>
> Best regards,
> Ridong

thanks
barry

