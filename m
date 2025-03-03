Return-Path: <linux-kernel+bounces-541041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E4A4B7BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1FB3A7F65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA61E32C5;
	Mon,  3 Mar 2025 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALaQEBom"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D6EADC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981157; cv=none; b=mJjQKTJ8IuLbiCbopsU1pZDWk9Y6FX1TJiQ+J6Gih+fxV/4/QKYXCU4Yo5r1FJeXNnXTOEbuN/AzVzk1swZTS5jWw9Lp5Ref4QZG5d8OSOWQy7s8Ft4cCTEt7toffYIz4hp0rXdOVsRkkKw5KShtQ9oyqMZga8gbMl/NYB54ruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981157; c=relaxed/simple;
	bh=gLGOdr0gUHxApp4Lbm9o/HiERNBdmbBhaZlmMFU99LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTVS749bZvbHTm/Vjj+A3DiTxPwWumGhocgNFUIRQ8hiI39o9otKnVPAksz4Vceh1JIACUoPWiN8VbeZT04ecnZGqGOGGkPQ6V66l/v9mDz0S7FZzEXJzGJy1bSAY2VXBxKpVfvgsgbQWh6OVYczn5vW908qdHeA1qGuopahl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALaQEBom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740981154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftdu/1Kbak1I91E2tCsRVJqvNKhfPSzve6d3GLs9Dlw=;
	b=ALaQEBomjdUsIBJgmDN/eyxjBAa9DkNR+ymJzvss9VJ2gTDm+PvcLD/oHBuRpFpuXKpC4T
	baKdagBl6bk5vHFKjzTjHqPaVzvUKCmi0cx2ubqM5VCYtyfctsdQ4UCXPd1TyjgE/VyuTI
	9CbLvLrTmwcxKRUsmNvjBicYVmq4xD8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-9SD7VKIKMAKy_fNC2g8gIw-1; Mon, 03 Mar 2025 00:52:22 -0500
X-MC-Unique: 9SD7VKIKMAKy_fNC2g8gIw-1
X-Mimecast-MFC-AGG-ID: 9SD7VKIKMAKy_fNC2g8gIw_1740981140
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fee4c7ef4dso4650398a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740981139; x=1741585939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ftdu/1Kbak1I91E2tCsRVJqvNKhfPSzve6d3GLs9Dlw=;
        b=VDzDUETdcDpBOQa5jIlxhsMN6agTTzM4k/DcrQX60TGRL0dA5ooYVzbqzegllD86yU
         0nMcuwZC8BD6qgqDssmEmmo+WtD5YWPc4jmRNySOCPDXzqjTyOYFfwOhhpgoxAhyya1o
         Nysmc6GRlj78sB/yRTm1mU5q/8dlgwyuwuEci3kw56lxndi7v8e5v11kW+kwBr5pyeBH
         7rH665mEBecjjAq71nW/+3gPLPIZAqIikzWYUYUMwn1w4ufTcyaD9lnNKYKGRHCVIhk2
         ffjj9J5dAFFXajtx0qXFpImWBHiTgPH9UvJi4OpVw9wUd618vopPwDiG2QVIQvwarJOE
         Mzxg==
X-Forwarded-Encrypted: i=1; AJvYcCV6XW+CYE0HTusOo9p0fdAMpkMPHagRbBF0FSSqNzAll0BVbnhAbcNThkmFTAbOsyk81BPt0F+aRuojPp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5UPz56m2zinZwWQtEw93Eg3iTV5PhYXkjAarGwdOSm0JDuPT
	jAcQ0SOKDTdxOW0fjaHbgVztExT9KDU0jldss+P9jBAiPYyKL2YYOjWee+lHu+y1t+HypnXm9+p
	xiwn8GGQui/kNp1I9huqOfk8r5Tuj4A4OZoICisLGLtA30dBMHvBsjc1XkO321DaGkyICHRg14z
	Hifn3KxJUXQ2Dr9wEE+1tG6rN3fP9K4hJejBmYfzM3RH5BwdQ9NcCn
X-Gm-Gg: ASbGnct/xuukT7G3ljtzSJJyPn0Ix/JQv8rmN/igxysJHvuTcpYpPbAyVDf1uGgwLWl
	Tx/dGghctU5yIxbhvcKdczfZyk4rcP3s2MvaiahpQjG9ZO0BmwEvCEL9WxoXsSAVKQtlLcv/ZLw
	==
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2febabf8577mr18654166a91.29.1740981139235;
        Sun, 02 Mar 2025 21:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhYuZxnpRojNpvlHkuk7NDb2qHnc13DCXse6EtUeiPs2yK5wok7qMMepunLQoYKyM78lF2mK6cW4eqe6uBJnU=
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2febabf8577mr18654149a91.29.1740981138899; Sun, 02 Mar 2025
 21:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-9-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Mar 2025 13:52:06 +0800
X-Gm-Features: AQ5f1JoMEQP4W-edssF3skwLm-BwfJKNJ3aGcD-m4x5KSoAF-9cVDu-CpqhKZBQ
Message-ID: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> is disabled, and any attempt to use it will result in failure.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++++++
>  drivers/vhost/vhost.c | 11 +++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index b455d9ab6f3d..e5b9dcbf31b6 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>           If unsure, say "N".
>
>  endif
> +
> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> +       default n
> +       help
> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> +         userspace applications to modify the thread mode for vhost devi=
ces.
> +
> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `=
n`,
> +          meaning the ioctl is disabled and any operation using this ioc=
tl
> +          will fail.
> +          When the configuration is enabled (y), the ioctl becomes
> +          available, allowing users to set the mode if needed.
> +
> +         If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fb0c7fb43f78..09e5e44dc516 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
>                 u8 inherit_owner;
>                 /*inherit_owner can only be modified before owner is set*=
/
> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 r =3D 0;
>                 goto done;
>         }
> +
> +#else
> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', retu=
rn error */
> +               r =3D -ENOTTY;
> +               goto done;
> +       }
> +#endif
> +
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> --
> 2.45.0

Do we need to change the default value of the inhert_owner? For example:

#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
inherit_owner =3D false;
#else
inherit_onwer =3D true;
#endif

?

Other patches look good to me.

Thanks

>


