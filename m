Return-Path: <linux-kernel+bounces-302475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3A95FF29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E19D284A34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CB12B63;
	Tue, 27 Aug 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIvKTRZe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48E372
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725966; cv=none; b=qux7Iv795zMps2sHfLaDY/zcnGesUUyi3tB8VwOB42S4Aga8P72DDRV4zB7fbepq5Os1jaGtqyYpmvMudV/IWIgnQnMZs39ZG0/doQNylRdMSUH/1Xy431D1pAlF3GG1WfSx5E14945dDfif7W9yCCtRgscb4LtDbgImaPGB1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725966; c=relaxed/simple;
	bh=sbJPq9FvX2e6wYSiTp7LDJ/eS//czmssCLWsf4RJfMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7oIv5de/UwcKvqmJOrkQz2zCW1EJpFSjjnElfK63CGCZmVXQUReR0IZy6n4D4AVC05Znvlodzlh9eDkKTX2EuOoDYD2Zd9JfPT1e96p36y2fiQwHskggM/6dnqQ+PbnAiVIPwi9SSB+ccHpf9Qy9xxKPUpTBmUfGBpX60QUcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIvKTRZe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724725963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9y7/wa1MaZmQ/+PLuz5xVB2gQebXbYhMUF4nVUR+irA=;
	b=dIvKTRZeIMpeU/J2f9apTrZz7c8Jzz08FLz29j06waewZ0XjQfWTC9HK+/N3BYRDyBWpfu
	lVm5wfGPrs/pVlRE7pEJ8O5mTAY7yYD4Vq+c2R2YnuwLz3zJK3eTpZSaSUVVDDWeGnbf54
	gYL8jN4yytp8NQVvRuPb7rYkEw62ryo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-BdvuW00lN8SczIN09syP6w-1; Mon, 26 Aug 2024 22:32:41 -0400
X-MC-Unique: BdvuW00lN8SczIN09syP6w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7142fc79985so5500775b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724725960; x=1725330760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y7/wa1MaZmQ/+PLuz5xVB2gQebXbYhMUF4nVUR+irA=;
        b=uOCN5FfqJw1djpEeagqeosa9PHstLOkrFeNKfm1AQiajSxxWrHHDVixaVQIGwOG7af
         Px8rLAORUNH1Z2pSazBaNEpEkmWa72/DMu1TrJL8Dbnbei19E53blJoGse2AroCGUYRy
         G5wY8hB5j1vkG+IVCo6WBYs93jxD0elme3EHTyGvRNG1RVLY9XNBTjar3wOr0hbyRSA+
         EgG6lyVNg2ZVzg0taPgi/X4eMW9u8zp9qrPC9VxpemIfbJjZXZXUB+/ZKIbyg4/2pTgi
         A1anAwNtIs1gA5ZiETvsmiZV/KROs1TYPmUYz6BQSjc40DWVGfxs/b4K6BhfttKm7AHh
         e4QA==
X-Forwarded-Encrypted: i=1; AJvYcCW2O3p01x4Y/yPYb3qE2apf8HiL/VWVZfcNkCQ0DSj777MdIyA8j6kIs6J8jrzmGf1n4ME9dLMnKdWvljQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXLrWXn8u7Pih/Ow9cWf4gnwL8CfZfM7GXak8ji1XZQ8/rf6H
	0/ck6uko5QF8YWkpFkl9VgM1huLNHwQI/KltlFIBkU8NfUHYTKpAaQB7eFV6rfUHXiNoq9pniWr
	X3XN3RYDQcVkGQqS7WbepQVJKW5oGu6nz4/QuLmacBUZdfRnBXGdn13ZiSN43xsUlEsamqHGR/4
	sZDlEGsczmJP32LeMnNyz9K3udnxFMBZ0BjhOr
X-Received: by 2002:a05:6a20:c6c1:b0:1c3:b61c:57cb with SMTP id adf61e73a8af0-1cc8b63e7admr15581330637.53.1724725959985;
        Mon, 26 Aug 2024 19:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0YzDFcuPZUEn/RDzIMIFU0bMwWHEcp2sJbXmCkPl/vxtY4HYrc6Ziaa9VVlyYiEP1DgNDh9tY5fDaUtI7Hg8=
X-Received: by 2002:a05:6a20:c6c1:b0:1c3:b61c:57cb with SMTP id
 adf61e73a8af0-1cc8b63e7admr15581317637.53.1724725959432; Mon, 26 Aug 2024
 19:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:32:26 +0800
Message-ID: <CACGkMEu8y74bffhfPcPGdq1jBVXxaPivXGRh3qe9TdjOQfrp0g@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to support setting the vhost device to
> use kthread mode. The user space application needs to use
> VHOST_SET_USE_KTHREAD to set the mode. This setting must
> be set before VHOST_SET_OWNER is set.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 11 ++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 0a7b2999100f..d6b71bddc272 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2340,14 +2340,23 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       bool kthread;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +       if (ioctl =3D=3D VHOST_SET_USE_KTHREAD) {
> +               if (copy_from_user(&kthread, argp, sizeof(kthread))) {
> +                       r =3D -EFAULT;
> +                       goto done;
> +               }
> +               use_kthread =3D kthread;
> +               goto done;
> +       }
>
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..386fe735da63 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +

Unnecessary changes.

> +#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)

So I think we need to do something the opposite. New flag for new
behaviour instead of new flag for the old one ...

By using this we can unbreak the old applications.

Btw, I think this needs to come before/along with the introduction of
the module parameter that enforce old beahviour.

Thanks


>  #endif

> --
> 2.45.0
>


