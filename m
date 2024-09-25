Return-Path: <linux-kernel+bounces-337835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F111D984F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FB2285016
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB22E541;
	Wed, 25 Sep 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkcCtTSV"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D4DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225044; cv=none; b=V8Ua8vbQ0yG6NKAKUgMjtMUCm9+UtJ/DuyJQii6U3J7RQKlHjurHWgrzQ3ApgTSqdSgit1l8poTiNwGIanee+NaxdZ/Ez9Pd5SEet1ixNO4SprIeJbAzqALe19H6TxuTCFJa6RYlz3X5Wc8puSPNJVZ1qgtJdp20M4g2QYn5dyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225044; c=relaxed/simple;
	bh=BHNAJ7uJWmxlvrv9db+1drXxKb7N4HYWK+/tuFG9R6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwJXH1rvmp6D0DdT3R26bgv6XzsbliO89HLhfKl2K/Qi9Rw024hvE8XoBqFXs9ou7JpeEO/OPfX17/u+CwIgb+TYy6KNw62mCmodC1LaUNMnQuQY6QFBm4RKkFwXWzHangham/iNlHABdOc08r7QUetzq6NDDV/tbJgrWQCh7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkcCtTSV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso67063166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727225041; x=1727829841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJi2L8GyGwoT7qv+pMxak7hzPYu05kdSza9kqGDuKdE=;
        b=CkcCtTSVuJmMGQ10U+AdZwPv4w1wmo0ClXu8d8fY4Am2NsdTdf4dsEK9U5RvTm7D7K
         ev8B07HrDSmweWBbOa5C0GWl6KXdT51lBBrXp0+bvVHlWJ/QvyKuwrhByUYrbtPjauDR
         Cf1jKs9CGW4bSYqV+WyCIvyGL2KGz647IN5vw1Vk/taq8O/ljpKp9X8jgksDQ+oDU1EC
         NX5hfExoCEwSfzMsKXQRCDaACEPJUliIBuC9jIQ82Vr5/gOwdz1Psya+3GcpwfPsdogL
         HFJ/jI1+u4KoF9cogFW0P1EN4+pWXPmqtcwfUrFfmShA+9YiJWjVYMQ0hitvzCGSmzgZ
         QJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727225041; x=1727829841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJi2L8GyGwoT7qv+pMxak7hzPYu05kdSza9kqGDuKdE=;
        b=YmY3uzQHV1+npY5spI4jbE3jAtdfdCoyhXVDB6TLQex+LBIjn4l1OI4ISq8EF4n594
         WF8O+JnGopJqB5ZMqi2wk67QV2bZ88ADX4x0qEid4TDd/kjiBrYbOND1SKYp+ven+qse
         lrhkXKlVJY0qwvNIxnx68PalVtDmOsmnPT4GI7QYdLk/kpBWwoOwLj9gpRmO3jIosGE8
         2DdvivPMHnODO/wonGhGHdNmugubbYNSihZDV1x7s7tXjL1YcStXmotWgSD3i+H5EycU
         h2ux4sxT1Y/MBCg4Avl8oZDu2y46nTZI6Org4BrtyxfCaj3eamusHcnglHQcW9qL8R+V
         K0Bw==
X-Gm-Message-State: AOJu0YzPGmkyBRFR1fBs7lG6P0/lipbfvTPIOYOitJV3WxIuPrPxmaSO
	wnuJ9JHAhorxcNq9BK4kyax7dkCjlIPDFD/ccFDgivO8Mgyb+rc8qXJzfGt9xq4r4HV8uhR8ZNv
	AJlEf11Kwdm38DeewzKFapz1/2TqbZmN+wrrAO7T3l+Fy2iWE2w==
X-Google-Smtp-Source: AGHT+IHX2NYpXdGM7kuVX9QLVKYJ1CekqVQmRM5AlnWr0eq6Uj/GUufVxg8WQ0twEEIpboTdLbxA+ghZsOlkkLVY8oE=
X-Received: by 2002:a17:906:c147:b0:a8d:2afc:c06a with SMTP id
 a640c23a62f3a-a93a17042a8mr67026166b.19.1727225040808; Tue, 24 Sep 2024
 17:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-5-kanchana.p.sridhar@intel.com> <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
 <SJ0PR11MB5678E588D9640C92E06AB0A8C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678E588D9640C92E06AB0A8C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 17:43:22 -0700
Message-ID: <CAJD7tkbRewK-L07GPzX6YtBnw7zpA1NboBCEyszoT4=-PvpdYw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:33=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, September 24, 2024 12:20 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; shakeel.butt@linux.dev; ryan.roberts@arm.com;
> > Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored
> > offsets in case of errors.
> >
> > On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > Added a new procedure zswap_delete_stored_offsets() that can be
> > > called to delete stored offsets in a folio in case zswap_store()
> > > fails or zswap is disabled.
> >
> > I don't see the value in this helper. It will get called in one place
> > AFAICT, and it is a bit inconsistent that we have to explicitly loop
> > in zswap_store() to store pages, but the loop to delete pages upon
> > failure is hidden in the helper.
> >
> > I am not against adding a trivial zswap_tree_delete() helper (or
> > similar) that calls xa_erase() and  zswap_entry_free() to match
> > zswap_tree_store() if you prefer that.
>
> This is a good point. I had refactored this routine in the context
> of my code that does batching and the same loop over the mTHP's
> subpages would get called in multiple error condition cases.
>
> I am thinking it might probably make sense for say zswap_tree_delete()
> to take a "folio" and "tree" and encapsulate deleting all stored offsets
> for that folio. Since we have already done the computes for finding the
> "tree", having that as an input parameter is mainly for latency, but if
> it is cleaner to have "zswap_tree_delete(struct folio *folio)", that shou=
ld
> be Ok too. Please let me know your suggestion on this.
>

What I meant is "zswap_tree_delete(struct xarray *tree, pgoff_t
offset)", and loop and call this  in zswap_store(). This would be
consistent on looping and calling zswap_store_page().

But we can keep the helper as-is actually and just rename it to
zswap_tree_delete() and move the loop inside. No strong preference.

