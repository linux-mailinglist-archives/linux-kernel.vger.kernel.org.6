Return-Path: <linux-kernel+bounces-511073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B26A3256B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69711888687
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91420B20C;
	Wed, 12 Feb 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgaCeMAG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44220B1FA;
	Wed, 12 Feb 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361055; cv=none; b=ngXTHcDiCop4bPi+FfkX6yDk/WPY/1kf7tmQi4LZgcLViU8WfHplo2OftN2ddK87rL48avGYckl09cq7CH42jJ1NxXuMOygsen77A1xAQdLtlzYPBcoCUsVoQcym8bWRAKV5jvtB3Qgaiksl4Ulwa6TvykjAzooJyObHmUHqwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361055; c=relaxed/simple;
	bh=2p4wDK+mOmCaL63HCLt90i0h6d4jY935NDq3ljzcRVw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gI7f93ZYayGCFfOEoZEWCqvoNT4+vkFPs3ZPmYflsiGlhmyCSSpT0ofZLC3D+zXLCHiLBUCw1ymvL6e7uhczmTG2Sx4XM5yQ+73GBO1Z3PV7llw2anE7v/b2mOhpRJDwpRspkGXGfMw0m9xeWES2O7Ei9ZqUTfVLdAwJPQ2M4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgaCeMAG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739361055; x=1770897055;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2p4wDK+mOmCaL63HCLt90i0h6d4jY935NDq3ljzcRVw=;
  b=FgaCeMAG+qGJOyukVn9T5BF+oDM2gMub/BzSjY4payfla2saxVhUqo+7
   zmlI+P/RC6VRg8qhlDtKhn3uxwM8Y/m9TSeQwZ/Z6GP5uigWN/fY+khRs
   vCVaKKgHDSuJh82V3SG7AyBxiAT8g4f4a3Xf7HTblQ6PQ8tRnI0Qm8tUq
   /HPPo/oXJSkuhhSPyqSGhmxT011bDhFIrc7kkTWhyC8mj0/2N4T8WKyT+
   k84xit2TcqVKs5OFYvDma7dqpyYkGTxOvhUOEe/qvSAovEoY79bu4GrqT
   1PGtSYa24QFvF3K/TEnh+qKgnWxDn3Yz9fbXhxrDPcvae32lAcdxJk8Gi
   A==;
X-CSE-ConnectionGUID: ZFJJHPsETs+KNQVNMetRKw==
X-CSE-MsgGUID: Gh55HtFiRvisqQyatYnYKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50234313"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50234313"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:50:54 -0800
X-CSE-ConnectionGUID: gEvzZfBxSdGXVv2zmvZqKg==
X-CSE-MsgGUID: NITsXsmtSna//vfIRqvVxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113702502"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:50:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 12 Feb 2025 13:50:47 +0200 (EET)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: Fix registration of
 tpacpi platform driver
In-Reply-To: <D7PSW9W74P7I.GBMKQD7EGPXT@gmail.com>
Message-ID: <6112b35f-fdb4-4beb-490e-03569ce9f17e@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20250211173620.16522-1-mpearson-lenovo@squebb.ca> <D7PSW9W74P7I.GBMKQD7EGPXT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Feb 2025, Kurt Borja wrote:

> On Tue Feb 11, 2025 at 12:36 PM -05, Mark Pearson wrote:
> > When reviewing and testing the recent platform profile changes I had
> > missed that they prevent the tpacpi platform driver from registering.
> > This error is seen in the kernel logs, and the various tpacpi entries
> > are not created:
> > [ 7550.642171] platform thinkpad_acpi: Resources present before probing
> >
> > This happens because devm_platform_profile_register() is called before
> > tpacpi_pdev probes (thanks to Kurt Borja for identifying root cause)
> >
> > For now revert back to the old platform_profile_register to fix the
> > issue. Will work on re-implementing this later as more testing is needed
> > for full solution.

Hi Mark,

I've applied this to the review-ilpo-branch. I had to rewrite parts of 
your changelog though to not say "I did/will do this and that". In future,
please just state the simple facts. What the issue is and so on, do not 
write a story about how you came to find that out. :-)

-- 
 i.

> > Tested on X1 Carbon G12.
> >
> > Fixes: 31658c916fa6 ("platform/x86: thinkpad_acpi: Use devm_platform_profile_register()")
> >
> > Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> I believe this is done now!
> 
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> 
> > ---
> > Changes in v2:
> > Modified approach to instead revert to old platform_profile_register
> > method. Will revisit using devm_ version in the future as more testing
> > needed.
> > Changes in v3:
> > Add check if tpacpi_pprof is valid before releasing.
> >
> >  drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > index 1fcb0f99695a..9f6d7e26e700 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -10646,8 +10646,8 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> >  			"DYTC version %d: thermal mode available\n", dytc_version);
> >  
> >  	/* Create platform_profile structure and register */
> > -	tpacpi_pprof = devm_platform_profile_register(&tpacpi_pdev->dev, "thinkpad-acpi",
> > -						      NULL, &dytc_profile_ops);
> > +	tpacpi_pprof = platform_profile_register(&tpacpi_pdev->dev, "thinkpad-acpi-profile",
> > +						 NULL, &dytc_profile_ops);
> >  	/*
> >  	 * If for some reason platform_profiles aren't enabled
> >  	 * don't quit terminally.
> > @@ -10665,8 +10665,15 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
> >  	return 0;
> >  }
> >  
> > +static void dytc_profile_exit(void)
> > +{
> > +	if (!IS_ERR_OR_NULL(tpacpi_pprof))
> > +		platform_profile_remove(tpacpi_pprof);
> > +}
> > +
> >  static struct ibm_struct  dytc_profile_driver_data = {
> >  	.name = "dytc-profile",
> > +	.exit = dytc_profile_exit,
> >  };
> >  
> >  /*************************************************************************
> 

