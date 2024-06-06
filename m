Return-Path: <linux-kernel+bounces-203450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA58FDB6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FC92869FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90736748F;
	Thu,  6 Jun 2024 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="reB9rPFk"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459ADDDBE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633536; cv=none; b=fKyEBkuhbILgT2NPizd56bQOVTsWGbxlsPdRQ//+T2b9Cc1uwZExP9i2RVeNigCkosZTDLZS+wuh5lKaIznTMh4zbQoSiz16ab/F4KVjI+pB5YvJJYruVQsa22TTxcmc3ea5nJjxxK7bQaeQVcvaOmh6oTsePIKbt0BN12q84hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633536; c=relaxed/simple;
	bh=dYRha53t4NxTSTFvRcE2NzVlp85LN/L+1WqHltJNom8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7zL3aB8xZZOQMO6XdnncEpxuG6UalIs4vX/+Sj5Ubct11ExfoGiU74vI1IeyJMyW0qyiZWVRTaOHF8AYvo9KDiAoU6akKvzz/vz4gr6dCW/owshF7N9q7dslVxa02JYYhqmGvAE3013RHD4+ZjgA7J8RO0JMbFy2o0E1RYdotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=reB9rPFk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7951da82ea7so21251285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1717633534; x=1718238334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1s4PX2KCyvcBADkbBYVK0pP1bkY3AHPso5o+d0yEf4=;
        b=reB9rPFkpz+CEYX3u/AXIbOZTiof1xGTIKyiGObTMwaMgQJwaYEVQ4CeqJaHzw8LPl
         65ec/Vu5pKlHqH2Vvmfy/jGpYTLf5hOv0qMGJ0fQIxV8MX6uYkeq+mpbVv14n2b114Vx
         aN8kUATgpB00TJ0+bWxPuHYAje4UWxnKSE9s/+nvVNukG1u08T/H14AQBIoKENGVcWra
         imYLPgalY0APPzOMyj7XE8M34vxAiq/lH5jlHQW36y39KKmsASElvqVrK+3mO9MyNEHG
         7Extk8ADTILMcM5aGnRIKhQEtKxKViUJxDIe1CODHfBpwjkitjG/tUfOalNDnfdhoftA
         xMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717633534; x=1718238334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1s4PX2KCyvcBADkbBYVK0pP1bkY3AHPso5o+d0yEf4=;
        b=fvONfrhXKzIqjGwMSVbtO3kfVFlISPF8RLITRS5kSrzzoyLY5Eb+WzwLNv8xuCfJN4
         OT1gCs/TsiAny/JDjxIxRfnKSrKrwZc5Ef27Uwfr2LjIAakOoQkkYq7Z3tkEeyPrVXe0
         D5wIlDaydFVm/TOJDjbh5ALzAZd2tW2KXFsksRxVxMKQQ62jGHx++u1p84S+TcTbxUb1
         wEffo+b8haLlSgksHLGSowlVQabyWNqaMsVzRgWLaV5PKAUPq3QcRbF0pyOtO4UFAFG4
         HebarhNqAFqYeNbEyqgb8M4PqV9UQJlBYaHErbzyU994m0f7GfjpG/AiToG/qQNZZFCJ
         mpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhCrqP5Ax+iT06yX3fsuEqi20wqHPVF2rR6lapaqIJdNpQMTmuHzGZw3eb245Ev1YFCb3P3qJyKwOwy3fU3ZS82kgooLAsYvo7d32d
X-Gm-Message-State: AOJu0YznmIkTXJyUxC2XrGnEk5Ipl78tY9OXTvz3jfjtAIEzFR431PLO
	bry+JnotzP8uZMs24+y/Ro5pH7CpwTIlLWobv0b8Ys4RLQozFRGZNUsy0tmcQIIZwiRAdP+2LjR
	AGbH4Mw3w1JUm6z9TA6ECcGSg124v0H5HijfwZg==
X-Google-Smtp-Source: AGHT+IEv5O+VTVcNzKe+sdpf8DdQPjO4FPLYUjb0gFxY2yKveF0NVL6NkUVNTkQHOMsQhotZMBaeOCsjA535Rk9etHw=
X-Received: by 2002:a05:620a:4d3:b0:792:91e0:e236 with SMTP id
 af79cd13be357-79523d6df6fmr425892385a.30.1717633534136; Wed, 05 Jun 2024
 17:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605212146.994486-1-peterx@redhat.com> <CA+CK2bCCeamiaoTFybTd5nW39ixVPDM2gV2rMmK+2PfFAyE+9w@mail.gmail.com>
 <666100d39dee4_2d412294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <666100d39dee4_2d412294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 5 Jun 2024 20:24:55 -0400
Message-ID: <CA+CK2bD2=Nd+wDtvphS-x+2xQWnMKwy-V4jVD2drV=xxKhqUnA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
To: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 8:20=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Pasha Tatashin wrote:
> > On Wed, Jun 5, 2024 at 5:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
> > > pages: they map PFNs directly, and they don't allocate page_ext at al=
l even
> > > if there's struct page around.  One may reference devm_memremap_pages=
().
> > >
> > > When both ZONE_DEVICE and page-table-check enabled, then try to map s=
ome
> > > dax memories, one can trigger kernel bug constantly now when the kern=
el was
> > > trying to inject some pfn maps on the dax device:
> > >
> > >  kernel BUG at mm/page_table_check.c:55!
> > >
> > > While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for=
 page
> > > fault resolutions, skip all the checks if page_ext doesn't even exist=
 in
> > > pgtable checker, which applies to ZONE_DEVICE but maybe more.
> >
> > Thank you for reporting this bug. A few comments below:
> >
> > >
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  mm/page_table_check.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > > index 4169576bed72..509c6ef8de40 100644
> > > --- a/mm/page_table_check.c
> > > +++ b/mm/page_table_check.c
> > > @@ -73,6 +73,9 @@ static void page_table_check_clear(unsigned long pf=
n, unsigned long pgcnt)
> > >         page =3D pfn_to_page(pfn);
> > >         page_ext =3D page_ext_get(page);
> > >
> > > +       if (!page_ext)
> > > +               return;
> >
> > I would replace the above with the following, here and in other places:
> >
> > if (!page_ext) {
> >   WARN_ONCE(!is_zone_device_page(page),
> >                           "page_ext is missing for a non-device page\n"=
);
> >   return;
> > }
>
> Hmm, but this function is silent for the !pfn_valid(@pfn) case, and the
> old cold has BUG_ON(!page_ext). So we know the caller is not being
> careful about @pfn, and existing code is likely avoiding the BUG_ON().
>
> The justification for the WARN_ONCE(), or maybe VM_WARN_ONCE(), would
> be if there is a high likelihood that ongoing kernel changes introduce
> more pfn_valid() but not page_ext covered pages? Is that a realistic
> scenario?

Good point, it is unlikely we will have scenarios without page_ext.
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

