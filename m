Return-Path: <linux-kernel+bounces-565232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F111A66433
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B905189DB36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B79155C83;
	Tue, 18 Mar 2025 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO52kE7+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8A57C93
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258949; cv=none; b=GlwH+GJz6tDtWupJVn+l+fJm3LzsuJVEl99+xjfxbxQt7poDemJDxOpyrBrzNSMj6BT/ai7UALxi3xsO+VytIJ/xecgFb3vCeCc2jykt4Gxb74RLiJ56mukF813KbBbG/veK1+WTBSyrroicaaSRch0LTlvks43lhEhJJGuoqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258949; c=relaxed/simple;
	bh=2GbqXqnbS5Gg8/qIgu8A5aL+NFbKddcn9ze7u+q6+yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjdSOK/r5DAv4vpnvMxJ1dc6CB+iqL3Kw71EzzAU34t5OgCUlq+gw2IiZ7LRKBcWIBIHOrSHUp8ocdhdZOTDogUI8KkD55oojFw4w12ARkkMLtIVrpJxhNSskzgBsUdqBfbA+T400fKiRTRzYNHle5FC1sxpC2woFXsqxE5YLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PO52kE7+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1wTYqcCo1fX2H4Rx0UpSTErsXiY/CdMyhzV1Dxv2kU=;
	b=PO52kE7+eEpBsBB8QmskixZLdLhrc4WpE8CQpYwDlde54udsBBp/pFwgj9Bt0JeswE+KW3
	PSjZnqfoZMB1kzsBI0p2wEnj99dspt/IBB/cUKI8g4E4tMlTzzp8YwTmjd89LtPWX2P9F6
	29resbTM0AJAL3ayAb/hmCC0gL4jzxQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-AtBO8iAEPzGKA_9JlN7vcw-1; Mon, 17 Mar 2025 20:49:04 -0400
X-MC-Unique: AtBO8iAEPzGKA_9JlN7vcw-1
X-Mimecast-MFC-AGG-ID: AtBO8iAEPzGKA_9JlN7vcw_1742258944
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3011bee1751so4067605a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258944; x=1742863744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1wTYqcCo1fX2H4Rx0UpSTErsXiY/CdMyhzV1Dxv2kU=;
        b=FmqmD0t5SOFNiZq1Lqoqd6w6amsQJKtc8cpLwCowGZ6GDd7BwJnnak+cl3vTjxjgZq
         IL/wHEufriAM+FU0box3CqgEO2Td0eE9kH63OGaLZyecFq4+wsHH5Q2Dba9Q7uOmgyDs
         PlgmfKjBz8R5QoTXN/+vyo7qDYU3j+TXUipqqTWapG1GPwqTr3UBgYNeJ44fPDn9Ltrc
         I1QEEkCHeYsnYZm+ZZsdWOTbHvLg848QC6BX/ncsJApiTw5HK8uhwTNuUyndpWfiSEBk
         D9Gy+xbpUI8pREQngd/vgs6ayvVRlIuJErxgwZH2124sHZqjlo7Du9cI1vyfCUuzdn5r
         jutw==
X-Forwarded-Encrypted: i=1; AJvYcCXq6wzZAcQJv7g1sX9Gh7i5Bk7RDQWjpTubhDoeCqtcCxCcT+uxpOm+Km4dDCeGmVw+3qbBs0D4mWoxrZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXJzlm2CbOXt1lAklKKRZpfT4VelxkQGtfAPlxCfe36anJkrJ
	NNYwPTz8Anw5VA2NnUWDNiVgDXqNuOI8sbTG2PxeSkvTwOBJA+Q/De2VURbk1JrAPWqV/ZGpjFv
	xxcJBXSMdIetehYrkuqSfrqZE4RHTNU2Wf1S0/1ythhEGYoN728dje4Azrv9++waBIl5/ck1mq+
	ffqBBlqR8t8l4xBJrFU6phXW36Bgl/JYvIJZak
X-Gm-Gg: ASbGncuJI2SvPB+M2h5/uGYdfZWvH6sIo34tEohWvm5ICoZGSfppHIQY8FOhDHBsjMn
	vci2MpfDiSCzCoSoszGMQCmrgFUGCZO8kC4wori3275u4IHVbWphM0Q0FkgEflOlIARxIMw==
X-Received: by 2002:a17:90b:4ac9:b0:2ff:7ad4:77b1 with SMTP id 98e67ed59e1d1-301a5b02909mr460973a91.2.1742258943944;
        Mon, 17 Mar 2025 17:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX+O7xUMVOLYXNcB0tMwzNzV42Bp5ZfdlbP7y8y9JbwXKmUX7+sFNpCUYyl3mQ2HUBXmQZCW6q/VS+oPLI/5g=
X-Received: by 2002:a17:90b:4ac9:b0:2ff:7ad4:77b1 with SMTP id
 98e67ed59e1d1-301a5b02909mr460946a91.2.1742258943615; Mon, 17 Mar 2025
 17:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-4-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-4-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:48:51 +0800
X-Gm-Features: AQ5f1JrJY7aJ8s6QNMasECLw6cRwuthV2ZgIcitKqlIwb3XaZrdvCSNgD8tZbAw
Message-ID: <CACGkMEsG4eR3dErdSKsLxQgDqBV55NUyf=Lo-UUVj1tqQ-T8QA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] vhost-scsi: Fix vhost_scsi_send_status()
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:52=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Although the support of VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 was
> signaled by the commit 664ed90e621c ("vhost/scsi: Set
> VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 feature bits"),
> vhost_scsi_send_bad_target() still assumes the response in a single
> descriptor.
>
> Similar issue in vhost_scsi_send_bad_target() has been fixed in previous
> commit.
>
> Fixes: 3ca51662f818 ("vhost-scsi: Add better resource allocation failure =
handling")

And

6dd88fd59da84631b5fe5c8176931c38cfa3b265 ("vhost-scsi: unbreak any
layout for response")

> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - New patch to fix vhost_scsi_send_status().
>
>  drivers/vhost/scsi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 59d907b94c5e..26bcf3a7f70c 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -999,18 +999,22 @@ static void vhost_scsi_target_queue_cmd(struct vhos=
t_scsi_nexus *nexus,
>
>  static void
>  vhost_scsi_send_status(struct vhost_scsi *vs, struct vhost_virtqueue *vq=
,
> -                      int head, unsigned int out, u8 status)
> +                      struct vhost_scsi_ctx *vc, u8 status)
>  {
> -       struct virtio_scsi_cmd_resp __user *resp;
>         struct virtio_scsi_cmd_resp rsp;
> +       struct iov_iter iov_iter;
>         int ret;
>
>         memset(&rsp, 0, sizeof(rsp));
>         rsp.status =3D status;
> -       resp =3D vq->iov[out].iov_base;
> -       ret =3D __copy_to_user(resp, &rsp, sizeof(rsp));
> -       if (!ret)
> -               vhost_add_used_and_signal(&vs->dev, vq, head, 0);
> +
> +       iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[vc->out], vc->in,
> +                     sizeof(rsp));
> +
> +       ret =3D copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
> +
> +       if (likely(ret =3D=3D sizeof(rsp)))
> +               vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
>         else
>                 pr_err("Faulted on virtio_scsi_cmd_resp\n");
>  }
> @@ -1420,7 +1424,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct =
vhost_virtqueue *vq)
>                 else if (ret =3D=3D -EIO)
>                         vhost_scsi_send_bad_target(vs, vq, &vc, TYPE_IO_C=
MD);
>                 else if (ret =3D=3D -ENOMEM)
> -                       vhost_scsi_send_status(vs, vq, vc.head, vc.out,
> +                       vhost_scsi_send_status(vs, vq, &vc,
>                                                SAM_STAT_TASK_SET_FULL);
>         } while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
>  out:
> --
> 2.39.3
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


