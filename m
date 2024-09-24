Return-Path: <linux-kernel+bounces-337290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B698483F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCDB284026
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290C1AB52F;
	Tue, 24 Sep 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaeMKMgw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B7EEB3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190496; cv=none; b=JGnHJ1jIT1QxPnjnpophoTU01+ERWDzrwpRSyQeTRKMHZDFOsrp0Yd7In4XZaPgfCZCRCY6hQA39F/Xlw7oeciviEjy5rLVVZuTy1V0Vqxm4UT5CJhaaOgClu129W9aPm9YBxRZ8KReVBPWl9Yl8EvuVec/7mXiRWsKT39Bvt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190496; c=relaxed/simple;
	bh=txe05EkN78YSxQ+w4D5wPuMdBXQ+DuV8uIQKXYfBCqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH/Y3krGrIEUFyRYhsMWz4jmaeVKzubZDNnRQnEW9aslxrPiz8yQzuOHt6DTuUxbDnUsC+22gSYAsfebrNXU56JqtJ7OqFdE/sAr8EO9UlUqJ4QHWHSf2kYzPHMRLMQTJy21bQWrG7nHYDqL+3HJ059jy2F4Uc6Wr0GuTuriGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaeMKMgw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so3753617a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727190493; x=1727795293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txe05EkN78YSxQ+w4D5wPuMdBXQ+DuV8uIQKXYfBCqg=;
        b=zaeMKMgwNpkUKuK6nvT56hzNHis6sF0LSzqLDfBBGB6hPCn7Xhu9ZG0GKNqlD0Q3pJ
         /8IxSuoLSGdmgkQxgWiVwZW/8tEcP9p5HexhMa+mYGR79BNoQOWHuMuy5aQbQX2JeSKR
         0caWPV9qV8sfojaaccZ5MKX4MKwxnF8BbVvA0gYLkP/g365HynVVI0DF5GeyDH0fivWe
         itj8/2ACtMVr1yJzmeY1UgCq2E/mY0d8T88FL24BQJA3EggfypaNHl7nhxlfqyqtzI6W
         QyjXmcdnLaGuI3r0I4ZE4xMO4ro2mo6ElW5iOInHk0jL9pyKF3tMUQr/5GDCROzO4Vrp
         0bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727190493; x=1727795293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txe05EkN78YSxQ+w4D5wPuMdBXQ+DuV8uIQKXYfBCqg=;
        b=Sdm31md2RfJS+Bl/5oAILFf4b2CE3rxXm7+Fcy0M3z6jKSdNkzWI1ZkLnD/tSBjI03
         W+Dmc5EusZS8jyCLSVPnwh2gm3rFjY9yoQ5CyHXlCJK2uBqEetPqXAO5Tq8AX1WdiNu5
         XmswWiaFK5mefXcegn2293dJ0GOozWOndrpYUn1quItHmkCa3Y30ydO29/l3DTVGFUBs
         w+YJsxIwvcNwA2DLXDFJXMLX4jtOTJJisCkNTwVaSNA5lOyaE1tYI9BQhdkWDVTCHoKf
         2XAYhoW2G/HdoF4a4XCQNF3GVTwn8zgVPSVsncMNQO1sMfoX1SBZUDBsDera9Wliul2f
         WYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWFNC/BiibPBLr37/207cQHVnjxBTv4Qwb3EsXugc0RnxN6+UaxiWiHqQURuQ1TBL1SEko4PGVPsBDOWlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9h4w5vxlxYW4E5FbL91qcEK6f1mQ4lrwhThQa0YLZaa6lFwGu
	j7dQYmby2hnbfX7lWqPWOZ9sGm937sfW1NhNEa4OpvKu7BWOCoHPipFoUvgaO4yg+6wDls9unkn
	o+Ki9nzcuh/m+8nK6u/Cr0m69Ke9lzh/SUHWs
X-Google-Smtp-Source: AGHT+IHWQ32+4fKQOYz5Y4zM1Cg77Ilylj/RMv9JiMX5KJvXcem0wZpM07wcBHBoO5LF3JgjmwtoDqoMYzV0iXr24o4=
X-Received: by 2002:a17:907:d2db:b0:a8d:f04:b19b with SMTP id
 a640c23a62f3a-a90d4fbcfd5mr1484565566b.2.1727190492533; Tue, 24 Sep 2024
 08:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
In-Reply-To: <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 08:07:33 -0700
Message-ID: <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, chrisl@kernel.org, 
	david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 7:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Sep 23, 2024 at 8:25=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> > On 2024/9/24 10:15, Yosry Ahmed wrote:
> > > On Mon, Sep 23, 2024 at 6:55=E2=80=AFPM Baolin Wang
> > > <baolin.wang@linux.alibaba.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2024/9/24 07:11, Nhat Pham wrote:
> > >>> The SWAP_MAP_SHMEM state was originally introduced in the commit
> > >>> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determi=
ne if a
> > >>> swap entry belongs to shmem during swapoff.
> > >>>
> > >>> However, swapoff has since been rewritten drastically in the commit
> > >>> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> > >>> having swap count =3D=3D SWAP_MAP_SHMEM value is basically the same=
 as having
> > >>> swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously to
> > >>> swap_duplicate()
> > >>>
> > >>> This RFC proposes the removal of this state and the associated help=
er to
> > >>> simplify the state machine (both mentally and code-wise). We will a=
lso
> > >>> have an extra state/special value that can be repurposed (for swap =
entries
> > >>> that never gets re-duplicated).
> > >>>
> > >>> Another motivation (albeit a bit premature at the moment) is the ne=
w swap
> > >>> abstraction I am currently working on, that would allow for swap/zs=
wap
> > >>> decoupling, swapoff optimization, etc. The fewer states and swap AP=
I
> > >>> functions there are, the simpler the conversion will be.
> > >>>
> > >>> I am sending this series first as an RFC, just in case I missed som=
ething
> > >>> or misunderstood this state, or if someone has a swap optimization =
in mind
> > >>> for shmem that would require this special state.
> > >>
> > >> The idea makes sense to me. I did a quick test with shmem mTHP, and
> > >> encountered the following warning which is triggered by
> > >> 'VM_WARN_ON(usage =3D=3D 1 && nr > 1)' in __swap_duplicate().
> > >
> > > Apparently __swap_duplicate() does not currently handle increasing th=
e
> > > swap count for multiple swap entries by 1 (i.e. usage =3D=3D 1) becau=
se it
> > > does not handle rolling back count increases when
> > > swap_count_continued() fails.
> > >
> > > I guess this voids my Reviewed-by until we sort this out. Technically
> > > swap_count_continued() won't ever be called for shmem because we only
> > > ever increment the count by 1, but there is no way to know this in
> > > __swap_duplicate() without SWAP_HAS_SHMEM.
>
> Ah this is my bad. I compiled with CONFIG_THP_SWAP, but forgot to
> remove the swapfile check (that's another can of worms, but I need
> data before submitting the patch to remove it...)
>
> One thing we can do is instead of warning here, we can handle it in
> the for loop check, where we have access to count - that's the point
> of having that for-loop check anyway? :)
>
> There's a couple of ways to go about it:
>
> 1. VM_WARN_ON(usage =3D=3D 1 && nr > 1 && count !=3D 0 );

Hmm that should work, although it's a bit complicated tbh.

> (or more accurately, (count & ~COUNT_CONTINUED) >=3D SWAP_MAP_MAX))

I think this will make the warning very hard to hit if there's a
misuse of __swap_duplicate(). It will only be hit when an entry needs
count continuation, which I am not sure is very common. If there's a
bug, the warning will potentially catch it too late, if ever.

The side effect here is failing to decrement the swap count of some
swap entries which will lead to them never being freed, essentially
leaking swap capacity slowly over time. I am not sure if there are
more detrimental effects.

>
> 2. Alternatively, instead of warning here, we can simply return
> -ENOMEM. Then, at shmem callsite, have a VM_WARN_ON/VM_BUG_ON(), since
> this MUST succeed.

We still fail to rollback incremented counts though when we return
-ENOMEM, right? Maybe I didn't get what you mean.

>
> Either solutions should follow with careful documentation to make it
> clear the expectation/guarantee of the new API.
>
> Yosry, Baolin, how do you two feel about this? Would something like
> this work? I need to test it first, but let me know if I'm missing
> something.
>
> If this does not work, we can do what Baolin is suggesting, and
> perhaps maintain the swap_shmem_alloc() helper. It's less than ideal,
> but at least we still lose a state...

Depending on the complexity tbh, right now removing SWAP_MAP_SHMEM is
just a cleanup with small wins, so if it's too complicated to remove
it it may not be worth it. I am assuming with your ongoing work, it
becomes much more valuable, so maybe if it's too complicated we can
defer it until the benefits are realizable?

