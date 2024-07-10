Return-Path: <linux-kernel+bounces-247072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A392CAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F40281DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C196AFAE;
	Wed, 10 Jul 2024 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAa7Id9i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15475FB95
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592175; cv=none; b=V6C8RaO97CnJC+8+wvKupH5Xs4VQZ4ZSNT6215+1mZwViRKxy9uBqSpBzn9+DmOWCv5X90dXkgkuFAg4fl57sll593DVpj5lKmYE2ysB8sOPDd4G86Md55QqIevsyyBjWqOnqWlIHA+MuigIu3p5zr4HQiwroOCmG3MfVYoCRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592175; c=relaxed/simple;
	bh=iHfMvlRCdeSCmCn+gosEI7hLv7yJDjDMkOnCUgrZe0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcu/WwM1s5EK8QsyvZWZzoa5uKPauOYkKe0iJwjMOF2erOOyVx9y366Eje1Lf8ClTuSMNJtLsS3Lel6QUub6qrcKfg+SVevi9DALto525j8c+oSxBl6TrgLbBk2/l1QXLaIMeDt++E1shYl3Rh/r2nFgBE3PfaSwJS01DZ1bWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAa7Id9i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720592172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nG64wpqZ5i6Hhdx10fctj8MX2Oe6BbD4hvrpu9U64kw=;
	b=QAa7Id9i9NOpWQ31LyIt0Q+ns56L1yt5i7AS9+/hKAacmVDkjO0WcdrtQ+ZEv7I9syJRyv
	PajToo8Dap5sQPrtSI3PWiGg12FgpHD9T0OCTBMWKMY4vjSjzJEaEg+oP2byX4/mBayk1K
	rWuen1JxkV7XqvVcs12ibeJq8Of3zKw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Szyu2zLiO7W1Zaa0_OchAA-1; Wed, 10 Jul 2024 02:16:11 -0400
X-MC-Unique: Szyu2zLiO7W1Zaa0_OchAA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42796140873so860645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592169; x=1721196969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nG64wpqZ5i6Hhdx10fctj8MX2Oe6BbD4hvrpu9U64kw=;
        b=vrnkZspNLgNYN8McYPLcYg+JdIPWB6GKWEmeHiglf9a3Flf5+Ta9xET55XYFXeUxpe
         SOCUUYlXtGSJo0mXju+KJXR4MDpKFeEjqwYk888XGsxcEVP89LwCsfPdMuEyiXE69N77
         /bYUJChYAP5wOE3a/jVXKr/N34+9lfDoaB0vJ73hK8Yspmzfd7WsJs+XWz3wdRKkzHth
         uW8g8+U1HApqABA03Ab0KVzj8+FkaID0lUUGcZFQdULs4f08GY5FD7U4rzTFGIeSznKN
         TShb1XdUXa4d+wcmMl7hWA7C9WOBuGh68ns0lla2qVXORxX/x1CdvY6J4fmXGfdknxrC
         ghow==
X-Gm-Message-State: AOJu0Yy+WK84TdZTyYeN2xghBD8zdhRHDPuqz8zMHmNka/eQqhutQASp
	MS8TT9amkmDjj+i7rStmN9xPMQsDXS5U6cO9jKLPD6j2aXn1OakSArRXdzCIvWGzQlRu3QxlMjC
	5EZdw6SaWotmpBCc20/q8JXCFdL2AAk6QVlnSuinZDAbxM3PW0oV+iw41bfo9b7r2r+0iIA==
X-Received: by 2002:a05:600c:230f:b0:426:5fcf:5e89 with SMTP id 5b1f17b1804b1-426708fa1d5mr31680595e9.33.1720592169242;
        Tue, 09 Jul 2024 23:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGogtW/P5GMJqkRp473befh8IMF5KbwpHPgee+YwSI975xbMbt5re21Dp6bt8On+t2r/Lcfnw==
X-Received: by 2002:a05:600c:230f:b0:426:5fcf:5e89 with SMTP id 5b1f17b1804b1-426708fa1d5mr31680405e9.33.1720592168524;
        Tue, 09 Jul 2024 23:16:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266a38f5a5sm104671615e9.43.2024.07.09.23.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:16:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:16:04 -0400
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
Message-ID: <20240710021441-mutt-send-email-mst@kernel.org>
References: <cover.1720173841.git.mst@redhat.com>
 <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
 <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:23:20AM +0800, Jason Wang wrote:
> On Fri, Jul 5, 2024 at 6:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > QEMU implemented the configuration
> >         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> > incorrectly: it then uses vq3 for reporting, spec says it is always 4.
> >
> > This is masked by a corresponding bug in driver:
> > add a work around as I'm going to try and fix the driver bug.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 9a61febbd2f7..7dc3fcd56238 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
> >
> >         err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> >                               callbacks, names, NULL);
> > -       if (err)
> > -               return err;
> > +       if (err) {
> > +               /*
> > +                * Try to work around QEMU bug which since 2020 confused vq numbers
> > +                * when VIRTIO_BALLOON_F_REPORTING but not
> > +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> > +                */
> > +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
> > +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
> > +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
> > +                       err = virtio_find_vqs(vb->vdev,
> > +                                             VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
> > +               }
> > +
> > +               if (err)
> > +                       return err;
> > +       }
> >
> >         vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> >         vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > --
> > MST
> >
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Do we need a spec to say this is something that needs to be considered
> by the driver?
> 
> Thanks

I'd say it's a temporary situation that we won't need to bother
about in several years.

-- 
MST


