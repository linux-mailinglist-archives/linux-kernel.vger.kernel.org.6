Return-Path: <linux-kernel+bounces-332469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5D97BA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE78B21E19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD017332C;
	Wed, 18 Sep 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFTQSatV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC41EB35
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651980; cv=none; b=Ho/kh02pt9myecBbFuaJnyn3tS/5g79YjXfG/YMfSoPt42gDY+F5Cei98BzQ9fvdjBCjNDZOCdHaqfMEdIAuzjAsSbltTwU+duT/+08x1iqBXjr0t3fE7J+71twPWRDag1UbyptmFR9HHIrRB61lfDrMmQMsrOiaduNs3phsPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651980; c=relaxed/simple;
	bh=/eQXsqmVGWAgLBwqF5Vlq9oEoff6mAPIoGT3hZ+/WRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3s9frMpfvzoEQ9NPOCJVEKvEn2S9LR/WlpUE6etjeSc7jzfg8HUZ1bDN8T0fYRJmX9DJWbrdj7l/WY+w+PP4rn3h+391OXWgmj1bF4lv0vwe37xWcTE25lp/GZvFjhv4MG1vIzAlfY3NkWN6kG4ht3vZn4Zpat4T0d67UD6rlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFTQSatV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726651979; x=1758187979;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/eQXsqmVGWAgLBwqF5Vlq9oEoff6mAPIoGT3hZ+/WRo=;
  b=aFTQSatVJnySRW52mkj4cAuHzYQVhVLRv6ymWx3vUY0BULBtLqcDbj95
   ilK8XkVollnM9lgVk3EREiGgXaSky9T+BdS1dYOAP8AbU3eVg7G2Eh6X0
   ai+N/bEh36OFoVNWlbF7HiL9x+fUNcqlBA9nsohGHKRjzMppY1y0F/rTf
   pkVfy+pikB2d/b4mSH2THbRJ8CAqnUG4PJhtiPKLH6wtI06o8bwqe4wau
   x1fMKQFRwvb2Pl4W5Sb/AQsCMKQ/pD++14Hl9GiYFwZZ9sTTgVffYz4Xu
   zBhnbO3NCigantID8xliZVMgRDMJialJJSZc5B+NpPsIcRZvFTeGDXBKS
   A==;
X-CSE-ConnectionGUID: eHAxuZGoReSmBzCaN7W7rA==
X-CSE-MsgGUID: 2gmGV4QmQlSlc27rGUZD3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25040531"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="25040531"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 02:32:58 -0700
X-CSE-ConnectionGUID: eATyQLaMSNuGwDYP+GZbsw==
X-CSE-MsgGUID: RKGDUa9nTPGMMY2Hz6S9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="100170565"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 02:32:53 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Shen Lichuan <shenlichuan@vivo.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Shen Lichuan <shenlichuan@vivo.com>
Subject: Re: [PATCH v1] drm/i915/hdmi: Convert comma to semicolon
In-Reply-To: <20240918032804.9269-1-shenlichuan@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240918032804.9269-1-shenlichuan@vivo.com>
Date: Wed, 18 Sep 2024 12:32:50 +0300
Message-ID: <87msk5b931.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 18 Sep 2024, Shen Lichuan <shenlichuan@vivo.com> wrote:
> To ensure code clarity and prevent potential errors, it's advisable
> to employ the ';' as a statement separator, except when ',' are
> intentionally used for specific purposes.
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Already fixed by commit 7cd1049a33ca ("drm/i915/hdmi: convert comma to
semicolon").

Please use the latest drm-tip branch of [1] when contributing to i915 or
xe drivers.

BR,
Jani.

[1] https://gitlab.freedesktop.org/drm/tip

> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index cd9ee171e0df..f2dce9896a48 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -1310,8 +1310,8 @@ static int intel_hdmi_hdcp_write(struct intel_digital_port *dig_port,
>  	memcpy(&write_buf[1], buffer, size);
>  
>  	msg.addr = DRM_HDCP_DDC_ADDR;
> -	msg.flags = 0,
> -	msg.len = size + 1,
> +	msg.flags = 0;
> +	msg.len = size + 1;
>  	msg.buf = write_buf;
>  
>  	ret = i2c_transfer(ddc, &msg, 1);

-- 
Jani Nikula, Intel

