Return-Path: <linux-kernel+bounces-214822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F5F908A98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DC61C231F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7605195814;
	Fri, 14 Jun 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3BMGMHp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411977E574;
	Fri, 14 Jun 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362746; cv=none; b=lB1/JXW3Nb0Eqg34IMfk44WL6/FLER9wirjSEmqNjVPuLV7o8BnO1sA7c8H0y10OvI8Hn3FNOuLuv/KlbdAWWXa5iC52M2lxebsaEQvP1dk+847akdE9Kfi1wRXETPFDDQbNx+rbYV1aepkqeUll11gDSa1rI8GA5US5uC4S9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362746; c=relaxed/simple;
	bh=TTvHHix6+Srl+76E73U9yIJKGY0NOq+abACWr2ceP4k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JGzlJ/02wNasVmSGLGXEkPdZI8KILBI8hUJCtVRS/An4DcMCaQ85MvWy98ZWp9d4GyLNho2GfyIXI0awVK7Zkd+E8BSdmzU4EMULns0dfP12ZKsj+atnabdWS+0tszKPAxzd/nQV0Q1zNeQXrdqnyG2sfYUwnqEonuCZpBZvXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3BMGMHp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718362744; x=1749898744;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TTvHHix6+Srl+76E73U9yIJKGY0NOq+abACWr2ceP4k=;
  b=T3BMGMHp2Ac7EeGnpHwaRT5GPsHcIdxs/P4B6MJBXjGuoASZ3f9855MS
   qhqMA+vpsEPbTZBoTzr4oWDQimtew+tfjutDXrQwQVZMqUYd+sswT4Q2x
   RHWIK0KfTY3UL9mdifVOuUtXLmSm4+uIw5GLUSfuYQqpi5gQCNBovDaB0
   MdvW+PbIPxbFKdfzq26d2CQKUTW93z+FjO3//g5PAcsFngPmVQoF3/R69
   nU/iHJZa6X7IScam12lD8t+/D9vVyOQC4TXy+NLcL2xpffE9JzeCcWkWy
   xgC01lM8FbTrDivDTwIxRqunZyyImKwqnPmDoXKsZPO37opbeBcBxhRcE
   A==;
X-CSE-ConnectionGUID: pFB1T+p5TkGcXoTeQOTJ5A==
X-CSE-MsgGUID: wd/YlGnaSe6tiZ7QkY0d2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18163527"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="18163527"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:59:03 -0700
X-CSE-ConnectionGUID: uyhVy4BiTzW2tBNbwhmKJg==
X-CSE-MsgGUID: DpTS8SjVTPufVx0TzMiFvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40601141"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:59:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 13:58:57 +0300 (EEST)
To: Shravan Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <DM4PR12MB5136181FEDCFFDD15C6AA1C2C0C22@DM4PR12MB5136.namprd12.prod.outlook.com>
Message-ID: <db45f242-7af9-5ae6-b72d-3354f1a33f70@linux.intel.com>
References: <cover.1716205838.git.shravankr@nvidia.com> <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com> <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com> <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <33f25d4f-386c-6df6-344d-8b7aa011e69c@linux.intel.com> <DM4PR12MB5136EAD83A50869388E96FF3C0C72@DM4PR12MB5136.namprd12.prod.outlook.com> <370b5e44-cf92-21af-8c01-dbb208bf323f@linux.intel.com>
 <DM4PR12MB5136181FEDCFFDD15C6AA1C2C0C22@DM4PR12MB5136.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Jun 2024, Shravan Ramani wrote:

> > This does nothing to answer my question. Where in the kernel, there's an
> > example where a 64-bit counter for BlueField platform is presented as 2
> > 32-bit counters? If there isn't any examples in the kernel, your statement
> > about consistency within the platform doesn't hold water, quoted (again)
> > here for clarity what I'm refering to:
> >
> > "The other interfaces follow this approach of having lower and upper
> > 32-bits separately in each counter, and the tools expect the same.
> > Hence the driver follows this approach to keep things consistent across
> > the BlueField platform."
> >
> > Where I can find those "other interfaces" that already follow this
> > convention?
> 
> Ah, I think I misunderstood the question and went on elaborating the
> same thing, apologies. The other interfaces are not part of the kernel.
> They are part of the BlueField Software Package, which also contains
> the tools that put together the performance metrics.
> My thinking was that since this is a platform driver and is used along
> with the BlueField Software Package, consistency with the tools which
> were developed following the same convention could be considered,
> as long as the driver is not doing something non-standard, of course.
> I can change the driver handling to present 64-bit data if you insist.

I'd certainly prefer 64-bit data be presented as such by the kernel.
While you make that change, please make sure the driver correctly handles 
the lower dword wraps without returning an inconsistent reading (assuming 
the counter parts are read non-atomically, it is a common pitfall).

-- 
 i.


