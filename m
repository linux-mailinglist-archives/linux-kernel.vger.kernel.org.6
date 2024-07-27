Return-Path: <linux-kernel+bounces-264185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692093DFF1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C028233E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D418133C;
	Sat, 27 Jul 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dtrPzDin"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F21D52B;
	Sat, 27 Jul 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722093671; cv=none; b=hqZ7S8kmXwsOx366GwzeG5HCVq7VFypDVsKzJJCu/d4jtMUp2FeEAKn0rYfRVgTaE6WXsp2WRn2yKwG75C/LLYW6vqFWZRVUrbg9h2tIbfzZtAk7W0azsBgifAeGmEMqJ1UcNoijgAi6req0r6GzFlqZ1Z3oE6+cq+9pfvpjx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722093671; c=relaxed/simple;
	bh=WtGgi1jB+7GuW/ovN0wMJJZUjOGWtNRhIUs4G2YYmuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW08HPkm2BmU+2MZpusAxVOASg5kr9UbYFZSgJJIkAkdOlXQFUVMA+0P7d5pI4zszmorDu5gtPdySPmzksRp7/t7GMEPu6LNaqyoj6rDT26ORwCq9Gs1Kn0MifXuvEt6vJdj5ZjmYKPwBDd7c0t4jMJ5HnaulE35nvaj6oBILaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dtrPzDin; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722093662;
	bh=WtGgi1jB+7GuW/ovN0wMJJZUjOGWtNRhIUs4G2YYmuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dtrPzDindDUqtKeTfN/U9eGJTxRtiORH+sBa4/KNusvAqNIamb5HittPoxrpr2T9P
	 f+ytVSEqe/UU70hK3AktguP/3/gbUb96f8aMfdxownRIlyezL0gD/EDw3ut5jbYzWX
	 bKgCM1F8uo4JWeJ0T6vZur1olslCOP2QnJkW7voH8o4R5cw+43Y6/pdfp+9fDRna8T
	 vWM06z/XkdocbNZ1fFmmfxU/Qdm42BkQ3oXJM2VF7wan57j+qTMBbyzmioMCyzeSKz
	 OwulObdUDPl3Y9Iq9wJROgy4gU+6I7tfe7fUBV5FiglhZMa+oyBInIrma5JBLdE5zO
	 jWmIL30pe/V+A==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E87837821B7;
	Sat, 27 Jul 2024 15:21:00 +0000 (UTC)
Message-ID: <25a6acd4-551f-439f-bd5d-7026b3b5d2fe@collabora.com>
Date: Sat, 27 Jul 2024 18:20:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: Fix error code in
 drm_client_buffer_vmap_local()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zack.rusin@broadcom.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <89d13df3-747c-4c5d-b122-d081aef5110a@stanley.mountain>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <89d13df3-747c-4c5d-b122-d081aef5110a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 19:09, Dan Carpenter wrote:
> This function accidentally returns zero/success on the failure path.
> It leads to locking issues and an uninitialized *map_copy in the
> caller.
> 
> Fixes: b4b0193e83cb ("drm/fbdev-generic: Fix locking with drm_client_buffer_vmap_local()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/drm_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index 2803ac111bbd..bfedcbf516db 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -355,7 +355,7 @@ int drm_client_buffer_vmap_local(struct drm_client_buffer *buffer,
>  
>  err_drm_gem_vmap_unlocked:
>  	drm_gem_unlock(gem);
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_client_buffer_vmap_local);
>  

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry


