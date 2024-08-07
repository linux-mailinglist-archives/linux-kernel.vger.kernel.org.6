Return-Path: <linux-kernel+bounces-277237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE1949E42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC08B1F21A67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCEA15D5CA;
	Wed,  7 Aug 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGAsWs75"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187B372
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000957; cv=none; b=MOZ+Irp1t3ebLIVtDjBWa4n+EWBBJRIO04BeZtej06Gb0FxTFU/lLsl49WOUN8bNyde8i+Q0Q9vnIunXk8MngWQONgqa9Gvq8kkFosjcp1PnOCcnMlPNsy36psAIh1XDWdxt50mnu8Xfawgrw+gKuIQ5A3HH1PeDg0WfC9p45MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000957; c=relaxed/simple;
	bh=jcTdZvp1M6mEmAuGRwtN/RIKMFgHOMuFKVo9+pHhSk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBdor8fVniil1W22+/yNp45pkv2cF1dUbX2+kPYRw+f4HUNonkoUtTxWaIkO8LEHbMePY3w/kdx5oD7LEDU1ohPGWiQWkRaYeJ3safqsGTNrzDzPkB0XR1Bg5AirRtDx4n8lQIG90RLaPb9PCBpAMReOp0Pl0/8AUL3LdYc7MkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGAsWs75; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723000956; x=1754536956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcTdZvp1M6mEmAuGRwtN/RIKMFgHOMuFKVo9+pHhSk4=;
  b=LGAsWs75q126DmuoQRwTnQCRev0ZmAP6Hq5pWOzF2OfNSs9VxWmLkWv3
   kaJ+CrrhQn/ahQIET3QtFxDuBMsk1gh9QX58iNZnqcUnjvdy8zA26PXWs
   jxdTLMgbdgQwjN/qW61AmFqoyPn4ERXGl8xL/TG6Hs4lYnAdP1yzdOs/e
   6kn1sc0kkaB2+NvAqeef9JXeF2ppzHE7G1r3yCewBF3Soo6G+pyWytbGd
   SByflh4tMj5VUimm0TpMm0GTk0s0yWF3FKV/9YVOggjiTusTZF27Ui4Yp
   agJhSSWV2QEaiFxvOKfTGFoHzkaHV4bCofp4pAJbbNng2YWMxwSUV5Vya
   Q==;
X-CSE-ConnectionGUID: YgoRjRT9TJ+VMrvK4GJyuw==
X-CSE-MsgGUID: RjbTS4z/R3CHbRBLQZ+vfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="24841541"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="24841541"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:22:35 -0700
X-CSE-ConnectionGUID: 24TWeF3PSTys7qyGRq4Ikw==
X-CSE-MsgGUID: uyRAIyovSNay2m6rb2DE+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56577007"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:22:35 -0700
Date: Tue, 6 Aug 2024 20:22:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
	irogers@google.com, peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
	eranian@google.com
Subject: Re: [PATCH 6/9] perf report: Display the branch counter histogram
Message-ID: <ZrLoeSR_U26ASD0T@tassilo>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-7-kan.liang@linux.intel.com>
 <CAM9d7cgQWLdec063U+c1su_O9jchv5HSTQ0S0tQJ_q96hjgjXw@mail.gmail.com>
 <9b7c5c61-ef8c-43a8-bf1c-7ff32b4c8bee@linux.intel.com>
 <CAM9d7cgE=cDyeOyXrRZt53vKD=FRSqQRMz8=f=bGT-gzm2jjkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgE=cDyeOyXrRZt53vKD=FRSqQRMz8=f=bGT-gzm2jjkg@mail.gmail.com>

> I understand your point.  But I think we need to provide an easily
> parse-able format at least for CSV output.

It's easily parseable, e.g. in python:

>>> collections.Counter(re.findall(r'[A-Z][0-9]?', "AAAB"))
Counter({'A': 3, 'B': 1})

> 
> >
> > I don't think there is a plan to increase the saturation of the counter.
> > So 4 bits of width should last for a long time. Other ARCHs don't have
> > such a feature either. I think I can the change the code to force the 4
> > bits of width now. For more that 3 events, the perf tool can convert it
> > to a "+". We may update the perf tool for a more specific histogram
> > later, if the saturation is changed. What do you think?
> 
> Ok, 4 bits width is probably fine.  How many events can a LBR entry
> support?  Maybe that's limited by the number of HW counters but
> theoretically 64 / 4 = 16, right?

The MSR doesn't have that many free bits.  It's limited to 4 events.

-Andi

