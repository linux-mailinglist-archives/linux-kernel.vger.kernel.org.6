Return-Path: <linux-kernel+bounces-346385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E504598C425
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A8A2842E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B91CB508;
	Tue,  1 Oct 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJf/EIFl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714718CC0B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802269; cv=none; b=s4m7mmU31wfwtmXjiprfNZv0cBnkhrxmJdshMHyS7O+q+j3jGA0/X/YHVYp0MWGXHjvy9AChzZKkKJEyxlKSoAp545nz5cn/+IyHR8dDEKdJ9gQOSGJq+xkVOhwlr9swDDvFThcQrGntsxElWua7fGSWSrpNzkIHCWoLVKAocL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802269; c=relaxed/simple;
	bh=NHah/p8BjP7i8E20p7sv1iprW6pzJ7tz6kElnalgvWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqvWF4S6kUPud605H4wZIZHDYE8Y8lHZc333Eaz8h5MP/skq7wcy2Bind6A7EiyrFPlDFcgNGVHq82DhMDGY6ctIgvmqWyCamLfU3XHbAKZ5K+WIQjleDqKxYA+taFsau3if3uL0/+yloyMc3ljEmwBws+liu66m5yRZ9hZ1NOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJf/EIFl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83562f9be9so42687966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727802266; x=1728407066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me1FX2lppyIL/j5P9cOe/gDvckfgLnvmXcT9GxnrPYU=;
        b=dJf/EIFlIqRKDQzuWe6B/kfCf4ygmCyfqwgKFM6RYebIdd2xRTRIyrQvVfKX5ILWs0
         UCm8qKfCguZnOdgqjnWrXCeRM96CjYogk75HbT/6OTnDwgWA6pGUOI1d/jAN4U4rGDqJ
         KojNW1SyYCP6FwMAasZpC89fXHBqeeznXcHNxsZpI5gEhWdHpkotrSAnSWd77Nbg+QJz
         Dr01+ccPJNdB3BLDkD912vuOiPKS95STI0VDauQ7Xi61ygRcqZffR95CD3Z+Psm+VPz1
         Q33XrXFxnyktVjX88H/CyR+UFvHaA4cN6jyNY3qgCZ6v3YtZmORu+e9GcrmEdj4mkJKT
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802266; x=1728407066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Me1FX2lppyIL/j5P9cOe/gDvckfgLnvmXcT9GxnrPYU=;
        b=wh9co2FBDVbF+Ku9gbDFjDkYwhDXD4ShOPXJK5bg1PhTuhnV5kogxH2PyrHO8pNCVV
         +Q4VfyIIZJxmQjL9aA4B9NWR0Jo0fmusJMJatDSjwPx3C8fPnpsfPfmfX7yh9yCeCwt+
         S9EHQlgyK2nxdM9PS/udwpsV99tTuOHn6wmnI2PGahb73zamQ6vIHLZGbw0Dp6Sq5C98
         PBGKg6I4d6Hc2cnFjHLNPAqcXi2KGrgkXz1iFyWcbC75HfDEOVmMOg9SYTEnSaJ4tVvB
         bmrPOdnuaZ6ZGYUXiv5zrUTqCjI7bj88XhbFFIDyxPnQ5F4gW4qJdbKcXwCcQgC1IPUz
         CBig==
X-Forwarded-Encrypted: i=1; AJvYcCX48bUt1SWBf9EymsIwC3gRvAZo4DLhaqHeEaYL54LIHZAgkYei3nDNVP8elO5hEHEdyJ7iAhcXaf4r1Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4pDvdnMt1NEES487vprLhofHnn5pcCBvg6PmpBX6U3soxFNr
	QQo1NoA7zHlZXK6z+i3rHTnCmctCkFa6hO4nj+bflTYzBfwSndfIL7JnyxSEN2BEooHpc7xegU0
	b/DQ23obrPDl76lYEJ5k/n4osMHd+++gfDlcJ
X-Google-Smtp-Source: AGHT+IGWt5bne4oNMH07QjwYPIuXsLAedm9zyIphbqhDR20VgwILmh2dIAAEPKSAwK4+Ick9yHCoxti2CBBAb44dRIQ=
X-Received: by 2002:a17:907:3181:b0:a8d:2a46:606f with SMTP id
 a640c23a62f3a-a98f8268e89mr19569766b.38.1727802265852; Tue, 01 Oct 2024
 10:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com> <20241001111045.GA1003400@cmpxchg.org>
 <SJ0PR11MB56786570AA6C6C8EE7FFC0BDC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56786570AA6C6C8EE7FFC0BDC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 10:03:48 -0700
Message-ID: <CAJD7tkYtfHyRgxqb_gGVLfWBHdwzmkD+SRHnBbSdv-59eWLPqA@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:01=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> > -----Original Message-----
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Sent: Tuesday, October 1, 2024 4:11 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > yosryahmed@google.com; nphamcs@gmail.com;
> > chengming.zhou@linux.dev; usamaarif642@gmail.com;
> > shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> > <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> > willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi=
 K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in
> > zswap_store().
> >
> > On Mon, Sep 30, 2024 at 10:32:21PM -0700, Kanchana P Sridhar wrote:
> > > zswap_store() will store large folios by compressing them page by pag=
e.
> > >
> > > This patch provides a sequential implementation of storing a large fo=
lio
> > > in zswap_store() by iterating through each page in the folio to compr=
ess
> > > and store it in the zswap zpool.
> > >
> > > zswap_store() calls the newly added zswap_store_page() function for e=
ach
> > > page in the folio. zswap_store_page() handles compressing and storing=
 each
> > > page.
> > >
> > > We check the global and per-cgroup limits once at the beginning of
> > > zswap_store(), and only check that the limit is not reached yet. This=
 is
> > > racy and inaccurate, but it should be sufficient for now. We also obt=
ain
> > > initial references to the relevant objcg and pool to guarantee that
> > > subsequent references can be acquired by zswap_store_page(). A new
> > function
> > > zswap_pool_get() is added to facilitate this.
> > >
> > > If these one-time checks pass, we compress the pages of the folio, wh=
ile
> > > maintaining a running count of compressed bytes for all the folio's p=
ages.
> > > If all pages are successfully compressed and stored, we do the cgroup
> > > zswap charging with the total compressed bytes, and batch update the
> > > zswap_stored_pages atomic/zswpout event stats with folio_nr_pages()
> > once,
> > > before returning from zswap_store().
> > >
> > > If an error is encountered during the store of any page in the folio,
> > > all pages in that folio currently stored in zswap will be invalidated=
.
> > > Thus, a folio is either entirely stored in zswap, or entirely not sto=
red
> > > in zswap.
> > >
> > > The most important value provided by this patch is it enables swappin=
g out
> > > large folios to zswap without splitting them. Furthermore, it batches=
 some
> > > operations while doing so (cgroup charging, stats updates).
> > >
> > > This patch also forms the basis for building compress batching of pag=
es in
> > > a large folio in zswap_store() by compressing up to say, 8 pages of t=
he
> > > folio in parallel in hardware using the Intel In-Memory Analytics
> > > Accelerator (Intel IAA).
> > >
> > > This change reuses and adapts the functionality in Ryan Roberts' RFC
> > > patch [1]:
> > >
> > >   "[RFC,v1] mm: zswap: Store large folios without splitting"
> > >
> > >   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> > ryan.roberts@arm.com/T/#u
> > >
> > > Co-developed-by: Ryan Roberts
> >
> > I would change that to
> >
> > Originally-by: Ryan Roberts <ryan.roberts@arm.com>
> >
> > > Signed-off-by:
> >
> > and drop this for now.
>
> Thanks Johannes. Sure, this sounds good. Should I post a v11 for just thi=
s
> specific patch which this change, or a v11 for the entire series?

Andrew could probably make the change for you while applying the
patches to mm-unstable if you ask nicely :)

Also since we agreed further cleanup can be done as a followup:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

