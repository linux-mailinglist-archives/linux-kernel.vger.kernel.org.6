Return-Path: <linux-kernel+bounces-310871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85836968247
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E45E282EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7293156885;
	Mon,  2 Sep 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsOTyZqy"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAAA7D401
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266708; cv=none; b=QUeW+NkiuwiD+9DPMZ4hJIouwUAmrbNTJMJx0jyXT4flrzCY/10FzbKNS4lHsahaD06yiQlWzAT2S1tZ+w4KKDrUXvmleDRJa+Gh7qMEbxrqD3zG9oZGQyeAWYWEg7hBm9WWlY2NdZuDZ1WyshGT2Ok99JgvUcttx9z6xlcRVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266708; c=relaxed/simple;
	bh=gb41VV9Y9wCuWlSBKmdHeI8ghtWnRNrEuF3qCJE3RaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAJK2KSAIo3q78NsRUHrf4JsImlFqe2DT0525K7xnn2VvCadeBASODTmsjQCh5Szr1gHuXoaDctgDqPS5U6sPg8preEboxJgj5I1zXXgvwca5mgro+EhrKytADLBPra74e8e2aZcOGJtmJCVnWvAMocFFXYg0V6ZwZajyLAn90E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsOTyZqy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2119600a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725266706; x=1725871506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdqvCtx4hCTgy7BAxwzQbRHtzAPunqaxxME8+E7kXXY=;
        b=SsOTyZqyH787zNcCGusTSmI7XTccfq7uuFoTpYXX+LGbv/KlgxPOsWOrRFn8KUdI/f
         hsXkFd3fruBTXajvWZq2wgENspcdcOHAhbs7iq8Q/OovYHnwnalFVwXq4vuRM2lz1bzY
         oyaEEJKk8FRhkxJKKsKdvw7G+MA8olShCnQG3LRyDnrYQ+zJXZ0HiCfQovbv3YqHZXyh
         uOYFSOsx7zTrzOH4RXk2AFQO9JJhwOlCgCNiKNODWbsIyb2GicW/XAkCfiseCirCBVe1
         CIOiSYpq/4DJWRGs2n2h9ObRR0NhUXdx/o2fJkBD+p1qNCYkoMpHSvcfPxsXwVmNQUBT
         AvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266706; x=1725871506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdqvCtx4hCTgy7BAxwzQbRHtzAPunqaxxME8+E7kXXY=;
        b=YBgIMBXXIRoGNYCg2odIoGHnTHGlL6tDj2EK/ZPHvhkkP/obMwBikydnunT5oyB2E6
         Mn/8Kkq59FTZTRUUwqmmRd24x17O0vgWlBvNdaA51ecn9fbjKd/plG/fHblFkj3KP1ek
         B5T3xhveuWdew8zVci02vf3B/v+QIY8aDRgBHPC+J3n6+VYKYBbF7UjNikFCiVk8SepO
         DucYXMvRv9q7nL93Idqt21EKrLd4H9SdEP9S+keMfxPWg60mmA0L14iQcgVQbYtvNtvD
         yVfCGQoOGhpnwOq2Ndj67X7J1Y/nt1OEKlDr/deFBgVdQkvgS0AikuAUEE1hOlNSo4Iw
         Zs+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkpUm9Y1CGAf34rzG4nYkrMe/7W33g7R+CERgTosvANOlGl1IexWByT/TzlpSy9V7uVG3VSsSn4ZDbtcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9/XJpk1YU+THNWbY85NtYeXtUWhbzNubrG7D84/UktYZDVaj
	6JkmqAZQ43sL7k7GyPVIr3mpkHIoF907Vd3VnM377LcySKVvU4JLtuSg/Ku9PHco3vY4eqyGfb0
	R75hi3mWTWn6lmziJJI6nM6aZyxk=
X-Google-Smtp-Source: AGHT+IHAI7kM0DcQ1Kk+xb1ziGWteM2SawbzG1IhlHiizIJbRX7VFUfJXcHjFVQg8b+4YnDofi7gqQcXaYryXdNCJIA=
X-Received: by 2002:a05:6a20:e687:b0:1c4:ae14:4e3d with SMTP id
 adf61e73a8af0-1cece4fcfe8mr6562127637.13.1725266705966; Mon, 02 Sep 2024
 01:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830100310.1553675-1-linchengming884@gmail.com>
 <20240830100310.1553675-2-linchengming884@gmail.com> <20240830175504.746fb2ec@xps-13>
In-Reply-To: <20240830175504.746fb2ec@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 2 Sep 2024 16:42:55 +0800
Message-ID: <CAAyq3Sbta_p9WNOTEdCA7V=huPkeFFxUvxTqfzRJz0dsJMJBwg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mtd: spinand: Add support for setting plane select bits
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

I accidentally sent the previous email before it was finished.

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=88=
30=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:55=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi ChengMing,
>
> linchengming884@gmail.com wrote on Fri, 30 Aug 2024 18:03:09 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add two flags for inserting the Plane Select bit into the column
> > address during the write_to_cache and the read_from_cache operation.
> >
> > Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash
>
> This flag has been renamed :)

Thank you for the reminder. I will make the necessary changes.

>
> > that require inserting the Plane Select bit into the column address
> > during the write_to_cache operation.
> >
> > Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> > that require inserting the Plane Select bit into the column address
> > during the read_from_cache operation.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/spi/core.c | 6 ++++++
> >  include/linux/mtd/spinand.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> > index e0b6715e5dfe..e7b592cdbb4c 100644
> > --- a/drivers/mtd/nand/spi/core.c
> > +++ b/drivers/mtd/nand/spi/core.c
> > @@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinan=
d_device *spinand,
> >       else
> >               rdesc =3D spinand->dirmaps[req->pos.plane].rdesc_ecc;
> >
> > +     if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
> > +             column |=3D req->pos.plane << fls(nanddev_page_size(nand)=
);
>
> Isn't there any better way to know what the bit position is?

There are two other methods to determine the bit position:
- column |=3D res->pos.plane << fls(nand->memorg.pagesize)
- column |=3D wdesc->info.offset

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

