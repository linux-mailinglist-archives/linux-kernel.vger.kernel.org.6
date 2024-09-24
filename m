Return-Path: <linux-kernel+bounces-337340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98D9848D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C1283DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805119B3F3;
	Tue, 24 Sep 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6QOvEpT"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF537168DC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727192903; cv=none; b=PUz+6rYCV5GYE58RNoq1gSOKIf6ezhcz73Kbu4e+aJfFz/XAO58O20AqrTuBmBb5p5ZabnUtvcQLNeO0R9Rk/bvCStXVkK7Db8O6CdGQ0kQtBkzjZ3bDVIEooWJr/zWyFUOJPJbfsAlZ5x1jLHDJHZ1IdukI6iAuHk4OvpDWfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727192903; c=relaxed/simple;
	bh=IIOfONdMZKtrLAeNANm9d7V+8VFVNVjKHSNrv20ztCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmwL7W7eEQj36qcuzYQz6m0e4bGE4yC4XY2IpY7oDODbHt9h2RLLh3z+P2cm4ZvjVs/L0+EqydDrPsnSTIGRfpJnvBAWxTIdSYCAOcmIRDZJTN9dgQ3Vt9vAUNJ25MNzh8v2T4vhuoXFI4G++RdsPpHHHMpcDFlWyP2L8aFXs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6QOvEpT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso51431566d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727192901; x=1727797701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04wmdnC8h/x5cUtDCBufySp5GXdDQG3ibVfSh0oRqk0=;
        b=E6QOvEpTYcDIoSLrODWWtP7rzTe593uxE+nMD8GIV3+hOtC0dSw1sxZsiQTocErZw0
         gRx/n6vh7qgLKpdItV9BzpBPk/qW5XP9yxNk3GUS7ZQwhUOSvCu9AqE8kvaVpyd8Xzgg
         BK3HAtZkhKaQKAI6U565lxDNHJ7HYymk4u31pc9Od9LsswWz9TGqb0LtlQrK3yEIRRj0
         Xvs7WI8Se0g0SFEGRuLHSP3eZz1+qcz3d3s/31yTBgiVtQlmuSf/aBpXeBkdSY5DSbV5
         5JqkwDDwLejzO8MkZ2xFdj8e/KYsTwktvn6+ovS4r9st39MqVSlC5+tU77gVpbUg6QCA
         XX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727192901; x=1727797701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04wmdnC8h/x5cUtDCBufySp5GXdDQG3ibVfSh0oRqk0=;
        b=aobNNpaMQLXXWm0JfBU18rhFYnvZ6aQWcrLfTDnFocdJB1JyUptrJKEnCaximWbphR
         vsEijT8RfOpGNK5941sGLVlxSY+ATeej1xY56QV294p+yeIKTXFywaPq/slPrjRi7VT9
         MOnKbONVokeGI6oSH9yENqRfFAd92JcChufHOichpyn9AWV1+SBhUISBC6ncTCleiU+F
         z0rwTxgw3+cjh/XNhKvuzA+/kSHtRl5cAbn3SnEWi5KvaX0e1hlHkZLAXDup/s/Dwsk3
         m1Yb6lu07CDQMxr1EcDBDVMMO8WcPNJLj0IbDyECNnpzGQiEmiSORG4C8AS2vZIWBFvj
         2FKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrXaPvaaQT0uXYqnLpjz3YiqYiekUeIPoP4PDONaTztqP+W+6kRaKVLsRoxvTjTeyUClEwX6Qn6+evtU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VoGt4QAq/wTwBtnmkHKWgKU4cFezjo3cw6RKUoA/YHMU+Yvq
	RZ+yyAdeaAR0/G6KDRX/dt7DhKGXGnwIqAs4pOZ/ZIZs8vnzmi5s8tiob4QuX3g71hmj4EFUHTD
	IvsBnEQfoqm/TlN1qnUQrjQT53CM=
X-Google-Smtp-Source: AGHT+IHJAhU8h0nLzZdcIkTMioVsHewyXYTfciPeaGEmHAvNWxX1jPN0ETXQY9ayQlnsSIrq7KmpomE/DlvGRPrXyRs=
X-Received: by 2002:a05:6214:3d87:b0:6c4:6f3e:d955 with SMTP id
 6a1803df08f44-6c7bc6ce13cmr291090366d6.10.1727192900615; Tue, 24 Sep 2024
 08:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
In-Reply-To: <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 08:48:09 -0700
Message-ID: <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, chrisl@kernel.org, 
	david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:08=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Sep 24, 2024 at 7:32=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Sep 23, 2024 at 8:25=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> > >
> > >
> > > On 2024/9/24 10:15, Yosry Ahmed wrote:
> > > > On Mon, Sep 23, 2024 at 6:55=E2=80=AFPM Baolin Wang
> > > > <baolin.wang@linux.alibaba.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2024/9/24 07:11, Nhat Pham wrote:
> > > >>> The SWAP_MAP_SHMEM state was originally introduced in the commit
> > > >>> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly deter=
mine if a
> > > >>> swap entry belongs to shmem during swapoff.
> > > >>>
> > > >>> However, swapoff has since been rewritten drastically in the comm=
it
> > > >>> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> > > >>> having swap count =3D=3D SWAP_MAP_SHMEM value is basically the sa=
me as having
> > > >>> swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously t=
o
> > > >>> swap_duplicate()
> > > >>>
> > > >>> This RFC proposes the removal of this state and the associated he=
lper to
> > > >>> simplify the state machine (both mentally and code-wise). We will=
 also
> > > >>> have an extra state/special value that can be repurposed (for swa=
p entries
> > > >>> that never gets re-duplicated).
> > > >>>
> > > >>> Another motivation (albeit a bit premature at the moment) is the =
new swap
> > > >>> abstraction I am currently working on, that would allow for swap/=
zswap
> > > >>> decoupling, swapoff optimization, etc. The fewer states and swap =
API
> > > >>> functions there are, the simpler the conversion will be.
> > > >>>
> > > >>> I am sending this series first as an RFC, just in case I missed s=
omething
> > > >>> or misunderstood this state, or if someone has a swap optimizatio=
n in mind
> > > >>> for shmem that would require this special state.
> > > >>
> > > >> The idea makes sense to me. I did a quick test with shmem mTHP, an=
d
> > > >> encountered the following warning which is triggered by
> > > >> 'VM_WARN_ON(usage =3D=3D 1 && nr > 1)' in __swap_duplicate().
> > > >
> > > > Apparently __swap_duplicate() does not currently handle increasing =
the
> > > > swap count for multiple swap entries by 1 (i.e. usage =3D=3D 1) bec=
ause it
> > > > does not handle rolling back count increases when
> > > > swap_count_continued() fails.
> > > >
> > > > I guess this voids my Reviewed-by until we sort this out. Technical=
ly
> > > > swap_count_continued() won't ever be called for shmem because we on=
ly
> > > > ever increment the count by 1, but there is no way to know this in
> > > > __swap_duplicate() without SWAP_HAS_SHMEM.
> >
> > Ah this is my bad. I compiled with CONFIG_THP_SWAP, but forgot to
> > remove the swapfile check (that's another can of worms, but I need
> > data before submitting the patch to remove it...)
> >
> > One thing we can do is instead of warning here, we can handle it in
> > the for loop check, where we have access to count - that's the point
> > of having that for-loop check anyway? :)
> >
> > There's a couple of ways to go about it:
> >
> > 1. VM_WARN_ON(usage =3D=3D 1 && nr > 1 && count !=3D 0 );
>
> Hmm that should work, although it's a bit complicated tbh.
>
> > (or more accurately, (count & ~COUNT_CONTINUED) >=3D SWAP_MAP_MAX))
>
> I think this will make the warning very hard to hit if there's a
> misuse of __swap_duplicate(). It will only be hit when an entry needs
> count continuation, which I am not sure is very common. If there's a
> bug, the warning will potentially catch it too late, if ever.
>
> The side effect here is failing to decrement the swap count of some
> swap entries which will lead to them never being freed, essentially
> leaking swap capacity slowly over time. I am not sure if there are
> more detrimental effects.
>
> >
> > 2. Alternatively, instead of warning here, we can simply return
> > -ENOMEM. Then, at shmem callsite, have a VM_WARN_ON/VM_BUG_ON(), since
> > this MUST succeed.
>
> We still fail to rollback incremented counts though when we return
> -ENOMEM, right? Maybe I didn't get what you mean.

My understanding now is that there are two for loops. One for loop
that checks the entry's states, and one for loop that does the actual
incrementing work (or state modification).

We can check in the first for loop, if it is safe to proceed:

if (!count && !has_cache) {
    err =3D -ENOENT;
} else if (usage =3D=3D SWAP_HAS_CACHE) {
if (has_cache)
    err =3D -EEXIST;
} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
    err =3D -EINVAL;
} else if (usage =3D=3D 1 && nr > 1 && (count & ~COUNT_CONTINUED) >=3D
SWAP_MAP_MAX)) {
    /* the batched variants currently do not support rollback */
    err =3D -ENOMEM;
}

At this point, IIUC, we have not done any incrementing, so no rollback
needed? :)

>
> >
> > Either solutions should follow with careful documentation to make it
> > clear the expectation/guarantee of the new API.
> >
> > Yosry, Baolin, how do you two feel about this? Would something like
> > this work? I need to test it first, but let me know if I'm missing
> > something.
> >
> > If this does not work, we can do what Baolin is suggesting, and
> > perhaps maintain the swap_shmem_alloc() helper. It's less than ideal,
> > but at least we still lose a state...
>
> Depending on the complexity tbh, right now removing SWAP_MAP_SHMEM is
> just a cleanup with small wins, so if it's too complicated to remove
> it it may not be worth it. I am assuming with your ongoing work, it
> becomes much more valuable, so maybe if it's too complicated we can
> defer it until the benefits are realizable?

I agree :)

