Return-Path: <linux-kernel+bounces-447328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025469F3094
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A464A1884FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079A204C1E;
	Mon, 16 Dec 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLCH1V0b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F11FF7BE;
	Mon, 16 Dec 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352341; cv=none; b=SCXrmXep4Td3pKycm6E75co+KyfkxLVBuokLrZF9G504xECJSCbonxg5KJIFWs0F5z/B9ftIa4bMHLOqqcai6UuuBlBIyNrYZUFsTZr2/dEAa61GYciRiQo2DMcW0ue3iBFfII0YmnuAgjl3xnmoHZVu5bRGBXT0KyAqJRuNwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352341; c=relaxed/simple;
	bh=ebp+GV9iiNe1ASJtxy2jknV0QqmU90H/gr4FUm/fQwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5UUdyfcAAOcPMOuwS8FuEsh6q9l29wxcRm2xY3xWZ+CIQLLP15A/oLDvsfZ1cDYpnjahg2tuLJmmVcr4vm7VLg5KPvLb6+OsHeMBaJtYe/66zLXyCCSZaivj2ZFnMf8kuzyy/4v1jwxJn0RVijq2dp6DpOGM+xAyouuFl3GnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLCH1V0b; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734352340; x=1765888340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ebp+GV9iiNe1ASJtxy2jknV0QqmU90H/gr4FUm/fQwY=;
  b=JLCH1V0bt0g+Bp+LQ5j5NWkdfkIzjClMIfhBgfRbgnOkEJMG/ydgrcU8
   bD11mLigwdesnDf3adncybdwqX0G/Hs9DAk+xIVXYvvOSmRi3fSGI4TVj
   LdIY2/LQ13W2Nfg4cTtQY1zeCbPG6laERrF06K0gAcaOY66QBD8jnvZHH
   RDA31dtE8oFVIfT6m3Ln2dZoyPRq1qlnNU2LUQ4mRnKoo8PwfJaKARyMg
   QBTwuLYZw30qUnFGEy1EYvgRqM4WflJk0cdCCO6Z46/U+rs+MQMKK2un4
   5fLn57AAUKbdWzIIIofdUYtFhhRp/5scxHD1K9JAx58gLYQ2R/Pzlv+H7
   Q==;
X-CSE-ConnectionGUID: GP+Qb253Tu6RDhyFD7zusA==
X-CSE-MsgGUID: oP0rhCahS4KI2aC+NyYAJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22318678"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="22318678"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 04:32:19 -0800
X-CSE-ConnectionGUID: Rmfr6sOBTRCEv1NbTKsmdw==
X-CSE-MsgGUID: xuESkDTNTEW6EqhS1W/JXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97044535"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 04:32:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tNAGk-00000008as7-1Qqp;
	Mon, 16 Dec 2024 14:32:14 +0200
Date: Mon, 16 Dec 2024 14:32:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel: bytcrc_pwrsrc: fix power_supply
 dependency
Message-ID: <Z2AdzhPW5Y4EjsDX@smile.fi.intel.com>
References: <20241216083409.1885677-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216083409.1885677-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 16, 2024 at 09:34:05AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now fails to link when the power supply core is missing
> or in a loadable module:
> 
> _64-linux/bin/x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_irq_handler':
> bytcrc_pwrsrc.c:(.text+0x2aa): undefined reference to `power_supply_changed'
> x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_psy_get_property':
> bytcrc_pwrsrc.c:(.text+0x2f6): undefined reference to `power_supply_get_drvdata'
> x86_64-linux-ld: drivers/platform/x86/intel/bytcrc_pwrsrc.o: in function `crc_pwrsrc_probe':
> bytcrc_pwrsrc.c:(.text+0x644): undefined reference to `devm_power_supply_register'
> 
> Add the appropriate dependency for it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



