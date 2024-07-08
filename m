Return-Path: <linux-kernel+bounces-244006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D421929DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C0F285821
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0643BB25;
	Mon,  8 Jul 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdGiSxna"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612E39AEB;
	Mon,  8 Jul 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425412; cv=none; b=ubqxrCh9wLQfv+bDVhZxg8NFoJtKOvHUyYriIp8uRA2+KBsyrWvXsIr+gv+leTk8akf/xmffRAFOmf6+n9m4IDrPXIlr1ZAYBYFg+sFtsUJCwQx3CDn9DUtwRnV/B2fxwncYhGqhDJXg0MGm3WC+2hFBfxNvOK48WA2MzIWslCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425412; c=relaxed/simple;
	bh=xQIJDnKzG/pmp1osbfArOuhYkmP/jZwxB3eVrcMED7k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=StiL0cr9ScMsYFDquIQLXrR8Q1e891csTZOa6ixlsC42M6y/mxLuU1SMcc8KBMfnzd+054qCejXbFlkySGRkGlY2OBg4bhBaGNYORyZVubimJEqxi8ulaAuXSlivAp1Hilx6AHF6WGoCM6QvMQctdJKlccLZNEu37kMkiieyVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdGiSxna; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720425411; x=1751961411;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xQIJDnKzG/pmp1osbfArOuhYkmP/jZwxB3eVrcMED7k=;
  b=PdGiSxnaz4NrO8Fxgs21udNU7Ta9Pvl/ijJqm0oCs4QJqikFSCkpPYg0
   Kc34b4AIGxb0hyDOD1X25sbx+6wOwsOIrHBhl3c9WRaNes/pntvEA56jw
   Wi7Z2NNkJPYaq+ODBAP+rRMoS893VrRpZxSNBS1XSsZtF0N0tFzZZwMQ5
   AlB0joiEadJrfZ3+0QLptIaPkKLVZ4TaK+MnHEhwo1gUAUNsY942zAY43
   VByhbrgsYs3UhgftDh/RsFRI+YlM/PGyab8yltQdGHaGcUF7/jqsSYQem
   GvAgWnVAbbk/tM4iO3gyb42E9MXjxZB3bzOUNQqZM6viQHECT60labE7g
   A==;
X-CSE-ConnectionGUID: zZ5RJX/ETe668umSksMZ/Q==
X-CSE-MsgGUID: 9s1MH9aTSfqwB0ndvDMM3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28216830"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28216830"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:56:50 -0700
X-CSE-ConnectionGUID: MpU4q5AvR+u8MXy46m853A==
X-CSE-MsgGUID: FCqibOSORcWB32N6wXe7+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47859566"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.115])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:56:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Jul 2024 10:56:43 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] platform/x86:intel/pmc: Convert index variables to
 be unsigned
In-Reply-To: <20240624203218.2428475-4-xi.pardee@linux.intel.com>
Message-ID: <f65374fd-1bdd-f6e2-4c9e-9ce5d9f7fd9e@linux.intel.com>
References: <20240624203218.2428475-1-xi.pardee@linux.intel.com> <20240624203218.2428475-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Jun 2024, Xi Pardee wrote:

> From: Xi Pardee <xi.pardee@intel.com>
> 
> Convert the index variables type to unsigned to avoid confusion and
> errors.
> 
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 51 ++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index b524b74293ca..cbdcbf288f67 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -247,7 +247,7 @@ static void pmc_core_slps0_display(struct pmc *pmc, struct device *dev,
>  
>  static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
>  {
> -	int idx;
> +	unsigned int idx;
>  
>  	for (idx = 0; maps[idx]; idx++)
>  		;/* Nothing */
> @@ -260,8 +260,8 @@ static void pmc_core_lpm_display(struct pmc *pmc, struct device *dev,
>  				 const char *str,
>  				 const struct pmc_bit_map **maps)
>  {
> -	int index, idx, len = 32, bit_mask, arr_size;
> -	u32 *lpm_regs;
> +	unsigned int index, idx, len = 32, arr_size;
> +	u32 bit_mask, *lpm_regs;
>  
>  	arr_size = pmc_core_lpm_get_arr_size(maps);

Hi,

Thanks for these patches. I've applied them into review-ilpo branch.

While applying, I altered the return type of pmc_core_lpm_get_arr_size() 
to unsigned int as it seemed the right thing to do after everything 
around it is already unsigned.

-- 
 i.


