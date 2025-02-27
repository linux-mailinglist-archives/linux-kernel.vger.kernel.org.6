Return-Path: <linux-kernel+bounces-536638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0AEA48255
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B2A175883
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533625E81E;
	Thu, 27 Feb 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lAnbFDsG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8B235361
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668148; cv=none; b=IAsdgxKs45yADFwx9iyNZDF0alfaeAZAMv3jviDOz7iZEnaZb9iVeVCudvXvFNTpnKfOHSmATipriQzfbn5NcwofvkiTJSobpyT5rfBD2T51BuIeIJdn0IZ4eaiyCgJ5rHWaM0iBeL/6mwFbLyheqQm+6tOMNH02w3SKxTRrsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668148; c=relaxed/simple;
	bh=4dno5vBh22aYtl3Z9Df8BPGW9j1ybKlDStdsMmYD354=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3bilZdY2edBNoWk6Hi4l5HKbFFnQb3fdbSwc6Q6HB4r8DvIXkS3vVqQwpNw+a1/7ls3nz9YfIMhzMXC2+0voomx7bcca6iW5ICbu+AuvccwKEg5nI/slI4nzQqgn+ROUG38HZiJRWhZqR1V0HrTDABvA3TBmFpFqVvfiIyfA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lAnbFDsG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740668145;
	bh=4dno5vBh22aYtl3Z9Df8BPGW9j1ybKlDStdsMmYD354=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lAnbFDsGga/v+vxybKW7lz/QeoHTd54aTEz9fqdEQwnIM1461iwno0TJOh/RrykQ7
	 VYw9CKWJaE27YAvwRLpU7YLj05j7PI+iT5ZcgWockyQo0eXPhN71SlRBUWJak9wYSg
	 XNgCElnd1DU1tjO1G57LyX1nxj7NBiJxKaw+yZNGt6GKahACQpOdxy+sJl6fcnuFqu
	 LagcITCtXVGsmSlZyFwhIdSUyhrz68Tuqi5qhphqQnt9Rm1BRlpo3ghcOLV1PD0xp+
	 5mNsVdMS+I/ZyFpx43axToP/0D/qB4ptqdil39hXS7z3/fjL6dJ+IlJqccco1jjKYz
	 joD63awNO4ILw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9BCCD17E09E7;
	Thu, 27 Feb 2025 15:55:44 +0100 (CET)
Date: Thu, 27 Feb 2025 15:55:39 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC PATCH 3/4] drm/panfrost: Support ARM_64_LPAE_S1 page table
Message-ID: <20250227155539.59944e18@collabora.com>
In-Reply-To: <20250226183043.140773-4-ariel.dalessandro@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
	<20250226183043.140773-4-ariel.dalessandro@collabora.com>
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

On Wed, 26 Feb 2025 15:30:42 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> @@ -642,8 +713,15 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>  		.iommu_dev	= pfdev->dev,
>  	};
>  
> -	mmu->pgtbl_ops = alloc_io_pgtable_ops(ARM_MALI_LPAE, &mmu->pgtbl_cfg,
> -					      mmu);
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
> +		fmt = ARM_64_LPAE_S1;
> +		mmu->enable = mmu_lpae_s1_enable;
> +	} else {
> +		fmt = ARM_MALI_LPAE;
> +		mmu->enable = mmu_mali_lpae_enable;
> +	}

How about we stick to the legacy pgtable format for all currently
supported GPUs, and make this an opt-in property attached to the
compatible. This way, we can progressively move away from the legacy
format once enough testing has been done, while allowing support for
GPUs that can't use the old format because the cachability/shareability
configuration is too limited.

