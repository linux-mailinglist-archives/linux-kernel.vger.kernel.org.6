Return-Path: <linux-kernel+bounces-310956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D7968342
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4603F1C22231
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0851D1F49;
	Mon,  2 Sep 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iR9OHUvk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795A1D172E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269546; cv=none; b=ksHkcK76SuAq63IlghPYmKBXBjc9BXwOAU2QXovcRD5OQex51AdG1Ve8vpZwVeT50PPvxp05NuB+YRKSo7p2pxLjREXQlYhU9L54rDJD411jxvNvhFFqpHUobXN+/SAk8LrfuV7W0qbntEI3MWNFgr8Pimzfv5IQy9L0jr9H7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269546; c=relaxed/simple;
	bh=vvWZEZ6qZ8OD+HQtruckzZ5u8YapWIkwBoQSy1nJc5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgydRDdH64Wz2jk5V3ZIbsC2zNDxij6121Wfa+iNBnOA9W2d7lQga+ubL7fUp6hUpmXEAdlDVdTO3RIozVU4s2qzysa7pQzEo/ge9CPZgaRAPi+SJaOxgJldaNlv3LzCgzrNamCXTIlqEBqqq5BcLcBKZt47zxXWbecA/Je7pMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iR9OHUvk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725269545; x=1756805545;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vvWZEZ6qZ8OD+HQtruckzZ5u8YapWIkwBoQSy1nJc5k=;
  b=iR9OHUvky0IcRok82KaXPm/ruJwaj7mWdlSLsgCVzU1GiB2yZlQ0dnjE
   GhhaotkAyMNIuEagsAGe7Qnr7NfoQ9gUMLaLx2UMJ6EFFPv3IOcwWO2fA
   j+KA9Ct17bXV8LlcMGBJvs6F+zh7WokpIYSg6dz/nR2KOlslIQLaFcySE
   TT5BqHBtH+loeCdzNjjjmAcQUp3cJmR9k/YFWvA8zoRAkO4wbf/tZkPec
   KfuQRZwofoRZiagKg5H0bRpqQkEgxAfqnZpXh7vgt47X7wuhCqWF+y+Ca
   kHpbTMi35DC0ZvNGwYJsU+HZYAMEWUK7X/2GuPkeL/ouyxVDaRJnE4yZk
   g==;
X-CSE-ConnectionGUID: E0KrAIDdTIy+elkI+XRbwQ==
X-CSE-MsgGUID: ROH/MM5sSDi7DEMLbZQ2kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="26745091"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="26745091"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 02:32:23 -0700
X-CSE-ConnectionGUID: +qAmpj7nSyqX+ewj0owl5Q==
X-CSE-MsgGUID: I1GbNqO4TFO8g5jU9dKTKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="95268241"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO [10.245.244.77]) ([10.245.244.77])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 02:32:20 -0700
Message-ID: <440d041982f7f232f0ce3284bed4db391adb05c1.camel@linux.intel.com>
Subject: Re: [git pull] drm fixes for 6.11-rc6
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel
 <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, lingshan.zhu@amd.com, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>
Date: Mon, 02 Sep 2024 11:32:17 +0200
In-Reply-To: <CAPM=9txF4+rC_CXQTftPctUd0N37t306YKcV3oKPjz+_zQGqag@mail.gmail.com>
References: 
	<CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
	 <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
	 <CAPM=9txF4+rC_CXQTftPctUd0N37t306YKcV3oKPjz+_zQGqag@mail.gmail.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-02 at 08:13 +1000, Dave Airlie wrote:
> On Fri, 30 Aug 2024 at 12:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >=20
> > On Fri, 30 Aug 2024 at 14:08, Dave Airlie <airlied@gmail.com>
> > wrote:
> > >=20
> > > The TTM revert is due to some stuttering graphical apps probably
> > > due
> > > to longer stalls while prefaulting.
> >=20
> > Yeah, trying to pre-fault a PMD worth of pages in one go is just
> > crazy talk.
> >=20
> > Now, if it was PMD-aligned and you faulted in a single PMD, that
> > would
> > be different. But just doing prn_insert_page() in a loop is insane.
> >=20
> > The code doesn't even stop when it hits a page that already
> > existed,
> > and it keeps locking and unlocking the last-level page table over
> > and
> > over again.
> >=20
> > Honestly, that code is questionable even for the *small* value,
> > much
> > less the "a PMD size" case.
> >=20
> > Now, if you have an array of 'struct page *", you can use
> > vm_insert_pages(), and that's reasonably efficient.
> >=20
> > And if you have a *contiguous* are of pfns, you can use
> > remap_pfn_range().
> >=20
> > But that "insert one pfn at a time" that the drm layer does is
> > complete garbage. You're not speeding anything up, you're just
> > digging
> > deeper.


>=20
> I wonder if there is functionality that could be provided in a common
> helper, by the mm layers, or if there would be too many locking
> interactions to make it sane,
>=20
> It seems too fraught with danger for drivers or subsystems to be just
> doing this in the simplest way that isn't actually that smart.

Hmm. I see even the "Don't error on prefaults" check was broken at some
point :/.

There have been numerous ways to try to address this,

The remap_pfn_range was last tried, at least in the context of the i915
driver IIRC by Christoph Hellwig but had to be ripped out since it
requires the mmap_lock in write mode. Here we have it only in read
mode.

Then there's the apply_to_page_range() used by the igfx functionality
of the i915 driver. I don't think we should go that route without
turning it into something like vm_insert_pfns() with proper checking.
This approach populates all entries of a buffer object.

Finally there's the huge fault attempt that had to be ripped out due to
lack of pmd_special and pud_special flags and resulting clashes with
gup_fast.

Perhaps a combination of the two latter if properly implemented would
be the best choice.

/Thomas

>=20
> Dave.


