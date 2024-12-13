Return-Path: <linux-kernel+bounces-444247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B7D9F034F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7362B283E77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817416C684;
	Fri, 13 Dec 2024 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT8NgZxu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2B15B97D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062240; cv=none; b=QwrYk+JyeNdA9UCy08QjqUakSSajCLpw16WhYnxb5r1rk5uqokYJXO6krcKwf3GfhEyms26rz3Do+QH6Op5RhzyaFZLRz61wQH56QJeCJi/1AyCcuwKpNCEIBvHHEmRzzrxCZdd2Ofhl8yHJPPaxSrNfqUY2b/A7MIYw/ki0NGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062240; c=relaxed/simple;
	bh=FXb7zfdtlFu9GBIjB0tryV1aOvS/z6JwtcsImBQ1aHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9mzedfoFXBCUO3x1tbvsZxgc/OYdK3DwfdBIeaTeWMS1xhTr3ioId4e2Sn0St3WZcxMB0XdWSuD4sjry+uOtmQLtMKvmY4ZeIX3toMtjz/2h4S5fPGjM2KhXCMmPUhnPhjDNSVtP1wYGgHI7iVd7ACbX40yeJX4aiAOSyka3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT8NgZxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734062237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+zQC/AspIICVZze8P03srX8nFk7q1UzX/5YiLdcZN4=;
	b=JT8NgZxuwGRtq68/TvvYQz17FAfEXHOGIA1e/JEzSB9nJIHQtEGjgqCCHt6ybAu3rebWis
	hLpT7YdlZwhRACSxp8MHzNj8ICGpptKH2tnueLy72ZhSf8pZ9cPOdfDiQei4VI4MATnZTR
	Y0vUCEhmjrgCxexs9y/ltX6a/ZFgnUc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-TUbIbr7LPO6tsfMvquK97A-1; Thu, 12 Dec 2024 22:57:16 -0500
X-MC-Unique: TUbIbr7LPO6tsfMvquK97A-1
X-Mimecast-MFC-AGG-ID: TUbIbr7LPO6tsfMvquK97A
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so1301063a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062234; x=1734667034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+zQC/AspIICVZze8P03srX8nFk7q1UzX/5YiLdcZN4=;
        b=javVWNnuW+oH2gowHj2ocrupMP5D9xQreeLBUv/Pv+xkVEFssa3S4xUrHB+uL0h+qt
         TWTJIkFeuEkRWThl0HpjBmooGyE1svQjjzk4Fy1LkIut7Z294KRtUrIhw6qZQt+PXSQA
         ZRPn3YaFob/fbxqTNnJJLLI2WlK9CX20haZ0vxm6BZYH0cPH3eLRE0bgmEtLKXZ5826c
         PpfmQ76NbmABbxo9HE2okVbOZ1RAg4aPD89Ol9qjDwsjHCmFSTkUcriC8Nexcdr+IIly
         OC8PpH86RrMGYB3jWgWICg801ejagyy7wV47leg2voD/BMu37hSktSb9CDuK1hnTSrCR
         glEg==
X-Forwarded-Encrypted: i=1; AJvYcCU5810iXAPTngGI7w/7Hh0mTRvQteUBYyaa6oJYjrpJ3AEGNt8TwGSmPWC93shwkK4X8i9zGMvlE6Kz59Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPf76q5kWus1ofu8sA95lrFEX98s15SsEwrUINk/47sHCjH65U
	IGzMiD0ONeTWIdjnZ9781vv7ia9TB2qSygToPYHqtjehJvArfDBb/34geEA0hqx1iSOU9hWtD5b
	tSG3b/3GssRF0pY8qR2D1elEuVbs4i2PgxoLKQ3TUx1uokVzF8+9CPFXgN/IFtC3dTXG8FFnxRZ
	79RGE4UD1YHYOm9AjhoamTY1rqxgNJQcHJQlyUOaUF3M3e
X-Gm-Gg: ASbGncuT0fUJWjVddiRenioTp9+dGhJX9PSRmeJZjLV8EyYIFUFyu6d452U+52vQK8U
	/xxDDEoEvnyHloQtBwgqZBLK4Iv9p6s9JtgXyhMQ=
X-Received: by 2002:a17:90b:3c02:b0:2ee:5958:86d with SMTP id 98e67ed59e1d1-2f28fb6764amr1931597a91.9.1734062234618;
        Thu, 12 Dec 2024 19:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh3fj/HXPiH/AF6JoMV2Y0Sft32EqIZr/Wg7xCm7BFvcJfN2LWRsNMAdRhZEer22QFkA6gf+Eyi/3v1wqkjoo=
X-Received: by 2002:a17:90b:3c02:b0:2ee:5958:86d with SMTP id
 98e67ed59e1d1-2f28fb6764amr1931573a91.9.1734062234229; Thu, 12 Dec 2024
 19:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209151427.3720026-1-sthotton@marvell.com> <20241209151427.3720026-4-sthotton@marvell.com>
In-Reply-To: <20241209151427.3720026-4-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:57:03 +0800
Message-ID: <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI capability
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added support to read the vendor-specific PCI capability to identify the
> type of device being emulated.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 20 ++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 33 +++++++++++++++++++++++-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
>  3 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> index 2cadb878e679..53b020b019f7 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -8,6 +8,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/vdpa.h>
>  #include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/virtio_crypto.h>
>  #include <uapi/linux/virtio_net.h>
>  #include <uapi/linux/virtio_blk.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -52,6 +53,24 @@ struct octep_vring_info {
>         phys_addr_t notify_pa;
>  };
>
> +enum octep_pci_vndr_cfg_type {
> +       OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
> +       OCTEP_PCI_VNDR_CFG_TYPE_MAX,
> +};
> +
> +struct octep_pci_vndr_data {
> +       struct virtio_pci_vndr_data hdr;
> +       u8 id;
> +       u8 bar;
> +       union {
> +               u64 data;
> +               struct {
> +                       u32 offset;
> +                       u32 length;
> +               };
> +       };
> +};

This seems not to be padded to a multiple of 4 bytes?

Others look good.

Thanks


