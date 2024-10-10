Return-Path: <linux-kernel+bounces-359987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02DA999344
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0277E1C2250B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53B1CDFD8;
	Thu, 10 Oct 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TqNLRW7E"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBC19B3CB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590349; cv=none; b=AaekFrOojOXglYbhpgyfaUJf57FWnAaCfbg7FX9q1vFQsbfauAe15z6r0/aqIEDj/EwLuN9jvc7tEWPpfm0tU0lK584MClrRP0D99zhywy/kee3ZPFnxcmrWXyidZ1aaELiAlLmHeAFjaEUo+nN5+YXpgv5A+fPdJRs3H5HDcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590349; c=relaxed/simple;
	bh=4yvNUNNfw+d1/ZXbpmqfonfdUaOLKiFzU12KeWjdtkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erR76vecLq5ou9OCU4vwX2AUND6XLVPYUw5Oi+MBFhZ5w8N1o/Q9nCC94aIUiNQq0fQptx3VVETymKOhYoznf5A3Cxm7OAt4LlP5NmJZixw+pjM64SyOrl7XC9pZgJscoeqN5WWSFpv3YZ/Sr657dfLtwiwAj0FZbituTkprgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TqNLRW7E; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1094547276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728590347; x=1729195147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/bc0MweznE39rPLaY3R7gQJcW93HabLZwOwmEd7zFU=;
        b=TqNLRW7EbdeYPWpemaDDPYiokr43Lqd1Gog+pDgHn/KgquzqP4P5Ekxy7ufeIGqBty
         LZ+r4ATahDWjfo2G9PL8C0AEBaGok0wROyDcg8gvU7nXNfrHDSSqn0XEONbeI5fZ7Glm
         l9vb1970GaFqyvNzA+/kwC+WWQY4lIEsKIj5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728590347; x=1729195147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/bc0MweznE39rPLaY3R7gQJcW93HabLZwOwmEd7zFU=;
        b=HCQyIjJuRutpJ0Gw52syNazLeqNkbfibwbth9glFpgE5CyV0Ah58EpvqeYpHl0Y8NZ
         enCDJ9ILpEJgn3JNjzFzklz1/sHxbqupUiHeeR/QkXG8NUTCp0E+S6NlQY8Ya94D6ybT
         Nz4po14y8v4RmXyUiJ6m4NWg5KqmZ6bM0H3has2pTG9u6FnD8AhZyP2s/YfMyLtCCbG0
         QyRFfxnZGNv3CkNLN761RAe2T0ZxA7NGSNPoX9vTFzeuLT/GgzJHv1IiaOT0ptpSPewR
         EKYDLEb9y0mX0UOy6OMDx3bfROpZWpRqWz3wmLI4ZD0bmccLVBTxZyTdUzhi6+kyTYI8
         G7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/+fn1vm+C+pqRjciwM/bViz+TogFyxvEl9uvUHlofXkf1W1LcfE56jsFB3lipotKHP62f8vwc3Swt6l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUaKdcQkCnh1sVaWTEdHmLuHVs469meZ7u/Va8Qry/GksAlu2
	ZrSTzcwCa//LS+RrAOYA40LlE3w2bXVtrrx1yGv9VoKMQ6AVZwdY+vxyBSNgwSwcz6x6j03wVGG
	qrCR4OWK/uE9crfPy6ugh7mgayv8oOgE88s4/
X-Google-Smtp-Source: AGHT+IHKdWo0J63T55tb5EKx4BupQmJDilI5bVOOroBGaVlaETEhyAGnkCjAUbgUWNG8Bn6WSbZNfqyk9zmB7YHCnLg=
X-Received: by 2002:a05:6902:2403:b0:e29:552:42a7 with SMTP id
 3f1490d57ef6-e2918379976mr312653276.13.1728590347036; Thu, 10 Oct 2024
 12:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004205053.1068629-1-arnd@kernel.org>
In-Reply-To: <20241004205053.1068629-1-arnd@kernel.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 10 Oct 2024 15:58:56 -0400
Message-ID: <CABQX2QP49-KFTbtDkmR0qt_qFRAmCQ+4O7x3WON5P22S6Of1FQ@mail.gmail.com>
Subject: Re: [PATCH] vmwgfx: allow building with CONFIG_HAS_IOPORT disabled
To: Arnd Bergmann <arnd@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Martin Krastev <martin.krastev@broadcom.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The older version of the vmwgfx driver requires port I/O in order to work=
:
>
> In file included from arch/arm64/include/asm/io.h:298,
>                  from drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:28:
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.h: In function 'vmw_read':
> include/asm-generic/io.h:626:15: error: call to '_outl' declared with att=
ribute error: outl() requires CONFIG_HAS_IOPORT
>   626 | #define _outl _outl
> include/asm-generic/io.h:663:14: note: in expansion of macro '_outl'
>   663 | #define outl _outl
>       |              ^~~~~
> drivers/gpu/drm/vmwgfx/vmwgfx_drv.h:692:17: note: in expansion of macro '=
outl'
>   692 |                 outl(offset, dev_priv->io_start + SVGA_INDEX_PORT=
);
>       |                 ^~~~
>
> Change the version check to hardcode the v3 version and remove the PCI
> ID for v2 in configurations that only support v3.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 2825dd3149ed..dfb4b2ba23c6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -262,7 +262,9 @@ static const struct drm_ioctl_desc vmw_ioctls[] =3D {
>  };
>
>  static const struct pci_device_id vmw_pci_id_list[] =3D {
> +#ifdef CONFIG_HAS_IOPORT
>         { PCI_DEVICE(PCI_VENDOR_ID_VMWARE, VMWGFX_PCI_ID_SVGA2) },
> +#endif
>         { PCI_DEVICE(PCI_VENDOR_ID_VMWARE, VMWGFX_PCI_ID_SVGA3) },
>         { }
>  };
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.h
> index 3f4719b3c268..a2fda4d43b4e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -655,8 +655,11 @@ static inline struct vmw_fpriv *vmw_fpriv(struct drm=
_file *file_priv)
>  /*
>   * SVGA v3 has mmio register access and lacks fifo cmds
>   */
> -static inline bool vmw_is_svga_v3(const struct vmw_private *dev)
> +static __always_inline bool vmw_is_svga_v3(const struct vmw_private *dev=
)
>  {
> +       if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> +               return true;
> +
>         return dev->pci_id =3D=3D VMWGFX_PCI_ID_SVGA3;
>  }
>
> --
> 2.39.2
>

Thanks! Looks good. Would you like me to push this through drm-misc-fixes?

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

