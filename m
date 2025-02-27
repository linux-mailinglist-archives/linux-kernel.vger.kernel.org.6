Return-Path: <linux-kernel+bounces-535997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D8A47A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365DD1714BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4F229B0D;
	Thu, 27 Feb 2025 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UkBMNfiw"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE81898FB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652045; cv=none; b=KapOObbKj7sPp8mqUll2vzWtJL8CiiQTxK+URCf9Pxu1k6Nj8Kx89MBW7qcxz7dkh46BL9W9oSlPoG/Ps2RnsEDteSRyciJ4CNZtiKfhwW9q/X50lKHGjTlIdSNq/FLht4j3ft5x7AgeQJ/IsRL7Qssv+Di3IeX9jdtSTBRPa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652045; c=relaxed/simple;
	bh=RvFsXy3oa5NHjKendf4+P2FG4U01eHfirgYBXuiA+Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt9EW/KquUZ4+H1GT2ject+mcAu+yRaT+pYUocQ/KpYdgQqYxz5YPu1iKDSMKgrIiV1VGb3bTloF7uP+0QOj+arAPocCRnM0BKv99tmDJ52Bs93ye5+MkGCqnnaz8KbPTZObi4nWQvGXTYWvOGXWvVEh4rJA5B59BRWt605VuMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UkBMNfiw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rDZLmU4kaimerfWX6r+jAJ7lSeZafoxmMsiq0Gy6kRQ=; b=UkBMNfiwQqvIYBCCD6fvOqm9wa
	Yh9nsXeszQlijEgSpRaDQT0xBJJcsCMWWnwJNg0oXDpt4Hjxv/FX1TFrbc/au+bpZ6IjkanazHxDT
	nEeRn9bqxD53xxhSYs++PC1FZoUMj7onGlEyoCi18aF1TX1ZGhuBaceUE/ScDj41ImNsUtwTE7QKH
	IXZUDS072kpLZBapTf29EKPB4TJsfwErKOcx0YMHVl6Iz5PrSWligBF+raQrjsaII1NbZN2kbgKfm
	pcrj6GFrickHylGyLJX0okxRDmvx1Xg5iyJyCvYE8hmKzVflMdR8vBM4cU/e9nV1qK83RdYwjmNz0
	3SxqaVMg==;
Received: from [106.101.137.194] (helo=[192.168.11.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tnb6m-001Y3C-Je; Thu, 27 Feb 2025 11:27:18 +0100
Message-ID: <09bc617e-8360-4aaa-8587-2a2bde1f5ef7@igalia.com>
Date: Thu, 27 Feb 2025 19:27:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.15] tools/sched_ext: Provide a compatible
 helper for scx_bpf_events()
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
References: <20250227091138.253809-1-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250227091138.253809-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 25. 2. 27. 18:11, Andrea Righi wrote:
> Introduce __COMPAT_scx_bpf_events() to use scx_bpf_events() in a
> compatible way also with kernels that don't provide this kfunc.
> 
> This also fixes the following error with scx_qmap when running on a
> kernel that does not provide scx_bpf_events():
> 
>   ; scx_bpf_events(&events, sizeof(events)); @ scx_qmap.bpf.c:777
>   318: (b7) r2 = 72                     ; R2_w=72 async_cb
>   319: <invalid kfunc call>
>   kfunc 'scx_bpf_events' is referenced but wasn't resolved
> 
> Fixes: 9865f31d852a4 ("sched_ext: Add scx_bpf_events() and scx_read_event() for BPF schedulers")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   tools/sched_ext/include/scx/compat.bpf.h | 8 ++++++++
>   tools/sched_ext/scx_qmap.bpf.c           | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index 266f94fe479b7..9252e1a00556f 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -183,7 +183,15 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
>   	 bpf_ktime_get_ns())
>   
>   /*
> + * v6.15: Introduce event counters.
>    *
> + * Preserve the following macro until v6.17.
> + */
> +#define __COMPAT_scx_bpf_events(events, size)					\
> +	(bpf_ksym_exists(scx_bpf_events) ?					\
> +	 scx_bpf_events(events, size) : ({}))
> +
> +/*
>    * v6.15: Introduce NUMA-aware kfuncs to operate with per-node idle
>    * cpumasks.
>    *
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index a6c6be308315a..45fd643d2ca0d 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -774,7 +774,7 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
>   	if (print_shared_dsq)
>   		dump_shared_dsq();
>   
> -	scx_bpf_events(&events, sizeof(events));
> +	__COMPAT_scx_bpf_events(&events, sizeof(events));
>   
>   	bpf_printk("%35s: %llu", "SCX_EV_SELECT_CPU_FALLBACK",
>   		   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));

This is a nice catch. Looks good to me.

Thanks!
Changwoo Min

