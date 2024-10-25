Return-Path: <linux-kernel+bounces-381887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7349B05E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E1B281079
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC621FB8BF;
	Fri, 25 Oct 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bx1iNKwb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7E18E76C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866742; cv=none; b=VQ+iKASchKEmIVgItrXcrDtN8FrAK5d1zVVK9Q3BkwD0rHaKMvXQF8ei1IQrlvRZi4b14DesYSTmDw5mcb2ff09pPRjmRKzrVWYamnbkZoXrwJrN0ULXMjV0RtalgcOi6LmoDNaNSuUpt/I3bP3uWLaARjLwKBtBFF2oYPCEPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866742; c=relaxed/simple;
	bh=NMnuD8+TcvuqRl0IQNjXaABqUFwLI07jvfxxrO9Tq6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm65glZTqwF2DiSdMz1lqg71gRu73ra2tvHVHBJWl/d+O31CxfmxJe0JqhEYYaE8vrb0i4F1t/3sCJdF8Gt61QFZd2Ho4EQwMLxZruT7GrdJBX/cO5iZLKxi/nMBJrcr5RjHMfYAvSNzg/r8DajlwHUg6Mj+ytmBKvHsV2BXuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bx1iNKwb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729866741; x=1761402741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NMnuD8+TcvuqRl0IQNjXaABqUFwLI07jvfxxrO9Tq6Q=;
  b=Bx1iNKwbyCRWKWgiSBkbnN3OzOThoJQwysGZlctPzmrIpVl/7Ox4h7hy
   VZhqq9/lCpTfbXVIjXfKsLtW8AnQVXHhker14tO2qx60QA4bcDc4gNTDl
   NMqhI4nBoVeqB8iQ+07PWePeghtlo/+AE65Y5QqDT6ShccL9FeWLv3ex1
   2XWQ+PGqXISk0W9YK4Jpg2u3hub+00wjzXpp2PVG2aES0zUcBrmWkEt2/
   Hcs/armGtdEXv4hAvp/66zzVutf+d5VZlOTl/orjU4FdJBkP3iX5zYl9m
   Vvm8cE4bJP79SimIYhSJ1FFa6aZmePyfC2OuhN6YenUN7kZXAh/iJOzlE
   w==;
X-CSE-ConnectionGUID: Me3PwGuiSJqXmasSIF7/+g==
X-CSE-MsgGUID: 7JMhFy1IS26eRz92IuKqLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40930995"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="40930995"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:32:20 -0700
X-CSE-ConnectionGUID: icyJaGXHTjCdK8z8GlPH1A==
X-CSE-MsgGUID: tonr6n63T+GEKQlqKlk8uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81087623"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:32:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4LMM-00000006wS7-01um;
	Fri, 25 Oct 2024 17:32:14 +0300
Date: Fri, 25 Oct 2024 17:32:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Zeng Heng <zengheng4@huawei.com>, jia-cheng.hu@intel.com,
	gregkh@linuxfoundation.org, quic_jjohnson@quicinc.com,
	jinqian@android.com, alan@linux.intel.com,
	linux-kernel@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] goldfish: Fix unused const variable
 'goldfish_pipe_acpi_match'
Message-ID: <Zxur7RC-bBYX79WJ@smile.fi.intel.com>
References: <20241025074129.1920707-1-zengheng4@huawei.com>
 <ttlc5ppgljd3plbk6kw4ndi47pqafivtxk2sosdhlw3zeda273@dn74s3eluxqp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ttlc5ppgljd3plbk6kw4ndi47pqafivtxk2sosdhlw3zeda273@dn74s3eluxqp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 04:27:07PM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 25, 2024 at 03:41:29PM +0800, Zeng Heng wrote:
> > Fix the following compilation warning:
> > 
> > drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
> > ‘goldfish_pipe_acpi_match’ defined but not used
> > [-Wunused-const-variable=]
> >   925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
> > 
> > Only define the const variable when the CONFIG_ACPI is enabled.

...

> Looking at changes like
> https://lore.kernel.org/all/20241024130424.3818291-11-andriy.shevchenko@linux.intel.com/
> I suggest to drop the use of ACPI_PTR() instead.

Right, please drop ACPI_PTR() and if needed, replace acpi.h with proper
mod_devicetable.h. You may find tons of examples in IIO:
`git log --grep ACPI_PTR -- drivers/iio`.

P.S. Thanks for Cc'ing me!

-- 
With Best Regards,
Andy Shevchenko



