Return-Path: <linux-kernel+bounces-302479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4E95FF30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416211F22F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C802EAFA;
	Tue, 27 Aug 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2MsJvS2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BE17597
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726222; cv=none; b=X+gV7riPZdWMTWrd6mG+0SMVG/pQAxd866P7mFTMAaUqtJiE3jb9vK9UpEgklFfLPzhusKH7geDozf2iKa7dDFLkwjQuBtjS3SDwMMG/PeIdBSWrWf22x/rLVcHp3HcwOPzLqmeostiStPaAi8HgPzJpuCLtclxeuqFuL4wsTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726222; c=relaxed/simple;
	bh=2fJ9UoHqXi1PF6ZiD5S5EF2R045y1Znp0QqjZS2yLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GprRbjd1uP8RnNFZ0qhhLcuJfQhV/mHVEe0F5LFmjdR4gvQ5iqu4FDUHVX+D0yiS2jOclJ9CH8+9+qzcUrfMFnpgBQm9gpufb1/ZqedvVMIxN76MYbHn1meOFgWLUngnv4FLM1cawwZVhUG9qKla4hiTT4LfrRI5VMR/3F7oIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2MsJvS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724726219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ5V1VZ6ZfM6F0owIcK94idaQ1AVYwDUarCrXj1TZuE=;
	b=N2MsJvS22Em5Ag4/o/9OCdp0qHildhFzqGkut8UeX9MbRyZpka5ylebCRFuYxEp9yb6Aid
	LdRWvHJ8ZYPSXCpLptO1Mo11nWd7ntuIi3kTlRFBvfFd2QNba7Oxyq4yG0NWEzgNzd1zl8
	HmzWd26QuNSZyS6AellzqpqUlUXtnbM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Z4HlnCCfOhGfPL2m4ydQhw-1; Mon, 26 Aug 2024 22:36:58 -0400
X-MC-Unique: Z4HlnCCfOhGfPL2m4ydQhw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3e42ef677so5070552a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724726217; x=1725331017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ5V1VZ6ZfM6F0owIcK94idaQ1AVYwDUarCrXj1TZuE=;
        b=UFAQHbLXxcacUmpsu3tBTdpMzThZpbkQCCFyM8MF1rNKsZ+hSVHAowuaC01f54I7kx
         m27C5v40re/QW04wyqtuM054vqGWQZaRGd2hsFg9v5ffXQDZiTVAxDhKsm4inqIlVzdf
         0nE2lUQKzH3EYmOocoTK3ADD88FEwAmE05NCVuZxlKWmlXQDhMccefx1pMFKXQIM4m3s
         C5Cfc1t5Cx/crs3ciTdR8HEZ9R9ko55BFLwu/BmT9PdE5xELjiIxDsiSLp08wIQLv4mU
         6R5vwkPFqqU/xFr1h+TqnbUDasoWbLAWtwByuqzJwjM/R8XoQ/E9nTW/LSVcjvYxcfKj
         rW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGMcdc7mJvYn9jqmcNevzTWH1KiqNlv5GHy7oD9kSkZOsF4EBjozRJeJcQpZQR8bncN81inYsDxbG0NiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztA3gTjjbxnaP2cgfUtx8EJ4e9sBT3RG9LBcSBoYkteyI8CF5Q
	ZFiUeqZf0JHUt7z3iGAERxUfkQI9nOYaSVP9BCwA2iDbT7rawvvbFp0DOXkefNejzRPiDCl/R1e
	6Ld5bD2Z4g4ADxkTyMxeZw+RB/HpTYnmGWh1eqdJ7Zpm0IwEfirTDWjLa8EYWj4hKQUuGMiiGUA
	IzMpEYVHbXgyGIIAlqpgTe58KBOyezcaTcEcDd
X-Received: by 2002:a17:90b:4c4c:b0:2d3:cd22:e66f with SMTP id 98e67ed59e1d1-2d646b8f9b9mr10321996a91.9.1724726217127;
        Mon, 26 Aug 2024 19:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWF7r+n5FR6V+WbdMzW70pPdN1pAK9i2g0lgxVgO/2wowduQ/RqmJRGnIlgT1oaJTBJGLKg0fhI0z84OUtQzE=
X-Received: by 2002:a17:90b:4c4c:b0:2d3:cd22:e66f with SMTP id
 98e67ed59e1d1-2d646b8f9b9mr10321979a91.9.1724726216553; Mon, 26 Aug 2024
 19:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:36:43 +0800
Message-ID: <CACGkMEt2O2r7BDLYq0Yus7KP17N_DMUP9OoRMbvqC5V0N6rs7w@mail.gmail.com>
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

Btw, should we enforce this to be called when there's no owner?

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
> +#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)
>  #endif
> --
> 2.45.0
>

Thanks


