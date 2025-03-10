Return-Path: <linux-kernel+bounces-553548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0FA58B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BB7188AEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A21C3BEB;
	Mon, 10 Mar 2025 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxsUKWEC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628B29A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582484; cv=none; b=bOZMtca2IsJCtg7zVGLo7OUUoRytkR93USoBcD9J5eRR9XdEHPdR+Sc/naIxaVhe3zahXl6ADKMY8oRRi6oB7dHtUL4cZr8BuNyvs3AoIsfPoHy+gGwPc+q1lyQU0r2EbfYoobEntJ6miCtzd8VnTxFbkZz4U7GlqFQiU5DsW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582484; c=relaxed/simple;
	bh=Ej3GMGlHpVfzanKsBYzCcPizoBxxPLk+vmAC5dehH98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI6B7ZpZiJQrjjGOs7lPGfYWp0HbfKh2TFSsDXgDkohxRU/CMvJrccjjh9usfdIAemNPMQV9vbzaKAzd1nOHJa3Zflv13l7BNVgKt3a/Cc5CId2dDlpwstYHhp8AvlO6wuErEZT5U0X53Bu2+rIjDH5TThwrxJ6FKa/355LDI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxsUKWEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741582481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbceALFOAXDwlrKk6BKJ6uMiVvCY64LvSE/YeKmsmrM=;
	b=YxsUKWECTRhfU2usd9ltQifPHNpEJsS3pXRXWP5ezzKBSeTOA1YTPgQ6pxhVzp1LXlSs5n
	ZbFN7lEPl6HC+9+rHVY1LxE3iaYhJiXxmUaAdaEuqYutbglBSqb6KGOfVDNuzkS8FoxHAY
	lhfUWkqbOaRi/PX7q+H6PakRQinnUzQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-PGah6oQxMWyvi-Lre9z07Q-1; Mon, 10 Mar 2025 00:54:39 -0400
X-MC-Unique: PGah6oQxMWyvi-Lre9z07Q-1
X-Mimecast-MFC-AGG-ID: PGah6oQxMWyvi-Lre9z07Q_1741582479
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so5411553a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 21:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741582479; x=1742187279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbceALFOAXDwlrKk6BKJ6uMiVvCY64LvSE/YeKmsmrM=;
        b=rO6jXYmMf47IThkaE9y0An7NPxVfBnOXDrVy3GCIa9fNKUwwv8yCkNp88CFqGJbltk
         znwVFKS7D4rNnIh5u1iXse8mwvGZxhodiLURDY9WsOEwzoGGQOVdDxieUBq+W9j1itjg
         JnPmqdldQXCzqP0diq4CRd//cQGWwBCSHIxkja09SI1gDXT4G/qML0qYPLXIxO2U5LVK
         XwOjSTWUbkRIoFV+vA4nk4Mo81lUucX3iFbCmGW88Nb+tZRo+PK3syKn+hJJgnJg12A2
         XZ46Tvi9OsT3CeugIgeg3QiWli+4/nzdG8+0Vk4RuiUf6boi62KiaP+9EOB9EcaW/84p
         LZPw==
X-Forwarded-Encrypted: i=1; AJvYcCW88gkWi2ytJUSjSsvNSCeDQX38RztwWuQzHANRgqIfDMfLA0SPFijKTL2wbe7JxhCcm+kcoUDDAg1vHpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4M3Meu0OCj2E/n2t4guN4s3+N+jxw/vnFBDtArrd5RiUIcE2
	9l0Vs/XJWhzwq/1IWXkTsOxojjVco6x8NcWf0VEN+uv0KEGSCXLOAOxlHsdzaVRD4J1cBY8+gZM
	sG4xzV+ki3rBMKO+lpnhsoFnpEatPMYVabF7a0FPDzVSj9TtnMr5ml6f1hN7rlFAlRz2XvWTGPU
	s6BR02jF2etH9yBhxy7EAflEdUprJu82ItHakj
X-Gm-Gg: ASbGncutDN5kGwJHC9Bxi8mJkL7P7j/hT7G4ffVLLXB9JC9cL6KO29ACvBVg0d8oV3C
	hH8Q1+xmkzdu8mBl8jhztq//gyqNtVTj/7C40663YTzyOEaguNZbYk71njcgYIiMxAeVJDnYeLQ
	==
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-2ff7ce8361fmr20103671a91.11.1741582478659;
        Sun, 09 Mar 2025 21:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOy4wkubfdY4rmjE4nVYH3EzfIy63HlIimFfPmtjEVryCYR1AfKHQgA7u4tps+tBzTrdofki7L500MLPtq6VE=
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id
 98e67ed59e1d1-2ff7ce8361fmr20103635a91.11.1741582478041; Sun, 09 Mar 2025
 21:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com> <20250303122619-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250303122619-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:54:26 +0800
X-Gm-Features: AQ5f1Jp343rEJyx66YRk5WfInd8kOaRENHB4oOZ_ZHycTTo0oYdMS29y7Ll8IMo
Message-ID: <CACGkMEtheNa905789WT20=p84HN9-B6=K7XA8dpB6=jJV0kh-g@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> > On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > is disabled, and any attempt to use it will result in failure.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/Kconfig | 15 +++++++++++++++
> > >  drivers/vhost/vhost.c | 11 +++++++++++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >           If unsure, say "N".
> > >
> > >  endif
> > > +
> > > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > > +       default n
> > > +       help
> > > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which =
allows
> > > +         userspace applications to modify the thread mode for vhost =
devices.
> > > +
> > > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set =
to `n`,
> > > +          meaning the ioctl is disabled and any operation using this=
 ioctl
> > > +          will fail.
> > > +          When the configuration is enabled (y), the ioctl becomes
> > > +          available, allowing users to set the mode if needed.
> > > +
> > > +         If unsure, say "N".
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index fb0c7fb43f78..09e5e44dc516 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> > >                 r =3D vhost_dev_set_owner(d);
> > >                 goto done;
> > >         }
> > > +
> > > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > >                 u8 inherit_owner;
> > >                 /*inherit_owner can only be modified before owner is =
set*/
> > > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> > >                 r =3D 0;
> > >                 goto done;
> > >         }
> > > +
> > > +#else
> > > +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', =
return error */
> > > +               r =3D -ENOTTY;
> > > +               goto done;
> > > +       }
>
> why do we need this? won't it fail as any other unsupported ioctl?
>
> > > +#endif
> > > +
> > >         /* You must be the owner to do anything else */
> > >         r =3D vhost_dev_check_owner(d);
> > >         if (r)
> > > --
> > > 2.45.0
> >
> > Do we need to change the default value of the inhert_owner? For example=
:
> >
> > #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > inherit_owner =3D false;
> > #else
> > inherit_onwer =3D true;
> > #endif
> >
> > ?
>
> I feel it is best to keep the default consistent.

Just want to make sure we are on the same page.

For "default", did you mean inherit_owner =3D false which is consistent
with behaviour without the vhost task?

Or inherit_onwer =3D true, then the new ioctl to make it false is
useless. And if legacy applications want kthread behaviour it needs to
be patched which seems self-contradictory.

> All the kconfig should do, is block the ioctl.
>

Thanks

>
> > Other patches look good to me.
> >
> > Thanks
> >
> > >
>


