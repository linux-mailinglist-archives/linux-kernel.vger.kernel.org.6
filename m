Return-Path: <linux-kernel+bounces-564267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7CA6518F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0772188BCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767E23ED66;
	Mon, 17 Mar 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hym0kP32"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4C8F5E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219091; cv=none; b=IYHFM8BC4VwegyJXrmGDkYayQcFVP3dNcTR3KGX4jwAn/w2pSA6OMcgRyQwD/MHlc/SrkgWlbrgfwL8Y1zqPvYywe8+BEvyL+ZKVc52b19+96mLaU2fYeDSwnjOPgjI7iSnHeK59C88kUTXeA6NenAupZyTfnDSpnChWWTEd4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219091; c=relaxed/simple;
	bh=JVmdQyfU6VNsa3dSvwc3s1VX9bvBvzsEOdDC3T1SiXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTjG8x6P4ru6NtfUrD2O6OmjEHlgqlNuyPMGzmCjelWmKvVMVgkJ5tvVsuAswN5R9ds5I1fnQ919yhCK4L3cqHyLngcur3pIWGU4nmB+8MHeupqGBMrmK+xH/tuxMsVFKEdjE0TCL/aMOKC1EbQWRu4/XsG29AtrvvD8wt6AHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hym0kP32; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742219087;
	bh=JVmdQyfU6VNsa3dSvwc3s1VX9bvBvzsEOdDC3T1SiXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hym0kP32VXeZ9Y8swpAitB2ywPMwWIR5TMF0ZqbdOKyF5ZCGo/j69C8vFQo1klT9a
	 KZHEs1A4efzgf8ekooXaM3aeUER2GS/vKf1xtfCMyT8gLn2hyi1XhAi8Uysd0tUVT2
	 rVeECek1J5hB+k0sg3QHTjhhpOuuRu3bTfbVAMPPYFoPRsv9x1J37Wu9wDPQQr5Jpe
	 z+c73PZyXXL/SkZyTRx0vxSLu0QzAOt9xqM1toDpL1KMUnFhiKD4nh3QXhsSk+aFmh
	 joKJC3NpkTf0DWN0JcVyed1m9YzGiY7avd49Vu1INRQ+CtF+ZuFK/l5k+kPP83q1Us
	 enqrkhPs5W1KQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91ADA17E0899;
	Mon, 17 Mar 2025 14:44:46 +0100 (CET)
Date: Mon, 17 Mar 2025 14:44:36 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com,
 angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 4/6] drm/panfrost: Add support for AARCH64_4K page
 table format
Message-ID: <20250317144436.2bcc17ed@collabora.com>
In-Reply-To: <20250317124044.16257-5-ariel.dalessandro@collabora.com>
References: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
	<20250317124044.16257-5-ariel.dalessandro@collabora.com>
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

On Mon, 17 Mar 2025 09:40:42 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> +static int panfrost_mmu_cfg_init(struct panfrost_mmu *mmu,
> +				  enum io_pgtable_fmt fmt)
> +{
> +	struct panfrost_device *pfdev = mmu->pfdev;
> +
> +	switch (fmt) {
> +	case ARM_64_LPAE_S1:
> +		return mmu_cfg_init_aarch64_4k(mmu);
> +	case ARM_MALI_LPAE:
> +		return mmu_cfg_init_mali_lpae(mmu);
> +	default:
> +		/* This should never happen */
> +		return drm_WARN_ON(pfdev->ddev, -EINVAL);

This won't return -EINVAL, but !!(-EINVAL), AKA true. We should do

	default:
		drm_WARN(ptdev->ddev, "Invalid pgtable format");
		return -EINVAL;

instead.

> +	}
> +}

