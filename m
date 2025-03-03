Return-Path: <linux-kernel+bounces-542064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73306A4C520
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F1C3AB771
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97F21518D;
	Mon,  3 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="sei5hvwH"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611942144CC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015477; cv=none; b=ak3llFjYc0Ac03EaH54Z0jj7DzKshmL39vDF9nPv+9/OWlC/LO43mDKtW+/A33A0+DeXKvpsTU8bifGiLeaVEY7P9C9Aq9MneGIYpahwq3uu1ye3RCtZKkjr9MYitri/0da0D7WViZr4Uyjgs75W3qQ1OOCbQaE6MNzdG5LG5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015477; c=relaxed/simple;
	bh=pfpr19Iu90GBD6jxo298SmOMqXiX+bP60uY1Ix2uksE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcbOj8dImOcVQfFe/0tFu4nl62LLMpVq4YyP4SP+aYztkXDReNwDiFjdAJdcCxHJtLvKOy49uohNVPvoOpWKGmZaDcEfhKlwLAT7QKlew+BZZ8vl8U7P4kfCbZX3xXyf3lDKShlgu8c+0SxbPPXYPFzqEygTcQm7j1HqNPzn2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=sei5hvwH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0ade6036aso529404085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1741015474; x=1741620274; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WFHt+0PcUrjf2KPzth13ahqz68xbUj7oThx+bYUbytM=;
        b=sei5hvwHuvTkTAJOMcYpdxuIOirM7pWtT9QlEr31KitoJE1PDkADHzOY6msBn48pKO
         dnr2GkmDJ0KFAUlXgChvD8d/rH400qva64OIJQ58nIHAHMwlYdZQHjR4ahLA7/YQ984d
         B2/Pr0/lWhAdlS6tmafscVOg89md/4RzPihch01xoKxhgsm1eciEYyRQxLnXM5wW1+Mb
         tvuamufs30rpSP7S/3/R6MAzVMJLoW+dZygBBasO0ZPwFkF2Kdqrz019WMbP/Pm6bCfC
         H+xPnbgh4tckK7kcMv50fza0ePq2DRDwRdJgfcM2V1Qlq8uMvMQB9pE0NAIdPTSUP6eR
         7UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015474; x=1741620274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFHt+0PcUrjf2KPzth13ahqz68xbUj7oThx+bYUbytM=;
        b=tTtKjvFxizZnkX2FSkKdgyBGs3PiqpqepT1o9O96QtSIOzcF9sV53Qhy9ftm8PNLZm
         NhU6QTFK3jEK4hNlNIxMM00kG93arqdCUVFUzwKPSVVNN7usKjRCyMCEwQdsI3NOrS1N
         5b2PeeMjUI9vkD92UYYO6pdDyCyNgkRD9ozZENkGRncvY4Pbwz/OqThYyw7myggv8NnE
         0MJZJ/j4PV9RFhrGybvdRaZsIFdxeylXaUHw1RpW9F2Zgqxjrk2GR/1LHlSLCoPDTize
         kQD/eSyZTxLl3tkcK8PrFuvSIV+SjIi7LF0R75fSFp+v5b5Pka9ayCE5c5DSatHYM5kt
         fOFw==
X-Forwarded-Encrypted: i=1; AJvYcCWa34cxEN8AOvs0Mc8DWXviCP5lPV513AUK/Ja4WTjTLsjEqemX0AoVd7XBw5zZ6aruQ39Iux6cA8ZllmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnRKW3Q/VmJAZqUn5iQ1TJvKEbrmZfhvnRMKrNSELwkjJ273z
	CwmM/er6ZXSIwIowRlMki3uvkOeLJkKm/2bqw7muycpQJgeK+eBo5sNJtTnpbBY=
X-Gm-Gg: ASbGnctrVjwmyPFQOa2xrvo/v2JCPrTjHvJVdltgYJqjlw2KZ0TYzUnwos4jg7AhXi7
	LTK89Vnq1hfgvTWEZYwoiJcHmVQRTnrN1qqBFGPflrwBUT5J5RDf348ynqH6dzsJ5UhqBOkEMYk
	OmEyqS4pv06yQFUOfV3uWK5VCsnpuFk93cNgywd699oSh4spImRyoGe5tvC7USPGon+zRgRu1UM
	WHY29/RG/HK5tm/M2xLWhuu92jGRXPUAGG62RTOQvoTWC0ZSkXMMGro/PmfH5QBGW0bxzJQcSL7
	Fe+8gofZP7W4K9LOLq/2xCeDS9NyTJPXuog7+B5NJDpAtCrUAQ==
X-Google-Smtp-Source: AGHT+IFfnYkxtmeyMx4cbVUhHoEgj8vIHk0FHdrXdCz4obVUHVFmEQgHCvy9FSBCGdXes2aYUVuO3Q==
X-Received: by 2002:a05:620a:f06:b0:7bc:de68:e932 with SMTP id af79cd13be357-7c2a7632d54mr2279290185a.23.1741015473845;
        Mon, 03 Mar 2025 07:24:33 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:e976::c41? ([2606:6d00:11:e976::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c89408efsm27440485a.114.2025.03.03.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:24:33 -0800 (PST)
Message-ID: <8b3dac7baed1de9542452547454c53188c384391.camel@ndufresne.ca>
Subject: Re: [PATCH v4 1/2] media: videobuf2: Fix dmabuf cache sync/flush in
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
Date: Mon, 03 Mar 2025 10:24:32 -0500
In-Reply-To: <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com>
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
	 <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mikhail,

Le lundi 03 mars 2025 =C3=A0 14:40 +0300, Mikhail Rudenko a =C3=A9crit=C2=
=A0:
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
> a13ec569c82f6da2d977222b94af32e74c6c6c82..d41095fe5bd21faf815d6b035d7
> bc888a84a95d5 100644
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

What would make me a lot more confortable with this change is if you
enable kernel mappings for one test. This will ensure you cover the
call to "invalidate" in your testing. I'd like to know about the
performance impact. With this implementation it should be identical to
the VB2 one.

What I was trying to say in previous comments, is that my impression is
that we can skip this for CPU read access, since we don't guaranty
concurrent access anyway. Both address space can keep their cache in
that case. Though, I see RKISP does not use kernel mapping plus I'm not
reporting a bug, but checking if we should leave a comment for possible
users of kernel mapping in the future ?

> +
> +	dma_sync_sgtable_for_cpu(buf->dev, sgt, direction);
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
> +	dma_sync_sgtable_for_device(buf->dev, sgt, direction);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20


