Return-Path: <linux-kernel+bounces-180735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0AA8C726E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157D4B22053
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41613849A;
	Thu, 16 May 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9KiKs33"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36F12DDAF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846689; cv=none; b=HGtri/8Rs1UQc87RMUFOWj95XihbMgaNK6wuhpOJWDhlBNDpSP6/j1C5ALCuHaJWu58329Ov30jGixkeihymVLsuU8Xbegl91Nb8eWdfrEdKznkpCl/tOYQlj0zXeTCzu7ISHIOEOQR8H8igjLPFW8MyqjwFPLhhipsUEc0YUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846689; c=relaxed/simple;
	bh=2tXHTi0dLNSZyf6qV6/xdIj/MMJqYMPKAqzz1CzpkkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tN74csV2A89pUDas8B7sR5G3cPHC5QctpaT6U0GPb+oNw8y+wwwjc9EVO2bbOc92BJ8aiZ2UG2ok6nAjXVtqJrqx6dvDgtHZCtGakbT/C98nygISZFhysXcNenhIKUIqIc6Gg/d3wLS0xfbvCwwps7aMNZNzF+GHSxcG8uvOxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9KiKs33; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715846687; x=1747382687;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2tXHTi0dLNSZyf6qV6/xdIj/MMJqYMPKAqzz1CzpkkQ=;
  b=M9KiKs33A6DMJ4IijbFOH/okBYWZVW6X2LXoxMyd+fwZGJWC1SgPC/n+
   lT/YFJD6ArgAphjTk6OdyGP+KR2lhn9UelVfVifyS4AM3DqBhfPDY50kR
   rhGWFQf0GzBES7ZQbyZohUjS2JBZUa2bOHRGLyf8MLAiUXpR7KC1Tk2Zk
   wijgjqF6kzBF2OdMADBjwBExJdxLH16ns/ZdHpMSMjcCjprmxeC+ZCQqF
   KiXjcXcdn3I2J7P9I0hJ4C9XfaMDhDzmIR+cCEvQy/77xGxf4IaZYpFAM
   gaQxoF6126GeWNIaoax/PekaaxpsUxGCiqwQ8qj7Q5CBUC/rBH+l6yz3B
   w==;
X-CSE-ConnectionGUID: MoKln77PTP+BZ3tsUNPHbQ==
X-CSE-MsgGUID: VP8O0IxwSk2Ea5JShMPu/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22613470"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="22613470"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:04:47 -0700
X-CSE-ConnectionGUID: 9QUzi2JtTcG3QGDSVfTjzQ==
X-CSE-MsgGUID: MHU8v8iiTRmi9b+L7Xo8ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="31277273"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.208])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:04:44 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dave Airlie
 <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel
 <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.10-rc1
In-Reply-To: <CAHk-=whuCX-NAGOLzwn5sObPDJX-pdqamZ7YTpHFHODAMv4P+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
 <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
 <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com>
 <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
 <CAHk-=whuCX-NAGOLzwn5sObPDJX-pdqamZ7YTpHFHODAMv4P+A@mail.gmail.com>
Date: Thu, 16 May 2024 11:04:40 +0300
Message-ID: <87v83eb2sn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 15 May 2024, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 15 May 2024 at 16:17, Dave Airlie <airlied@gmail.com> wrote:
>> AMDGPU, I915 and XE all have !COMPILE_TEST on their variants
>
> Hmm.  It turns out that I didn't notice the AMDGPU one because my
> Threadripper - that has AMDGPU enabled - I have actually turned off
> EXPERT on, so it's hidden by that for me.
>
> But yes, both of those should be "depends on !WERROR" too.

Fair enough. Honestly it just didn't occur to me.

The main goal here was to ensure the drm subsystem does not have any
build warnings, but without halting CI on any non-drm warnings that
might occasionally creep in and that we can't fix as quickly.

If there was a way to somehow limit WERROR by subdirectories, without
config options, I'd love to ditch the config.

> Or maybe they should just go away entirely, and be subsumed by the
> DRM_WERROR thing.

For i915, this was the idea anyway, we just haven't gotten around to it
yet.


BR,
Jani.


-- 
Jani Nikula, Intel

