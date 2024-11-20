Return-Path: <linux-kernel+bounces-415667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49999D39A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C05B24B80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D71A0BE5;
	Wed, 20 Nov 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NX+o7Tp5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EC1A08CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102901; cv=none; b=H5eBCGSwXUVwtLqcKwwA+3Fk5HVdjD9a+s1JbjrJqbaVVW+jgEP8iI9nbJ8tl7TEN4qLeiFdL78IkZ+ox2DY+zhfCz4KHmncSawOLnyj5N3e3BkQS+1gTFotrSgZ6RtfygNG/ss3TIXYKqdNvhTSBclAU9JgcLzaYlZArmCtjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102901; c=relaxed/simple;
	bh=R89d6A5mpwXuErqQT+DVy8w/GHdyMclAMWFBAG1D84E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfCMJB2m/Z9GWJWpGvGOG6uy+0/HVUFBGyvpJkTarnk29O55KREl/OuUnIjHS/X1+UuOgJW8h4OjVsAbgQeXcFVQFesVIV89amFLLm2TmFBVW+sOrxYLA/sfh4T8+wyP9ZgaJfZIHLHPGZE563FZ9Glgfh5zEcJpDhxluE6Ka+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NX+o7Tp5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732102891;
	bh=R89d6A5mpwXuErqQT+DVy8w/GHdyMclAMWFBAG1D84E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NX+o7Tp5Ee3wuIvWGNWF704zgabeh6RLROGj+n+3cECHTbk4Vu/OMxxDYEYfEZDNg
	 v93h8y46MGAe3Q5gmPmpAm7UOQin/PC3NwR0bFOQKMOzdDtI9YDctNK6VrppyN+rMQ
	 xyRgEJmSOAq9cLxGkMrtZym7Md8+TGaRgLs1NTPda+B6aT7wBy754halz29Upn5Gy6
	 qNoMaLhMQD1c7QCe74MrtGlmydEHUHD+WxeDiwuWwg23bjv2RYN297R8qA+B0k/vO9
	 ijfrv9ZtTe0x89jXxzbpqlh7eR0xV0+nGmG+zx79Xapqo2q3aCYJuI/L1MR/EuZJXu
	 Bu2PKM4gm7D+Q==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B50E17E362F;
	Wed, 20 Nov 2024 12:41:31 +0100 (CET)
Date: Wed, 20 Nov 2024 12:41:25 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Fix compilation failure on panthor_fw.c
Message-ID: <20241120124125.0bf1b9ac@collabora.com>
In-Reply-To: <20241119164455.572771-1-liviu.dudau@arm.com>
References: <20241119164455.572771-1-liviu.dudau@arm.com>
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

On Tue, 19 Nov 2024 16:44:55 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path") forgot
> to copy the definition of glb_iface when it move one line of code.
> 
> Fixes: Commit 498893bd596e ("drm/panthor: Simplify FW fast reset path")
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Liviu, can you queue this patch to drm-misc if that's not already done?

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4bc52b1b1a286..c807b6ce71bd4 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1133,6 +1133,7 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  		 * This is not needed on a slow reset because FW sections are
>  		 * re-initialized.
>  		 */
> +		struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
>  
>  		ret = panthor_fw_start(ptdev);


