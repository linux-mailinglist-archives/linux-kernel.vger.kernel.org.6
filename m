Return-Path: <linux-kernel+bounces-356639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3366996474
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F172B27592
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1B189BA2;
	Wed,  9 Oct 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgbYeQld"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F173487AE;
	Wed,  9 Oct 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464917; cv=none; b=MwiU4M+hgKB574WjS09qUxZc9e3NvlU2p9ffH4oEKrdLC2dEDlhfkbc9p1GshKW55joJynYlhEMyjs9b8aL0KUEC4Bs2Zb5GxIHeoEX48cir8B3yilauIupNF9NUnD3hp/dv8ZZJ+Ku8MHmQjpWGAjizoOVeS/l8i0dwJJu25to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464917; c=relaxed/simple;
	bh=jbWq0WW1GHaUSUsd+1XElHTTumE3QWv51W3cm2riO04=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N5l5A90/cHR1vzwxGN7pnUSz3dbg4frr9I3Vpg5aaYBbv+sRXj3b1RzsHQpuzFhJrzPYmxJhzkQZKNExl02rvOdVmIKyJGkF0D0j9hI/9fiir/4P+6YgH2AuapeeMOf9HPc4UfTB3UUu5j0a7j2D7O6UGRDb35MA0VnusC0dLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgbYeQld; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728464916; x=1760000916;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jbWq0WW1GHaUSUsd+1XElHTTumE3QWv51W3cm2riO04=;
  b=BgbYeQld3wbzXqGhK+P/gnBddNBxLu/tppcweesgI3pd2APNMsF/rstQ
   ZQx0cErGp22KGxLayFzX6VpFrgRjWsyBkyXlfkFtBW7qguyOzBDvspXBs
   wj4rZwTsNlpoRmWrdSKVStyIXOfZBPllOJcaUsvGS3Z+ZlFwXbUhuQW32
   B9fak0ZBwA5CeNSwD4shBaB0qMxi3MbXgg5J8Oyfb9Sd3ivxzFMGT6kBT
   z/tMGJMJFgZqBFNDbTaE5UNAAmfGVzBflTFyWuK7LSPxNHrrtj5usegQi
   s9tQmD2sho9QXr76AvEDE0BuPNjwsKEBUkB3mX8xXZUmdjVHarT7y1fCx
   w==;
X-CSE-ConnectionGUID: 46bIgxJqTPuY2QqYlCoryg==
X-CSE-MsgGUID: qeFCGjexSIWZbeHrOWQDVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38878078"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38878078"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:08:35 -0700
X-CSE-ConnectionGUID: 3DjeUUZVS8yPVHmpz/VwTg==
X-CSE-MsgGUID: eIPK81RCTCiVlVPlrLpPGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80763358"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:08:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Oct 2024 12:08:30 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>
cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: wmi: Update WMI driver API
 documentation
In-Reply-To: <263ec855-d19d-4b81-b3cd-1a7f575c9c27@redhat.com>
Message-ID: <14abcee7-29b2-bb8c-c2b7-02a397db10b2@linux.intel.com>
References: <20241005213825.701887-1-W_Armin@gmx.de> <263ec855-d19d-4b81-b3cd-1a7f575c9c27@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 6 Oct 2024, Hans de Goede wrote:

> Hi Armin,
> 
> On 5-Oct-24 11:38 PM, Armin Wolf wrote:
> > The WMI driver core now passes the WMI event data to legacy notify
> > handlers, so WMI devices sharing notification IDs are now being
> > handled properly.
> > 
> > Fixes: e04e2b760ddb ("platform/x86: wmi: Pass event data directly to legacy notify handlers")
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> Thank you for your patch/series, I've applied this patch
> (series) to my review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> I will include this patch in my next fixes pull-req to Linus
> for the current kernel development cycle.
> 
> Since patch 2/2 makes non pure bugfix functional changes
> I expect Ilpo to pick that one up for pdx86/for-next.

Patch 2/2 is now in review-ilpo branch.

-- 
 i.


