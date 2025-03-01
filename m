Return-Path: <linux-kernel+bounces-539730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D24A4A7DB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566C8189D113
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DAD14A0BC;
	Sat,  1 Mar 2025 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWrYa8La"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98ED22087
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794911; cv=none; b=DxbkD+tG1Y3V4fECEO/DfkYFh7YTSkuV4KLiFiSDAccC85/JM3YnjEdPwbZgAstzS0HoC1K9oLx6ixVH7aS4vFf2iP5VVbAtBnFU82GJ2LcvQG0waADPpEmq50fh/ZReDWqvH3w1gaft86Sil3bTV8hBtBKVRi88ppO6TTWqRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794911; c=relaxed/simple;
	bh=C9//VzWKyWP09uZa7+QXqcG8mFN/Iz00I5i49b26kQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni592DFCEwL0L4GypVthGd9U5ch/PNcdfcli2UFkhKMbz3dNLeTDFKJGX68RjMfxyixj9wYOZhDyFnXsNwkw3lzZhZjTD/qPeOce/6Y+NfkdYqYELpT/YmuTkuxDXDQxzg6quBdFkNf2Ue6cGXdoSpp9FaEq7PejFKcwMy8kbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWrYa8La; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c095b5365eso185847485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740794907; x=1741399707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9//VzWKyWP09uZa7+QXqcG8mFN/Iz00I5i49b26kQs=;
        b=jWrYa8LaeT98vL6ge57mqRuKgGz05FQuA/o7drDn0F9I3PBQqadqtJVRc7W3eqpc3e
         CFPScjR21mfo1GYhiLTsSZFYjOveKAyLTjIQWGrzetYd9Iy1fnn+FJe7wE8m0nqe/OTt
         zuI/7+tAirNt/QI3FGXKMK72te9P5tmVC1Y48Re9opZN4A9I8ZsX1dZK9yWIE35kCUmN
         YyGx7UN42PTApB70M7PT034D3ilo9vuUhjkVKeT96OkrJkS85/ZE8t8I4Grtvps2fQbA
         gnXvlLCJyNxpGUKunxsQSrHWPyWt5b7ZB0Wk8mOB2ppoNhPTnijASjR1SmE3mUwCPr3t
         yIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794907; x=1741399707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9//VzWKyWP09uZa7+QXqcG8mFN/Iz00I5i49b26kQs=;
        b=DOluLBwNjkScVXV1NVLk4gLiwIr56QYH86DzPHPLh2vtG9L0+PAXHe5mA/DFW3aVKe
         uRnci5iRY+PIxBt0naoiIQIavhOrJi+csvZ5uPMsPdOD3uDWOHjwTQqHu5C2SmC3AmRj
         CVUho3jcR1HmVIDux4QL7X0meDw075A1GgYEwbeGC4fKeRPqoY/1vHv7s7mR5tx9vu8s
         eyS9tdIyjYi3qaQypLhUpBzng3G0ATarfOMt0da9cBB1qicu1lydsRYeKwz+keclf/B9
         Ukh0rV6r/0/cqYBwnnpTTvh+wicX/4huo9lo4DPKnFqS5NijPz5az9CPvypkFCeYONbK
         btGw==
X-Forwarded-Encrypted: i=1; AJvYcCVIuJKjLWip9t5ZvxROFH0pdm4Nk3jGcZwWzOCRCsPAphBtkNih54qOZIbq8zlp3yDvU9sAFzThUVggWZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtRQ/jRfu3qhkCvnZ3f9FMSMpAF17fjqGHgOoc1eBnvTGi9Dl
	qYt3po9tBkaR4I9Aon9H3Ou9N5ppIggQbWcT+B+biP6PXlmky4Ve2pClgT6G2dhxVKYnkFj6G4V
	u4CRVCqU60X4BP65wEmpldPE5tWI6mLulQ3U=
X-Gm-Gg: ASbGnctpTYSLTeNLj9L6erLxKM2zSh+plWFbeWuYJ7uYkDhmHXx3K707xtmFw7RlDBF
	GhA/4KZoRbDqXSUVbWSkPGL2/kfSi8JdMtR2l4QHsZdPH3NwxIgF+F9mJPYUENyqwDQy7OE7okf
	sLMMEQGBYGyd4cUDE86AbKVxNdn0mcesTTzkKGwPLEGA==
X-Google-Smtp-Source: AGHT+IFC+7pVYZMM0Are0zBRmUyINtFSZJDWjFDX5AviFPUFAeK9+iklQK+sjlcgAxp8K7xiUFiUqfnT1C3kRVGxKT0=
X-Received: by 2002:a05:620a:4053:b0:7c0:a6ce:b5a2 with SMTP id
 af79cd13be357-7c39c65cc39mr996591985a.40.1740794907459; Fri, 28 Feb 2025
 18:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227001445.1099203-1-nphamcs@gmail.com> <Z7-9o81kBfw4tFSz@google.com>
 <CAKEwX=MR7bhebu+7qnoUrADL0C2Uqi3Ta7Beo=s0Aim28BSDVw@mail.gmail.com> <Z8DfQahDy7ig643i@google.com>
In-Reply-To: <Z8DfQahDy7ig643i@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 28 Feb 2025 18:08:16 -0800
X-Gm-Features: AQ5f1JqyEYBBBgUCUPdgYFXgP3Vz3mwYcEUDyYrFKZeqBDTW_b5dNl4M3Gn5jrA
Message-ID: <CAKEwX=PurvxHEvyy6tTNxTXVvhUN3Fz=EURb5h0-u7H=pL8UYA@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:55=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Thu, Feb 27, 2025 at 01:46:29PM -0800, Nhat Pham wrote:
> > On Wed, Feb 26, 2025 at 5:19=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.=
dev> wrote:
> > >
> > > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > > > Currently, we crash the kernel when a decompression failure occurs =
in
> > > > zswap (either because of memory corruption, or a bug in the compres=
sion
> > > > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > > > process asking for the zswap entry on zswap load, and skip the corr=
upted
> > > > entry in zswap writeback. The former is accomplished by returning t=
rue
> > > > from zswap_load(), indicating that zswap owns the swapped out conte=
nt,
> > > > but without flagging the folio as up-to-date. The process trying to=
 swap
> > > > in the page will check for the uptodate folio flag and SIGBUS (see
> > > > do_swap_page() in mm/memory.c for more details).
> > >
> > > We should call out the extra xarray walks and their perf impact (if
> > > any).
> >
> > Lemme throw this in a quick and dirty test. I doubt there's any
> > impact, but since I'm reworking this patch for a third version anyway
> > might as well.
>
> It's likely everything is cache hot and the impact is minimal, but let's
> do the due diligence.
>

Yeah I ran some kernel building tests for 5 times, and found basically
no difference:

With the new scheme:

real: mean: 125.1s, stdev: 0.12s

user: mean: 3265.23s, stdev: 9.62s

sys: mean: 2156.41s, stdev: 13.98s


The old scheme:

real: mean: 125.78s, stdev: 0.45s

user: mean: 3287.18s, stdev: 5.95s

sys: mean: 2177.08s, stdev: 26.52s


Honestly, eyeballing the results, the mean difference is probably
smaller than between-run variance. :)

