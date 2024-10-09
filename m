Return-Path: <linux-kernel+bounces-356147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2D995D03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B72280F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7720B0F;
	Wed,  9 Oct 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kxu/HiR5"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983772837B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437467; cv=none; b=LQO86sI8L/1AcxYGT4nWTYjigtIoG8LViivrh55ZoedUJVe+/ObBhwdD5ddg38VLDQC7aU+7aPz7z/ikezCNoHX23N3mEhsEt7w7jmbXSm5Pw0jEWTCCIFHnI24YqTqvh/JC3YkR8BkFaZKPaVkGibP2eJLmf7GG27iW/6kbfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437467; c=relaxed/simple;
	bh=JMZQpgsZnD4QJuBQRATaHjoUH0moyq6IB/wFdyJnpbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnen4s2tAmD89MVKSxKazUeIWLg4ALMh74yddFP20qeOX3Psc64tbzaJ0hXaUWiiC8Dq9uqc4SZP4lwcaN+yE5JRn0YhudesPG1KA88C6eGNdI/bKn+v1LvSwgg44MfxINgM8FtcN6BxbFKCLPtDJ3jIjKtxusVyQJ1LpwsmRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kxu/HiR5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TFsLOBWSv8UQd/8zZ32Lp0PuTYHDd6AQ1gekPW+f/W4=; b=kxu/HiR5RSEi8z+ZqxS5RHRLmT
	hYeRYR5gWep5i8SNJYH9eU7ucjndv5Jb2rv+fkknvNUGZLibT+k1lIQw85f8oavGpUbLBXhks3igB
	0L/haX6LBusDhugCRBo5SCGYE0jg37jCfT4dYW9aIa+nxK6tfFMDK6vFCMiXNW4jKR/gBKv4LvD/J
	eGn0r3RMupG2svg41CGX2UMiTl0x57Z10yPltPJdh/1w6VHPKtzm6Cd59VYo0LGv1o06iojzfCZTG
	L5N92YEUJ7P2FX2cKj+d88hEc8uyfrU0gxZtezy5mbNenjqWwmOaIFcWdf9tuV9LHg3lw0/xct1JC
	qhJP0Klg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1syLXT-006m9f-IW; Wed, 09 Oct 2024 03:30:55 +0200
Message-ID: <a0922d76-0dc0-46a5-8408-a8eda3a07f26@igalia.com>
Date: Tue, 8 Oct 2024 22:30:49 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/vc4: Correct generation check in vc4_hvs_lut_load
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
 <20241008-drm-vc4-fixes-v1-3-9d0396ca9f42@raspberrypi.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20241008-drm-vc4-fixes-v1-3-9d0396ca9f42@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

On 10/8/24 13:44, Dave Stevenson wrote:
> Commit 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
> incorrectly swapped a check of hvs->vc4->is_vc5 to
> hvs->vc4->gen == VC4_GEN_4 in vc4_hvs_lut_load, hence breaking
> loading the gamma look up table on Pi0-3.
> 
> Correct that conditional.
> 
> Fixes: 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>   drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index c5ebc317188a..1edf6e3fa7e6 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -224,7 +224,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
>   	if (!drm_dev_enter(drm, &idx))
>   		return;
>   
> -	if (hvs->vc4->gen == VC4_GEN_4)
> +	if (hvs->vc4->gen != VC4_GEN_4)

Again, another nit: I believe `hvs->vc4->gen > VC4_GEN_4` is more
semantic and it's the standard I usually see around the driver.

But this isn't critical, so:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

>   		goto exit;
>   
>   	/* The LUT memory is laid out with each HVS channel in order,
> 

