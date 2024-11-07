Return-Path: <linux-kernel+bounces-399674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0E9C02A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EE8281E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540E11EE034;
	Thu,  7 Nov 2024 10:42:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B71EBFF4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976165; cv=none; b=FmHeZfcpN89QoQNFdjCr2js7tg/0MoLC2kwI+FhPwm7A3bpMebjcASymhRefvutk8lVS4eMuf6fdTOoCn5nvye7LKEI89QqOKkGcx4kDtZeob5nmIPQDeJSBcqZ4d7n2PrVZmlLKP02hDo4I/auEbVfDjl0n0f1yvLTchr5m9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976165; c=relaxed/simple;
	bh=GazuDk2dGCtXW6F67WD4+J5kAdo5lRk++17dUiQgWOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcMUelr0Sb0/xcxEloahSgQm0XiExrGO5p2RRTSivfLQ18NCjmVmX+gOVLi/GUW8JcmpnpS2wVtWAcBTaeyhUsa4Q1uaJ8LQQlNDMgPknmRLOGqB2BObZ03milRHLOOS4Nox0PSYBfls9+PBqc7soGzpmjRAxJwQRtZ8gp/211Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F98B497;
	Thu,  7 Nov 2024 02:43:11 -0800 (PST)
Received: from [10.1.30.33] (unknown [10.1.30.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15D5F3F66E;
	Thu,  7 Nov 2024 02:42:39 -0800 (PST)
Message-ID: <c6a3db17-9d07-4337-b500-c65bc5ec9db1@arm.com>
Date: Thu, 7 Nov 2024 10:42:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Lock XArray when getting entries for the
 VM
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20241106185806.389089-1-liviu.dudau@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241106185806.389089-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2024 18:58, Liviu Dudau wrote:
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
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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


