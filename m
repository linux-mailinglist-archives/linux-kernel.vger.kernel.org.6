Return-Path: <linux-kernel+bounces-343996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F198A252
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D3B1C225E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8DB18DF83;
	Mon, 30 Sep 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gskLvOQU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060F18CBF7;
	Mon, 30 Sep 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699002; cv=none; b=Lord6TMvwTAqmi1rj5L+ylsmwvBgM71oPziP8hxT9JVbdVJgQtWVp4qxD9eLiSWX3OaQFAByd7Yay0hzMthHJ7q6TpehFTIopGN9QuvJ+UNdOgrRpNA+pBtuyrFqn2H3F/ta5x/RyASXlCAy8WVAIr/M+XmLtGoJkaGXxr1+nyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699002; c=relaxed/simple;
	bh=5HBufJuRJTDINVJL3z3VzyjHtxL6XF6TxE9WdkMmSDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txrYJcn+Apmlk0a2h+jTEZKMggMAqiqilMneOkbzulOa3d5taKZd64RA9yJy9oSXAFGac3Hj3zVtwbtH+J5VPPEeQd9kuR6XmV/ppBAOm+9Pzfk023bDs3B0RVdXC7XEhXP8qUhA8BM/AmXew1HBjgO7m2oP4cOYSf5LVGzIK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gskLvOQU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727699001; x=1759235001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HBufJuRJTDINVJL3z3VzyjHtxL6XF6TxE9WdkMmSDg=;
  b=gskLvOQUSG+86PMfeydqQ4rnDUXj6b6d2gSm250MApK2cejEyMzYWlYL
   NWb+Yf3JD0C3VESF0+ma2Rn4PItaxeECitx+/REHfGUD6axelNvjBi7fH
   cbMfWiCACuw6gcXpJSLutLMQU6G7E2jd8eXyYwLZfKuxQWpcGzHyfVZdQ
   vzw6On5mG0lxVON181hAqbw+kep4kL3Mm1m9ylBvS4vK2OrlF143LktRd
   YKyhpP8wUC2O1IRWovzF55uRdMg3GqAY9JYOvSKbq+U6qiTTs2sEEg071
   14+85rdVf9BQ4w/r8fY5cfT2/exSsPhm/SpoLXxOmrB/Z0orqUjAi+eJP
   Q==;
X-CSE-ConnectionGUID: sRig8awBS4CdByQPEYX99A==
X-CSE-MsgGUID: Ri397MSPReyo48VkH++IiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26291151"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26291151"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:23:20 -0700
X-CSE-ConnectionGUID: V4CLIAaHTQmIyGv8yg9AMg==
X-CSE-MsgGUID: mSvxM4cjQsu5QZ2YIvlypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78039157"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:23:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1svFQo-0000000Eeg1-0fVl;
	Mon, 30 Sep 2024 15:23:14 +0300
Date: Mon, 30 Sep 2024 15:23:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] serial: 8250: Fix typos in comments across various
 files
Message-ID: <ZvqYMV9s41DyVOnK@smile.fi.intel.com>
References: <20240929100931.530620-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929100931.530620-1-yujiaoliang@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 29, 2024 at 06:09:31PM +0800, Yu Jiaoliang wrote:
> This patch fixes several typos in the comments within the tty/8250
> directory to improve readability and code documentation.
> 
> Detected using codespell.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



