Return-Path: <linux-kernel+bounces-381217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9E9AFC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E412853A8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086111CFECF;
	Fri, 25 Oct 2024 08:06:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5771C7B7C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843618; cv=none; b=oA3m7/HsJZd3r2flySO6IiR9TTPOa0cw5IDZtir4Pk9jgH4qj8rJWdrdxv9vJh+HDp0cihPbl698UrVEGmg/7voib17fIBTQ8FSX50kt1K7ZwqNGYTTVYVv9n39m/N6YlENRUCCRFiY3pz3skhR6KsD1YHF2euHpRAchIe6nxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843618; c=relaxed/simple;
	bh=py1rQHOuFBpdgeIOQg7+7cMMifT4Bz1wRkm8QyHUXiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pu+v+1h3X5u7tuo5p3cA/QiPFQjZyyn2eA/3CayMZow0c4EJxPXy0rlOZDBqppegysTjY144ScOIHo2+NnOxibECTpggwdrLrhaoTqpC/KQQGFkNQKyPuazfbSsKSSsRlP6pfkgabGLw4mOzSYps7/TKOzRHpjAlhGbDkR8x1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t4FL6-0004hU-KX; Fri, 25 Oct 2024 10:06:32 +0200
Message-ID: <14677b6975162c59f5bfbe71aec52f9078ae6f64.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] Fix GPU virtual address collosion when CPU page
 size != GPU page size
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 25 Oct 2024 10:06:31 +0200
In-Reply-To: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
References: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
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

Am Samstag, dem 05.10.2024 um 03:42 +0800 schrieb Sui Jingfeng:
> Etnaviv assumes that GPU page size is 4KiB, however, when using
> softpin capable GPUs on a different CPU page size configuration.
> Userspace still doing the allocation with 4KiB page as unit. This
> results in userspace allocated GPU virtual address ranges collision
> and therefore unable to be inserted to the specified hole exactly.
>=20
> The root cause is that kernel side BO takes up bigger address space
> than userspace assumes when the size of it is not CPU page size aligned.
>=20
> To solve it with no GPU VA range space wasting, we first track the size
> of a buffer that userspace/GPU think of it is, then partially map and/or
> unmap the tail physical page with respect to this 'user size'. Ensure
> that GPU VA is fully mapped and/or unmapped.
>=20
Would you be able to get me a updated series with the feedback taken
care of? I would like to add this series to the next upstream pull
request, if possible.

Regards,
Lucas

> Sui Jingfeng (3):
>   drm/etnaviv: Track GPU VA size separately
>   drm/etnaviv: Map and unmap the GPU VA range with respect to its user
>     size
>   drm/etnaviv: Print an error message if inserting IOVA range fails
>=20
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c |  8 +++--
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h |  1 +
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 42 ++++++++++++---------------
>  3 files changed, 24 insertions(+), 27 deletions(-)
>=20


