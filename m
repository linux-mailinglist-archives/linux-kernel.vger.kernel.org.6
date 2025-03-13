Return-Path: <linux-kernel+bounces-559643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2AA5F711
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38B117357A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0B267B07;
	Thu, 13 Mar 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U14gIKjP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E9267701
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874223; cv=none; b=Zzp9EtoKvuv/p7EDNli5onBcqLyGRC7s0AN4jZiOWES4kMBHOekyyl7+gTvRQdOSOqNgO9ZQteM0cUnIuP8C20oC/6lAmPpHtrVsUwY2/zzVdtSET0ATuJVIhvHh/dbJ0QGkEs80adlcSakXGEwWeo62v71ISOg9tHYumgE6fmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874223; c=relaxed/simple;
	bh=LGMAZVxMLMP4zoINiImPzFOYs0NI6DAPitF/gHKG7v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igWkbAAuFGPNsiuqN05aO9igZ7/l0qCjdGdUqbAHjzYZ7OQcsHY6Cz1rdSHO6i8mNkwyXU5xMC8ZT7axfGAXWMIeRUmxi8Rwi4adcUqyZWklrG96FiN6jE8qy6xm1qPE5zt6BtbN+sRaOxu7e4umjoUNjbPY1Oj7p3eA3VbVKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U14gIKjP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741874222; x=1773410222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LGMAZVxMLMP4zoINiImPzFOYs0NI6DAPitF/gHKG7v4=;
  b=U14gIKjPnUJGG1IJFxvj2NR36jCZ3dNnf9EWs4fIcrSVuS7k8BY43wS1
   0FEHxfdFtXNywa4NuXH42Pzi48kJcT34sqi5zUDqizgohbuo1DylSzoH6
   mnBJ7sSQCb6ISZVQVOXLl6HaszlqEUo3RMhleJqicTc+v89Mr/31zFTEw
   j573THmbrqeXAxjwDVrjirYyY+/IqsP502071fN8PInZyfMR/Dtv5n/F4
   HB412o4zFIwmvBlAKw8+W+3zPiWDoHafPdfDdeuUELpTMDO4SHQK2Y2xD
   EbQ3yWTCe5/L85W81zJ/+WrA/YU1kqm+A1lr3HKOV64epkdgP49jHbXwy
   A==;
X-CSE-ConnectionGUID: gKU5JbfiSgafU8DcYJcB1Q==
X-CSE-MsgGUID: Cu8kQfslTdaGCr19u/VamA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54364730"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="54364730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:57:01 -0700
X-CSE-ConnectionGUID: /DiW6qIxT324umM7RI1qug==
X-CSE-MsgGUID: jY5Rv8mzRpiuSYHqa61QlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121016098"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:57:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsj3R-00000002BzV-10we;
	Thu, 13 Mar 2025 15:56:57 +0200
Date: Thu, 13 Mar 2025 15:56:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/1] mtd: mtdpart: Do not supply NULL to printf()
Message-ID: <Z9LkKLLl2Z5cANga@smile.fi.intel.com>
References: <20250313091631.243346-1-andriy.shevchenko@linux.intel.com>
 <f17a1851-7360-3f18-4e89-dbf6948eeaff@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f17a1851-7360-3f18-4e89-dbf6948eeaff@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:09:09PM +0800, Zhihao Cheng wrote:
> 在 2025/3/13 17:15, Andy Shevchenko 写道:
> > GCC compiler is not happy about NULL being supplied as printf() parameter:
> > 
> > drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
> > 
> > Move the code after the parser test for NULL, and drop the ternary completely.
> > The user can deduct this since when it's not NULL two messages will be printed.

> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



