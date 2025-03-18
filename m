Return-Path: <linux-kernel+bounces-566249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D5A67572
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CF63BDAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C53420DD43;
	Tue, 18 Mar 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDPHWWIA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF2148827
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305436; cv=none; b=dISNnfn9jfgPqTCX3z4lzJNrT7zBVf8ZM8Xp296j7t759YVPuY9LebVVIoNtm4EhG6eXGj5hb6oW0dYYHKf1xLard79PWO43FESifCiotUrYSFJA1E4ylynSL/hMcmTI//RD2eusvGx5Q3g+FnXOM8nvMgq7ppuE5QsUMOixMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305436; c=relaxed/simple;
	bh=uTN+eBYgOfv3Wl4zi9ajxanfhWVyzWlH/H9w1CTv8og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMWCPl8iN4wmgis9RsgpC8bt+zofjbZaM9psUVM+BJveKbIQQcl5Atg2SSczM2z9fqbSRzhyJNicUS+K2m9cIaSTKnZlmxQ32KMTP+6m0w6j26GgP6MDhmLFi0vEUZKmdzJHr/93A08sC3OyGz2U/atm+Gw87f7TDsMp/75Cw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDPHWWIA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742305431; x=1773841431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uTN+eBYgOfv3Wl4zi9ajxanfhWVyzWlH/H9w1CTv8og=;
  b=FDPHWWIAS7/kz9kpR/hbHKeIpK2TdDWu+IAdDCZp/sjvCcOZhDUVaXWu
   4tl58t7oWsCIS/kb/78PtSVlLnFF1iDMhUQKCTlGDBE5+DzyJGzmt9O/0
   0ZkHhD5syljIUlghAgJ1zOfFhZHTCDIDcAFR9i1UFmlRn606AFjwhx3Uy
   jnvZXNemkuyTOqR7JfeyuqBmC4e3OkLCCqKz+jf/c7ltTnCKg7XyatD7h
   DUvvcZcZ2bNhWXssddBOKgeWOMoDkQVFf0y4kNnqQpKGVapM8h+H7lSu2
   uCPqgh0OOYHoMHRrisSHIyPs7qwLYD40ObamjclVoAa/CyzZh+B6qlWCF
   Q==;
X-CSE-ConnectionGUID: NwPALNm/QMOfci7L7LM08Q==
X-CSE-MsgGUID: dTW7Wi6LQUqkBiiXP/g6YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54122488"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54122488"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:43:50 -0700
X-CSE-ConnectionGUID: 0AUjGvH5SjmTPNRKELTP3w==
X-CSE-MsgGUID: a3ikDP44SMOLRmp0YQx/1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153248082"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:43:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuXEQ-00000003dP1-2itr;
	Tue, 18 Mar 2025 15:43:46 +0200
Date: Tue, 18 Mar 2025 15:43:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: giometti@enneenne.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pps: generators: tio: fix platform_set_drvdata()
Message-ID: <Z9l4ktWrZ3VGN8B_@smile.fi.intel.com>
References: <20250318114038.2058677-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318114038.2058677-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:10:38PM +0530, Raag Jadav wrote:
> platform_set_drvdata() is setting a double pointer to struct pps_tio as
> driver_data, which will point to the local stack of probe function instead
> of intended data. Set driver_data correctly and fix illegal memory access
> by its user.
> 
>  BUG: unable to handle page fault for address: ffffc9000117b738
>  RIP: 0010:hrtimer_active+0x2b/0x60
>  Call Trace:
>   ? hrtimer_active+0x2b/0x60
>   hrtimer_cancel+0x19/0x50
>   pps_gen_tio_remove+0x1e/0x80 [pps_gen_tio]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



