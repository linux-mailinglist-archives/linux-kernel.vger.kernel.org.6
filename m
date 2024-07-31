Return-Path: <linux-kernel+bounces-268909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD55942B04
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0F1B256CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84A21AB51C;
	Wed, 31 Jul 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dz0PyLsF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD71AC432;
	Wed, 31 Jul 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418712; cv=none; b=UkgRtJQgUIMC8pDiFog09GWYZfsP4Hzr1RG4C8SsTJcml4t56llZh4BCekAPvUWPtv2LlMcCw30R0NvqhQpNdi1rlNI/Yx01Bv9SteakJUx/JqGpob3uR5ohljrVLEH3B4mtNxuXSVCHVFwJ+YMcESMHrgn6tNCagkIbH4+ejoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418712; c=relaxed/simple;
	bh=CFTPxhFb0K7rYKGBpXdI7VHPyu9iXkMHxgG5kf9DD5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jiRy6c0wbsFc7OBZBQA+pvNZqAspygbVkdTn4NrsuPgje5z9fdARTPgqTMKQAcb/vNx70AqjQ7AtzmLLvEIUoJm5gajcGsgEG3SKEwpG15/ddbDed1yd2+VM+lj+eVGWk+8G91+y/XTWijEPBKVQ/pQjLLkjZRriQ66QJeq3fUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dz0PyLsF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722418710; x=1753954710;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=CFTPxhFb0K7rYKGBpXdI7VHPyu9iXkMHxgG5kf9DD5s=;
  b=dz0PyLsFDMWgF09p/s14WXCQIC9EI8mSG1tbblvrcgRSChKnx/UztlOc
   W5slOXlIEqxXdqnZ2+FoRSsweUWzu99Y15wUVOy8Nl4O7ieKEizeE628a
   kLUG8SyXdPg8CobvZQblMVPbraD4LD9e6u0QvuicAuvkmHrePDT37btKz
   gMKhlGt4jhY1vlE9lBWOd7buueaVL3pZ3kk4hc+jfxlhN3AhQsu4TZ18M
   bu81kxwusWpCKLL5RVGPrG/OCwdEFZxnRAETup+Pn2NwgYUoa9JQFnzAt
   ZPj0i5VzQIpnvjq2QIBWrP1tiAMCH9saFDEsv+1lT84l87+Y6tlhN9OKA
   A==;
X-CSE-ConnectionGUID: /V3M2mRvQ52YlVj+pUc5Rg==
X-CSE-MsgGUID: ELdczTrMQxuTNdSs4zQHAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="19977587"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="19977587"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:38:30 -0700
X-CSE-ConnectionGUID: pWIfqzyVROGLlckvyrvu8g==
X-CSE-MsgGUID: J/dXt0iCTRielnkQEvVbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="58755539"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:38:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Jithu Joseph <jithu.joseph@intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shankar Ravi V <ravi.v.shankar@intel.com>
In-Reply-To: <20240730155930.1754744-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240730155930.1754744-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v1] platform/x86/intel/ifs: Initialize union ifs_status
 to zero
Message-Id: <172241870140.1738.16219078765024239314.b4-ty@linux.intel.com>
Date: Wed, 31 Jul 2024 12:38:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 30 Jul 2024 15:59:30 +0000, Kuppuswamy Sathyanarayanan wrote:

> If the IFS scan test exits prematurely due to a timeout before
> completing a single run, the union ifs_status remains uninitialized,
> leading to incorrect test status reporting. To prevent this, always
> initialize the union ifs_status to zero.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/ifs: Initialize union ifs_status to zero
      commit: 3114f77e9453daa292ec0906f313a715c69b5943

--
 i.


