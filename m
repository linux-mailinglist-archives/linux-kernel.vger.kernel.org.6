Return-Path: <linux-kernel+bounces-445244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94DD9F1333
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DE51884144
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2DA1E32CD;
	Fri, 13 Dec 2024 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY534SAz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598A175AB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109662; cv=none; b=Cn2HoHtTSWWsnYSn4yEOzi5EjkZpknt5kZ4DG0yJDrqA70GcBGHjroxOkTMj7iw92jiWIIqk/OZRUwOLnET3ecWCwvF0rH7tQRpJA9kxb7dCZLy6e9cpgaZKL6nx3gRRvmIxms9RTxE7zN8wrR7S3OCk1o9lnFwt477abA1QWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109662; c=relaxed/simple;
	bh=9h2P6ELdMzx/Gu7OEnPIQA6Pmdclf6xQrgpKHh0542A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4QVt8rRqANzN0hHvYctGn7qDCjWHw48MlWuHYF8c58hOrO8m0iqb8xZFHyd4XhAMKTHipn6Vr6HT/yVPTDvpkj1ELHUskUesISu0JbiNZafdj0eO9StGIo0BbsUr/rdftNnffrjHonyPgNrN2UUutsFXUZNoFOzy3Teqpo0Qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eY534SAz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734109661; x=1765645661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9h2P6ELdMzx/Gu7OEnPIQA6Pmdclf6xQrgpKHh0542A=;
  b=eY534SAzHFf9SQI742LpYx/DcGgJO1bMrtDAetahh9BooqQDr9XqxGWn
   Vk1F/OhpD5GZPQ19v3e4e28+qp9EdxAHE88P2kHru2VwJbqaQlWZf+pvr
   Cg59YtUOutrx+pAwhAfs41VctoOf03Oq6iTYvttsIF6g+xdkc2Ok1Xq4+
   +5ULn6H1fIIK51Lx8MG32B4VtZ5sGvOkuY9bbJFfnmjgYNA6L8buZWqBa
   Ji9QWlGRYeXQAXceQty2TuN6tCEUkeoTDnEEaeUznS90Cu1E3bPurM0bm
   W8JTQle8avn/XU+tUC9Vj1gFXGZ0AKHe2y1kKRm6kmyiFFmJoay4fJnzz
   w==;
X-CSE-ConnectionGUID: yqYY/AI0RWukuixGZflHqg==
X-CSE-MsgGUID: CVBVi7dyS0WId9cD4utIkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="22156299"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="22156299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:07:40 -0800
X-CSE-ConnectionGUID: vt3drGVZS566O67j18l/5A==
X-CSE-MsgGUID: R2CKISlLTKWU8fVnWwDOag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97373648"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:07:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tM98Z-00000007Py8-27f7;
	Fri, 13 Dec 2024 19:07:35 +0200
Date: Fri, 13 Dec 2024 19:07:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Message-ID: <Z1xp1xwLXAvkKgwD@smile.fi.intel.com>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
 <Z1sOTf6UZbruptnl@smile.fi.intel.com>
 <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 13, 2024 at 07:28:45AM +0100, Christophe Leroy wrote:
> Le 12/12/2024 à 17:24, Andy Shevchenko a écrit :
> > On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
> > > Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
> > > > Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> > > > file provides an OF API that's deprecated. There is no agnostic
> > > > alternatives to it and we have to open code the logic which was
> > > > hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> > > > drivers are using their own labeling schemas and resource retrieval
> > > > that only a few may gain of the code deduplication, so whenever
> > > > alternative is appear we can move drivers again to use that one.
> > > > 
> > > > As a side effect this change fixes a potential memory leak on
> > > > an error path, if of_mm_gpiochip_add_data() fails.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > Thanks, what's next?
> 
> Next step is that Michael or Madhavan apply it I guess ?

Folks, do you have any comments? Can you apply this and we move forward towards
removing the legacy API from the kernel?

-- 
With Best Regards,
Andy Shevchenko



