Return-Path: <linux-kernel+bounces-383782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6989B202E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43331281E31
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D041741CB;
	Sun, 27 Oct 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLrMRA1i"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221544384
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059426; cv=none; b=hA24v8sUpvGec5KcA1RmSA4rjhSmy1RHIV8m+Md4JpAYPl5kzz/MLa4mtRZZeAw32NMO3wp3bkstXTWQTuFiujSmwhVIiDScfbHnwutADtMhyJZbj5HJzMtUHhCEbTWaKzcHXlz2wA345e72/IiZd6GFbBzewb4VTPsvgTN843o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059426; c=relaxed/simple;
	bh=Si72k3ReWef90sHMjPWftD1MbLTFrQR0jisHjlN/spY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkgt1+dmuFV68KPi5dgy0Jo9mXSaqv0Wf4+Hr7a8wzeHcjgHgo7jmbGepEZkHhH3vQes+Z2yfLfRzbk0XTGElE73UJBKpD5jVfkr8EjtfW8uvDMh/CjSbXi/GEa/XiNP+F5WEoyqCIupFT4UAX2jdFxpCDybLrBD2qN3byENG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLrMRA1i; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d3d2d0775so1110239e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730059422; x=1730664222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si72k3ReWef90sHMjPWftD1MbLTFrQR0jisHjlN/spY=;
        b=oLrMRA1i5jAdyXwXTdDaPqVQE2dp/CxDy5l328+Qa+4K1hDxAVbQ1SkWw1ELrnQEZP
         tuj3eAfbIxVvYI0CT61OPlFG5I2zVNCpI6cEsVx/KBVZ7DkrLFOpKxCt5koXsDDS2JpB
         hy0o7feIJA3OESWnCILKjDLSXanDsN8i8zkUjuWq3Qb5sT00jSlc1fBH/zrUAiGHpSFd
         2GgqBYbcCD6zMjFq/ZdhXjgfHxkjZXvmD1r/G/3T/KEDvWB2O88UeugoKnm2xpPlgP/H
         YpxPO2hNOzqGWrFocaOKPrbwpwKyKI3bgzt0msQUR3YofDIdDhaGDYaMS1WKq94gqlK2
         eoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059422; x=1730664222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si72k3ReWef90sHMjPWftD1MbLTFrQR0jisHjlN/spY=;
        b=fc/XHj3O715/Qa07LEBrZCEDgB+4hJw7wcozEh+SchKiVwNfz778g1a0qVAQclE24i
         xkvc3deCFw63vgvp8JM6ukZiqMKeDg7QbPU/I+08CZhRGaDvlwbd0o0pd3GGxEWQAsvN
         kxdHiyRIFSF0J/dYmhyi7gWWZcPHMD6Glym4NLNU8gi/9zzNBM6uin9BpzGLg8dPuHyP
         iDYsVfEbHBwZsklJseT+jOO7bGcMCKnelrwuUr0M9MW7K+iXcFaKBwXGtQAeKicBeF+F
         Gd3zJV3HePVCB93VguZnxe1iqfzJC7vB5eaclwN7kQxPgrtB9GJ+Q1usCE/IA+8Munyp
         Ch9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4bCkmYTHRb+99eXwf/HfXtgk4kEGNUnLbCZHrs5sXj6PjNAsb/6Q4bz23uA8gbqIgsXLf0ifdxzrJXZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTGe2pL6Hgqh3xC+d7uxlDTNaJr9nBp2RQB/+qTCMsKtdHvjR
	7OCqXKgd+UrDjzZcplUvNsDi/4zoML9dLWtByym+1gqDoGtcZrpj/dvfG6YsLLsNCdAG9n5/wD3
	BamavEYAGZS8ayhYESVV5HxmeKA70i+AEZC5E
X-Google-Smtp-Source: AGHT+IE7gils5dchqxLzswDymXiO7GZKaEJDtRm02srfhsgdKLYaC66intvMGKji2i5s80Xv/NfIMR0nDZOW3ySBN9I=
X-Received: by 2002:a05:6102:41aa:b0:4a4:878a:e3b7 with SMTP id
 ada2fe7eead31-4a8cfd4de79mr4048886137.22.1730059422127; Sun, 27 Oct 2024
 13:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026033625.2237102-1-yuzhao@google.com> <20241025212448.b1a9069d71df5b497e1b0190@linux-foundation.org>
 <CAOUHufbJs3GxZGsJQT6AHQzz2KAETVwWCaGjeybTTCH0K2Nu7Q@mail.gmail.com> <afd9f99f-f49a-41c7-b987-9e59a9d296ad@suse.cz>
In-Reply-To: <afd9f99f-f49a-41c7-b987-9e59a9d296ad@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 27 Oct 2024 14:03:05 -0600
Message-ID: <CAOUHufZmuUYPNdUMShKwyHJq=tU7EMwjC0Sn5JX26eUVgdmzEw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Link Lin <linkl@google.com>, 
	David Rientjes <rientjes@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 1:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/26/24 06:40, Yu Zhao wrote:
> > On Fri, Oct 25, 2024 at 10:24=E2=80=AFPM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >>
> >> Is a -stable backport needed?
> >>
> >> If so, is a Fixes: target identifiable?
> >
> > The code has been there for many years, and we only recently noticed
> > the problem from Link's repro. So it doesn't look like a stable
> > material.
>
> The stable backportability would be limited as there's a prerequisity on =
the
> "mm: page_alloc: freelist migratetype hygiene" patchset from half a year =
ago
> - patch applicability wise and importantly functionality wise.

I don't see any dependency to that series.

> Otherwise the
> counter could drift easily.

Care to elaborate how that could happen?

> However we could perhaps mark it for a 6.12 stable backport as that's
> presumably the upcoming LTS.

Right.

