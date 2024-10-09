Return-Path: <linux-kernel+bounces-356137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321BA995CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94DE1F2421B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B9210FB;
	Wed,  9 Oct 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pbKqVmAn"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE153AC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437196; cv=none; b=SfNbq6tz2H+6QgbUmGO++GIMVQoQMWlUj0DDry/+SLR7+JvjN1YUbu729A3cwPYwAOteB8m9S3AY7fk59geQANMRPMELr1eAqWHVPdoFIzmF/z015yJAV4r89PiHIKyzL4SfSf983W9IiPSv0zz2YiC3mvBZHg13MTcGpSZYufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437196; c=relaxed/simple;
	bh=BbvtfkcV45V6WR8XoFEKX6xXRGoPcqEbijqUhr5K5kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBxOz+QR8XdBeVaB32TAC0RttUOGskqtl/S0rtwkiCpgDcREJpQgj2A3pZGl7MCBNFUwGX5PzagZuLaOzpHVAMX++rODrXSmey1IQvpsgO5qfOrcp1lcLM657Eryu9jQvnSVXiS6kofOByy/Z5Os1OJvsoY4jcaAVCcqGvgtK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pbKqVmAn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JAFp916kxOdbCqgaPKFuFD6qIvTJHO6XWM83DvknjCc=; b=pbKqVmAnNfs0aA+HpFlUdWOyhW
	MOpSKo8XGRViIsUpOELcc41IFxIuYuU91nVabFEot4/Ua2LV0U2RnyyUHtYX7vLmo04J+6Pr+jvr3
	eE0KBdo+388dikzilt+fUoUvbnSfnpBnao+7Bt0T1l48tnkOCSsDkvGGVcPc0NWgB9vbjhWQWlG0P
	B0/18lpOYOvEXBdJJdNQdFRseXBpxpBhqg3wAqNp8GQwsZItXymxyHdfGkpwV/9SRACfhplhzyMsK
	XiJYI0Qae+a6XmoCjuXhG6XdiXz3QhHVv8h9uNbkWw5pJ3iBDsAjvowoPwjPJ+ymZg12FY2sk2UK7
	vRgTCguQ==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1syLT7-006m5g-Am; Wed, 09 Oct 2024 03:26:25 +0200
Message-ID: <6a78ccff-915b-4fc6-b677-1301e3d6993f@igalia.com>
Date: Tue, 8 Oct 2024 22:26:20 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/vc4: Match drm_dev_enter and exit calls in
 vc4_hvs_atomic_flush
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
 <20241008-drm-vc4-fixes-v1-2-9d0396ca9f42@raspberrypi.com>
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
In-Reply-To: <20241008-drm-vc4-fixes-v1-2-9d0396ca9f42@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

On 10/8/24 13:44, Dave Stevenson wrote:
> Commit 92c17d16476c ("drm/vc4: hvs: Ignore atomic_flush if we're disabled")
> added a path which returned early without having called drm_dev_exit.
> 
> Ensure all paths call drm_dev_exit.
> 
> Fixes: 92c17d16476c ("drm/vc4: hvs: Ignore atomic_flush if we're disabled")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

With the same comment as PATCH 1/3,

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_hvs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 546ee11016b2..c5ebc317188a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -603,7 +603,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
>   	}
>   
>   	if (vc4_state->assigned_channel == VC4_HVS_CHANNEL_DISABLED)
> -		return;
> +		goto exit;
>   
>   	if (debug_dump_regs) {
>   		DRM_INFO("CRTC %d HVS before:\n", drm_crtc_index(crtc));
> @@ -686,6 +686,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
>   		vc4_hvs_dump_state(hvs);
>   	}
>   
> +exit:
>   	drm_dev_exit(idx);
>   }
>   
> 

