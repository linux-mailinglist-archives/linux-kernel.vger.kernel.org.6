Return-Path: <linux-kernel+bounces-209369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2E90334D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E1B285ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADD16F85B;
	Tue, 11 Jun 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3B0XqZz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F413D8BA;
	Tue, 11 Jun 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090204; cv=none; b=q2b1i/f6hAUs3CkdKCzlQQRkM1AWpzlAbhFxw2dINfSAuMjNh51kJEk0ep1sPzovxwd+bZk1wt86sN4XsBC8RMM/f4ugp6JNf2mCABogYB/Lu1MZOg6uLarbeotznWLItuXjopNzv5/Xdm0f24aXesuuLHU4X2zqNM+bs0bm0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090204; c=relaxed/simple;
	bh=vpbX0gUUB2VGt9N7waW0P4LN2HbIaCAwhRuNuAENwSw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aIlRWGPEkm9eJFJO7McgpLHyrkAAhhRG/Zaoyx2/otCTbE/QetHxSzHInvhQnmEx+HoP34m78HE4nRABRUWgajaFwU2Y3jmcHUfVDuBDFB8wuzHHcsJF5M23Gyd5CX6P0Ft0JCOwlVA17KnWKMxXTtrIL46sV48EXuPDb6fv91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3B0XqZz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718090203; x=1749626203;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vpbX0gUUB2VGt9N7waW0P4LN2HbIaCAwhRuNuAENwSw=;
  b=U3B0XqZzxw0I06A0UUlGNWnolqkWdZWU59XRh4nqi9ttFTgt1xsjpD9m
   Xlqu0usZM7cWgqHebftkgasqHTfi+zbnKPGnBlJAN/e9lYX1MFBwFLyIH
   AaBTA3f29bRIQsT2ZhtQMzsag1cGQAQV/CcqQHp2wxZKCtHqHYP3HhhR3
   cQ0LjdZjbKqlv3QlGP9je0azZzuowOX+/7Be5hAdUoFeqdLYFDhR3sJFl
   MQL3S6sl8Dn/0QpAZ2RiPfx50ka5BbKY3jG5dA8/8F+aulHvnKk+LR7sn
   3LjfPtyQN9gv35tiEZzV99C3vclYMAUnGXD5BfWHnT06dJzadPgXlk7wV
   g==;
X-CSE-ConnectionGUID: 2I6I94oWS02U5aqmoLvFPw==
X-CSE-MsgGUID: Q3Xld98rR6uD3pW7uInmTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14909144"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14909144"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:15:04 -0700
X-CSE-ConnectionGUID: 586XrpUBQsyNXuiGnTDHKg==
X-CSE-MsgGUID: OpFeabnwQdmx7UZqW6dHRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="70505559"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:15:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Jun 2024 10:14:59 +0300 (EEST)
To: Shravan Ramani <shravankr@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
In-Reply-To: <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
Message-ID: <33f25d4f-386c-6df6-344d-8b7aa011e69c@linux.intel.com>
References: <cover.1716205838.git.shravankr@nvidia.com> <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com> <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com>
 <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Jun 2024, Shravan Ramani wrote:

> > > Both these features are supported by BlueField-3 PMC hardware, hence
> > > the required bit-fields are exposed by the driver via sysfs to allow
> > > the user to configure as needed.
> > 
> > I'm trying to understand what happens for the other counter, when the
> > use_odd_counter is enabled? This change also doesn't add code that would
> > make the other counter -EBUSY, should that be done?
> 
> When 2 32-bit counters are coupled to form a 64-bit counter using this setting,
> one counter will hold the lower 32 bits while the other will hold the upper 32.
> So the other counter (or syses corresponding to it) also needs to be accessed.
> 
> > For 64-bit counter, I suppose the userspace is expected to read the full
> > counter from two sysfs files and combine the value (your documentation
> > doesn't explain this)? That seems non-optimal, why cannot kernel just
> > return the full combined 64-value directly in kernel?
> 
> I will add more clear comments for this.
> While it is true that the driver could combine the 2 fields and present a
> 64-bit value via one of the sysfs, the reason for the current approach is that
> there are other interfaces which expose the same counters for our platform
> and there are tools that are expected to work on top of both interfaces for
> the purpose of collecting performance stats.

> The other interfaces follow this
> approach of having lower and upper 32-bits separately in each counter, and
> the tools expect the same. Hence the driver follows this approach to keep
> things consistent across the BlueField platform.

Hi,

I went to look through the existing arrays in mlxbf-pmc.c but did not find 
any entries that would have clearly indicated the counters being hi/lo 
parts of the same counter. There were a few 0/1 ones which could be the 
same counter although I suspect even they are not parts of the same 
counter but two separate entities called 0 and 1 having the same counter.

Could you please elaborate further what you meant with the note about 
other interfaces above so I can better assess the claim?

-- 
 i.


