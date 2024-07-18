Return-Path: <linux-kernel+bounces-255808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35525934569
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5840C1C215D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0D15C9;
	Thu, 18 Jul 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WevXZsmZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAB10F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262804; cv=none; b=aOEE8jrRt0KvEjKAESo7GjYno6z/5aTU7Hp7bFJF4nG+a17ud7/mgASfM63WKj1EEKe8oLhn93GS12sFDwflY4nmVsdwnL4jiu5ppWWMwZk3F24r9m63Za6sXTEB7F1xZiUNw6abZ5fW/zQDXxohz6Ux9D2ImPs4gmK9TWpxSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262804; c=relaxed/simple;
	bh=Rp8c4UkQcNBnTx3QJZMU+cC81PiJjr4tBFbSpiLrR4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPVwG2lRBLX/NNEtEaB28MkiM/YM/kti7TGVd1hgPfkRkH6zl5sPEA0r//p4K0Q+n4Fu/bEPj4bCUhv/cxr44i8K2QczFO8ukglkvjkCSgDn8AaYQo2c9JODry3HPx4QhEjS3VTnO1pFt8q+cCY5IsZzHgp3DhYBVIj1Fq/PsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WevXZsmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721262801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u68wgJ63ryVdre9iF5AoFnGzoJg7HXk9rm5FX/Mq98o=;
	b=WevXZsmZlaHabNK1PuMihJNMdUSZj8LCxX7r/cXM1k96cSANAC2mwIlPP9EmqAQuOskK7n
	qhelNL5fKiVtAzcobBy3+yO0GLksf/tqv66g6oyqA61lTLqJ75wP/d5I2CAcJ8iA/mFAHz
	KsXRothSKiwgFh9VwJyIEII+JSWJUEM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-c2PhZGIsNDu6Q6T9TvRdYg-1; Wed, 17 Jul 2024 20:33:20 -0400
X-MC-Unique: c2PhZGIsNDu6Q6T9TvRdYg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-721d20a0807so243616a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721262799; x=1721867599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u68wgJ63ryVdre9iF5AoFnGzoJg7HXk9rm5FX/Mq98o=;
        b=lxpICMGyNkoJzX65Ww9NebnmngP5jAdrm6UrGbHEgUU8OZ52Yy2beDoI7WDj+ZRimD
         WUQuD+3xEq7tsLdHMcQ7NqvuQo/hx2kWJtE3MxT9RG6OOM7ZdoRbOU2FqWr87PwfNVUN
         hMC7HEjouPbIacTCf5JbMYmrgATErIgRzoX3ssho47bluE3bHlyJQMSMfDC/C19sSVGD
         SP5JaMaQsg/pMm/jdtAk1LkuLYpmJpqx65HRSE1WfIUFc2Fc2IpRwZ0Qie8vP6oLTWdz
         M8bmuM81xBE/06zixUDOaLHhxFRVPWAko3OKMmkvu4tCDXYi3ybSshxISbdtS5RbTtPm
         VyZA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVNKGUpj+2btTDMzigU3ndCYDo9Rt8uXMKlfu5JkkFxBSWhZcTHrCBp/ARJtlv8Kt5zRLdl8HsK6RKNzGWxkgkggMg4QwnT4HKdMp
X-Gm-Message-State: AOJu0YwcsPmN+tQDYcMm3o7sqzvJMyGaQXxNp2iK4+HkFti+9hKk6FYi
	pMvnNoeGZ/RxUmpIpk2JMxMJElQNsRYKREXDdLJK8kF5+Bss04fPlK7ExPZnf8D1hVXqBG1bmVI
	WVp3iMLMx5LLZkbHAtJrquVPZhoyvsq7vQYc/Aq30eVoToZ5qWchRJNcjvqaDxDRHjRHW6fZwWY
	8v/+S5YA+9EQ/thlstL+ac2kTF6ZfqsBURhaXo
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id 98e67ed59e1d1-2cb52927e76mr2869703a91.29.1721262799109;
        Wed, 17 Jul 2024 17:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZO+VU4obCAMlLWVT45xvTrxr3rvTyY+6U4DhssOpvN3TexH/9IeAtdQBJcSbdawQJw1uZ/ZkYQfYlgJK3i/A=
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2cb52927e76mr2869692a91.29.1721262798686; Wed, 17 Jul 2024
 17:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
 <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com> <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
 <bab464f5-a660-4122-886a-c348be3d95fa@oracle.com>
In-Reply-To: <bab464f5-a660-4122-886a-c348be3d95fa@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Jul 2024 08:33:07 +0800
Message-ID: <CACGkMEtpVOqsJMF1LLNOdTG+_1JBKy6yNbn12_nP=Tw0DeAZvQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:29=E2=80=AFAM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/16/2024 1:30 AM, Jason Wang wrote:
> > On Mon, Jul 15, 2024 at 10:29=E2=80=AFPM Steven Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> On 7/14/2024 10:14 PM, Jason Wang wrote:
> >>> On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare=
@oracle.com> wrote:
> >>>>
> >>>> Live update is a technique wherein an application saves its state, e=
xec's
> >>>> to an updated version of itself, and restores its state.  Clients of=
 the
> >>>> application experience a brief suspension of service, on the order o=
f
> >>>> 100's of milliseconds, but are otherwise unaffected.
> >>>>
> >>>> Define and implement interfaces that allow vdpa devices to be preser=
ved
> >>>> across fork or exec, to support live update for applications such as=
 QEMU.
> >>>> The device must be suspended during the update, but its DMA mappings=
 are
> >>>> preserved, so the suspension is brief.
> >>>>
> >>>> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memo=
ry
> >>>> accounting from one process to another.
> >>>>
> >>>> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> >>>> VHOST_NEW_OWNER is supported.
> >>>>
> >>>> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its us=
erland
> >>>> address in the new process.
> >>>>
> >>>> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> >>>> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> >>>> require it, because the userland address of each DMA mapping is disc=
arded
> >>>> after being translated to a physical address.
> >>>>
> >>>> Here is a pseudo-code sequence for performing live update, based on
> >>>> suspend + reset because resume is not yet widely available.  The vdp=
a device
> >>>> descriptor, fd, remains open across the exec.
> >>>>
> >>>>     ioctl(fd, VHOST_VDPA_SUSPEND)
> >>>>     ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> >>>
> >>> I don't understand why we need a reset after suspend, it looks to me
> >>> the previous suspend became meaningless.
> >>
> >> The suspend guarantees completion of in-progress DMA.  At least, that =
is
> >> my interpretation of why that is done for live migration in QEMU, whic=
h
> >> also does suspend + reset + re-create.  I am following the live migrat=
ion
> >> model.
> >
> > Yes, but any reason we need a reset after the suspension?
>
> Probably not.  I found it cleanest to call reset and let new qemu configu=
re the
> device as it always does during startup, rather than altering those code =
paths
> to skip the kernel calls.

If we care about the downtime, I think avoiding a reset should be faster.

> So, consider this to be just one of several possible
> userland algorithms.
>
> - Steve

Thanks

>
> >>>>     exec
> >>>>
> >>>>     ioctl(fd, VHOST_NEW_OWNER)
> >>>>
> >>>>     issue ioctls to re-create vrings
> >>>>
> >>>>     if VHOST_BACKEND_F_IOTLB_REMAP
> >>>
> >>> So the idea is for a device that is using a virtual address, it
> >>> doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?
> >>
> >> Actually the reverse: if the device translates virtual to physical whe=
n
> >> the mappings are created, and discards the virtual, then VHOST_IOTLB_R=
EMAP
> >> is not needed.
> >
> > Ok.
> >
> >>
> >>>>         foreach dma mapping
> >>>>             write(fd, {VHOST_IOTLB_REMAP, new_addr})
> >>>>
> >>>>     ioctl(fd, VHOST_VDPA_SET_STATUS,
> >>>>               ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
> >>>
> >>>   From API level, this seems to be asymmetric as we have suspending b=
ut
> >>> not resuming?
> >>
> >> Again, I am just following the path taken by live migration.
> >> I will be happy to use resume when the devices and QEMU support it.
> >> The decision to use reset vs resume should not affect the definition
> >> and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.
> >>
> >> - Steve
> >
> > Thanks
> >
>


