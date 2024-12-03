Return-Path: <linux-kernel+bounces-429968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD969E2CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68CEBA6902
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCDC2040BC;
	Tue,  3 Dec 2024 17:44:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EA202F89
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247865; cv=none; b=YrCwhxZ2GMgOCUHMHfldSV56/c8voWomBoGKmFpWbyrKZyk/gD6VQTpNmaNuPKgd+DajPwWQbiA40WErauq/65bx0FxsuYuNVuSnD7fnAGXZeY/32PakIpJEJl7Qs62pJa5ci6uIqy6qjmEOJEjXuyxL4FWc5VjtUb3ukjKPKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247865; c=relaxed/simple;
	bh=9CatxZSKXXQBXV+zaeOK+ndAnZDN/lxTNr5+fdQThI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9dzG5cZANlYifGyaV2ti4S1Pr4IBzyHnXxi4VtVodAw801p77NH0UwdLB1dFC/shgF8W/CNRCs1N02FNxAEvwOupnVgCTo9h469d7jxbd6fFwA/Uj2lzEo6xbe//NFwLqi2ylPaXM2q4Wo4lhNXNIFM5w5yrzUzT56jEgfdcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIWwX-0003We-RH; Tue, 03 Dec 2024 18:44:13 +0100
Message-ID: <5b5cd19556613e3e1190f23c052120bb3995860e.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/3] drm/etnaviv: Trivial mmu map and ummap cleanups
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 18:44:13 +0100
In-Reply-To: <20241115123246.111346-1-sui.jingfeng@linux.dev>
References: <20241115123246.111346-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
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

Am Freitag, dem 15.11.2024 um 20:32 +0800 schrieb Sui Jingfeng:
> The 'sg->offset' denotes the offset into a page in bytes, but under drm
> subsystem, there has NO drivers that etnaviv can contact that actually
> touch the 'offset' data member of SG anymore. This means that all DMA
> addresses that sg_dma_address() gives us will be PAGE_SIZE aligned, in
> other words, sg->offset will always equal to 0.
>=20
> But if 'sg->offset !=3D 0' really could happens, then the current impleme=
nt
> might be not correct. Previous commits[1] fix the 'sg->offset =3D=3D 0' c=
ases
> effectively, below is a simple illustration.
>=20
>        One CPU page       Another one CPU page
>   +----+----+----+----+   +----+----+----+----+
>   ||||||              |   ||||||              |
>   +----+----+----+----+   +----+----+----+----+
>   ^    ^                  ^    ^
>   |    |                  |    |
>   |    | .----------------'    |
>   |    | |    .----------------'
>   |    | |    |
>   +----+ +----+ +----+
>   |||||| |||||| |    |  GPU pages, each one is SZ_4K
>   +----+ +----+ +----+
>             Correct implementation.
>=20
> --------------------------------------------------------------
>=20
>        One CPU page       Another one CPU page
>   +----+----+----+----+   +----+----+----+----+
>   |///////////////////|   ||||||              |
>   +----+----+----+----+   +----+----+----+----+
>   ^                   ^   ^    ^
>   |                   |   |    |
>   |      .------------|---'    |
>   |      |    .-------|--------'
>   |      |    |       |
>   |      +----+       |
>   |      ||||||       |
>   |      +----+       |
>   |       IOVA        |  GPUVA range collision if use 'sg_dma_len(sg)'
>   +----+ +----+-------+  directly to map. Because 'sg_dma_len(sg)' is
>   |////|/|////////////|  frequently larger than SZ_4K.
>   +----+ +----+-------+
>             Wrong implementation.
>=20
> If we map the address range with respect to the size of the backing memor=
y,
> it will occupy GPUVA ranges that doesn't belong to. Which results in GPUV=
A
> range collision for different buffers.
>=20
> Patch 0001 of this series give a fix, patch 0002 and 0003
> do trivial cleanup which eliminates unnecessary overheads.

Thanks, applied to etnaviv/next.

Regards,
Lucas

> v2 -> v3
> 	* Reword and improve commit message
> v1 -> v2
> 	* Reword and fix typos and mistakes
>=20
> v1 Link: https://patchwork.freedesktop.org/series/140589/
>=20
> Sui Jingfeng (3):
>   drm/etnaviv: Drop the offset in page manipulation
>   drm/etnaviv: Fix the debug log  of the etnaviv_iommu_map()
>   drm/etnaviv: Improve VA, PA, SIZE alignment checking
>=20
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>=20


