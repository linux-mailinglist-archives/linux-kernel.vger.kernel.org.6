Return-Path: <linux-kernel+bounces-273135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A99464DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DB81F22CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F8770F9;
	Fri,  2 Aug 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7zY74s4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03A8248D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632958; cv=none; b=D6Qyk+txUSHgw3zHA/RcHlQX7z4a6gc8l2ucJEMCeoAkhYxe0elyxOSOf6UZyqC9guqFU64MNvTY5nJn1BBN2VXh8sTPNtcNDvvkTipKxUWZB/mxl5Bw56O+9kcOdTrvveWSio9ijgLu41ppk/wSPvdsKg06wSdm3x0eHjYYJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632958; c=relaxed/simple;
	bh=3LNFBr2PbvgMNdP0wf/cCMkQ3+loqg8eSt50F3+Fxzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBGJW1FpZhLlA9vMusDQjX2SRjv6885c4QJB1f/QKRFgITi5LhjVgmYi95JKbnY/Sv1R8YPVZXaxU01FUE5M9fwOa+nZlxPs2jLqhIXnq7cUhqJVOT2vlF13Y3xm5FPG10ywOnxATUajBabDemfXnvkVcQWy90Pj3aUBOLfwe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7zY74s4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722632957; x=1754168957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LNFBr2PbvgMNdP0wf/cCMkQ3+loqg8eSt50F3+Fxzs=;
  b=K7zY74s4kO5gasbnFrFPavzbMXNtnKPJeDs6/O/0u7FORdV4Fj8vfbiU
   oDUo7hMs+o/0lhH4pVX38+fgHPEgfuEFzqsGvZXG7WuYrpd7KsR5C9yq9
   TsUVdoejWQwf0E1Y2skY+dEKYumNYiZAHe1atQIWjUYrYMylmtm8ksobU
   qnscmGObQJD/5voQeAbA9edYl6oGnIqq0WOspP91K6wk+L694s4KOAAiH
   1l5CxLRfUQe6oFLfekl2zhpPJnrEvr4CwtwUhaGGnmQ67XeChp7J/4yJR
   kBMSPbyeblkbXWjfYgxjgYGYZs7bdJFAOFVI5TDTq9LQv1nEgr699V16Z
   Q==;
X-CSE-ConnectionGUID: g4w4SF1vSqa8Gng33X79yA==
X-CSE-MsgGUID: nyh5IkXGSKOGLcZ5axEa8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24437457"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="24437457"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:09:16 -0700
X-CSE-ConnectionGUID: uU4r8KqiQAq/aMCGpZd2yg==
X-CSE-MsgGUID: IH0GJYsXQBeXU9BeSIx+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55201408"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:09:15 -0700
Date: Fri, 2 Aug 2024 14:09:13 -0700
From: Andi Kleen <ak@linux.intel.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
	peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
	eranian@google.com, Tinghao Zhang <tinghao.zhang@intel.com>
Subject: Re: [PATCH 7/9] perf annotate: Display the branch counter histogram
Message-ID: <Zq1K-YM4JoEQwov1@tassilo>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703200356.852727-8-kan.liang@linux.intel.com>

> Display the branch counter histogram in the annotation view.
> 
> Press 'B' to display the branch counter's abbreviation list as well.
> 
> Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
> 4000 Hz, Event count (approx.):
> f3  /home/sdp/test/tchain_edit [Percent: local period]

Can we output the abbreviation mappings here in the header too? 
Otherwise it will be hard to use.


-Andi


