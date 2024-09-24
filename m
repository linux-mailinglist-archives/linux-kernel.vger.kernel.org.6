Return-Path: <linux-kernel+bounces-337260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F29847BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B2DB2080A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3A91AAE05;
	Tue, 24 Sep 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlQlaY8w"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECE1A76BD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188369; cv=none; b=DQdSR4QyLzTHxwLibIMffziW7lypLIAS3sflFjYT6/lPobSFJxrRQ5bxzNDls3ld76WekanAoa2tFJnpfX9sKfuJaJE/SCqUVSQqvIWOvR8nZ6uBlUDvSJnp8F3mCoDxPQFsV8l0jyERsjbgPV6t6qwM7/w9bzOMLHm9Od9Z9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188369; c=relaxed/simple;
	bh=Y+6fiaAOImA1gdNyy2VGCAfVO/VoDlfn0ifZdVX1aDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAtWWdo30EvnQQf2cG8KLaq1EEj0WNpsrN6DgJ2aHMh9RFhFfvrMOlp3h6fetvjuQQBMrqepkENT+2VYmrASZDKw2FAf9wLfGG3JHMHnKgP+FQHtzy8zyH3v3Sb74V7Hec4kPXqHB9iEmTOkrbGHbM5om2Q4UNgEytulXlovhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlQlaY8w; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99e8d5df1so570145185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727188367; x=1727793167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+6fiaAOImA1gdNyy2VGCAfVO/VoDlfn0ifZdVX1aDQ=;
        b=KlQlaY8wbCdRAFebC5HIzTE8afbgMS6YpBpWDmcZ/GDBLDP85jGjjUudfUYE1WJmze
         9u3Yb9r0V8T/u321EsUoY8iXuhkf4Eevdc8tB5g2p7Kk5PzofX78rKVnJ8XQHOEVIGbZ
         oPOSOvE75b/lPEUEWcpx+qJVVLA/Bm96bmcxK/q+HNpgJvq7UyfX5T+uw8yMIu4zl/uh
         cC4T5bihDaVINnRZa7ZoVnGGpf6A5zR+HEAwpsUan8wq7TyOFvOeh9HLePnn3FOY+gao
         MFBWBhnWFjVs2CRO2M6vBUdb9mX4b/1S2X1cpy14lTqFA4whAOaPUCiomGTTL76/rJjP
         H/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188367; x=1727793167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+6fiaAOImA1gdNyy2VGCAfVO/VoDlfn0ifZdVX1aDQ=;
        b=UA9qHpLgh7LAFx6dJ1Si4YTo3FlKkzVROcPOEZYeKfDoXSVCZhW84FVJfgKBBeeG27
         r1Eenu58cjuVVn6PPcUNp8ZnRj75dO+Rq0e9kO+IOooDTBkngXpGeF4hCnrUdlti8Pfu
         jtg4rXRQwiC2oY5uK0lsgiOJFLczixdYuELY0UdSLSxj4BhWWvyh9kxpBqwHfH6v6a8s
         I5BDTAdXpIOgGPsdEzCSetCEvvqB+5vVzgS/Q3yfGMV2i1SVAOgDfvNvx2+ac+11HJem
         nPV/lxevBknRSUc5q2QqfHgBNuaBKA5uGTq4db6IhFGbnBWMrnd0zdiLhKZpedxIKDg9
         p03w==
X-Forwarded-Encrypted: i=1; AJvYcCX8uLtzp96CjvLAagb8gU9+CWdIXZYdsJrZmkqx+BthMglnjD+MNDwksZPI2ImuKoZ7/THGKFPTSPf0KJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHVmBtBcngdptj9llJUaXkX0jlkNi+8Kc/HGSe7VKoZ7vw/w2
	byFFXn50OfQ7lrf10ROMu6pTacq0To6RR2CxuPr53d2ZtzPdCVlkj+fzPVa0t4fIkIS47UqSccT
	NiuI/Bt1snFFDWqWNr/jTVmpYdAA=
X-Google-Smtp-Source: AGHT+IFpa8EMVNC7Vgl7rbx3EZ8q6zCIHqEWaa+a6ah1TX8v+6tf7QI+0hO2k1UY0CmGzj8n7kMM1mbOIU029fnmsgk=
X-Received: by 2002:a05:6214:319d:b0:6c5:20c2:f34f with SMTP id
 6a1803df08f44-6c7bc736b53mr194713196d6.21.1727188367141; Tue, 24 Sep 2024
 07:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com> <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
In-Reply-To: <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 07:32:36 -0700
Message-ID: <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:25=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
> On 2024/9/24 10:15, Yosry Ahmed wrote:
> > On Mon, Sep 23, 2024 at 6:55=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 2024/9/24 07:11, Nhat Pham wrote:
> >>> The SWAP_MAP_SHMEM state was originally introduced in the commit
> >>> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine=
 if a
> >>> swap entry belongs to shmem during swapoff.
> >>>
> >>> However, swapoff has since been rewritten drastically in the commit
> >>> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> >>> having swap count =3D=3D SWAP_MAP_SHMEM value is basically the same a=
s having
> >>> swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously to
> >>> swap_duplicate()
> >>>
> >>> This RFC proposes the removal of this state and the associated helper=
 to
> >>> simplify the state machine (both mentally and code-wise). We will als=
o
> >>> have an extra state/special value that can be repurposed (for swap en=
tries
> >>> that never gets re-duplicated).
> >>>
> >>> Another motivation (albeit a bit premature at the moment) is the new =
swap
> >>> abstraction I am currently working on, that would allow for swap/zswa=
p
> >>> decoupling, swapoff optimization, etc. The fewer states and swap API
> >>> functions there are, the simpler the conversion will be.
> >>>
> >>> I am sending this series first as an RFC, just in case I missed somet=
hing
> >>> or misunderstood this state, or if someone has a swap optimization in=
 mind
> >>> for shmem that would require this special state.
> >>
> >> The idea makes sense to me. I did a quick test with shmem mTHP, and
> >> encountered the following warning which is triggered by
> >> 'VM_WARN_ON(usage =3D=3D 1 && nr > 1)' in __swap_duplicate().
> >
> > Apparently __swap_duplicate() does not currently handle increasing the
> > swap count for multiple swap entries by 1 (i.e. usage =3D=3D 1) because=
 it
> > does not handle rolling back count increases when
> > swap_count_continued() fails.
> >
> > I guess this voids my Reviewed-by until we sort this out. Technically
> > swap_count_continued() won't ever be called for shmem because we only
> > ever increment the count by 1, but there is no way to know this in
> > __swap_duplicate() without SWAP_HAS_SHMEM.

Ah this is my bad. I compiled with CONFIG_THP_SWAP, but forgot to
remove the swapfile check (that's another can of worms, but I need
data before submitting the patch to remove it...)

One thing we can do is instead of warning here, we can handle it in
the for loop check, where we have access to count - that's the point
of having that for-loop check anyway? :)

There's a couple of ways to go about it:

1. VM_WARN_ON(usage =3D=3D 1 && nr > 1 && count !=3D 0 );
(or more accurately, (count & ~COUNT_CONTINUED) >=3D SWAP_MAP_MAX))

2. Alternatively, instead of warning here, we can simply return
-ENOMEM. Then, at shmem callsite, have a VM_WARN_ON/VM_BUG_ON(), since
this MUST succeed.

Either solutions should follow with careful documentation to make it
clear the expectation/guarantee of the new API.

Yosry, Baolin, how do you two feel about this? Would something like
this work? I need to test it first, but let me know if I'm missing
something.

If this does not work, we can do what Baolin is suggesting, and
perhaps maintain the swap_shmem_alloc() helper. It's less than ideal,
but at least we still lose a state...

