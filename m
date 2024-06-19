Return-Path: <linux-kernel+bounces-221491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ABE90F455
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4BF1F23861
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04481153BF0;
	Wed, 19 Jun 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM/6aQCr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BC153578
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815202; cv=none; b=oLaSgl4v/sT+GIVC+4U0NP4+PlJkApteLp2IN3NPf2SsV6yf8I6FA7zvTiC/jB9QjVk5f0ukI2tCHx5KokcqPtaWFCEQqTwPVJKl7eAxa69WuMIMn5FWY7cOCR2be5euVq0E93RK9b076rGgDmohCOeqwSRZmOwKfo/DzOejub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815202; c=relaxed/simple;
	bh=TLxDuDULv7mvnSpOlUw3zxuVhjTlDVDDw8EewhZA5MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDFti/O1GwJ7Ay4r9r2r/rjibkR4oqk2vFMhQNw8Vrx0XaUE6FRttIwCzyDLxYAtLE6UkXZ3tudYAJrrdpmvWBQBCcx7BRqI1zPkxpYvZ6E3kFOg4A4voAUaVgttcjsOlyPeAOKnz4QR+STJlO6WP7cUwAt3ePp58BgqO7rGyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM/6aQCr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718815199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P60Z+qqKP/gxhy1fal8KOowFEF1s+YzH3edKw1gHlyU=;
	b=FM/6aQCrgoL8qshur8rleJ3Qhz5i3MmMhcg1Rv7t2D4p8wear3fyrMXeAjOW9KjwdrnWew
	Iz9LCpkgCFJdNdaBsyx7sh265A9WFZEJ0bjuMBUb8+nzzRn1wYcEXvWkV8a+9yjOn80gU6
	6WakzzfrrFDAW+mNrYosX99OuAN/xrw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-9c1IW2JEMkiVfNyxYrjwsg-1; Wed, 19 Jun 2024 12:39:57 -0400
X-MC-Unique: 9c1IW2JEMkiVfNyxYrjwsg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-62f8a1b2969so137922967b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718815197; x=1719419997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P60Z+qqKP/gxhy1fal8KOowFEF1s+YzH3edKw1gHlyU=;
        b=gD77Frc1c0jwcEd931ZKmpXyiEbMIg/5DgCnib/0D6+X0R6GAFUTf3vm3U4+ctukxV
         HJBf/BhP8tQH1gm2OSFZChKbnS/wQEMVLlQXKgLZ2cfwuNtKa6l0OEGcPTP8FPQg9p73
         om0mTBN6pENfW4yoBG6c44mnPWxHLCGERcDy0TT3D5DCeJTocFqRYadeLDiixaQ8BxNh
         qj3DBt/S5xChcinw3/ow0qlXy1EPvYEIfFTG8spw+QMM21JoQ6k6QO1rXPpzlTztGDpt
         Qg7CqsACU5/bLwz5zBlrsLyO03idqDKWpN7/YR067WXLbkqp3sTQWnwcPGfHJbl+7kWz
         fOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH8BtWqUgBBfSMD8JHZzOifmsL+paSVb3wxBYdZs+48/eArMeHwGgRHBqRRvcMy+2puIvzB9N7eIq5hTPNKHyr8P7zMSfuHcbmRVkM
X-Gm-Message-State: AOJu0YyDtQm8po5FCTbIUsacOtDRX9Zv9AVVhLpBfsZoIw8bPQsdGpwO
	IZCH6eHplzoOp64xMcI4Ik8qVa4rtktmnWLlyZObyAWd3CzxX5XKcZ01adinyw0F/xUBEmCotbA
	ef60UavNX2hFtocE3x/YR+VZeNaiwzo8PTN9zhw1J1p95cXTLDlPYpEURvHhZzvYmUMhOywlXZT
	0m1FWF+J31cVivwZQorvgvuo6BaMe6BpnzLDqr
X-Received: by 2002:a05:690c:94d:b0:61a:b038:6d34 with SMTP id 00721157ae682-63a8e4bb5a1mr33219847b3.24.1718815197192;
        Wed, 19 Jun 2024 09:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOXaEuiFH0ecGWxfyNYKYA47piELvowHtDpjSC86sl6JvY/gqFtoIQ2677PkimEVq0gbLNOWpWdslhce2oYP0=
X-Received: by 2002:a05:690c:94d:b0:61a:b038:6d34 with SMTP id
 00721157ae682-63a8e4bb5a1mr33219687b3.24.1718815196917; Wed, 19 Jun 2024
 09:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 18:39:20 +0200
Message-ID: <CAJaqyWc+bmWVU8Lu40bhxEatJ5y1f3n=AD2_UborSRa+Bf495g@mail.gmail.com>
Subject: Re: [PATCH vhost 23/23] vdpa/mlx5: Don't enable non-active VQs in .set_vq_ready()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> VQ indices in the range [cur_num_qps, max_vqs) represent queues that
> have not yet been activated. .set_vq_ready should not activate these
> VQs.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1a5ee0d2b47f..a969a7f105a6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1575,6 +1575,9 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, st=
ruct mlx5_vdpa_virtqueue *mvq
>         if (!mvq->initialized)
>                 return 0;
>
> +       if (mvq->index >=3D ndev->cur_num_vqs)
> +               return 0;
> +
>         switch (mvq->fw_state) {
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
>                 /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
>
> --
> 2.45.1
>


