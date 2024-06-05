Return-Path: <linux-kernel+bounces-203183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8768FD78E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B09281CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692715EFA3;
	Wed,  5 Jun 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCPj/JbC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61119D89D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619619; cv=none; b=pNLkOBAy9nMoYmZiwo890VlKYyafcPX0wYVXj+hEWAwTiUa6OdaVP5gvRGS79XPX1U26/qq6j6ystnTtaMOtbP+jm20BQXEsZwi3DsvC/HkzIvgjeTGdA/J+1FGgfnd4hfC7lW/hw3EnHtWiMeYno/jm0Pr/wcfIRiHqicCbNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619619; c=relaxed/simple;
	bh=0PsK40ZqXsyaPlDEAwJM8R2V+6h0/qS4beYU5xutNP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaEtoM+z8VWwFxPyf4GlVd/KAJDiSqr9R6xcEx4Z/VwePT6Gfeye062pg8Ra7gQqMhl13Jo+s1Sce5F7KhX0ZkZSp/LZ29XXsCauH8ippIkTksT8r7ffZ9s8JO50nMgIWIW/MiOjxSnx2IhjQkqup7YB4wxqWoPSUA/VVErWAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCPj/JbC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717619617; x=1749155617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0PsK40ZqXsyaPlDEAwJM8R2V+6h0/qS4beYU5xutNP0=;
  b=PCPj/JbC2jDkf2ng6GiYfePV41wizo46Iy66HbF+751iGe3Htt74Ycwd
   uajiMMHQWpfoXYRb8z/Ihxu4WdQz3YZdAzL7CZK5gn7wDuvUBC5fOXcNZ
   gmxkoMXGkVLvhs9UmBd2d7SyshAthuRs9xzMMvgLeBfRR81fj0vwdQYbX
   Svle1ttkZ/FJ63j5mXT/JnkN42tXo3SbeL++mtC0zhf7dZQomiCh0HxfY
   Mc465mDtflmr2mtasZb9aTccNKLHqvgDfDYzgdcOnlQ2vAe3cj59C/PMp
   q+UWhjMDFxKoyfEmsY1rQarTHmt/iARbRHvDXDJqtX5cdMudcrMXuw9jF
   w==;
X-CSE-ConnectionGUID: RiUQOqWSS7eihogKI1Kslg==
X-CSE-MsgGUID: Pq7zJFtASlG4t2J5SOZogA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="17190952"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="17190952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:33:36 -0700
X-CSE-ConnectionGUID: +I7plNA1QeqMzTyeqRWALQ==
X-CSE-MsgGUID: xy4A72KnSDOnkZFGZ6tOYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42677407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:33:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sExK7-0000000Dxap-30Op;
	Wed, 05 Jun 2024 23:33:31 +0300
Date: Wed, 5 Jun 2024 23:33:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Baoquan He <bhe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] resource: add a simple test for walk_iomem_res_desc()
Message-ID: <ZmDLm1xN68f_6Odg@smile.fi.intel.com>
References: <20240605195324.3213954-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605195324.3213954-1-olvaffe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 05, 2024 at 12:53:10PM -0700, Chia-I Wu wrote:
> This mainly tests that find_next_iomem_res() does not miss resources.

...

> v2: update subject, use DEFINE_RES_NAMED and hardcoded offsets
> v3: really hardcode offsets

This doesn't explain why you multiplied previous values.

...

> +static int resource_walk_count(struct resource *res, void *data)
> +{
> +	int *count = data;

+ Blank line.

> +	(*count)++;
> +	return 0;
> +}

...

> +static void resource_test_walk_iomem_res_desc(struct kunit *test)
> +{
> +	struct resource root = {
> +		.name = "Resource Walk Test",
> +	};
> +	struct resource res[8];
> +	int count;
> +
> +	KUNIT_ASSERT_EQ(test, 0,
> +			allocate_resource(&iomem_resource, &root, 0x100000,
> +				0, ~0, 0x100000, NULL, NULL));

Shouldn't this use RESOURCE_SIZE_MAX?

Please, split the assertion and allocate_resource() call, so it becomes
readable what exactly you checked against.

> +	/* build the resource tree */
> +	res[0] = DEFINE_RES_NAMED(root.start + 0x0000, 0x1000, "SYSRAM 1",
> +			IORESOURCE_SYSTEM_RAM);
> +	res[1] = DEFINE_RES_NAMED(root.start + 0x1000, 0x1000, "OTHER", 0);
> +
> +	res[2] = DEFINE_RES_NAMED(root.start + 0x3000, 0x1000, "NESTED", 0);
> +	res[3] = DEFINE_RES_NAMED(root.start + 0x3800, 0x0400, "SYSRAM 2",
> +			IORESOURCE_SYSTEM_RAM);
> +
> +	res[4] = DEFINE_RES_NAMED(root.start + 0x4000, 0x1000, "SYSRAM 3",
> +			IORESOURCE_SYSTEM_RAM);
> +
> +	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[0]));
> +	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[1]));
> +	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[2]));
> +	KUNIT_EXPECT_EQ(test, 0, request_resource(&res[2], &res[3]));
> +	KUNIT_EXPECT_EQ(test, 0, request_resource(&root, &res[4]));
> +
> +	/* walk the entire region */
> +	count = 0;
> +	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +			root.start, root.end, &count, resource_walk_count);
> +	KUNIT_EXPECT_EQ(test, count, 3);
> +
> +	/* walk the region requested by res[1] */
> +	count = 0;
> +	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +			res[1].start, res[1].end, &count, resource_walk_count);
> +	KUNIT_EXPECT_EQ(test, count, 0);
> +
> +	/* walk the region requested by res[2] */
> +	count = 0;
> +	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +			res[2].start, res[2].end, &count, resource_walk_count);
> +	KUNIT_EXPECT_EQ(test, count, 1);
> +
> +	/* walk the region requested by res[4] */
> +	count = 0;
> +	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_SYSTEM_RAM,
> +			res[4].start, res[4].end, &count, resource_walk_count);
> +	KUNIT_EXPECT_EQ(test, count, 1);
> +
> +	release_resource(&root);
> +}

Other than the above, LGTM. Hopefully next version will be ready to apply.

-- 
With Best Regards,
Andy Shevchenko



