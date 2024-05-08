Return-Path: <linux-kernel+bounces-172561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816258BF3AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F561F21527
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E63385;
	Wed,  8 May 2024 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RLrrJo/t"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF96364
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128009; cv=none; b=mzrfHxuYkyIrT09/5z90oznQ+gn5dNG+YOUywlNbNZAUZ42pyP5nZNi0iNiRweQFWvHXvGLeIc0jVMgH8Huain4sEmCpFFxPj87CBWJvgOJs8wPwH9mG1Jo3dq1kll/f4esaVJ4EbCxH/v85oDMFdDldsqiNFdHPv/pS2Z4cR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128009; c=relaxed/simple;
	bh=2q9aEjN9x73U9aV1nPPS52wJ3HrjkT//eC62M+3nndE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7qmR4xiOsSJTWmYUpNlwGzaJwf7OqrRn93CXf3pafkwdY3Vne9mtd2nj79z+xfc6tw213ZfxohWjSZ6r9dFePfHe7XSTh95KQUD5gBug/JEcYq395EqMV77aLPzYjjjbAozImk5ec7zcKPo54QKAa82x/hraw2Xp4hOdx+4NMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLrrJo/t; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de462979e00so4133481276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715128007; x=1715732807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/Y8YSo0UflOIrS18HGguXJLlkQlOMDLO/RmzBToNLE=;
        b=RLrrJo/t2hGInbHc6mRkDH2m+e9mOMwCPRH/YT63x6IhMWIhYZs2W1UU3cScy4FlHC
         f93shql2qszOWcDiAzdcnEb67e1YAkvoVZLG7rikhC0uO3HubE4Pv7EAWHIRuTN3unBR
         WgHOWOgG6Z7gl6Z8yca1SksWZ3ey030ls3YO/bv4QZ9QX6Q0ojFfWdsDc+Y3Kc2/KNuO
         b9zRHrXD2t3TiLJjin3oSE2NREcy7yhZ46juvV+pE9rrhvJGfaPIHG/ynt7m2TeSRQOQ
         byHSyoFJe6l2UlPgRwBhjcZIweFUM8gact1gnvWDxqj/C3ncS3BxIINuDqSGJk3lARyV
         Sj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715128007; x=1715732807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/Y8YSo0UflOIrS18HGguXJLlkQlOMDLO/RmzBToNLE=;
        b=b61LkDc+rwH91GW5x6m1iCfJeot1qjDRjZ55YQ9xrInM0/JAzNfWPPmQ6WsXkH7COb
         8/MtKOygoDkOaojMwGDeLIrSgie3UgzoeOXW+BBA98CQcZKx7qSnlSrKuFw0ZOs+/N7s
         9RrHMnLo53V1Iwp8DLbMIPY3Kr7dXfI5dbO4qeOTOtGFkAS7rcc0pG2+J9yoPWH1OxwM
         K9Fdpgl2g6dFDJDmvqTMA3VlmfeNZ2DD/Zf1mfUvdMJIcXQsR4g3y6Vv0otC8dUOQzUq
         KRewssNGlk08EhYH5D3ijpyKyRnsvvXsP2+kVFPtKRiPVALhD/7AWkHWsYAvlqIK3Pr1
         E3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlrEB4V1yo9iT2g5Fgz3C5viAqERR0ebhI+8V1CFlvtkhipITzN0/N7ez97yCcqp3cr7SxDOqmkek8OQobJuFUpgicgojVJ9cATjG
X-Gm-Message-State: AOJu0YxRdROx5+e2mdirk6fSqoCtBYH7+bQYoQZriSckx/GpQAFNdDZx
	BDfRHTgUxlCxq+2SklQS90Gaa5QlfEiNx4bnHJuXOmlRRsrQUZTf+8WiZL92iCxzlt+w7c+XLCy
	yWQFNjtW8vxHP9nn4j9W8QGuxhvUiHvfwgYEB
X-Google-Smtp-Source: AGHT+IEPDVdLbXgASH8Qh5wJ5EWC6SznW5aoq47djjlHQ6ksP/6baMo2OjF/edDMy4kh1QUdKV71GNMk6bIKXAHJdPE=
X-Received: by 2002:a25:2650:0:b0:de4:7816:e7b9 with SMTP id
 3f1490d57ef6-debb9d89b4fmr1346687276.17.1715128006478; Tue, 07 May 2024
 17:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
 <20240503201835.2969707-3-roman.gushchin@linux.dev> <vpkrdo4tbighfh3o3lrr4kfwxcauxpqzktthacj5chqkdkwiqc@h2dmudmh43d5>
 <ZjVUoxAWGCd1uFXg@P9FQF9L96D>
In-Reply-To: <ZjVUoxAWGCd1uFXg@P9FQF9L96D>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 7 May 2024 17:26:34 -0700
Message-ID: <CABdmKX1NfkogiKQ4VGC8WoK4WLEG552QttNSUzLWRT46i2mQmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a
 single structure
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:18=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
dev> wrote:
>
> On Fri, May 03, 2024 at 02:11:17PM -0700, Shakeel Butt wrote:
> > On Fri, May 03, 2024 at 01:18:33PM -0700, Roman Gushchin wrote:
> > [...]
> > >  enum mem_counter_type {
> > > +#ifdef CONFIG_MEMCG
> > >     MCT_MEMORY,             /* cgroup v1 and v2 */
> > >     MCT_SWAP,               /* cgroup v2 only */
> > >     MCT_MEMSW =3D MCT_SWAP,   /* cgroup v1 only */
> > >     MCT_KMEM,               /* cgroup v1 only */
> > >     MCT_TCPMEM,             /* cgroup v1 only */
> > > +#endif
> > > +#ifdef CONFIG_CGROUP_HUGETLB
> > > +   MCT_HUGETLB_MAX =3D __MCT_HUGETLB_MAX,
> > > +#endif
> > > +   __MCT_NR_ITEMS,
> > >  };
> > >
> >
> > Thanks for the awesome work. I haven't gone through all the patches yet
> > but wanted to ask a quick question. In the above enum are you trying to
> > do a union between memcg and hugetlb? It gave me a big pause to
> > understand what you are trying to do.
>
> Yep, sort of. So the page_counter structure supports N independent
> counters, where N is sufficient enough for both memcg and hugetlb cases.
>
> MCT_MEMORY, MCT_SWAP etc are used directly in the memcontrol.c code,
> while hugetlb code just indexes. MCT_HUGETLB_MAX magic is needed to defin=
e
> N at the compile time.

Where N is __MCT_NR_ITEMS for all the counter array lengths? That
doesn't look like it works if MCT_HUGETLB_MAX is small... i.e. there
is both CONFIG_MEMCG and CONFIG_CGROUP_HUGETLB and (__MCT_HUGETLB_MAX
=3D 1 or 3) since MCT_HUGETLB_MAX would be < MCT_TCPMEM and then
__MCT_NR_ITEMS would be wrong?

If so, what about:

enum mem_counter_type {
#ifdef CONFIG_MEMCG
    MCT_MEMORY, /* cgroup v1 and v2 */
    MCT_SWAP, /* cgroup v2 only */
    MCT_MEMSW =3D MCT_SWAP, /* cgroup v1 only */
    MCT_KMEM, /* cgroup v1 only */
    MCT_TCPMEM, /* cgroup v1 only */
#endif
    MCT_MEMCG_NR_ITEMS,
#ifdef CONFIG_CGROUP_HUGETLB
    MCT_HUGETLB_MAX =3D MCT_MEMCG_NR_ITEMS + __MCT_HUGETLB_MAX,
#else
    MCT_HUGETLB_MAX =3D 0,
#endif
    __MCT_NR_ITEMS =3D MAX(MCT_MEMCG_NR_ITEMS, MCT_HUGETLB_MAX)
};

