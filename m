Return-Path: <linux-kernel+bounces-538527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65FA499A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA766172D07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2426BDA8;
	Fri, 28 Feb 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVK2ydqE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC926738F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746644; cv=none; b=WhA48AhgbM02QHx1Cd13Fj8qmuBGpI4mxaDAZ+gLxBD5o1fgXbF0lilh2m+j46rmzR+Y5k02TwFVfijb4w6ItQWGo6XqDvhoY9YszcZNHtDHBh4TzXxWxKL1I14jtcizv+jb0rxm5GhWM723fR1XGmBZX+w8zTHZ4WKN83MwRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746644; c=relaxed/simple;
	bh=QpwP5dDbs++pwyXHcXaib60iS3oSbodKiBqpIqSeB0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3vqA1ThcZuymghQg8B/peHVNVXdW1xPquW+W/A3oaL7zZH+0w52zpZd1DOJe0q3+qXQHSip/VSaIefIuayZI4WabxPw3BR6krYdxbJKV7vG1ckqdSrtqhNEqSlWb6trRh1BnA59+D27Bh4WyP0tA0TJU4N24+OCT1tl3nAekd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVK2ydqE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740746642; x=1772282642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QpwP5dDbs++pwyXHcXaib60iS3oSbodKiBqpIqSeB0Y=;
  b=JVK2ydqEtKZ3Gi8rFPWftmQaUk0D5BtOHb9IcYj/4gXUR6aouUPc0hV+
   SoHDzIRofiejIA64XQysglbQJvnvGwHuKZ0Kxs7RECD5jBM2VCwnsLPG2
   hQNat67hFe5e1N4YdTGc7VJ1NlIa+uxu9bm6E4aX6umN2omO6MLSIrUZH
   0URDfgUyC92d1EsnRSSUU6T0opv7kyZOuMAAx/KiOcIG9gJqsVOUM1Pdt
   J4Gd34UsUpUxXS/H+mZdmlXoMyGsXqygCxJFP7e8wVMoxy/xVg6me8W/y
   1sTQteQIa8U0u8ZrpXRkoTXXTJ5xqZIpFk7IIEv9zsmMfRthhXz6yEAmA
   w==;
X-CSE-ConnectionGUID: en5Nl6J9S021TFPA97eO3w==
X-CSE-MsgGUID: aN/WSH9FRJyfO3mOkpt+yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52317169"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="52317169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:44:02 -0800
X-CSE-ConnectionGUID: G8n7rWATTs6d/GMpgK4HCA==
X-CSE-MsgGUID: zbl+3/OSSkCP/0QSjq2TAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117085125"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:44:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzif-0000000FwlI-2gOJ;
	Fri, 28 Feb 2025 14:43:57 +0200
Date: Fri, 28 Feb 2025 14:43:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: xiaopeitux@foxmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Split devres APIs to device/devres.h
Message-ID: <Z8GvjSUdl6dGx1UE@smile.fi.intel.com>
References: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
 <9a2d29f3-3e8b-4851-b481-cc72cd804ea6@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a2d29f3-3e8b-4851-b481-cc72cd804ea6@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 05:28:56PM +0800, Pei Xiao wrote:
> 在 2025/2/28 17:18, xiaopeitux@foxmail.com 写道:
> >
> > Since a21cad931276 ("driver core: Split devres APIs to
> > device/devres.h"),but some APIs like 'devm_alloc_percpu' didn't move to
> > devres.h. we should also move it.
> sorry, I forgot to modify the subject. This is an RFC.

You don't need to have it as an RFC, just base on the resent changes.

-- 
With Best Regards,
Andy Shevchenko



