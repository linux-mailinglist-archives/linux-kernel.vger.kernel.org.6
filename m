Return-Path: <linux-kernel+bounces-405602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E50B9C552E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD43B34E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A721733C;
	Tue, 12 Nov 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu+ZJ9gI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5C2123E1;
	Tue, 12 Nov 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407236; cv=none; b=AdIdVgDLopmbi394aKWvIy35FZuiuATbOBYALa1M+biQSygmhu9KR4ulnjkrATp2Rcs0XxZSze1FHjAuTUjwl+Xcfwj/s0OgaTkgJNT28qB/iR8yDsvTtIjLPQQOnsm+Shhjgbwwj9ufaAC57Paik73/JwzSd8/4v5t/8BIIxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407236; c=relaxed/simple;
	bh=r3tdFHWQJmZnrPmjime0hJZBCdMEA6lv+qJPVtyxsro=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LiSku6mjnraMwBFEfeden2dY5SzW8sZv4ZedsbcJNodHLVc6qV1m9K30mfn45brrYDbDX9cF+LLLUNGfJsRSuOhoYGo2WO/2mgGq6U4DkqUuW806bOI8oV2DMVDsoE3PSaBhcQ+CjzbjgOPkJLPFoV1SVAj1ywI/KvNUde3IDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu+ZJ9gI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731407235; x=1762943235;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r3tdFHWQJmZnrPmjime0hJZBCdMEA6lv+qJPVtyxsro=;
  b=Yu+ZJ9gI+zlplXPMss3pGlpmLV9sQmWULyGEqrmT4BH+UGC0oVx42o9U
   +V95UoEP88kf/s7qaIB0dSeo3pF53CXnxdGPhZ0s3HsE2SROF2XcSkkvb
   KDLmIoLkguKpu1oRAzFdnhS+JNr36pVRJ9McXyOHQJcahGG9nIu1fUWTl
   6lggk/jQ+W1tv4QL6S95KW49Zb0/Qsa2nMii8bMupRJNRaO/po0O3VjAu
   RQkmApXYI2zNyGm+u7MnkZt1aj05Lm5zC5loJWOjjlD1wNZREsNZfsHtp
   kdguHgSPJaYrya+2xlBR2LoyR3yk+y9p5CcINlFIIgny0QkXTqFeLE7mL
   g==;
X-CSE-ConnectionGUID: q7Uxy7l8QBeXHIw/bTlECg==
X-CSE-MsgGUID: fxY7VbmfStCEBhAopscKpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="35166862"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="35166862"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:27:13 -0800
X-CSE-ConnectionGUID: nDdqt2vrRz2lTAdoGdXiJQ==
X-CSE-MsgGUID: 9IaxB7ADQGWoy5VxZ4xx1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="91888067"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:27:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 12:27:08 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>
cc: Cole Stowell <cole@stowell.pro>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, alexhung@gmail.com, 
    Mary Strodl <mstrodl@csh.rit.edu>
Subject: Re: [PATCH] intel-hid: fix volume buttons on Thinkpad X12 Detachable
 Tablet Gen 1
In-Reply-To: <32b477e7-27b7-4468-b506-2c565b2010e1@redhat.com>
Message-ID: <87f0e7ba-a02d-81a4-9479-42c8c9c365ca@linux.intel.com>
References: <20241107205908.69279-1-cole@stowell.pro> <32b477e7-27b7-4468-b506-2c565b2010e1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Nov 2024, Hans de Goede wrote:

> Hi,
> 
> Thank you for the patch.
> 
> On 7-Nov-24 9:59 PM, Cole Stowell wrote:
> > Volume buttons on Lenovo Thinkpad X12 Detachable Tablet Gen 1 did not
> > send any input events when pressed. When loading intel-hid with the 5
> > Button Array explicitly enabled, the buttons functioned normally.
> > 
> > Adds the X12 Detachable Tablet Gen 1 to the `button_array_table`.
> > 
> > However, the driver is unable to call INTEL_HID_DSM_BTNE_FN and prints
> > the warning "failed to set button capability" when attempting to enable
> > or disable the 5 Button Array. I'm not sure if this is normal,
> > but the warning seems harmless.
> 
> Yes the warning should be harmless and adding more special handling
> is not worth it IMHO.
> 
> Patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Hi,

I've applied this into review-ilpo branch but edited the commit message 
slightly by using the text from Hans' reply.

-- 
 i.

> > Co-developed-by: Mary Strodl <mstrodl@csh.rit.edu>
> > Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>
> > Signed-off-by: Cole Stowell <cole@stowell.pro>
> > ---
> >  drivers/platform/x86/intel/hid.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> > index 445e7a59beb4..48ad75a56199 100644
> > --- a/drivers/platform/x86/intel/hid.c
> > +++ b/drivers/platform/x86/intel/hid.c
> > @@ -118,6 +118,13 @@ static const s
> > truct dmi_system_id button_array_table[] = {
> >  			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
> >  		},
> >  	},
> > +	{
> > +		.ident = "Lenovo ThinkPad X1 Tablet Gen 1",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X12 Detachable Gen 1"),
> > +		},
> > +	},
> >  	{
> >  		.ident = "Lenovo ThinkPad X1 Tablet Gen 2",
> >  		.matches = {
> 


