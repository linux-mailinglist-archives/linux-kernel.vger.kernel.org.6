Return-Path: <linux-kernel+bounces-392030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489C9B8EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70861C22B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF64186E40;
	Fri,  1 Nov 2024 10:16:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47815CD60;
	Fri,  1 Nov 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456170; cv=none; b=s375tnkKCFCegxqln66rojhv2Q/0RQiDUdiHhnFQnVvLAqQXK0TO9Bee5sDfXmxbJ73htc6L4vSr5NLa2hUy0RTWHYEnr/LT/96crs1P7nH1vTunqXsu/3DFi/Sw4kRunuD3GrLJVe/GyHWldW8XoAxl/DW5+cVwSdnu2y/uAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456170; c=relaxed/simple;
	bh=xa2mx5V90u4dXLNz44nm9bRWG5DZnoGaELqD6fUk+F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMnEgqq4zNid+ruYja8O2SQPDstkOfgjvkypLyllzQ75MHBnbO1lddxzG1u1YM2CiTnLe4DQpL0rvZ3+htcmcFn4w1y6r0KQ+rfovItR2tdy8w12KbuOUaNQ/F6ID2RNHUw7foB9v0U6g8n6dfbRbhRyx/4pR1AlQKh/Qf4RLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 9B3YuDfHSeqJIvkXtncV7Q==
X-CSE-MsgGUID: eaBG5H8pTZ6RKOEtUt7TTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="34019792"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="34019792"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:16:08 -0700
X-CSE-ConnectionGUID: 6V6F1O1LSRuEc8fQEV00Nw==
X-CSE-MsgGUID: tdVZufXXR4G/6M6SzZcAoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="82838350"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:16:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t6ohH-00000009zYn-2seL;
	Fri, 01 Nov 2024 12:16:03 +0200
Date: Fri, 1 Nov 2024 12:16:03 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: mchehab@kernel.org, hdegoede@redhat.com, sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp: Add check for rgby_data memory
 allocation failure
Message-ID: <ZySqY9YX0ke64Lf-@smile.fi.intel.com>
References: <20241101154823.3067891-1-lihuafei1@huawei.com>
 <ZySRjyrxI9jrcY1q@smile.fi.intel.com>
 <d2590a9f-7786-ca08-a705-a5b287e74ba3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2590a9f-7786-ca08-a705-a5b287e74ba3@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 01, 2024 at 05:57:36PM +0800, Li Huafei wrote:
> On 2024/11/1 16:30, Andy Shevchenko wrote:
> > On Fri, Nov 01, 2024 at 11:48:23PM +0800, Li Huafei wrote:
> >> In ia_css_3a_statistics_allocate(), there is no check on the allocation
> >> result of the rgby_data memory. If rgby_data is not successfully
> >> allocated, it may trigger the assert(host_stats->rgby_data) assertion in
> >> ia_css_s3a_hmem_decode(). Adding a check to fix this potential issue.
> > 
> > Not sure if this code even run on currently supported hardware / firmware,
> > but fix looks okay.
> > 
> >> Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
> > 
> > No, this is an intermediate commit, you should find the original, which is
> > earlier in the history.
> 
> Apologies, the correct fix tag should be:
> 
> Fixes: a49d25364dfb ("staging/atomisp: Add support for the Intel IPU v2")
> 
> If this fix can be applied, do I need to send a v2, or can you help add the Fix tag?

Up to Hans, but there is another question left unanswered about SoB chain.
Can you clarify that?

-- 
With Best Regards,
Andy Shevchenko



