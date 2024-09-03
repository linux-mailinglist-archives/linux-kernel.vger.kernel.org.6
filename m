Return-Path: <linux-kernel+bounces-312615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F39698DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816A6284686
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F511B9838;
	Tue,  3 Sep 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sr1Fhf1t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D819F43E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355587; cv=none; b=fqqNvXJUjvFyclcj+OFjQB9R2tqGUz3LYP9DtnbBvia9toj2ROcV2PXIhVHy40RnjWOtbLghpeGidkBt4DfKCzERYwRA4hJlEyN6Uyu8LNPErr84dd3780gy6z+MRfufgGEsOLwEc1a6wGxxT1Vq0QtG/gBgvCOySqM1lBcCEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355587; c=relaxed/simple;
	bh=PfEXXIU9sRjka86TJyF3Cc9GISKq8sSKC1fdWUaacbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZCMFfRpJybnC8coA+iX5m3anvaD6DqMUd9nBMRkVrfX0049itz8PFF+X12p1kNadrIm+CzXHvPs7XVZ0M0IzTY3P8d/U3VN7Id3hRanlJDPHPW/DJ5L3CC4u2Xc5IjtW0zwsiykHMqCcKrer9A+32rH8M024c1mR0sfxo1LE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sr1Fhf1t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725355586; x=1756891586;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PfEXXIU9sRjka86TJyF3Cc9GISKq8sSKC1fdWUaacbY=;
  b=Sr1Fhf1t/eRIJxdswzO48GwnftbDKiiFgR6BjkRlWlFSp8eN82QA1pik
   I7euUuEWCmDAclZskNLiIl4iXO66QkhnD/BFTqmCOTJAx7dG2dqnlyp0b
   lRH3QCby111iUSwRnCyD+oXXGlXhrkuQ+v6E66LaVdQRKR10FYiP90WfW
   /t4IH+bNtgicE5X+mbno5FbxunzcKKZLW4ggFroriy4MDdQLeDHk4nen3
   X84HMyK1gyq7y0u+vB+Mj9IrxpJIQEa1yMx1Cfo6tIiYEKSJ4yNDgQbBa
   kFcPKojzXRu6K9c9GQyPbbGb2qkCjTytm/pHdBslsunACX29VrAzKJtXM
   w==;
X-CSE-ConnectionGUID: cMak4iJvQiilfHx2yEX4yQ==
X-CSE-MsgGUID: uNgwPI5rQLW8z+6zf3/b5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="41411779"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="41411779"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 02:26:25 -0700
X-CSE-ConnectionGUID: Az/ee2smTjCulo37yWasMw==
X-CSE-MsgGUID: LZcDm11OT4emPXWWjCo5BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="65348229"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO [10.245.244.199]) ([10.245.244.199])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 02:26:22 -0700
Message-ID: <80ed1e928de230f54098d2a4b7f14b5d3556a687.camel@linux.intel.com>
Subject: Re: [git pull] drm fixes for 6.11-rc6
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Dave
	Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel
 <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, lingshan.zhu@amd.com, Matthew Brost
 <matthew.brost@intel.com>
Date: Tue, 03 Sep 2024 11:26:20 +0200
In-Reply-To: <5c493bd5-e657-4241-81d7-19ccd380b379@amd.com>
References: 
	<CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
	 <CAHk-=wijFJM9MHvwGSS4ADs8ncRagrXYi2E9SvhK8coMH32D7A@mail.gmail.com>
	 <CAPM=9txF4+rC_CXQTftPctUd0N37t306YKcV3oKPjz+_zQGqag@mail.gmail.com>
	 <440d041982f7f232f0ce3284bed4db391adb05c1.camel@linux.intel.com>
	 <5c493bd5-e657-4241-81d7-19ccd380b379@amd.com>
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

On Mon, 2024-09-02 at 12:33 +0200, Christian K=C3=B6nig wrote:
> Am 02.09.24 um 11:32 schrieb Thomas Hellstr=C3=B6m:
> > On Mon, 2024-09-02 at 08:13 +1000, Dave Airlie wrote:
> > > On Fri, 30 Aug 2024 at 12:32, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > > On Fri, 30 Aug 2024 at 14:08, Dave Airlie <airlied@gmail.com>
> > > > wrote:
> > > > > The TTM revert is due to some stuttering graphical apps
> > > > > probably
> > > > > due
> > > > > to longer stalls while prefaulting.
> > > > Yeah, trying to pre-fault a PMD worth of pages in one go is
> > > > just
> > > > crazy talk.
> > > >=20
> > > > Now, if it was PMD-aligned and you faulted in a single PMD,
> > > > that
> > > > would
> > > > be different. But just doing prn_insert_page() in a loop is
> > > > insane.
> > > >=20
> > > > The code doesn't even stop when it hits a page that already
> > > > existed,
> > > > and it keeps locking and unlocking the last-level page table
> > > > over
> > > > and
> > > > over again.
> > > >=20
> > > > Honestly, that code is questionable even for the *small* value,
> > > > much
> > > > less the "a PMD size" case.
> > > >=20
> > > > Now, if you have an array of 'struct page *", you can use
> > > > vm_insert_pages(), and that's reasonably efficient.
> > > >=20
> > > > And if you have a *contiguous* are of pfns, you can use
> > > > remap_pfn_range().
> > > >=20
> > > > But that "insert one pfn at a time" that the drm layer does is
> > > > complete garbage. You're not speeding anything up, you're just
> > > > digging
> > > > deeper.
> >=20
> > > I wonder if there is functionality that could be provided in a
> > > common
> > > helper, by the mm layers, or if there would be too many locking
> > > interactions to make it sane,
> > >=20
> > > It seems too fraught with danger for drivers or subsystems to be
> > > just
> > > doing this in the simplest way that isn't actually that smart.
> > Hmm. I see even the "Don't error on prefaults" check was broken at
> > some
> > point :/.
> >=20
> > There have been numerous ways to try to address this,
> >=20
> > The remap_pfn_range was last tried, at least in the context of the
> > i915
> > driver IIRC by Christoph Hellwig but had to be ripped out since it
> > requires the mmap_lock in write mode. Here we have it only in read
> > mode.
> >=20
> > Then there's the apply_to_page_range() used by the igfx
> > functionality
> > of the i915 driver. I don't think we should go that route without
> > turning it into something like vm_insert_pfns() with proper
> > checking.
> > This approach populates all entries of a buffer object.
> >=20
> > Finally there's the huge fault attempt that had to be ripped out
> > due to
> > lack of pmd_special and pud_special flags and resulting clashes
> > with
> > gup_fast.
> >=20
> > Perhaps a combination of the two latter if properly implemented
> > would
> > be the best choice.
>=20
> I'm not deep enough into the memory management background to judge
> which=20
> approach is the best, just one more data point to provide:
>=20
> The pre-faulting was increased because of virtualization. When
> KVM/XEN=20
> is mapping a BO into a guest the switching overhead for each fault is
> so=20
> high that mapping a lot of PFNs at the same time becomes beneficial.

Since populating at mmap time is not possible due to eviction /
migration, perhaps one way would be to use madvise() to toggle
prefaulting size? MADV_RANDOM vs MADV_SEQUENTIAL vs MADV_NORMAL.

/Thomas

>=20
> Regards,
> Christian.
>=20
> >=20
> > /Thomas
> >=20
> > > Dave.
>=20


