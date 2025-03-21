Return-Path: <linux-kernel+bounces-571317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4347A6BBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A0E19C4010
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4922ACFB;
	Fri, 21 Mar 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo7TjSDi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32711227EB6;
	Fri, 21 Mar 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563178; cv=none; b=Oxk0RANZo9obU6ChUGucsL2cyFvsnB0CCNanCKSQoI1paUD+kUnCgfBS/VasnQIo7wc5UgZy7xfVKi858XyV7EQCPAwe9c1qLrcL9A8JW6VGHuCWR8VEMTkyPdWsi1aD1fJdKrmXztwhRUxf3GUD4NRX9IHZvxBnaOt3NNm0otE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563178; c=relaxed/simple;
	bh=v661GMwK5O8Mepjy+6Ct83aAjIURnHWOu+79QKsyoqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl9vwuHeLj4GUzbsdSyDQNdq4VsIlLbiaWiTDQRDZ88C3g572SCoGk82WRXnBI1vRy2yap0ptq7q9BdGe6ixEvgwx54ijFpYlcctpyEFojV5LiONh8E79xqgt71ahFDmc9/JxfvaFlJ40KyOV69gFPKZ7OXo/P2Y1QDrRh7xV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo7TjSDi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742563177; x=1774099177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v661GMwK5O8Mepjy+6Ct83aAjIURnHWOu+79QKsyoqc=;
  b=Fo7TjSDiwCc7KZqHw7H2yo9m9UA+CFfAPfKFCGEyGrq3Ridz+RWNgSm0
   SS7budJ2pe9Ab6QsZ3aiOmLwAeRKufi6Xi1Za4bykYUyG3Nw3vWw8sK8X
   v1Q2rJWIZZpbJ00mI52tK5Lsv0/JdrJov4QHLs6+nHoEmrDOQJuyRKgM9
   5aS/B+G/hk8U3EmAr3Ztm83zmktXM7+K0fV102tjgq/RPJZQiv3Ok3F+V
   ed6DfsmfuDs+u3FM3CGJi5x0+m3kEjjPPSA/xzme+GFlYigYSyP/+m4n6
   mKyfC8CW7YIxSve+gT2DjS+Bo14y2YF15ZxFp91xefau2j0TYYvEJOGW1
   A==;
X-CSE-ConnectionGUID: qK+NbRKfS/K2iR+gdAYj5A==
X-CSE-MsgGUID: NgwQ1Dk0Q/qudKP6eOTrOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54044111"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54044111"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:19:36 -0700
X-CSE-ConnectionGUID: NrLnpaMsQ0eUvnA/l0AG5w==
X-CSE-MsgGUID: dM88Kf/gQQSVwGFkk5ju7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123380026"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 06:19:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvcHN-00000004WNO-42NF;
	Fri, 21 Mar 2025 15:19:17 +0200
Date: Fri, 21 Mar 2025 15:19:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com, leon@kernel.org,
	lukas@wunner.de, bhelgaas@google.com, wagi@kernel.org,
	djeffery@redhat.com, stuart.w.hayes@gmail.com, jgowans@amazon.com,
	jgg@nvidia.com
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
Message-ID: <Z91nVYgDeK8RhrSj@smile.fi.intel.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com>
 <Z9wan08CpbvddHhc@smile.fi.intel.com>
 <CA+CK2bDWJcrWpkk0asKUb46GYT-r9JdBMU-OUx3E4qjr6rVpGA@mail.gmail.com>
 <Z9xVbqyomZunipQL@smile.fi.intel.com>
 <CA+CK2bBQwC16W2Qmw5vXdMi7EaadAGXfUs6ym1P1UZ90PzbZvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBQwC16W2Qmw5vXdMi7EaadAGXfUs6ym1P1UZ90PzbZvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 02:30:25PM -0400, Pasha Tatashin wrote:
> On Thu, Mar 20, 2025 at 1:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 20, 2025 at 12:35:20PM -0400, Pasha Tatashin wrote:
> > > On Thu, Mar 20, 2025 at 9:40 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Mar 20, 2025 at 02:40:09AM +0000, Pasha Tatashin wrote:

...

> > > > > +EXPORT_SYMBOL_GPL(liveupdate_state_normal);
> > > >
> > > > No namespace?
> > >
> > > Namespace is 'liveupdate_', all public interfaces have this prefix,
> > > private functions are prefixed with luo_ where it makes sense.
> >
> > No, I'm talking about export namespace. Why does the entire kernel need these APIs?
> 
> These functions are intended for use by drivers and other subsystems
> participating in the live update.

Sure. Why can't they import API namespace when needed?
Btw, is this feature switchable? Then why would the rest of the kernel
need to see these APIs or load them?

> They allow these components to
> determine, during boot, whether to restore their state from the
> serialized state, or, during runtime, whether a live update is in the
> prepared state, causing different behavior compared to normal mode
> (e.g., prohibiting DMA mappings modifications, binding/unbinding,
> etc.).

-- 
With Best Regards,
Andy Shevchenko



