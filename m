Return-Path: <linux-kernel+bounces-247527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F5292D0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA6C1C22118
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA0719048B;
	Wed, 10 Jul 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyG8bhfy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44A190473
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611375; cv=none; b=SHsWJKJmkSMB3PXVTm1BBQ5gX5iVxGcuSj1Y6rXJrZd8ZYNaE8SLe58LSzE8pKQaSlOqIyExy+h9iy9EPK17aaV+f6IOGiREx8cu7RqZOV1uSlHJkd9IwiM1I0H4BLJVvLaNVDz+l66Zlwkz2YY+NvsP7gTPq9YThMR2VX0fMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611375; c=relaxed/simple;
	bh=X8uDFXcnEE5RI3vslZAxqO3xUCnLxKmC6eeolodP1ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nby936BiAxBiq2/tBbTF6JWdy/W9fyBh5fzHPjWr32Bjxa+OeOajV7SCZwwR8+hKyRhNbxmnDRt/NBDnqKu2WEHdEkqx8qWqDCXrTwKUU6eeZQ6OQGrheLk4bv0UZJAOalblAMIw3f9r8Qfm+nTGbMPOPnD/YE6+wLSk0eYOudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyG8bhfy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720611373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2suduc0eZg9XX+FDprjOHVDzW/H7s1JCz2GVtSoayG0=;
	b=LyG8bhfyonup1L0lSqEfkisID/vTGVEI1dfnuQASY3lPZF1rsTdbkkk8NmErbOKkNoJeIj
	ueFWPBgX4bFgAxx+FMarOXVvL0HZuIXIntMpLPQH491al/C10XonLaMvTTRbdcRTbXRj0g
	6f3+uuZSse+O0EnGBTUV6+v1e7kFSuY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-dZLAnS0ZMqy41wztXxGyNg-1; Wed, 10 Jul 2024 07:36:11 -0400
X-MC-Unique: dZLAnS0ZMqy41wztXxGyNg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77af33ce50so501166366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611369; x=1721216169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2suduc0eZg9XX+FDprjOHVDzW/H7s1JCz2GVtSoayG0=;
        b=HMmx8+yqbm2k9gqrQQi+CZKRXhYIz0dLM2dmbH4HkU6vWWev1njuUxznQFCr5mqzjq
         P7dyFyYNSPznN8AfDhqtVdOzVNy/dBDGabkCH5QSpKTg8ZBCjXwYNd6E261+SWKeRj3v
         waanglZmGJJgNRnyN9ZNtrj78KZMUnuirEP4NwUMYAUsBWRvckh6ai4gPtfgrquoNgJI
         CjEvZQc66JYECB3zgPH2pcFH5aKLzxQ+okqmCno9cQJgIjh6tsLetTUyMFEJH2iTWtjH
         UhsvQSyw5yG9KnL6DyOnqC/qxelNLo3kD/SnGQwX9ynZhCWalqa67qQSGgD0CLIzVqFU
         YCPA==
X-Gm-Message-State: AOJu0YyHHGIH5xLYDrUOCvX5hOM1eUslCx9Cqrl+2ifYfSdbUl6GQsB8
	R4xnrnOWuCblZiWNHuQ7cxoU+z0LJ+LdncAHg6noaf+FYgNK7cEBTLEZQsSmbQnuArLaVxnr777
	3ZIuhCjRKWZooH6sx6ojmfz6wuxQI1m4H8prRiYvvzq86tEnGY8+HyMi0pM341Q==
X-Received: by 2002:a17:906:118f:b0:a6c:7181:4ffe with SMTP id a640c23a62f3a-a780b89cae7mr337171266b.66.1720611369132;
        Wed, 10 Jul 2024 04:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1927fCvntios62qJMLPjpSJ34oAaJFk3+qIAErLv8E/TF32/P37V3lT+hs0r8hE+DUqaNEA==
X-Received: by 2002:a17:906:118f:b0:a6c:7181:4ffe with SMTP id a640c23a62f3a-a780b89cae7mr337169166b.66.1720611368490;
        Wed, 10 Jul 2024 04:36:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854592sm152506866b.146.2024.07.10.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:36:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:36:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <20240710065317-mutt-send-email-mst@kernel.org>
References: <cover.1720173841.git.mst@redhat.com>
 <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
 <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
 <20240710021441-mutt-send-email-mst@kernel.org>
 <CACGkMEv7-si5b9Eq7mEDZHGC2r_6CFudOHj9ge7u3s7a1epNcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv7-si5b9Eq7mEDZHGC2r_6CFudOHj9ge7u3s7a1epNcA@mail.gmail.com>

On Wed, Jul 10, 2024 at 03:37:49PM +0800, Jason Wang wrote:
> On Wed, Jul 10, 2024 at 2:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:23:20AM +0800, Jason Wang wrote:
> > > On Fri, Jul 5, 2024 at 6:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > QEMU implemented the configuration
> > > >         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> > > > incorrectly: it then uses vq3 for reporting, spec says it is always 4.
> > > >
> > > > This is masked by a corresponding bug in driver:
> > > > add a work around as I'm going to try and fix the driver bug.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
> > > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > index 9a61febbd2f7..7dc3fcd56238 100644
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
> > > >
> > > >         err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> > > >                               callbacks, names, NULL);
> > > > -       if (err)
> > > > -               return err;
> > > > +       if (err) {
> > > > +               /*
> > > > +                * Try to work around QEMU bug which since 2020 confused vq numbers
> > > > +                * when VIRTIO_BALLOON_F_REPORTING but not
> > > > +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> > > > +                */
> > > > +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
> > > > +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > > > +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
> > > > +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
> > > > +                       err = virtio_find_vqs(vb->vdev,
> > > > +                                             VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
> > > > +               }
> > > > +
> > > > +               if (err)
> > > > +                       return err;
> > > > +       }
> > > >
> > > >         vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> > > >         vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > > > --
> > > > MST
> > > >
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Do we need a spec to say this is something that needs to be considered
> > > by the driver?
> > >
> > > Thanks
> >
> > I'd say it's a temporary situation that we won't need to bother
> > about in several years.
> 
> I mean, should a newly-written virtio-balloon driver care about this?
> If not, it means it can't work for several Qemu versions.
> 
> Thanks

True - I could not find a way to make it work in a way that
would be compatible with old qemu.


> >
> > --
> > MST
> >


