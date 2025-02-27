Return-Path: <linux-kernel+bounces-535825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87781A477BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C9A188667B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A122371B;
	Thu, 27 Feb 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SZ2E1/Wd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACF1E520D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644744; cv=none; b=sSkBRcBD3pVTxAT02odRoY8dX100/C3DUMEkNl4o+l50ASZPWw8HQdl2+cN76LsgBubzKoWj4yLU7M4HVNuL7DGw04D4Rhmgn0wlD/I2T/pLex79A0T8D4OYqpPwCv319sHa7NRC5/HKlIBYioqXS2ZY/0RTYNk0qbr8Yu6rGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644744; c=relaxed/simple;
	bh=L5y2u+6ZbVsG8e8AdeI8M9nMozRubd1dS8820cxPBNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxv1fD/TeQGufKD+VD4YvDawlHBqVdaQUEL5dtnyhSG+T1h8cSvp1rNIyNXE5di/b63/c612NgZ4BTlhK+IeNRw4NlkbgQQkvSO0YZ/ky7PdpHJmZqetnQ8dOqJvhAUhvvUK9ZbwFh32JDkieuYjQqDpqTL7VaSf1o2aWKfZOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SZ2E1/Wd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740644740;
	bh=L5y2u+6ZbVsG8e8AdeI8M9nMozRubd1dS8820cxPBNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SZ2E1/WdINttx2bEUkYV+minAB18jXR4dU4vwrXDEIAPDc76Q1wveRu5yvL9oyVZ5
	 nu01LAQ/IAvWhTbdK+KIkSHrq5ws2SZ9RJN16PGKfLksEPFseZpVIRyNZvLet5S5cb
	 nTwH406+g/8pS7uQQd8bDZZUPNF4OdcK+HSUAhnN+F5lR2lf20x7eZePbDsW4LBNfL
	 ScbnYqZ4uy6scl/NtXwTxCb2CrgBxATgxsNNqucalL4bOWFkLvxy1L1JDvO2WPQX2r
	 t3qMzGNCWQVVe64Y1NhQB9LHiVyiDem3PKmbuEUXxWlf9KREFsMKlYSifJwe54p8Xl
	 xcBH4Yg5a8WAw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E2E117E0605;
	Thu, 27 Feb 2025 09:25:40 +0100 (CET)
Date: Thu, 27 Feb 2025 09:25:37 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC PATCH 2/4] drm/panfrost: Split LPAE MMU TRANSTAB register
 values
Message-ID: <20250227092537.63053596@collabora.com>
In-Reply-To: <20250226183043.140773-3-ariel.dalessandro@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
	<20250226183043.140773-3-ariel.dalessandro@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:30:41 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> The TRANSTAB (Translation table base address) layout is different
> depending on the legacy mode configuration.
> 
> Currently, the defined values apply to the legacy mode. Let's rename
> them so we can add the ones for no-legacy mode.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_regs.h | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index b5f279a19a08..4e6064d5feaa 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -317,14 +317,19 @@
>  #define MMU_AS_STRIDE			(1 << MMU_AS_SHIFT)
>  
>  /*
> - * Begin LPAE MMU TRANSTAB register values
> + * Begin LPAE MMU TRANSTAB register values (legacy mode)
>   */
> -#define AS_TRANSTAB_LPAE_ADDR_SPACE_MASK	0xfffffffffffff000
> -#define AS_TRANSTAB_LPAE_ADRMODE_IDENTITY	0x2
> -#define AS_TRANSTAB_LPAE_ADRMODE_TABLE		0x3
> -#define AS_TRANSTAB_LPAE_ADRMODE_MASK		0x3
> -#define AS_TRANSTAB_LPAE_READ_INNER		BIT(2)
> -#define AS_TRANSTAB_LPAE_SHARE_OUTER		BIT(4)
> +#define AS_TRANSTAB_LEGACY_ADDR_SPACE_MASK	0xfffffffffffff000
> +#define AS_TRANSTAB_LEGACY_ADRMODE_IDENTITY	0x2
> +#define AS_TRANSTAB_LEGACY_ADRMODE_TABLE	0x3
> +#define AS_TRANSTAB_LEGACY_ADRMODE_MASK		0x3
> +#define AS_TRANSTAB_LEGACY_READ_INNER		BIT(2)
> +#define AS_TRANSTAB_LEGACY_SHARE_OUTER		BIT(4)

How about we keep AS_TRANSTAB_LPAE_ here and prefix the new reg values
with AS_xxx_AARCH64_ when there's a collision between the two formats.

> +
> +/*
> + * Begin LPAE MMU TRANSTAB register values (no-legacy mode)
> + */
> +#define AS_TRANSTAB_LPAE_ADDR_SPACE_MASK	0xfffffffffffffff0

It looks like we're not use AS_TRANSTAB_LPAE_ADDR_SPACE_MASK, so I'm
not sure it's worth defining the mask for the AARCH64 format.

>  
>  #define AS_STATUS_AS_ACTIVE			0x01
>  


