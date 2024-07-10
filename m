Return-Path: <linux-kernel+bounces-247162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF69992CC06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C70B2363F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9B83CD2;
	Wed, 10 Jul 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAylkb3G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374383A06
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597086; cv=none; b=bTu8mXjDaplmLPahhp7vE3eWydtN8zxlzRqtqzoGrBEtvdOfENf033kso6v2kMFmdHnzYqBCSNdUY4DGFC8B1lMkqM2LeOrMMML0fZcWNzYiJrAMYdaLpDivPczU9mr64SsMrzHiadgI3R1Mc5wDW19dT703Cld8kJJFBFkU1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597086; c=relaxed/simple;
	bh=ssIlQpvsElw4kkjFJIVNml8CPZUcO7qVdUTTBiDGe3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKvh+EqnAGTAmj1XBX9XQlheUfh/DaGXDMEy5b4gIQAw5TkNe7xzvkjz7fxSbA1+Z/XvtrukKYGf8H4QQdpXDSEYQkZGDscpSIJFYZ+fSQVy6XOcHYbAGsc2zunok9nI0cYVa1uByrcmKcg6PWA4SahJj/qZn4u98e6oPfoY/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAylkb3G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720597084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUJF1q8a+Pk2ObEsjFSECnLgZsn9hN/0SJ1wWWUk6pU=;
	b=UAylkb3Gam9EivKHpVMoij+md5s38SE0xiOB2kb0taToO0NEOYUXj0pO9A5V89oDPrIkEN
	lDv44Ejrq6s4RzWxXFNKUzbMy12110QL3BmBeaRdtVtTaquH05wjvTbzdll9Nzg4l2Vfx1
	2oL6ISdilyMHev6ZjOA+A4iQ/gACb08=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-lz2hYBY5OmuPG5pHz8-bcQ-1; Wed, 10 Jul 2024 03:38:02 -0400
X-MC-Unique: lz2hYBY5OmuPG5pHz8-bcQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c975c0c765so4778997a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720597081; x=1721201881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUJF1q8a+Pk2ObEsjFSECnLgZsn9hN/0SJ1wWWUk6pU=;
        b=CNcL8W5ihL3lkcdxdn2LSZMctISoQE5ixYRi0yh3kCL7L86UBTevY996IS1iMKql5q
         Z3QRNIXVZfD5bpIaOpdnyK62IHwuILHtzYNc+CdOFDfYKNb0XSUjCNuw9yQLTIEpiwKU
         gm9BQKKS7MlsGaZcYQCoMH5hiuQEd/ZY+9WbIT7jlgvDpsnPlARhmlV/FSf1NNPWTRlt
         vingjy3ltoPBJ4IODM5cZ487hHJdZ3IbPOgU8PwTYy1p/WvObpIyFi8etN4DH63avnFO
         TYtbBN1rLyZEd4+8QMKx5/YZf6e9PLpM5EC95ibUIXOTzI0eGZQQP4It6wzlv2cX/H5m
         3gZg==
X-Gm-Message-State: AOJu0Yw3sjsQgT6nkn8ZCLN9EIRc7NYrq7FmA5ePtA9UH8Baa+oCamFc
	vbgcxATKIojzHp6LinwI75tYRaDB/gOcheZEcK8+mWk7br0c/K+1GVuV7Z/JePYxFMrl1z5QVZw
	+bjBhhD0Qk0XQzNaZaWHnk4DKSode/jaHMUnj+RqG/NFWQ78xIQJX37hLCTXKbHnZpSoX1+hQMl
	YgdwO7C7gv05lgryr2Jo/DjiofgUCzmHoW6v+tGEcHgogy
X-Received: by 2002:a17:90a:f989:b0:2c9:63e9:845b with SMTP id 98e67ed59e1d1-2ca35bde686mr4165284a91.9.1720597081397;
        Wed, 10 Jul 2024 00:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb8eXZWVoCyxJTzp6MxyGbXSWGrUHaLhZR91AslE04MRFyNLqJWbX13b87VqvCvK6zJivqfW+wq158Tzxh2Ak=
X-Received: by 2002:a17:90a:f989:b0:2c9:63e9:845b with SMTP id
 98e67ed59e1d1-2ca35bde686mr4165266a91.9.1720597080892; Wed, 10 Jul 2024
 00:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720173841.git.mst@redhat.com> <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
 <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com> <20240710021441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710021441-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 15:37:49 +0800
Message-ID: <CACGkMEv7-si5b9Eq7mEDZHGC2r_6CFudOHj9ge7u3s7a1epNcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 11:23:20AM +0800, Jason Wang wrote:
> > On Fri, Jul 5, 2024 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > QEMU implemented the configuration
> > >         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT
> > > incorrectly: it then uses vq3 for reporting, spec says it is always 4=
.
> > >
> > > This is masked by a corresponding bug in driver:
> > > add a work around as I'm going to try and fix the driver bug.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
> > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_=
balloon.c
> > > index 9a61febbd2f7..7dc3fcd56238 100644
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
> > >
> > >         err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> > >                               callbacks, names, NULL);
> > > -       if (err)
> > > -               return err;
> > > +       if (err) {
> > > +               /*
> > > +                * Try to work around QEMU bug which since 2020 confu=
sed vq numbers
> > > +                * when VIRTIO_BALLOON_F_REPORTING but not
> > > +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> > > +                */
> > > +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REP=
ORTING) &&
> > > +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FR=
EE_PAGE_HINT)) {
> > > +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D "repor=
ting_vq";
> > > +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D ba=
lloon_ack;
> > > +                       err =3D virtio_find_vqs(vb->vdev,
> > > +                                             VIRTIO_BALLOON_VQ_REPOR=
TING, vqs, callbacks, names, NULL);
> > > +               }
> > > +
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > >
> > >         vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
> > >         vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > > --
> > > MST
> > >
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Do we need a spec to say this is something that needs to be considered
> > by the driver?
> >
> > Thanks
>
> I'd say it's a temporary situation that we won't need to bother
> about in several years.

I mean, should a newly-written virtio-balloon driver care about this?
If not, it means it can't work for several Qemu versions.

Thanks

>
> --
> MST
>


