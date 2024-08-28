Return-Path: <linux-kernel+bounces-304445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD20962026
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104C5B2127E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EA61581F2;
	Wed, 28 Aug 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6xGqxM6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9894D108
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828307; cv=none; b=aP7QCIfdB1CpIksVnk7BuSEmxgLntnjQVUYxtI4g3zQCBWjq5SrtgYYdN2R+ZyQcamx0UubWBsnYY4Ne7xskGGvQzMrF32LC+/gXFZx1FZDpy+Hue1F+qrGQkolbe2eKiYBMww44IyUI2vHmTkqhQt7kXhgw2oUN1KRzVnDm8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828307; c=relaxed/simple;
	bh=wfqAgOhaK8jZJJGedj5Y/u8XaA7hh+dHLk9BAC/wSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtX5FcqhlcHbkpHKylEKPwqCzinYBMlFaOjXsMjvfw6aD/SiobGg6FZdMJndqq66EPOZbKNWoq8QRRN6mKyTCyBm0ogAv5tkOn3CQ5Q7TibgRAHT0V0RRlDyb2g4OcsS9e2wn5BvSpqSDrcd7U2Pd3rSXNT8x/Hcs88YtElxJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6xGqxM6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724828305; x=1756364305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wfqAgOhaK8jZJJGedj5Y/u8XaA7hh+dHLk9BAC/wSDQ=;
  b=A6xGqxM6n701NlQFQrMrsEVB2r0jaVDyyWuJPTxTJqW7xYl5FDYlu2yO
   NuHlUUBvPpleues1ms11MXJfGEkmL9e7YLE50ZnmQ9ed3Kkb+RnaUhTfS
   n3kOxXULk07RIPMZkqIdQyJ0o0ZrgZ6aJ5Zz/XK335tmx/3R3xlHP/ouI
   Q0oKOU/NMx3Hd8pCHsG1v0WhEgga7aSOyWYrFjcMmQNHmeA5x6A+HJW/H
   hnmTIQ609AUKoJb/jVeSj6msoUJrrcUF8xv/Bf1gizqlG0SSG38+ufaB1
   5Hfngi16vY3wD2DIOU94xRtoGolRdo2Bce/AnZQOlQ4cdiZ3nI5MvSB37
   g==;
X-CSE-ConnectionGUID: k6Kip5dTQ6ymtci6LiSq+Q==
X-CSE-MsgGUID: 0x7qDZszSymkx5LIyli2rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27220608"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="27220608"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:58:25 -0700
X-CSE-ConnectionGUID: 4O2nbH07QE6r5Gfe0d5uLA==
X-CSE-MsgGUID: 7vNjQTuQQa6+p59pDGnP6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63116074"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:58:24 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7BC2E11F8B3;
	Wed, 28 Aug 2024 09:58:21 +0300 (EEST)
Date: Wed, 28 Aug 2024 06:58:21 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Robert Mader <robert.mader@collabora.com>
Cc: linux-kernel@vger.kernel.org, jacopo.mondi@ideasonboard.com,
	javierm@redhat.com, kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v2] media: i2c: imx355: Parse and register properties
Message-ID: <Zs7KjVvDHRXSOP5S@kekkonen.localdomain>
References: <20240811111718.22513-1-robert.mader@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811111718.22513-1-robert.mader@collabora.com>

Hi Robert,

On Sun, Aug 11, 2024 at 01:17:04PM +0200, Robert Mader wrote:
> Analogous to e.g. the imx219 driver. This enables propagating the
> V4L2_CID_CAMERA_SENSOR_ROTATION and V4L2_CID_CAMERA_ORIENTATION
> values so that userspace - e.g. libcamera - can detect the
> correct rotation and orientation from the device tree.
> 
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Please always CC the linux-media list for Media tree patches. I've resent
this to linux-media this time.

-- 
Kind regards,

Sakari Ailus

