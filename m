Return-Path: <linux-kernel+bounces-327899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23784977C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBEC1C245B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A91BD4FF;
	Fri, 13 Sep 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4/AZdzs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20D1BD4EA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220415; cv=none; b=JMSicoQdoR999da8QBfgTI2KGiDeTwhtPkx8lFUIbrsZ4P50ec/4Q3pQ5lzq73WkjIwbD/Vlefv8Nd4O33g1Ystw09xWwSpxgTKJx9vnqnKQzSTaVPN/e5S8ag/hnU5bo2zlSFc2RIO2R4QaNiTZNxETyWDPIm3rGz2wZuQ+wGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220415; c=relaxed/simple;
	bh=cOSrEE905Rfu8CuPrTD5Phsawe1N0e+sdn2jMHVTme0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXXnftiadB8trZ1gkC0mfqevCqtBuxBLsKvK9v40pkomlBoe4iCOvygcV7gKwimgQQzg0+Jp/NnWv5kvNhaQnMV2+AzX52lLW7cNydxTa8e5XaKmZ9TlBGJibt9MzdTyl9ii+Vk3Av9R2MrYm6J6tUreHSLFSQVX/8QjvW/jQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4/AZdzs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726220415; x=1757756415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cOSrEE905Rfu8CuPrTD5Phsawe1N0e+sdn2jMHVTme0=;
  b=B4/AZdzsb97QM+IDELlW5vFEWVJFQknAw+/Wndy/gqAoJtb7sPcAyxxC
   bzKTfZgA78kPDwT6KYa0OokErA7EOIMjbiGt8ewohV6GlpPD1c1J3JpvO
   6tl3u2kC3+5Ncj8P/l9hCixEfrmOrn+B4llLQGY1sQzzBMOeIYmvzHkci
   dTQ9bifuLlyaY1ucMW9w0arXOCeoMXv/UeaTfeg9S2BvPZNMAvG571CnJ
   EjfalbJLY/tTehKSv0dj9V46wfjZ81275bAyQv3Gnt+Re0wMJ19BwbfRV
   pfUkL4iaqP+aVQhfBPaOM8CVRKe6vkylkaieHAy6j2zJIdoAGGObgO5/4
   w==;
X-CSE-ConnectionGUID: MuIFlhtDQKat1Pkh6mL6BQ==
X-CSE-MsgGUID: axWUOkz8TqeGgQ8OvGrb/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35780000"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35780000"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:40:13 -0700
X-CSE-ConnectionGUID: 7fZULQ5AS7q2ErYODBmC4w==
X-CSE-MsgGUID: CYkBKoFESF60js26xiMzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105454536"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:40:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2mf-00000008FKa-2pg1;
	Fri, 13 Sep 2024 12:40:09 +0300
Date: Fri, 13 Sep 2024 12:40:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] uio: uio_dmem_genirq: Make use of
 irq_get_trigger_type()
Message-ID: <ZuQIeVAdC1O2xAM9@smile.fi.intel.com>
References: <20240912235925.54465-1-vassilisamir@gmail.com>
 <20240912235925.54465-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912235925.54465-2-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 01:59:24AM +0200, Vasileios Amoiridis wrote:
> Convert the following case:
> 
>         struct irq_data *irq_data = irq_get_irq_data(irq);
> 
>         if (irq_data && irqd_get_trigger_type(irq_data) ... ) {
>                 ...
>         }
> 
> to the simpler:
> 
>         if (irq_get_trigger_type(irq) ... ) {
>                 ...
>         }
> 
> by using the irq_get_trigger_type() function.

Btw, can you add a coccinelle ruleset for this?

-- 
With Best Regards,
Andy Shevchenko



