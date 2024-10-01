Return-Path: <linux-kernel+bounces-345489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2F98B6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42F81C21CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991B19ABB3;
	Tue,  1 Oct 2024 08:27:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0B1E4AF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771278; cv=none; b=YAugC3XHhGA9A3/CUa2oMhGJu6cSx35cf6ztPV8UsKfuL9N9Ovxxdl5S+qSPYVjgELHYquELlyAqV7KwkxH+vyNWqIhwizW7U03yK2A0IuakleaC0euKhebGXv9KTPpA9WIljLwoBo0AyzHnlcETqAo/Ta9FqJhqJ0GXhqsw6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771278; c=relaxed/simple;
	bh=j0UVAOSpNlqu+azrorl8wPebprpfDJA89G4NXyR5AmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZp/XQZY8JuVhYs4EAr6wJUIcFeNH21xmQqkcik88/wu/ateqZbCaH5oxg0KGQ3fp3Xg6YIsG4OcDQFtApm3zvs/sdxWXG9y+XcghOJiVxTEkV/DUDBj4AG9tbBos+df1U/AJJlw3+nakASdhCZ7tAxQXHeGwMznv/VY2qBQ92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svYEU-0002XU-DN; Tue, 01 Oct 2024 10:27:46 +0200
Message-ID: <ca5e444a22bae0a834a673e41e8d5b93c08f2351.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Print error message if inserting IOVA
 address range fails
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 10:27:45 +0200
In-Reply-To: <20240930221706.399139-1-sui.jingfeng@linux.dev>
References: <20240930221706.399139-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Sui,

Am Dienstag, dem 01.10.2024 um 06:17 +0800 schrieb Sui Jingfeng:
> Etnaviv assumes that GPU page size is 4KiB, yet on some systems, the CPU
> page size is 16 KiB. The size of etnaviv buffer objects will be aligned
> to CPU page size on kernel side, however, userspace still assumes the
> page size is 4KiB and doing allocation with 4KiB page as unit. This
> results in softpin(userspace managed per-process address spaces) fails.
> Because kernel side BO takes up bigger address space than user space
> assumes whenever the size of a BO is not CPU page size aligned.
>=20

Seems we need to track the GPU and CPU allocation sizes separately.
Userspace is correct in assuming that the GPU page size is 4K and
buffers are aligned to this granule. There should be no need to waste
GPU VA space just because the CPU page size is larger than that and we
need to overallocate buffers to suit the CPU.

> Insert an error message to help debug when such an issue happen.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
> For example, when running glmark2-drm:
>=20
> [kernel space debug log]
>=20
>  etnaviv 0000:03:00.0: Insert bo failed, va: fd38b000, size: 4000
>  etnaviv 0000:03:00.0: Insert bo failed, va: fd38a000, size: 4000
>=20
> [user space debug log]
>=20
> bo->va =3D 0xfd48c000, bo->size=3D100000
> bo->va =3D 0xfd38c000, bo->size=3D100000
> bo->va =3D 0xfd38b000, bo->size=3D1000   <-- Insert IOVA fails started at=
 here.
> bo->va =3D 0xfd38a000, bo->size=3D1000
> bo->va =3D 0xfd389000, bo->size=3D1000
>=20
> [texture] texture-filter=3Dnearest:MESA: error: etna_cmd_stream_flush:238=
: submit failed: -28 (No space left on device)
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> index 1661d589bf3e..682f27b27d59 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -310,8 +310,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_conte=
xt *context,
>  	else
>  		ret =3D etnaviv_iommu_find_iova(context, node,
>  					      etnaviv_obj->base.size);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(context->global->dev,
> +			"Insert iova failed, va: %llx, size: %zx\n",
> +			va, etnaviv_obj->base.size);

As this might happen for a lot of buffers in a single submit and
userspace might be unimpressed by the submit failure and keep pushing
new submits, this has a potential to spam the logs. Please use
dev_err_ratelimited. Other than that, this patch looks good.

Regards,
Lucas

>  		goto unlock;
> +	}
> =20
>  	mapping->iova =3D node->start;
>  	ret =3D etnaviv_iommu_map(context, node->start, sgt,


