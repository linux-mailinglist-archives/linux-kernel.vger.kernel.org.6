Return-Path: <linux-kernel+bounces-376920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB39AB77F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511AB287820
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F01CBE84;
	Tue, 22 Oct 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WyayMeny"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47B1CB328
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627978; cv=none; b=qRTW7Yym/JAnRB9C88puZdtw8iRdBAQHUd/gD4m/xc2B4p0135rkuf6XV+aDEXi3BNUKjjFJw/mzlEg23vp9hyv404OQxU6ecyS7sqUbkUjgJrF1T6L5ht//6r90E5xg8MqFqjYrwtzJZj1v9h2veQpvumjAwx+vgTdX/f8NYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627978; c=relaxed/simple;
	bh=zCR64HFl95lvxcsBR7QrQNObUf0OVrJECCE+eNAIKM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNDAkUDdfpVlt0tQMAn4t508Sjg0Iv3lvNCxX5J2cQCZe/DT9U8z8BOBBPrg3WttQuMjxilbOmtnRMDbOJiaqT0MNMQesItahZ+VuD1cIAs/H+C6zlxhwcQlgVgiUuUO77apmIZPq5heCdLzh2vtzxlzgxE4CWkcU19t7HsbWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WyayMeny; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+9wATrRaNKvQSpJMImeBUhzHEx7yflVLEZaMwAZ4MEE=; b=WyayMenyNnUZ7NNU82yzkA1aj/
	L2fndHRje5cVhnD8QtmAJSO7nkARexvm8sppiypDpN1J/hLQq4UXstKrIyOitQeC+Ni4BiAYHlVW9
	8DcmyhrGCxSAKvfxersQ1avoG3KqwAskatsFNEf7hZWtvowGAgmqXvH+y+XklDEspO5rMQiGKvuX4
	709cI93hlKnQCaoEssRqkEPPEt21r0idWW3igAGInowUC65hVq28GPPhGFM4XDWl58nRAHr8Ijxyr
	8MggCNqoZzjbd0w/i8keAIKTZpTVtjcJHzDjm0qxU8mE6nhkWRxEYVrRELK/mGMhhpWxVplIh5GRO
	0osKzd1g==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t3LFB-00DkcB-GN; Tue, 22 Oct 2024 22:12:41 +0200
Message-ID: <8f050428-53b0-401f-a60f-3d4732c0a75f@igalia.com>
Date: Tue, 22 Oct 2024 17:12:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, Christian Gmeiner <cgmeiner@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241020204156.113853-1-christian.gmeiner@gmail.com>
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
In-Reply-To: <20241020204156.113853-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/24 17:41, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> This patch adds a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, which
> allows the configuration of a global performance monitor (perfmon).
> The global perfmon is used for all jobs, ensuring consistent performance
> tracking across submissions.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_drv.c                 |  3 ++
>   drivers/gpu/drm/v3d/v3d_drv.h                 | 10 ++++
>   drivers/gpu/drm/v3d/v3d_perfmon.c             | 49 +++++++++++++++++++
>   .../gpu/drm/v3d/v3d_performance_counters.h    |  6 +++
>   drivers/gpu/drm/v3d/v3d_sched.c               | 10 +++-
>   include/uapi/drm/v3d_drm.h                    | 15 ++++++
>   6 files changed, 91 insertions(+), 2 deletions(-)
> 

Hi Christian,

I have one major issue with this approach: I don't think we should
introduce a `global_perfmon` in `struct v3d_perfmon_info`. `struct
v3d_perfmon_info` was created to store information about the counters,
such as total number of perfcnts supported and the description of the
counters.

I believe you should use `active_perfmon` in your implementation and
don't create `global_perfmon`. This is going to make the code less
tricky to understand and it's going to make sure that the hardware inner
working is transparent in software.

Only one perfmon can be active in a given moment of time, therefore,
let's use `active_perfmon` to represent it.

I couple more things came to my attention. First, I don't think we need
to limit the creation of other perfmons. We can create perfmons and
don't use it for a while. We only need to make sure that the user can't
attach perfmons to jobs, when the global perfmon is enabled.

For sure, if we go through this strategy, there is no need to have a
count of all the perfmons that V3D has.

I would prefer to treat the global perfmon as a state. Ideally, we would
enable and disable this state through the IOCTL.

One last thing is: don't forget to stop the perfmons when you don't use
it anymore :)

Best Regards,
- Maíra

