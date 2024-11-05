Return-Path: <linux-kernel+bounces-396217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B135E9BC972
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4AF281D20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B671D0784;
	Tue,  5 Nov 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh7amOpD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA01CEAA0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799601; cv=none; b=RJQmitJv1OS6pU/5PdiZMT+OR02SNgU/dRW0tSVF9P4DaJeFsPi/pUqVjH9cId/DowK4R7Xm1bKLbhEMvOt7IN59CmQGyChudlk5M7l7ltv2HuXSE3nH4vx9fG1UB9DJIbb8tEa1Bp9IU8WHi8YHYHtMHkvEGea+iusNsB2Kw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799601; c=relaxed/simple;
	bh=zbV55dwHjJ2kbTTg3MViuRzCwoRMxpq1N/C5N+zK6zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEQqbNQunMxVjwDaEr17PWFb6LBCwK/dekdRyrGXUxVEg+wL8IKccODIxMKGG/Y6jMVFNGR9fCCdnyvJ0uhVhHPeh2aTflhEw7sU4PS4s85lzvpbMNwhH/1HvCat9GNhH3HmmOkKQ4ZY+vXTR9BP/EvzZWMiSltw9DFHhlhefOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh7amOpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwsPPiBOKl8pP2TdmsQrIwR4zMRwzINJIydDBGwl0M=;
	b=Fh7amOpDm4hiVNHB0UFY7bJrvHiztk93bKXPOZKFVVeijMAO1zv6TY62AaeKKsGg4i+oC/
	VNizlOdiT6ktwMB32sU2S45m7qaDXpiukosRaIIlY/EDea63F/ADM8rnHVpdMwPqZ34CO1
	WF7hJl2/IAsh2noKtgJsyzYbu3Sm4PY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-fPIyUUs5ND2TUU44qVhM1Q-1; Tue, 05 Nov 2024 04:39:57 -0500
X-MC-Unique: fPIyUUs5ND2TUU44qVhM1Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2c3338a9dso6820354a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799596; x=1731404396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRwsPPiBOKl8pP2TdmsQrIwR4zMRwzINJIydDBGwl0M=;
        b=H/4ZZpoO1bI5RsUuEIBkB+NMcnwP98gJznUjvLBdLAzAnbdjoJC2f/VRQblv3xhnnv
         sUgKKQxoFu8Aq95H/eArCauLrFJr4T6vSk5B5EG7NuiK0ezHHEkqsoI5OOgfapyDAj8h
         86Vcz0oPzXufxN0HakUqK5guU926IXv/hWmidgjkdVjyGEZf9YuHAW4cq/TCfesTXimK
         TCJB/1T5hJTBxAcP1MRNu3c8uyz9yDcdzDjXpYoiERhSIqVxRPdj71xWMPLamgZUqssR
         s+HbLDmlh8gGrqrzYGslGKivQ+1ZfvxuE5d30iZzbof3pa4POvXmQ72+21TKZ2dDqo6q
         0O4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDBKF8CK0biALLtOy2b04d1x+df7H2gwloBB7bwqsUeG8WpBPE08j+5Z+4nS68R3LW48yQEc8p28EBO+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypyd/suND2VeTqsN2X716wB3Kw/Qxn0fmStLIXpKy+QjYizjSd
	7sZAV5odxDFz43LEAdQX/57YEnN5vEnkVf2XpLAHi2gVEyRIFbLpNbh3TPmHYvTdncC3WhpphBt
	4632Rj+PgoTCFUtBPApHn4YdAEqdIj8HTSQbbzTvtsUAEWAWXtmWupMkg4mde/Nr8ZLCV45cQuY
	ButAeWY5UJ9xW4IFfcGP29T+wib9TXnFJW0YQX
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id 98e67ed59e1d1-2e93c1239b8mr24582869a91.3.1730799596552;
        Tue, 05 Nov 2024 01:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkWs7EprrlFH5lqTZLM7dQHu2gPsz4loSVUjvX2t1vhkBm4E6upLHhA0nfNQI6ZN+O5cxUBaSpekre3l5wCV0=
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id
 98e67ed59e1d1-2e93c1239b8mr24582850a91.3.1730799596044; Tue, 05 Nov 2024
 01:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-8-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:39:44 +0800
Message-ID: <CACGkMEuEyXC7pOfwUTKSSrc-vrGW-v7SucV0qAHDE5Lo-b7zYA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c17dc01febcc..70c793b63905 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       bool inherit_owner;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 if (ctx)
>                         eventfd_ctx_put(ctx);
>                 break;
> +       case VHOST_SET_INHERIT_FROM_OWNER:
> +               /*inherit_owner can only be modified before owner is set*=
/
> +               if (vhost_dev_has_owner(d))
> +                       break;
> +
> +               if (copy_from_user(&inherit_owner, argp,
> +                                  sizeof(inherit_owner))) {
> +                       r =3D -EFAULT;
> +                       break;
> +               }
> +               d->inherit_owner =3D inherit_owner;
> +               break;

Is there any case that we need to switch from owner back to kthread?
If not I would choose a more simplified API that is just
VHOST_INHERIT_OWNER.

>         default:
>                 r =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
>  #endif
> --
> 2.45.0

Thanks

>


