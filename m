Return-Path: <linux-kernel+bounces-528264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F1A4159C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F33218939E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8620AF7E;
	Mon, 24 Feb 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px/ai2Zl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB001C8632
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379499; cv=none; b=em/pHmUQYAxkv2U0exYvglx/CC5Dfhn7/85TrNBPqZ9t6KsQOy6+hBpZDNGLu39pcVpQ2JaEhMS2gZUJGsVxksv8t3mXWjOM4yHUkXC/+0DAW3fVkB3Bch122BLOV9oLwEUzUSQWp/HpVpdv1PNqi0CGGGBAE0Dr+a+VwkNW9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379499; c=relaxed/simple;
	bh=/Jfq7whmlioOSwgDgSDv2qm9bwJJVCS1zNEaZ6n/TAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezcbtCQ45iSmn96qaOULdbziQMhgxynixerQa778PHEdqiDC2q5nh6CkOO5vwWDkvRICSvEYTKnz/thXNFE+B9tNR1VAXPbSWCPrSyiufjm7GJWahRNng0fOqBFBYq+/qmzHIg5bb/vDa81M1rcka/Poq+MCxxqSRIeadLg3vyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Px/ai2Zl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740379495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlnzt+4Vsslz5x4/AuLq7Fn3rGBWOoO6iNMkYrHdaZU=;
	b=Px/ai2ZlLBcrnxdEnU3O8m7xigc2WAI298WEwsJUsQisfsVraPMpiMxud/oCuR9yrVJS1M
	e1OG5d751pQUlmIkDEPWOIHP75Ro3uxZzTiLgnUXz1fAtWnRhqeCUUHWFCv4zdooBQmrOG
	fvBeP0tVbaqujMF0OfZ3ZALoUrD3RKQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-lhd-jH51NPOWiaIiitMpDQ-1; Mon, 24 Feb 2025 01:44:54 -0500
X-MC-Unique: lhd-jH51NPOWiaIiitMpDQ-1
X-Mimecast-MFC-AGG-ID: lhd-jH51NPOWiaIiitMpDQ_1740379493
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so13573435a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740379493; x=1740984293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlnzt+4Vsslz5x4/AuLq7Fn3rGBWOoO6iNMkYrHdaZU=;
        b=F1c0rMxB6+FiaUe6+FTCIaUD+YTvMJua4RGFgQ2TNEhZ1nFKgm85rhX1Ztk1rOkjgz
         oWOTgKWGRtE+dDWjY7tCzJMKnTJ2+7nI1D4iFn8brFDiy2aHZPJYTPTfB8KYUIIHBKWF
         cmP8erXBieBD5ePXucjwonnqjsW0k9BlhOtOuDi+cI0obV9pI/4PRmugr5fV5exMVaFU
         ntKdEApayffTYQNScPFrzyVRdbcCuwH9ZXd0Fv07rckZJN/1yUze1LHJyo2RDxVgdoBU
         +zVbYpS7CffioLe+54U6NTL+iXiHWYa9v88zrpKXjJWBGyjxL8+5Im4im4nidUH2Lx0h
         kKjw==
X-Forwarded-Encrypted: i=1; AJvYcCWedkR4NGUy92lqiiItyHt/XfrG/3+PsY5LNmk9QQwuMIFge7Uk4c1GPb+kg0uKnoZVqMVFaAsd4pdni9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqfoTZGZ1PzTwTrekVm9cOptXURFr3aOg0Pj5v7tiMq1b+Lv5
	0dJf+PPUxGaIPxr/6ypVHJc3wxhZ+eK34rbbCtn40CNGxIrsj7X+H+TC3zBh10ylCeYyeWgE/ad
	XJlKLLV8NPeFdiFzofkjJQ3bv+oITCRI0Hmq5E8jCm1XyjbKQB36LLq92GvQyj10BGM2jmJRo6X
	sULxe35BJEGp3ZWXHWeZG3bAZ1bHx7WT0X3ZRV
X-Gm-Gg: ASbGnctve1NVt0tbuMwfVuazsOhm3f+wAISfMIV3L0GoGdpU8jTTVxCFBur7ggp6KxG
	kTZXk2lt/PAgo5lSELb7NIa9I9YJHcgVw2adGcQ982ykRkHLNu4Zt1rqW3J/wIw3p+XjpTyQ=
X-Received: by 2002:a17:90a:e18c:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2fce86ae2cbmr22577969a91.12.1740379493311;
        Sun, 23 Feb 2025 22:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+QXXdDVbqf8t3f/26ebYVnK6ojKfcvcrvRH2q7kwGg4SFCRCzuT+aRlB7GnSP50i0yF2Yhl0NOkW+BNnKYTQ=
X-Received: by 2002:a17:90a:e18c:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2fce86ae2cbmr22577956a91.12.1740379493050; Sun, 23 Feb 2025
 22:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-6-eperezma@redhat.com>
 <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com>
In-Reply-To: <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Feb 2025 07:44:16 +0100
X-Gm-Features: AWEUYZmaaoOh5-_CSThxXsUePh68Wwvct_SIIcGFaKJE8V1sULxHulV6xbikoMM
Message-ID: <CAJaqyWcxWvYrFoocHD6e4ccZxQp9J=rQ_Ou+s3zcwmXQt4xMYA@mail.gmail.com>
Subject: Re: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Disable notifications right before scheduling, instead of waiting until
> > the work is running.
> >
> > After applying this patch, fio read test goes from 1191MiB/s to
> > 1263.14Mib/s
>
> Let's describe more about the testing. E.g FIO parameters, test setups.
>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index e19c78f2480e..3d6981c0f3c3 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
> >
> >         dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
> >
> > +       /* Shceduled, don't send more notifications */
>
> Typo, and I think we can just drop this commnet.

Agree.

>
> > +       virtqueue_disable_cb(vq);
>
> Do we need to tweak the virtio_fs_requests_done_work() as well?

I don't think so, as virtqueue_disable_cb can be called multiple times
without consequences.

To control it in virtio_fs_requests_done_work imply to create a new
boolean somewhere and add a conditional there, redundant with the
conditional in virtio_fs_requests_done_work.


