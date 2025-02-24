Return-Path: <linux-kernel+bounces-529343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E5A4231D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7551885B15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61426191493;
	Mon, 24 Feb 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Db/AM0T1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60A16EB42
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407361; cv=none; b=fZfeLa4ca1dI2RBuzdq3P4uG24XKqYoWYG/f3/OznESIIZiRycH+9CclXVkR7AHyKjZnCvu6rtdhHe7Vz80shukdJtzgbRitKja0Sd/1GSs2MmFuIuLi4oEtCmdid7t0fY9OsH6h42ux2lrpljPT+AI+fOZm7ZBL6zawnNZujsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407361; c=relaxed/simple;
	bh=dmpFLg1ecdSuqOmmUqoxFTq+m5PnyBOgLaZ2gXmFR84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7oEvaZD6uoPYNeQTmzMQ/JeYN7YkvfEt8CVB3pG8G1TTrASLDufLMVRKQnVKbtIIiVs+aQ1F+f/WBXuCwwHIiRx6O+XOYaRCfE7iLGGdF3zJaUlnn8XGul7wuLtyeDyupS10ZEp98nYRn5vojhi3Q5Nn4I5o4eRGzAPxDO27Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Db/AM0T1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740407360; x=1771943360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmpFLg1ecdSuqOmmUqoxFTq+m5PnyBOgLaZ2gXmFR84=;
  b=Db/AM0T1xVUfp+6v+DX5EccKk/ZW67VtEpUkesMN4e3N7Z5l3TRFBP8C
   XbolYCGXzosExBFuBbEyc8TfGr5KEoGUQvW1sCY7sqhbWFRWqUQr7og4Z
   Wc20E7/EZBOa0aXp7l6KU7JO0d3cD3YCygt5eXlPLDxjzZI7Sz0uxaryK
   1saiUlzX2Qwi4ZHXEnjdNvRJ3oppalXBJOpSy+Dw2SWL4fnXWVOkYHLZw
   Twr5Lxjscsu4Q2F4M6Bc8NSw8yQfwaX9caWtTc1IJWM3AVJbT0xENGSFb
   B+MKst9NoyFH6llQ7wsmnzK91MATy9QSXBxMB7Eo8zF49z+V6xKq11NRO
   Q==;
X-CSE-ConnectionGUID: zs/mTa0cTkC5j4TYBgxO1g==
X-CSE-MsgGUID: vfqveQfMTD6ItQkaFKGr1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41179665"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41179665"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:29:10 -0800
X-CSE-ConnectionGUID: 0iePib4FSf2eNgfBrf7owg==
X-CSE-MsgGUID: ZXhrhEvLTWOgTMYDmhF4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116557498"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:29:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmZSB-0000000EibU-3puf;
	Mon, 24 Feb 2025 16:29:03 +0200
Date: Mon, 24 Feb 2025 16:29:03 +0200
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
Subject: Re: [PATCH v4 1/2] drm/format-helper: Add conversion from XRGB8888
 to BGR888
Message-ID: <Z7yCLxBN4Cl4btQm@smile.fi.intel.com>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <03FA573F-6D01-40E8-A666-CEA17A917036@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03FA573F-6D01-40E8-A666-CEA17A917036@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 01:38:32PM +0000, Aditya Garg wrote:
> From: Kerem Karabay <kekrby@gmail.com>
> 
> Add XRGB8888 emulation helper for devices that only support BGR888.

...

> +static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)

Okay the xrgb8888 is the actual pixel format independently on
the CPU endianess.

> +{
> +	u8 *dbuf8 = dbuf;
> +	const __le32 *sbuf32 = sbuf;

But here we assume that sbuf is __le32.
And I think we may benefit from the __be32 there.

> +	unsigned int x;
> +	u32 pix;
> +
> +	for (x = 0; x < pixels; x++) {
> +		pix = le32_to_cpu(sbuf32[x]);
> +		/* write red-green-blue to output in little endianness */
> +		*dbuf8++ = (pix & 0x00ff0000) >> 16;
> +		*dbuf8++ = (pix & 0x0000ff00) >> 8;
> +		*dbuf8++ = (pix & 0x000000ff) >> 0;

		pix = be32_to_cpu(sbuf[4 * x]) >> 8;
		put_unaligned_le24(pix, &dbuf[3 * x]);

> +	}

Or, after all, this __le32 magic might be not needed at all. Wouldn't the below
be the equivalent

static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)
{
	unsigned int x;
	u32 pix;

	for (x = 0; x < pixels; x++) {
		/* Read red-green-blue from input in big endianess and... */
		pix = get_unaligned_be24(sbuf + x * 4 + 1);
		/* ...write it to output in little endianness. */
		put_unaligned_le24(pix, dbuf + x * 3);
	}
}

The comments can even be dropped as the code quite clear about what's going on.

> +}

But it's up to you. I don't know which solution gives better code generation
either.

-- 
With Best Regards,
Andy Shevchenko



