Return-Path: <linux-kernel+bounces-252273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB2C9310D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9353B282942
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37B185E76;
	Mon, 15 Jul 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaLRfd0C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A15223
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034399; cv=none; b=qU6b1P2AMMkNB0iq+yjntwa9YDhONIXhr101LSxp0PFN1GfopkBIdnQtEmTqrdALA3C2bsDGo9Rdv6j8+ZIlgKL7uOQ+62zxnF2JHkEejtJerpYTbFaoduLRgen8KPJya7v2koubXmKQtjinedQTIJgir3jvrcGIC6cfI+pHGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034399; c=relaxed/simple;
	bh=fAulVNlUTMQplVVMke7FfExihU6i3ea+gp84VRoL3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBWHGBnlCadlSh+dMCdHrrccCY5mnbL+Mw6WcIlQjzpVmtW6RB7jPWgraqUFcFbDkPBjLVh0BL58yONvk+dyzQ9lez2AKwPB/Qkn/Gcvlsf6GpdBOwBWkAFoUvFruQpf1raFatYUpqaylO/XkHiaKHqA7lPT9h4FqhVreG+Uhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaLRfd0C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721034395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT0rnoa5JEtEGW9/2VF2BekmihUkTnDpEUSe0xymCOI=;
	b=ZaLRfd0CpZzcs8vmo4nQQDdR4wcQovlGFyDhPnjWBn7/J65VU5gQ/yxNzT3Cl6FOK/L2J1
	iCWMrVbeeobcrZoqwBBRZUQGncSRfRZN3TvrZVC3gO/FAxsE2wR7fwdCFjX3o1wBFx4fKB
	opDP4/viHZRJIUpziE1gFZpQWQN3pWM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-enfOUReFNeiyJGpj7lQbJg-1; Mon, 15 Jul 2024 05:06:34 -0400
X-MC-Unique: enfOUReFNeiyJGpj7lQbJg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3678e549a1eso2092445f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034392; x=1721639192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rT0rnoa5JEtEGW9/2VF2BekmihUkTnDpEUSe0xymCOI=;
        b=W5AjhquqnHuUHl1gmoYOeJhvYgjDXMkpeGKYK4CXIT1Iquon8foi5fiSFgT2BBeE1S
         rXT9THU782y/c4pktWPiVqNz+wXWQMsRvDVZ6HOgQeTR8Mq5R4VEGQGWW8Xm0gBVPaRI
         eaRXRbuRFS/pvffSEZJtwgHlukG/M8hTtAggfrJTzgIBH2OjQNzs5DknB2JrOcmJTBnK
         DS1NGxJf5DpGrHru6Mzo2KVvNlJIGZDPGJRjN3f1YesNKARO/C7787e4FZixq/xsUxwV
         CRmJnarX6nF77lm9rdVklfCrEtIiiFMJySNQj6/6MYRWC0NOFhVqMlufX3SqspHXuiSi
         0O5w==
X-Forwarded-Encrypted: i=1; AJvYcCUod7gcBgtuphq8OFzI0Q9XaLhsLpvIH3Gk/gkh4PqbDojeukT1tT7l7DExtLsLNVcILqtKQTBRwPy+2fUJRKfykUGEpLs5iTGid+IW
X-Gm-Message-State: AOJu0YxqXyqDwT3vcZ5Gh3RVGPHwWBiyJOJxSuUyrhhrM3Weq/IfzWWj
	kTmvH7U1G8273d8Np/eX8udHF1JRwESifs93ULhTpvu/nK6PQpn3G7QI9NXMF5rqMpb8V1KeDuC
	2k/xtRWJJrs9B8j2ydn6EgciSxMsjUVkKrrrPpJSVLgEjpn327naQfe78t8LY+VKtP4YZIQ==
X-Received: by 2002:adf:f84d:0:b0:360:9d2a:fe05 with SMTP id ffacd0b85a97d-36804ea059fmr8251740f8f.13.1721034392595;
        Mon, 15 Jul 2024 02:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYbyF11xi/72ROTi3yPaIErFC1ULcKvqEQllP6vsqOj9AoQ/N/73+4HPYCJnqrcWEK2j91Xw==
X-Received: by 2002:adf:f84d:0:b0:360:9d2a:fe05 with SMTP id ffacd0b85a97d-36804ea059fmr8251704f8f.13.1721034392023;
        Mon, 15 Jul 2024 02:06:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36816758620sm3315051f8f.19.2024.07.15.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:06:31 -0700 (PDT)
Date: Mon, 15 Jul 2024 05:06:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
Message-ID: <20240715050501-mutt-send-email-mst@kernel.org>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>

On Mon, Jul 15, 2024 at 10:26:13AM +0800, Jason Wang wrote:
> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
> >
> > Add an ioctl to transfer file descriptor ownership and pinned memory
> > accounting from one process to another.
> >
> > This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
> > as that would unpin all physical pages, requiring them to be repinned in
> > the new process.  That would cost multiple seconds for large memories, and
> > be incurred during a virtual machine's pause time during live update.
> >
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >  drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
> >  drivers/vhost/vhost.c      | 15 ++++++++++++++
> >  drivers/vhost/vhost.h      |  1 +
> >  include/uapi/linux/vhost.h | 10 ++++++++++
> >  4 files changed, 67 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index b49e5831b3f0..5cf55ca4ec02 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >         return ret;
> >  }
> >
> > +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> > +{
> > +       int r;
> > +       struct vhost_dev *vdev = &v->vdev;
> > +       struct mm_struct *mm_old = vdev->mm;
> > +       struct mm_struct *mm_new = current->mm;
> > +       long pinned_vm = v->pinned_vm;
> > +       unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > +
> > +       if (!mm_old)
> > +               return -EINVAL;
> > +       mmgrab(mm_old);
> > +
> > +       if (!v->vdpa->use_va &&
> > +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
> > +               r = -ENOMEM;
> > +               goto out;
> > +       }
> 
> So this seems to allow an arbitrary process to execute this. Seems to be unsafe.
> 
> I wonder if we need to add some checks here, maybe PID or other stuff
> to only allow the owner process to do this.

Not pid pls.


> > +       r = vhost_vdpa_bind_mm(v, mm_new);
> > +       if (r)
> > +               goto out;
> > +
> > +       r = vhost_dev_new_owner(vdev);
> > +       if (r) {
> > +               vhost_vdpa_bind_mm(v, mm_old);
> > +               goto out;
> > +       }
> > +
> > +       if (!v->vdpa->use_va) {
> > +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> > +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
> > +       }
> > +
> > +out:
> > +       mmdrop(mm_old);
> > +       return r;
> > +}
> > +
> >  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> >                                    void __user *argp)
> >  {
> > @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> >         case VHOST_VDPA_RESUME:
> >                 r = vhost_vdpa_resume(v);
> >                 break;
> > +       case VHOST_NEW_OWNER:
> > +               r = vhost_vdpa_new_owner(v);
> > +               break;
> >         default:
> >                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> >                 if (r == -ENOIOCTLCMD)
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index b60955682474..ab40ae50552f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
> >
> > +/* Caller should have device mutex */
> > +long vhost_dev_new_owner(struct vhost_dev *dev)
> > +{
> > +       if (dev->mm == current->mm)
> > +               return -EBUSY;
> > +
> > +       if (!vhost_dev_has_owner(dev))
> > +               return -EINVAL;
> > +
> > +       vhost_detach_mm(dev);
> > +       vhost_attach_mm(dev);
> 
> This seems to do nothing unless I miss something.
> 
> Thanks


