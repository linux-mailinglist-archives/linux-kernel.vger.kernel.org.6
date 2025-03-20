Return-Path: <linux-kernel+bounces-570123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036BA6AC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495DD487340
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42822687A;
	Thu, 20 Mar 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoPUFr1D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B361E3772;
	Thu, 20 Mar 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493059; cv=none; b=PNaZ9+tspejeC47TRl7ulMXu59x2pJm9v1Y2mEivaZ0kJnNVPD8GgInbFim8rVib2MISYcz8coNhNUhsjFzk71eaLUqLhJiGOBrf24fdtWMl60tpWNINiGAYixQThdoTpMgJmxoQU/GLKNJ4OarsCGaDZTjGK3vpIflQUHHKNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493059; c=relaxed/simple;
	bh=cea3vmsVkjuO2XwGRUt+ahnW8RAvoY9Qk5TkREX0e2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3iQDTFCvjbCpX+H3nf+31b+W2W9k9eH2OhZeKImoAu30tte2HdT8sunL2fsWSneUC1gyraEE5yO0JBqLUNKMNpSuiEoBpLdkz3Bbr9wyZJ5pGCW98tz8ZQNui54KysZqrt/VTep1Psx1YTfsNTOqYG298OItU6IjgK3oWPQU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoPUFr1D; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742493058; x=1774029058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cea3vmsVkjuO2XwGRUt+ahnW8RAvoY9Qk5TkREX0e2E=;
  b=JoPUFr1DgkZ7Q7UBBigJW6RodXDI3JdUqENNYD/Vdrk1e8xIiIMyafaX
   u4n75Z9QhsRIAeNDMW+5eo87SjwHJcR+qE88peiX8revx9z0BtqjOzSdk
   7/v3XQjyvNIZfwyCFXpd+xDxcoSLj7E/qy/eoz+eNOjZUKOUdGlPLBPFj
   2zeEWsO9+26B1w/29wikTfTvMKln4HDqU48IQncYCVs9knNzzXKLpn8sa
   Yg159xEElcbXNghxgt5tg1i65awPP9BZVJ4yLyIqhYfbJ0ps5vozBZedH
   rDdBVYqtXhRTfqWH/0+NZaTjz1QrO4qq6yC+ZOrm+WgjExKamje89OwHQ
   w==;
X-CSE-ConnectionGUID: p9mq7mPbSNGkB8qaVAwHQw==
X-CSE-MsgGUID: IJ0kh1CIQ6mN1Inz/VfcdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66204429"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66204429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:50:57 -0700
X-CSE-ConnectionGUID: JydCvEvfSJujt0UDk44Flw==
X-CSE-MsgGUID: TpYanpyeR/CHZ/RImw0Hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="154163594"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:50:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvK2Q-00000004IWz-3yfN;
	Thu, 20 Mar 2025 19:50:38 +0200
Date: Thu, 20 Mar 2025 19:50:38 +0200
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
Message-ID: <Z9xVbqyomZunipQL@smile.fi.intel.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com>
 <Z9wan08CpbvddHhc@smile.fi.intel.com>
 <CA+CK2bDWJcrWpkk0asKUb46GYT-r9JdBMU-OUx3E4qjr6rVpGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDWJcrWpkk0asKUb46GYT-r9JdBMU-OUx3E4qjr6rVpGA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 12:35:20PM -0400, Pasha Tatashin wrote:
> On Thu, Mar 20, 2025 at 9:40 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 20, 2025 at 02:40:09AM +0000, Pasha Tatashin wrote:

...

> > > +#ifndef _LINUX_LIVEUPDATE_H
> > > +#define _LINUX_LIVEUPDATE_H
> >
> > > +#include <linux/compiler.h>
> > > +#include <linux/notifier.h>
> >
> > This is semi-random list of inclusions. Try to follow IWYU principle.
> > See below.
> 
> I will remove <linux/compiler.h>

But you need to add something more...

...

> > > +bool liveupdate_state_updated(void);
> >
> > Where bool is defined?
> 
> in kernel/liveupdate.c

Nope, I meant where the type is defined. It is IIRC in types.h which needs to
be included.

...

> > > +     if (kstrtol(buf, 0, &val) < 0)
> > > +             return -EINVAL;
> >
> > Shadower error code.
> 
> In this case it is appropriate, we do not case why kstrtol() could not
> be converted into an appropriate integer, all we care is that the
> input was invalid, and that what we return back to user.

The kstrtox() may give different error codes. User may want to know more about
what's wrong with the input. Shadowed error codes are discouraged and should be
explained.

> > > +     if (val != 1 && val != 0)
> > > +             return -EINVAL;
> >
> > What's wrong with using kstrtobool() from the beginning?
> 
> It makes the input less defined, here we only allow '1' or '0',
> kstrtobool() allows almost anything.

But kstrtobool() is the interface for boolean input. You may document only
0 and 1 and don't tell people to use anything else. ABI documentation should
be clear, that's it.

...

> > > +EXPORT_SYMBOL_GPL(liveupdate_state_normal);
> >
> > No namespace?
> 
> Namespace is 'liveupdate_', all public interfaces have this prefix,
> private functions are prefixed with luo_ where it makes sense.

No, I'm talking about export namespace. Why does the entire kernel need these APIs?

-- 
With Best Regards,
Andy Shevchenko



