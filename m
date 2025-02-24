Return-Path: <linux-kernel+bounces-529134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB42A4202F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219501886A42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22723BD18;
	Mon, 24 Feb 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWVhIiMq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D423BCF6;
	Mon, 24 Feb 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402883; cv=none; b=us4LJS/tZtjI3hHVGHWD4pyteH/fkjvsqVprDs9brmGD2BUl8cJSVpVllkgVHXcUwOU338J73llf/QxKMmEk++00QE3gB+qprLPRM8f4XljQg0ohHLeSYhMJyI6lEl82AHTFHdY0Cn6lYid+mfLjYn6WkBr2MVnma4ZSyVZgD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402883; c=relaxed/simple;
	bh=XiVTLCpQjoG7i4GIZhQDVM3cLNtiY+nfowdB5nwr+lI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLZmiJDYWbsFM34mQCV0V/57nW6o0E3LROZiizCwpTKOZpHCMICLo5GUeKgmp/JwaA3Bht1K0yuMgbh9dgThXD6JPYbdmZuRvp7rSaYl2Lbs1ZrkspcxNdwUqpAmPBqcse/AKNqTIGMUyWzCdeZKXmFQi/JXGAqjQPFuYgiGp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWVhIiMq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740402882; x=1771938882;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XiVTLCpQjoG7i4GIZhQDVM3cLNtiY+nfowdB5nwr+lI=;
  b=HWVhIiMqEwj6YZ5exHDiZxnHJhDVMylwuG6SkE1XkjS7ccghzKy7TJla
   llyuQVyKfgvD+PO8v2D4v8mf/CwETs+XmNmHqCzHu4oHjix9xYJ+zTDev
   eCtA56kvcdd/UbOlNJqgGw4XN2p6GYO/k1k/zKj2MotOqgHjDqMyuqIi1
   ZxHOzB87K+i3Z7QeZOG3Bt7zHHthv9MQ+F7JkMOPYcN+GTXP5KW7xqGf3
   +CTuIsMi0Wjob54cn2gJTGI0asm864jabt7amFE+90u4uvMxzdCQhTss6
   ldSwzrizC1umjduS0HReFqSwgmE/nSUhCFIU+aHeTf3BWpr7M1NoEsBsz
   A==;
X-CSE-ConnectionGUID: 9/BS2fYGS5KbRW5MY8G7qg==
X-CSE-MsgGUID: cEjCMEkNT7W/KXXzhzJbqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40344075"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40344075"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:14:41 -0800
X-CSE-ConnectionGUID: vOJLew+fQQiJ7KeLZRkCvQ==
X-CSE-MsgGUID: FZp77It4RS+Qoz+lHAOAbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115895179"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.133])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:14:36 -0800
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
Date: Mon, 24 Feb 2025 15:14:33 +0200
Message-ID: <87eczn7adi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> The "id" variable is an enum and in this context it's treated as an
> unsigned int so the error handling can never trigger.  The
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

Maybe we want to do something else here... see [1].

BR,
Jani.


[1] https://lore.kernel.org/r/CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com


>  			mutex_unlock(&vgasr_mutex);
>  			return -EINVAL;
>  		}

-- 
Jani Nikula, Intel

