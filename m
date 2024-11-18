Return-Path: <linux-kernel+bounces-412912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A0E9D1117
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED9E1F22B08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64519AA68;
	Mon, 18 Nov 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdGG8cDP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C218EFDE;
	Mon, 18 Nov 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934779; cv=none; b=ZOJx6fKqxGy1uyWUBPx/eq3dDoj5FPhDLwH6PP+D/mabGIqCN57PJTZ12sMVa4h81XGVjjOaxaapH85haTnT0KXTUPoWCp4IT4ynZVyEz9b7wYuR1NQZmKfmBIe5jakAZ5IsN3PMxLLNIDOT3vp94s64X2Hwgy7l3TLhXG2wXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934779; c=relaxed/simple;
	bh=hGf9o+DPDbnD6AChel3FfLrxzaLLuwhOelLSe94F8YE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OaC3ufn36u3vqDsEPvXW3b4o/p7Qkkoe+ruc1O5rfOVKrXFzH6fuKsypeut07Tbn2mZ45ey/hYR7Qfdu8QlWWQZxzm8IfaWuuys/gliZVh6+8fZ/4w+pDetTgNj9dlpiKGSblygOotSFnXGOM+hqcPjRdX1m2lbIT3KBQz0VdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdGG8cDP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731934778; x=1763470778;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=hGf9o+DPDbnD6AChel3FfLrxzaLLuwhOelLSe94F8YE=;
  b=fdGG8cDPo9JPG2EteOyxaDDb9R6S6h9ZjmdDy5F/94X79SkoY3rsVhM4
   0lYtoQKJe2cC9+E6XjXBoB2XqeHSxloL8RhOpNjBmiPnrwz2AiJh2UI8i
   RtSG6o9fzevSaDui01TvAnsKz/6K5YwQx4i+OUVWicNUNLg+0fXrmup6f
   dJA3p0rg/cmtIzbm7BfvDlig2iwoFAUom4LQJuy+xmsZyIpMRknKZ0RC1
   NELiNKHXnnYmA0H0lm6xYN1kn3+SeA81mSrOfrI5upKacYAKwUscwjWO/
   eUEYvikdprOr83Rl5quZbEvdbrnhVla5cFihr7t20QUle0fkkeqMBA/f9
   A==;
X-CSE-ConnectionGUID: vcRSqhuHSieFPI2YrnW9gA==
X-CSE-MsgGUID: vFZxR/9sTBiHxuzsQvgabQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43275110"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="43275110"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:59:37 -0800
X-CSE-ConnectionGUID: 5FeoSNcyT9+tZVGoYgVYAQ==
X-CSE-MsgGUID: eu+nurogTD++neQHGwQJeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94270879"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:59:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Kenneth Chan <kenneth.t.chan@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, Yao Zi <ziyao@disroot.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241118064637.61832-3-ziyao@disroot.org>
References: <20241118064637.61832-3-ziyao@disroot.org>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: Return errno correctly
 in show callback
Message-Id: <173193477000.3357.812507403692284846.b4-ty@linux.intel.com>
Date: Mon, 18 Nov 2024 14:59:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 18 Nov 2024 06:46:39 +0000, Yao Zi wrote:

> When an error occurs in sysfs show callback, we should return the errno
> directly instead of formatting it as the result, which produces
> meaningless output and doesn't inform the userspace of the error.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: panasonic-laptop: Return errno correctly in show callback
      commit: 5c7bebc1a3f0661db558d60e14dde27fc216d9dc

--
 i.


