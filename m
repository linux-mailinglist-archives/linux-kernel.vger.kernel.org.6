Return-Path: <linux-kernel+bounces-359683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC0998F13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D5AB2AF96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525061C9B93;
	Thu, 10 Oct 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hz1GxqBm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F81BC9EE;
	Thu, 10 Oct 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582957; cv=none; b=BIdzmZ3SXqYNpwupPfop99B+SGj/CwX3JrCq2NvtJou4Ho+7jhhcPRfMwZw9Hir5PhgbOctgxkfyLGvm2ojWgoG6mNKtAZVFFIt7FQvPkzEcJrT+ND/G0vktFlOOfw2MASz8n3IThcA9DmyD4qXKEiSNJPA3S8RNQPoGp4uc2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582957; c=relaxed/simple;
	bh=B0xSv0oqpMjHLG79JuskG5H5p9JvO5/h+cQy+KJHRSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/no+TKLRYAHpNfiTBLZyXEOIGrmmZHPY1Jw5UYnqubbP85caJTwDMX9Lh3J8X9fT4qYpG3/zRxwUabFmCmAuyUKz0qi744UzwnsB5BIJHv+HDrr/SMOPbray76QNQ3eCH61wE6JkULDQ0RwoMya/6dh8NMGd8RjIWslFnZKBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hz1GxqBm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728582956; x=1760118956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0xSv0oqpMjHLG79JuskG5H5p9JvO5/h+cQy+KJHRSI=;
  b=Hz1GxqBm5F5H9uUCxWoYmTF4MJid23xBPEuTeid5H1zdMIJoCsJD4REP
   IKqSNnzKrxTxnthkSh215ZEc2UZvfbZEu2k0TlumImJpp76dZKGckYYYj
   xgbqFAuPsw4m0sONa4YqoAUEj8PanXIhSVhTx9k1LMeZ0eGj/5n0X6ONi
   QD953r7b6i3cnFUeJcGLNJGxIVUDqcLB9w1sbLHxUfNjlFuNr9P0wMTxB
   G+zj6OVoMSjZBFMLoVLB9ZCrY2Jh4C9EI8akSrbpBUpmjXcxpeARl0xoM
   IkFqqOpkeKi73kIwFWdzTNd9JBYOryBe7/yv9avpDpN9U7s4Ihei132xv
   A==;
X-CSE-ConnectionGUID: EWq6ZN0rQ3yY2yjDB75zOg==
X-CSE-MsgGUID: rNBZVODMQWWBcUHA+76fKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27906600"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27906600"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:55:54 -0700
X-CSE-ConnectionGUID: D7I8cOhpQESSHckpGAyOAw==
X-CSE-MsgGUID: Q5I773WtTtaeN8N/Znx3Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76594980"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:55:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syxO9-00000001cwR-0Eh2;
	Thu, 10 Oct 2024 20:55:49 +0300
Date: Thu, 10 Oct 2024 20:55:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain usage
Message-ID: <ZwgVJLLK2ldE_H4l@smile.fi.intel.com>
References: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
 <172857714957.2687257.4921456811511949312.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172857714957.2687257.4921456811511949312.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 05:19:09PM +0100, Lee Jones wrote:
> On Sat, 05 Oct 2024 22:27:03 +0300, Andy Shevchenko wrote:
> > It appears that the driver has been developed without proper thinking
> > of what the difference between HW IRQ and Linux IRQ (also known as vIRQ).
> > This misunderstanding led to the 0 being used as vIRQ which is no-no and
> > platform APIs unveil this after the commit a85a6c86c25b ("driver core:
> > platform: Clarify that IRQ 0 is invalid"). With this the Intel Broxton
> > Whiskey Cove PMIC driver has to be fixed all over the places.

[...]

> Applied, thanks!

Thank you!

-- 
With Best Regards,
Andy Shevchenko



