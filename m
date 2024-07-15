Return-Path: <linux-kernel+bounces-251988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CA930C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FE3B20D33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4217483;
	Mon, 15 Jul 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbvUCyIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C974C9D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721010393; cv=none; b=RkpdbpbSKJIX2C3Dv5QKaOK6RwuJ5GLUgbRbwWJBLjuJ9+FQ+Pb7d9oYwZbZgMa/FmTlb1N8ldjhvisfqcwn/+HCvZV/rf4cVT5+FeFCsgFXM7bzABoK8Ah+14Atpn/pl2jY6OnvtemnWOcjzWNOwA8FHS37YEflREsVPuXOQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721010393; c=relaxed/simple;
	bh=SGA3prCIJJ3llNRdzo4QP/2bUfApjHDjg1r3KYXgOC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFxYNaUazhlSi64wfaqQnOGhiSDbx+zk05sBWMDfooS4Z/UTD4ABwagENhvxRS+y1c6Jgg+5FEE/+Argxxk3qg52ZM06dY/RGWySTVKzXNFeU9HQ+a2N+bjqMpnhPeyW5Ylg+4mMAWCNsGyIW6im0Fo2BVxNZPrCKzVgpmNNEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbvUCyIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721010389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGz2AvnYlX/OuYWFp42oY62WHdDe8oCr+x16py/fxm0=;
	b=KbvUCyITUT0o81rgAaOmAgsSe3TfRvcm4y66vmDFenDHWuz7kJRn4gwoK0mrAlqzHSSC4x
	t0V79wjY9tmY5NBLaB2gQnwe+K6QVGDOXrHUPczOR4CPouw/Ng41nXUelr/imevpJf3H0L
	u58dfbE3h7DRQh9eAOnyYCk+Wu9EYjM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-rBF7rWt2NkGq4K5WN0zUFg-1; Sun, 14 Jul 2024 22:26:25 -0400
X-MC-Unique: rBF7rWt2NkGq4K5WN0zUFg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5c65e857b43so3320036eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 19:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721010385; x=1721615185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGz2AvnYlX/OuYWFp42oY62WHdDe8oCr+x16py/fxm0=;
        b=w5zG3MPD5Xh7eq2+2sCRbaQTXx5LccRuU3zTc0ocKSZJeA3zpN9q/dA7WL7iqLlknm
         yu1kcUo8A545EKWq3NltYYscj70wee3KngFWfdXZg/4CcI2ZC76CYcySdJIvN82B9cWT
         k5MMzPEZiESgavYUSfHVc2PDGgAhRYoigUprIOF5UV457rGC6LFJRFcxoDqyEqFbuUdr
         obTGIXmfr1+4EIVoZtNBGO5N7mKrZusMkd5AMwwGfPiKdK6ijafWTUmAjOh5XFjfB9T3
         grhV4WdO5bSQ61a2FVuzftbMvRqL0Fgyw9ebOXO1jNapnYPrOW0+Mez54zWSl7onhDx3
         iexw==
X-Forwarded-Encrypted: i=1; AJvYcCXGo1bpdbrCriiFR4sTHTbTzP8AN2G/GDGp5pLwAcpja/QOLXxevrsquTJvmbT/ilbc3onWuetHPZQ59d+G/bLPLqHDJsT1qLlzOsRc
X-Gm-Message-State: AOJu0YxodVuXprN3R8R/JJBmbwkZuqojnhS1OOHjgU4XIuJy9aiydbRL
	0xaQnVvJC3MxNLfLefcPEcLvmY5+kKAVh+9lvM4fXM1bID7B0RpYY7s4dMlhhZrshgnso1I40Kt
	JXJvsIDFhq2s/kY1aIKlLGicprbBhDnJIVw2Bo6tSrZQvBB0Oz36vzfogs0o3164zbESFlTVHL9
	wWRpHpJIbJSAAj1lEmioBicoG2OH+6Q4/8oNUc
X-Received: by 2002:a05:6358:71c8:b0:19f:1644:d45e with SMTP id e5c5f4694b2df-1aade0a6299mr1900876955d.8.1721010384908;
        Sun, 14 Jul 2024 19:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrFW06pmuoNN0Sc+c5vkbGajGRrCBhFYgVDbJHm25Mox95wsQfYrdPmBV25g65b3NPEHi7agQZ/xuwxNOAtfk=
X-Received: by 2002:a05:6358:71c8:b0:19f:1644:d45e with SMTP id
 e5c5f4694b2df-1aade0a6299mr1900875355d.8.1721010384479; Sun, 14 Jul 2024
 19:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com> <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:26:13 +0800
Message-ID: <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Add an ioctl to transfer file descriptor ownership and pinned memory
> accounting from one process to another.
>
> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER=
,
> as that would unpin all physical pages, requiring them to be repinned in
> the new process.  That would cost multiple seconds for large memories, an=
d
> be incurred during a virtual machine's pause time during live update.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.c      | 15 ++++++++++++++
>  drivers/vhost/vhost.h      |  1 +
>  include/uapi/linux/vhost.h | 10 ++++++++++
>  4 files changed, 67 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b49e5831b3f0..5cf55ca4ec02 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>         return ret;
>  }
>
> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> +{
> +       int r;
> +       struct vhost_dev *vdev =3D &v->vdev;
> +       struct mm_struct *mm_old =3D vdev->mm;
> +       struct mm_struct *mm_new =3D current->mm;
> +       long pinned_vm =3D v->pinned_vm;
> +       unsigned long lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +
> +       if (!mm_old)
> +               return -EINVAL;
> +       mmgrab(mm_old);
> +
> +       if (!v->vdpa->use_va &&
> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
> +               r =3D -ENOMEM;
> +               goto out;
> +       }

So this seems to allow an arbitrary process to execute this. Seems to be un=
safe.

I wonder if we need to add some checks here, maybe PID or other stuff
to only allow the owner process to do this.

> +       r =3D vhost_vdpa_bind_mm(v, mm_new);
> +       if (r)
> +               goto out;
> +
> +       r =3D vhost_dev_new_owner(vdev);
> +       if (r) {
> +               vhost_vdpa_bind_mm(v, mm_old);
> +               goto out;
> +       }
> +
> +       if (!v->vdpa->use_va) {
> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
> +       }
> +
> +out:
> +       mmdrop(mm_old);
> +       return r;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>                                    void __user *argp)
>  {
> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>         case VHOST_VDPA_RESUME:
>                 r =3D vhost_vdpa_resume(v);
>                 break;
> +       case VHOST_NEW_OWNER:
> +               r =3D vhost_vdpa_new_owner(v);
> +               break;
>         default:
>                 r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
>                 if (r =3D=3D -ENOIOCTLCMD)
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b60955682474..ab40ae50552f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>
> +/* Caller should have device mutex */
> +long vhost_dev_new_owner(struct vhost_dev *dev)
> +{
> +       if (dev->mm =3D=3D current->mm)
> +               return -EBUSY;
> +
> +       if (!vhost_dev_has_owner(dev))
> +               return -EINVAL;
> +
> +       vhost_detach_mm(dev);
> +       vhost_attach_mm(dev);

This seems to do nothing unless I miss something.

Thanks


