Return-Path: <linux-kernel+bounces-529253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2AA4223C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F2C188D748
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042474E09;
	Mon, 24 Feb 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnCk4LS/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACFEAF1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405656; cv=none; b=GL6R6+ThjVK4DeH7JAbXWnvsM0NMrujJ/nDQepLgW5BQOzjKjJQYH1f9yCWSIrkDtakdU5Z2FGuW9mTHu/1iFHfje0tAoQU5jC0lOKAhGa4KQt/T6uew3meAnS+dnZwZPzbiy0X9kb6Ip27K7lGz7qiZCObShkYcGlooJ49TIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405656; c=relaxed/simple;
	bh=7Z65X3uAnnrMTsxGFkCu0G6zCm18r0qbQoTUv+3XTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD2EiUmXco6hz7KPoxMCpCSTed07uLMur8CziZ5FhUtnbv08zzVCciuh4VM5fiiiG9s8enGAm3UDKvuyHgkqFewixNdxoIZFzQIpwHYXeMx+dAJdKDtGuyTKXpegQWv9umJUJGYMVj7tbtw6u/d5KE4dYWUjDlHZWfM710OHyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnCk4LS/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740405655; x=1771941655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Z65X3uAnnrMTsxGFkCu0G6zCm18r0qbQoTUv+3XTJY=;
  b=QnCk4LS/Ac1y/rMHQMPPn2uIaX9Wi2a5mBore5xGz9C55vR2p9sGcaAY
   8f5OO1XLtuLWoRcPUsUPWY/tsH8RZ7sWyUxAcPivyOxKOBcEV9uZHzNwb
   V+Mg94J9Nu9wRJxWNBvYRdrRkRhTLedV/PihFYsmMBqGBdZjMnUIPHSM9
   /olPOotsku1zyXCmz2jQzV7p4PU8bSUrIS7T+x9aJ802d4tMILvc0OUrW
   OA5yKufPGVqtdDPUUTMhEtRBsXgQCcQahIql1PLoFSOCt80Lbyg2nNzej
   T+GjJxdfKMH7/15fdEuQo8vjzYtdpJ7+Bs5PQFbW2AYKygcvJF1ir+3gA
   A==;
X-CSE-ConnectionGUID: 0chBuxBSRFSDk5PwlxyyjA==
X-CSE-MsgGUID: opWq3wjjTcCthahJttFaNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58576179"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58576179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:00:54 -0800
X-CSE-ConnectionGUID: omwNZuk9RwmIZq4cQKjXWA==
X-CSE-MsgGUID: 8k+fUmvKS+K3SkL+2y59lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116270717"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:00:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmZ0q-0000000EiFx-1f8o;
	Mon, 24 Feb 2025 16:00:48 +0200
Date: Mon, 24 Feb 2025 16:00:48 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Message-ID: <Z7x7kMjaDbCp_LB2@smile.fi.intel.com>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 01:40:20PM +0000, Aditya Garg wrote:
> From: Kerem Karabay <kekrby@gmail.com>
> 
> The Touch Bars found on x86 Macs support two USB configurations: one
> where the device presents itself as a HID keyboard and can display
> predefined sets of keys, and one where the operating system has full
> control over what is displayed.
> 
> This commit adds support for the display functionality of the second
> configuration. Functionality for the first configuration has been
> merged in the HID tree.
> 
> Note that this driver has only been tested on T2 Macs, and only includes
> the USB device ID for these devices. Testing on T1 Macs would be
> appreciated.
> 
> Credit goes to Ben (Bingxing) Wang on GitHub for reverse engineering
> most of the protocol.
> 
> Also, as requested by Andy, I would like to clarify the use of __packed
> structs in this driver:
> 
> - All the packed structs are aligned except for appletbdrm_msg_information.
> - We have to pack appletbdrm_msg_information since it is requirement of
>   the protocol.
> - We compared binaries compiled by keeping the rest structs __packed and
>   not __packed using bloat-o-meter, and __packed was not affecting code
>   generation.
> - To maintain consistency, rest structs have been kept __packed.

...

> +#define __APPLETBDRM_MSG_STR4(str4)	((__le32 __force)((str4[0] << 24) | (str4[1] << 16) | (str4[2] << 8) | str4[3]))

As commented previously this is quite strange what's going on with endianess in
this driver. Especially the above weirdness when get_unaligned_be32() is being
open coded and force-cast to __le32.

...

> +struct appletbdrm_msg_information {
> +	struct appletbdrm_msg_response_header header;
> +	u8 unk_14[12];
> +	__le32 width;
> +	__le32 height;
> +	u8 bits_per_pixel;
> +	__le32 bytes_per_row;
> +	__le32 orientation;
> +	__le32 bitmap_info;
> +	__le32 pixel_format;
> +	__le32 width_inches;	/* floating point */
> +	__le32 height_inches;	/* floating point */
> +} __packed;

Haven't looked deeply into the protocol, but still makes me think that
the above (since it's the only __packed data type required) might be simply
depicted wrongly w.r.t. endianess / data types in use. It might be that
the data types have something combined and / or different types.

Do I understand correctly that the protocol was basically reverse-engineered?

...

> +	/*
> +	 * The coordinate system used by the device is different from the
> +	 * coordinate system of the framebuffer in that the x and y axes are
> +	 * swapped, and that the y axis is inverted; so what the device reports
> +	 * as the height is actually the width of the framebuffer and vice
> +	 * versa

Missing period.

> +	 */

...

Otherwise it's nice tiny driver.

-- 
With Best Regards,
Andy Shevchenko



