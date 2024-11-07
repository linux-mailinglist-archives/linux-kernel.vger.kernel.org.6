Return-Path: <linux-kernel+bounces-399480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC29BFF77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E5AB223DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8470D19A2A3;
	Thu,  7 Nov 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HybzMa06"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63B17DE36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966371; cv=none; b=Nsps9PN2Y0QeMVtUrCwvg+sfl9eItxZfvCHQnm5m/RtMjDgp+WyAzSCR0oH0Iihk+ksFwt5QSmM32nKSeInqa747XFMcBR5z9Mir46bET3rE+r0wi3mogbwRKMRcQe1ved20SRwiZ4ZJpuuo1aLrzsOHxXE4QFGj2TnpJBmLVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966371; c=relaxed/simple;
	bh=aI1Gn3wfvYIU7Ie1yMvVPfIc5l4MzgNxCYAI6UHRYME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TN0ONt1WJWAiXJapkT7frAppX3D+DyWCbCMp0JbZ6zIMiMWIVG1eTuisyZjEqTD99M3LrHOsXjsSJlCjlyeBqChGJSyCdMfZmTvefr1gwkwpFbYUp1mlg0bPbSlbvGnqj/jkCiT5jSBa5RtFu+rcX5iIvCwzb/LROkeYOPxiDoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HybzMa06; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730966367;
	bh=aI1Gn3wfvYIU7Ie1yMvVPfIc5l4MzgNxCYAI6UHRYME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HybzMa06wlpVsA/FuzUXrFhnpDNIzaj2Kup3/lRz+TlU+E3mzf7VohaNn87AqzVHZ
	 b4BmZ4yk6pXk7sbeIvlNNHzii17UTH5pxjfnirK3+tS4bFNzUK40vEBbuMbGjc3zCj
	 C952MVVR0P0c8ROS+jNWMjTp+aMmVFBhCaEB9pqY++3pjUCyVjSDSIVnGut0b+n2wZ
	 /wIEtpo2Dd1KgUeBwoK3i0Tx8dHIjdEt6/D2jXbJkLwAjSKRiyNq3wpHQfP5fPopGv
	 dY/h7/6mKK51KOvZ64hgAiQ9aqM1McWUtIRY1oMvHXQiZ/Kz6G8eWxL00N9BUJz89I
	 Uf3HznadwIzpw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A27D17E121E;
	Thu,  7 Nov 2024 08:59:27 +0100 (CET)
Date: Thu, 7 Nov 2024 08:59:23 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] drm/panthor: Lock XArray when getting entries for
 the VM
Message-ID: <20241107085923.06707a10@collabora.com>
In-Reply-To: <20241106185806.389089-1-liviu.dudau@arm.com>
References: <20241106185806.389089-1-liviu.dudau@arm.com>
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

On Wed,  6 Nov 2024 18:58:06 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> Similar to cac075706f29 ("drm/panthor: Fix race when converting
> group handle to group object") we need to use the XArray's internal
> locking when retrieving a vm pointer from there.
> 
> v2: Removed part of the patch that was trying to protect fetching
> the heap pointer from XArray, as that operation is protected by
> the @pool->lock.
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 8ca85526491e6..46b84a557d9cc 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
>  {
>  	struct panthor_vm *vm;
>  
> +	xa_lock(&pool->xa);
>  	vm = panthor_vm_get(xa_load(&pool->xa, handle));
> +	xa_unlock(&pool->xa);
>  
>  	return vm;
>  }


