Return-Path: <linux-kernel+bounces-567476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B94A68688
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3F419C2BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4C2512CB;
	Wed, 19 Mar 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqgBrrFM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B142A93
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372290; cv=none; b=Bw5J3dSWtWsylP/t16B2umJQYzFf4zsr7ZGmOe1iOzQZUT5kZfLVO8BI3Q8YRvQiZqCqTvIfmwZUdFi9zX8S311ba310z0xzQbLSyWnMbhciTT4bJL3sA9EEn927FIj2oJB3lVWdkJZq/QWC94B9I7rC6Pk+fIAy5XwYTGxYMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372290; c=relaxed/simple;
	bh=zKCGYClygELnOz5kUrSj+2y/YlS9cO2lSdiPcMiRq64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7DQd5eI+gA+CWos4/tGz+ZuTcuBz+1eQB9qvGI2r7tS6sHRRcyJnooP/AwYZqLweh35A0OgcqTtL6dElPEM9Sk8z9gRoLTNw4K7/rwWkbLJzP7x30x9T3ZmVtH0TTDmAU61OJ1pzIBxXGgivFTfn37POU4d3KTKRMVEGFe/ykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqgBrrFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742372287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4weFtyR8Vv/0WRgvwevHnBmwuMVQABx5dwojXYaS1A=;
	b=UqgBrrFMCR7ZBlynjLSSLIFF3ZfrXMxtDq3PEplMwj7J/yNRPKYMTiAtT6E2VwNJwQgreh
	rXXXpsjbDmZc2YK9RHPgkKYjEkJ0f9tMcJzt78h1b/TxSltQKhcHhf10mrrqwxt7GOeJQ6
	sWs9ViRBpzraZzeo1Y7Wf8m5GVlgS44=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-8hQphmrpM8moX69iPpp6vQ-1; Wed, 19 Mar 2025 04:18:06 -0400
X-MC-Unique: 8hQphmrpM8moX69iPpp6vQ-1
X-Mimecast-MFC-AGG-ID: 8hQphmrpM8moX69iPpp6vQ_1742372285
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5d9682f6eso5938957a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372285; x=1742977085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4weFtyR8Vv/0WRgvwevHnBmwuMVQABx5dwojXYaS1A=;
        b=IGgEpWeAt62gx2gCuDlaIFHDSYqQ4zyhM4r3NFzIDpxfveEwAREtd6Vxq5ql+wshlf
         2uFqVFUh/cz8EqT7f7E2GbR0RF8E1KRmYitLVUCy1qiObjVSZkY78EJzVtvo7zMlB6Ii
         1P8RPS7LCUmyCipQjrLsLL9pljpSHWMjRgAmm4e7Wyoz+nEVolVmZjWOItL9PIMl2AEc
         layPVOGSpwPYzkxm76NE+0ik95Mri2UeVgElnYlpztcEjlrI9qaL4RYAjO/af4TbCmNh
         2/tQNU+uwkShCwM7KWq5H8U4wdBNV32O9UUOKVCAelu6Br7CjnHW8v/HqINlZfEJcdnr
         PlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOq2PZ7cRjVIuO1ijJAXZKKs9uz1rLrYyB4tDQIV85OTiHjXsp+WN+3Cy4A6VYiVol3YlTayKdREcTtrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJGEfZhmxrKaZf+GLeLV7k6jdwggdlu7BvMSBMYXVo3GwnGdf
	qb0+nyyuHJWn5fjvRR3wnz5xTm2vn+FDe/3YSzi5BnGQwLeVzG+Hd3KMFL4k+DoaMez5U+N8LrV
	aa210dybrLmAeCZNc8GE6F02VvhWr3EOYRhaqfQUjqNb9TUxjy9qJdvU92BH4mTEDdPleC8t+oT
	Hu6qzTe9TvxEgQpXw6ddDwVGoyExBv9Bh8bUYK
X-Gm-Gg: ASbGnctSGrxsSM6SrRMF7MRw5NCaHTznTHKCNCxVOelpfGojTFMwg1dd5GGmvxRzm7a
	/NT7bOu1g6RrzEmdMz3icGqM2vFYP7T607ar3YLoAJVjEDeW9zpKgougfO1/CHzjOHkQyfrnfuw
	==
X-Received: by 2002:a05:6402:84e:b0:5e6:13a0:2321 with SMTP id 4fb4d7f45d1cf-5eb80f98226mr1528279a12.32.1742372285015;
        Wed, 19 Mar 2025 01:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX9nz4PdJIYgHPcBf3jCqH7Zjv1u+6eHEgELtuPU+YClK9V5WOHBjYADD5j90Xk8f2xxcCVZPPvbntyja6ch4=
X-Received: by 2002:a05:6402:84e:b0:5e6:13a0:2321 with SMTP id
 4fb4d7f45d1cf-5eb80f98226mr1528262a12.32.1742372284630; Wed, 19 Mar 2025
 01:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 19 Mar 2025 16:17:27 +0800
X-Gm-Features: AQ5f1JqtDok_bmysxOd31u7DWf9rtwBh16X9cCFBc9Txej8fP9FvAHet7aatDRA
Message-ID: <CAPpAL=w6bNxmsqpK7TGKM_YkQOLPe_w=D8_rCA6NsQCJCbHktw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] virtio_net: Fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio_net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=3Dz299Q7b4qEDONpYDzbVqhHxCNVk_vo=
-KdP9A@mail.gmail.com
>
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
>
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------=
------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


