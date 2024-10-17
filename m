Return-Path: <linux-kernel+bounces-369265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C49A1B05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE4A1C21A03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31411C1AA5;
	Thu, 17 Oct 2024 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpiSzyth"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E61953B0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147884; cv=none; b=K9ICZpgA9nCsGnDhIvaJSz/fmiqZuU3WdHZh1PTRPUsIMqkhtthv5atN89VzHShfGsnSFuegwD/PuCYBKfSH4AsYTyCodVNZSWN0cH1nMHpdjFwLuMYbYMbhkbZMG1YtRUNjcO7jBjtmn+J26vN9Q5tFiF0YNtjlekfA7gX+eZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147884; c=relaxed/simple;
	bh=xvSTe7MkagrupWBAefdjJyXtMIcCbckwXBrGdN7d9l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrrtqxXp9cJIRlFAdbr2NbfGkV5TCTAVGKEFmeA6X9fc3yANOEgiLE9185UCkPUmnTrPbFMNelII1wIs+8ZCYyvsjPdio1Yet89XlpZVBCkWtrrP5QHf81vXxJ3Aprd5uU5daY7nam3tC8PK2QkE6CaNcIWhFLzquXRgqvmcEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpiSzyth; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729147881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xay7m0WxFpn21Bz1X2gL8BD4WBjxqjm+qohOUPEun3M=;
	b=LpiSzythaGuceqZiuQKLuW2GVkl9o69h0qKXb2Sjgq6gmvkCEzvBXFV2rrYiQW0YtSY/fQ
	KqTdBVKflmjoR27+f56uS1mxnEoZrsnDP4iLHJtIvE6fxlvrvp7WMfCccUPa0lzhEXXpd+
	eZuP9GT68ZV0bqkDpwqn78GGf1Bm5OI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-_owsF8e1PxmX0NfOABevYQ-1; Thu, 17 Oct 2024 02:51:19 -0400
X-MC-Unique: _owsF8e1PxmX0NfOABevYQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e578061ffso660783b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147879; x=1729752679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xay7m0WxFpn21Bz1X2gL8BD4WBjxqjm+qohOUPEun3M=;
        b=idkgo/i+6OW+zehYZkIYa/SoO3w7NcmlkbujbB56F7/7JQoNNY4A7nuY7W3XKKvqKJ
         jDcD19mHRUfEhRlFftwv2iYWCYuq7YH5F1ropx9lk9al/oLCheYME6x+nku2gh7bz6TI
         CGSVrogTWODriFiZfvD4E14bo6/IAYJqkl+0GgrNaC3fxdyyYZPBIwgCX4w6M8HknUQy
         FTRZLVk5tQoRfqta+b5r8P1rmeTu9n1jHP1E3X8/xMVu/+weSZ2JKHYg+aldXx6/duQ3
         WA99CEo74NM67JSiZNbEAHVzbNTFRgM5eVG9tA4g54IOwEVJ70i+Y1QlASNmN0QTTRej
         EdGw==
X-Gm-Message-State: AOJu0Yyb0BJxPPL/mdc1rEsjiKJT7RCSEuc5qu0bJB6O4ML82F+hPY6y
	fYUw/kLBUFCtfxd1Ie6ZRpcf/QccqLW9CnvRPUKQn1f5OW33tLkwzhFbnDwt+PINvGbIF0qiVHB
	ko7bxn9Q07RZLWxHpP6k4/uxG7vbuP32y0cwOFTe4W9BCXXdeYy2Yv4XW6N8TZkII+Pi2CgHT3J
	GjXMw7ST7Tnx77RZzBdqnZV+8ggWK5/sFUeB1Y
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr18954655b3a.0.1729147878718;
        Wed, 16 Oct 2024 23:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGSON7GqEf790y/2ntpuXKji/SEhnmlTHIdPHQBAwq6YDA8De1J3fJmL4zC3Yp6zQMaH7+G3U/d3cye43jIOs=
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id
 d2e1a72fcca58-71e6489127amr18954637b3a.0.1729147878273; Wed, 16 Oct 2024
 23:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
In-Reply-To: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:51:06 +0800
Message-ID: <CACGkMEsovgv9=jj76dfATHWHY7c6NAmiqKDaARDGYju-A6zaKg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix integer overflow in stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"Colin King (gmail)" <colin.i.king@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Static analysis on linux-next has detected the following issue
> in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :
>
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                 queue_type =3D VIRTNET_Q_TYPE_CQ;
>                 ctx->bitmap[queue_type]   |=3D VIRTIO_NET_STATS_TYPE_CVQ;
>                 ctx->desc_num[queue_type] +=3D ARRAY_SIZE(virtnet_stats_c=
vq_desc);
>                 ctx->size[queue_type]     +=3D sizeof(struct virtio_net_s=
tats_cvq);
>         }
>
> ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
> VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
>
> include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL <=
< 32)
>
> ..and hence the bit-wise or operation won't set any bits in ctx->bitmap
> because 1ULL < 32 is too wide for a u32.
>
> In fact, the field is read into a u64:
>
>        u64 offset, bitmap;
> ....
>        bitmap =3D ctx->bitmap[queue_type];
>
> so to fix, it is enough to make bitmap an array of u64.
>
> Fixes: 941168f8b40e5 ("virtio_net: support device stats")
> Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


