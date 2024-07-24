Return-Path: <linux-kernel+bounces-261356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5003B93B639
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F68F285132
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166215FA9E;
	Wed, 24 Jul 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BDy2fDbL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E515CD62
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843719; cv=none; b=DcuWSbftbly2MOQ3U9HxgmBuDNxVlcILO5dziWa1JbFw3lAVX3iO3cwtoKNIYRHwobCp7IsJHWwRGqP+fjDvf/6FJAumbOwKbdcy/bvDG472XPoVw/NKSm2/tsI5bYIG/v+EeyIBnbkJGdHoZDL9CW+Nj4KeI6XeiSu81DHR0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843719; c=relaxed/simple;
	bh=+Cz8FMfqaSMVQTCt9LPQa3f7UPH6cU0zFsty7wI3sNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fw31blj7TzEAWo8Y6MXkZNv2GlMksmAUIqE5NUVXXN3/nemdVELwSdc/HNteONa+hQSYNZld2voLtBaKSbDIL8c/NSIQdwXsAMgv8IdUFRhMnt3DwVFRFxx3cMvFPiZm0u5FRcXNsK1Nz/17LmQtNNvNtyTrNjLSysfMWnRl03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BDy2fDbL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721843716;
	bh=+Cz8FMfqaSMVQTCt9LPQa3f7UPH6cU0zFsty7wI3sNc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BDy2fDbL9j9U1m82H+p5L6AIfTBoPApmg9sbJSWHdf8uqZsZSHhR5frvHtXURwwkk
	 mc4FnrFPtZdqee3TYsOjsEmEkE051h3o1faEziwJKOilcSpn/C6mllJQz49B5KSW9h
	 4gwNKoH9omVmwL6YjO62oopO2Pzkzphyx9x4g5uu1X6Hn9KWBhswquzkianRj/8IWr
	 rWP3kYqL5g9KTAPLWGGCS8D0P1ubqalUKyjueF8Ug9hyWNOIyEzRh+gpPWiI6CQBxu
	 +srJYXPCUylazyFl20tIQ3COCHcKmKwiQU2hMwCHfsYMc6QJLT2CLLEQEji4qe8zsQ
	 CaWSY9kBLaF/Q==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E3CFC3781144;
	Wed, 24 Jul 2024 17:55:15 +0000 (UTC)
Message-ID: <7b41a75a-1d52-4cc4-a12e-6ed2be313f02@collabora.com>
Date: Wed, 24 Jul 2024 20:55:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Add DRM capset definition
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240714205502.3409718-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20240714205502.3409718-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/24 23:55, Dmitry Osipenko wrote:
> Define DRM native context capset in the VirtIO-GPU protocol header.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  include/uapi/linux/virtio_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 0e21f3998108..bf2c9cabd207 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -311,6 +311,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
>  /* 3 is reserved for gfxstream */
>  #define VIRTIO_GPU_CAPSET_VENUS 4
> +#define VIRTIO_GPU_CAPSET_DRM 6
>  
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

Applied to misc-next

-- 
Best regards,
Dmitry


