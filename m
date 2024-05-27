Return-Path: <linux-kernel+bounces-189937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DA8CF764
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4CE1C20F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106232905;
	Mon, 27 May 2024 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R0I4gFhU"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353165C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716775592; cv=none; b=m41B3yyAdJCrpvH35A1VEJFvr9+m4bRUsUtZhWvd1BOctLyHIqlJ1kkpPAy9FiAowsHeFKANeNmXWsQkQdnuZVVKJ4nIUDrn8lhr/UnSx74ba1fNbD2TzmOSJaNobIOxUkHkzXMT3jVrS/7+JJ9wigDBTDzNGNXl3Smp5cw0q5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716775592; c=relaxed/simple;
	bh=0KXo3AVNLqFRMvDu3wkXyLN6vqXMeAZYhcWh5lY34Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgQQtN7O55ztWG6bazlyr4hQ3cdKQSv6QzNhmqycsfNs+3GApCzSKxUdtJmic2Ye0GpCpCXT3kYb3y6q4qm5BeuM0lF/Fh2UDeCBbh99vVvFjykeM+FPbBF+mQScsMmYd2sMhFlK22eqXAz3DgIIl+snrxHlnmpT0UVRbCulFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R0I4gFhU; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lkp@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716775587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7LCmvAxIYOVvpO6R7p76ccCzHXaBGKk9+emyZM3oos=;
	b=R0I4gFhUK6m7i9mSKwrVEjUcuiQ1P348IpC4440HcrJJg7bv6fYwAUySXV/SGhGgW9zlcs
	yRo1ZDvzT9KfhmZN1HyrVdbVP8WmWV6zwxd+Lt9BvZv3HUYlCjZQ1yneLKl0pIaQKGp6zs
	25rFeoQthB26h4E/mFz+m0YD3ZEZe4c=
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: llvm@lists.linux.dev
X-Envelope-To: oe-kbuild-all@lists.linux.dev
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <db39b18b-b941-44b8-abeb-d06c5cc087d7@linux.dev>
Date: Mon, 27 May 2024 10:06:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 02/10] drm/bridge: Set firmware node of drm_bridge
 instances automatically
To: kernel test robot <lkp@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240526202115.129049-3-sui.jingfeng@linux.dev>
 <202405270622.VDMbp9FR-lkp@intel.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <202405270622.VDMbp9FR-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/27/24 07:33, kernel test robot wrote:
> Hi Sui,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on drm-exynos/exynos-drm-next]
> [also build test ERROR on linus/master v6.10-rc1 next-20240523]
> [cannot apply to shawnguo/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-bridge-Allow-using-fwnode-APIs-to-get-the-next-bridge/20240527-042402
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
> patch link:    https://lore.kernel.org/r/20240526202115.129049-3-sui.jingfeng%40linux.dev
> patch subject: [PATCH v6 02/10] drm/bridge: Set firmware node of drm_bridge instances automatically
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20240527/202405270622.VDMbp9FR-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405270622.VDMbp9FR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405270622.VDMbp9FR-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/gpu/drm/omapdrm/dss/hdmi5.c:487:49: error: expected identifier
>             drm_bridge_add(&hdmi->bridge, &hdmi->pdev->dev.);
>                                                            ^
>     1 error generated.
> 
> 
> vim +487 drivers/gpu/drm/omapdrm/dss/hdmi5.c
> 
>     480	
>     481	static void hdmi5_bridge_init(struct omap_hdmi *hdmi)
>     482	{
>     483		hdmi->bridge.funcs = &hdmi5_bridge_funcs;
>     484		hdmi->bridge.ops = DRM_BRIDGE_OP_EDID;
>     485		hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>     486	
>   > 487		drm_bridge_add(&hdmi->bridge, &hdmi->pdev->dev.);
>     488	}
>     489	
> 


Sorry, my bad. I have do compile test on ARM64 before posting.
checkpatch.pl report a style problem, then I manually modify this
patch, accidentally add the tail '.' character. Will be fixed
at the next version.

-- 
Best regards
Sui

