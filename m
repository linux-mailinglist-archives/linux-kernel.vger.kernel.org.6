Return-Path: <linux-kernel+bounces-337611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D44984C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D11F23520
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B413BAEE;
	Tue, 24 Sep 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCO2hw7x"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B974418
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211087; cv=none; b=LuVxEFx5D/RJFpuDZZ8qFMRqIUb1x4UFQ0dNfSkNjr+I2pgkFukXuo4gP/AqPnZ3UgYBL1xqiSYl/mJCCEJtX5UwFQ0y60vK8X14tKJ+0w38EU11VR74xciwC6At/l5/lyc0W3ZtyFfY0a9VeuUqy6QDzyFZB2g2KotIZI3gN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211087; c=relaxed/simple;
	bh=to3sMPAPUS+U8Yc2xR8p1UrQH7WHum/0e5cqAn3w/Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAm8XsJI7w2lFi2GJR8LHwPTQvEVek4yq23JJPHS4FeclprxCAet6aTP7jZuEGRt/RXdjoiaevFop1uUgkOBkNI+7fGYSlNVHxUCSt9KK3ihRhtA1u77zSH09gQF/J1Ur1pEYh6xF5HdzRzUqxIsqnaLiqltTGKBjd42wW+3iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCO2hw7x; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c359c1a2fdso53160206d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727211084; x=1727815884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8Ouk3+mOzkk2sFKAnAlzIMXgObvchvQn+4b73wEQTE=;
        b=bCO2hw7xTYQFBDvLOB4s0N4rScT5Tknei3MzDqWM/j+2eBQ35izM2/jSiroSQsPque
         JMoBuOLGBZr3H2KeX7fpBRWOm6frUnkLYhYYf6+fEKfEu19/3NW1b3WcI0CUQR+KqWso
         dVUiIFkkz3Bpw2rm2l1uMxVy9iLLvRFeTblOqYdJDZYly9Rr91Jl1Dh88opQqXeh4b9I
         lmMKZ62zpnCK/6OfkhnZpWzL0WSRGcL44lCMXXQCd2Z5hprvJGJ3OC2vR7bQEAn3nZjv
         Xm50J8FwckhdQzcnAb+SlI4NcMdl9QI3ivq2QfyomoDd72ippVKfcIZ1X7Xnafs/ycjs
         GDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727211084; x=1727815884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8Ouk3+mOzkk2sFKAnAlzIMXgObvchvQn+4b73wEQTE=;
        b=g8tfaEqpYGgHog/FdgTqAm85is37Y5cZeGKj4VrkPhP/+IgYtwAztuBbT6ejYe5pCy
         lP0Icb/edbwe2QyYQ4paVWqLVmOHPTfbw/DaBcVrgjd/T4H4hsQCKFXvlJQSPKS4W6E/
         Wdakj6YPQjXQa6w+hHjgMpz0+lD+fEzrvkn3II5E9QGKF1iwECylHlxgc9fqoIhIuRl4
         fqJ3PjXuifeOzwF8i0FSPSAG67EPPtqGTeyZF3Ilyd2DraXDBSiOYQ8lWy+kZnTzeJsL
         Y43iPJ1nAiN/LHRfX5D1V9zN+dR++GZkGe6a+eT5x8Sxh8zS8+LThfBrE6lY3bcZmOpN
         DQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV01gzhVok06D3HV1rMuyHE0pLMm+xvkUBMpsuahCp+aeirbhur1SZESzUrvU6TwxtrhnVxgrH+i0vqnIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJwpPkXIxM+VzwZ0BlJDpfBzUeWJUqinAmBxAlN410ot8Y2Id
	q032I3OkxTXDBeTj8r53aAB5ITHTqzTdFegyZAAR5zHt6Yv9cf6G6r0SmOnkuotDdPV4T/0Rfap
	hRIjNKcFvHJnvKpydfcGs6EnOt2o=
X-Google-Smtp-Source: AGHT+IFQC06uACtY5Q0qyEv5c3jsAf1V1JqntpR5sTV+WlZmbiWoVeqVnTXQJigx0D8eL1UWD58roQDqvyzbVMEpV4M=
X-Received: by 2002:a05:6214:4a85:b0:6c5:a934:6b7d with SMTP id
 6a1803df08f44-6cb1dd70739mr7083626d6.6.1727211084320; Tue, 24 Sep 2024
 13:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
In-Reply-To: <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 13:51:13 -0700
Message-ID: <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 12:39=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
> > +        * The cgroup zswap limit check is done once at the beginning o=
f an
> > +        * mTHP store, and not within zswap_store_page() for each page
> > +        * in the mTHP. We do however check the zswap pool limits at th=
e
> > +        * start of zswap_store_page(). What this means is, the cgroup
> > +        * could go over the limits by at most (HPAGE_PMD_NR - 1) pages=
.
> > +        * However, the per-store-page zswap pool limits check should
> > +        * hopefully trigger the cgroup aware and zswap LRU aware globa=
l
> > +        * reclaim implemented in the shrinker. If this assumption hold=
s,
> > +        * the cgroup exceeding the zswap limits could potentially be
> > +        * resolved before the next zswap_store, and if it is not, the =
next
> > +        * zswap_store would fail the cgroup zswap limit check at the s=
tart.
> > +        */
>
> I do not really like this. Allowing going one page above the limit is
> one thing, but one THP above the limit seems too much. I also don't

Hmm what if you have multiple concurrent zswap stores, from different
tasks but the same cgroup? If none of them has charged, they would all
get greenlit, and charge towards the cgroup...

So technically the zswap limit checking is already best-effort only.
But now, instead of one page per violation, it's 512 pages per
violation :)

Yeah this can be bad. I think this is only safe if you only use
zswap.max as a binary knob (0 or max)...

> like relying on the repeated limit checking in zswap_store_page(), if
> anything I think that should be batched too.
>
> Is it too unreasonable to maintain the average compression ratio and
> use that to estimate limit checking for both memcg and global limits?
> Johannes, Nhat, any thoughts on this?

I remember asking about this, but past Nhat might have relented :)

https://lore.kernel.org/linux-mm/CAKEwX=3DPfAMZ2qJtwKwJsVx3TZWxV5z2ZaU1Epk1=
UD=3DDBdMsjFA@mail.gmail.com/

We can do limit checking and charging after compression is done, but
that's a lot of code change (might not even be possible)... It will,
however, allow us to do charging + checking in one go (rather than
doing it 8, 16, or 512 times)

Another thing we can do is to register a zswap writeback after the
zswap store attempts to clean up excess capacity. Not sure what will
happen if zswap writeback is disabled for the cgroup though :)

If it's too hard, the average estimate could be a decent compromise,
until we figure something smarter.

