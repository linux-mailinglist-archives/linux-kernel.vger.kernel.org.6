Return-Path: <linux-kernel+bounces-169542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5C8BCA21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10B51C210FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332351422A5;
	Mon,  6 May 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnnsNmEQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5531420B9;
	Mon,  6 May 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985966; cv=none; b=S+F6fdkViFbXu3jt6YRmGxJtoF2/Q6+yzkLMkHUY3T161Nyon64PFq5iIzmXyJ0LTJQ1IAcBHCZpZgvXO6W9VDsWQsBWuSXc/DApF/t1yaM2e2GgbCM91d62aOOP9uxM/Jhd4dhOh2890hqb/3nL63x5GroJqVvu88IE0G5pUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985966; c=relaxed/simple;
	bh=meoAl7VJ4L0S2JcmCiwLtvhomwsvNljoLTF7oZEN7cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPU2LkBS9aTC11UwBo6VMlbq08W4f15Fc2wb9rqqXNblOAjmrrP1ziWC+CBSyaMwZtxkViduP+XVZxPyDs+QbTEpENT7eh2jzQvxzsjk+8G9Linlovw1N3mWGHlb5xgbrD4Pr8Sf6WDMXvIeXUXSiFu0Ub2NQQzrDPJT+FDM5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnnsNmEQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714985965; x=1746521965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=meoAl7VJ4L0S2JcmCiwLtvhomwsvNljoLTF7oZEN7cE=;
  b=MnnsNmEQB7CwgfGLb94babQ2IqYlaPiv7+5UrMcnGsK+TdS4DRP56BZf
   Z+MgnI8R7V8UOjvyVCrvM+ieFZ9aarcN0JnHP3VHJRdoMkiFb9rRqZuHM
   N3t0iWeiORZvl2snuojV9H4V6GnUWMCw6BIEna15+tm9+LFNw6vLtpp/2
   66wlqZ88EJKmPvTk+UHdZDFRLM7dQ4L/rIStAQCKujuecjRJcrc9F2FyH
   tYALGQJZ24SzVT2dy7//WGo4+0PkSi0bfLVXQVBcLEtFL2YWyJAMc9HFB
   /odrO6iDti1eDyzC5zzRL2/o10XLXrHC6xcv4O0wP04whwf7Y6pcWt+8h
   g==;
X-CSE-ConnectionGUID: DHHrQsUHR7Gp069IjnVYrQ==
X-CSE-MsgGUID: 2mAS7ecmRP6b43SQTA3neA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21277119"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="21277119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:59:24 -0700
X-CSE-ConnectionGUID: 5HzU3DBkQGC6kLo+lFofBQ==
X-CSE-MsgGUID: LOsICayAREi2ReqULgzh4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32910466"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa005.jf.intel.com with SMTP; 06 May 2024 01:59:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 May 2024 11:59:19 +0300
Date: Mon, 6 May 2024 11:59:19 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: R Sundar <prosunofficial@gmail.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v5 linux-next] usb:typec:mux: remove indentation for
 common path
Message-ID: <Zjib5xNdpeNVfgtV@kuha.fi.intel.com>
References: <20240426164705.2717-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426164705.2717-1-prosunofficial@gmail.com>

Hi Sundar,

On Fri, Apr 26, 2024 at 10:17:05PM +0530, R Sundar wrote:
> Nitpick, Mostly common path will not be indented.  so rewritten this
> function to check device_node pointer is null and removed common path
> indentation.
> 
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

For the record, I'm still uncomfortable with the name - why not just
spell out your whole name?

> ---
> 
> Fixed nitpicks in code according to comments received on other patch as
> below:
> 
> [ Nit, this function should be rewritten to not work like this, the
> "common" path should not be indented, but only the exception (i.e. bail
> if ep is not allocated properly.) ]
> https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/
> 
> Goal is to get rid of of_node_put,but sending this patch first to do one
> thing at a time.
> 
> Changes since v1 - fixed the typo error for spell from identation to
> indentation
> 
> Changes since v2 - Shifted the indentation to one level left for the
> switch cases as per coding style.
> 
> Changes since v3 - Added descriptive subject for the patch and checked
> from and sign-off having same name.
> 
> Changes since v4 - Fixed name in signed-off-by as in documents.
> 
> Patches link:
> ------------
> v1  - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
> v2  - https://lore.kernel.org/linux-usb/20240420164927.15290-1-prosunofficial@gmail.com/
> v3  - https://lore.kernel.org/all/20240421011647.3027-1-prosunofficial@gmail.com/
> v4  - https://lore.kernel.org/all/20240424150718.5006-1-prosunofficial@gmail.com/
> 
>  drivers/usb/typec/mux/nb7vpq904m.c | 68 +++++++++++++++---------------
>  1 file changed, 34 insertions(+), 34 deletions(-)

Sorry for missing this earlier, but it looks like this patch only
modifies the nb7vpq904m driver, so I think you should specify that
already in the subject.
While at it, you could also specify the only function that is being
modified in the commit message (this is just a suggestion):

        usb: typec: nb7vpq904m: Remove uneeded indentation

        In function nb7vpq904m_parse_data_lanes_mapping(), the "if
        (ep)" condition is basically the entire function. Making the
        code a bit more readable by inverting the condition so that
        the function returns immedately if there is no "ep".

thanks,

-- 
heikki

