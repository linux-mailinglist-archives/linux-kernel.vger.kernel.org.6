Return-Path: <linux-kernel+bounces-261347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493E93B61E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860871C23A48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482B15ECCA;
	Wed, 24 Jul 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KyO+DU8X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5381CD1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843162; cv=none; b=Mz6xfPcjnpFEjxeqQx8crnMa43BFNwx52RVNPSjif2a7AgeSDylxXQfvJU2J82G1a1xAeizNSw382XwAiVlANHHsnEL+k1RHDAJ7EZ5R59/xH+7oEoK0djLqZOIY1LYnJOGD+IrJh4JRYrzDsNn06hIdg3XE3lnblbTItTK2Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843162; c=relaxed/simple;
	bh=aW/2ENY8chSVdPwvE1cXMgxEIAwFHFG8j53H46Zc8GY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S/x8a03Fy7ii+CImcFwVioCFqxOy/qz7E50M/Dz5XV52Th52yrC4gEwICiF91S4BMtWB1rO+YpNUGATvTkS//6HE3HJkCAZZHagpIg/7noY8a2hja8GcRY7dOSJi3HqAqKYzDeUDGHtYEdcEFOfMCf1ae5euL3aRW5iTr4NawdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KyO+DU8X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721843159;
	bh=aW/2ENY8chSVdPwvE1cXMgxEIAwFHFG8j53H46Zc8GY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=KyO+DU8XZx7J6yEyHgQGx/j1xtj9Tq19J7EiaeEtFpTS5u50mLXZUsoN4VoQM9RUt
	 h0ynxXmHRL0nhFuXjdVbvppL2n8VDLbarq6iRH4POvfUUA8n2aFjFlHCftuU8RDoz/
	 bT7s9K8oVpT1GeRxNd31LX+zGa3Xfz6SIF5si0GkY3HvpQjD0V+fhOql1SeHvj2WdF
	 O2ecgo8lQZHtsRTGhp7EnCJfZNTqKZy55zxdjD3I+S4U0cgmBthPCAMQ47cYmXa5ho
	 ik0AoGIgdJUQfVPhtn7NdMZ5kTQx5q62vpoMLBaqvgOhJXCg1LrfwezRx4ucrU5fh7
	 1S0zZxmISzEHA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 47E26378020D;
	Wed, 24 Jul 2024 17:45:58 +0000 (UTC)
Message-ID: <9cd3aa9e-765d-41fc-b9ee-a683656bd7a1@collabora.com>
Date: Wed, 24 Jul 2024 20:45:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Fix type of dma-fence context variable
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240714205009.3408298-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20240714205009.3408298-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/24 23:50, Dmitry Osipenko wrote:
> Type of DMA fence context is u64. Fence-waiting code uses u32 for the
> context variable, fix it.
> 
> Fixes: e4812ab8e6b1 ("drm/virtio: Refactor and optimize job submission code path")
> Cc: <stable@vger.kernel.org> # v6.4+
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
> index 1c7c7f61a222..7d34cf83f5f2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -48,7 +48,7 @@ struct virtio_gpu_submit {
>  static int virtio_gpu_do_fence_wait(struct virtio_gpu_submit *submit,
>  				    struct dma_fence *in_fence)
>  {
> -	u32 context = submit->fence_ctx + submit->ring_idx;
> +	u64 context = submit->fence_ctx + submit->ring_idx;
>  
>  	if (dma_fence_match_context(in_fence, context))
>  		return 0;

Applied to misc-fixes

-- 
Best regards,
Dmitry


