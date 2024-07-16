Return-Path: <linux-kernel+bounces-253360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1E93200C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C983A1F22CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D815179AE;
	Tue, 16 Jul 2024 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1gkVa41"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1BE552
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107743; cv=none; b=Oa6KSLGW8jMJTx2yeK8BVi8uHAslcYr8ZZVwho5S78ZVQpCSr9Uw2JLFlqQ8/6iH50Ci/SN8svAnKw7wszA4Y+DYbpy2QztHdUxflAchqNJkPF437McHLNxHk7y6BdHhSTsQ52HdfoB/4BuWvC8ix6oPmP5nj2GNZEckLrDe0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107743; c=relaxed/simple;
	bh=MXVC+nb+mFTLSbcgUCk86uGQXs06nd5Go8mt3o5mB8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF7oOojg8SgP0V0eVPvAlmvKvzyRPAcGXfmUQr4JvKfyLGp7nOG1kJRTR/az1HGDsn1TMtTThbr8MSKgnnNS0MNjPrHTEf8b6N8Emh/g563VmsVb0Tto7q8dcr0E5MXC0i3frBs3nm5pX4hcwiib6kDwqB32ZXrGYcB2JNOHmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1gkVa41; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721107740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsIOpb9KWrrSWH+khCy+irTM/PEKQIZUWtlNy0wC+B4=;
	b=I1gkVa41RiWkKOT9DGN60G+u+06aLfUEzEa+68R5yKYXlupzRGbHp/Y0CQWIsJS4LyarCL
	UBPpJYQg1BdrenRvKLYssBDw4nxtWAIW9kGISfcigDgl7hpCnV+SsGd6GGy3JZtYlqhNNX
	vIZbdPBW5KaMRh6Fr/ehkoi8Z66SvIo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-QD3OsX9HM_2TRUfLrJ9ZIg-1; Tue, 16 Jul 2024 01:28:58 -0400
X-MC-Unique: QD3OsX9HM_2TRUfLrJ9ZIg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7926d869756so1559275a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721107735; x=1721712535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsIOpb9KWrrSWH+khCy+irTM/PEKQIZUWtlNy0wC+B4=;
        b=NZEGH+FegitEg3mYWVc62SMY0Z6ufPtLtCGkghGbU+t8bSj1i6rZl2srdhVMLnTpIe
         s984gHR5AGbbrwKjCJWWIuBZlT/2+koWg5uv0Yi57ruf3M+a/TySAA62VmHtAPB1sXjo
         hxv7l+KDKl7Ls5+ea/exOdD7wJL5AKFeLI/qaY88FlZ0fkXA9nQYAd534ztpWchjd5el
         T5dSpwbGdHKAB+qe113XcqgFKF+bG9pzV1s5U7x2kEKVuV8p/o+fI4IRitFzyovYjneT
         9yS4rC98n1k9uELDpIJsWEYCOHfrRcqC8p3D+ib88EgFJKpaJFR11dLcUnB+jwHMobtA
         7Upw==
X-Forwarded-Encrypted: i=1; AJvYcCUuLFyYzYliX8jy8VwgOWNPvPhPlAT6k5Sk4zbq0kGctEIcKn4rYkZg7Aj4NQDNrK+trJ3CZiFWNpFB7oo7HkZaa90MX0DmqsWAGRh7
X-Gm-Message-State: AOJu0YweE6naV/vMccz49EPRd/JPw7fzlz9oYxHG97tzVhMp5pDuTehT
	m01kEPHg7ceNEasJknG/tnfhSU7rdhYtgrZA4ITNGqSVwSEZj+d35VF3TbVbVp+uxUWwp/E9H+i
	73bWsZmRst8Xihvxk3xQNrdsgsPvcrOBOP6Au0/oQgEYSNcoIQ1aDGhuPhHfk/Lxs7SDb281fwK
	qWF66wLO/NRODg+9hrow8yL/piKBzyRioEbwffE/RO4m3OHuY=
X-Received: by 2002:a05:6a20:3946:b0:1c3:7405:80d0 with SMTP id adf61e73a8af0-1c3f1211cfdmr1304610637.18.1721107735514;
        Mon, 15 Jul 2024 22:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw0k4wnJZ6JiyMBimDNiLpa7AGdMM0EuO2N/PMl66auR/7kGFYq4Rv8muHy8OJ4V1I5y5HjebZFkoXdDsb9P8=
X-Received: by 2002:a05:6a20:3946:b0:1c3:7405:80d0 with SMTP id
 adf61e73a8af0-1c3f1211cfdmr1304572637.18.1721107734712; Mon, 15 Jul 2024
 22:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com> <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
In-Reply-To: <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jul 2024 13:28:43 +0800
Message-ID: <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:28=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 7/14/2024 10:34 PM, Jason Wang wrote:
> > On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> When device ownership is passed to a new process via VHOST_NEW_OWNER,
> >> some devices need to know the new userland addresses of the dma mappin=
gs.
> >> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uadd=
r
> >> of a mapping.  The new uaddr must address the same memory object as
> >> originally mapped.
> >>
> >> The user must suspend the device before the old address is invalidated=
,
> >> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
> >> requirement is not enforced by the API.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vhost/vdpa.c             | 58 ++++++++++++++++++++++++++++++=
++
> >>   include/uapi/linux/vhost_types.h | 11 +++++-
> >>   2 files changed, 68 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index 4396fe1a90c4..51f71c45c4a9 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -1257,6 +1257,61 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa =
*v,
> >>
> >>   }
> >>
> >> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
> >> +                                         struct vhost_iotlb *iotlb,
> >> +                                         struct vhost_iotlb_msg *msg)
> >> +{
> >> +       struct vdpa_device *vdpa =3D v->vdpa;
> >> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> >> +       u32 asid =3D iotlb_to_asid(iotlb);
> >> +       u64 start =3D msg->iova;
> >> +       u64 last =3D start + msg->size - 1;
> >> +       struct vhost_iotlb_map *map;
> >> +       int r =3D 0;
> >> +
> >> +       if (msg->perm || !msg->size)
> >> +               return -EINVAL;
> >> +
> >> +       map =3D vhost_iotlb_itree_first(iotlb, start, last);
> >> +       if (!map)
> >> +               return -ENOENT;
> >> +
> >> +       if (map->start !=3D start || map->last !=3D last)
> >> +               return -EINVAL;
> >
> > I had a question here, if a buggy user space that:
> >
> > 1) forget to update some of the mappings
> > 2) address is wrong
> > 3) other cases.
> >
> > Does this mean the device can DMA to the previous owner?
>
> Yes, but only to the mappings which were already pinned for DMA for this
> device, and the old owner is giving the new owner permission to DMA to th=
at
> memory even without bugs.
>
> > If yes, does
> > this have security implications?
>
> No.  The previous owner has given the new owner permission to take over. =
 They
> trust each other completely. In the live update case, they are the same; =
the new
> owner is the old owner reincarnated.

I understand the processes may trust each other but I meant the kernel
may not trust those processes.

For example:

1) old owner pass fd to new owner which is another process
2) the new owner do VHOST_NEW_OWNER
3) new owner doesn't do remap correctly

There's no way for the old owner to remove/unpin the mappings as we
have the owner check in IOTLB_UPDATE. Looks like a potential way for
DOS.

Thanks

>
> - Steve
>
> >> +
> >> +       /*
> >> +        * The current implementation does not support the platform io=
mmu
> >> +        * with use_va.  And if !use_va, remap is not necessary.
> >> +        */
> >> +       if (!ops->set_map && !ops->dma_map)
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * The current implementation supports set_map but not dma_map=
.
> >> +        */
> >> +       if (!ops->set_map)
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * Do not verify that the new size@uaddr points to the same ph=
ysical
> >> +        * pages as the old size@uaddr, because that would take time O=
(npages),
> >> +        * and would increase guest down time during live update.  If =
the app
> >> +        * is buggy and they differ, then the app may corrupt its own =
memory,
> >> +        * but no one else's.
> >> +        */
> >> +
> >> +       /*
> >> +        * Batch will finish later in BATCH_END by calling set_map for=
 the new
> >> +        * addresses collected here.  Non-batch must do it now.
> >> +        */
> >> +       if (!v->in_batch)
> >> +               r =3D ops->set_map(vdpa, asid, iotlb);
> >> +       if (!r)
> >> +               map->addr =3D msg->uaddr;
> >> +
> >> +       return r;
> >> +}
> >> +
> >>   static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> >>                                             struct vhost_iotlb *iotlb,
> >>                                             struct vhost_iotlb_msg *ms=
g)
> >> @@ -1336,6 +1391,9 @@ static int vhost_vdpa_process_iotlb_msg(struct v=
host_dev *dev, u32 asid,
> >>                          ops->set_map(vdpa, asid, iotlb);
> >>                  v->in_batch =3D false;
> >>                  break;
> >> +       case VHOST_IOTLB_REMAP:
> >> +               r =3D vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
> >> +               break;
> >>          default:
> >>                  r =3D -EINVAL;
> >>                  break;
> >> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vho=
st_types.h
> >> index 9177843951e9..35908315ff55 100644
> >> --- a/include/uapi/linux/vhost_types.h
> >> +++ b/include/uapi/linux/vhost_types.h
> >> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
> >>   /*
> >>    * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
> >>    * multiple mappings in one go: beginning with
> >> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
> >> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REM=
AP or
> >>    * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_EN=
D.
> >>    * When one of these two values is used as the message type, the res=
t
> >>    * of the fields in the message are ignored. There's no guarantee th=
at
> >> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
> >>    */
> >>   #define VHOST_IOTLB_BATCH_BEGIN    5
> >>   #define VHOST_IOTLB_BATCH_END      6
> >> +
> >> +/*
> >> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping a=
t iova.
> >> + * The new uaddr must address the same memory object as originally ma=
pped.
> >> + * Failure to do so will result in user memory corruption and/or devi=
ce
> >> + * misbehavior.  iova and size must match the arguments used to creat=
e the
> >> + * an existing mapping.  Protection is not changed, and perm must be =
0.
> >> + */
> >> +#define VHOST_IOTLB_REMAP          7
> >>          __u8 type;
> >>   };
> >
> > Thanks
> >
> >>
> >> --
> >> 2.39.3
> >>
> >
>


