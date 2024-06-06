Return-Path: <linux-kernel+bounces-204076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F748FE3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CF01F22D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134481862A1;
	Thu,  6 Jun 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxC8BzMQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D564A185091
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668088; cv=none; b=fSzoc6/SgvZxUQCdLQKREoa6DQ5uqIPDMi/uhhP3zWQ7yGc1ZI/xL4XwjXOpJGUJlEjvqHghAoJvNTW+OfozoMaujQFG6tqUVp5Jtith+UVVga6pwaeQNxkcK1Ykb4D4r3dfOfdEPkvyfvE1KaHvGoYfpR+0Ew+1wnwc+4Z/dBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668088; c=relaxed/simple;
	bh=OcdwBe41VOHoxba7xSg4ULAv55Y7TqZs85XGx4ve3I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+oF64p76xejNLd58+6tngNPHzrBmN0j1Td/CyXDZ4PGc5iLUOTugHIrschARq4YZDe/jRHkYisA7a7JzROG1DPlZ7mYtm0P9d4NxGTJ4MoahN77XkvoT7QwlsYj26B0ddQj1HjJT5KlwRBRmFFON1YyMWq0swpSHXZedKq+lAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxC8BzMQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717668087; x=1749204087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OcdwBe41VOHoxba7xSg4ULAv55Y7TqZs85XGx4ve3I0=;
  b=kxC8BzMQws+49iqRLOBLJoVDZywjyeBWgKSb4TG47UTxMG8xpTSBbwbi
   67w6/SqKs9v5/v1OY5baOXYmnid8ywNTSIW0RVkVcAGhpoElTfbHdWedd
   0DS7Xn/Zy1HkbijZF5CLCcGIzAWeRSLjtZqVlMqILheJk3jfGhr9dKC2p
   Tqvm1K0gR39t1r9UpB9KWPua91yBbSwERFS9PCdnjx9X0EN/bZYdJVv+N
   7x922Y9YtPbgFmG/GmR2bpNDTYpo6193TlXjVlExGkkCA7XVCaq7eP2lB
   sEQjZ2PaknTXKSLfo2M9rkuEpKV7zNpNq3MhsWg1GwKmsgjmlkmql1bZU
   g==;
X-CSE-ConnectionGUID: Rz29k9epR1uicmmHVEuGsw==
X-CSE-MsgGUID: J5+S0Zt9Qbmi+a6Yz5WATQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14206695"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14206695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:01:26 -0700
X-CSE-ConnectionGUID: k8WdnHHqQb+Be+yOwYFqOQ==
X-CSE-MsgGUID: AdryZSLhS8GoPM7arIdC2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="38575383"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:01:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sF9vs-0000000E837-0D2i;
	Thu, 06 Jun 2024 13:01:20 +0300
Date: Thu, 6 Jun 2024 13:01:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] resource: add a simple test for walk_iomem_res_desc()
Message-ID: <ZmGI715vFZ3pgzjN@smile.fi.intel.com>
References: <20240606004002.3280960-1-olvaffe@gmail.com>
 <CAPaKu7Q8Ba4_GEZdBruO0if374BhMYafDbGc2dptPL4vdKR+1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPaKu7Q8Ba4_GEZdBruO0if374BhMYafDbGc2dptPL4vdKR+1Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 05:46:16PM -0700, Chia-I Wu wrote:
> On Wed, Jun 5, 2024 at 5:40 PM Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > This mainly tests that find_next_iomem_res() does not miss resources.

...

> > +       walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> > +                       res[2].end + 1, res[3].end, &count,
> This should be from "res[3].end + 1" to "res[2].end".  Not sure if I
> should resend or if you can make the fix when applying.

Please, slow down. You sent three (!) versions over a day, this is against
the recommendations. And it seems you want to learn a hard way the clear thing:
Hurrying just increases a chance of a mistake.

-- 
With Best Regards,
Andy Shevchenko



