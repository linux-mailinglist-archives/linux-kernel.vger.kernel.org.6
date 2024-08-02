Return-Path: <linux-kernel+bounces-272592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4A0945E72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA5F1C2264F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B881E4852;
	Fri,  2 Aug 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqc87/ps"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEF1E3CB9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604484; cv=none; b=Agqi+qUXCgv/fjb8H1Lw/qTZO2WdJM9e9jH6a+hPY2whclqyKU0oVp0nIaCb1e6ivdifASENm2ZJPjalC1u6WX1XYvKsaJwi537pzy8qt9A66H8BjjSKVWWcqQQu4saCnQF3LuSPxHDVCJly6bmk4JoVutxOwJgrVNxUc5DJtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604484; c=relaxed/simple;
	bh=mlVHMMZEWCwegHzSZJoPrbG16hagpjxEFmlG/bPjAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R37QIsLzmS/+5PnXOK6jqVCTG7yJ6H+P9waSTFewprPprDBDKNw8OS2NCs8R8GG9KThLqlbCShvCtYZWzZQx340JTADGBjklKZMI/vy3DZrj/1B/nqBYY3Efp87iUr/xPbL/75dkNUuBu4iYWEjc9fh8rkY5w1cpAz6LTS5q3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vqc87/ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722604482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G+bWvjkV854PGv5nQauKmV3J78os2SxWsQ3vifFpzE=;
	b=Vqc87/ps4K+/6g3OlrtyJ38wctRreGnEisPZKgTeVERxLMrx7VEnM/qfTbFOYFToKDNmzx
	FeojJ7XgVGm7MXCYXdNAJkPH22mmXGwGXI5JrZykLpoIILBEUQT3MaW42CFeBHhbiFqB6Z
	Qx4NjMVW4yDjrnFXnQGSznI31jwrRL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-a5tNkZ32NhaEtQmuKjR7Ug-1; Fri, 02 Aug 2024 09:14:41 -0400
X-MC-Unique: a5tNkZ32NhaEtQmuKjR7Ug-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso53778315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604480; x=1723209280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G+bWvjkV854PGv5nQauKmV3J78os2SxWsQ3vifFpzE=;
        b=CYRmECHhxVoShW2xzcNlGsoqtrONzwWwzLXh6X2jB1iznIbcJ24RYl+FMCa2MXl3WI
         A/NtwrQr5K760RbEg/q1Hd447RhTFl11X8ivWNtmdWMZc3KoV7dHfKFDCR0lCdfyUugV
         ygooJUBv7sxuQOrB6lg+oJxx/c/TY+nm9omcReDHQyHqTuxYUGsJS+YV6qUO9PByG/OQ
         wv9pJvJetDM7z8fAXKTiqIFWz4XGu8TF5FVk/3F7y6zzuOFdlbw6qtLYoO+XR5od70S4
         r9o61st9aVGb9Tc0CfWagBfI2VMXnI07fflb0pVAFtfe3bcRAHQCUrmVjMuU6plTDLki
         OiAg==
X-Forwarded-Encrypted: i=1; AJvYcCVHEFD1FEgipEvpaVBNQ0gmEdgbVkOiJXZwfQVG5c+8FxSINzkhrqNQOX4DSnhD+Y0j90LlupMvF9Ze3f1xHu7BbZ8vnNAr3tvdV1pu
X-Gm-Message-State: AOJu0Yw2cm7+IPUImyAg3OAEIC4EnlD5MeH2ecZUzHY+YGiZZAV1cSrP
	pSpkQ7SvqDKqsAVF5MDgHeZl38zfztgY5rRIH7pfghftJmHWaJpOcsRD8So6EaeJ0AFW2a5i1o7
	wZjZ/tC9h22quXmwou8nzPCh3hfTvQws2TocXBAxIHDl6P7stfIUAAAw6e0Sg7g==
X-Received: by 2002:a05:600c:3b27:b0:426:593c:935d with SMTP id 5b1f17b1804b1-428e6af7aeemr19557115e9.5.1722604479659;
        Fri, 02 Aug 2024 06:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuRmjRgLKWU2y9r5mwZaqHkfa4aoDytkkFpO3vmjIpfmO1Id6emUqbDV3bWzmGUtUR32/LqA==
X-Received: by 2002:a05:600c:3b27:b0:426:593c:935d with SMTP id 5b1f17b1804b1-428e6af7aeemr19556785e9.5.1722604478820;
        Fri, 02 Aug 2024 06:14:38 -0700 (PDT)
Received: from redhat.com ([2.55.39.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb97fbasm95238665e9.41.2024.08.02.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 06:14:37 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:14:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
Message-ID: <20240802091307-mutt-send-email-mst@kernel.org>
References: <20240802072039.267446-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>

On Fri, Aug 02, 2024 at 10:20:17AM +0300, Dragos Tatulea wrote:
> This series parallelizes the mlx5_vdpa device suspend and resume
> operations through the firmware async API. The purpose is to reduce live
> migration downtime.
> 
> The series starts with changing the VQ suspend and resume commands
> to the async API. After that, the switch is made to issue multiple
> commands of the same type in parallel.
> 
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
> Note for the maintainers:
> The first patch contains changes for mlx5_core. This must be applied
> into the mlx5-vhost tree [0] first. Once this patch is applied on
> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> tree and only then the remaining patches can be applied.

Or maintainer just acks it and I apply directly.

Let me know when all this can happen.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
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


