Return-Path: <linux-kernel+bounces-440852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12E9EC56C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0E18898B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109A1C5F00;
	Wed, 11 Dec 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a55pNOK7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1D1C2443;
	Wed, 11 Dec 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901264; cv=none; b=u69QXVY1D0Dyr1fWmwpUxelPAtpL0gNMVOJcQloG76lS0ivEFeLQm/vsqqtcpXQfMXBYy9+c0P/Z9WDjHlvnL152I9VI92OtZLVEbPxDoxdgyeICwhuXa97wnMmm/dc2ewVIYhCDAhHatPcNzesJRHE3ON6BsfnFBqg+HK2z41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901264; c=relaxed/simple;
	bh=eNbU40uTyE9XaSbbEj0HmIYTCwXeVochwHLRD0TMXV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5DikMDkB0Twmgb5Inzpni+0ErugDmA/wDM18TmFPUa8B1QMcs5i7rDb6zA9jWK3do7ROOsT23Ie3VMemhDBI6zOgAvaiKagTqjWY5NFSee9J3ATHJAqxTl3iVXSbpG7D+gNAm7liN+Z2DTQ1hTGGeB6pqLNEDgw5NB3awyBLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a55pNOK7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733901263; x=1765437263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNbU40uTyE9XaSbbEj0HmIYTCwXeVochwHLRD0TMXV8=;
  b=a55pNOK7MTf8TjaS5rrLIZh+uzYps19lCAjKr1KUgevQJt48hfVFhmzY
   odRdemVF7+LEUjxJa+7de/0exCM86SnB81gZnQVpsOTPMgkadIPOKtHzg
   PkPPLzZyOVrSmsSqWw5Ig26vh5REsHwwwWShejLSrcJq33XGXkgkRpe6J
   FMrhL3VlzLJK5zJ3skmm7jQd0wosokM0thm0sCVu/5J/VARCoV0BBPh9I
   iQlVMfGOxSEUfqyPPbn7J3mzrnzsx8eGE6tIZq0JuBnwVbUQ5w1nDu+0L
   LU3CqWvdDOh6BoauYYMioamFpGrToh+I0DheKoXN5lF3XdniQb9SIT8cC
   A==;
X-CSE-ConnectionGUID: /8Cspmn4R9esyf1tKjMqUQ==
X-CSE-MsgGUID: dpnzu76WSfm+mO4JiJTjTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33589466"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33589466"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:14:22 -0800
X-CSE-ConnectionGUID: iKZY6jk5TUaUBBdDGmIuuw==
X-CSE-MsgGUID: QjDW+gXsTaqJpPZK60khGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118934774"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 10 Dec 2024 23:14:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 9F35D192; Wed, 11 Dec 2024 09:14:18 +0200 (EET)
Date: Wed, 11 Dec 2024 09:14:18 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH v2] thunderbolt: Don't display nvm_version unless upgrade
 supported
Message-ID: <20241211071418.GP4955@black.fi.intel.com>
References: <20241209162551.888749-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209162551.888749-1-superm1@kernel.org>

On Mon, Dec 09, 2024 at 10:25:51AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The read will never succeed if nvm wasn't initialized due to an
> unknown format.
> 
> Add a new callback for visibility to only show when supported.
> 
> Fixes: aef9c693e7e5 ("thunderbolt: Move vendor specific NVM handling into nvm.c")
> Reported-by: Richard Hughes <hughsient@gmail.com>
> Closes: https://github.com/fwupd/fwupd/issues/8200
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to thunderbolt.git/fixes, thanks Mario!

