Return-Path: <linux-kernel+bounces-338061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83009852E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019D6284436
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804D154C0C;
	Wed, 25 Sep 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQhUT79k"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E3647
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245627; cv=none; b=fj5nMrdeOrfPA7ruD+QXq2IQEDNkycO9YmMbAEMkzQNLfWmnotIrBvLFfGIagTOUwZgP3IbqgCsRz+XMoOIM9933iTrrU9tfNUW/7Sd5QLrangCwrPxipfozIAC56+vdwl7FXByZKCZvlCDeoI65wlJR/t3cXh5vMkvO5Kgr9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245627; c=relaxed/simple;
	bh=phiexKold0sDHr3JxqDtJdbcNcwwUnlT+SL3OxZCTt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2FBRv5hRr2Opjko5rK+oKdZjhzSsfrc/zg5jZw9zSsiqSE5i0PLHl0koy/1NVhiawHACrxQcHIORY0O/2QQKBQCi+0nKoT+BZKOB4Nz7/kUnxBmZoXSHojLnWe1oCM6mU0KX1kn8ak0p0d9rlXbcvhX4tQqXRrKIrcaewFRIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQhUT79k; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49bd76face1so416519137.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727245625; x=1727850425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw2KumctdM5J/ktaLv2+p8EP/6GhqY7xK+IMjtOjZwk=;
        b=DQhUT79kKpHODl3UWgKzlPV8HMIq4o/RmevxUs9Us4sNibjf2luyYVlQWFhxHcw5tT
         wXEpZjhJKmuMk3G2At7Jw+LbEqfGR/2UKvM3/MRBsdk39Marft4HKOTaGI/kWbBBVpvX
         yRdWC5mKEYCgkWRlR15IbI0+06PhaBJma58M8Pj9x0tEGJDOqV5jeo4MFTRE9Siq6yD2
         RugIIe/sSJtT0n0aXs5B/yYOKMZSBIly3u+KcznOmP8b6GuzBM+GgjqnoqLDpOyaUFPh
         /MSA1O1KAn0tomQDT5T93RhtLjDF9hK4rs+ZcYZzd9aelmMq5t6Ek1LaU7/DPT9K7KYE
         K40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727245625; x=1727850425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw2KumctdM5J/ktaLv2+p8EP/6GhqY7xK+IMjtOjZwk=;
        b=mTumqwWg1YxQYe9pcGyxnLUIrKY4io+KzUIjYdzrtW49Trph1ho96KXbNxUuq1SLUl
         two6AhO3epocQvfUl6pAzvAEIEAjCGCLofVjvdeuBwmA/iUHFu+FtuLojrTYPv/VsLjy
         AF/sptjve5+2hE4gr7+YDOiNoV7XUb8SfV0mlYk4xANh0MrhWtPeHLlmxJjhd4CiM0iy
         toNifq/BnZIAPYp3ZdTVwwfuIEem385ZggyKu6DNced5VVhwd0v4MZqj4CqhTE4Pxzgd
         YteU/lzKpq4MFb+pMkytJQtw9FFPz87i/xfOQd3gvXosbzn5y0H6xiHstyGEyBAsJjak
         mAAA==
X-Forwarded-Encrypted: i=1; AJvYcCVY8S89eQIpuFqbBC4FnOV3eHCMq65NRtJb2Lkm1Yj5fnk2RZkNJ/TXn8VV+VxK8rCdLdA80v2WWX3RzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jsm0iCpwJ170vxWRdblTA0VAee/JhhbADENr49tuV+mqb606
	QJb6M9MhZIEQvg96zYGTzkY4gDKAk0UjN+yVvnXRKp5nb23nQdfc0X58cEY8Kg5b9KpbwVNek/0
	zleI7sbBb+k9SbZUibrPw7OIf08c=
X-Google-Smtp-Source: AGHT+IGvdSE72ZOSM1zF21YJkmzPxuDbV43RU1LlEgRSjp1vtfjmV6s9Rr9DU8IyTbWXn6xb1YS4oQINdfs8ya2Ados=
X-Received: by 2002:a05:6102:5492:b0:49b:f8f4:6a77 with SMTP id
 ada2fe7eead31-4a14e957527mr4697244137.5.1727245624726; Tue, 24 Sep 2024
 23:27:04 -0700 (PDT)
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
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com> <CAJD7tkaZwkBbMPaL0mUNyftOUxOgMsAk1KDupZqPq0SO-zeZcg@mail.gmail.com>
In-Reply-To: <CAJD7tkaZwkBbMPaL0mUNyftOUxOgMsAk1KDupZqPq0SO-zeZcg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Sep 2024 14:26:52 +0800
Message-ID: <CAGsJ_4yMxNsmPJn0W9puKWcQD3T7RDyQ=QmPhAtoq=3_u=m+TQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 2:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> > > > > > Apparently __swap_duplicate() does not currently handle increas=
ing the
> > > > > > swap count for multiple swap entries by 1 (i.e. usage =3D=3D 1)=
 because it
> > > > > > does not handle rolling back count increases when
> > > > > > swap_count_continued() fails.
> > > > > >
> > > > > > I guess this voids my Reviewed-by until we sort this out. Techn=
ically
> > > > > > swap_count_continued() won't ever be called for shmem because w=
e only
> > > > > > ever increment the count by 1, but there is no way to know this=
 in
> > > > > > __swap_duplicate() without SWAP_HAS_SHMEM.
> > > >
> > > > Ah this is my bad. I compiled with CONFIG_THP_SWAP, but forgot to
> > > > remove the swapfile check (that's another can of worms, but I need
> > > > data before submitting the patch to remove it...)
> > > >
> > > > One thing we can do is instead of warning here, we can handle it in
> > > > the for loop check, where we have access to count - that's the poin=
t
> > > > of having that for-loop check anyway? :)
> > > >
> > > > There's a couple of ways to go about it:
> > > >
> > > > 1. VM_WARN_ON(usage =3D=3D 1 && nr > 1 && count !=3D 0 );
> > >
> > > Hmm that should work, although it's a bit complicated tbh.
> > >
> > > > (or more accurately, (count & ~COUNT_CONTINUED) >=3D SWAP_MAP_MAX))
> > >
> > > I think this will make the warning very hard to hit if there's a
> > > misuse of __swap_duplicate(). It will only be hit when an entry needs
> > > count continuation, which I am not sure is very common. If there's a
> > > bug, the warning will potentially catch it too late, if ever.
> > >
> > > The side effect here is failing to decrement the swap count of some
> > > swap entries which will lead to them never being freed, essentially
> > > leaking swap capacity slowly over time. I am not sure if there are
> > > more detrimental effects.
> > >
> > > >
> > > > 2. Alternatively, instead of warning here, we can simply return
> > > > -ENOMEM. Then, at shmem callsite, have a VM_WARN_ON/VM_BUG_ON(), si=
nce
> > > > this MUST succeed.
> > >
> > > We still fail to rollback incremented counts though when we return
> > > -ENOMEM, right? Maybe I didn't get what you mean.
> >
> > My understanding now is that there are two for loops. One for loop
> > that checks the entry's states, and one for loop that does the actual
> > incrementing work (or state modification).
> >
> > We can check in the first for loop, if it is safe to proceed:
> >
> > if (!count && !has_cache) {
> >     err =3D -ENOENT;
> > } else if (usage =3D=3D SWAP_HAS_CACHE) {
> > if (has_cache)
> >     err =3D -EEXIST;
> > } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
> >     err =3D -EINVAL;
> > } else if (usage =3D=3D 1 && nr > 1 && (count & ~COUNT_CONTINUED) >=3D
> > SWAP_MAP_MAX)) {
> >     /* the batched variants currently do not support rollback */
> >     err =3D -ENOMEM;
> > }
>
> Hmm yeah I think something like this should work and is arguably
> better than just warning, although this needs cleaning up:
> - We already know usage !=3D SWAP_HAS_CACHE, so no need to check if usage=
 =3D=3D 1.
> - We already know (count & ~COUNT_CONTINUED) is larger than
> SWAP_MAP_MAX, so we should check if it's equal to SWAP_MAP_MAX.
> - We should probably just calculate count & ~COUNT_CONTINUED above the
> if conditions at this point.
>
> I would also like to hear what Barry thinks since he added this (and I
> just realized he is not CC'd).

I am perfectly fine with the approach, in the first loop, if we find all en=
tries
don't need CONTINUED, we can run the 2nd loop even for usage=3D=3D1
and nr > 1. this is almost always true for a real product where anon folios
are unlikely to be fork-shared by so many processes.

but we need fall back to iterating nr times if this really happens:

int swap_duplicate_nr(swp_entry_t entry, int nr)
{
   ....
   if (nr > 1 and ENOMEM) {
   for(nr entries) {
    __swap_duplicate(entry, 1, 1);
    entry =3D next_entry;
  }
}

seems a bit ugly?

maybe we can keep the swap_duplicate(swp_entry_t entry)
there? then avoid __swap_duplicate(entry, 1, 1);?

Thanks
Barry

