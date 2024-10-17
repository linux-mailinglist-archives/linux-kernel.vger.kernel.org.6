Return-Path: <linux-kernel+bounces-369270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0C9A1B13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E5D1C210B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62421199954;
	Thu, 17 Oct 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho9/Nj2H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01524158205
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148043; cv=none; b=BBRblyFJTloKdUj9/y65LUCEuV6HxSmIMemV75bYHr1DPgrGUq1VBBAsDTB0/H5dgF6QnC/X0EHiPFi2G8eUGZAU2L4K9x75+jwR/Km69iek+rq7llaipNHp8WrsXjlCmQICvjm2IkwxOZoZJ7uBojoum8lXxoIms9Tc1yLsiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148043; c=relaxed/simple;
	bh=pFA1yUiGPlsgyeSVcgazShhN8fRF06GsnpgIB1d90gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhZFNQzmOES34FS5N31LqOXsq3QCMoOc9gMllu3R6VTBSoyeuuhtXkUXhw3lYZJInSe1LtiWmRcrShvG2v5p14GCgeZ938J0KyuvsaEZhIwUTXffNbwag3d01E3UjhxxNdCixzaWC8Ol8b37f0Qs8aT/33EhPfVzUgb8AjaFOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ho9/Nj2H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729148040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJQzvz6uHtGrtsGDp9Qm2Acz8a7WWHI/1Ep6JEpCX4c=;
	b=Ho9/Nj2Hzmy873z6S9W4XjFr+d71nl1uaPSxx76fCezBwte283jhasWvHEOoyll3qJmPIs
	0u0gileE/rYzCryPsUTCQ1Y1Hm4P6UpusHkRSpcB02gajDE0BTcuFyxdSJDzuOoMQHE6Ux
	mM0vRJ34NzZejYCxzwJtFSiCZiDJXX4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-zzHlaK7YO4ONNVLjcIMHKg-1; Thu, 17 Oct 2024 02:53:58 -0400
X-MC-Unique: zzHlaK7YO4ONNVLjcIMHKg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e3b9fc918fso838892a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148037; x=1729752837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJQzvz6uHtGrtsGDp9Qm2Acz8a7WWHI/1Ep6JEpCX4c=;
        b=uPquLSndSNWZYS5G/E2Ra8yk/TCIvmWBEf1ZAfCbWVcOc7hSLZJ3TlSQUAlQU+OBZL
         WiWFq3FeZ2YWIi6YB9YYI+sQ1ez/KmacTg/4VUUUlGDQdvobjxzJsRTYMUK2b1ceNlZ7
         zRz8R4Usz0pF0YpFOoYeM8XNZTmOy8R5pWcnmCfvHq/hoEa+SFiOqbcu1x9ZC28V+S2d
         5qXxuJ41fUJdTnKwxjbLrF0xgFMAK0TLVLB3dXtli1/pCaYXzha2Y9DUjLBytZfkGHLx
         zfNoHt2CFQXzML6sXcBY5hTpoH4JQwi+snnDaCd5TQxiBGJ5jIt3vQFKgxmcIXLZ4OmI
         +rAg==
X-Forwarded-Encrypted: i=1; AJvYcCXwJ73Z8snhtEzwf9Zr2xTZcLlIiwRtWPZJg4dFciV1ERGr8r9wLiiP37yGXKvjrnRlqu3Vr3NYrJD09KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/z8VacjA8VLieXxjPmDXKEq6gCSmH4clL1kw2rKX1neyYIdVf
	S+9E6y4yzFsIojk30E5OgZl3zz/fGU3gE/RcVNQGog2Bihyq3O1Io+NgPKR/6TaJNw4c3WtimdX
	JMTJtab2uVU0d/3M4DhCHkO+FRMH6I8jsZp6lOgrdlwM2Gl/Q2Q0A8w9mJnxMjpaVBhQz+IGetR
	Rl1Zfk+RfQAti92XJOFOhrsDAcl88SNwCu04B7
X-Received: by 2002:a05:6a20:2d14:b0:1d2:d001:5677 with SMTP id adf61e73a8af0-1d905ebfe59mr9558118637.17.1729148037328;
        Wed, 16 Oct 2024 23:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG8C/BVcvKkGicqaeLbaxiAJT7pyamfNAsXZNUiPjCu+QbFKGLR3kgbDl4/vHQ02bbwqp70XJypNXY2tnt4PQ=
X-Received: by 2002:a05:6a20:2d14:b0:1d2:d001:5677 with SMTP id
 adf61e73a8af0-1d905ebfe59mr9558108637.17.1729148036926; Wed, 16 Oct 2024
 23:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-8-lulu@redhat.com>
 <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com> <20241015061702-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241015061702-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:53:44 +0800
Message-ID: <CACGkMEuPzd-gtBhCGE8dRWdAbyta=9yFPYjiCU0H0z3tLRJPRw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 03:56:33PM -0500, Mike Christie wrote:
> > On 10/3/24 8:58 PM, Cindy Lu wrote:
> > > Add a new UAPI to support setting the vhost device to
> > > use task mode. The user space application needs to use
> > > VHOST_SET_INHERIT_FROM_OWNER to set the mode.
> > > This setting must be set before VHOST_SET_OWNER is set.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> > >  include/uapi/linux/vhost.h |  2 ++
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 08c9e77916ca..0e5c81026acd 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> > >  {
> > >     struct eventfd_ctx *ctx;
> > >     u64 p;
> > > -   long r;
> > > +   long r =3D 0;
> > >     int i, fd;
> > > +   bool inherit_owner;
> > > +
> > > +   if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> >
> > Maybe instead of a modparam and this ioctl we just want a new ioctl:
> >
> > /*
> >  * This will setup the owner based on the calling thread instead of
> >  * using kthread.
> >  */
> > #define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)
>
> I feel this is not good because it is insecure -
> process should not normally have a say in whether
> namespaces work correctly.

Note there's still a lot of kthread users, so the "problem" is not
specific to vhost.

> So we want the system admin to be able to block the
> old mode.

Then we will break the userspace silently which seems not good.

>
> > It would initially be used by vhost-scsi when worker_per_virtqueue=3Dtr=
ue
> > since that is a new use case and there will be no regressions.
> >
> > For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
> > tool XYZ can use the new ioctl when they are ready.
>
> I do not like it that we switched default now we apparently will be
> switching it back. Will break some userspace whatever we do.
>
> --
> MST
>

Thanks


