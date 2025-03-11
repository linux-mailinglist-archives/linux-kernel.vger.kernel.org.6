Return-Path: <linux-kernel+bounces-555630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E94A5BA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8243F167E17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771F223710;
	Tue, 11 Mar 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JIQRQO6G"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0C1DE894
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680547; cv=none; b=ZNo+JgZ85/kDsK/MhTeadQId/3DtuoLbP71LcyDvwEJsowsVqjxdg5lbr2Rp/yEeMgRGOWbRscewhMnj7lwgf6jFB0ebxNeEigrkPSESRs91eKa/z+dqdpLWIGP8EHvZ9FfxmMg9g9x6yKD3U/OC1VnRS37y6q0UDB9iDI7pi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680547; c=relaxed/simple;
	bh=JDmQM8Dhze4FKjCBOIy9JrDUTaaxnVukGFxN9fy/cl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDPT68gwVrQs82c9V4ViEyr62Oe7OJCceetmN5ZsIltW/8LLlta4ieQN3lTdkBC1EnACrWc/yLO8PgYyW50YNzyBAXokWQjeFy1CvqmNbdmvfV7K7r0E8hHRbpSuLImipLVHIuvDWBqIyf+N6YTHCn0fmGhPR+ec8i1S83Qc3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JIQRQO6G; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741680543;
	bh=JDmQM8Dhze4FKjCBOIy9JrDUTaaxnVukGFxN9fy/cl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JIQRQO6GB0j4uGLUnX+WM6YlhluKEHd9N8JWH1xxbqlijd6kQ6rTEdZXIfktU8C06
	 wTNBEj3qI8eRm4T5PDZ9/T2KBPS479Xfk+o4A9PJM8v0QIqsZikKzt4d4MiNwAArfp
	 kv60m3OTgSF8ryOydyZyk+pdaSGfqNIWxNZu3jdK1vWzSSFiKHvm2yc12LjANU8JQL
	 jf8+ZOVPuZehRaXOHLlKi2T+9/mm8uOaPeZmErvZ8Vpq32rxxNJ8g6tSjCEH4uDDqm
	 3PAserwgJsV6JI5jM657UDI0NPbBBWuLMYiZy3DDyogOhxrpWC+SG3yq//HTQET2/e
	 Z8nztYk2wWWjA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06E8517E0237;
	Tue, 11 Mar 2025 09:09:02 +0100 (CET)
Date: Tue, 11 Mar 2025 09:08:55 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
Subject: Re: [PATCH v1 6/6] drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature
 flag on Bifrost models
Message-ID: <20250311090855.0211c114@collabora.com>
In-Reply-To: <20250310195921.157511-7-ariel.dalessandro@collabora.com>
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
	<20250310195921.157511-7-ariel.dalessandro@collabora.com>
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

On Mon, 10 Mar 2025 16:59:21 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> Set this feature flag on all Mali Bifrost platforms as the MMU supports
> AARCH64 4K page table format.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_features.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
> index 7ed0cd3ea2d4c..52f9d69f6db9d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_features.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_features.h
> @@ -54,6 +54,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
>  	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>  
>  #define hw_features_g72 (\
> @@ -64,6 +65,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>  
>  #define hw_features_g51 hw_features_g72
> @@ -77,6 +79,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
>  	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>  
>  #define hw_features_g76 (\


