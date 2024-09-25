Return-Path: <linux-kernel+bounces-338322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DE298566D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC885281C89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8115CD54;
	Wed, 25 Sep 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W21+6nzi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130E13AA53;
	Wed, 25 Sep 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256946; cv=none; b=Hy0fgtQXHtp5tU+HtKZJVaMoNCsJhUBo6tQwhmRPc1zjiG3vGPff+j+SgzAoqj0G50gsiLFVkbzs0GUzNwbkHWe9Tiw+VY9crRA+GsTUYmgP0GxZuic0h9M3eZsPhuD67lnBf45wD2YPmVCprV/wM5OFqPgQyJs8DHC7WM1pnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256946; c=relaxed/simple;
	bh=2GPgVJ0/g0Ha/YUnhKpQQX58Iusuhm5y+hBXDyEaAws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPANP4VoLS7sm3wiUp3MADv0dz+XIAKijOS2YsMs6VpLeMc8pkICfi0F57+Cuxykb6kHXO9P3O8olWd4iy9iG121fZCy3LnDF8DET00YlmDBuraLuxFrHVrXT0oYY9FF3mrJJowQ/IdU4/xpsW25vCdbgdnRJyumeJflS9k9Ws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W21+6nzi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727256945; x=1758792945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2GPgVJ0/g0Ha/YUnhKpQQX58Iusuhm5y+hBXDyEaAws=;
  b=W21+6nzipnMoeUG0YcMiJinTl0IoYMYYB0rIzKefjKuV3PhsUydh6YuD
   3E9h8+HYb9KC612/CkdakXpGsKpIx9wFL+KtZIG1UKHJfyTH8LgFa8yXm
   EvkpvERPCU1McoR1iRsQ46d8WqsN7dYhLIvp/oMOiJGYE5YZBSgxPoSgl
   X9XynId3u7h2UBfEar4u3IwoNPs9yBu96rJoFKy3vFR4oW97xMJ3KVwlL
   SCe7LlrscuN56DEwUHxQk41waX4yj2SWHqSKIzU5djqax3R+hYg9KTzgm
   3CuSy2Kl6UuPHSI7iso4ZZtOeryazNdSzEtFiI3NfjZpmpWDtccL+vx4W
   A==;
X-CSE-ConnectionGUID: CQw6tMsTQwWmf1gRKBD05w==
X-CSE-MsgGUID: b5TqQ1Y2QTKZkxBeJLlk8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26392362"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26392362"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 02:35:42 -0700
X-CSE-ConnectionGUID: pfCtISnXTGKtj/ucoT2vHA==
X-CSE-MsgGUID: E5+kPXTmQUO44qA4CcqoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71859389"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 25 Sep 2024 02:35:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 93AAF565; Wed, 25 Sep 2024 12:35:38 +0300 (EEST)
Date: Wed, 25 Sep 2024 12:35:38 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Use common error handling code in
 update_property_block()
Message-ID: <20240925093538.GZ275077@black.fi.intel.com>
References: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
 <20240925084501.GY275077@black.fi.intel.com>
 <a0c37886-cf9e-4c4c-8ff2-db8735f97cb6@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0c37886-cf9e-4c4c-8ff2-db8735f97cb6@web.de>

On Wed, Sep 25, 2024 at 11:20:45AM +0200, Markus Elfring wrote:
> >>  out_unlock:
> >>  	mutex_unlock(&xd->lock);
> >>  	mutex_unlock(&xdomain_lock);
> >> +	return;
> >> +
> >> +out_free_dir:
> >> +	tb_property_free_dir(dir);
> >> +	goto out_unlock;
> >
> > No way, this kind of spaghetti is really hard to follow.
> 
> Under which circumstances would you follow advice more from the section
> “7) Centralized exiting of functions” (according to a well-known information source)?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.11#n526
> 
> How do you think about to increase the application of scope-based resource management?

It is fine to use goto as it is described in the document you linked but
this what you are doing is certainly not fine, at least in the code I'm
maintaining:

out_unlock:
 	mutex_unlock(&xd->lock);
  	mutex_unlock(&xdomain_lock);
	return;

out_free_dir:
	tb_property_free_dir(dir);
	goto out_unlock;

This "goto out_unlock" adds another goto to upwards which makes it
really hard to follow because the flow is not anymore just downwards.

