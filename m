Return-Path: <linux-kernel+bounces-346921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB0F98CB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4091C2194C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F6C2F2;
	Wed,  2 Oct 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuW3e9h0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01ABE4A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834853; cv=none; b=dba2xUrrhHi9sgDSf3MnQ+ZD3g3bwwOdMIamB49QJh2KlYSD1Jq/idX+i5CjafN/dgAbKhV+VVRRmP2XTmQS/mb1MMuJ/j4196nfFSOHoUSEHXvtGQKjJEvNDA6ReRsFKckMrftsfpPPjhI3jcHKrRoVlffMQM/lP11EbqB7QLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834853; c=relaxed/simple;
	bh=SqgRp9ksyb7TqEHQlqN1wv+FBNWnFa5i6BHVz1zWkmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZNNTUHaEC66o7oFNDJUs7GGUOKvzMolyjeczH8aJVci34JqX+hLxAqUaYkjZP0HjapY4cycBRC/B+p2CPzDEmxAIPW9XVEk9DNJehYLwx+4yse6n1Txb/8p1U2ZC7pay0e4U3iJ626x1+9tBXsDd3UIgLqclY8FJ7gCa+mZfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuW3e9h0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so892294766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727834849; x=1728439649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqgRp9ksyb7TqEHQlqN1wv+FBNWnFa5i6BHVz1zWkmk=;
        b=SuW3e9h0e0cHbtrouY6UFTQampwmGGREl6bRsXfWWFxCO9/YweKCn06DFtR1xQFTWa
         M6KzcC2OMqDjslmy7RdaRwwHOiiXCISx0aUfgAlGZBlGy5jVv05XMj5lFbhsAV6GiBco
         hmBYHLlIZrz2CH3med/xhOTeYfOUKBVfxsroWHQHO9g5dwmMwRt+uZQeZHxSD+p34RI8
         NF4/u2ALW6dlhdH2gzzKgyWWaix3xxBK9wq2UGaSpF3dngCs/WytiCkrHEWsad+y0tKF
         urEgSE2+vuPepxAjI/DhrHbvAw/cgTGr4W+uyfKMNFuW1Fy5B/FGCj+uo0D7KOsPGUHg
         fIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834849; x=1728439649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqgRp9ksyb7TqEHQlqN1wv+FBNWnFa5i6BHVz1zWkmk=;
        b=jM5ANq1lXTtcHlkv36+mShkRRWKVh4WE5btNkwhpIGLVEhteZ60Kmvg8f2NQHCymbi
         svSeo5PVxNrhSM9ask1/Xs+ZxA5nrE704+f6o6L0E2Cn+t6o5GHPMeAj0RjItU7Xbr8W
         Wi0niRmTgJLB0wLBCd4REUlU8y8hLaY7jQrqkT7HUUokUCR/3VTZV/DEeql6y3Qo8bDh
         cDZyCdAk4gqEml5hPhkP/8U19GInuM9csysLib7NOTIgZ7Ufe8oMebcBPdFNHct3aCcN
         YLc+Z0OlQJIEVxqyR2NWSq1ef9xOFVhyczXyKs1mS0yIrPYgtPu8HqjhGSUtlMZbuEgy
         rA9A==
X-Forwarded-Encrypted: i=1; AJvYcCUFf3iwFrCNujs1d1oJz0XUVsPeqU2yNpTbFfcsY2kLrPVOXLM4PQYFNxCLo38YpPWYCp983iTvT4ABXsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgOQ1rl0oTYZz8l8u40t7F004kcErH8Rjl3cc5LUpNEYU5nOC
	OR1+C9KcyQhHRgPE5E9pUSq6UWLFwLNdFjUlq2wgZpGKPBHYML13rnqZdxODljEt0E/qW8F3vx0
	1hMAYfnYcljHzixvX2KLO74rqrdOL2/CD6RYO
X-Google-Smtp-Source: AGHT+IEuRycV2lyATx7SaAlaEJeUlJiYknVz8zfaj1/Pio6g7o8+pOJ5r7VtUHQGnEC/26nPfYiAe7uBfU6k/yfUhE8=
X-Received: by 2002:a17:906:c113:b0:a8a:7027:c015 with SMTP id
 a640c23a62f3a-a98f83fe799mr148466166b.56.1727834848839; Tue, 01 Oct 2024
 19:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
 <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com> <CAKEwX=OTq2HaEKGgM4n8M60xh217r=vKs4U-GGc83moS5pcZJA@mail.gmail.com>
In-Reply-To: <CAKEwX=OTq2HaEKGgM4n8M60xh217r=vKs4U-GGc83moS5pcZJA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 19:06:51 -0700
Message-ID: <CAJD7tkYOs0Abg4818uCosbGAj=zq0eb-QppcE+w-xzg=TbCWiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:04=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Tue, Oct 1, 2024 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > I was debating between WARN-ing here, and returning -ENOMEM and
> > WARN-ing at shmem's callsite.
> >
> > My thinking is that if we return -ENOMEM here, it will work in the
> > current setup, for both shmem and other callsites. However, in the
> > future, if we add another user of swap_duplicate_nr(), this time
> > without guaranteeing that we won't need continuation, I think it won't
> > work unless we have the fallback logic in place as well:
> >
> > while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
> > err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
>
> Sorry, I accidentally sent out the email without completing my explanatio=
n :)
>
> Anyway, the point being, with the current implementation, any new user
> would immediately hit a WARN and the implementer will know to check.
>
> Whereas if we return -ENOMEM in __swap_duplicate(), then I think we
> would just hang, no? We only try to add swap count continuation to the
> first entry only, which is not sufficient to fix the problem.
>
> I can probably whip up the fallback logic here, but it would be dead,
> untestable code (as it has no users, and I cannot even conceive one to
> test it). And the swap abstraction might render all of this moot
> anyway.

What I had in mind is not returning -ENOMEM at all, but something like
-EOPNOTSUPP. The swap_duplicate_nr() will just return the error to the
caller. All callers of swap_duplicate() and swap_duplicate_nr()
currently check the error except shmem.

