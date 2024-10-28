Return-Path: <linux-kernel+bounces-385314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F299B357F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EDE1C21CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1F51DE4FD;
	Mon, 28 Oct 2024 15:57:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFC1DE4F6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131051; cv=none; b=FHCkzHUdDZkOjPFHOL++NudCN/nP03OgaKKu3ta7FNlQKQirTRYafYj0HzMR7EHpMl4O86/fqBI4ruKGWxIVNpSXEVhu/daHAw0W/X/lnpb0mYXxydHWSIvJaImJ713hAMeo8Q0s500QOAnYpG9cx2wAQW2Nkv9Zh7m48mpCAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131051; c=relaxed/simple;
	bh=FsA1HFEdhlkOgFTua5cl1KaG9Wzv2kwPIXTXrwkzvrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNr7whuU8Y5ku7gSRw3eiIqSrTR0DFiBkG6AhFD5gc3c95FvKI2ZSaTqdT9OSqWjndHZAXKxXJ3vQLQskyB8qC/+O0nv8aVlcPx2eB0flTBSNCV09RCEobQPQ43QhHHf2ZcfsadCyC8XdQMvlUDp8N8FpScHmmIJlTXCmNwdPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t5S7O-0004aX-M5; Mon, 28 Oct 2024 16:57:22 +0100
Message-ID: <e3049e426581d913c732b7da2497cd40605bc5bb.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] drm/etnaviv: Fix GPUVA range collision when CPU
 page size is not equal to GPU page size
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2024 16:57:22 +0100
In-Reply-To: <20241025204355.595805-1-sui.jingfeng@linux.dev>
References: <20241025204355.595805-1-sui.jingfeng@linux.dev>
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

Am Samstag, dem 26.10.2024 um 04:43 +0800 schrieb Sui Jingfeng:
> Etnaviv assumes that GPU page size is 4KiB, however, when using
> softpin capable GPUs on a different CPU page size configuration.
> The userspace allocated GPUVA ranges collision, unable to be
> inserted to the specified address hole exactly.
>=20
>=20
> For example, when running glmark2-drm:
>=20
> [kernel space debug log]
>=20
>  etnaviv 0000:03:00.0: Insert bo failed, va: 0xfd38b000, size: 0x4000
>  etnaviv 0000:03:00.0: Insert bo failed, va: 0xfd38a000, size: 0x4000
>=20
> [user space debug log]
>=20
> bo->va =3D 0xfd38c000, bo->size=3D0x100000
> bo->va =3D 0xfd38b000, bo->size=3D0x1000  <-- Insert IOVA fails here.
> bo->va =3D 0xfd38a000, bo->size=3D0x1000
> bo->va =3D 0xfd389000, bo->size=3D0x1000
>=20
>=20
> The root cause is that kernel side BO takes up bigger address space
> than userspace assumes.
>=20
> To solve this problem, we first track the GPU visible size of GEM buffer
> object, then map and unmap the GEM BOs exactly with respect to its GPUVA
> size. Ensure that GPU VA is fully mapped/unmapped, not more and not less.
>=20

Thanks, series applied to etnaviv/next

> v2:
> - Aligned to the GPU page size (Lucas)
>=20
> v1:
> - No GPUVA range wasting (Lucas)
> Link: https://lore.kernel.org/dri-devel/20241004194207.1013744-1-sui.jing=
feng@linux.dev/
>=20
> v0:
> Link: https://lore.kernel.org/dri-devel/20240930221706.399139-1-sui.jingf=
eng@linux.dev/
>=20
> Sui Jingfeng (2):
>   drm/etnaviv: Record GPU visible size of GEM BO separately
>   drm/etnaviv: Map and unmap GPUVA range with respect to the GPUVA size
>=20
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 11 ++++----
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h |  5 ++++
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 36 +++++++++------------------
>  3 files changed, 22 insertions(+), 30 deletions(-)
>=20


