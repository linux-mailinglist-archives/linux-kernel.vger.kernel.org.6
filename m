Return-Path: <linux-kernel+bounces-563550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA1A643FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800F163E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2B21504D;
	Mon, 17 Mar 2025 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In/JT1D5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB66215046
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197240; cv=none; b=Ws3eFx15GwDjiF9mppVfrHDaOp0qdj80rF5BarjojkoQbImSj4Mhz9tYbO2lflUhhKtor4RGKezc1W68uDqlZKLVX0Rg0WsCXIqeNGnWUztXIO9nm/AmN+wf+i+fYnxo+mYfacnjzjsjewTE0KeI87dyW/UFFnnhZZCAPk9mveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197240; c=relaxed/simple;
	bh=4iPeKpB6xQpUo+L3+W20HJO0vsTT+DG3vFOt544pFIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6H/W5Gi8hV3kpBLX1V8a4EA9LYaJqL83x5IOq5o8Qfd6hAeKNfK1zkUe3b/zVFgfKZ4gnmIPALt3HpJY0Cagi/JGLPoFqFXwsMx/CS700zxwmBNLffEEhXSC9xW1m54UQvJmOvcBbYaO0txZdyQUALSsKjHzafez71m1VtpcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In/JT1D5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742197239; x=1773733239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4iPeKpB6xQpUo+L3+W20HJO0vsTT+DG3vFOt544pFIU=;
  b=In/JT1D5dmCZfwdY/20qNPOTUEL42fGOiKpHXVvRzS7gBlrOUjAVWckg
   dBd+K+L/QaNs+/zIauhwHj761O6my20Kh8J5aClrpPwqKxq9vhs0BAC5X
   ohM6i+bN/Vwy1sfhRaTR66KzHdhIbQs8HLsQx5d2j/AlE4zJSvTOeNt5G
   z+91fXnLuKKDFiVTVP06Jx6ZtI89wd0EpioT32ng2pQzVj29+iMaDME7g
   eH7bOt3Jld4g15Gb6ICKNaXcpxfYKDyo/U4kDGfkL4nhF4P8JGhaOW9sf
   2dxN4B69QT90FAFl1GN5nnxgpvyJhfShszd/ietxCstJNjXabPH0APTJu
   A==;
X-CSE-ConnectionGUID: lOzYtNWQSFGERanMqYjXog==
X-CSE-MsgGUID: WtuSCLdbRAWzqEuaI7usjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="47057158"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="47057158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:40:39 -0700
X-CSE-ConnectionGUID: zCaMVxGnSmuF6CGstXPzyQ==
X-CSE-MsgGUID: Xjav2hpTSqy1sWOl9ZlcIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="122817433"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:40:36 -0700
Date: Mon, 17 Mar 2025 09:40:34 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: giometti@enneenne.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pps: generators: tio: fix platform_set_drvdata()
Message-ID: <Z9fR8sgpzvSYLyn3@black.fi.intel.com>
References: <20250315133140.1707949-1-raag.jadav@intel.com>
 <Z9fOw6iu37GVxD48@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9fOw6iu37GVxD48@smile.fi.intel.com>

On Mon, Mar 17, 2025 at 09:26:59AM +0200, Andy Shevchenko wrote:
> On Sat, Mar 15, 2025 at 07:01:40PM +0530, Raag Jadav wrote:
> > Set driver_data correctly and fix illegal memory access on driver reload.
> 
> Do you have it in practice or you are thinking it will be like this?

I reproduced it but didn't want to bloat the commit message for an
obvious fix.

Raag

