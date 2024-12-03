Return-Path: <linux-kernel+bounces-430002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E39E2C88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF50B36331
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2191FCCE0;
	Tue,  3 Dec 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfC52Thg"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D1F4733
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250032; cv=none; b=uenrhypyWhP138ZaVFM3vS3ZeLBquxLBsh+JAoVLO2hgx3ZTwYMF7Km410VF0F7xicoDFPPwAAbxnFtp+mL4fJuwgZBnXCRqttnyCQQEOkPNwBTwfp6qbrRRlmcg2tabhJU2u6iUyAyE/YyEmFOsjoh7WXBg2KDSDKcBYwOOBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250032; c=relaxed/simple;
	bh=Tg77dCDtAZmva1ERfchmhVsuVVdvrIhUSXlxK5rUApI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzf0mufgCaURwvgujwCt/gmRIZ35i4LZU9wd4uq7sE8g31nVsQ727Eu600bGDQHubP7uI/NshU2qWU8b8u7WONwOo1S890Zt4akwt2p4P9YSNYKdLOE8x5P/euVy9JC2GYJO+uVkWK8SKcDZ4Ur1pkCZOKa2Oxbnpu8xD3+gRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfC52Thg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd796ba0aso58562771fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733250029; x=1733854829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBCDNod8qWx3xnslvb8P0JxN8cIjahJejEW0GBjZxls=;
        b=DfC52ThgcUUvNFbmbviRevJAWj0ug1ZQId95Q1Qa2CMB+I7OsodjFSXsUycA9ABFlU
         7fM/j5DkBRCUuRWiDALUP7zWeG9f39XW3qcmzp2r3tGKY5CROL1k9I9D4WipuC7GeNl6
         eyWo8vY2+cjTAV80CG377eQx5FyjSDrUIVzTU9Mx5QC4LIl1SSzCL1uMV1Tv8ifabrfI
         1eBB/bN8cotNk6kZMHdAa8TrFj5/YFpqAeGhk4jO6kTeNAZRN1ZxsoDAVSWeCUF0QGsN
         BDTBV0RPG1g5YOspa93QwYZ83XN1suEKnE/MmiKTi6nW2CY4Mnm4VOW9n16STXM8SKf6
         i+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250029; x=1733854829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBCDNod8qWx3xnslvb8P0JxN8cIjahJejEW0GBjZxls=;
        b=UXyNbDBA71Cs+NBZV1Olr/ypjf1orDtMcPeUl1g2YfXwP0ia0MTmBEqgVAgwdtDrcC
         ynkfcY3+3KOAs92iDfxeFHBNeGm38jpQ14QQvhq9rEMMP47uXeX4uzPzSluAyGGGDwqZ
         QkPDil/o4ZjwzSsRJWcjolsVK3q6L8ACl3DKixZmodti8WaHfzlqjPn3o55q/7cc4wgH
         ZN/JJGNZJ0ziB5kaCw2XjTN8feDHlLVN6VGXYfRylH3Bkwy3NxqpeWe8XQsdtkc+9/sD
         hpmoy5qxxUOzdqFHu14hlKLrSt+t2Z1WxjTd0RTe1IbY1YCCxzGP/4zgV6OY9xUDk4D8
         Z1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHR8wgQAey5qkE3ol7xCOOSFwWaCT0CYwxWug0SiyFDLZZ45bC8O9s/6WdeLfO4EAg3utt/AguvsfiWe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywat0OUDG0fAD+jydMCR9fMS75kcAoXyFdC/+C3qzFca187AzRC
	qey9yEF1p/nOM9rUd2iZgSNJi+/OVoZQvZ+2G4REvvDfVJ54ZIj5SCUdeQNbfRoM5ogIikMq0+j
	a7KDi78EPE8pxgfHEOg9HKvWei4ruObsloVb9mA==
X-Gm-Gg: ASbGncs2NNdTT+SrPQlcthjRRCCiuwiWOx4/zDd+OOCZ/o0fqkzi6NHeLlzPQo3XGAu
	z4tYiayv/Dr2zUBu0fkDVDlCUTWw5ieE=
X-Google-Smtp-Source: AGHT+IEHtgXqV5spgn1jCShCpH39AID9i3tZwDZ7iC8o3rSlviejHzCRZmbFFMLWYH1agF3iiTjCbND+KCX6cd2ikxo=
X-Received: by 2002:a05:651c:892:b0:2ff:c741:db84 with SMTP id
 38308e7fff4ca-30009bf618dmr28772601fa.1.1733250028557; Tue, 03 Dec 2024
 10:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
 <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com> <CAJD7tkaJt19hNF+PhTUuop0rbpsnzWRs7837jTCMpw6=uVTosg@mail.gmail.com>
In-Reply-To: <CAJD7tkaJt19hNF+PhTUuop0rbpsnzWRs7837jTCMpw6=uVTosg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 4 Dec 2024 02:20:11 +0800
Message-ID: <CAMgjq7CJt21a0=bfzvndfeLB6+9AsLwnF3sQs1-ET5CgOZsLsQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Yosry Ahmed <yosryahmed@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Mon, Dec 2, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintai=
nance")
> > > replaced the cmpxchg/xchg with a global irq spinlock because some arc=
hs
> > > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
> > >
> > > And as commented in swap_cgroup.c, this lock is not needed for map
> > > synchronization.
> > >
> > > Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implemen=
t
> > > it to get rid of this lock.
> > >
> > > Testing using 64G brd and build with build kernel with make -j96 in 1=
.5G
> > > memory cgroup using 4k folios showed below improvement (10 test run):
> > >
> > > Before this series:
> > > Sys time: 10730.08 (stdev 49.030728)
> > > Real time: 171.03 (stdev 0.850355)
> > >
> > > After this commit:
> > > Sys time: 9612.24 (stdev 66.310789), -10.42%
> > > Real time: 159.78 (stdev 0.577193), -6.57%
> > >
> > > With 64k folios and 2G memcg:
> > > Before this series:
> > > Sys time: 7626.77 (stdev 43.545517)
> > > Real time: 136.22 (stdev 1.265544)
> > >
> > > After this commit:
> > > Sys time: 6936.03 (stdev 39.996280), -9.06%
> > > Real time: 129.65 (stdev 0.880039), -4.82%
> > >
> > > Sequential swapout of 8G 4k zero folios (24 test run):
> > > Before this series:
> > > 5461409.12 us (stdev 183957.827084)
> > >
> > > After this commit:
> > > 5420447.26 us (stdev 196419.240317)
> > >
> > > Sequential swapin of 8G 4k zero folios (24 test run):
> > > Before this series:
> > > 19736958.916667 us (stdev 189027.246676)
> > >
> > > After this commit:
> > > 19662182.629630 us (stdev 172717.640614)
> > >
> > > Performance is better or at least not worse for all tests above.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 41 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > > index a76afdc3666a..028f5e6be3f0 100644
> > > --- a/mm/swap_cgroup.c
> > > +++ b/mm/swap_cgroup.c
> > > @@ -5,6 +5,15 @@
> > >
> > >  #include <linux/swapops.h> /* depends on mm.h include */
> > >
> > > +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
> > > +struct swap_cgroup_unit {
> > > +       union {
> > > +               int raw;
> > > +               atomic_t val;
> > > +               unsigned short __id[ID_PER_UNIT];
> > > +       };
> > > +};
> >
> > This doubles the size of the per-entry data, right?
>
> Oh we don't, we just store 2 ids in an int instead of storing each id
> individually. But the question below still stands, can't we just use
> cmpxchg() directly on the id?

Hi Yosry,

Last time I checked the xchg status some archs still don't support
xchg for 2 bytes, I just found things may have changed slightly but it
seems at least parisc still doesn't support that. And looking at the
code some arches still don't support cmpxchg of 2 bytes today (And I
just dropped cmpxchg helper for swap_cgroup so that should be OK). RCU
just dropped one-byte cmpxchg emulation 2 months ago in d4e287d7caff
so that area is changing. Lacking such support is exactly the reason
why there was a global lock previously, so I think the safe move is
just to emulate the operation manually for now?

>
> >
> > Why do we need this? I thought cmpxchg() supports multiple sizes and
> > will already do the emulation for us.
>

