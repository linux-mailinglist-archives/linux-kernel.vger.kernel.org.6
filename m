Return-Path: <linux-kernel+bounces-235942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8E91DB91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62EAB21A84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1E82D93;
	Mon,  1 Jul 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnlT4yJ3"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8E6EB5B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826558; cv=none; b=L1KPrHvtl8enCCSsy//nhFHEEUljX4Kb51X86/cQoqznuddhmsopUrFTPZHOM0ssGEt4vcT6vc1NJf5LwxMK3LpV0OGyEdPTH8sOBMP1eC3GwY9SzA4J2zy/EA8aRixpvxu1Gw9c2clKTysTFTKpG+Cw3i/dE9xJUEDKgSmznpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826558; c=relaxed/simple;
	bh=tVvM8ABMVMKlIf3mM7n6da76RHUGU08/lSo66hrPo7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX8fe854VHRhAjzz5kA/sL/RJ/OlZBQVqVIMrvYw3Srmv2iKB8VjEzDyrwZFo4dVSMdKM+I7zNexQMUtnwsTxwE2AOrDBpIqeIDqxH4rI+narytoJudr/+suybpEblQtquQxH2Op+KmgFpCAQqIy9z0SU/Cyt/g21Hsop1ptdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnlT4yJ3; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ef56bdc3fcso1300065e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719826556; x=1720431356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSUOWCJo2wOKRUZ2PTRrAMpOyQfEQtWBInes4peI6eQ=;
        b=JnlT4yJ3hUdIB4ymZjcmHeLpJmCEpDCEt+ryrvoP5iVumMZckgrQxY/ECiFB5udd+i
         htFT/bXS7d7EIJwJ6yy3WmL/lI/ZwolcJVDUltGF1T6yRLZbwIx78dbD0YGiDvUJtDI2
         vGma+7JrfReFvZXAxc9bFIVTOCyUh81zNUE2G8a4IME4FSmzy+tRej6zFaqWsHE3X+wV
         vuHKcpot/cP9uyGI83OzYp5ifDhqOLp3MzBDuADK8w1KWkjG7E0VEFUX0odvGkAsHdtr
         jAJyc0C/+gW3IYURqMUAciKyS2GGnOLFKSyrdlCn4XhCPosXdpR9wLiFyDqtZPF9A1nr
         rO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826556; x=1720431356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSUOWCJo2wOKRUZ2PTRrAMpOyQfEQtWBInes4peI6eQ=;
        b=lFYMi6eUJiBSQSGlXhA7LyASnNK7p+Kz2cn2xaFm7PFqukmFGwtRJekPPu4kWzbYUY
         kURAbvxZBPzcoKKVPz+EVjP6wXDFgLNuziZkAQziKSSUfzMaVkGxfJDEfcgjsPmT7Lvb
         IlKWwIK/CTltnUTR5F3Li6TCbJSvTTR/D02rtfzqyfYFiMwq1OBpxthVmVssIk9LG3WO
         s/0VxLTu2og3HBxbzTmMac5QRatphFEGtiz+22XhyHaAgBDB+pUriLucyk38lD7eOMUH
         DncDkP/3mIFJREmaga1AczUd3ktsq4/uiLiKkhwGmWnXj44CPOUelx6jN6XtDZKg4VRK
         RPgA==
X-Forwarded-Encrypted: i=1; AJvYcCVQykVvlRCZfBlcBodb523EDJlEXsB0QHLYw8A7q8eH4tLLv5WkJhv6RWxSFgB1tTvxmzi0FtR20cTXaeEabouuK4+HnZNFtLu6oN3r
X-Gm-Message-State: AOJu0Yw/pG4JfiPrTrhcATfjlsXoQLdgHC08gQCM7mK+Kdq/QjPNpvMf
	m3l6Kxd+/wpMpTz1+8wq425MMOLzWHuEvOseUs8ZsRwZr9VNiEZhG2WIQEWuBugQEKNDZsBMZMV
	98tN/NaOuyi2ANRNCdp6IQ9tnWwLuCFoA
X-Google-Smtp-Source: AGHT+IF8FD5RE6recsa0PMT5qKPJrkH2JQiad7QESmZpBarzYZLG3dHfhHu5YieodPW/N+CbkKJ7lY7KHy9FJkr3H6Q=
X-Received: by 2002:a05:6122:d28:b0:4ed:682:7496 with SMTP id
 71dfb90a1353d-4f2a5705bc3mr7133420e0c.12.1719826554575; Mon, 01 Jul 2024
 02:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629234155.53524-1-21cnbao@gmail.com> <bfdf6970-48cc-477a-b726-5e0da242da93@arm.com>
In-Reply-To: <bfdf6970-48cc-477a-b726-5e0da242da93@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 1 Jul 2024 21:35:41 +1200
Message-ID: <CAGsJ_4y9yjFgccoja63Yw=SOv96d2+8sc4_9s7xfJ8mHh2BkOg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: drop checking if _deferred_list is empty
 before using TTU_SYNC
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:48=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 30/06/2024 00:41, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The optimization of list_empty(&folio->_deferred_list) aimed to prevent
> > increasing the PTL duration when a large folio is partially unmapped,
> > for example, from subpage 0 to subpage (nr - 2).
> >
> > But Ryan's commit 5ed890ce5147 ("mm: vmscan: avoid split during
> > shrink_folio_list()") actually splits this kind of large folios. This
> > makes the "optimization" useless.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>
> > ---
> >  -v1
> >  * I remember David and Ryan once suggested that this check could be dr=
opped
> >    while the patch was being pulled into mm-unstable. However, for some=
 reason,
> >    I forgot to request squashing this change.
> >
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 3d4c681c6d40..0761f91b407f 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1291,7 +1291,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >                        * try_to_unmap acquire PTL from the first PTE,
> >                        * eliminating the influence of temporary PTE val=
ues.
> >                        */
> > -                     if (folio_test_large(folio) && list_empty(&folio-=
>_deferred_list))
> > +                     if (folio_test_large(folio))
>
> As it stands, the list_empty() technically needs a data_race() annotation=
. I
> think your original patch went into v6.10-rc1? If so, perhaps it makes se=
nse to
> try to get this into the next rc?

Either way is fine. Hi Andrew, if you include it for the next RC, could you
please add this tag?

Fixes: 73bc32875ee9 ("mm: hold PTL from the first PTE while reclaiming
a large folio")

And an additional changelog:

Additionally, the list_empty() technically requires a data_race() annotatio=
n.

>
> >                               flags |=3D TTU_SYNC;
> >
> >                       try_to_unmap(folio, flags);
>

Thanks
Barry

