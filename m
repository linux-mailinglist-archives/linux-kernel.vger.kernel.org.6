Return-Path: <linux-kernel+bounces-521787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFE1A3C253
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E9B3AD0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB06B1F2B8D;
	Wed, 19 Feb 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M54h55MK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFC1EFF9B;
	Wed, 19 Feb 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975827; cv=none; b=Eg3P1CLnXmbXWtUrSVnFtNlc0jsbo1tc5ratTn2oJXLqV52XJ34pxxBv7a5JeD40CU3MJvRO6/abkNfcMaGMqq2Vcn3LffNxTy7YrSU0rkN91I0ddJIHEukKZx1h5Gt323nVhP+cviHkoWKvr55aUYArk7y0f8evHMQZ6tEYuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975827; c=relaxed/simple;
	bh=Cy2uzR5sSMeZpB6yyjkJvB+XTzsSwXMHJo8AMbj5rVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufNy7pfNcs4m12B9q626keT3NTc1MdITiyc694GrLCUUSMGrxnGtDkVgdPP+CaDbiralcM4GSJpal0yHBubCoW9pyG28fF02HHYhLO1+CHIKkEFzTsL1eqXiK13ElYiu08CeP0rBOMF2EyjXGlISQWB3SGm+X+ZfhzgonTIiBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M54h55MK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739975826; x=1771511826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cy2uzR5sSMeZpB6yyjkJvB+XTzsSwXMHJo8AMbj5rVo=;
  b=M54h55MKyqYbYC31XMzltlklJXRUBMcz9/bVjK11QcYUtpiZk1Wk1SAh
   IzqSlFNSswaed8p2Ranq7kqmjSWjuuNTztC3Dewc+PTJEeb3aG7PRLraA
   xVzbbKXZ0X0S3c4sf2qArcde9nFX94d4pnsNthzVY4e9zS+8TfHPGWPps
   nbaEPdThcscDTQe4cUp0tPTRWVRyTHXc4Z9WUoNfrarAHEl5lawe9V6Pn
   9BmCTs5xdFnJZhCkLI3wc7WA2GhhX7kp6q9/cYQj7iYxkyW+OT26JE49L
   fi0dCPH235gi8J2bvyQGS9RYywdRO2mUQT7wrE005JFVSFh08OgZdy4g3
   g==;
X-CSE-ConnectionGUID: la9gQbGKStGh4nU4koq9Jw==
X-CSE-MsgGUID: lmDJn2WhSbGMlBqyRHLIxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51333570"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51333570"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:37:05 -0800
X-CSE-ConnectionGUID: Zu6rQLmiQdG55ox8xxG6ww==
X-CSE-MsgGUID: DbC6MqTmSJqi7QQQAt076Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114712946"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:36:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tklBD-0000000D35X-2Pv0;
	Wed, 19 Feb 2025 16:36:03 +0200
Date: Wed, 19 Feb 2025 16:36:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Ashok Raj <ashok.raj.linux@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/4] platform/x86: intel: Use *-y instead of *-objs in
 Makefile
Message-ID: <Z7XsUzAkDviFMz62@smile.fi.intel.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
 <20250218194113.26589-5-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218194113.26589-5-kuurtb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 18, 2025 at 02:41:11PM -0500, Kurt Borja wrote:
> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
> instead, which is usually used for kernel drivers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for all 4.

-- 
With Best Regards,
Andy Shevchenko



