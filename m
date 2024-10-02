Return-Path: <linux-kernel+bounces-348056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63F98E209
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E59281C04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323FE1D1E8F;
	Wed,  2 Oct 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzsV+vcR"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301878F58
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892091; cv=none; b=QvmhzdJ1zo+Unjab3AEM1n0XnYojJbVeATWw+rExidY4BbxdKS1BQaFDrtFu1svbKC4iJLp+o21fwtt7FvZFI5OPcPeW0WMkIIWN/fdeRl/TWKt7ckJVtW/57QwuAWo+aMpzJN3qSGgEiRoGOvWW3TWgNURYAHXWjdztSfvIM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892091; c=relaxed/simple;
	bh=zBmVpJ2lS0EfBt11YWK5IEU6NV/O02N/XsQBY+RyDpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwf9wmc1ndq7NIDD/0xvREoccm2R07WVCGLJzt5pEeQ2XtduO4wJPJtIeDhTnc/yM0jdCOB8XDeFuXPstOOLgLeovGnF3ewzeRWjmPOx1RVScVkxdZHMoNqWsPXtbItxRr6tT28FbTrUML0zwaJJFQga3At08tVvn7+xv6QjrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzsV+vcR; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-710e910dd7dso28491a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727892089; x=1728496889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBmVpJ2lS0EfBt11YWK5IEU6NV/O02N/XsQBY+RyDpI=;
        b=ZzsV+vcRdXLxv9xmYYBcbODkmHC/BZNGHUFj2dkTgL4ybYEZzv+7SJ7f3sDd488A9f
         PF3qia6IsMxCs7dO81R+am04O8b8RAcYeM/yAPW+H8CADhXCYH5TgszJqN6g55P1l/8/
         F2KxIJe7CVSU/kzbKpJoZpXzNngN0ZBpXzWyDgbNSLyVtUvnyrMdLRT7NMOKg1JjCEUa
         pnZ6S7NzvURdKPjgACB3jeO/7QXif/4X5ZscoL4bFRTkYS2463kvP+3Nlf446UTTt5he
         KD2OXcsuj8f3l5VEg5QgK22XWcvZJGX+SbgOXvfINUJAWPipYyILIvgIv8FyvGhTJZhZ
         /L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892089; x=1728496889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBmVpJ2lS0EfBt11YWK5IEU6NV/O02N/XsQBY+RyDpI=;
        b=v937Ui30pIjfPN4liTndD2l8xGyPVfVsa5hHuN1J3R8vkKfwGPIf3jlk86u76eypFX
         hftVw4t9VjVpnCzhaBzIhyg85kiYwGOixklT/ZqZCmh3XtZOr6QSHHJoVJ7/pZ2+sAw4
         ZjhVMO+v2YurSXjKGp01F7hD9h7REWRGGyBU/8XyAetMwDCce54PvQEoF3YQq5kGdaUS
         VvFqvWc2s6JspuPH42ZDmH3Gc4gXFEfwW0xVEikjmkX4PcS8CVJ8XlNY1Xxw2oXqmBEY
         PH4SWueIpRtPTtme5UhWAyhmPipukVFfRFOWa85tdtAFp/r/zxzgwf3+jYnU4D3IaZ/r
         rVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWoeE+8AJ+xCebNGITXFeNaNjdVK9BSA9KJLTf4kZN9oROaF/kP45d0O3bd2f5S9RYHtAAoJXQHTGxGaTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeRePEOWlxthW2HXHqpfO2c/41obBtm4vGcdooNIZBL0gyEe5
	Q6REVSKEAXOC6XLYbLwA5g44VpT7I7B5CZhNBQT4aTbzJCFrJabMhVzsIlzTr62FqyDhoNskMEV
	eE0MhLvJB/mPV0JXH+nFUUhS0Zcg=
X-Google-Smtp-Source: AGHT+IFpdVK0i5krQWsg7wpQTYmxLMD2SJ/37I9vSqzsKw/ix8i2U9iC8sZsEjqctodizk8RYjAjuEwSR187MYF57ug=
X-Received: by 2002:a05:6358:9985:b0:1b8:33f0:65e2 with SMTP id
 e5c5f4694b2df-1c0cee6a9e2mr260890055d.20.1727892089208; Wed, 02 Oct 2024
 11:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com>
 <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
 <CAKEwX=OTq2HaEKGgM4n8M60xh217r=vKs4U-GGc83moS5pcZJA@mail.gmail.com>
 <CAJD7tkYOs0Abg4818uCosbGAj=zq0eb-QppcE+w-xzg=TbCWiw@mail.gmail.com> <CAJD7tkaPX_AnzMu8c0ezxXkeLi1V-GBEgj6AaerhEK35-dUuUA@mail.gmail.com>
In-Reply-To: <CAJD7tkaPX_AnzMu8c0ezxXkeLi1V-GBEgj6AaerhEK35-dUuUA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Oct 2024 11:01:18 -0700
Message-ID: <CAKEwX=P58aJo9G2Jq+b0EJP8RJBcd=_MSp-zMSB7ZG5tqr=tuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:14=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Oct 1, 2024 at 7:06=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Oct 1, 2024 at 7:04=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > > >
> > > > On Tue, Oct 1, 2024 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> > > >
> > > > I was debating between WARN-ing here, and returning -ENOMEM and
> > > > WARN-ing at shmem's callsite.
> > > >
> > > > My thinking is that if we return -ENOMEM here, it will work in the
> > > > current setup, for both shmem and other callsites. However, in the
> > > > future, if we add another user of swap_duplicate_nr(), this time
> > > > without guaranteeing that we won't need continuation, I think it wo=
n't
> > > > work unless we have the fallback logic in place as well:
> > > >
> > > > while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
> > > > err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
> > >
> > > Sorry, I accidentally sent out the email without completing my explan=
ation :)
> > >
> > > Anyway, the point being, with the current implementation, any new use=
r
> > > would immediately hit a WARN and the implementer will know to check.
> > >
> > > Whereas if we return -ENOMEM in __swap_duplicate(), then I think we
> > > would just hang, no? We only try to add swap count continuation to th=
e
> > > first entry only, which is not sufficient to fix the problem.
> > >
> > > I can probably whip up the fallback logic here, but it would be dead,
> > > untestable code (as it has no users, and I cannot even conceive one t=
o
> > > test it). And the swap abstraction might render all of this moot
> > > anyway.
> >
> > What I had in mind is not returning -ENOMEM at all, but something like
> > -EOPNOTSUPP. The swap_duplicate_nr() will just return the error to the
> > caller. All callers of swap_duplicate() and swap_duplicate_nr()
> > currently check the error except shmem.
>
> ..and just to be extra clear, I meant WARN _and_ return -EOPNOTSUPP.

Ah ok this makes a lot of sense actually.

I'll return -EOPNOTSUPP here. Do you think warn within
__swap_duplicate() makes more sense, or at shmem's callsite make more
sense?

I feel like we should warn within __swap_duplicate callsite. That way
if we accidentally screw up for other swap_duplicaters in the future,
the feedback will be immediate :)

