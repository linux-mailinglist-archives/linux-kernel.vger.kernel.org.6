Return-Path: <linux-kernel+bounces-434256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04519E640B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE1E28454F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6FB167DB7;
	Fri,  6 Dec 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEY6M3Cw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DD14A4F9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451681; cv=none; b=gzZczoaMxicIWUXui+SS5L1xYaqr5IN62xd8S+kS2BQULAY5gXrpY+ill39M/AomUZXW4SH4BFfjRui7PRu3doYKwKqEcmhyJ3KTL2m5Gk0LpVdAuXoe1gxmhlPGT9BF3u4ZPGGgSaGNEZam9Ez7EoSr3PgSA/i+Tq+XgcbNMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451681; c=relaxed/simple;
	bh=vLk2hzOOvDlMEBh2Gzo2cdgEyGdDlfjKgTthl08JpAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxokD3vv0ZJcSss/VchSspYzyjlsbQzv1bByd26i2fuPDfhNHt4Yuw9NUP8SWQ1pX8APZAShWWHoTdYXN8w5s7R2HmYUJsm9r1haTPI/HDA79AFOPO/mv8hbCSfyrPlp+gXdG260wte3LfXCIkiJmsd10FSMpTq4Gr2Rn6RwXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEY6M3Cw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pboZ3VnmcTTj8kP2f77So4+NcnFeGWKwtfiLi6aYhnU=;
	b=dEY6M3CwTimFsbzcoTjlIeGDjXdw1XAY5MYTqbKe8WBE6HlT/v5PB4DQaNBAxCjVu915NP
	uw7Ti1ArdBpuWf7T7kTjbygxZKbNX48c8Jnim58+XOqKvBdSIbHPxg4ULyUdxJnrSbjrh0
	wQ43pgRwzZAYs3CgzvREyfdrac4VmGQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-CtmztgQSNB-dZuf8TWecAQ-1; Thu, 05 Dec 2024 21:21:18 -0500
X-MC-Unique: CtmztgQSNB-dZuf8TWecAQ-1
X-Mimecast-MFC-AGG-ID: CtmztgQSNB-dZuf8TWecAQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so1556553a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733451677; x=1734056477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pboZ3VnmcTTj8kP2f77So4+NcnFeGWKwtfiLi6aYhnU=;
        b=FNrpvT2OmuluuujFUw830L9fp4A5yUF04rg4nAXr/0ILQmbAUglE7bxVq2iBRK7Se7
         PlDIQ5IcWZoeiJ+aqctaqZLsmF3hLza79LAlSX6OJsdcuFSOSPiTHTvRDzusS6ARPwfY
         F6tTSkeDKzOLVgrb3xJXrbk48C6Z2t3+5FCeWtYzPS458dwKqZYYW+cAvChuZ3kmju6z
         +YlkK34wot3rwx5kf8pwIY5ebkSd26mfB8UkZx8CTM99aVinXz6NuIQfr/kf9JHIGrdO
         HWqNkwVsCvffBcKISnxtioQfuoqYwVkQH8ssYYSYCAbLewyHJLaawZnwnnYJxOyVg8IY
         tW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy85GEEyr2LrcgN0DeQQmTQvhjF9gbKm1mBNeevVDpirEl8iCAgDgp2DnDB8G3ULkGL/u6pppVoGJUDvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBw3a1RnuoX/qN5QzOGyMK+LZqXRj7SJCYMnGxclQcsJECqARg
	73rejkDlhK8Ngnvwm6ZR3Vm8z+bSOigJh2lzfDfcz0mpM50KC4SVVjIXtwO+HF5yyXKM9vM+2t4
	F+LJDSStmfYylin6+Uq5SOruY+zD1//D3TdiIGBhY0KcwUFVv51UhIAYBd2U1PRtW8QGkM+i1n9
	bwIH5iKM5SBGEjZVW258SQzBvecBKSE/lqxcum
X-Gm-Gg: ASbGncv1W07E9yBAr2dDDnfRU/sZOd5afm7vRRyiMp/HdjqdSiBy1cMZdQsF9FG5woD
	lDSvTux6m3ORr9NebmDp4NovMkBYUUE4blg==
X-Received: by 2002:a17:90b:2685:b0:2ee:a76a:820 with SMTP id 98e67ed59e1d1-2ef6a6bd306mr2214630a91.18.1733451676820;
        Thu, 05 Dec 2024 18:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH1dl+mby1r2n+lqlFAVV9PyOHv14lvCGqbyM5ufLkebaJNAcXZtoHC509zXOU/tKgOZdkjx6jxpTQ+/2YkYE=
X-Received: by 2002:a17:90b:2685:b0:2ee:a76a:820 with SMTP id
 98e67ed59e1d1-2ef6a6bd306mr2214594a91.18.1733451676402; Thu, 05 Dec 2024
 18:21:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com> <20241121134002.990285-3-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-3-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:21:05 +0800
Message-ID: <CACGkMEt_wUm7GEZ6zxUUO=JSRLYfj8ah9pwYbT0ZhO9-pnD+Ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa/octeon_ep: read vendor-specific PCI capability
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:43=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added support to read the vendor-specific PCI capability to identify the
> type of device being emulated.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 24 +++++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 34 +++++++++++++++++++++++-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
>  3 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> index 2d4bb07f91b3..0f83a1eca408 100644
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
> @@ -52,6 +53,28 @@ struct octep_vring_info {
>         phys_addr_t notify_pa;
>  };
>
> +enum octep_pci_vndr_cfg_type {
> +       OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
> +       OCTEP_PCI_VNDR_CFG_TYPE_MAX,
> +};
> +
> +struct octep_pci_vndr_data {
> +       u8 cap_vndr;
> +       u8 cap_next;
> +       u8 cap_len;
> +       u8 cfg_type;
> +       u16 vendor_id;

Is this better to define the above in uapi/linux/virtio_pci.h?

Others look good.

Thanks


