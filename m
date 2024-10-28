Return-Path: <linux-kernel+bounces-383982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C54F9B22C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A73282031
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027415B54C;
	Mon, 28 Oct 2024 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb0IHodh"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8E14EC7E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082750; cv=none; b=gR6pD2q/7YLfPJ3XyYLHV2WqPaJUYQseCfF2JiuI9Q+2Y748zY5YyME4C0c5f9556zmCKAnZ0FyZuJGoIyUv3iMjVgoCrZeqkw1r0U55Ivil+d/Yz/tAxC++2uc+wfOIRHg+L1sLnTsk8ruXqD1XBw9/ykQtdCTH7+gpVrqG0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082750; c=relaxed/simple;
	bh=kRU46fFJSWTvTE9azsOVFdvCcZhQWHNPT5RuN/5wiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlUNTuEJH0F1Bx570WnpMlbUu347vuJJik+dSwGVN6+eRz8Fr9n26WDtSqj165cBZEH8NaM4srCPOtHWVL3WiJuVeZsid5I3xLzXBtVefPOJ/FVaKjW/MVgyaRIlD2tyg+rufsBNzdKVCPYQ74iFqL0ycdEZiAI53q5zkO5FEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb0IHodh; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d32d82bd8so891792e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730082747; x=1730687547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRU46fFJSWTvTE9azsOVFdvCcZhQWHNPT5RuN/5wiCc=;
        b=Nb0IHodhqs1oqcN8cwXxNd2G0V4Su7Izs8S0fChF7Zui882wx4azzo2bkdk0ncII30
         iAqjJCHTBnF3IwTOalu0FA/lJ5WOsIb6wuFLmKfrKBCrDUckiB4cSTbeKnEluww1PxDh
         T75OKJaLZzbGcPmfju/cwD2i3WyVC7nXXBY7cMdvBn8UF4MEtEOrS0MPNFtHMDbBYo0V
         pTlanNIenC2YuYm1w2a+oKQdiNv3BgFjk5GBi7NfRQs197IrNF3c/gZRMSusFiiPsXGA
         1NdLvQYc+VgalkNH3D5C9r6GM2PMlxIdGQJ96wwKxF1dpEtyBLd8Zg6bt9/akwk6ujFX
         F8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730082747; x=1730687547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRU46fFJSWTvTE9azsOVFdvCcZhQWHNPT5RuN/5wiCc=;
        b=G9y2GRq8yKqNM+Bvx/j90nopvWyDlQvl9OFpJce+YYlcAFymvqWbmco0yKGSl3tTm8
         eSss6TUaB56Zlfz78iF4/C373KG+o1oG/hIeC1WGr+FgrB9zxDTMeFThGjFex58vByOE
         qiuoMjKb3XWGq9sMnU6rDM3TtVm4SDzxn91O8So94JDe6o5DS0sONU8uaBZQ3dlBTV4o
         8DJsTHsivCsT2Po1wkWVRkGFuRzvkh4tm8aGSgrFKR4vKjEn3At+//AFvnyNSHgkP1Tp
         0iqhZ3lsHz73Rv2jS1T5Me5gHsWuV0x77roxJAAqXLT5B4o4YsZifRYGgkaBRycgHxMS
         +B+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNZ9zARM9n59B7WeVC7PIz/tKQziNWO6vthnLCcbi3lWlr6Lu1RAx+qwRvTlXm0EudyD98DkJWHbsrNlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwptlUO8idhOC5o4AlZ1s/WAbBavlZ7W1ycdOyGrkAqqJfy7Ht4
	BmJ9YuRT3zjXERgbRCYmgVljO/yYVWKGPYD18d0rtrtiQXIbJVsKKzQ6lqEhAlZkyaHsY2ekCXO
	g0YWDeTVTp1080klTpQf94tWnKl0=
X-Google-Smtp-Source: AGHT+IGAKGiQtxNNjWP/suVkwlm9F3CfEs6lSxe8RO2adHAovmGXLEAuKHiz6aysVLjsKqnboadCYmweD4cQxJUO5WY=
X-Received: by 2002:a05:6122:1d8a:b0:50d:4b8d:673c with SMTP id
 71dfb90a1353d-51014e9d0b8mr3266190e0c.0.1730082747482; Sun, 27 Oct 2024
 19:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Oct 2024 15:32:16 +1300
Message-ID: <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 3:45=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Sat, Oct 26, 2024 at 6:20=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When the proportion of folios from the zero map is small, missing their
> > accounting may not significantly impact profiling. However, it=E2=80=99=
s easy
> > to construct a scenario where this becomes an issue=E2=80=94for example=
,
> > allocating 1 GB of memory, writing zeros from userspace, followed by
> > MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> > and swap-in counts seem to vanish into a black hole, potentially
> > causing semantic ambiguity.
>
> I agree. It also makes developing around this area more challenging.
> I'm working on the swap abstraction, and sometimes I can't tell if I
> screwed up somewhere, or if a proportion of these allocated entries go
> towards this optimization...
>
> Thanks for taking a stab at fixing this, Barry!
>
> >
> > We have two ways to address this:
> >
> > 1. Add a separate counter specifically for the zero map.
> > 2. Continue using the current accounting, treating the zero map like
> > a normal backend. (This aligns with the current behavior of zRAM
> > when supporting same-page fills at the device level.)
>
> Hmm, my understanding of the pswpout/pswpin counters is that they only
> apply to IO done directly to the backend device, no? That's why we
> have a separate set of counters for zswap, and do not count them
> towards pswp(in|out).
>
> For users who have swap files on physical disks, the performance
> difference between reading directly from the swapfile and going
> through these optimizations could be really large. I think it makes
> sense to have a separate set of counters for zero-mapped pages
> (ideally, both at the host level and at the cgroup level?)

agree it is better to have a separate counter for zeromap.
then it raises a question: what is the proper name for it :-)

zeromap_swpin, zeromap_swpout seems too long? and zswpin
and zswpout have been used by zswap

Thanks
barry

