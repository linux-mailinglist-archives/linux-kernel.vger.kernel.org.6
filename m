Return-Path: <linux-kernel+bounces-315320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3096C104
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE82282A83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9ED1DC184;
	Wed,  4 Sep 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAla73Ki"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058E1DAC5D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461057; cv=none; b=Bq6wOJUJl2bSoU3cryettAa3QK6mncwuyAgNTNAZBKHva6vv07wl//V3rClOVx24ORPSYhAAS7zQneHMqwnlHnOmIrWq62rrwH5vSJgdGQCYN74bHYj52fWnWTjwD3U4/3Ev9Vyv4oh4JHbITFvZSyUNPVrkzm7JSngKLidqIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461057; c=relaxed/simple;
	bh=bJ6XCjvHeZ63bM71cj6QQNZOC5zRXwsk78sclLYNbFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkq3FA/Iw/AgIdg9LkX9wjlpMcE5OWQbbZ06LdJ3pgFtB3902ZJh5xqUs256LZAPVQ+hKGm4L2T9wiEz4oA/2uyuafY1CL3T4bgi0rmVqzVHTeFTymPcrVDrSRBLJVUAnvy+H3g89g0UFIY/BY35DqF2lLLDGAt2tTR99TDerZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAla73Ki; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277fa3de06fso1694413fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725461055; x=1726065855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdpmfiLx4+9GGPxwJuciL+EJAWZcsVrIVB432BnBKdU=;
        b=WAla73Kil5yqmUjmihtvgYEukkL7FhRMdLWgPaaOARURbMnGN+wkoSFOycsnuSAOc7
         WiqT/TqP/Yrb5/4FhjH/S71oOWvjy1fjydUiFwP243s2Oblgn2ElE74PRFj+wfOi6BYO
         kdCsndE/H2t/YO3aIIupcscDhpNwAKPiJCQt1+dmRJo3u+jDGaU8whpP673HnGP0nidR
         gtJs4SwDV7cClcpDHipas/tzWc1sn9R1oLW5sRYZS0QkKX9o7/UGNydEsLRWaIdreCqf
         99H+oMuou1eOs9sryNVJyLKKU+IrIyUdOdKv0/O6nIUZJu0eBFc95ML6iskRzfFG/qYS
         Jidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461055; x=1726065855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdpmfiLx4+9GGPxwJuciL+EJAWZcsVrIVB432BnBKdU=;
        b=Tgfo18IR3KkL1viwSaEE72GgetCjJl1JZ1g1THfx6cHogglEmrasebZkXjZmUZUooj
         Gxhs7vT3TS4VLVyPj6+ksIa/6oxH0v/JcmllfGt40cb/DaClSKyuPaY3e11LqB8UMSvQ
         sF7ml4aRzSRgoJWgUeUk/1H/EdIaLWJFXK6B27TqwhgR2cvdU7U1nPDsy1bd3cjR7H2z
         O29d/ihIhqC4XnLBtEoqUdvgJfa1XdDDXC/ZsdMxc54Pmzqfv7rehG4cUTRx7iFi4Irj
         DyJ/DL8cqQTW6N5XDdZJBK/fDTRvVV/MH6AfgoLFzXaRjP6GhKlD8P2xpRJB3Z+9JKiT
         arug==
X-Gm-Message-State: AOJu0YwvF1sWaK1aS21sTRtznhYZajIgqQL1YrFCTjmeqE4hDiCs2OVj
	nj0mOJ9zmijkzTZ3d4JSfCQzI7sz6e1nemp1q7AzJWSHYZ29wx4p19q3witYBpjofiqdYgNgDZX
	doVc9GDDHdKKfcfvw/LFApmx03ipfpGM/
X-Google-Smtp-Source: AGHT+IE/9AMP6bqtRFFMYiCEsn1ihogTuhUyYbZgblSm0eDNypUktZrclSZlCa+1/a6gOsqjXO8loI8FPA8aHk3W+sw=
X-Received: by 2002:a05:6870:c081:b0:277:e2fb:4035 with SMTP id
 586e51a60fabf-27810c13b6amr8597162fac.27.1725461055329; Wed, 04 Sep 2024
 07:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201608.1840977-1-robh@kernel.org> <CAL_JsqLzpDC42G35TDjgQpDCJhmy6_oQxG97uut9VKdYCHi_NQ@mail.gmail.com>
 <CABb+yY1W53SJ1r1yspQpaBjMH+JPC89yBM7G9+WoewSJgjD+Mw@mail.gmail.com> <CAL_JsqJFT1y6+LkVUOYhGqTN=1jYescxTbSFGLfu8zrO2ijLSg@mail.gmail.com>
In-Reply-To: <CAL_JsqJFT1y6+LkVUOYhGqTN=1jYescxTbSFGLfu8zrO2ijLSg@mail.gmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 4 Sep 2024 09:44:03 -0500
Message-ID: <CABb+yY2MjYkVCpYjVXCxiNDizCoOCf42p7w0=B4W=EapJ++CvQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_match_string() instead of open-coding
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:20=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 3, 2024 at 4:05=E2=80=AFPM Jassi Brar <jassisinghbrar@gmail.c=
om> wrote:
> >
> > On Tue, Sep 3, 2024 at 2:18=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > On Wed, Jul 31, 2024 at 3:16=E2=80=AFPM Rob Herring (Arm) <robh@kerne=
l.org> wrote:
> > > >
> > > > Use of_property_match_string() instead of open-coding the search. W=
ith
> > > > this, of_get_property() can be removed as there is no need to check=
 for
> > > > "mbox-names" presence first.
> > > >
> > > > This is part of a larger effort to remove callers of of_get_propert=
y()
> > > > and similar functions. of_get_property() leaks the DT property data
> > > > pointer which is a problem for dynamically allocated nodes which ma=
y
> > > > be freed.
> > > >
> > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > ---
> > > >  drivers/mailbox/mailbox.c | 22 ++++++----------------
> > > >  1 file changed, 6 insertions(+), 16 deletions(-)
> > >
> > > Ping!
> > >
> > Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
>
> Don't need an ack, are you going to apply?
>
Yes I was and will be if you won't.

-Jassi

