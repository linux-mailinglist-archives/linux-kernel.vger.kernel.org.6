Return-Path: <linux-kernel+bounces-544477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D8A4E1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ECE18889C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73898263F25;
	Tue,  4 Mar 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLtW4P7v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B925D20E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099219; cv=none; b=nKzuc/lDfXdgX8szbSvpomAOkR9OXtmI1uONeJnTcyHBSp7IdTMHdx6M5eXCdiiD4htRhEx2vHQmoD+JP0O/1ol+6RbovBu4evJh+gDfEFa0bd4AK59BMhL60WEd1N0bjTRBJVICVZ9b8MyzPpCGEJFalPAT38yMg/pI5nq/3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099219; c=relaxed/simple;
	bh=uH0iy8XmD3PMq871alInZIwyF7MizcrSuLKTwFg3pXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ/Q3fZEv/0buZbRkcd5qdhp8UZxzBa+5UjkoBxBxLhcSMwszr+uxqqijiNYGMT1zKbYoHYoT/zs966z1kmC0IYZfiLxI+r/WgoWkIoO2ZNdS37BoZStmRAMwkAm5MFJP44C6btsUVbARRCQXhlK2Hpw58qzJWr/etLOJmZV8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLtW4P7v; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741099219; x=1772635219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uH0iy8XmD3PMq871alInZIwyF7MizcrSuLKTwFg3pXk=;
  b=cLtW4P7vytgYhazBJjeShW8icNgBj56pQV03kDjJNQtrwFwnS1Hd76oE
   pLC7Z07kodv6KVjzanNbNZwt2z/KcMP4/Lw0YiGgQEKxdLOaz46JhsfeI
   MWa+NYPdI3eJfRqckbUq9R6Vr4QVPmtYOyvPi91+7yIdffYXIi66Vn/bV
   Nkqn75tdJHKLds+j7TPxCG+lBzwW4jAvWi4r97AKXi3QbC2qj2w2Jp+9m
   /E6jnH9yyCV2aObgBGKGtmA1i+ruWH45N74lkCwIvPm12L1qn5waoSkmC
   AvefqcMg6dVvZGyGPfxujtRBPKuPZnWFc1tYSOnzqiEVHEP1gagq/+GPz
   Q==;
X-CSE-ConnectionGUID: lJlCDchsQzS9sHmn+yOicA==
X-CSE-MsgGUID: UvaCQehJRKWvbCKqUlrj5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59431157"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59431157"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:40:18 -0800
X-CSE-ConnectionGUID: 4xEIotUoRuOp4IQRBVHO5A==
X-CSE-MsgGUID: yeYGr0nzTJqr9ounl9pyUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118266170"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:40:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpTRM-0000000H9UD-27vR;
	Tue, 04 Mar 2025 16:40:12 +0200
Date: Tue, 4 Mar 2025 16:40:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ofir Bitton <obitton@habana.ai>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>
Subject: Re: [PATCH v2 1/1] accel/habanalabs: Switch to use %ptTs
Message-ID: <Z8cQzCWEzQ9T9j9_@smile.fi.intel.com>
References: <20250206192109.1133364-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206192109.1133364-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 06, 2025 at 09:20:43PM +0200, Andy Shevchenko wrote:
> Use %ptTs instead of open-coded variant to print contents of time64_t type
> in human readable form.

Any comments on this, please? If no, can it be applied?

-- 
With Best Regards,
Andy Shevchenko



