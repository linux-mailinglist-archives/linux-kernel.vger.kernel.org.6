Return-Path: <linux-kernel+bounces-234968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214191CD9B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E81F22631
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043480C09;
	Sat, 29 Jun 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6JWTX/c"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387B1E489
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671419; cv=none; b=ZjWEMZZRpgu+0IM7aE5CMIjBLAbfoOPNKbFrlAh8lOorbra4Wir/4GzkznnfFgD0rEjnAOQx2tDSQ97cN60dHfcQR/IAxBDUh+psrsaxVdvmtldY/FHRR4exkN68iI5oqVbkpre4xpcNl0NOcmVS4I+NUgXVL1hP6m2W8BmldBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671419; c=relaxed/simple;
	bh=4c4eNHgquP5LXvtkVKXE1VzOZkK6RNUxtXFoN7k8dlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXsamdRggHSPRm1YAmd0ugqa1QvKU4mcxR0BhH897Y38te2X+brUB/MQkO/kwD00QOnfKf424c8fixrNsQ+HeQbZbhqUm9y9QJCR9EKxpzKB+6igWCDaKyPk8Nr5Z6qjF30/vMpIx5fV6MKxrzmoFfLdIznZDn6haqKdv/SwfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6JWTX/c; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so1830813a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719671416; x=1720276216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG9SqCZxDcweEqWP+jIbPso5aga3wixc1/xcyoRvDi0=;
        b=A6JWTX/cTIOzIHSyZod5JOnmCi6rYUj9/T1wtm5LfZS8xHFDJ3sNP9WyNSyIQAyOg7
         PWBbEpWWF5/c+Bwcot+MEd+Fzr1tWBVDD/2fxrMJJOIG22Z6lYUM/t+OfF840ffSCsVH
         m+Aj/1uKWZGsrDJk7QOrAlrHm5g3PReSzDyveAspEBKdFD29k17Kujbz/8YHQ1Vt4wPM
         7pa1N9HAlhvg+BxvNlJfFHkq0su7NEgvjZF4lcBOpiURRmGDIbREPzTJcbnnnszn0EqY
         Pch0fCG+XmkpyzP4LkLBISsEz95vkIgk8yiGPaaTiREEZr5EKYGbS8mvGxy5OAHtqEGR
         3YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719671416; x=1720276216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG9SqCZxDcweEqWP+jIbPso5aga3wixc1/xcyoRvDi0=;
        b=riTGbS0TZAAMFQAyGiuzrYe4IU0lGJn7TjPVfXdfzphtrY+pmpIPHU3t0r9wz9Rvwc
         NvVCahx0EFd2XQgRYqKqBGzrnKR8kfACbf9Q4Ez8Lvncvqe0UtAdNjALUiV2yaxp9G9e
         ElIJS0EgOH+HMxOA0dGn+5+j0lpBPuzajmL5/IrLRUqZtw+Y6mmrvgImAfYwztAYJjUK
         xr6+YiC3lg+6V97TNyo2bd+4Zi0WGe21meXs31TAacbXcKGef3ow5dugb5E/ovcbHDym
         6b3Tc9ZMAQY/KIMT8ai1QuRmdkpwjtmSQhsZ5paW1/ZS3sW2bDdDBHJtLGHNYI8UOp4X
         Ny6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi+uvT/MoDApYM6G/SixUi2ZjjBO2XY+hdT1othwtFX9GZ0TOSDkkahwD1/R5EFp1MgNfcPpH1RWdT5J6s4cmfBAbz+F16DldRR3GS
X-Gm-Message-State: AOJu0Yy13petG0+6h3gOzPkdtVVPT5V8GFZBWWvFd/VRhUsqYD9q5tkB
	HkZTMbZIbQ2glJW++4dzxsBWTC7pzC694yrafTwLkO5lWOlJWt143S6LgWNx6YQHGgK5aFH9CdG
	OPkmJPgDsXeJ34kKRvTLN1aGVFls=
X-Google-Smtp-Source: AGHT+IG0VFG34dW6TntSYGpVhzlZoKnQog7LGdjEUr2rXNIVqshKQ72zGCPy+dOq0y/6WL0TqlFup1SG7llo9wwJPFs=
X-Received: by 2002:a05:6402:1910:b0:57d:619:7721 with SMTP id
 4fb4d7f45d1cf-5879f982feemr833762a12.21.1719671415676; Sat, 29 Jun 2024
 07:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-3-ioworker0@gmail.com>
 <CAGsJ_4ybc6-PmJEP-h_uWmT1wqE9gmT8b0juXkYYi7XpzSrpdA@mail.gmail.com>
In-Reply-To: <CAGsJ_4ybc6-PmJEP-h_uWmT1wqE9gmT8b0juXkYYi7XpzSrpdA@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 29 Jun 2024 22:30:04 +0800
Message-ID: <CAK1f24nzALDT5zVL2bCBvf34sLfq1k_z6f9KBcVYRB+4dCCYrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: add docs for per-order mTHP split counters
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Thanks a lot for taking time to review!

On Sat, Jun 29, 2024 at 11:08=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Sat, Jun 29, 2024 at 1:09=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > This commit introduces documentation for mTHP split counters in
> > transhuge.rst.
> >
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Have a nice weekend ;)
Lance

>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 1f72b00af5d3..709fe10b60f4 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -514,6 +514,22 @@ file_fallback_charge
> >         falls back to using small pages even though the allocation was
> >         successful.
> >
> > +split
> > +       is incremented every time a huge page is successfully split int=
o
> > +       base pages. This can happen for a variety of reasons but a comm=
on
> > +       reason is that a huge page is old and is being reclaimed.
> > +       This action implies splitting any block mappings into PTEs.
> > +
> > +split_failed
> > +       is incremented if kernel fails to split huge
> > +       page. This can happen if the page was pinned by somebody.
> > +
> > +split_deferred
> > +       is incremented when a huge page is put onto split
> > +       queue. This happens when a huge page is partially unmapped and
> > +       splitting it would free up some memory. Pages on split queue ar=
e
> > +       going to be split under memory pressure.
> > +
> >  As the system ages, allocating huge pages may be expensive as the
> >  system uses memory compaction to copy data around memory to free a
> >  huge page for use. There are some counters in ``/proc/vmstat`` to help
> > --
> > 2.45.2
> >

