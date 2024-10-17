Return-Path: <linux-kernel+bounces-370417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24199A2C13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA028173D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6EC1DEFF1;
	Thu, 17 Oct 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9wcLkJd"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AF184D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189322; cv=none; b=BW6Vcflky/RIAEPohGnz2dUcCOct+1Dldp1s/sfQQZyfD752ZMRP2vZ6q5PUT0/mYdfZ2sOnNyaFO/rFE9E5uXecfXCvHP9ecpYnvnuo27d34oU/1tEfcoY3O/0w08OPwxPPPyPpmikxoyovmYFyNqPYKUdaoFi54rS3jV3Vi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189322; c=relaxed/simple;
	bh=RPqBl/e5kWqnuhA97vgRQ/te+jB+nHObSIWu953FoEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAmb9m5xdC3iYroulntrrnuxEqP5dTORscZ38osiLxGNYoXqHNJDVvMiUnUCGTvW9qRbxx0a0tTnwiNkUVR+PH6OfLBcS3VEj0MPY7MtDQy1Z57+WiBtMdl5Nk9NSvi9yy/PiSAd4c9/elBuMUdkDGX5lmTZng1/F3idHwpSOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9wcLkJd; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e4d5aef2f8so748371b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729189317; x=1729794117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vNuwIkZe438Kvv9BoDJdtP4Yx5fJLEE4DgPHUXL9Wg=;
        b=Q9wcLkJd3weMnatwvhLROZAToggeqNrpMCwuFigGmRLRcGcQxZwQP4AAbW8+4ZTGxN
         Q+BRrLscGI8PJkl3y8+DxEBP+lW8g387nZn0NE6sjGT6M/n+TNbkQBPqwDhdwOs7JMJM
         2cMq/omEaytoLdL8+cirPwnKdWxIiTqv1mHJRhquXVejl7TD6F4gDjqexkeNvGuVlS6w
         Lk+tf3RAS+b9SszAdxE00TH53LuXVaK43lob+roOflum73kiu+ddIjd5ephjDJRS5076
         CDgjIuZHVBhw5oVgYL6UTsri1vRDXCfmLg+fdMCn2CLRBDtoE17T3ubG8azz2fAA/2Xm
         wdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729189317; x=1729794117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vNuwIkZe438Kvv9BoDJdtP4Yx5fJLEE4DgPHUXL9Wg=;
        b=HWJQgZrxWyIETixyj98OcuuhHWOmv8Xj2SXRHYkvnT8PQP6qnpBw9f9e/M4AjAbIMa
         3YL5oMZbDf5Z+okKztEpZeZttbpni8tYKiMfj9nPYxki1BWKE1n72JNjXKZMPYj+/evx
         qwaWcNOkdOQDOE3ng/4NjGLrklXgciQw9XXOhEGiDBzIuvhOqUtZJdI6iqTBKmg7s6oy
         c6hBJojkpYZF9BrO/8A7wt+3JhpLut0mMNm6LFGlWfM1dOyQp9Couq0Yf2vQCrApMQDe
         QeDAtFEH+1gzfJR22wzcGaC/jfwV4WL+o7uQ42hF3Z2TlT44pWkcGbcpVXgNISwRzMKs
         tqFw==
X-Forwarded-Encrypted: i=1; AJvYcCXU47oa21/U4sy9w+bcNRZjtheVuoYwfpHF0YSkC7/XRZqnkRSnha5DX1av9secnutHno1NLBSswbEBH+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qoQep46iXjru/q0ZSEZj39lPLzEUoU0ploYry9xw6cki9cFc
	b80EsLRg1RCmCJZ1E3eR76hTjgBMMW0AouTnncGk8NbuE5z5g1b4UnYVDpXUe6hK5bN57djoO0X
	q2W5jvuQh2iAqI5Dmwt3BWKLIBUNpH64pNPRr
X-Google-Smtp-Source: AGHT+IHM6SgvakHOzfMHe+tK8akdryo1YChetAtJK61+k9hGwygT6I8t9ITw0MGJ7Ss0gI7UGwKq/hQASSlBC+NDQfM=
X-Received: by 2002:a05:6808:3198:b0:3e6:92:ea86 with SMTP id
 5614622812f47-3e60092efc6mr1054575b6e.20.1729189316559; Thu, 17 Oct 2024
 11:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014221231.832959-1-weixugc@google.com> <CAOUHufb2nJ4-qEWrS_d0X_8FbLKR-+=OC3yNh1ExthKXiYYKHQ@mail.gmail.com>
 <20241016155550.9ff2ab4625c7f19b6be8b7e1@linux-foundation.org>
In-Reply-To: <20241016155550.9ff2ab4625c7f19b6be8b7e1@linux-foundation.org>
From: Wei Xu <weixugc@google.com>
Date: Thu, 17 Oct 2024 11:21:43 -0700
Message-ID: <CAAPL-u_bzGmB3DkTKZqeCbtiPkuZVsmLFMbN+zCojWsYtkBUNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/mglru: reset page lru tier bits when activating
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>, 
	Jan Alexander Steffens <heftig@archlinux.org>, Suleiman Souhlal <suleiman@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 3:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 15 Oct 2024 22:55:23 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > @@ -257,7 +258,9 @@ static inline bool lru_gen_add_folio(struct lruve=
c *lruvec, struct folio *folio,
> > >         gen =3D lru_gen_from_seq(seq);
> > >         flags =3D (gen + 1UL) << LRU_GEN_PGOFF;
> > >         /* see the comment on MIN_NR_GENS about PG_active */
> > > -       set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), f=
lags);
> > > +       mask =3D LRU_GEN_MASK | BIT(PG_active);
> > > +       mask |=3D folio_test_active(folio) ? (LRU_REFS_MASK | LRU_REF=
S_FLAGS) : 0;
> >
> > We shouldn't clear PG_workingset here because it can affect PSI
> > accounting, if the activation is due to workingset refault.
> >

Good point. I have addressed this in the v2 patch.

> > Also, nit:
> >   mask =3D LRU_GEN_MASK;
> >   if (folio_test_active(folio))
> >     mask |=3D LRU_REFS_MASK | BIT(PG_active) | BIT(PG_referenced);
> >
>
> Thanks, I'll drop this version of this patch.
>
> When resending, please include a full description of the userspace-visibl=
e
> effects of the original flaw, thanks.

I have sent out a v2 patch, which includes a description as suggested.

