Return-Path: <linux-kernel+bounces-544638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1964AA4E3EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C30884170
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA928F936;
	Tue,  4 Mar 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMMunoU8"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55F28D05E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101427; cv=pass; b=ouRO1tPw4DsXHJ5xwPrybPrU0qU1mq3XzmydPaKwVZM/I2pt4fQ829DgLv51IvThQ0n6eLYnixJfPfe1SAT23a28n6fxSrukOxNa+fymu1zKHnHqzxBDe1yFddrxS1Ntp41qLjLWXIR+WSSDmmmcBMVFYx4auVk0yBVlskJseig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101427; c=relaxed/simple;
	bh=bHj3RuaEvw/XR9ln0JVQ+k18d+4+GPO5j9pqL9juKEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5fDooPOjr7uLb6ynVdO9MlYW51zCPPG/r+dHdo9um5XMy0YZB91DW+UGE3spfzR1UEdeqtfYY8jHb/rJc9H3mZY/V7zgVPqIoqxxzLv+ajPmo1BB39DXryiGYZ/Q5idP0IdEYp79+ioblWZs844RSTEGHmM6ecvY4pbkSZq5T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMMunoU8; arc=none smtp.client-ip=198.175.65.21; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 133B540CF13F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:17:03 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fPr68PPzFyrQ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:15:28 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id AF53142741; Tue,  4 Mar 2025 18:15:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMMunoU8
X-Envelope-From: <linux-kernel+bounces-541149-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMMunoU8
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 606074279B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:28:54 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id F388F3064C16
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:28:53 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F843B2934
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E21F03FE;
	Mon,  3 Mar 2025 08:24:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363B1EF389;
	Mon,  3 Mar 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990290; cv=none; b=JudwpvV83Ez1p6GlUuhczaneJ5/rVI5k4xO9Ur8wCrpNswE9zfYbd/IYPne8JDz3hVpYyM4PhQ1sDnEmNZXw4u1ssSWFvYd95wMTp68Myl37kJ5vOKZTv9jOn/aDNgLaicznN/bYNDy+UHr3/NxbMi4gGeTpDe2WSg9bgLMhz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990290; c=relaxed/simple;
	bh=bHj3RuaEvw/XR9ln0JVQ+k18d+4+GPO5j9pqL9juKEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnQV+lzNJYE1Gwy2Gc117qrUyb7s1cCrjEh30rtcJBpkKhg/RsOTM0B7MfJfXho7S4uM1aJg0EvZFqZ9JExQMEdlbLE24sGR5m8Er845rPe1KpXHDEdJUUH/JLC6JdD1IMqpkWHjn+dinmuIdColWSahaNAWLdRtQdrf39z0zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMMunoU8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740990289; x=1772526289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bHj3RuaEvw/XR9ln0JVQ+k18d+4+GPO5j9pqL9juKEo=;
  b=gMMunoU8kFrHpRKyMk0K4/YlBRGxvCvwTTy0/881zvBOGQRK3J+/idO8
   jNxV/QaC6ljCaMfUmcGlL72RZuwwuWgBrpEESX8TzfkTDuMrjBppZ5GUz
   uRjrFtqnlJOfwcOKoWL9Srpu7dnZk/VwRmjVRefgh10h7GYNDQshEMTAW
   Zu/yNvQkTVhie1fgrjNkFmYUYk13D1meW1U9Cc6rRQuxO8hURGX1g+5z3
   GptPWWZRdWp/XjuaQw0tnStIoryInwmWMWcsIkqaz1//8CgGl+VThwJiQ
   leMJtiUOIvhTCbeka2bnFkLSwMCeDAFrdgu9v9B1Tj8FW9VhtCH8pbCmj
   w==;
X-CSE-ConnectionGUID: u8tlR3PNRKuVHb2i92i7Zg==
X-CSE-MsgGUID: /sK21GK/Sb2oBfrAFQbOOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41767624"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41767624"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:24:48 -0800
X-CSE-ConnectionGUID: yPQlhLDrRXa02V5ZoXrMIg==
X-CSE-MsgGUID: kqL2B0DfRQutGWmtbmIiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118422792"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 00:24:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp16R-0000000Gkma-19iC;
	Mon, 03 Mar 2025 10:24:43 +0200
Date: Mon, 3 Mar 2025 10:24:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mfd: intel_ehl_pse_gpio: Introduce Intel Elkhart
 Lake PSE GPIO and TIO
Message-ID: <Z8VnSyH_DBuJpW2o@smile.fi.intel.com>
References: <20250303044745.268964-1-raag.jadav@intel.com>
 <20250303044745.268964-2-raag.jadav@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303044745.268964-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fPr68PPzFyrQ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706140.89818@UwK11LVcMETt51/DVL1MIQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 10:17:41AM +0530, Raag Jadav wrote:
> Intel Elkhart Lake Programmable Service Engine (PSE) includes two PCI
> devices that expose two different capabilities of GPIO and Timed I/O
> as a single PCI function through shared MMIO.

...

> +INTEL GPIO MFD DRIVER

This also needs to be more precise and follow the name. We have more Intel GPIO
drivers, and MFD doesn't ring any bell about the platform or so. Are you going
to support all of them (existing and comining)?

> +M:	Raag Jadav <raag.jadav@intel.com>
> +S:	Supported
> +F:	drivers/mfd/intel_ehl_pse_gpio.c

-- 
With Best Regards,
Andy Shevchenko




