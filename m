Return-Path: <linux-kernel+bounces-314763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF0096B822
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25401C24731
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70A1CF7AC;
	Wed,  4 Sep 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4+V7wep"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEA1CF7A3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445166; cv=none; b=Tb0ug6iiMTD20k82qLj/WYNvdleZvp2vOJzZwPbmF4I5cvyXXoiXr9e53qp55+7ikWjJAsAzTIWpdfboxIdKe8qSv8+sbDoyh5SCHHtjTmh3cILuLw1mL3+iyELYJpG/HTmLzKiB5GGZmH3bO3lUbtxRxR/NoxUCXIBvwXhS0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445166; c=relaxed/simple;
	bh=N0PbBy5Ao6MuNdFdvZuksajIlLLWYbIn7QFeG11lzhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVeYRHQ9spcSRPMyfrN/AxXU/gxJ/F3QGAE6725lRKMcsMo+P5KTHcwRBvhixQs4dHAla0W1cjXCeK5oL9nOWf56h9rNNrQ6gl3FggSmolFmd8G7zYTmCIXGPX9Bo8ktJEPyWdktJx7DoqtLR8tGs53hQcw2Ei8RK4VuwzVVx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4+V7wep; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725445164; x=1756981164;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=N0PbBy5Ao6MuNdFdvZuksajIlLLWYbIn7QFeG11lzhw=;
  b=I4+V7wepwQaVzS38YEzC48SxV+vV/ehkShbNptwNaLE9TWmYHIuQTIzd
   exGqGnE/1EM9rLxPPLEfuEaetHdhj7NjfA5T8Ti7oZAWqMVOkZDQkjfY1
   62u/RziHcZtvR7QEiu808+8ZjN0f7ATlAH8yQqIWslnrmoFcMPXItMdg1
   nmccDo874QE9QbEiuYbbZK5xRUfQFGafwMeUzL7ilXR4y4X60uDQkxdr9
   vnSyuZWvOWqLq9s1jjaNk3mMZL9uFEwa2iJIiLjX9PW8gDQh2aOyph6IB
   JBpHjiUQq0oeT4eTdLXvFcw0l6QRvLybiPUyiYvxWGCX1SlRq5w9Un3Ff
   g==;
X-CSE-ConnectionGUID: OebRU4qCR1KhZSNgfIJcfA==
X-CSE-MsgGUID: sPWtt7M6ScKCv64+5KKmyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46625975"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="46625975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:19:23 -0700
X-CSE-ConnectionGUID: d8UJR7GcQOO8qqCwn9qMwg==
X-CSE-MsgGUID: EA2wnQljRe6rygHZktpMIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69622166"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.18])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:19:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Chen Ni <nichen@iscas.ac.cn>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 daniel@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Chen Ni
 <nichen@iscas.ac.cn>
Subject: Re: [PATCH] drm/i915: convert comma to semicolon
In-Reply-To: <20240903025558.493977-1-nichen@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240903025558.493977-1-nichen@iscas.ac.cn>
Date: Wed, 04 Sep 2024 13:19:01 +0300
Message-ID: <87frqfsove.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 03 Sep 2024, Chen Ni <nichen@iscas.ac.cn> wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 19498ee455fa..00e98a5ede09 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -1313,8 +1313,8 @@ static int intel_hdmi_hdcp_write(struct intel_digital_port *dig_port,
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

