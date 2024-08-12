Return-Path: <linux-kernel+bounces-283860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C194F9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A672819B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67F199239;
	Mon, 12 Aug 2024 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pq8b2bHA"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179A1991AF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502579; cv=none; b=F7vOqdWvMjkvpVEQBcig4t7uCYSllbfnnrOIyjoaicU5Ti45J7g4fV6OHfLha4lc9VY3nd7lSIORiT/bZuqrcLRrkf5dniwq+jrWMemlMTjkpEZBQq/yCGZFMYGxupE4pF6ysalMQyzXTYSCMvrAiYqmEEYmustU/yhnfjYhY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502579; c=relaxed/simple;
	bh=71uNIZ13j+rTrm85ZN6aYkIkiJNb2IayJiIib7eHRPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TW4Hf3SH4bHPPUGRzp2KnoTLv/NyRoRa2wqKaeNQIgRLAyG3cNc6Teq4g0KKbsW+FJ6plJRK4GXJTjF6ro0aXvMWRqLeo9nvR4gGrbLoVjMwVxqhKjcMAeNBBn6iTD1YIk0yFm09SFFGBEr8gZIKpkJrA7YpM07XcKVx55+knfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pq8b2bHA; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-83172682ab3so1452818241.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723502577; x=1724107377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AueiYHrl/hbiYD3dSLPHyTTuwNQ0IVY+sYMHbIQZCJQ=;
        b=Pq8b2bHAjjL+29sRvCtG9i3TYkJAsQC9HuYvQaRpvK0bT3H1WE3EpWFfRcPS+vxm2N
         J03aI3Md+zB+kbtUE4x12PFIFns3b5wFmt9n0qUZD2WO+/TMVBh8Ww/cUL+6ZuqjRFT2
         3dVZQ+7N4rtgj0r+S3ufGhoOdYAYqJonbtNc+DVC0MAabfZe44MV0xvL6jX8FLU2cgY5
         YpKLpmrlaJbJTqD6MtltpY1y14h67nMsrrkec8yzbNFhnKUxA6OT4VvN8zLvdwkpg6RP
         IdADzWsOy8btT5FQtwBrVAzTdC8LC5fWAvSQwk5KRBHws9jBAWqny0qSJPeVBA6mBonJ
         Y0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502577; x=1724107377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AueiYHrl/hbiYD3dSLPHyTTuwNQ0IVY+sYMHbIQZCJQ=;
        b=u8P12fmDBk+febcvHsHGGELDj3n5PI3+BImyCpclGbwHMy1Yg/rp2QYtsHgJdDv/iy
         qzUMne87KDsHosPuOuCl3Nf+rgqEgyAwHyvjxh1gsSyjc7KzRDeyuzABcqmT/k0DAxew
         3fsVJK/cSmkt91UZ895pz8h8OLbJwRLM1HkfXmiKr+HNQUTTKd6uRh3hAW1gXcyFOppq
         mk4OA8n7sgQcSTEND3Hob22NNV5dTZlVDobqzQX4T4nxLpTb0qAGdg+qHi2Qp2fjY+AM
         XobqBJMAwZMZemPRmwTzEceifvZJCjyvDEa//+KO9vtF6J2q1xxlGvd+vzxf2o258shT
         F2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUZLPcU3namPhs9HiAymEncOF7LjEFXEtK0D+2xtDzMfy1Tab6d0/k5CGKIj75KNRSkWJrMktNsIy3awz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUv/fbm+fMiazFynp6nIze2IJYluAzeI++q2Yj7bOR7SYQyUY
	Mvu7j88MylWmJxaJpC4DjrlFkLdJuVRT+V5WFpxB68dApz7eM9IQnMvD74l4ymNH1yymnb62hHm
	/B4Kyt2j7Rsm0vRkLpsm9uYiN9Azr/0JdkQdl
X-Google-Smtp-Source: AGHT+IEo6Q/3tFGZj8m8ATzcp9PmqvulcLtNoRpqubB5FMK6mvuYFDL5YqQ75170LA2WrLnXhPk/u+ryx/fs3sK5EZc=
X-Received: by 2002:a05:6102:3ec5:b0:48f:463c:2fbd with SMTP id
 ada2fe7eead31-49743943122mr2196881137.2.1723502576522; Mon, 12 Aug 2024
 15:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811041703.2775153-1-yuzhao@google.com> <C5E8EB48-1B4F-4C40-A580-8C99C128ACCD@linux.dev>
In-Reply-To: <C5E8EB48-1B4F-4C40-A580-8C99C128ACCD@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 12 Aug 2024 16:42:19 -0600
Message-ID: <CAOUHufY9dceDCGyGrQGBozFxZa13Ctgw25PenAbfzoJSEaNTkA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/hugetlb_vmemmap: batch HVO work when demoting
To: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 3:40=E2=80=AFAM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On Aug 11, 2024, at 12:17, Yu Zhao <yuzhao@google.com> wrote:
> >
> > Batch the HVO work, including de-HVO of the source and HVO of the
> > destination hugeTLB folios, to speed up demotion.
> >
> > After commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with
> > speculative PFN walkers"), each request of HVO or de-HVO, batched or
> > not, invokes synchronize_rcu() once. For example, when not batched,
> > demoting one 1GB hugeTLB folio to 512 2MB hugeTLB folios invokes
> > synchronize_rcu() 513 times (1 de-HVO plus 512 HVO requests), whereas
> > when batched, only twice (1 de-HVO plus 1 HVO request). And
> > performance between the two cases are significantly different, e.g.,
> >  echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
> >  time echo 100 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> >
> > Before this patch:
> >  real     8m58.158s
> >  user     0m0.009s
> >  sys      0m5.900s
> >
> > After this patch:
> >  real     0m0.900s
> >  user     0m0.000s
> >  sys      0m0.851s
> >
> > Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN=
 walkers")
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks!

I forgot to mention (in the commit message) that:

This patch changes the behavior of the `demote` interface
when de-HVO fails. Before, the interface aborts immediately upon
failure; now, it tries to finish an entire batch, meaning it can make
extra progress if the rest of the batch contains folios that do not
need to de-HVO.

Will post v2 to fix this.

