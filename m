Return-Path: <linux-kernel+bounces-282819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DA94E8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FF31C2186D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456916BE2E;
	Mon, 12 Aug 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKz2wEc5"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F574C14
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452799; cv=none; b=rev7GRMM5HSRGKHz778Uw6eadXPieYFXM7Q+mI9s2hbG063SlSs6zGwn0/93IZ+rjIG+SllIoetwkqH628rnz2ij+SwoescGDhJOLSJl8TvekfccPmSeqjCvzX7Rf8kk5j2BuAXG2DCskh1ONHFnUD274VH5Qg/6TbHOdENh438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452799; c=relaxed/simple;
	bh=bdAG9wiCe8mariX5TumUNhpfNtrGMSbS42GGbYiEv48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOj6Hm0jwV7dCkCQdOIVPB2YLnkEfYUKJjxXvg0S2y4l7oxG+8grcaQCgQPKwxIwepWnN+M7l/22VWIL9dnqLQVxowTvF5YBp0iXbdLjTzIj2xuiy6tKaghpi0OtqDMC2XRUcoVdvOggW/dKE9H6n2JBtdC+PhcWfepO5MhoDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKz2wEc5; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4929fa64542so1580367137.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452797; x=1724057597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzRg5ERg+gUSeCaNauijAePNPU4ZqgOK6zY180TKQGk=;
        b=OKz2wEc5mv4dai5kaGh6/X2Qqb+/jO/AuDoSs4gWSdlchrz7MM9jqssvP9bORR+TeH
         awgSov6PqcVEp47wV1ad1TFo6yQPWFnJK6sBiOM0IWPlg+PLyTCceeq3/XbZ2lVxQAPP
         R/zYIBILeLQs1EfM8gpkuBYuPptHqKJq0AkIpjNkJXePnfIZxPXNHh/UDo/e69yHu1dT
         iGLPXXM4xxOTNMPLczUvJqAaPlPzAWnZdDvORfT2g7ZUAJeKdMnMfEaN6XND8rBOhunl
         BxqLcultQvoW4tbL3OTRZQ1qhns1NWxC5Z9TJ4i3gTL1Y17SVKsNjEthRYYgkAJh46S3
         o2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452797; x=1724057597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzRg5ERg+gUSeCaNauijAePNPU4ZqgOK6zY180TKQGk=;
        b=AZuPEWRtdWuDnYzHcD/BV32Fq2GW2bFELS/34/yq1z1WNgNGk+pJNZ5xCW0xIGdQeg
         ADIpQMvf4tPxYlNc+IHNROy+M+lCpX1/dMP70SFkwRdBhykpEUZuBRrRxYmrzDFEUEDi
         emwXd3g+budAjojqY8HzjUqCc8qMiCy08MdyAqUY1RETrKfFr7H4cO0124GZo9kIaCZ5
         ee3auSIdsDJuM4ZNt/hYyujXRigieaHWYzumorL078vV8kl5O0pp4fdUtJgBiJwroxcP
         7a4/y5WPYbDYnCnAnHfKIKhuCEaKq+fTfSU4ubMrQaQ62jfaFxxHhsuuVf914gKgsPUH
         81/A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ut51f3qSvl2qZJWGge5aZGFQRZBYewtoN/dItuT1Kd6ZSTpxF3YF05nUSgCFcKEeSS4S4CJF/DaUWpf42bnruKFNrZNIX0kYWHBR
X-Gm-Message-State: AOJu0YyznQHIHJm+zzywT/QvkjLoAiOaoyBv7VXz61hJNfc+lvlNIGHY
	AGd+cMLSjKm6lE/JEgEv3Ljtj/0ZMFqIfh1ryQjcfWLTYBTSPbPMUMsbx+vQCFkUu9wJ7k2ugJe
	SVoMqFk/Jk9/Qr4eEdvbgRellPDiaZ2tu
X-Google-Smtp-Source: AGHT+IEL0rOQGs4OcfdcIr+sp0Oe8UukqY2ZAwnwQC0KY2evDuN3tG9lSXqjVtDba5yBRFbPB4x345ObihlXFhxL3cU=
X-Received: by 2002:a05:6102:162b:b0:48f:df86:dba with SMTP id
 ada2fe7eead31-495d83d9094mr11071099137.5.1723452796989; Mon, 12 Aug 2024
 01:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240802122031.117548-1-21cnbao@gmail.com>
 <20240802122031.117548-3-21cnbao@gmail.com> <ZrnHTpzp65iZqTJ5@infradead.org>
In-Reply-To: <ZrnHTpzp65iZqTJ5@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 12 Aug 2024 20:53:06 +1200
Message-ID: <CAGsJ_4z-4mPNaGSuj6spfzms0sa-DtEcKSQwFDOXb6Rn5R_kSg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:27=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> The subject feels wrong.  Nothing particular about zram, it is all about
> SWP_SYNCHRONOUS_IO, so the Subject and commit log should state that.

right.

This is absolutely for sync io, zram is the most typical one which is
widely used in Android and embedded systems.  Others could be
nvdimm, brd.

>
> On Sat, Aug 03, 2024 at 12:20:31AM +1200, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > Currently, we have mTHP features, but unfortunately, without support fo=
r large
> > folio swap-ins, once these large folios are swapped out, they are lost =
because
> > mTHP swap is a one-way process. The lack of mTHP swap-in functionality =
prevents
>
> Please wrap your commit logs after 73 characters to make them readable.

ack.

>
> > +/*
> > + * check a range of PTEs are completely swap entries with
> > + * contiguous swap offsets and the same SWAP_HAS_CACHE.
> > + * ptep must be first one in the range
> > + */
>
> Please capitalize the first character of block comments, make them full
> sentences and use up all 80 characters.

ack.

>
> > +     for (i =3D 1; i < nr_pages; i++) {
> > +             /*
> > +              * while allocating a large folio and doing swap_read_fol=
io for the
>
> And also do not go over 80 characters for them, which renders them
> really hard to read.
>
> > +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > +{
> > +     struct vm_area_struct *vma =3D vmf->vma;
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
> Please stub out the entire function.

I assume you mean the below?

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
static struct folio *alloc_swap_folio(struct vm_fault *vmf)
{
}
#else
static struct folio *alloc_swap_folio(struct vm_fault *vmf)
{
}
#endif

If so, this is fine to me. the only reason I am using the current
pattern is that i am trying to follow the same pattern with

static struct folio *alloc_anon_folio(struct vm_fault *vmf)
{
        struct vm_area_struct *vma =3D vmf->vma;
#ifdef CONFIG_TRANSPARENT_HUGEPAGE
#endif
        ...
}

Likely we also want to change that one?

Thanks
Barry

