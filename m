Return-Path: <linux-kernel+bounces-370403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA59A2BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415F81C26198
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03801DEFF3;
	Thu, 17 Oct 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaXEwsg4"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB71E04BA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188938; cv=none; b=uylo9sC+FK6+Jl92Hgo8LBjGFuNZs/QHA+i5FuUb/laW20rZhCNfWjV/3izxelb0SJHwmFo6Pfe4mdjXM/ax0n9pudcwRIrrQ54Ip2dGAzI3VloplxzIDsJy0Bs4EVZ6kCQc24+g133Onm/2b7L3FLQ7njG6S0JpORxnc65rQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188938; c=relaxed/simple;
	bh=uTLIkRoeUhrkpCkiTBl8MeGvB3CFrmvZD/nnKemVEls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kVyXCldY/oThIrB9s6sdP3/lT5tmk1eQbPU9z6NA6SbMfgt6rKhdEr1B54kPdT2ivdzIPyLSPLo4ukvFdOP0hPTVmwpd/k4J2Ms/fa88ET5iPDYN4Qa4N4+1WGpMWQwgEOvLhET6kfqTaunDMaHlX6oIKFNLXHu85+IpdJ+z4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PaXEwsg4; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2888bcc0f15so155719fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729188932; x=1729793732; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHjzV8GIFWQi9KufRK9CoYHfQ8GleMG3rIylN1btqcA=;
        b=PaXEwsg4RrNo/ID5k2lexnhMt1iqtAdYYfdeciUcHaC4JbgvvvUu9vMi6vLKmAofCf
         kdS2zD3TxwSjlxH8wnJjhm3+dSc7C4n6Mpqn8wR6+kow75u6ObnbKb8nLCpwOYxeqP51
         3NcEsWmPW/jUfRNjLf6ar3NaAgEn4Liamlnq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188932; x=1729793732;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHjzV8GIFWQi9KufRK9CoYHfQ8GleMG3rIylN1btqcA=;
        b=pB2i8AV5oboMNjP6phetKaZFC5mSiBJz4jXe7OQ1H0YP46NcvJY3fSRsbWmYI0UxSg
         rqHkHKmo1VM6ZNXsMhMz83VBPjg081qEmcVGA6lXWCEXFUuEQaCXdf6p3va98ZJ18nEP
         s1mN4fPqt6sF6n+8MaehExkIXdTWTqYgRMdDKidhSEiO0/YUzptcBOoGGSfM8DiITpLi
         4TTi59bR1x1zkM3mGtpeUzsiNDncaLNIp428dSPoP3WgaVFambCVFNyNy/2uDL10frlL
         QYFwxvQd2APo/Q8uhIBbtKtjV3SR8ztjK2MKlPMkTu88PfB/v7xktvqf2MWz43dtRdO3
         0m/A==
X-Forwarded-Encrypted: i=1; AJvYcCXzdGa+O26lZ4a5LRSW3LRHGIcYUY1ddb2bHBhqBhv5If/bTAXHwIVSQZQe4hSuEF2ysoAU91UmKCGtgUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKti0eB71AVrWugqHf6mnsfI35GcGTji+RVaQ2zfDfQCeoxFGc
	KeBfYSJjUSZf/koOcxov7PAxw97Ll26PBrkcxVC3IoIrsP9NTw03nxIeElTeu2ke/E4PxGc106p
	syGqIaFX6uqDyjP0VHniWKcCKvU8kTtT5Gt6o
X-Google-Smtp-Source: AGHT+IHWoSRydBwpFfvzHOj+pEJcPJy3O5dGMCE675ZY1tgLOWLdb19FSg2ahEsrWnglBoA4ppbBK8AjpwmRUGi7x1I=
X-Received: by 2002:a05:6870:5253:b0:27b:9f8b:277c with SMTP id
 586e51a60fabf-2890c7efecbmr1150009fac.11.1729188932453; Thu, 17 Oct 2024
 11:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
 <20241016201719.2449143-2-Liam.Howlett@oracle.com> <CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
 <4izjonpaqhkx6p3csfyxcjicgqahbmj2k6gupazehb3l7xhnvi@twlvpx2wc6ce>
In-Reply-To: <4izjonpaqhkx6p3csfyxcjicgqahbmj2k6gupazehb3l7xhnvi@twlvpx2wc6ce>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 11:15:20 -0700
Message-ID: <CABi2SkW1Au3WZ6Qem=FppOFBGRn3GDJo5+U3yXpk2brK9MR8NQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:07=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [241017 13:55]:
> > On Wed, Oct 16, 2024 at 1:17=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > vma_to_resize() is used in two locations to find and validate the vma
> > > for the mremap location.  One of the two locations already has the vm=
a,
> > > which is then re-found to validate the same vma.
> > >
> > > This code can be simplified by moving the vma_lookup() from
> > > vma_to_resize() to mremap_to() and changing the return type to an int
> > > error.
> > >
> > > Since the function now just validates the vma, the function is rename=
d
> > > to mremap_vma_check() to better reflect what it is doing.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/mremap.c | 39 +++++++++++++++++++--------------------
> > >  1 file changed, 19 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 5917feafe8cc..648c29f568af 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -826,17 +826,12 @@ static unsigned long move_vma(struct vm_area_st=
ruct *vma,
> > >         return new_addr;
> > >  }
> > >
> > > -static struct vm_area_struct *vma_to_resize(unsigned long addr,
> > > +static int mremap_vma_check(struct vm_area_struct *vma, unsigned lon=
g addr,
> > The original function is vma_to_resize, and mremap_vma_check is
> > missing this context.
> > Maybe mremap_vma_check_resize is a better name ?
>
> Good point.  That suggestion is long though.  Perhaps
> vma_check_resize(), since this is a static function in the mremap.c
> file, it is fine to drop mremap from the name.
>
I'm ok with that.

> ...
>
> Thanks,
> Liam

