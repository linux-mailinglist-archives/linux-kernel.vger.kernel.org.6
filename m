Return-Path: <linux-kernel+bounces-191509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E88D1087
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2329D1F22013
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C113BC04;
	Mon, 27 May 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmtqMoZ8"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0D33C8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716852043; cv=none; b=OUWPsR1Ynwc4GmjtY1u4X7amVUFSk32NtaZbTX+oqKfg7eS0NOIRfhdt6C/XOl3+qTr3GqR8cKVkY9p0o7qjAcmIIz4KPvR83Bew2HiuMjrDjaMhX/UNCFNaRVrSmyWB9KAx7H7rbNGvkaxwHcVPXmdtbnQ5c24sZlqfZVeqn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716852043; c=relaxed/simple;
	bh=2sh/dRvFkPSLs0JF4FxHO2HAo5gWFEJi1sQG1mmGNbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RTOcH1KIkjtv0FHpEglRvewp4+0B/La0CvgA6F1WEyPUu18i4k3cONIuDslhrte7rlgx8xFUJDO7eiKrWkSKtDDbYIyHIEt6fwJpyYDOImqoKDGR6PcO2/qIJMHmsD7x31/h/xtC5FGtPYXhp25lvPjVq5vzx94abd4CiF54s3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmtqMoZ8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so219555a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716852040; x=1717456840; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7v8nyfneetP058M0TF7TFC6gyu5q7DfMf80A5cRq4GY=;
        b=OmtqMoZ8tXI+sAWe/wA8jYTn3yzjR7sz9STdX2lge6DuDSII+dPHEEtEs0Mp4saEZ9
         h48qyie5ACs4MeXqQ+EPwaeBPDJovOhqjU4VCLJUZmKZHr9203f4bex76n4X2p1PnstD
         1fE1GcE7YUNAxHTIYGduuuhNmo09DiG2b+mHzsze7/KWJzj7doPPDcHPuy8U+STZ1H0e
         ScdQtln2x0reAeDUn7EJ7ezFIV8tMbvjTTOeTzjlqtqpc5DV6H+pJhXS1iag+enpeLSC
         xzRhQkLGNMMeUsEj2kcyvg9dMZTCfwX+tm1MOS4HKz0i13RXdOCNS5YsXMfwulJ8WuVn
         EXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716852040; x=1717456840;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v8nyfneetP058M0TF7TFC6gyu5q7DfMf80A5cRq4GY=;
        b=Vz2R8QQ+RxpWGS+CpNbi20T8P3NuxosXx2DqDq5wvez13oxWkg6Ov2xEnLYByFCOnV
         0pTj0bEPBCuVyvVtm3OV8kitOTPCvAhbRygU1t6UY0uxETiX/sFz+qrska5myvG0D5pK
         a/KmrbHsZ8MJV40q32/JZ0RFmYKghR5xa5KjQ/ny2L0tOT1tp7CyvYAWLevYmRaIqrDO
         hNtWOKn2Uq2is0hau78qKr+EsWdJ3mLDVw2CiV4r+ezdneExXDgJI/W0lZjWIgNfn1M7
         NkiGNK/YMpsdM7+lRLSYS49hYoJIwkf3+yaWEMkl0s289H6QTqiwQvkt8TUF/Mf42DhU
         V9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/lPxPJaOx3o2IXBqvGOPEKP43/QyZjuU/C1O1ZUaeig6rHCWxmUF05BjIy/QyNtAuy98DCwTUlfHZDu8bvP62D6/LpZHNKgiCVYiN
X-Gm-Message-State: AOJu0YyladftqD0uKzU9zOe2WkrDLhJC7upFRDsj2xwj5F3PGyVRbfKs
	hsEptKQdId2rNpWljmJ+5MhTPaKa04sUqNfzob/1GrcWFiVYNtE3y7Fre3owZCb7nt8gE69jpWb
	wqqCg9P/VacWDMS81xMZb0SCLz3AF42/bhVE=
X-Google-Smtp-Source: AGHT+IGrRbaj+fNgmNraE/lQCqbggMELagqivzQh//6K8V8qFCHvqTHod/bsN63C4sPeX+s7TwVF75zwFYwaFJeALfA=
X-Received: by 2002:a17:906:491a:b0:a59:c844:beea with SMTP id
 a640c23a62f3a-a626511622emr604826066b.73.1716852039560; Mon, 27 May 2024
 16:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525010223.1704-1-rgbi3307@naver.com> <ojvx3usqalady6zp5cwbqjrvtrhjgym4ai7hagbpjvfkfztsu3@2o6nq3hgiblu>
In-Reply-To: <ojvx3usqalady6zp5cwbqjrvtrhjgym4ai7hagbpjvfkfztsu3@2o6nq3hgiblu>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Tue, 28 May 2024 08:20:27 +0900
Message-ID: <CAHOvCC67kLqZ9Z+ecKNyhz0gSk50N1rn5=twN=Z0p=_0qmGAbA@mail.gmail.com>
Subject: Re: [PATCH] maple_tree: modified return type of mas_wr_store_entry()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, JaeJoon Jung <rgbi3307@gmail.com>, 
	maple-tree@lists.infradead.org, "<linux-mm@kvack.org>" <linux-mm@kvack.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you so much for clarifying and correcting my comments and
sharing it with relevant groups.

On Tue, 28 May 2024 at 00:08, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * JaeJoon Jung <rgbi3307@gmail.com> [240524 21:02]:
> > From: Jung-JaeJoon <rgbi3307@gmail.com>
> >
>
> Thank you for your cleanup patch.
>
> I have added two more mailing lists to the Cc.  Please Cc them on any
> other patches related to the maple tree and mm area.
>
> > Since there is no place to use the return value of the mas_wr_store_entry() function,
> > it is correct to modify it to void.
>
> This comment isn't clear.
>
> Maybe something like (please, modify it to your liking):
> "Since the return value of mas_wr_store_entry() is not used, the return
> type can be changed to void"
>
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > ---
> >  lib/maple_tree.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 2d7d27e6ae3c..da30977aab0f 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
> >   *
> >   * Return: The contents that was stored at the index.
> >   */
> > -static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
> > +static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
> >  {
> >       struct ma_state *mas = wr_mas->mas;
> >
> >       wr_mas->content = mas_start(mas);
> >       if (mas_is_none(mas) || mas_is_ptr(mas)) {
> >               mas_store_root(mas, wr_mas->entry);
> > -             return wr_mas->content;
> > +             return;
> >       }
> >
> >       if (unlikely(!mas_wr_walk(wr_mas))) {
> >               mas_wr_spanning_store(wr_mas);
> > -             return wr_mas->content;
> > +             return;
> >       }
> >
> >       /* At this point, we are at the leaf node that needs to be altered. */
> >       mas_wr_end_piv(wr_mas);
> >       /* New root for a single pointer */
> > -     if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
> > +     if (unlikely(!mas->index && mas->last == ULONG_MAX))
> >               mas_new_root(mas, wr_mas->entry);
> > -             return wr_mas->content;
>
> Please keep this return statement, as you did above, for consistency and
> code clarity.
>
> > -     }
> > -
> > -     mas_wr_modify(wr_mas);
> > -     return wr_mas->content;
> > +        else
> > +             mas_wr_modify(wr_mas);
> >  }
> >
> >  /**
> > --
> > 2.17.1
> >

