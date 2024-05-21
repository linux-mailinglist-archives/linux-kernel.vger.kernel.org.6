Return-Path: <linux-kernel+bounces-184369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50468CA632
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E10B2202D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A710A1A;
	Tue, 21 May 2024 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga2oW15x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7628FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258769; cv=none; b=J3jzT4o1VtBaY/NAayEJMCINPttttIPmS0tc4YbP9Yfei0gmJ/Rw5mQ8OZImnJ35jKvQqKOFu+TrZPV5s8RIbvZ2ZW5g7m9fS9XC9iK4wTbfrPKXCEbmavTglKFrdzIjA+sDFq0kpzU/H7QqtH/oJFg6SEKLtBuIQg5g5Prh/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258769; c=relaxed/simple;
	bh=dhRjjEcWzIW5IuAVkeI6OtRR/mPN6j0nB2JMIXUDHl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oinufGOVI48I3dpeD+zySNQRDfsVnFMYMstGDLhShxfHrGS2o21XUNn3tZr1uLKgxCjcS0ObAcwHVmsuMf2V2bfaqqR8J7p1VPM45jxgIz/MIB8oa9mzTe/+svq1bKH7SiTIAdY8bxZLnIv8RiHNDr1H/dwn17KWnr5YBSCGj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ga2oW15x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZYyiqrniwdjP/E0uFE4XEuFX95Nzf5hidJoaA2dd3w=;
	b=Ga2oW15xQNDZ+hEQdmA6xbqC9HsHBY/L50TuZpeZxrYpkJEcRpExq4s3gb9WnqinHkY+Q5
	LsNG4f9RWSE7u/RmWqiq4SXIiSqf2qDSEe56O781x8WoEXNgsGp8c4g5cnmWoMXlPc3yWI
	MIaiVwx4BkkZWeII75CJugpu9p3HEhk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9D7yW5OcMoGn9qHZfjfQiQ-1; Mon, 20 May 2024 22:32:44 -0400
X-MC-Unique: 9D7yW5OcMoGn9qHZfjfQiQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c65e666609so11317885a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258764; x=1716863564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZYyiqrniwdjP/E0uFE4XEuFX95Nzf5hidJoaA2dd3w=;
        b=LDp69BRwx+AKYOdr/B6i7tJpt7iebUMZjhr5XEwKwe3TYNxYz/RVGD5xdODTRxoVYO
         2OuLE/MLTY2zq+JZ6spTpXP6zD7bEkPEx+e6zRrFgSjsA1ozl7nffbLkK74gLnSgtF8V
         yTHWvO7UPjjJeF+hbBQkl55MJWXCEnAOyp9E2bhIpYlgXg021npFJpICbJ//3HLVR4S3
         KmNTK3V9+Qxy3oXhFLL9Ek9N0Gl9hEVW2NtlmOumwf4fdrEuKTnoxoSl2qtYgk9o1Z4m
         UwPwpK+ftO7zrsZVfyScJiSANNzC2yn1E8kW8/mKokjNq2Lw3ke6VTIB/xfWpFKVnoz8
         6MmA==
X-Forwarded-Encrypted: i=1; AJvYcCUOfSykYtYvtRgKkw0T59ESWB7zIaU8P7VCzSdBE+dWMdmOiiZohNYbDXW6nyiua4CwBCnQ0USFhCqhLXT0nPq+GtwC8/mVHFqiKGOe
X-Gm-Message-State: AOJu0Yyva9Sc61c6wJyc2dCMg6GoojQLuqL6yowjPmFEQW/Zc/qlvgrY
	gDqryVxFYhxY37fS5B2251qGz4LX+1xvpxAxSvxGNv6ffz/N4kfXFut76oGboRQBGaU+cSD2lNn
	77qT1ZIu2efuazygpL2UffY/GKG4my9yiipcbGKM+39Vgm/w4QZz+1eof4fFrbCpFM3AvtGUHuh
	ei2GYu4fyethCsTS1rWPn1JBHHFrR8pT37tjp2
X-Received: by 2002:a05:6a20:9195:b0:1a3:b155:1cd2 with SMTP id adf61e73a8af0-1afde0a9c56mr36384181637.10.1716258763754;
        Mon, 20 May 2024 19:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr2sWk1bvHi3YU4qBFQlqFEE+X7oAHBNjrFbrHBEoUDoyA4HuyxRx/H6KHE2tjsD8R1nCScvMy8Rvhc1xYJy0=
X-Received: by 2002:a05:6a20:9195:b0:1a3:b155:1cd2 with SMTP id
 adf61e73a8af0-1afde0a9c56mr36384160637.10.1716258763309; Mon, 20 May 2024
 19:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com> <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:32:32 +0800
Message-ID: <CACGkMEur=CoU1GgxNdweu-SfuutSN-a+LaHLkdtoWYJMnE+LOg@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
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
> Flush to guarantee no workers are running when suspend returns.
> Add a lock to enforce ordering between clearing running, flushing,
> and posting new work in vdpasim_kick_vq.  It must be a spin lock
> because vdpasim_kick_vq may be reached va eventfd_write.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 8ffea8430f95..67ed49d95bf0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device *vd=
pa, u16 idx)
>                 return VDPASIM_QUEUE_MAX;
>  }
>
> -static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> +static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
>  {
>         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> @@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa=
, u16 idx)
>                 vdpasim_schedule_work(vdpasim);
>  }
>
> +static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> +
> +       spin_lock(&vdpasim->kick_lock);
> +       vdpasim_do_kick_vq(vdpa, idx);
> +       spin_unlock(&vdpasim->kick_lock);
> +}
> +
>  static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
>                               struct vdpa_callback *cb)
>  {
> @@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>
>         mutex_lock(&vdpasim->mutex);
> +       spin_lock(&vdpasim->kick_lock);
>         vdpasim->running =3D false;
> +       spin_unlock(&vdpasim->kick_lock);
>         mutex_unlock(&vdpasim->mutex);
> +       kthread_flush_work(&vdpasim->work);
>
>         return 0;
>  }
> @@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>         if (vdpasim->pending_kick) {
>                 /* Process pending descriptors */
>                 for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
> -                       vdpasim_kick_vq(vdpa, i);
> +                       vdpasim_do_kick_vq(vdpa, i);
>
>                 vdpasim->pending_kick =3D false;
>         }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdp=
a_sim.h
> index bb137e479763..5eb6ca9c5ec5 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -75,6 +75,7 @@ struct vdpasim {
>         bool pending_kick;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
> +       spinlock_t kick_lock;

It looks to me this is not initialized?

Thanks

>  };
>
>  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> --
> 2.39.3
>


