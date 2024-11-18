Return-Path: <linux-kernel+bounces-412618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1939D0B75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCE8B2171E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9618C34B;
	Mon, 18 Nov 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMu46P/A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC118871A;
	Mon, 18 Nov 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921264; cv=none; b=cyCwdph/aMtFVUsMZ8Imyv1+9vOAFkNodXxUIE7YCA6UO85oczbmqklyERGYTAaZGzQn2sUCyybvYcEGM+GiLNqoMXoewNp2hOYsZSmwmCvodh17nx9gK2+eHRlxoj6nUfHwiK95s7lq8F3dY7tv0YyUImL3M/fOtuBSH31ydjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921264; c=relaxed/simple;
	bh=hSzewweX/6QCLXU+M888JYO3hhX0ZDbaQ/lubqqZO/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjmzDrR3+90sRWaYomHV2NwYklsCSp3C+gax2zMUE0PJ0eJsyStXiMm72yDZdr1wC+b040yWOeOsikHZksR6phzBxq//hC4swyiv2CoTEMNSNa5/EIgdbiVaNXk+IC3/jwRYGWc8B31f8BlYVba5FZkyG+9jxTzt7IOQZ5r1XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMu46P/A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731921263; x=1763457263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hSzewweX/6QCLXU+M888JYO3hhX0ZDbaQ/lubqqZO/o=;
  b=NMu46P/Ag1iJPN/Zd1W3VuyEAfOnUinlfviDO3VhlHR8vlhw7pPSfzgb
   u6EVbSy/XXw8TrJJQyRRul7YfeX2MdpZTlCdJsjQj9pHiOphv0NrrTAFQ
   HLHOPnUoj5VrGC/WUNjOFhb7YhYHe0EA+9o0FIAaxnrj9CtLCBQVvES3o
   37Wz9uL60N704luBFhxec9Ez9qKianDpuDKIbu7e4T0nKtA/6jBrRfZZp
   OLbzp5EoC5/Z/jy4uR6xXYmyDCU7SbXU0xq6Tj6dUHUUCOQT8c4vkXYHp
   LH2APeLY11jpod6XzIyyXHIumy9gO5XkkYApPahz1mVPD/WLYcGB+Gj6m
   A==;
X-CSE-ConnectionGUID: clMmv2G4R8G/EGr/0sopPQ==
X-CSE-MsgGUID: rqjKp/I2SlufZ6H6P8Dftg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="35780028"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="35780028"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:14:22 -0800
X-CSE-ConnectionGUID: w4e3ckILTQKR8brnyLVAvw==
X-CSE-MsgGUID: NiKv9goZSjyVlfxeykUlKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="112466750"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:14:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tCxpn-0000000Fwns-0azQ;
	Mon, 18 Nov 2024 11:14:15 +0200
Date: Mon, 18 Nov 2024 11:14:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, shenghao-ding@ti.com,
	navada@ti.com, 13916275206@139.com, v-hampiholi@ti.com, v-po@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, antheas.dk@gmail.com, philm@manjaro.org
Subject: Re: [PATCH v5] ALSA: hda/tas2781: Add speaker id check for ASUS
 projects
Message-ID: <ZzsFZnWeEAbIjgbN@smile.fi.intel.com>
References: <20241116075006.11994-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116075006.11994-1-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 16, 2024 at 03:50:06PM +0800, Baojun Xu wrote:
> Add speaker id check by gpio in ACPI for ASUS projects.
> In other vendors, speaker id was checked by BIOS, and was applied in
> last bit of subsys id, so we can load corresponding firmware binary file
> for its speaker by subsys id.
> But in ASUS project, the firmware binary name will be appended an extra
> number to tell the speakers from different vendors. And this single digit
> come from gpio level of speaker id in BIOS.

...

> +	// Speaker id was needed for ASUS projects.
> +	if (!strncmp(sub, TAS2781_ASUS_ID, strlen(TAS2781_ASUS_ID))) {

Better approach is

	ret = sscanf(sub, "%04x%04x", &vid, &did);
	if (ret == 2 && vid == ASUS_ID) {
		... // matched to ASUS_ID
	} else {
		... // no match
	}

Alternatively it can be

	u32 subid;

	ret = kstrtou32(sub, 16, &subid);
	if (ret || upper_16_bits(subid) != ASUS_ID) {
		... // no match (as in previous 'else')
	} else {
		... // matched to ASUS_ID
	}

With it it will be clearer to see what's going on here.

With the above you can get rid of the custom constant and
use PCI_VENDOR_ID_ASUSTEK directly.

-- 
With Best Regards,
Andy Shevchenko



