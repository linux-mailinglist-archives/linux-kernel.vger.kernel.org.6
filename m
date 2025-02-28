Return-Path: <linux-kernel+bounces-537692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12AA48F23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB00916E3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18518C011;
	Fri, 28 Feb 2025 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="ajGRkQ6K"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85A05A4D5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713439; cv=none; b=F39DuJAKXJxSlH5fy2969eeYhgo7VNeLwgNs6ZRHEaFwp44cJRv7uWeLL63y1yga6FJt2HeqdIeWbxf+hx6JtTDTyFzQ+Bs8d6JkxOS8qr5fH+UvixrwNEEWyVCoWqwlqO654Re58G+BXx7mLV2sSoOLUsaMiWbDySpBpZ09GEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713439; c=relaxed/simple;
	bh=ZwRtAKiHSC+DlCDipLWMPBo0fB0XJxa/oWhdVHUyLJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/CnFx3k7TQf/LHcOad2bOVwt4qYFXM1R1m9l8sItI3b8uBlJPURndPsy0WzEa6fb6+wsVbk2u6O2Hnyzz12HNyi6co4LiyCH9mSGJH40iojHj14WtxD5vZUf262TomziJRHQu/SeyJazblagVtkFMgqAs843YhaBTExQ8z+Ego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=ajGRkQ6K; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471fe5e0a80so15426341cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1740713436; x=1741318236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RVVG2IwvthWW/+RBCG6i5JXoqhlYqngpobZWnBOaYI4=;
        b=ajGRkQ6KbkU6CaieJzUpDTy6koJTD9kkT+ESqHpKWLAyOA8CwvcMQdSwGz/5nLQSNX
         yljW7FZZ6qPOmjuK5e2fQ9gGfJWr9XR53eMnS5Lhj4m6TI/QRfoZVExTFyd+DR5RH4hJ
         kH8g6u050Y5z0vbU81LqFNaSbkFXNOWeQ1WvPb6hyipqfZ6RceEfPa6li0Uy6nD4R3AA
         J9yDf7YKSdxWGgkYnPqhufeAdLML+b7O/CZxcB8vhpVMd3R5psFXAlfGrk56BibgAz5m
         hLwWbpy4xSWwQeJ1UhtTkGEbpbGyJlMYh/sk94usPLDdsUz/B/5lBAUcsRYisPbc1HLu
         cRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740713436; x=1741318236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVVG2IwvthWW/+RBCG6i5JXoqhlYqngpobZWnBOaYI4=;
        b=brBoDU7E6qoWM+Z1Potra0hPMMIuubFnB2Fx+OJXZzDqCY5NcQg20bnpwL1Rin41hd
         +VemXNN+BsFwDBAn95tDXZQP0TSkIgJ/WqqvaXNdRjziAJGD4PmMEmW9Y2XSFjOy0s3J
         NM0SYBXh4xQsnSVG4PQQLuIagn1YTBCAVdd2h5AmTVQyYSTc+WAFZ+pPtI2n0QtV5v08
         mDVGTUxyYQSQjfhXzgETreBkef+7tV611RKrtcwJNpSCLFC0mwLB0dAWoZLU0H+eur/V
         Ksb2aqEE4gYjvYGu1Zvm4PNh2YBYnzfWiC7ym5hYTzaKw91qNVpfi6hl3ZdlEzd7yGBL
         PNVg==
X-Forwarded-Encrypted: i=1; AJvYcCUQCtKefC0VjPjoGmQxdHUbhDupYAJBLka2orNmHUdvmhOadWL3BTsNIN7lPuteby1IuaG5wbsEhxqwSnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGx+3wrtWXgmg85aHIH8IMW5NTpi33aAk4DAg6J9ptxCyRuxP
	dNJYoOS0s3TtWfHZoMfKs1zilxrMMlXgsld5p+3l75V1H8/U6HZY8qwPubJU3bTX6RJpJ1bRpCO
	cjgg2Mg==
X-Gm-Gg: ASbGncujdEF0KhBNVHzeWvbPB7D9wY9mC6KjxHysPDQSKxdrow/vcm15ISkAeHDZJa+
	b+d2w6kBfNTOulmz+rL7mPazv2AV+vOEWA055poh9tHKQNsM72cOOJNL8J5fRDjFSqm+yOLL4fS
	kVaWxY4M2p70SaRcETqjsAIwGWVGXTFoDNI2qGSALZUhuT9GeDtACae4b442xI6GFY3CaqQFlQQ
	OLIhyxiqn/Eu9GbTl7PZWiC+qg3uFPnvWxY5zjvKst/Y4iVxIIl/bm778dvjgzL9kYgnguvgOdy
	n6Qi1F2C6ARlCjUczfOd74+D1e21jno=
X-Google-Smtp-Source: AGHT+IEEio0A7nIEAZI3ddno0TpSgz9fND8CuYHuE1x0cFd3ArDKQjvW9X1ozId7B5F4Eo4JdE2bJw==
X-Received: by 2002:a05:622a:11d0:b0:471:eca0:113c with SMTP id d75a77b69052e-474bc0fef42mr23052141cf.42.1740713435715;
        Thu, 27 Feb 2025 19:30:35 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:e976::c41? ([2606:6d00:11:e976::c41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474b7696709sm11029291cf.48.2025.02.27.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 19:30:34 -0800 (PST)
Message-ID: <25beec7ea929b624d845f5ba4abce6267974ed82.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] media: videobuf2: Fix dmabuf cache sync/flush in
 dma-contig
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Mikhail Rudenko <mike.rudenko@gmail.com>, Dafna Hirschfeld	
 <dafna@fastmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Mauro Carvalho Chehab	 <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Tomasz Figa	 <tfiga@chromium.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hans Verkuil	 <hverkuil@xs4all.nl>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Date: Thu, 27 Feb 2025 22:30:33 -0500
In-Reply-To: <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com>
References: <20250128-b4-rkisp-noncoherent-v3-0-baf39c997d2a@gmail.com>
	 <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mardi 28 janvier 2025 =C3=A0 23:35 +0300, Mikhail Rudenko a =C3=A9crit=
=C2=A0:
> When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> commit 129134e5415d ("media: media/v4l2: remove
> V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> no-ops, making cache maintenance for non-coherent dmabufs allocated
> by
> dma-contig impossible.
>=20
> Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> {flush,invalidate}_kernel_vmap_range calls to
> vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> buffers.
>=20
> Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> V4L2_MEMORY_FLAG_NON_COHERENT flag")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
> =C2=A0.../media/common/videobuf2/videobuf2-dma-contig.c=C2=A0 | 22
> ++++++++++++++++++++++
> =C2=A01 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index
> bb0b7fa67b539aa73ad5ccf3c3bc318e26f8a4cb..146d7997a0da5989fb081a6f28c
> e0641fe726e63 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -427,6 +427,17 @@ static int
> =C2=A0vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> =C2=A0				=C2=A0=C2=A0 enum dma_data_direction
> direction)
> =C2=A0{
> +	struct vb2_dc_buf *buf =3D dbuf->priv;
> +	struct sg_table *sgt =3D buf->dma_sgt;
> +
> +	if (!buf->non_coherent_mem)
> +		return 0;
> +
> +	if (buf->vaddr)
> +		invalidate_kernel_vmap_range(buf->vaddr, buf->size);

Am I correct that this is mostly to prevent the kernel from reading
back old data from the cache after an application or other driver did
CPU writes ? If so, can't we restrict that to DMA_TO_DEVICE and
DMA_BIDIRECTIONAL ?

As for pending kernel writes, they should have been flushed before the
buffer is made available for dequeue. And any access while a buffer is
queued is concurrent access, which is expected to have undefined
behaviour.

> +
> +	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);

Isn't there a link to make between buf->dma_dir and direcction before
calling this ? Also, shouldn't we use direction insead of buf->dma_dir
to possibly limit the scope ?

> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -434,6 +445,17 @@ static int
> =C2=A0vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
> =C2=A0				 enum dma_data_direction direction)
> =C2=A0{
> +	struct vb2_dc_buf *buf =3D dbuf->priv;
> +	struct sg_table *sgt =3D buf->dma_sgt;
> +
> +	if (!buf->non_coherent_mem)
> +		return 0;
> +
> +	if (buf->vaddr)
> +		flush_kernel_vmap_range(buf->vaddr, buf->size);
> +
> +	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);

Similar questions for the end_cpu_access implementation.

Nicolas

> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20


