Return-Path: <linux-kernel+bounces-304712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2949623DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C9F1C22A80
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C9166F12;
	Wed, 28 Aug 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6KFRKom"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423E1547F2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838424; cv=none; b=PcjRYeh5ffLNToAtzzv/zRPKhQNlIiej0MytuGKGWF94Ps0TjrMii+fQGV24DOXjFDa9NJEcTnlJpHs1M+XZum97UxpEqvMYEDAXdMTFNRD85K7x9csxb312mH2wx7Z/AaxDNi6j/WuDdZ2MEswDD5qfpQ58qNTApBzITUn8EsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838424; c=relaxed/simple;
	bh=r72QLoFGiRbClZBW9n0myeCz15GaLdkhV+3zu7ayllk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkIEBSu+hYlFyjj1xOBY2gHVewHikRzQ7pC+snnTfKx90c4PeSNt0mzbHhxFm6C0VWzHA2TgxDiem7GME/DempVx8bq2obLKOM6/ZJqnsOoMGHkrzt0NqxHC5veOG3bqiqe1EntcqdISkRarWz+dZd7gplV5/5sS2VRsqzl8+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6KFRKom; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724838421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccU6JWpMNBWSt+eDM3V9HlZBQ7GrgQMzqDlSIIFms9s=;
	b=i6KFRKomZh2DgqS513y6IzL49gIZfS8nC3aysHhcuEyQBpICElvTh2EKa0BIU3yCgJEcS8
	G3TOCyXX4jXLOG31QdTcIiQwlbXMy/hI8UeMHFUgH1kTUWoMX59p+xdlqfPJ9GXUcwM/Hl
	KBOhbpTdu8lgp1sHvjOcGZdfs/6PjNI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-at8AkSkqPqyPrq-dF_ux7A-1; Wed, 28 Aug 2024 05:46:59 -0400
X-MC-Unique: at8AkSkqPqyPrq-dF_ux7A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5befa588972so5698168a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838418; x=1725443218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccU6JWpMNBWSt+eDM3V9HlZBQ7GrgQMzqDlSIIFms9s=;
        b=p1qcw0NQ90NS05yDu8eEMtUrA0oiYeoGWjJ9lDoRo4f+sgAAfkMs9vIthBsrvytSD+
         PkZ+2GxAZSckxB4Y9qOtO4mZPg9RtnvtYEVwzsnRJW1JRbUmcrRJIpRzpoO0GluN/qkF
         AaQPNZBUYyO4DMHO4p2Vg0XVWzjV3R++7UwDe0lYjz/uQzsXpvI/v7g2qlu5VCh4h4EW
         ODRjQHXuUXjjrUCedGSjyvW8+zeVW0Z6SBApxmwWgGSmdsIjSZ1By366d0VyOtnziNwD
         J2y9manwjTUZ7weqYebTwwHZgI1b69vMaajx6j5uAtXXbXC5C+R2TQBtaUdyf1jLVGaE
         DctA==
X-Forwarded-Encrypted: i=1; AJvYcCVicV9mRgRvmiTmwwLYhvxb/gvFSgihpZM/mZ+4BoufVvvsDcsKJ54IQLiICkHmzPNTHlkx6gSbt5dZolM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFIK7Y9R/Am6a6d/B/el+YVqSQ9DpENQNIb1S8yHdZfVWz8L3
	eDNX6semwy5mfT1d5ThITBxSs24ElX1fn62FTr5Bxmvnq2VAJkV958SpBw98PVlQF2iO+k4PBeh
	OMl0hdIBnkmLpn93DDLZazx/YxGVo7fOotrFkik5kx8Mct5GT3ATcEUKXIV3FFUlwyRocQuuNMj
	vDcolv/+vFxVJzwT04qN0ribmXYVMWVn00HyRy
X-Received: by 2002:a05:6402:3709:b0:5be:e01c:6b5e with SMTP id 4fb4d7f45d1cf-5c214c62bf7mr1053096a12.35.1724838418360;
        Wed, 28 Aug 2024 02:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnq9AE9KRm5+YQj4Di1/zCftkF/BXYpzArwOeoZ4gVb/5zNP3hTWdDBV5iE8iU3DddUjK/zdPyIa2rrsOkdmY=
X-Received: by 2002:a05:6402:3709:b0:5be:e01c:6b5e with SMTP id
 4fb4d7f45d1cf-5c214c62bf7mr1053075a12.35.1724838417911; Wed, 28 Aug 2024
 02:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <CACGkMEu8y74bffhfPcPGdq1jBVXxaPivXGRh3qe9TdjOQfrp0g@mail.gmail.com>
In-Reply-To: <CACGkMEu8y74bffhfPcPGdq1jBVXxaPivXGRh3qe9TdjOQfrp0g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:46:21 +0800
Message-ID: <CACLfguVSqfrjTjYGkP6Fis=pONcf5x7u-8qUb=-Z+o-fLWENcg@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 10:32, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a new UAPI to support setting the vhost device to
> > use kthread mode. The user space application needs to use
> > VHOST_SET_USE_KTHREAD to set the mode. This setting must
> > be set before VHOST_SET_OWNER is set.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 11 ++++++++++-
> >  include/uapi/linux/vhost.h |  2 ++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 0a7b2999100f..d6b71bddc272 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2340,14 +2340,23 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >  {
> >         struct eventfd_ctx *ctx;
> >         u64 p;
> > -       long r;
> > +       long r =3D 0;
> >         int i, fd;
> > +       bool kthread;
> >
> >         /* If you are not the owner, you can become one */
> >         if (ioctl =3D=3D VHOST_SET_OWNER) {
> >                 r =3D vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +       if (ioctl =3D=3D VHOST_SET_USE_KTHREAD) {
> > +               if (copy_from_user(&kthread, argp, sizeof(kthread))) {
> > +                       r =3D -EFAULT;
> > +                       goto done;
> > +               }
> > +               use_kthread =3D kthread;
> > +               goto done;
> > +       }
> >
> >         /* You must be the owner to do anything else */
> >         r =3D vhost_dev_check_owner(d);
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..386fe735da63 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,6 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,      =
 \
> >                                               struct vhost_vring_state)
> > +
>
> Unnecessary changes.
>
> > +#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)
>
> So I think we need to do something the opposite. New flag for new
> behaviour instead of new flag for the old one ...
>
> By using this we can unbreak the old applications.
>
> Btw, I think this needs to come before/along with the introduction of
> the module parameter that enforce old behavior.
>
I think the old behavior your mentioned here is use Kthread?
So If I understand correctly, the NEW uapi is something like
VHOST_SET_ENFORCE_TASK

The module parameter can also be changed to.
bool enforce_kthread =3D true;
module_param(enforce_true, bool, 0444);

thanks
Cindy
> Thanks
>
>
> >  #endif
>
> > --
> > 2.45.0
> >
>


