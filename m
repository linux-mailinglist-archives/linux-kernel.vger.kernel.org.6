Return-Path: <linux-kernel+bounces-184367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C228CA62C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD72817C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8C11CA9;
	Tue, 21 May 2024 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GygLXg+k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154E8C1A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258677; cv=none; b=q5YxMa3S9ICxhiLISu3+Pur1eSfClg/gwgod21JEq55z80oR+R7rM5dVZNZZc5my0fGyRwbTgSf6qDKaHW0Hfsbn3xP8du2OvZ421am/39zIV/6+q2GBxd5nOguh6rupMDAWtmB1mvfuei8rgWXlGEnmCVXHUCQiBhkrJ4mtoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258677; c=relaxed/simple;
	bh=i7+CWO/0II/UI8CKSRz7fLVDbkwJxrROTMfRJ5aptBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lq/sB8C8GYtAdkfWu7SugDjqh0v9+f6izpgDHg7gjhjFqy3y07p0RHZLsm6IH2HUxuxNT8uCKFEPpkhInhCoRqMRcWIKUKiYALRagaLEJWasuL5yo9i4MkwI74KRRezAogJ8HU/6EdZZvQqTMqLhi1+J8GWiQt4+DIfo4NMvbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GygLXg+k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snWeVoOnPaLJ29g9hTUZ+NC9NK6zSoMxNiCQ357kDKA=;
	b=GygLXg+k8/WwipvEO346YAGgsqUgS8iJuo00D8ZjTH3C9Ubc++JeBGWvenxTEFnFbjOOGI
	XkOs7At3BVVjBzq5ThtkDfXpbsos7yxI9+Nc4AV40hOnhKKquJ+4BRSDad2WQkOEcZJx+Y
	xKlZgcmrRCmi3SUkRCqj70XJJ2gjMlY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-lWIEiPUdOY64BXHhmbNuIw-1; Mon, 20 May 2024 22:31:13 -0400
X-MC-Unique: lWIEiPUdOY64BXHhmbNuIw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2bd72b9d660so1901931a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258671; x=1716863471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snWeVoOnPaLJ29g9hTUZ+NC9NK6zSoMxNiCQ357kDKA=;
        b=JWEg+0cVeoajqDEhXQKQ1cNC2+nmu//58VK5qPNbPwqGrn5u03rxr2+8XZ1PkMidax
         xhPP+kTtmdFCT6UIkjU70dGD1UODqTu3n3kuu4YJSCHhjvY3ibFJCas0KFCTSjmzOD6L
         40cgzRmbvMuUKzfpBfMq1s84zcbuap41N4fuetFqC4+N4spYCx26jYhdirHrzz/b60CC
         vAVEeSYZ2OG3NJg08JmWt4XFVtZl/JE9ILiCLHkGWfsLP+2Hf55uRRjPyJRj/k1Fp4E9
         eUHhsIjutXLYhlfZR8PImqS1lnOWFCs37cXD4HVoXV4UH/XIOc+D7SregH+rb5OhoYiH
         nl5g==
X-Forwarded-Encrypted: i=1; AJvYcCU1HchQ4VWgw8KXNxj+HCZyQifyaKzq6e0lb/egyhyL4qlb+pbxbdj3GJJP2BaTB0wxSj+41G+E9PQ7VygJjpIJWwHZyVQrm2FhL1Ve
X-Gm-Message-State: AOJu0YxaJWGbF4pnaQ5gWS21zwUtUelk4tur5qk+C5y/FJ5OWpStoTEO
	yVHUhZ0NWqzERpmbJbTYzjpsKPPuT5VFn2GLb0x3pxboO4hg17F+ROFPLi40a8GKD3BMtHPo2Ac
	6iSmyfKbfFiE2yBFDmXx5jS8z2zcklXuadgvr2Q1Ex9ylILVmoqQxH4RAjPVEDmKu+3EdSbvEzS
	VC+C5vzMnBxfOrBWh9aWJrdupsFsr+5168SWnBrb6hPsBxbxs=
X-Received: by 2002:a17:90b:3882:b0:2bd:7a9a:658 with SMTP id 98e67ed59e1d1-2bd7a9a3896mr4030733a91.41.1716258671400;
        Mon, 20 May 2024 19:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAwbDe2Uec41b+43t2LmVdBeOsfakB9vtDjODRX2S0bWBrCE8IcUuNeKzeWpGTZXIf0gukWjH8XSFm8luO0vw=
X-Received: by 2002:a17:90b:3882:b0:2bd:7a9a:658 with SMTP id
 98e67ed59e1d1-2bd7a9a3896mr4030716a91.41.1716258671032; Mon, 20 May 2024
 19:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com> <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:30:59 +0800
Message-ID: <CACGkMEtfjHzdBBwgUWgRHDc5opekvgTuXp-_z4ku6L5cqOeAJA@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] vduse: suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
<steven.sistare@oracle.com> wrote:
>
> Support the suspend operation.  There is little to do, except flush to
> guarantee no workers are running when suspend returns.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 73c89701fc9d..7dc46f771f12 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         up_write(&dev->rwsem);
>  }
>
> +static void vduse_flush_work(struct vduse_dev *dev)
> +{
> +       flush_work(&dev->inject);
> +
> +       for (int i =3D 0; i < dev->vq_num; i++) {
> +               struct vduse_virtqueue *vq =3D dev->vqs[i];
> +
> +               flush_work(&vq->inject);
> +               flush_work(&vq->kick);
> +       }
> +}
> +
>  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
>                                 u64 desc_area, u64 driver_area,
>                                 u64 device_area)
> @@ -724,6 +736,17 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa=
)
>         return ret;
>  }
>
> +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       down_write(&dev->rwsem);
> +       vduse_flush_work(dev);
> +       up_write(&dev->rwsem);

Can this forbid the new work to be scheduled?

static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
                                    struct work_struct *irq_work,
                                    int irq_effective_cpu)
{
        int ret =3D -EINVAL;

        down_read(&dev->rwsem);
        if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
                goto unlock;

        ret =3D 0;
        if (irq_effective_cpu =3D=3D IRQ_UNBOUND)
                queue_work(vduse_irq_wq, irq_work);
        else
                queue_work_on(irq_effective_cpu,
                      vduse_irq_bound_wq, irq_work);
unlock:
        up_read(&dev->rwsem);

        return ret;
}

Thanks

> +
> +       return 0;
> +}
> +
>  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> @@ -806,6 +829,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
> +       .suspend                =3D vduse_vdpa_suspend,
>         .set_map                =3D vduse_vdpa_set_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> --
> 2.39.3
>


