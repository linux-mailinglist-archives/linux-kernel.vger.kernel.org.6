Return-Path: <linux-kernel+bounces-435217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20B9E7491
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A45F1884454
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3520C004;
	Fri,  6 Dec 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RvUlJjM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C7153836
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499606; cv=none; b=dQRxX0ZiwwML5yLE80B6b4u978V4hSWIuMGaVkuWoLJmT5jcyE7SXrd7oBFsNvcm1jn9urtTXbjSHxGJVpR+t7Go0lLA0o2ovE59xs07tQt5vV3MGZ9l1aj5/kZU+3abTI6AONBM4Eovv8pBtDI+vd/9NVaorK4yePys3VGYbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499606; c=relaxed/simple;
	bh=jT8ogZeqjK5yNlehTNXOm1ygBvyi7lM6bCCk2we9ZHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioloQCI3GcHI2NH0imVYkpIsBB89vYckeDy3l5LaPaISXEy+vaG9hRmHGbkJOi55Dfs6JybrohcqfKXSYzyXH+KHuLyI5dlYvzqGhjYkMIVVLnkJMizGk/fOCABwkxvRg7rUqW48eWfL05t+fUGi9A8wTvysPMmDgitxpmNl37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RvUlJjM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21561f7d135so99665ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733499604; x=1734104404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naCWMgpan0nrCXMmm7Tdt71tCJVAIhYJMfmvvtiKj/o=;
        b=4RvUlJjMr1p9WR2jITLModdd3yROdwQmD+UG/hGzp8B0f8t2IWPEL0uDDpdQV1POLO
         zoOo5vwO3kPdVOTbiWTmhSWMKvAUol3NltWuUYymb9kkPYlyq3Ij5i+rva6KeE4zmXt6
         4/K0dOuEbPJ/APTlmtc3Eb7s6/lB7gFDpzqpHtiPimqJTFKCYb12+W2F1Af+zOAPXfAh
         /0I9GJ23/aCg2gWJCgnLT7BefYB1yYa9DOsmVekGCZFuKyxQ4UVG+6ZsdsWbIc9pWfVx
         klHyE0ZlfIKwXFqmKyvuVMJjI8iANmOkYjI0fBrzu094EDW8YC9wSsMz0zq8UQ16dPEK
         is5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499604; x=1734104404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naCWMgpan0nrCXMmm7Tdt71tCJVAIhYJMfmvvtiKj/o=;
        b=VJ+luyl03g1voSXoidMuS05hKDp/LfDRafLsQRL08MvR1SUXMckX5lBtA3/fUc4sjX
         duVu3WAmevcUMN+qxERhgNstC2Eo+V1BbhqkaVz4SWpSsqVNOLG3CG7OEC+bpwvJgyeY
         t3RVQyB67b4/FfXll/+31hySOTqC4zOtCtqnkftqE20jiTV6uhLT7adQcVK4RG22fUCx
         BOE5P0iA/pN3zcQuWydXyvxxHXZ6rU2BAXfu41DY/pSollmctDCLJbXsVH9scSjiT7Zw
         1Us+jjoy7BDw41kTj9f7DMgmtyjrTwD/Wb+IQtzE+jDyjX1e7JR+NFV3a52XxENiEWpB
         Y/iw==
X-Forwarded-Encrypted: i=1; AJvYcCUeXIZCCWqk2gLd1aEgpek8ghT99EcMpoxi1rM8nNEAu/ivR7exXu92iS6tt+qvIIeu/RwIp33z/qYnEYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiP1e3jbTHesoNRNC4Ag9wBkqSBT1ZGHHV3vgDUunr1r+gLW4f
	Ogmi+Y1eH5Crbpr1PacuY5Ib/l8q+0er72HCRAwewWs1nSRWPQ9nNRKOpydHaA5OtiOKXugFfGx
	fkTuOLElAfz0wqazS+icjh4sHdu4A9qqzzAD8xcPBGPOM0MLKMQ==
X-Gm-Gg: ASbGncvA3v2Sva07RtYO2XPP3+UkDrphYTN9OyPBG2i+f+FD5xfJXy+YYbg7kCfGmYj
	Bqx7tLEgLHqWrw5AUjgfPe+rZaUFBCQ==
X-Google-Smtp-Source: AGHT+IE+BD5ikEdOAL7gsqN0QEsob2iPIWBRUza/lTLftU4hGbKoYm0b/3gbBD9v7I4I4FlEWSM0E0u/9tVwq+rVBfs=
X-Received: by 2002:a17:903:94b:b0:20c:f87f:b7ef with SMTP id
 d9443c01a7336-21613785b43mr2705515ad.22.1733499603658; Fri, 06 Dec 2024
 07:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206152032.1222067-1-bgeffon@google.com> <20241206152032.1222067-2-bgeffon@google.com>
 <CADMPHGvA+6A+eRG74Xqx5rnLUvq7CFu=p5+YhEfN6oS=S_g6wQ@mail.gmail.com>
In-Reply-To: <CADMPHGvA+6A+eRG74Xqx5rnLUvq7CFu=p5+YhEfN6oS=S_g6wQ@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Fri, 6 Dec 2024 10:39:27 -0500
Message-ID: <CADyq12wamMsWXW3BS0dQfAUBuxXomnBfU4598Kxi7X+TtPqHPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mremap: Fix new_addr being used as a hint with MREMAP_DONTUNMAP
To: Marco Vanotti <mvanotti@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:35=E2=80=AFAM Marco Vanotti <mvanotti@google.com>=
 wrote:
>
> On Fri, Dec 6, 2024 at 12:20=E2=80=AFPM Brian Geffon <bgeffon@google.com>=
 wrote:
> >
> > Two non-mutually exclusive paths can land in mremap_to, MREMAP_FIXED
> > and MREMAP_DONTUNMAP which are called from mremap(). In the case of
> > MREMAP_FIXED we must validate the new_addr to ensure that the new
> > address is valid. In the case of MREMAP_DONTUNMAP without MREMAP_FIXED
> > a new address is specified as a hint, just like it would be in the
> > case of mmap. In this second case we don't need to perform any checks
> > because get_unmapped_area() will align new_addr, just like it would in
> > the case of mmap.
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > Reported-by: Marco Vanotti <mvanotti@google.com>
> > ---
> >  mm/mremap.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 60473413836b..286ffdb883df 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -912,15 +912,27 @@ static unsigned long mremap_to(unsigned long addr=
, unsigned long old_len,
> >         unsigned long ret;
> >         unsigned long map_flags =3D 0;
> >
> > -       if (offset_in_page(new_addr))
> > -               return -EINVAL;
> > +       /*
> > +        * Two non-mutually exclusive paths can land in mremap_to, MREM=
AP_FIXED
> > +        * and MREMAP_DONTUNMAP which are called from mremap(). In the =
case of
> > +        * MREMAP_FIXED we must validate the new_addr to ensure that th=
e new
> > +        * address is valid. In the case of MREMAP_DONTUNMAP without MR=
EMAP_FIXED
> > +        * a new address is specified as a hint, just like it would be =
in the
> > +        * case of mmap. In this second case we don't need to perform a=
ny checks
> > +        * because get_unmapped_area() will align new_addr, just like i=
t would in
> > +        * the case of mmap.
> > +        */
> A few lines below we also check for MREMAP_FIXED before calling
> do_unmap, can't we do the validation there?

I don't have a strong preference either way. I can mail a v2 with this
suggestion.

> > +       if (flags & MREMAP_FIXED) {
> > +               if (offset_in_page(new_addr))
> > +                       return -EINVAL;
> >
> > -       if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> > -               return -EINVAL;
> > +               if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_l=
en)
> > +                       return -EINVAL;
> >
> > -       /* Ensure the old/new locations do not overlap */
> > -       if (addr + old_len > new_addr && new_addr + new_len > addr)
> > -               return -EINVAL;
> > +               /* Ensure the old/new locations do not overlap */
> > +               if (addr + old_len > new_addr && new_addr + new_len > a=
ddr)
> > +                       return -EINVAL;
> > +       }
> >
> >         /*
> >          * move_vma() need us to stay 4 maps below the threshold, other=
wise
> > --
> > 2.47.0.338.g60cca15819-goog
> >

