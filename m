Return-Path: <linux-kernel+bounces-374869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E19A714E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2FEB212A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B821EBA08;
	Mon, 21 Oct 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFI6ntfQ"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71D5028C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532894; cv=none; b=U9e4JGB/ggbWogFhqZbp0AVgzPrkFlbsQx4WADrzZ/dXDpuse7BWU07UEbtbUBmLGOdFAUohs5y83Qljq5iUZf/ZI5xDUmIYvctQ0mmrej3dqIiZK8irlJvOxXqGr0b27/GCzdtZOcAzk2fSS/A35VtT9nRAwQj/xXkpXYmWCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532894; c=relaxed/simple;
	bh=XSKtuWfXkXy1EUZnyfOH7RilgH97BOuVx5La/ly0D7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHhDiQoQHR447Op+P4n8iPcY1RziMA+7PhLAvHuFizEzwsGFg4ePzfSEmF6p/O8O/wNfzlheb/4nI7KhhKMLXthiouovquy9mEGU9RrDwGr+alVbXYdD2AQy8oXLW0dKGYDyLydoXZKgucZRBBMbFTAAlsAN7XUoYsg2hnUuoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFI6ntfQ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a49505ba64so1259458137.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729532891; x=1730137691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6xfJqNYxgSFtrrbl27/AR1F/LasrkKf3mfqMuCjZvA=;
        b=fFI6ntfQ3pjUoj6oPDo/IByRQsJ+wJsGh+7FpTZXLA6FKWzabuHE7Hn8VDbO+zw1rs
         eDZh3hcwdQwma4cUoQ/VQVT8LcWAdj+9fPuHju3SrBl0t9CAjA1tpQSxOKI+v1xHVAGG
         br6I0FcaawzE4Ad7bYw8cK6ZOHD1qk+Nuf4P7+1/3TFwXHFrbAIeHLb40uRrgokBalEC
         kf2NpOGu980b00SWxQbNVQNktqQzfQnRvGcIsdXp2Y2B4pUC1P0gFIkEuKyNPKFjZl/H
         VPJtmvBBC0XwKdjFVrsz4DJ8WCtBiRSKmanLQqLBqW1E3yLVh0rqjF4gRWg9nhcVjOmx
         oXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729532891; x=1730137691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6xfJqNYxgSFtrrbl27/AR1F/LasrkKf3mfqMuCjZvA=;
        b=TuPrqNSyOtT5KIBqWoHNSpRNfLZuuE0ZfS7vpQNAdWSVI51k0zFKbySghTl8X9gVjl
         PboygD/gSJf+LPGHYbYj9gMF8XQ7jMCm+6BqdBwWKMQ0BWwRceBsZR2U+8RZQ690twIv
         nahNBn2JPxv3YNV/d8DjlrF6bhxZRW0kdZMYjXY2EQkkaDNHx7+OObrK4vt1FM70n72I
         QVrPvdzrFppfbDsdAeAMpLdpWnO9svr1Yv/RzoyP2DKCuly1jhLUv6mIz3Pn2ieNRiAG
         mQw2PdViSXW9G3PfkBpxJACyzgTgUGg6R4MxswYjFAKXoi318S0CqcD5j9Mu3ORCFNX1
         2ngA==
X-Forwarded-Encrypted: i=1; AJvYcCU+b40GN6uZKXflEAmrkPwF60DxCieQsRYzHWzrk9lSBq1KPaSuz9zQ5JSXaYMkgcB3DFIXt50ycsg3TYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEI57VPBWnRiiWbIxDDRNQdlLXuc5jWXg7+hu53zasEybtEql6
	ckvWV1YyGVbebmjFP90BVas2GQTDaKXgYgGqT0z15cLbdEPL/Uoi9DX9AUYNGUcNFsJj1i8BNw0
	NJSdVvaEodUFo4l1OW+xd1MmEyxQLb5F0bO6Ey3U+J8F0DUP7sA==
X-Google-Smtp-Source: AGHT+IETp+/g0y6U2XpbcP6t4HQIZ/PhZV/J5zf4SqFEuZHZNKc76kVZXpwgJLipoLo4+tdDXiuA+OueSYtg03V886I=
X-Received: by 2002:a05:6102:3052:b0:4a4:7609:35f with SMTP id
 ada2fe7eead31-4a5d6beb2e7mr9296702137.24.1729532891284; Mon, 21 Oct 2024
 10:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020051315.356103-1-yuzhao@google.com> <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com> <ZxaOo59ZwXoCduhG@tiehlicka>
In-Reply-To: <ZxaOo59ZwXoCduhG@tiehlicka>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 21 Oct 2024 11:47:34 -0600
Message-ID: <CAOUHufYwCoVsti9mkZ0eiRDcB50r9RjNPL+f-1cWcuGdTrvBGA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:26=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Mon 21-10-24 11:10:50, Yu Zhao wrote:
> > On Mon, Oct 21, 2024 at 2:13=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Sat 19-10-24 23:13:15, Yu Zhao wrote:
> > > > OOM kills due to vastly overestimated free highatomic reserves were
> > > > observed:
> > > >
> > > >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE)=
, order=3D0 ...
> > > >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB =
high:1068392kB reserved_highatomic:1073152KB ...
> > > >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB =
(ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M=
) 0*2048kB 0*4096kB =3D 1477408kB
> > > >
> > > > The second line above shows that the OOM kill was due to the follow=
ing
> > > > condition:
> > > >
> > > >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784KB <=
 min (410416kB)
> > > >
> > > > And the third line shows there were no free pages in any
> > > > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as typ=
e
> > > > 'H'. Therefore __zone_watermark_unusable_free() overestimated free
> > > > highatomic reserves. IOW, it underestimated the usable free memory =
by
> > > > over 1GB, which resulted in the unnecessary OOM kill.
> > >
> > > Why doesn't unreserve_highatomic_pageblock deal with this situation?
> >
> > The current behavior of unreserve_highatomic_pageblock() seems WAI to
> > me: it unreserves highatomic pageblocks that contain *free* pages so
> > that those pages can become usable to others. There is nothing to
> > unreserve when they have no free pages.
>
> I do not follow. How can you have reserved highatomic pages of that size
> without having page blocks with free memory.

Sorry I might still not get your question: are you saying it's not
possible for 524 pageblocks (reserved_highatomic=3D1073152kB) not to
have free pages? It might be uncommon but I don't think it's
impossible.

> In other words is this an
> accounting problem or reserves problem?

I don't follow here: why does it need to be one of the two?
reserved_highatomic can go up to 1% of the zone, and all reserves can
be used for highatomic allocs, leaving no free pages in
reserved_highatomic.

