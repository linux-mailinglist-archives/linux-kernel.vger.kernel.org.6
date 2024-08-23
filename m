Return-Path: <linux-kernel+bounces-299325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF295D301
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2D41F21E45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59518BC2A;
	Fri, 23 Aug 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1Txo4lY"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2401191477
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429832; cv=none; b=lt9nF0c2PLbRAYZfl6ebEgD6hqD2Vh7UsgSkTyeQwi77GV8E3reSo/7tX5f7vqt/2pNrOaI3kC0cZtxJfi+QwuvTXNcSuXQn1Ez9zXwdBMXEo69qDj4F0CZ84tha8p2QlkM977pt3FvYfucUI0NeGsMmxueLBnULYws0rTKDy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429832; c=relaxed/simple;
	bh=KnP2R2SOHCKuyyL1619jImwOBRmEyKY28WF2znWJgGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arACSti+dASZvUc2iEWnjcpAISEgVWpVTXmg1fIMOVfU6dzdk3BiKmRnvMf2N9RosAJ3JZstlCOwbWYtnvH2MTif5SRzEyRLsVIkFfuT0Hof04DpGQmiY9TO4CPwZnIqSU6RO9PFRvVg2iBVs3RGxiMRPlnRmMxO+dfB8iB9/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1Txo4lY; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d2a107aebso199695ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724429830; x=1725034630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRyBChkzDJ6EdBnp4HpZAO2Elm1XGepN3U0opL5ubIU=;
        b=S1Txo4lYImKk5GLbxp3ch8S78c5yAh58zT6ppnVoFrn0a6+SF/YzEfWsP57QY3Gk1x
         39cwH8DEj1upYNwX088gQCTy6M4iu425STd57LayjFuLeiqzSaiGWHZkxCc1hlWgSSkh
         QcXtjVJtYVQqBxlhu3jyTc2EkhtOYSQhMiEwctENO9Hzw8Zpd7rhMUiQK2xpmxQYEmMM
         TnIh7P6GAzzekhm6gk9oqJhL/aYvaqzUjUv7UBKItHZIlhaO0/UNppfaCIXbwSfje4p/
         GSYuqLcRrWTUMK67oYwYHa3x2kIlY8SIBQamCp2PPN55stFdA8Q5VKQhXiQuNhJMtvSj
         LF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429830; x=1725034630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRyBChkzDJ6EdBnp4HpZAO2Elm1XGepN3U0opL5ubIU=;
        b=SiIru1PD6+WK7hO3vPdTps+v2ZUAjBuFxlyvKHfpAVxCkfTfTav+uQWoF7GzcixESP
         4l+B+XHdH1ubWzp3UJCJnOEM7ykYfCl7nERNCe9gLG654Vw5Ei3BKjuNI2ISAIIv1l0q
         zyNiYD3Pu/hX3g9b7euWitDjBqOSjQZiRwMw9hK4KZJ4DLU9cmSC+8ybQ09hC9casgxY
         1xR4jthBf0syGeO3R5RrahRnrPEzki5mS7AbnGVT+X3pFOWVEBbscbpKJKOCxS5Qzg7C
         ZTXdVmvLiJxtrcGqj/SRSPDZgHFIN33FW+ECf0Wbz7YhSGlcU4Ih5p0szKZp4GNR3jJK
         1fVw==
X-Forwarded-Encrypted: i=1; AJvYcCXGRg9KZckq7DGtpsPJn3ONLrHAqnN42LJxEh1XuwPhDQIf4FB5bVrutbAxnm7SqNr6Z4KsYmtv5SrAabU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZg7G2qH/RAlRHMJS2CLC6hRT3pYnM50dTxB077hZPgXa7qON
	Wb3TlTzEXa6MvYHZPxrCrXZGblGbSXjphYnFC0Dht+n1JW9kHKLhIb1m1675rFM5dD0G8allkUr
	BjpYBX6qiJ/4Yg4jUXBZ8Klopnxenbcmi29sn
X-Google-Smtp-Source: AGHT+IH8wuwWOfarZTVY3YLjuN0ypve1B5twUBatzYsj4K93vqQwsdzwVWr8fUx2i+lMfTFoiVulVkZnnkD3rHMAzTc=
X-Received: by 2002:a05:6e02:1649:b0:395:e031:6c1f with SMTP id
 e9e14a558f8ab-39e3c5250b6mr2841165ab.27.1724429829298; Fri, 23 Aug 2024
 09:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822025800.13380-1-hao.ge@linux.dev> <e360598c-cb58-cf9d-9247-430b8df9b3b7@huawei.com>
 <b2f51535-ca38-ac67-03b4-1aa45b2a7429@linux.dev> <CAJuCfpHUZBkGtu8CL=5cxNMtJa4iNyJ8gBVu2Ho_WOXCRzzfTA@mail.gmail.com>
 <eb021308-76f4-216f-77e2-1de8ab72b083@linux.dev> <d6f46ea8-0f09-4942-6818-a58005c8a0c1@linux.dev>
 <292d1141-4edf-ee60-a145-4ca06600076a@huawei.com> <50e74f28-5165-a45b-c152-1b18f32e61aa@linux.dev>
In-Reply-To: <50e74f28-5165-a45b-c152-1b18f32e61aa@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Aug 2024 09:16:56 -0700
Message-ID: <CAJuCfpFfw04uv4Euw_C7Kqdo59DJ-zaGJ-TPhjE3uOwxo=WTyw@mail.gmail.com>
Subject: Re: [PATCH] codetag: debug: mark codetags for pages which
 transitioned from being poison to unpoison as empty
To: Hao Ge <hao.ge@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>, kent.overstreet@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>, stable@vger.kernel.org, 
	nao.horiguchi@gmail.com, akpm@linux-foundation.org, pasha.tatashin@soleen.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 1:10=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Miaohe
>
>
> On 8/23/24 15:40, Miaohe Lin wrote:
> > On 2024/8/23 11:37, Hao Ge wrote:
> >> Hi Suren and Miaohe
> >>
> >>
> >> On 8/23/24 09:47, Hao Ge wrote:
> >>> Hi Suren and Miaohe
> >>>
> >>>
> >>> Thank you all for taking the time to discuss this issue.
> >>>
> >>>
> >>> On 8/23/24 06:50, Suren Baghdasaryan wrote:
> >>>> On Thu, Aug 22, 2024 at 2:46=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wr=
ote:
> >>>>> Hi Miaohe
> >>>>>
> >>>>>
> >>>>> Thank you for taking the time to review this patch.
> >>>>>
> >>>>>
> >>>>> On 8/22/24 16:04, Miaohe Lin wrote:
> >>>>>> On 2024/8/22 10:58, Hao Ge wrote:
> >>>>>>> From: Hao Ge <gehao@kylinos.cn>
> >>>>>>>
> >>>>>> Thanks for your patch.
> >>>>>>
> >>>>>>> The PG_hwpoison page will be caught and isolated on the entrance =
to
> >>>>>>> the free buddy page pool. so,when we clear this flag and return i=
t
> >>>>>>> to the buddy system,mark codetags for pages as empty.
> >>>>>>>
> >>>>>> Is below scene cause the problem?
> >>>>>>
> >>>>>> 1. Pages are allocated. pgalloc_tag_add() will be called when prep=
_new_page().
> >>>>>>
> >>>>>> 2. Pages are hwpoisoned. memory_failure() will set PG_hwpoison fla=
g and pgalloc_tag_sub()
> >>>>>> will be called when pages are caught and isolated on the entrance =
to buddy.
> >>>> Hi Folks,
> >>>> Thanks for reporting this! Could you please describe in more details
> >>>> how memory_failure() ends up calling pgalloc_tag_sub()? It's not
> >>>> obvious to me which path leads to pgalloc_tag_sub(), so I must be
> >>>> missing something.
> >>>
> >>> OK,Let me describe the scenario I encountered.
> >>>
> >>> In the Link [1] I mentioned,here is the logic behind it:
> >>>
> >>> It performed the following operations:
> >>>
> >>> madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE)
> >>>
> >>> and then the kernel's call stack looks like this:
> >>>
> >>> do_madvise
> >>>
> >>> soft_offline_page
> >>>
> >>> page_handle_poison
> >>>
> >>> __folio_put
> >>>
> >>> free_unref_page
> >>>
> >> I just reviewed it and I think I missed a stack.
> >>
> >> Actually, it's like this
> >>
> >> do_madvise
> >>
> >> soft_offline_page
> >>
> >> soft_offline_in_use_page
> >>
> >> page_handle_poison
> >>
> >> __folio_put
> >>
> >> free_unref_page
> >>
> >>
> >> And I've come up with a minimal solution. If everyone agrees, I'll sen=
d the patch.look this
> >>
> >> https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/page_alloc.c#L105=
6
> >>
> >> Let's directly call clear_page_tag_ref after pgalloc_tag_sub.
> > I tend to agree with you. It should be a good practice to call clear_pa=
ge_tag_ref()
> > whenever page_tag finished its work. Do you think below code is also ne=
eded?
>
> Actually, this is not necessary,It follows the normal logic of
> allocation and release.

Yes, we don't need to clear_page_tag_ref() after every
pgalloc_tag_sub(), only in this special situation. alloc_tag_sub()
resets ref->ct to NULL at the end, so not clearing the tag allows us
to catch if an extra alloc_tag_sub() is called on this page later.

>
> The actual intention of the clear_page_tag_reffunction is to indicate to
> thealloc_tag  that the page is not being returned to the
>
> buddy system through normal allocation.
>
> Just like when the page first enters the buddy system,
>
> https://elixir.bootlin.com/linux/v6.11-rc4/source/mm/mm_init.c#L2464
>
> So, can you help review this patch?

Yeah, that looks good, just spelling in the comment needs fixing. I'll
comment on that patch.
Thanks,
Suren.

>
> https://lore.kernel.org/all/20240823062002.21165-1-hao.ge@linux.dev/
>
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index de54c3567539..707710f03cf5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1104,6 +1104,7 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >          reset_page_owner(page, order);
> >          page_table_check_free(page, order);
> >          pgalloc_tag_sub(page, 1 << order);
> > +       clear_page_tag_ref(page);
> >
> >          if (!PageHighMem(page)) {
> >                  debug_check_no_locks_freed(page_address(page),
> >
> > Thanks.
> > .

