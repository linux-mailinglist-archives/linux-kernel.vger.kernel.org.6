Return-Path: <linux-kernel+bounces-399595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945259C015C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35071C2186B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FA1E0DBA;
	Thu,  7 Nov 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZXF82rw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A9372;
	Thu,  7 Nov 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972749; cv=none; b=mDLhdgm9RAOT5iNueaebJa+z92vYbuOV2uNTGaq2z0dHnzsvP/jW/2IOiaY1VSXAIkXafE51rdRyKX4SALO+mNFnzmF8fGxGQiqUx2h3IfAjJQKQHYIbhfuBh91L+ZzMG/tYGseRj45cIh9NIfu8YCCoP1ucg+nsS6jF7SepcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972749; c=relaxed/simple;
	bh=PqoizVj8OyvEeeSjCvB6UcJ2ogs3bCJ1y+agmRj5f/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy0yTH128Vnk5EqSccxLxnlzQK7iW28vo/jVyThsuNU39fnFvf0K5AAOwZYA5/TssxCOSHeF1y4cADXlQbtDR8asCAkuw3x7kfW3wfrYIAzE9x9v7DQBwkO4RpNS/QRDK8RclCy/HsOPrkd5/k22YhjriqAEZUHItoqYhL2OgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZXF82rw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730972749; x=1762508749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PqoizVj8OyvEeeSjCvB6UcJ2ogs3bCJ1y+agmRj5f/Y=;
  b=HZXF82rw+JEKUA195hep9X+PJTgPcBGmuqXMeok1IyIlOxSLMSErPF3F
   yLh+xD5QJFpcBI9GXHTQCeklLgoPkS7ghg6xENzACE0gjs4svi3vgmfJF
   8BPIghRWubpDqrceltPQ2bWqH/noF5/aBKoAM+ipnpHgQ1oTI87UL3T/Z
   RntfC9t59f/0Jk5Ue72D3KQu5zYY93+Lt0JDLqaZT13TMes1QWefyQpE0
   YU9dqAx1YVO0OT50ha480g8f+18PqfUVZP1sViWLEkhOzD9gXmTDtnZN5
   BIa4RL3h2IxPGGAlG23MYT7hLOO/cQicmHJHx6Hyuj1wodPxs+yplwt1h
   w==;
X-CSE-ConnectionGUID: 0FsbCrp5Sy6aQkGoLRgXAA==
X-CSE-MsgGUID: gyilO5gHSVizKQCCOPPn0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="42210411"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="42210411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 01:45:48 -0800
X-CSE-ConnectionGUID: O1NINg1TS7WgGAW3KnUGCQ==
X-CSE-MsgGUID: EMLW/tBDRcOK9fQLgrm8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="85132720"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 07 Nov 2024 01:45:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 1828260D; Thu, 07 Nov 2024 11:45:44 +0200 (EET)
Date: Thu, 7 Nov 2024 11:45:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241107094543.GL275077@black.fi.intel.com>
References: <20241023073931.GH275077@black.fi.intel.com>
 <20241023174413.451710ea@kf-ir16>
 <20241024154341.GK275077@black.fi.intel.com>
 <20241031095542.587e8aa6@kf-ir16>
 <20241101072155.GW275077@black.fi.intel.com>
 <20241101181334.25724aff@kf-ir16>
 <20241104060159.GY275077@black.fi.intel.com>
 <20241105141627.5e5199b3@kf-ir16>
 <20241106060635.GJ275077@black.fi.intel.com>
 <20241106110134.1871a7f6@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106110134.1871a7f6@kf-ir16>

Hi,

On Wed, Nov 06, 2024 at 11:01:34AM -0600, Aaron Rainbolt wrote:
> > Unfortunately that does not help here. I need to figure something else
> > how to detect the redrive case with this firmware but first, does this
> > work in Windows? I mean if you install Windows to this same system
> > does it work as expected?
> 
> It does work as expected under Windows 11, with one major caveat. We
> used a Windows 11 ISO with a setup.exe created on April 05 2023 for
> installing the test system, and after initial installation it behaved
> exactly the same way as Linux behaves now (displays going blank soon
> after being plugged in). However, after installing all available
> Windows updates, the issue resolved, and the displays worked exactly as
> intended (the screens are recognized when attached and do not end up
> disconnecting after a timeout).
> 
> Would it be helpful to test on Windows 11, and provide a report and
> system logs?

Unfortunately, I don't know anything about Windows ;-)

However, I asked our Thunderbolt hardware/firmware team about this, if
they have any idea how it was solved in Windows side. Might take a
couple of days though.

