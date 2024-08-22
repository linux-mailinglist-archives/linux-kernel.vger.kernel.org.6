Return-Path: <linux-kernel+bounces-296873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3295B010
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447ABB23339
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3716DEBB;
	Thu, 22 Aug 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uqi4OjjP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456C1547EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314720; cv=none; b=hkH3Ged7kAWdWBxrx4DJg6BdbEmlga5xtb7LeYkoNwhSl7cfDbNIUtZjQdKkylGsuyCmjV4v9E77rQ5gUiWPbl/woI82AuoDbeTVBBCOvL2zpB/oTa9BkNYyb7OV/0KjiyInZRy55qZV8TBTPq4nY9xJMYRtgLJDQSn6++Mp/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314720; c=relaxed/simple;
	bh=9MmmmklF/yizWWGEjFJjdie1UnunmTEc9qKCljXIsPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIuBAjtoxawzIpKyyplCNBbklr0dkVjDC2rKym8lR/Ce0KkCfPwRimx9s6cpVEg/dkqm4Wp9/aZZ6E5vbEnhgiB3FP/4cF3LhIky7iwlUfu70rnJmVcubma+MX1jNhIrsonP4McvRUjMIxAPLjDVEtZ0hRdYCjw21KJo9mMQE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uqi4OjjP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724314719; x=1755850719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MmmmklF/yizWWGEjFJjdie1UnunmTEc9qKCljXIsPk=;
  b=Uqi4OjjPqDDJXNciDK6JJHHpdqJbh0TvfWzcxlj7uvKrf+pdfqZ/GOuD
   tAdKmG+pT5s6EkazMLbpQ5Tz9U6NX62RXZoeQ34c+pGa+ovuX9uCYim8X
   ZosDPgBIwh8sg0oPcnT4jjcKULmDxqJZDDiG8ZaET5XVp2d2p5jaLOdPL
   FkXD7T/2Kf0JsJSLyeC0OjXL2A6WPHAo4uayzOG+56n2yDbZcGD4MQqVg
   A8Ro4N528oDsopyIFsevjRa58W7180kg1ZGEDn66OMA9Uvd66QfySokV+
   qCl+aTC/TpJlsm2j3oLEC8FYzggOCrEncUv5ak5evFgvU0lpBCUMuctFx
   Q==;
X-CSE-ConnectionGUID: JGr9wI4DTQiY8SpvXQRN7g==
X-CSE-MsgGUID: yi9PN/F8QQaRaqX1iRLzoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22883565"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22883565"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:18:38 -0700
X-CSE-ConnectionGUID: TeokA5NzSNCcM9jW0lovwQ==
X-CSE-MsgGUID: 2rB7pi9BQSGJBX9jXJ4zqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="98863154"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 22 Aug 2024 01:18:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5349E43E; Thu, 22 Aug 2024 11:18:05 +0300 (EEST)
Date: Thu, 22 Aug 2024 11:18:05 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v4 4/6] x86/tdx: Add a restriction on access to MMIO
 address
Message-ID: <fzaia3kslzfxj35mmarkpydlt73ha7fr6qo2ub47zfu7l6f7c4@axlrzkeqavod>
References: <cover.1723807851.git.legion@kernel.org>
 <cover.1724248680.git.legion@kernel.org>
 <0d4381397c33426bda5d3b0e5541965dcebdf962.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4381397c33426bda5d3b0e5541965dcebdf962.1724248680.git.legion@kernel.org>

On Wed, Aug 21, 2024 at 04:24:36PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> In the case of userspace MMIO, if the user instruction + MAX_INSN_SIZE
> straddles page, then the "fetch" in the kernel could trigger a #VE.

It has nothing to do with "straddling page". It's about tricking kernel
into doing MMIO on user address.

For instance, if in response to a syscall, kernel does put_user() and the
target address is MMIO mapping in userspace, current #VE handler threat
this access as kernel MMIO which is wrong and have security implications.

> In
> this case the kernel would handle this second #VE as a !user_mode() MMIO.
> That way, additional address verifications can be avoided.
> 
> The scenario of accessing userspace MMIO addresses from kernelspace does
> not seem appropriate under normal circumstances. Until there is a
> specific usecase for such a scenario it can be disabled.
> 
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>

Cc: stable@ please.

and this patch has to go ahead of the patchset, targeting x86/urgent
branch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

