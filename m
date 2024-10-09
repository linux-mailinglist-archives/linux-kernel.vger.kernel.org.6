Return-Path: <linux-kernel+bounces-356429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5039960F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C0A1C20D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793417E472;
	Wed,  9 Oct 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM+fpfwK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673D36D;
	Wed,  9 Oct 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459211; cv=none; b=P99Cfx6p8CN/qStiiXj8he2X5EjUAYhLoj8e7uPnGdKgjRCPB6IKy//606xDAr+2l2OlbG8mln6s1nM99TqkosK7FuheMuO0NXEO+ttFM4TyAhXWOIRgATz3NfEMbsMgTr04lxZpSffwHJqt9CrF+gY1ziMT1rAs1mFOGF3MWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459211; c=relaxed/simple;
	bh=8GAHgHjYxQwFO+o1uKFke1ZThRSGSbbBWN09VFfVzG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8Uoo2VodE59UQ1BPvSipOJVEOfdpU9tqZPSRD6rCos5rHoxLtHF4iIZ3bCFfLmRfQN0RwzIihRTUyzIhIkHozhrw4AFJcW4ACEXsL2WviAOAAIsTTSR5AY8Rk+20Qnl2l6ycHZQn8DoFH53fSf+zvbKEXHewjL3EJXLF/lGf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM+fpfwK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728459210; x=1759995210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8GAHgHjYxQwFO+o1uKFke1ZThRSGSbbBWN09VFfVzG8=;
  b=bM+fpfwKz+hOdiuuRYzAP8pCKDeKp68nAGQExi06OCo1Vy6dBK+tuFUX
   +VksJXNN/+VC7oskRXwnoUwbtdCa7CwjKNXz0pyLwWGM0bLAatDcRRao8
   4oDUidc4frLuJhED+ALAdQq8ydZ78TAIpKrz7R+qjvOV1yf3q76jXIyrc
   IdyoPdhVYOAyw707Nm2BqQJIqXM9lzpGJqK+a77P2h0qGpnceitUiBdkb
   /KeAhqPd8lKsbJS8iS5svgWMtUwa/1cRtK9AoWiLA8iQXK1d8cj1Siexi
   Ua8W/3z37v/aNQASdYtTc/jEyBjlpx+tEcLmRq08kP0KqEbCs5P1d2xrh
   Q==;
X-CSE-ConnectionGUID: 4jCPJq6CSJSfQEWpmqKksg==
X-CSE-MsgGUID: ITpv7/aRTnaMPE4N0iVxcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15363062"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="15363062"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:33:25 -0700
X-CSE-ConnectionGUID: tdgdPtR0Qvqsq/70+BP1ig==
X-CSE-MsgGUID: Voobu18BRZO1Pj0HNgctpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="106921699"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:33:20 -0700
Message-ID: <737eeb51-b5eb-4585-a9d2-f1578b21d86f@linux.intel.com>
Date: Wed, 9 Oct 2024 09:33:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] usb: add apis for sideband uasge tracking
To: Guan-Yu Lin <guanyulin@google.com>, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com,
 yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com,
 perex@perex.cz, tiwai@suse.com, tj@kernel.org, stanley_chang@realtek.com,
 andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr,
 quic_jjohnson@quicinc.com, ricardo@marliere.net, grundler@chromium.org,
 niko.mauno@vaisala.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, badhri@google.com, albertccwang@google.com,
 quic_wcheng@quicinc.com, pumahsu@google.com
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-4-guanyulin@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20241009054429.3970438-4-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/2024 7:42 AM, Guan-Yu Lin wrote:
> Introduce sb_usage_count and corresponding apis to track sideband usage
> on each usb_device. A sideband refers to the co-processor that accesses
> the usb_device via shared control on the same USB host controller. To
> optimize power usage, it's essential to monitor whether ther sideband is
> actively using the usb_device. This information is vital when
> determining if a usb_device can be safely suspended during system power
> state transitions.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>   drivers/usb/core/driver.c | 54 +++++++++++++++++++++++++++++++++++++++
>   include/linux/usb.h       | 13 ++++++++++
>   2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 0c3f12daac79..c1ba5ed15214 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1673,6 +1673,60 @@ void usb_disable_autosuspend(struct usb_device *udev)
>   }
>   EXPORT_SYMBOL_GPL(usb_disable_autosuspend);
>   
> +/**
> + * usb_sideband_get - notify usb driver there's a new active sideband
> + * @udev: the usb_device which has an active sideband
> + *
> + * An active sideband indicates that another entity is currently using the usb
> + * device. Notify the usb device by increasing the sb_usage_count. This allows
> + * usb driver to adjust power management policy based on sideband activities.
> + */
> +void usb_sideband_get(struct usb_device *udev)
> +{
> +	struct usb_device *parent = udev;

Is it really "parent" in this case? Perhaps better variable name would 
just be "device".

> +
> +	do {
> +		atomic_inc(&parent->sb_usage_count);
> +		parent = parent->parent;
> +	} while (parent);
> +}
> +EXPORT_SYMBOL_GPL(usb_sideband_get);
> +
> +/**
> + * usb_sideband_put - notify usb driver there's a sideband deactivated
> + * @udev: the usb_device which has a sideband deactivated
> + *
> + * The inverse operation of usb_sideband_get, which notifies the usb device by
> + * decreasing the sb_usage_count. This allows usb driver to adjust power
> + * management policy based on sideband activities.
> + */
> +void usb_sideband_put(struct usb_device *udev)
> +{
> +	struct usb_device *parent = udev;

Similarly here.

> +
> +	do {
> +		atomic_dec(&parent->sb_usage_count);
> +		parent = parent->parent;
> +	} while (parent);
> +}
> +EXPORT_SYMBOL_GPL(usb_sideband_put);
> +

