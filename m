Return-Path: <linux-kernel+bounces-344236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A098A713
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA631C22486
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739D191F77;
	Mon, 30 Sep 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CgGf5Jh5"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACA18FDD8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706707; cv=none; b=L4zq/WMuCiivssIZ/Tzor2K9iBQg4nri10NlbKwlzGk23kDq8S97a3pCeOoYiXfZNAPMvTJgLHm2UGoxKlAnIgMVQ0bFwq+ip1iCHQvKQe39cadzhRrIl8J4wuqpJJ0HPW92pHxUZBjDK8/ZXw9plL+j9iQRKX+Kccw1k9UaFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706707; c=relaxed/simple;
	bh=PV75RsCHFd9Set6408trF5b+jscrnWLWrq8vU1FBhhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jzr6zvGgKgn40+Qfi7DYE/g7vPENcJHR/6mo7ln7ykmkLaYxk/wTxoooypGt4q2ulXqdK8qWpYEUGN8Q3JiZPYX5kYKrMaYxzQEYsWC0++g7cCADSfXoIF2yWPUd+1YBDjaOq1UtrnrgvWc07KFtIEAbt+c/JqI63kbIuhHQXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CgGf5Jh5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D6693F5B3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727706698;
	bh=VUmP4zgDk2FCqePA5hQ7O8LU3PwZfHmbS4Pals0CPPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CgGf5Jh5SMQXUC+IUbE+lWXk7X3D72WiLQJBDwxJcKohps4Lx2ydHBGWaLd34TNlS
	 f+D6mtZ0+Tea58J83OOtGKzAcVSjqaE/QLfjYSdLhbmoI32bjHH/Yj4E0pPubXxqWP
	 TB0cFbUIbvzHT+ch7uOCnfy4wbCEI4+qufwB4dpcJVNMYD42JztV0GJxXZteTDVf8j
	 XoC0CEPEGZIVOzyWnGnBWiHFB53HkcDsC9ytDhG9pXBO5hUfEydItHvoXuDCFJC8ig
	 w95ZwKw/iojdICaaN26Tr+sJU/UysCG7bb0+8H6KxJgYuitxsRThgBs/l2uLKj/ce8
	 fo7xHvVe/lhTw==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-507874de4c5so589431e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706697; x=1728311497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUmP4zgDk2FCqePA5hQ7O8LU3PwZfHmbS4Pals0CPPE=;
        b=JiYo/5kPKfOjl7SCWlPgzNgJFOORSCRRxpxFXyIMgnK4LASsy9MHq4uenvSj7Ru2ft
         bf8vT3cLPirHzQFvmYK2uP+ye9iMosO0AewpEPKHCLkS0R5S8FuxAOSgzx2Y1HZ03weM
         /ifTzrrt1Lhk1I/cECTCYViof4xc29TmmI9UMGowvmoMHo1Cu3MlANNOrgcVJOHmtyJi
         3Sf1sfSMBNu7G92HvHb0VrCkeHO9HP5Z/eF3M1ArBbP0LyFR1SRyti8dhWoblMP/4ip0
         16OTxHp2mGMSm3VMt0DsDOz2hp6knr5AdCsllvTnSVIlgzGi36uE2XglQ67nF7SH1nOq
         3ItA==
X-Forwarded-Encrypted: i=1; AJvYcCVoD7XKZr1xUjE6hBalBgH6DHyO7VXS52HNGCnf1iAANCO+1C7MlRE9If9PsHidYTpfJ+jcSnOs15jfwp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHFJe3X5kAPwyBmuv151a9Zkc1j09gW4GmMHCdz5Pi9PfY3EU
	ywZZ5abVt9U5n+CsZDvnTbdgOf2ogZyzuU89bbdo/6jMDV5/N+RgJOdiTq0130euc7qKF3/bHrh
	DhX3RfdqyNEi3S+2TxEIGbs867C3g28Wtnq7sZJykK2O+1aG2l7GqcfcMv+pg39rYGZ03rB1btY
	od+o1I1ZgV+xoPaeAbZbtb8kWLXinaqO/ntO690tXpjJYDE9CaonTv
X-Received: by 2002:a05:6122:469f:b0:50a:c73e:b337 with SMTP id 71dfb90a1353d-50ac73eb866mr1132469e0c.6.1727706696625;
        Mon, 30 Sep 2024 07:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUm0HvUYsfb4b25izSbvZDphH102aNkELKCDsxbCwfS/CukKD+k5zVEfDIEJd2YZSQnWu62hWtUFb1+rs3YZQ=
X-Received: by 2002:a05:6122:469f:b0:50a:c73e:b337 with SMTP id
 71dfb90a1353d-50ac73eb866mr1132432e0c.6.1727706696263; Mon, 30 Sep 2024
 07:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <20240929150147-mutt-send-email-mst@kernel.org> <CAEivzxcvokDUPWzj48aJX6a4RU_i+OdMOH=fyLQW+FObjKpZDQ@mail.gmail.com>
 <20240930100452-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240930100452-mutt-send-email-mst@kernel.org>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 30 Sep 2024 16:31:25 +0200
Message-ID: <CAEivzxeBbRSgOKqDTkdxy2nyShD-Gq7+Go3+4Nm1DrwQ2-rGzA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: specify module version
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 30, 2024 at 02:28:30PM +0200, Aleksandr Mikhalitsyn wrote:
> > On Sun, Sep 29, 2024 at 9:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Sun, Sep 29, 2024 at 08:21:03PM +0200, Alexander Mikhalitsyn wrote=
:
> > > > Add an explicit MODULE_VERSION("0.0.1") specification for the vhost=
_vsock module.
> > > >
> > > > It is useful because it allows userspace to check if vhost_vsock is=
 there when it is
> > > > configured as a built-in.
> > > >
> > > > This is what we have *without* this change and when vhost_vsock is =
configured
> > > > as a module and loaded:
> > > >
> > > > $ ls -la /sys/module/vhost_vsock
> > > > total 0
> > > > drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> > > > drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> > > > drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> > > > drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> > > > drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> > > > -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> > > > --w-------   1 root root 4096 Sep 29 19:00 uevent
> > > >
> > > > When vhost_vsock is configured as a built-in there is *no* /sys/mod=
ule/vhost_vsock directory at all.
> > > > And this looks like an inconsistency.
> > >
> > > And that's expected.
> > >
> > > > With this change, when vhost_vsock is configured as a built-in we g=
et:
> > > > $ ls -la /sys/module/vhost_vsock/
> > > > total 0
> > > > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > > > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > > > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > > > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> > >
> >
> > Hi Michael,
> >
> > > Sorry, what I'd like to see is an explanation which userspace
> > > is broken without this change, and whether this patch fixes is.
> >
> > Ok, let me try to write a proper commit message in this thread. I'll
> > send a v3 once we agree on it (don't want to spam busy
> > kvm developers with my one-liner fix in 10 different revisions :-) ).
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Add an explicit MODULE_VERSION("0.0.1") specification for the
> > vhost_vsock module.
> >
> > It is useful because it allows userspace to check if vhost_vsock is
> > there when it is
> > configured as a built-in. We already have userspace consumers [1], [2]
> > who rely on the
> > assumption that if <any_linux_kernel_module> is loaded as a module OR c=
onfigured
> > as a built-in then /sys/module/<any_linux_kernel_module> exists. While
> > this assumption
> > works well in most cases it is wrong in general. For a built-in module
> > X you get a /sys/module/<X>
> > only if the module declares MODULE_VERSION or if the module has any
> > parameter(s) declared.
> >
> > Let's just declare MODULE_VERSION("0.0.1") for vhost_vsock to make
> > /sys/module/vhost_vsock
> > to exist in all possible configurations (loadable module or built-in).
> > Version 0.0.1 is chosen to align
> > with all other modules in drivers/vhost.
> >
> > This is what we have *without* this change and when vhost_vsock is conf=
igured
> > as a module and loaded:
> >
> > $ ls -la /sys/module/vhost_vsock
> > total 0
> > drwxr-xr-x   5 root root    0 Sep 29 19:00 .
> > drwxr-xr-x 337 root root    0 Sep 29 18:59 ..
> > -r--r--r--   1 root root 4096 Sep 29 20:05 coresize
> > drwxr-xr-x   2 root root    0 Sep 29 20:05 holders
> > -r--r--r--   1 root root 4096 Sep 29 20:05 initsize
> > -r--r--r--   1 root root 4096 Sep 29 20:05 initstate
> > drwxr-xr-x   2 root root    0 Sep 29 20:05 notes
> > -r--r--r--   1 root root 4096 Sep 29 20:05 refcnt
> > drwxr-xr-x   2 root root    0 Sep 29 20:05 sections
> > -r--r--r--   1 root root 4096 Sep 29 20:05 srcversion
> > -r--r--r--   1 root root 4096 Sep 29 20:05 taint
> > --w-------   1 root root 4096 Sep 29 19:00 uevent
> >
> > When vhost_vsock is configured as a built-in there is *no*
> > /sys/module/vhost_vsock directory at all.
> > And this looks like an inconsistency.
> >
> > With this change, when vhost_vsock is configured as a built-in we get:
> > $ ls -la /sys/module/vhost_vsock/
> > total 0
> > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> >
> > Link: https://github.com/canonical/lxd/blob/ef33aea98aec9778499e96302f2=
605882d8249d7/lxd/instance/drivers/driver_qemu.go#L8568
> > [1]
> > Link: https://github.com/lxc/incus/blob/cbebce1dcd5f15887967058c8f6fec2=
7cf0da2a2/internal/server/instance/drivers/driver_qemu.go#L8723
> > [2]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Does this sound fair enough?
> >
> > Kind regards,
> > Alex
>
>
> Looks good, thanks!

Thanks, Michael! And I'm sorry for not being clear in my commit
messages from the beginning of our discussion ;-)

Then I'll send v3 a bit later as I see that Stefano reacted to this
proposal too, will see how it goes :-)

Kind regards,
Alex

>
> > >
> > >
> > >
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > >  drivers/vhost/vsock.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 802153e23073..287ea8e480b5 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> > > >
> > > >  module_init(vhost_vsock_init);
> > > >  module_exit(vhost_vsock_exit);
> > > > +MODULE_VERSION("0.0.1");
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_AUTHOR("Asias He");
> > > >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > > > --
> > > > 2.34.1
> > >
>

