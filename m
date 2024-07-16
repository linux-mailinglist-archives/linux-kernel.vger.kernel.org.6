Return-Path: <linux-kernel+bounces-253354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131F4932000
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5A8283B99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3D1B947;
	Tue, 16 Jul 2024 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCpwQ2ei"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F92B9D5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107040; cv=none; b=WGNiew374hHry+OveLvbAcdNKeAZdtiO3z27KzvTNFv/5Mn9R0vXA213Hdy+rl01LBjXNxdLXocFQoQ6jgMMnHl1bAEF5rGenbaubHe0esr/Xd/IdeYVinJFEDHV5ztQZjPIvxBfPrOc8PqTtA5+JeA7GLSJZqWM2/C/W+ZJ4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107040; c=relaxed/simple;
	bh=Ei8Zh+WUYz9gyI6jvfia3vMDKTzpVSDcVJwlBtwjSN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmK+u1nLxmnJ3b6A0pc8Q8BJunaNteX/Tnwj1bXRocBt15VQ6LN0dekf/sxODKkCUV6eAhUWrX2J0eOJRuXJAUjuo/odieLpGD0Em3GnsjgKx35i4hhFVj0DeFXvLipIQMG297ozIzVfdHFvWuWwE0NnTBIHXS3wpbM23FdDJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCpwQ2ei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721107037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV35LYaNNEGWx8EBWfuJaXV5qmmqt8q3YPSyBVDLw84=;
	b=WCpwQ2ei2CgPgeATdYARUnWY2jdRAWR+rFBJDonlhygl3ctA8Z2m4cuahNIuLi7I0BYNHZ
	6Z5QS7neyXJJqy7TXA6gXZGZ2MN/YVAy4ZO1pUj/6/IxaJM0O5xeG9cZcIUc49n5MBR1Vl
	aUhCcfCF3OTwo6zQq3Lhv86hV4AYKUQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-WMg7nGSJNAC_EvzQrS5h6Q-1; Tue, 16 Jul 2024 01:17:13 -0400
X-MC-Unique: WMg7nGSJNAC_EvzQrS5h6Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c965f8f813so4299612a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107032; x=1721711832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV35LYaNNEGWx8EBWfuJaXV5qmmqt8q3YPSyBVDLw84=;
        b=Rljh9LejEqb7Go+c5jjYN8GJNpRSmu6d+/wkfYkEFmvXbWHMXa3W4ttC669zorFzZ/
         uUEwWnOES9F2pUtvDdp2bh1hj4o1dTSO+FP8sy1lHSdtoXyzYlvz8gob/cozrb81s3qW
         mMqbahvtnhM3Iia/G+1OnGGEeiK6zK9mbpFdkjmx3Had394QfW8seedDN7C0mMyMcPKn
         37dgJtjmoSGAV4kDXmsKRgkMh45p2ZzmkNXQCmOaiNCjnhQBRn6oVd0Dij6oCETglUrh
         JxwZCmLEN0SBrSSX2fO1bDeX2b99HZV0JTaibCzIM109N3GuXfU7NJu1TEDURqIMnwL4
         HUrA==
X-Forwarded-Encrypted: i=1; AJvYcCVHsf/uEj4xpR+hCkzrZmSXgw1jbfHC+IQTta8Qhte1Cev3w5x2CBwEUu/mG5aeTyfeOD3lEbKciYAORBJzaLfB3l4KySpcYxt1NtpL
X-Gm-Message-State: AOJu0YwxzBHQ6rMW0Ja/KQK2sRDzWaHZkcE02n3s6LeV/VSVHKUQ2Yc+
	InFM/ebJINcVXrK+F0cxAX4kyuh4Y59NuVV0IRiBJwWJgzadiv9M6Va+ff5xtyA08a0KZw3OzW+
	sgM0+3AjXTzc/3xjf4+iq14KOti8O89iJ4EhrrQgBj182bzwmNaz5y/zi5BNKhxekWLPN57onNJ
	hHUeABcPPP7rCWRBDlNPCRjK8vvgiAuHOGbkEE
X-Received: by 2002:a17:90a:bb07:b0:2c8:f3b4:425 with SMTP id 98e67ed59e1d1-2cb3740ee4emr790012a91.23.1721107031940;
        Mon, 15 Jul 2024 22:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ANQt5ows3QOa5bdpVKACuf5yOTcvmdotzZ6xqk3YrNrhe/6vFwXEh88rK+S5GL0Jwr+RG+N864dnR4xWlNg=
X-Received: by 2002:a17:90a:bb07:b0:2c8:f3b4:425 with SMTP id
 98e67ed59e1d1-2cb3740ee4emr790002a91.23.1721107031501; Mon, 15 Jul 2024
 22:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com> <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com>
In-Reply-To: <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jul 2024 13:16:59 +0800
Message-ID: <CACGkMEtL7Fkj+srq+beK8UBZ5QDowpz+hT2HZ8RZR00UsRJcVA@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:27=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/14/2024 10:26 PM, Jason Wang wrote:
> > On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Add an ioctl to transfer file descriptor ownership and pinned memory
> >> accounting from one process to another.
> >>
> >> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OW=
NER,
> >> as that would unpin all physical pages, requiring them to be repinned =
in
> >> the new process.  That would cost multiple seconds for large memories,=
 and
> >> be incurred during a virtual machine's pause time during live update.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++=
++
> >>   drivers/vhost/vhost.c      | 15 ++++++++++++++
> >>   drivers/vhost/vhost.h      |  1 +
> >>   include/uapi/linux/vhost.h | 10 ++++++++++
> >>   4 files changed, 67 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index b49e5831b3f0..5cf55ca4ec02 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *=
v)
> >>          return ret;
> >>   }
> >>
> >> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> >> +{
> >> +       int r;
> >> +       struct vhost_dev *vdev =3D &v->vdev;
> >> +       struct mm_struct *mm_old =3D vdev->mm;
> >> +       struct mm_struct *mm_new =3D current->mm;
> >> +       long pinned_vm =3D v->pinned_vm;
> >> +       unsigned long lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> >> +
> >> +       if (!mm_old)
> >> +               return -EINVAL;
> >> +       mmgrab(mm_old);
> >> +
> >> +       if (!v->vdpa->use_va &&
> >> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit=
) {
> >> +               r =3D -ENOMEM;
> >> +               goto out;
> >> +       }
> >
> > So this seems to allow an arbitrary process to execute this. Seems to b=
e unsafe.
> >
> > I wonder if we need to add some checks here, maybe PID or other stuff
> > to only allow the owner process to do this.
>
> The original owner must send the file descriptor to the new owner.

This seems not to be in the steps you put in the cover letter.

> That constitutes permission to take ownership.

This seems like a relaxed version of the reset_owner:

Currently, reset_owner have the following check:

/* Caller should have device mutex */
long vhost_dev_check_owner(struct vhost_dev *dev)
{
        /* Are you the owner? If not, I don't think you mean to do that */
        return dev->mm =3D=3D current->mm ? 0 : -EPERM;
}
EXPORT_SYMBOL_GPL(vhost_dev_check_owner);

It means even if the fd is passed to some other process, the reset
owner won't work there.

Thanks

>
> >> +       r =3D vhost_vdpa_bind_mm(v, mm_new);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       r =3D vhost_dev_new_owner(vdev);
> >> +       if (r) {
> >> +               vhost_vdpa_bind_mm(v, mm_old);
> >> +               goto out;
> >> +       }
> >> +
> >> +       if (!v->vdpa->use_va) {
> >> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> >> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
> >> +       }
> >> +
> >> +out:
> >> +       mmdrop(mm_old);
> >> +       return r;
> >> +}
> >> +
> >>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned in=
t cmd,
> >>                                     void __user *argp)
> >>   {
> >> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file =
*filep,
> >>          case VHOST_VDPA_RESUME:
> >>                  r =3D vhost_vdpa_resume(v);
> >>                  break;
> >> +       case VHOST_NEW_OWNER:
> >> +               r =3D vhost_vdpa_new_owner(v);
> >> +               break;
> >>          default:
> >>                  r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
> >>                  if (r =3D=3D -ENOIOCTLCMD)
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index b60955682474..ab40ae50552f 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> >>   }
> >>   EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
> >>
> >> +/* Caller should have device mutex */
> >> +long vhost_dev_new_owner(struct vhost_dev *dev)
> >> +{
> >> +       if (dev->mm =3D=3D current->mm)
> >> +               return -EBUSY;
> >> +
> >> +       if (!vhost_dev_has_owner(dev))
> >> +               return -EINVAL;
> >> +
> >> +       vhost_detach_mm(dev);
> >> +       vhost_attach_mm(dev);
> >
> > This seems to do nothing unless I miss something.
>
> vhost_detach mm drops dev->mm.
> vhost_attach_mm grabs current->mm.
>
> - Steve
>


