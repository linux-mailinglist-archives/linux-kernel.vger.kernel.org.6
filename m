Return-Path: <linux-kernel+bounces-520074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C1A3A55D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772963B596E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C8274248;
	Tue, 18 Feb 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sooZ/3QH"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA8274244
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902716; cv=none; b=gLiz/p7MO5OHpCt++xZXmmP3fGDET0jtLg/izwO4XapRvJ9M4BhadqjjULXBfpJQRTBxJlUXhAGxIDb/tbFeHfdfRDkoBzJFdmxcH313+SEYrvW88V+jX/k0QVGPSg3mtNSGd08VqbfXgPH+9qSU/5tr9+2Tds+j/NgzX4vkMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902716; c=relaxed/simple;
	bh=hfzZdfOKpQbXFbOoMsaUFV2yirnnitYfWgxWHNz+MGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz4oSO8Hc20GICS+0PMnNvQgcYoeCeluUp8hAozpN+twazmSXI70ls+0UCZBSS4dFYF/3Il1nwee6OAGQXMoJki/qiADrXHkJAQfdhWfxw8p8dYjCSw6ojEOW/5BpzI1+O5wtRw0jCfVuQllWF2UX8TvAfgJAKadZxtLKFFl2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sooZ/3QH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wLZah36tLm4xOWwJU55Pxm/enxSsJZjr9oUwxC7JWZg=; b=sooZ/3QHQye4tgIwF7EprYtpTw
	QfZjyavNYFnQTwhE2F5c9qB8uGoSIwJYwl1ADhN8au46xyjeCB96YDChy0F1hzlEPTcwm/MQYP7VE
	SxkC8Pg8mmz4KS492SepYPEs2SI+msvtk7fwBdtcni/DPIkhcJS1eWHXuWc5rPEbK7Nch7uPVuNJD
	fRFw28flOpN9HXNa8azfYnezZChgSLgYtKyu/7hNQsZZUtrRnQ+aPfapTnYUrdyb0vCxLJJFx3xJQ
	idc0J7D0IWV3RzLbGz+hLFQMTYrojQdbik78Kcep0okhgnoVNMOsERQ0TgJs7KL5EHO5NjAcmX+Me
	pjCVP2nA==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tkSAj-00BPDZ-4t; Tue, 18 Feb 2025 19:18:23 +0100
Message-ID: <3c7da108-4692-4456-ad23-7e5d51f0f606@igalia.com>
Date: Tue, 18 Feb 2025 18:18:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/sched: Fix preprocessor guard
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250218124149.118002-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250218124149.118002-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 18/02/2025 12:41, Philipp Stanner wrote:
> When writing the header guard for gpu_scheduler_trace.h, a typo,
> apparently, occurred.
> 
> Fix the typo and document the scope of the guard.
> 
> Fixes: 353da3c520b4 ("drm/amdgpu: add tracepoint for scheduler (v2)")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> I just discovered this. But I have little understanding of what is going
> on in this header in the first place, so I kindly ask for comments on
> this entire guard line with its logical or ||
> 
> The code hasn't been touched since 2015. So it seems it at least didn't
> cause bugs.

No other header includes so it never caused a problem.

> P.
> ---
>   drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index c75302ca3427..f56e77e7f6d0 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -21,7 +21,7 @@
>    *
>    */
>   
> -#if !defined(_GPU_SCHED_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#if !defined(_GPU_SCHED_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
>   #define _GPU_SCHED_TRACE_H_
>   
>   #include <linux/stringify.h>
> @@ -106,7 +106,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
>   		      __entry->seqno)
>   );
>   
> -#endif
> +#endif /* _GPU_SCHED_TRACE_H_ */
>   
>   /* This part must be outside protection */
>   #undef TRACE_INCLUDE_PATH

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


