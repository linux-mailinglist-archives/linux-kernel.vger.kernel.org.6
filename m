Return-Path: <linux-kernel+bounces-339511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19B98662E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E971F259D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D012C7FD;
	Wed, 25 Sep 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lrxlhy0X"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D761D5ACD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288293; cv=none; b=B233NeKaLqPM35wEZEH1pFmQXTRgqn4S/uhsAcH3WjsZzVHLE7na6bpQFlZyUA32S5Y1k00UyjM81IFiSe3Auc6n3Fbj+AxTVzbF8M7IYkyLek7GPT1COW9mwF2+Ghow9zSxFFjay8Zsh6aTobYQmLu4uqMgmDGx+EjfDeRyv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288293; c=relaxed/simple;
	bh=RdW82l0CEtQWDRVvjJpkeUR1WmxtN49UrfkmOZn8KWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGbDfBvLm37I1asN09rbZqjdUBGkUD1Ki6IXNbEsl6qy9Q/6f3oroMIiAQCRg+/zmyru1fb+Tnkdcsu+qEDZQxwPssy/cGvTiDQBAaZN+dXHVkGz28fAt+/8FVtfKqDkg4yvU2oHpiCyHTS86Zoz2mo4O/vFcFw8jZ8f9eHOzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lrxlhy0X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d4093722bso21280066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727288289; x=1727893089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdW82l0CEtQWDRVvjJpkeUR1WmxtN49UrfkmOZn8KWo=;
        b=Lrxlhy0X99t7I/fvNSZg4y6px/b3zsTKDBLTosIX/Tl2RMTpi7Zs+nTOxHDVZIJNrU
         jENyrY1XthCa22DLh2QPjr77k+j8AcDK/f2El52St7SzTX26yFq+OQgMADHyW1NYqUHa
         G9zjTee+LVi7u2E/x1hbZaCegNvZ/tYMeDFHPrGHDhGWsdzVHfc1b+epauBQDlLeMXFq
         A/612ccFzVuDNzNPjfGYEhLLWz4vTomQqsT4iEK7QK1/KeFLMXQOFWVuigQxdnTgu6+N
         MzHWuBkoA2I+77t2xCP2HJdVmIEjaQ1ymdMhUdTN3pLX/xKjw6RbNAaeAxJ8wLEw2CdE
         B1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288289; x=1727893089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdW82l0CEtQWDRVvjJpkeUR1WmxtN49UrfkmOZn8KWo=;
        b=QdT9lJpIG9kR3F46cHJio9d6rz/GBf48juKzHJb9fsBbg7n9PSoIuIyNBZY6s3vMiX
         fYW83e03Zpxt16fucw4FkPST5sAy+OMTb52lpxwqoC7cjnI1l/VwHWjpbHXDikFbnF1o
         bfe1pOynMpQSdTSyh1J2tPshQgIZYTEGx37bUJrQkLWRptd87oq8LV8J8ib7Oy3vWMvs
         KO34zUDY4GqJp2ZplwnCHBUz2hUDZpy09vVAP14xj57KxASfqoxw9c9Py3OPHcqmZP0j
         oDurLjAE1SIVfvjdh41aHEhRkoy/gYtYID4Tm7Rs5rw6FN0hk1nIQjqy4RyXAAYwZdCq
         l/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVeJ00dssV0TLbcI0XbsBRPcoMlgT9wYWj5AZENXRLR6GNNgju3IL1pyzzpakmOrXZ7IkLEJg2IzD145J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAtA0OYlAK4UOO1WbXtxw2dBwoUnhYQy3NHT3Iwar6xwulzdI
	zmaO9djbm/iHqbqAlha/RSCKJp6iFFlJH4dIqiDFnFY9PgQ6ANJdYQ9eyh+XhCD6LAHlUs9XRen
	7iOAzY714tcF8csjnb6ixILR/cnAXD4gLpgPjeQxPPXBnSzheOg==
X-Google-Smtp-Source: AGHT+IHV26DgO5vUM/i6lQ/pvqfkbICr8tb71JeHSFuhXswVdTAZDLXdsGexDUBLxiY8EXC1/lI5qvqm7v3IRj+UI9U=
X-Received: by 2002:a17:907:944a:b0:a8a:9070:a6ed with SMTP id
 a640c23a62f3a-a93a03e07bdmr381799866b.31.1727288288323; Wed, 25 Sep 2024
 11:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <20240925142741.GD875661@cmpxchg.org>
In-Reply-To: <20240925142741.GD875661@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Sep 2024 11:17:30 -0700
Message-ID: <CAJD7tkam-Qbh-mJD3nTe1hX6JDtzS66Ej+1Fvo1kmg8WuwVfQA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:27=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Sep 23, 2024 at 06:17:07PM -0700, Kanchana P Sridhar wrote:
> > zswap_store() will now store mTHP and PMD-size THP folios by compressin=
g
>
> The hugepage terminology throughout the patches is a bit convoluted.
>
> There is no real distinction in this code between PMD-size THPs and
> sub-PMD-sized mTHPs e.g. In particular, I think "mTHP" made sense when
> they were added, to distinguish them from conventional THPs. But using
> this term going forward just causes confusion, IMO.
>
> We're going through a big effort in the codebase to call all of these
> things simply "folios" - which stands for "one or more pages". If you
> want to emphasize the "more than one page", the convention is to call
> it a "large folio". (If you need to emphasize that it's PMD size -
> which doesn't apply to these patches, but just for the record - the
> convention is "pmd-mappable folio".)
>
> So what this patch set does is "support large folios in zswap".

Agreed on all of this, except it should be "support large folios in
zswap _stores". We don't really support loading large folios.

