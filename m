Return-Path: <linux-kernel+bounces-570858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FDA6B575
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38AF3AC478
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5D1E9906;
	Fri, 21 Mar 2025 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zgi6IX72"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C25433A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543298; cv=none; b=ocR8S+Kmf6OPYXVYkjQzE5wm5JpgSgDxaF7dJrAeECl+vlAdrMwCaZeHUy8UUVwKpSpqK+Y1fM6WH/QWbxYP8jFg4R1zk9kj7Bj3klmb6V14YNeCq4d8oVsHlfwd7TNy7xU+KEqYZQQY/tmZbqFU6m/663zkM4mULV36vYiBzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543298; c=relaxed/simple;
	bh=46YpdeKsPmWTrIvWN8WZQtRqKCeBWAjbWlNsZ71Qz1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWkMitWsvtAuuxaG3IGMWu4EjU6CsNnCj0SrOR3wkSX5YiWgl/wkqkwuMluF+xY9NQVVupMdPHOqC5W75AGYNYL+BaggvGp5cOQXQEAmBJFpcX0UADhRrNRInlek47lnWNpdAwR6AyD8zvMI24RCAJi5/1AJA0ljrjuXs3RW/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zgi6IX72; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742543294;
	bh=46YpdeKsPmWTrIvWN8WZQtRqKCeBWAjbWlNsZ71Qz1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zgi6IX727uyPcSdRfvA1G6qCvfCttkvhaEJ4zB3U3H7tFMEPnU2oBrfx8hqcL3L3t
	 pUGeeFolSuc56K2dWrEr1JJaoc+EjSLDIbLWeJv/AbBzWTnp97gHXptvaOxEoQzTrJ
	 TzALBPXBZwYvgYEHGqq5AO4H22YLt8rP8RQGQsT42cqC6EenqexE533e76PMrNGyln
	 Z3wiCse5x0VnYpGckEX6oYTSeLVct0h+uAQ2d+s4viIT90k1Kea4ah4Cswkr8R6Csh
	 i2ctmla5tPwl0M4aOGu6fPe8pqTKjIcMeYuBnOdVwaomi+aiGdF9e/fHiwzk8g42zy
	 zmBtXVPcEVD7g==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C19CF17E0C38;
	Fri, 21 Mar 2025 08:48:13 +0100 (CET)
Date: Fri, 21 Mar 2025 08:48:09 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] drm/panthor: Add 64-bit and poll register
 accessors
Message-ID: <20250321084809.5f217049@collabora.com>
In-Reply-To: <20250320111741.1937892-2-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
	<20250320111741.1937892-2-karunika.choo@arm.com>
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

On Thu, 20 Mar 2025 11:17:33 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> This patch adds 64-bit register accessors to simplify register access in
> Panthor. It also adds 32-bit and 64-bit variants for read_poll_timeout.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_regs.h | 55 ++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
> index 42dc3fedb0d4..7ec4a1d04e20 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -238,4 +238,59 @@
>  #define gpu_read(dev, reg) \
>  	readl((dev)->iomem + (reg))
>  
> +#define gpu_read_relaxed(dev, reg) readl_relaxed((dev)->iomem + (reg))
> +
> +#define gpu_write64(dev, reg, data)                            \
> +	do {                                                   \
> +		u64 __val = (u64)(data);                       \
> +		gpu_write(dev, reg, lower_32_bits(__val));     \
> +		gpu_write(dev, reg + 4, upper_32_bits(__val)); \
> +	} while (0)

We're not doing funky name concatenation in these macros, so I'd rather
have them defined as static inline funcs in panthor_device.h. We
probably want to move the gpu_read/write definitions there as well if
we do that.

> +
> +#define gpu_read64(dev, reg) \
> +	(gpu_read(dev, reg) | ((u64)gpu_read(dev, reg + 4) << 32))
> +
> +#define gpu_read64_relaxed(dev, reg)  \
> +	(gpu_read_relaxed(dev, reg) | \
> +	 ((u64)gpu_read_relaxed(dev, reg + 4) << 32))
> +
> +#define gpu_read64_sync(dev, reg)                     \
> +	({                                            \
> +		u32 lo, hi1, hi2;                     \
> +		do {                                  \
> +			hi1 = gpu_read(dev, reg + 4); \
> +			lo = gpu_read(dev, reg);      \
> +			hi2 = gpu_read(dev, reg + 4); \
> +		} while (hi1 != hi2);                 \
> +		lo | ((u64)hi2 << 32);                \
> +	})

I would name that one gpu_read64_counter and make it a static inline
function. Note that we already have panthor_gpu_read_64bit_counter()
which does the same thing, so maybe move it there and rename it along
the way.

> +
> +#define gpu_read_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)    \
> +	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false, \
> +			  dev, reg)
> +
> +#define gpu_read_poll_timeout_atomic(dev, reg, val, cond, delay_us,         \
> +				     timeout_us)                            \
> +	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us, \
> +				 false, dev, reg)
> +
> +#define gpu_read64_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)    \
> +	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false, \
> +			  dev, reg)
> +
> +#define gpu_read64_poll_timeout_atomic(dev, reg, val, cond, delay_us,         \
> +				       timeout_us)                            \
> +	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us, \
> +				 false, dev, reg)
> +
> +#define gpu_read_relaxed_poll_timeout_atomic(dev, reg, val, cond, delay_us, \
> +					     timeout_us)                    \
> +	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,     \
> +				 timeout_us, false, dev, reg)
> +
> +#define gpu_read64_relaxed_poll_timeout(dev, reg, val, cond, delay_us,         \
> +					timeout_us)                            \
> +	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us, \
> +			  false, dev, reg)
> +
>  #endif


