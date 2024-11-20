Return-Path: <linux-kernel+bounces-415695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBA59D39F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FEE281497
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B31A4E76;
	Wed, 20 Nov 2024 11:50:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227619E98A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103452; cv=none; b=NsZcj+HLAM9fQjIYkXI+ufhIj/qGZwHJ+k9rDa+N+RmRSsipBGg9F9c1rsJuU80eLT7/WHatf0VpibN1tfrBNBHEYFFrxBZg7IBnR/442OsfRoWUVgJlp2G9Jk1Iw35sgyVJ+BvaCoUes4z5TtPJ2l5t1RpNkNoZfEg8l0ynWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103452; c=relaxed/simple;
	bh=aqLwPDjO5w3h/OT2nmvlsOV0Oto5sNvZsa/9a+ktrtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVWqX/J7rTSzpC0qtvu6ysknLv+20FDHybR/Kjm9bP6Iow0+GPUIP3elNaYnXqFvI+pcHiqP86GN+7/GZ9wIohGIdwhX3HHJw/xUovWQftSzm6Oi7YIM6zqmvWXXDzcW1W0/Zlz9wpIQo9nJvRv+MC0AecLVsyRIpCbUNKhtrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4815E1480
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:51:20 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 131C03F66E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:50:49 -0800 (PST)
Date: Wed, 20 Nov 2024 11:50:45 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com, ketil.johnsen@arm.com,
	florent.tomasin@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH v2 0/3] drm/panthor: Coherency related fixes
Message-ID: <Zz3NFRSF1GEbtbEN@e110455-lin.cambridge.arm.com>
References: <20241030225407.4077513-1-akash.goel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030225407.4077513-1-akash.goel@arm.com>

On Wed, Oct 30, 2024 at 10:54:04PM +0000, Akash Goel wrote:
> This patch series contains 3 cache coherency related fixes for the
> Panthor driver.
> - The first fix, regarding the Inner-shareability, is mandatory to
>   ensure things work on all platforms (including Juno FPGA) when
>   no_coherency protocol is selected.
> - The second fix regarding the coherency feature/enable register is
>   required to avoid potential misalignment on certain platforms.
> - The third fix, regarding the potential overwrite of buffer objects,
>   has been prepared speculatively & it may not be required in practice.
> 
> v2:
> - Added r-b tags for the first 2 patches
> 
> Akash Goel (3):
>   drm/panthor: Update memattr programing to align with GPU spec
>   drm/panthor: Explicitly set the coherency mode

Pushed the first two patches to drm-misc-next.

Best regards,
Liviu

>   drm/panthor: Prevent potential overwrite of buffer objects
> 
>  drivers/gpu/drm/panthor/panthor_device.c | 22 ++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_gem.h    | 10 +++++++++
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  9 ++++++++
>  drivers/gpu/drm/panthor/panthor_mmu.c    | 28 +++++++++++++++++-------
>  4 files changed, 60 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

