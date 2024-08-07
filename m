Return-Path: <linux-kernel+bounces-277947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284394A888
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACF01F23D7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496C1E7A53;
	Wed,  7 Aug 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+wYeB3j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C011BDAB0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037172; cv=none; b=FPvFNp+PbyWsFU5w3xHWqX2QK58QvV5MK2gsmDkUD6d1ymzFcoAE1H90uHdYNJjUcL3XL0hJoijP0yqmgUdDUcQpQU8Hj4wGzeKwf0ifcb975X7xag68oMKwArETTlIfXyI5suG5y/JnE+Hk+CiQbz5BiWjgP/E+Mrt3ninDArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037172; c=relaxed/simple;
	bh=i08Eu++Bs5ZfYyhmfDLsgMllWxZSyJTGvRtL9wXdWUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qT9OX9uQRt/tdvFWkJy20yexf1xpyffnuEwuBpUndFmUHhvmIZvHwjzdRUPId9sj63YQ1vG46wpj//yotWtvthZEkaz9PF0f21bslr/hx/CnTCxy7RqD4zQcay/htcjVpqhNFIyIz31MynT8pYjGnf/XAbm51kv6lkHdEtxj60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+wYeB3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vloTJ8N6rDB2OVVpi1DvU3M2IhFk9AAWb0s6CTF2pM4=;
	b=P+wYeB3j7W9W2C9TuNeiN/49PE0dfVmmAwETSprdfMtkdM9dM9w7Uixvtx764zpf0vaYrd
	zrvGvnp3O4DMQIhkgVqQxM5KmJiwq+9Id0mnaAo5T98yyjGi8/DsY9fcCaqsFRyr1uWx4J
	9HAQ+XCuwA6qHVL+uHC7aG7FBTYdycQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-5-aap9TTMpC6edFXBNurNw-1; Wed, 07 Aug 2024 09:26:08 -0400
X-MC-Unique: 5-aap9TTMpC6edFXBNurNw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-692aa9db2d5so34010427b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723037168; x=1723641968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vloTJ8N6rDB2OVVpi1DvU3M2IhFk9AAWb0s6CTF2pM4=;
        b=N0VNIUb+TR/BmhHBZgaAm68HtO4Ngmfc5utvtuAwZ9z9lDdAGh2JArBYB9Rvc4dxzc
         OGD7iDSD1FbxKGapADU9z3TbUBfqZcsT8bLGntfrDKVcrZ38A4p256y97ao3havTEOo8
         Jhu7CnIkxKk/mpZhiNv4LgxFn0WlSnOqoYlX/+k6mADChrWxPJ0iQZTncZFaBjMwYmlq
         NkM5HwjhnG/Js7f7EPIdulkP9jpToWRCOW/IMjl1UOFcuULtZDb84f/IMsD1RF/6fQPs
         6Qxz/pL7vRBELZLusA1Dv0yWlz7H/9TOowlkbSJkcTQ9CDAbr4cSheZlCenSRycpA6kh
         kqCw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtgsDBOe79jNysWAnjlDDrhzM/sLdcV9SeQrRdCCloAg+4i17hXkAwvTijfOoNrblk6NX+My+fiSsyZXZQybmywsR9Wp/jpC4Q5Dp
X-Gm-Message-State: AOJu0YyUpWVpBZuDf8BBWUfSitW/fDisxdxCnme/545LqaH++UuiPbf9
	XHh8Fix6QVXG+CXWWQZ513niI/HSNxL2aCwwsrJRyLEXi5NvyrsS9jwMwIv1DnN0jMPX9Rx32QO
	X1sxQGgnNCflq5/ZSwCWzJEOIaIBljioCIJqBSLPZTjLYJQ9yTdop7gVI95SwTHvNAq8raklxDz
	vVhD+ubrW4CPr8+efQjI881o8CWXlpm3xLw35I
X-Received: by 2002:a81:8887:0:b0:63b:b3b8:e834 with SMTP id 00721157ae682-68963423819mr222073747b3.32.1723037168332;
        Wed, 07 Aug 2024 06:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlaQzWaMhaOL8yyUTkscgvdFCW3vr0eHO4IPz4j2TIsmeWnld07fIgPnkUYUvyGyLGq+dpPFUOtl3iXD2ZKEw=
X-Received: by 2002:a81:8887:0:b0:63b:b3b8:e834 with SMTP id
 00721157ae682-68963423819mr222073587b3.32.1723037168001; Wed, 07 Aug 2024
 06:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802072039.267446-1-dtatulea@nvidia.com>
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 15:25:32 +0200
Message-ID: <CAJaqyWdGNfJ3n-E2-PvkuvCiOMsLkEzYaUi5wi-C_n84-a_LAw@mail.gmail.com>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:24=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> This series parallelizes the mlx5_vdpa device suspend and resume
> operations through the firmware async API. The purpose is to reduce live
> migration downtime.
>
> The series starts with changing the VQ suspend and resume commands
> to the async API. After that, the switch is made to issue multiple
> commands of the same type in parallel.
>

There is a missed opportunity processing the CVQ MQ command here,
isn't it? It can be applied on top in another series for sure.

> Finally, a bonus improvement is thrown in: keep the notifierd enabled
> during suspend but make it a NOP. Upon resume make sure that the link
> state is forwarded. This shaves around 30ms per device constant time.
>
> For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> x 2 threads per core), the improvements are:
>
> +-------------------+--------+--------+-----------+
> | operation         | Before | After  | Reduction |
> |-------------------+--------+--------+-----------|
> | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> +-------------------+--------+--------+-----------+
>

Looks great :).

Apart from the nitpick,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

For the vhost part.

Thanks!

> Note for the maintainers:
> The first patch contains changes for mlx5_core. This must be applied
> into the mlx5-vhost tree [0] first. Once this patch is applied on
> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> tree and only then the remaining patches can be applied.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/lo=
g/?h=3Dmlx5-vhost
>
> Dragos Tatulea (7):
>   net/mlx5: Support throttled commands from async API
>   vdpa/mlx5: Introduce error logging function
>   vdpa/mlx5: Use async API for vq query command
>   vdpa/mlx5: Use async API for vq modify commands
>   vdpa/mlx5: Parallelize device suspend
>   vdpa/mlx5: Parallelize device resume
>   vdpa/mlx5: Keep notifiers during suspend but ignore
>
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
>  3 files changed, 333 insertions(+), 130 deletions(-)
>
> --
> 2.45.2
>


