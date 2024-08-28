Return-Path: <linux-kernel+bounces-305087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669E962950
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21451F2379E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E91187FE5;
	Wed, 28 Aug 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbfi/M3d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4F176AAA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853226; cv=none; b=GDrG1C+nI97vPck8k1Uq+wMC/dfGqHzoZ3YTGLiOHmXI7XrrL+5NABndKal/OHzSWv3VHgB/a6XTnCsDoBI0JbJmQ1nne0+ldHehrcfRb0Pm0LQZsBZBRj5D1PkZJtJycnBRmFAWVGE4ru6vZeasojVEyWV2pLXJ3uyHAdQqG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853226; c=relaxed/simple;
	bh=PvyBmKRoeFEO05ifJLAInxyI3UlsGzTlrxxlMnActgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9Dn9/97H6OfZBhYWQLjUj1gxz8+RYTdTlxfQED/HRXbM1a7Cy5T3s9ukCO+FXO0kVkIQLvnE2D43ubcQcfpl0asLVP/rxJaSX00kbMVGVGzkeV/lch9V3Qa7c0So+9Ub9JTCMHrGlp6rqd0H+l21TDAio4eQE96Ri40CRZdkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbfi/M3d; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724853224; x=1756389224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PvyBmKRoeFEO05ifJLAInxyI3UlsGzTlrxxlMnActgM=;
  b=gbfi/M3d6/cjV2vjYRmlMoyJWNZOqKHDyLGLXAh2a5ncM+uuBAr8GMlR
   N2fbZaXmmZtlXfxRus1CQCDiV2PO6cG8KTiZpd+9ZiedY4Pqmv15MLCjj
   gnIJdf06iXr8Y0WcHYbOLSix7ZaTl2ltloosv4LX2A7TjFvu9Yo6R4wKZ
   L6FY6W0gFX+c2ME3s5UoJk46WI6QvZ3k7XoISMf9g2NAXVgb9JHt1QIGo
   c3NguM7I3/ITS1Q9hXp75lDM/Uy0AhDxol2Bs8I+OgFSa7Tlj0bsQDE2b
   S0vI248edNtzAzXvWVtbVCgyNpaaKyUc/c1cJm1XFdCLeRsaBs4GYDg0y
   g==;
X-CSE-ConnectionGUID: XvyYmU6nQ2COwbo0Aoq5fQ==
X-CSE-MsgGUID: T17cdt+8R16W4i9sxRZjmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34042918"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34042918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:53:43 -0700
X-CSE-ConnectionGUID: gPRVgNnWS4+On0U2WXwkXQ==
X-CSE-MsgGUID: GCGgfDGdTbuYbcCwScdC1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63740897"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:53:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjJ7D-00000002fBX-2APZ;
	Wed, 28 Aug 2024 16:53:39 +0300
Date: Wed, 28 Aug 2024 16:53:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] regulator: irq_helpers: Add missing "Return"
 kerneldoc section
Message-ID: <Zs8r4_oYUNLd2xCZ@smile.fi.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-9-wenst@chromium.org>
 <Zs3mP547BolU4MRt@smile.fi.intel.com>
 <CAGXv+5FSt=8yRBa0ZqVQs_27wTGDedJiLdhMfGzzSySQYXbctw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5FSt=8yRBa0ZqVQs_27wTGDedJiLdhMfGzzSySQYXbctw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 03:50:55PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 27, 2024 at 10:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 27, 2024 at 05:55:48PM +0800, Chen-Yu Tsai wrote:

...

> > > + * Return: 0
> >
> > "0."
> 
> Ack.
> 
> > > + *
> >
> > I don't think we need this blank line.
> 
> This actually changes the output. Without the blank line, they are treated
> as the same paragraph. With the blank line, the next line is treated as
> a separate paragraph, and put in the "Description" section.

I see, then please make sure that description either annotated with
"Description:" or comes _before_ "Return:". that's why it confused me and I
though it's related to the "Return:" section.

> Strictly speaking, the only return value is the 0 integer. The other
> "return" values are output parameters that have been modified by the
> function. I believe those should not be in the "Return" section.
> 
> > > + * Actual regulator error and notification are passed back through @rid.

-- 
With Best Regards,
Andy Shevchenko



