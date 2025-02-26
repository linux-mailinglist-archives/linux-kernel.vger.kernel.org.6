Return-Path: <linux-kernel+bounces-533896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7BA45FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB17176276
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0EB21770D;
	Wed, 26 Feb 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9Zhu9cG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EA13BAE4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574864; cv=none; b=DJ7fIPnbAVFgVR4Kq6/sb3ViCLugvURyx3ZdoAxcN0ERcwHAiNDJldpQwzvrap/ndgWIAuWSzcxcoAAquYzt8kj9ydDebJ7CyiG6oZ0YEEP07skX13L0XIlbA/iNANv38uj5U7Qyt3NncLgVJoniuW2ur2cA/ZDgEI5qnGikvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574864; c=relaxed/simple;
	bh=aFsSIDgQsI7tJMg1km8GcrGOIXvm96n8p7vR8dZR+mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSyYMYE+zkKMSpdAHNF9YJVZcid8vLDcamYrtPxHhxXGYlp8ap2m6B5Pp0qmAUnnuYn7TAMXK/25nye19aqSk6UCzaXrd9ZJnlPF1f62cDYz9oi5KpCGreI0IupEKSsxXf+Qu0jJnSmIbIYkYQqtkMR+4sLV5ubWB5DEY2PaFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9Zhu9cG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740574863; x=1772110863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aFsSIDgQsI7tJMg1km8GcrGOIXvm96n8p7vR8dZR+mQ=;
  b=O9Zhu9cGWlZnm+cs76ru+0/jC8GAfqUIX90APw76lZM598AebqXBgPGv
   ILtRO13AijIThykcYBexi5HKUKwVc/ziuMFtR4zIho6ZaohG4xZJS01Kl
   foWQ/UhlXD7FzJ/l3u/MYNbzZolR1/byEn1XHp6Gm2UTqflwktH8PCh9M
   LqaiE/JIXlATg6D8/mQqNqgZdHFBLI68qR96cEVf9UzZanG9rON8aJie/
   /4QbJUYbXhJbUoQlKz0o0jcWt2I4uloHu/gOiMZkqNXswj5qnm1gRULWS
   Xti8fqsL0aBq33mUn7aiQ+q3w8f6cI0TIWajV62WdIk/JIPvyph0qZSPk
   Q==;
X-CSE-ConnectionGUID: GnBIrVxiTt+cLdnL0Hs6vg==
X-CSE-MsgGUID: MLag50g3SWKRuKQQPXnoWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45329294"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="45329294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:01:02 -0800
X-CSE-ConnectionGUID: C+PVLKGGRn2l26SiTBHYlA==
X-CSE-MsgGUID: cQEuLMG4Qta1XkJaP76Akw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153862510"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:01:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnH21-0000000FKOR-1IG2;
	Wed, 26 Feb 2025 15:00:57 +0200
Date: Wed, 26 Feb 2025 15:00:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: lee@kernel.org, giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] pps: generators: tio: Introduce Intel Elkhart
 Lake PSE TIO
Message-ID: <Z78QiXa4-Efoq-hT@smile.fi.intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-4-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226061527.3031250-4-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 26, 2025 at 11:45:26AM +0530, Raag Jadav wrote:
> Add initial support for Intel Elkhart Lake PSE TIO controller.

...

> +static const struct pps_tio_data ehl_pse_data = {
> +	.regs = {
> +		.ctl = TIOCTL_PSE,
> +		.compv = TIOCOMPV_PSE,
> +		.ec = TIOEC_PSE,
> +	},
> +};

Same as previous comment, please move it further in the code closer to the ID
table which is the user of this data.

-- 
With Best Regards,
Andy Shevchenko



