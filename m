Return-Path: <linux-kernel+bounces-528338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3AA41680
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8647A3A45C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A721DF988;
	Mon, 24 Feb 2025 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5Cm+0Ls"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF070831
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383123; cv=none; b=gggcGo4KwfZAdlW0xvUfuoQR0UtXxgkq16HI+tJfXLk7Bet4UErGhSe+z3NiBcz8Fq0UrRsv2bQwKB8PB4fP4XgAd932UU7GTbaHKdwjSyWLXxv0eLixp3PHHaI8smBTFY7EG4H6UoChmEdb65rLs7qkhYsiAFAwmPfbVgJb2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383123; c=relaxed/simple;
	bh=NH8pA/rRIuhJj2dTHWRNlJwy4WjedINerJ+EuN1qX8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jta2oZmZm1WH34bAeE9tlSXLsdOwVH3zJLajBHOnZWTsp/6AbGTj9+qnSA4T5kUFTHjG/kCEtNwKbS7q7/ITGz2fhKSfeXS/o2Qq2vg60jksfMaBuR0E+0vr2u+UYsrYm+egZUbf10c9iy/UnNpclbd2GtlxCg8V7l/fXmie6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5Cm+0Ls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740383120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqqJsStYSzgw6zPnJ9OVQt4WMGE6BKA9vAfMMXb1jqY=;
	b=C5Cm+0LsMKEzaMcX4rO+OyGriWQbL589H74Oo9NFZeX4AFFOvAloTquZOEQkpRcpZV3Hbk
	MXBxHYCyvxQJjkckFFBQXLwPK+VY4oRaRAF8/k3jaiPPEvZbGKxjeosSIUQMhmOjPPTU/B
	iAlxNHphbSeKqCImNcdNJ0K/A1Ir6aA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-UCyEv9tKNkenuUfBIrfaiQ-1; Mon, 24 Feb 2025 02:45:17 -0500
X-MC-Unique: UCyEv9tKNkenuUfBIrfaiQ-1
X-Mimecast-MFC-AGG-ID: UCyEv9tKNkenuUfBIrfaiQ_1740383117
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so8701105a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740383117; x=1740987917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqqJsStYSzgw6zPnJ9OVQt4WMGE6BKA9vAfMMXb1jqY=;
        b=TJh0MwiNaO0gSfVPrQoxHfsF+2iTI4Szglqw274kib6VpzHS11T6BaFDw1JCDFuMpb
         mJPTHGKQ33Crz0cfrzWUPQ9gTuJgpHTkfhD6tQQQk0mxHJdYzH3LeIH2xdlDjfh9VtxH
         Rg3PNmAUJdPiOw9NkSVsD2L8YFnJdjwOuQXWE8pAOR0B49wMDRz5Psz9laSYBSvFCfv4
         HL1US8C4w0uU7zBQ99SChqwFXfTg1WcTMgNv+FYoTddNjhaOSg8int0qyEJEAz9mSZDD
         4dq/WF69jEu+9ghJUhhx03Fq5mXSU69Sf+7tW4NV0z5GuhJ4xyiRI+RWrCTiAeeQB2jo
         l1jw==
X-Forwarded-Encrypted: i=1; AJvYcCUzzw/3lqaSYlrVD/KrU/+fnCmoEyejHiUDc39d18jdiZr9tn1ZwLyJafyHjXU4dgjCegpgLgRtcmv2qs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVDYwNPG9IzMmcq9d7ueiwXniGRT7rlC1lJ0LyDVtvwV+j/iQ
	cdp2EfHSDnzsYYN8DGifqwIxBqAG6qI30K1SjRN0R/Wbv/YoXKQrKkTUV4fyaWuIm2ZHqelea2+
	KpJBoI1EVQ0JycWX1V4SlGJR+MI+DAfD5EhMIzqCWxuD8flm2Fox7mLwOhZe4q3XvW78lt63lSS
	jNRcmygPiwMYL0ITKnhcNeuuyt6LayLsV3xi/P
X-Gm-Gg: ASbGnctPqcYAFYAB8cdc+LP9R74DykEUQfnvbab3QKu7pKRT0Ini+/h+X/w1qCw+YWF
	DgQnLJYyMKWHWSk3FV4Ionh9H5RfSfNPJUFvobSAVtUEzZuiauSEourBHrFhw3qQsPMyMlHs=
X-Received: by 2002:a17:90b:35ce:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2fce78afc47mr22453436a91.11.1740383116369;
        Sun, 23 Feb 2025 23:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd03NCJKapA0K4R+wH4X2B5nqwHMlKA6kza08T2BGLCU3PC/BSlrcq1ri4MQU6KVoRSv045FU2aIywSuBF4Y0=
X-Received: by 2002:a17:90b:35ce:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2fce78afc47mr22453410a91.11.1740383116074; Sun, 23 Feb 2025
 23:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-6-eperezma@redhat.com>
 <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com> <CAJaqyWcxWvYrFoocHD6e4ccZxQp9J=rQ_Ou+s3zcwmXQt4xMYA@mail.gmail.com>
In-Reply-To: <CAJaqyWcxWvYrFoocHD6e4ccZxQp9J=rQ_Ou+s3zcwmXQt4xMYA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Feb 2025 08:44:39 +0100
X-Gm-Features: AWEUYZlg1nXAbWMa31gRfSEy_may4MYKmRmSOpCZy6ZQMcIzQZvycxAkt7cnt7M
Message-ID: <CAJaqyWfwPCOSrgJ=rBFm4oJph5wPG2xu4Gvr-WFntqoA0n4o=Q@mail.gmail.com>
Subject: Re: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:44=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Feb 24, 2025 at 3:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Disable notifications right before scheduling, instead of waiting unt=
il
> > > the work is running.
> > >
> > > After applying this patch, fio read test goes from 1191MiB/s to
> > > 1263.14Mib/s
> >
> > Let's describe more about the testing. E.g FIO parameters, test setups.
> >
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  fs/fuse/virtio_fs.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index e19c78f2480e..3d6981c0f3c3 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *v=
q)
> > >
> > >         dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
> > >
> > > +       /* Shceduled, don't send more notifications */
> >
> > Typo, and I think we can just drop this commnet.
>
> Agree.
>
> >
> > > +       virtqueue_disable_cb(vq);
> >
> > Do we need to tweak the virtio_fs_requests_done_work() as well?
>
> I don't think so, as virtqueue_disable_cb can be called multiple times
> without consequences.
>
> To control it in virtio_fs_requests_done_work imply to create a new
> boolean somewhere and add a conditional there, redundant with the
> conditional in virtio_fs_requests_done_work.

I meant it would be redundant with the conditional in
virtqueue_disable_cb_split and _packed, as they store the avail flags
set so the operation is idempotent :).

Is it worth reordering this patch so it can be profiled and applied in
current code?


