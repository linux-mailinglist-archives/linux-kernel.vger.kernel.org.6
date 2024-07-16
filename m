Return-Path: <linux-kernel+bounces-253363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA64932012
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65571B22E03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694A17C91;
	Tue, 16 Jul 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMix6gBa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998C17556
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107835; cv=none; b=D+P9jbwTrFx9+ihTwJMcBGa48SQ3m6OeTHzgJB286yDdL8UnXrYX/nRI+AA/oTBmB92vskMtA/xcTrwNUYOFbs+iE6DLeoWcH4MuN73BGadobBsP8uOcXt0dAz/oXbxgfe4uv7thWDwLmLJ2TPhErG8fT3xFZu+Jgif0H9+3nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107835; c=relaxed/simple;
	bh=MztzX0AtfKG0vv54p9gj+yksNvKCCq9lQ3ToCgPyir4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4cWbtfUR2tOtQJ5eiWHzOaghKhPeDQpm68dgrVLi0Tizh+HOp2BPlUevlgtPvZO1ajw2CyF2gVzE1KjAseXa/aEOEiZnNwqpK5psw9VpSjxL5eQoc1AIdTUiamobyjgKWWVmytC+5Jk8ajZGC+CswmK1LnFweVxD5FtpC0BAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMix6gBa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721107832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWVxoYotOuZE0adepWrwjW/Gf4iGqle1zZCVIlIH1KA=;
	b=iMix6gBaVl/jbgO4fzjJ22qBTT47hNxzIXRsk5vvihZ9HEskX6h1x7/I+m+gUrYjAEpisG
	eC3UpWjjt43AZiOBF/oC53ayLI5PR4Nk/CAmAb9AK7w7qWOMjh9q2K/OwCWOnGipMova0y
	7Xva1K58RDHXHyPVCNe75/D03jjEH5A=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-WXIPcCaDMzq3FpTq5utJcg-1; Tue, 16 Jul 2024 01:30:30 -0400
X-MC-Unique: WXIPcCaDMzq3FpTq5utJcg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-78e323b3752so948915a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107829; x=1721712629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWVxoYotOuZE0adepWrwjW/Gf4iGqle1zZCVIlIH1KA=;
        b=hU2hOY13hJu3ntkX1YB5oT0wGWNl6CC6aJJ6H13bq9sgf+mPHw8vqbOWIdHG+nlN+G
         sm723OLMD2Si3DkUu2KffzKdhTwoMlRVRAr07SntL4Y3JLBwxbunyCXDltp7uT1TljMv
         TrS0NIMNO7snhxLlvnHmWb7Tovubk2XBye5CnfF+TRRj4nbBfxiie51/DqrRKpvW5hLE
         gwRM+4O8fmiq4/NK6eScNpsyBId51DgJuwWmeYGnB2VdNiyPi03Ns9sSOnn5V9csoRGp
         uezOYQ/1O5SGaTEbt0ztRy+qEPkRgHerg0OsnU76P5lbB/AJW2c+nMElseXWyCpNXd87
         PNRw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ojXtnApd7+v418ffa4NyImSfX9u9r+CnTSLRJFg++V8tZODz63fG5GRIqoaAbD0m1I6b/qhew6NRwwwaZZRnmIU1UMxmDxpJXQ94
X-Gm-Message-State: AOJu0Yw9OZ7iZB+QtOLSRIKUZ9KRGu2jHHgi2L3gdOCJjG8m2Bn88RFX
	XmkfjIyMn+aWUs0BKlhli5laMjjLh9/zJPjTuO7jeGpedS5YYmw6pGdHmwI1GwUKRrHMEu80Qoi
	Se0jxndre1D/Ms+X3AWWkkRb/GK48FT1r1KSdUoUPzEzo+GN/EL3L3mGQ0kiMVsVnU2xbyK4PH0
	ms/c4C0fn+OM2drXTN/cL5k6CRkqhkm0sJbpMe
X-Received: by 2002:a05:6a21:9207:b0:1c3:b2da:cdff with SMTP id adf61e73a8af0-1c3f10ec5a9mr1427749637.0.1721107829142;
        Mon, 15 Jul 2024 22:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE4/IsYi91e+b+a6BuuTQWkanz20Qq9rKT2XEAIkwUc0Z5+zjH7s27Jz8KjgAa5CWQ0wpSwUG31rJrYIKyU/c=
X-Received: by 2002:a05:6a21:9207:b0:1c3:b2da:cdff with SMTP id
 adf61e73a8af0-1c3f10ec5a9mr1427735637.0.1721107828571; Mon, 15 Jul 2024
 22:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com> <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
In-Reply-To: <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jul 2024 13:30:17 +0800
Message-ID: <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:29=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/14/2024 10:14 PM, Jason Wang wrote:
> > On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Live update is a technique wherein an application saves its state, exe=
c's
> >> to an updated version of itself, and restores its state.  Clients of t=
he
> >> application experience a brief suspension of service, on the order of
> >> 100's of milliseconds, but are otherwise unaffected.
> >>
> >> Define and implement interfaces that allow vdpa devices to be preserve=
d
> >> across fork or exec, to support live update for applications such as Q=
EMU.
> >> The device must be suspended during the update, but its DMA mappings a=
re
> >> preserved, so the suspension is brief.
> >>
> >> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> >> accounting from one process to another.
> >>
> >> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> >> VHOST_NEW_OWNER is supported.
> >>
> >> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its user=
land
> >> address in the new process.
> >>
> >> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> >> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> >> require it, because the userland address of each DMA mapping is discar=
ded
> >> after being translated to a physical address.
> >>
> >> Here is a pseudo-code sequence for performing live update, based on
> >> suspend + reset because resume is not yet widely available.  The vdpa =
device
> >> descriptor, fd, remains open across the exec.
> >>
> >>    ioctl(fd, VHOST_VDPA_SUSPEND)
> >>    ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> >
> > I don't understand why we need a reset after suspend, it looks to me
> > the previous suspend became meaningless.
>
> The suspend guarantees completion of in-progress DMA.  At least, that is
> my interpretation of why that is done for live migration in QEMU, which
> also does suspend + reset + re-create.  I am following the live migration
> model.

Yes, but any reason we need a reset after the suspension?

>
> >>    exec
> >>
> >>    ioctl(fd, VHOST_NEW_OWNER)
> >>
> >>    issue ioctls to re-create vrings
> >>
> >>    if VHOST_BACKEND_F_IOTLB_REMAP
> >
> > So the idea is for a device that is using a virtual address, it
> > doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?
>
> Actually the reverse: if the device translates virtual to physical when
> the mappings are created, and discards the virtual, then VHOST_IOTLB_REMA=
P
> is not needed.

Ok.

>
> >>        foreach dma mapping
> >>            write(fd, {VHOST_IOTLB_REMAP, new_addr})
> >>
> >>    ioctl(fd, VHOST_VDPA_SET_STATUS,
> >>              ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
> >
> >  From API level, this seems to be asymmetric as we have suspending but
> > not resuming?
>
> Again, I am just following the path taken by live migration.
> I will be happy to use resume when the devices and QEMU support it.
> The decision to use reset vs resume should not affect the definition
> and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.
>
> - Steve

Thanks


