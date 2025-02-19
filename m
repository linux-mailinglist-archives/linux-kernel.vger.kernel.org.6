Return-Path: <linux-kernel+bounces-521877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9424A3C377
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E97A8D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C195319D067;
	Wed, 19 Feb 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVUdwtTU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3202862B2;
	Wed, 19 Feb 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978297; cv=none; b=BmX+VS6RsLeFs8JYB4S4sAUytN0yx2flcTwjSK4w2LXdfKLhgtjIJnhRs7RbVLFALvN6yeTjDI6YudU3uu1q/TLnigLZ88GExW2wTo+bHBPToQ9jN3UQlyaZ7qrPfcVy76vPnZdw1I5hh2xDfysbNLuaAcatoKz8wLtwJbX/7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978297; c=relaxed/simple;
	bh=+ujEqHIOWz9Mb9bXmB1Kcu9x9LVXuo/LUQYjQcr79uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=foH7k1rMASRgV6GPaamU5DJjo2BD/NTPzuvVRhKZFJTEr+QP/TCPbuu10VjzIhjYYOIPRQk8PGQYuD2UtXkYIbjZ3QZah8vyfviLCa/zEzEnsVZWJ7q0oL2gBBtrBRHRc3Df9uq2RCIDDWNdWN8IyGCNcC08R37+DmjcfvWa/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVUdwtTU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739978296; x=1771514296;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+ujEqHIOWz9Mb9bXmB1Kcu9x9LVXuo/LUQYjQcr79uI=;
  b=BVUdwtTUa4CRDgC18EGqQJvhjN+9JaTlkALvcZX6rpfWZo8KbkXiNkr7
   hGNVUprSKXdvdfLwXD9JfywY2YqLp1Idnrhlh+EERkcoV4UZV5ORrLYch
   vz177rl0x6BgEZcTmgx9wEbX5SbpA7/k5t3AV9q4Gt70l0fC2lGFonSjG
   VRAkhXAPtzOSv+UyxKxK7cECcU9CDZI8/whs1bC8k4AhMFkHkIraUSCCY
   XXZv2PVz7oq7pGppvCq2DpCa5P8Eu1YqImRqVaIOmVpxFFFg/otn7MjP7
   oNK9f0MXB66dND8XZ6A24HleJCrM0yo2aWwRgbmkSc8571XjFRCoa+Cgm
   g==;
X-CSE-ConnectionGUID: 0XxZrwchR3WpDj0bLEb4MQ==
X-CSE-MsgGUID: QwYKL54yQuyj7xQp1Ey7tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58129675"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58129675"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:18:10 -0800
X-CSE-ConnectionGUID: C7UDGHwnROCJnLguSLob3A==
X-CSE-MsgGUID: Sz83G2noTcK9huBU59g88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115395868"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:18:03 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Jim Qu <Jim.Qu@amd.com>
Cc: Lukas Wunner <lukas@wunner.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
In-Reply-To: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
Date: Wed, 19 Feb 2025 17:17:56 +0200
Message-ID: <87zfiim09n.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> The "id" variable is an enum and in this context it's treated as an
> unsigned int so the error handling can never trigger.

When would that be true with GCC?

BR,
Jani.

> The
> ->get_client_id() functions do not currently return any errors but
> I imagine that if they did, then the intention was to return
> VGA_SWITCHEROO_UNKNOWN_ID on error.  Let's check for both negatives
> and UNKNOWN_ID so we'll catch it either way.
>
> Reported-by: Su Hui <suhui@nfschina.com>
> Closes: https://lore.kernel.org/all/20231026021056.850680-1-suhui@nfschina.com/
> Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/vga/vga_switcheroo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> index 18f2c92beff8..216fb208eb31 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
>  	mutex_lock(&vgasr_mutex);
>  	if (vgasr_priv.active) {
>  		id = vgasr_priv.handler->get_client_id(vga_dev);
> -		if (id < 0) {
> +		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
>  			mutex_unlock(&vgasr_mutex);
>  			return -EINVAL;
>  		}

-- 
Jani Nikula, Intel

