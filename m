Return-Path: <linux-kernel+bounces-214536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A828908620
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B421C211F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15218410E;
	Fri, 14 Jun 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESPVHlhV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854131836E9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353213; cv=none; b=jvep4fAVOSFJOlWg8LOwsjrRlVltjIdcWQqwX3BGrxgDVa/uaGIof6vo6K/sKqIggVZPSwmMp8cBVSm+U6BQe0DfnDjxyXEAlmtRusH4ZcdY++vdkaT8ZfMBnP2+7RRnVnYe/knNQ2DpdlvopjdZi28WwKLYyBI2AtnUUfHYakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353213; c=relaxed/simple;
	bh=X5c8MpgPj5qYJRYA2r6eJqb0Ao5dFb7mECFRWBRRy5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKfk4K8gRLQdjRZI/WJKxhf6Y2ZBam2qr8OyD0+7gedHg/d88kCNOKgEByvuGOhazoQIqTuScndWcEqP2LL0XrgeBv9QTnzRnl9WM+rxSprHuaXCVhPsaEEKLXVtSpTzKrsII45YwL5pAuT5UbtRgOAvV2JW4/AdgmAgwbWGaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESPVHlhV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718353213; x=1749889213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X5c8MpgPj5qYJRYA2r6eJqb0Ao5dFb7mECFRWBRRy5I=;
  b=ESPVHlhVAvuQL3yNp6S8bIXGxGPAkSlE9TAUHAiZVzTKhxG9L2kVePGp
   bgk0FYYaW9Vr4vJX256YgvcOKNVaPC19X7E9EEhpZUiS9vqBP1hNsYe4q
   V7/RSSZTaFjwsX/DL7yh1iFDQdPnCOKo7hjzoCY8ojq3D0bmRh0N9t+mO
   u5CZGcc2Ix4ONPdtFfTIUu8jbhMnNBLPrVIqHexU4h3VsdaRxF4tK4xP/
   MsHB78rSGHYblzQni0ua29YTdNrjAnyYbTey4KEoZ+5AeMHapuZXF1nU0
   iRbMg1aX1ewbS3vWbZcYIyXgJue5lmWXBJgvHZGg4E6r8aVGAa2BqYpJE
   w==;
X-CSE-ConnectionGUID: cMUqStjYRlG/uzEM08jlbA==
X-CSE-MsgGUID: aGDdTfuhQT6/iFB6ENxgbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="26647530"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="26647530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:20:12 -0700
X-CSE-ConnectionGUID: 75RvTaFVTNqMTJeyBeohXA==
X-CSE-MsgGUID: e/Qc+JhnSSi1q2GQGbHQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="71630247"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:20:10 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5670311FBC0;
	Fri, 14 Jun 2024 11:20:08 +0300 (EEST)
Date: Fri, 14 Jun 2024 08:20:08 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
	Andreas Helbech Kleist <andreaskleist@gmail.com>
Subject: Re: ERROR: modpost: "i2c_acpi_new_device_by_fwnode"
 [drivers/media/pci/intel/ipu-bridge.ko] undefined!
Message-ID: <Zmv9OLoxDxPI9de_@kekkonen.localdomain>
References: <202406111148.Jbw7a5GF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406111148.Jbw7a5GF-lkp@intel.com>

Hi folks,

On Tue, Jun 11, 2024 at 12:06:38PM +0800, kernel test robot wrote:
> >> ERROR: modpost: "i2c_acpi_new_device_by_fwnode" [drivers/media/pci/intel/ipu-bridge.ko] undefined!
> >> ERROR: modpost: "i2c_find_device_by_fwnode" [drivers/media/pci/intel/ipu-bridge.ko] undefined!

Sorry, forgot to cc you. I posted this
<URL:https://lore.kernel.org/linux-i2c/20240614081418.2506288-1-sakari.ailus@linux.intel.com/T/#u>
to address this, the I2C dependency can then be removed. I'll post another
patch for that.

-- 
Kind regards,

Sakari Ailus

