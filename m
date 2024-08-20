Return-Path: <linux-kernel+bounces-294599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD7958FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C495B216A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DF18B478;
	Tue, 20 Aug 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQAx9DoR"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB518E377
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190390; cv=none; b=LdroBuuXb2WTKF5r4GQFtdZZbdmckqZYMw5xiAS/OpGUfy9bGBsbfsq2uylnZYoj+GzNAGiLFuGftko7mIml2ldbBCBalZQCsXZOFc/Utukkz2p1Q94PC3SK0TjndPqOZcoAQKjmvh34sVY1aDpCGlmh30uJvG0/OVw3ldYrxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190390; c=relaxed/simple;
	bh=oERP+612B9MESUpwFC2xgLQm8dXRH1ACHkct3PiM9K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxMt5NC4AXt03jruU1PsVf96V6Xy++nhvc4WCOCC1IoiXQLf7c9gU+ORJvtNkiXC4HrjQXqtc/zDKTiO/rObnSNbFlFKde0rX9GoaYlmsYAQuqjwwzo/H+G0sulsGOnbn43f57yme36QIhvA8yydB66GODzKEQ5AxcJU3jfbxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQAx9DoR; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f8dbdbba98so90480e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724190388; x=1724795188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYiBf1vm/fzG+eRd8lpaessq+xOvrwp8tbUt3OoA+0A=;
        b=kQAx9DoReEiGnLZxBmtBo4/X3X6qlkhWoCiHHLu7AMVpfcFIhx0G8tT4FcTtJR6Llu
         yhkfCbYdPk5d2U+UDeQzRFJI+8ePcBnN8EUICEGmiJ4eGKnAMMKETroO7VJGPWowaLvy
         oasCnDvU+nnDZkm21uIPrL8GLi0KbgH0p1i2cIa5l/fAobvRxpbgjTgBEvrYwdA6I7L2
         XCOv66CMeG4V1CRPBVb2loQVDi42dbNR32VipCPzQ3WkFYgdfdTjgKpLnKlDQys3IUEC
         6/3wgptUO7ScEjR5UI2YAbRgyJvdGasFgq6sIEDcC51lpJrbZnGHHyZ+zkQ+CmDBKk0Z
         ff2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724190388; x=1724795188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYiBf1vm/fzG+eRd8lpaessq+xOvrwp8tbUt3OoA+0A=;
        b=QV1R0qtdEUSeqOeuxmSMhufwAYcVUZRV0OWrVwjqNlgF09fdc41quryWXkyjTnmoiG
         fOgNliHeGIk6s7tPJhJ1Rt3DrFSm9tpa3FegEth16cTfptO4ObGADWF8kzqNV+Bj/Rpq
         R2TU2nUX+C0OuQJjEHmmX5TJVWA407+aMh2akaZ2dfXEmgMv2v3BcrfvjCBz17q2L4tI
         R4iHtnzPsWtDybyF504GLUb8+1hyvwxCcf30HvroJqaYaQ4vfYcStqctDCXqYuVmovcj
         +Hu0U7FR0Toe7H3pXeXX8V3FDuY/6NuPKyfwekUEgyVb/Q9jbW9skHaWsjnDNpQBdZ7R
         FPAA==
X-Forwarded-Encrypted: i=1; AJvYcCUvMO2mne5lrLFSjGRYIeKFGRhHBPXSTLY9sPtaWVpPIm7pXsXm3uDadjXNSOQb4xQs5FzYZbJ1QvMW0Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgXY6T6DgZm3rqVM/Z+X2Yh2DxN0ud4naMLj/KvMX+IW8YDOp
	G8n9w9rKb+WroYNd73AAj+roSSXQNCFN92kHwbUVMIxzGxp7HkIwMpqxClmzHVOUCyF7cinu6Jq
	c/Q0dhFz9zxGl3t/hgVXmGbV9lmo=
X-Google-Smtp-Source: AGHT+IFL869/hbuGBllNon9+ZE6lVsV0t9wZrGUg8Zksu1quTXl91B0mKh1C2FgjQTTiijQtut+HB9iLBUd1liHZzME=
X-Received: by 2002:ac5:cb0f:0:b0:4fc:ba44:6ad6 with SMTP id
 71dfb90a1353d-4fcf3a105b4mr210623e0c.0.1724190387921; Tue, 20 Aug 2024
 14:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <CAGsJ_4xTW5y4O6BoVuXKk=awhoiZV0zitPYYbfsX1pmqZgY9WQ@mail.gmail.com>
 <974d9d6c3b5e4848a32b930732366084@honor.com>
In-Reply-To: <974d9d6c3b5e4848a32b930732366084@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Aug 2024 09:46:15 +1200
Message-ID: <CAGsJ_4yJ8EB3ci=0c1JcshF1Gk16=NSfpMLVgPObMJUFtHcK7g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Shaohua Li <shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 11:54=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> >
> > On Fri, Aug 16, 2024 at 7:48=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
> > >
> > > Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfr=
ee_fn:
> > > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it'=
s
> > >    moved to the LRU tail, it allows for faster release lazy-free foli=
o and
> > >    reduces the impact on file refault.
> > > 2. When mglru is enabled, the lazy-free folio is reclaimabled and sho=
uld be
> > >    added using lru_gen_add_folio(lruvec, folio, true) instead of
> > >    lru_gen_add_folio(lruvec, folio, false) for adding to gen.
> > >
> > > With the change in place, workingset_refault_file is reduced by 33% i=
n
> > > the continuous startup testing of the applications in the Android sys=
tem.
> > >
> >
> > Hi Gao,
> >
> > Just curious, in which scenario are we frequently calling MADV_FREE but=
 not
> > MADV_DONTNEED?
> Hi Song,
>  Android ART use MADV_FREE, please refer to the following link.
>  https://android-review.googlesource.com/c/platform/art/+/2633132

thanks! It seems like the art guys owe us some changelogs, with
no data and no reason =EF=BC=9A-=EF=BC=89

Your change seems reasonable to me. Since users plan to free those
anon folios, we should avoid placing them in hard-to-reclaim areas,
which could lead to unnecessarily reclaiming file folios instead.

> >
> > > Signed-off-by: gao xu <gaoxu2@hihonor.com>
> > > ---
> > > V1 -> V2: Based on the latest mm-unstable, recreate the patch.
> > >
> > >  mm/swap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index 6b838986d..e0dbfc983 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -641,7 +641,7 @@ static void lru_lazyfree(struct lruvec *lruvec, s=
truct
> > folio *folio)
> > >          * anonymous folios
> > >          */
> > >         folio_clear_swapbacked(folio);
> > > -       lruvec_add_folio(lruvec, folio);
> > > +       lruvec_add_folio_tail(lruvec, folio);
> > >
> > >         __count_vm_events(PGLAZYFREE, nr_pages);
> > >         __count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
> > > nr_pages);
> > > --
> > > 2.17.1

Thanks
Barry

