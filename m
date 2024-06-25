Return-Path: <linux-kernel+bounces-228552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9ED91618B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3311C235A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503C149003;
	Tue, 25 Jun 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIiNvyXD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C9148FFB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305146; cv=none; b=G8mhgZGKRenPIxy8mLcNgimI+np5cIxpYzrVX2GY8E+JnmjTVNfU5RU6Ks0teXsGrQHHG7RCPu5DBKDvmXOUmYXi2qEuC7NzoodjtjGPxWIoEfrSWJNQ859cTfHyBDr3PL2yxipeVJT+Ul8wmiYxhBkRA7BwFrW2LygSZ423PFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305146; c=relaxed/simple;
	bh=dwOAdMSSVbj0gZ1Okilxekx10WXrLvdoqy5TsLaP598=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+4rKtEWo+N0SmWgwwOw0db6RMKfEoaRg6ljDD/SQXLHYH9kPHwiBagibUh4DQRuntYZJAwukH9q1nySgxoIct9CBgXtb2KUItdnHMCsUG/wsg8x1EuBanciokCQYmFcEBDakZqmSrlaxATGT4PiFyDBiO1mpoRA8o3Dh10YJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIiNvyXD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719305145; x=1750841145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwOAdMSSVbj0gZ1Okilxekx10WXrLvdoqy5TsLaP598=;
  b=GIiNvyXDBqyoQMKivrJsP2+1xQic2t8D8srmJu5cOnMEujhH1PlGWUuC
   TO7USyVCCRUNbgisyJSupCjndLeSl7UG5ltIeaso1F6hUa8o7PE8+wxHm
   DIPcXJvha/yt7jx5aPwCDQ3vtLL5lL6romlDghJ696WvALhL11qqMWrq7
   CJozrx4lE6gYOMmsPz1kK9RfTSLV6xsQmytAYjEX/oY5yV/RYJ1VJtxAb
   dpIfZdMysJd47AIlA+VCZc5D7ZKvgVII8nKIUoUJ4RsyXa+qbm3aComCZ
   6fMBDtsAs4d5BwgwP9nA4seDWIgwtjEmflnWghHy05PZUzM9ye51uYZq/
   Q==;
X-CSE-ConnectionGUID: GMTCHoK4RnKDQ/U10QV4kA==
X-CSE-MsgGUID: ukL/G5QDTaO+QMU4MTh4Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33764688"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33764688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:44 -0700
X-CSE-ConnectionGUID: 5WkDpaRDRtCgTaIB5FqYJQ==
X-CSE-MsgGUID: XHrVdY+aQ9ubi1HvVpsiWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43561278"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:45:43 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F308911FA94;
	Tue, 25 Jun 2024 11:45:40 +0300 (EEST)
Date: Tue, 25 Jun 2024 08:45:40 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v4 4/5] mei: vsc: Enhance SPI transfer of IVSC ROM
Message-ID: <ZnqDtOpurAv3bk_O@kekkonen.localdomain>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
 <20240625081047.4178494-5-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625081047.4178494-5-wentong.wu@intel.com>

On Tue, Jun 25, 2024 at 04:10:46PM +0800, Wentong Wu wrote:
> Before downloading firmware, a command response is required to
> identify the silicon. However, when downloading IVSC firmware,
> reading data from the SPI transfers with the IVSC ROM is not
> necessary. Therefore, the rx buffer of SPI transfer command is
> determined based on the specific request of the caller.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

