Return-Path: <linux-kernel+bounces-338275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994D9855C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AC71F21352
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CB15B13B;
	Wed, 25 Sep 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNr6MoI6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCF15B104;
	Wed, 25 Sep 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253907; cv=none; b=cxNgKabUJXRRv+UPA6g5kSy8XPd4wc13SNBY4cEA8r/XDNDN23ANeYFX8/QO1mgsXBhRxf70BqfP8pLIF4pKnGDpRqRkSFbuIojSqtul2Wkos12ts2xzwhFYCZpN+cwok+IxMq9O27cT2iQcyDcmOQb5yhUEpGaTE3jOStH5AQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253907; c=relaxed/simple;
	bh=u49MkBsrEVyat/nSqnmiVuo+lAAzaF2zEZQwaCaUPJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+QHKvz7/iVEMYqQidUYcN8WO6DfHLAn03//Wu8otV3BDh3dWkRauYNoUahTew8fk2fpl2mpxqO61LhqudW4szYefcIFfALV3qtm2eCFCpxuh1NyCh2QrqX8zbrs4V0tD9eEKUFMSRxk58cCiqcgRw+xQWW0LtgRLRJ+hDziwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNr6MoI6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727253906; x=1758789906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u49MkBsrEVyat/nSqnmiVuo+lAAzaF2zEZQwaCaUPJk=;
  b=mNr6MoI6ndplyIc3/XRfJRjxEmWZw3GwkAhP7PlU+vZXDaA8lJTGE5Ol
   HtUBzzog/KBy3ArEQmgsFmVl3YPRD8c1byAolxwfGJh6/BhlQCZy6o1/X
   ALBubL6FNWhsHGDZIS4Rvq3kAzkfm64rEZ0XGoXfLzfuxmzPC8ifqBaa0
   ORJTUl5rhRHHhCQVnwNnKoeM6fmiUeLmT1+qy+JC6JqXTDsVmEi7VhnqK
   eiKRWzgJ+naw8YL2Mx0kvbGqIsD+jeGvrzJQY7kovvVQj9xYPurc3eAx0
   +Iz/0OYEpoUTHTsKsOYs6OxskgTP5W6pemGGDBg6zGcSE+DWpIgFTTkH9
   Q==;
X-CSE-ConnectionGUID: PsGGAUxcRIuGWTcCtYcUPw==
X-CSE-MsgGUID: 2/+czE6uRnevD0sLNJEmLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="13913785"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="13913785"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 01:45:05 -0700
X-CSE-ConnectionGUID: UGcvfzunQtyjTha5afLKig==
X-CSE-MsgGUID: 16rf9qmjTzq/BZmK4YHtCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="76630188"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 25 Sep 2024 01:45:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id C5E86565; Wed, 25 Sep 2024 11:45:01 +0300 (EEST)
Date: Wed, 25 Sep 2024 11:45:01 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Use common error handling code in
 update_property_block()
Message-ID: <20240925084501.GY275077@black.fi.intel.com>
References: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>

On Wed, Sep 25, 2024 at 10:10:38AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Sep 2024 09:39:16 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/thunderbolt/xdomain.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
> index 11a50c86a1e4..8e3cf95ca99c 100644
> --- a/drivers/thunderbolt/xdomain.c
> +++ b/drivers/thunderbolt/xdomain.c
> @@ -670,23 +670,19 @@ static void update_property_block(struct tb_xdomain *xd)
>  		ret = tb_property_format_dir(dir, NULL, 0);
>  		if (ret < 0) {
>  			dev_warn(&xd->dev, "local property block creation failed\n");
> -			tb_property_free_dir(dir);
> -			goto out_unlock;
> +			goto out_free_dir;
>  		}
> 
>  		block_len = ret;
>  		block = kcalloc(block_len, sizeof(*block), GFP_KERNEL);
> -		if (!block) {
> -			tb_property_free_dir(dir);
> -			goto out_unlock;
> -		}
> +		if (!block)
> +			goto out_free_dir;
> 
>  		ret = tb_property_format_dir(dir, block, block_len);
>  		if (ret) {
>  			dev_warn(&xd->dev, "property block generation failed\n");
> -			tb_property_free_dir(dir);
>  			kfree(block);
> -			goto out_unlock;
> +			goto out_free_dir;
>  		}
> 
>  		tb_property_free_dir(dir);
> @@ -701,6 +697,11 @@ static void update_property_block(struct tb_xdomain *xd)
>  out_unlock:
>  	mutex_unlock(&xd->lock);
>  	mutex_unlock(&xdomain_lock);
> +	return;
> +
> +out_free_dir:
> +	tb_property_free_dir(dir);
> +	goto out_unlock;

No way, this kind of spaghetti is really hard to follow.

