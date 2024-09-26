Return-Path: <linux-kernel+bounces-339868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41A986B98
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8816283D56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358E17BD5;
	Thu, 26 Sep 2024 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnaSxeNf"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA161D5ABA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323243; cv=none; b=sTAv1+LjYKz1h0nBffNoVufosJZpLfRBMCDflEYkvVksjwI0tQoN6RZ4vtjAbQRGyNLvRKiEQG47rXEBonMgwX93sab695cryhqZP8DIq9+KDHnG3WV1RF1J9AhYSKD7kgTVGK/3D3cgjm41aGQajcvmW42Z77sUaqDtbPHIREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323243; c=relaxed/simple;
	bh=mJTgPBMLZJWGDbS4W17luVJqjEhENoFdMEgTVeaCeLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHkhG5PwLLabk9qhqcJKJuzB4Ew4MFV7ADTH8MID1/cg0+q47B0NQ5V0Q5XbX7OWIcXl2kPQyxCsjaBhC4uzfqaMfuw0YbgKICw9oNFBMnFEbYtWLRwu3/jsJkJIIwVEh+7D60ZuNC/86V7J30NUmgE3PtgqDfjNy/h6EmGUbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnaSxeNf; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49bcfbc732eso219143137.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727323241; x=1727928041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSWg3M+knHgctkAGQzD17TDx9FvV3XHYgbLL+DuknZg=;
        b=jnaSxeNfucJFRv1QtUJK6f6FTInp8lY0y6W0kL/IFVHHpHceErY13ItHngFsA4JOl1
         +XIQ4qfDnbNLgNm5heCRR6hbNBsPbvMfgWcTpnc9rTgAfzo1l8Jokl7vJUX6SwbJurrh
         abSTEO/Mz4t4Rbo3vjEeYs91aba2mXeiXxkmrfXTAITYZSvQWP0oSBi3Xc4MHscOn0NW
         hWe5pkbRTZRzrYxm1+WtAwaWmq61mSEb4puk9+BhJ9Rwfod0WbhSE5GDVvwnu5yX2h/a
         jAa+3s85/v094rMLENPuqKJAK1zw1T38H9oUEtXmJpnsb08SClMgv1Y70rt19e/ZhTIm
         flEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727323241; x=1727928041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSWg3M+knHgctkAGQzD17TDx9FvV3XHYgbLL+DuknZg=;
        b=qWZBRENg11wa2jZS+DppVmx9UzE/bZWSpArZRndCP2lDLN0UWR8P6qg7mbVFD61oet
         ZNl1TGCg1BtAfGqWDVE1/replJCuLuQz+VUg+PT/8ZgYxkdp9hceCuYjjO/5wSfYXxue
         KmdZXcSQmp0QwZ78F4P/ppoFmlC9aDRYhmnGUJvxB+hEn77spJJ+4SLQTIwtB/6/cDRx
         4id9OkRY200FYD+7nWV8jfb5kgg+aAN81QCSFzZNH+Y0QtzhpuM6Z+gi7yiNGjm+vaMM
         J+EdRVjzVVUOXGXB4gT2ZuFwtsWsDMrpYyncfxZ/kJgnHckd+K6hu32cCyGqSRe6U5Aq
         L0pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVe07f407oq7+VTmoR42N2z61S0MMsjtWQ8rys8y56vCycaHWWwHV3uMM2FUgP6ewth1uGXPmlyTeh754=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NRQUWlGI/wcJqTfhIF8eHiNMI5+Y4rxj+pPrOFZgHeKpoCVS
	Psm1Ri9WRzD3s+q5nuJYyvx1G5YP/xYRMRtA3RLmVP87HO8r5hjRgOCNgDtrtj1jDAkHP8uWDty
	64m2cPuKQ6yi3KvkPgzpOBEQqOPU=
X-Google-Smtp-Source: AGHT+IHJkRePT+aq6OOlxUbxaE4Wo+2BhZ4HzMd1u6zAU7wmyDn7T1fEfkgj7fp5uhngvqnmqDiRHAg+daq0B2iSsfw=
X-Received: by 2002:a05:6102:f13:b0:49d:433b:a601 with SMTP id
 ada2fe7eead31-4a15dc7ad2amr4641777137.10.1727323240866; Wed, 25 Sep 2024
 21:00:40 -0700 (PDT)
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
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com> <CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
In-Reply-To: <CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 26 Sep 2024 16:00:25 +1200
Message-ID: <CAGsJ_4z1TvdLFybdjpOVnRX80L842xn0XYhVww646AcvL_f_ZA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Yosry Ahmed <yosryahmed@google.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:37=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Sep 24, 2024 at 6:53=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> > One benefit I can mention is that removing 'SWAP_MAP_SHMEM' can help to
> > batch free shmem swap entries in __swap_entries_free(), similar to the
> > commit bea67dcc5eea ("mm: attempt to batch free swap entries for
> > zap_pte_range()") did, which can improve the performance of shmem mTHP
> > munmap() function based on my testing.
>
> Yeah, the problem with having an extraneous state is you have to
> constantly check for it in code, and/or keep it in mind when you
> develop things. I've been constantly having to check for this state
> when I develop code around this area, and it gets old fast.
>
> If we can use it to optimize something, I can understand keeping it.
> But it just seems like dead code to me :)
>
> My preference is to do this as simply as possible - add another case
> (usage =3D=3D 1, nr > 1, and we need to add swap continuations) in the
> check in __swap_duplicate()'s first loop, and just WARN right there.
>
> That case CANNOT happen UNLESS we introduce a bug, or have a new use
> case. When we actually have a use case, we can always introduce
> handling/fallback logic for that case.
>
> Barry, Yosry, Baolin, Ying, how do you feel about this?

Hi Nhat,

I=E2=80=99m not entirely clear on your point. If your proposal is to suppor=
t the
case where usage =3D=3D 1 and nr > 1 only when we don=E2=80=99t require
CONTINUED, and to issue a warning once we determine that
CONTINUED is needed, then I=E2=80=99m completely on board with that
approach.

It seems that your intention is to simply relocate the existing warning
to the scenario where CONTINUED is actually required, rather than
maintaining a warning for the case where usage =3D=3D 1 and nr > 1 at
all times?

I wasn't actually suggesting a rollback as you posted:
     err =3D __swap_duplicate(entry, 1, nr);
     if (err =3D=3D -ENOMEM) {
         /* fallback to non-batched version */
         for (i =3D 0; i < nr; i++) {
             cur_entry =3D (swp_entry_t){entry.val + i};
             if (swap_duplicate(cur_entry)) {
                 /* rollback */
                 while (--i >=3D 0) {
                      cur_entry =3D (swp_entry_t){entry.val + i};
                      swap_free(cur_entry);
                 }

I suggested checking for all errors except -ENOMEM in the first loop. If al=
l
conditions indicate that only CONTINUED is necessary (with no other
issues like ENOENT, EEXIST, etc., for any entry), we can proceed
with a for loop for swap_duplicate(), eliminating the need for a rollback.

However, I agree that we can proceed with that only when there is actually
a user involved. (There's no need to address it right now.)

Thanks
Barry

