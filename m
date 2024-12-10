Return-Path: <linux-kernel+bounces-439211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E19EAC51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0C9188BC11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDEA2080ED;
	Tue, 10 Dec 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUHZfbbf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2622080DD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823222; cv=none; b=gjXR7TFUQFx3hb0+UptZ12XEoltnjutWa0QdIkSYkZ5xinlbcRIEjqueRauxTJkghMyUMw+DUklEaTq7DrOmb5siHP6B3ZLTiNChGTJjQdD0WjMWt5G/JgLBsCu+riVGbvAJx6iXGUow4+maZWJDOuNLLfMHcNTXqY3XZfOIMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823222; c=relaxed/simple;
	bh=uiJSYhsMkhrtcrx4xUvSwptITiekNJGtqKuEgrR35KQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=Me2eMzU/GugVfDv0/7MMbX7tqqnNnnBrvmDHC0XyHlOX0WQsdjlAUhTv1OhuuxaLS5PfabC64pL92L70DbLjGAEQnJUm+FC8TaONhLFz2PdDTO6dDiAmGy/bQgYy7Mj63OzyJMK3fTPYnScGiQ9jk1OjBRD8+JbO/CSzuhUwV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUHZfbbf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733823220; x=1765359220;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:to:date:message-id;
  bh=uiJSYhsMkhrtcrx4xUvSwptITiekNJGtqKuEgrR35KQ=;
  b=MUHZfbbf510vPJfyeFjnCB7da8MtaoEdw0YChuTNC5fPB09CxNUdp6sf
   XzpU/+6dycgvull0RGXqpZ5+orcONc+LtCdhcxwWPuG5EjYNXwUZWE1z4
   humoogB7tR4mv3N9iDrALjevBlEyLJwEdfAdqeBcjT+cPnFBEXCl8PQIY
   PmCxNHA2jOQlGPMXTCh1LyxZrVqEJ7UjPJlBBvfaGMeZDWAH7wKE5bMPD
   Zco1oSLXIFsy/hGQ/Sjkn4Gdj26otjCDZ8xe/F7rcm/4pytMBg2Lz7jr/
   9NYxyD3wZvtdLEhiS5vrDDrOXH7mcrUP6iQgLOREmQag6SMjqMutmwtqT
   Q==;
X-CSE-ConnectionGUID: vFim71q8TFS23bOzw/hHpg==
X-CSE-MsgGUID: p+GeIu5aR0SU7XKYBugIOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37942969"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="37942969"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:33:40 -0800
X-CSE-ConnectionGUID: HUjq2qIMReiVzDIrC+D+OA==
X-CSE-MsgGUID: r/mkXWyhSDCb+77g5KxIQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95826050"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:33:36 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e4401ab1-0562-407a-a0e9-2f6e43e5ac22@amd.com>
References: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com> <20241209133318.1806472-15-mika.kuoppala@linux.intel.com> <ec42fe8b-9be0-41cc-96f4-f1869c6bb7e6@amd.com> <Z1cNQTvGdAUPp4Y-@phenom.ffwll.local> <e4401ab1-0562-407a-a0e9-2f6e43e5ac22@amd.com>
Subject: Re: [PATCH 14/26] drm/xe/eudebug: implement userptr_vma access
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>, Linux MM <linux-mm@kvack.org>, Maciej Patelczyk <maciej.patelczyk@intel.com>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Tue, 10 Dec 2024 11:33:33 +0200
Message-ID: <173382321353.8959.8314520413901294535@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.10

Quoting Christian K=C3=B6nig (2024-12-09 17:42:32)
> Am 09.12.24 um 16:31 schrieb Simona Vetter:
> > On Mon, Dec 09, 2024 at 03:03:04PM +0100, Christian K=C3=B6nig wrote:
> >> Am 09.12.24 um 14:33 schrieb Mika Kuoppala:
> >>> From: Andrzej Hajda <andrzej.hajda@intel.com>
> >>>
> >>> Debugger needs to read/write program's vmas including userptr_vma.
> >>> Since hmm_range_fault is used to pin userptr vmas, it is possible
> >>> to map those vmas from debugger context.
> >> Oh, this implementation is extremely questionable as well. Adding the =
LKML
> >> and the MM list as well.
> >>
> >> First of all hmm_range_fault() does *not* pin anything!
> >>
> >> In other words you don't have a page reference when the function retur=
ns,
> >> but rather just a sequence number you can check for modifications.
> > I think it's all there, holds the invalidation lock during the critical
> > access/section, drops it when reacquiring pages, retries until it works.
> >
> > I think the issue is more that everyone hand-rolls userptr.
>=20
> Well that is part of the issue.
>=20
> The general problem here is that the eudebug interface tries to simulate =

> the memory accesses as they would have happened by the hardware.

Could you elaborate, what is that a problem in that, exactly?

It's pretty much the equivalent of ptrace() poke/peek but for GPU memory.
And it is exactly the kind of interface that makes sense for debugger as
GPU memory !=3D CPU memory, and they don't need to align at all.

> What the debugger should probably do is to cleanly attach to the=20
> application, get the information which CPU address is mapped to which=20
> GPU address and then use the standard ptrace interfaces.

I don't quite agree here -- at all. "Which CPU address is mapped to
which GPU address" makes no sense when the GPU address space and CPU
address space is completely controlled by the userspace driver/application.

Please try to consider things outside of the ROCm architecture.

Something like a register scratch region or EU instructions should not
even be mapped to CPU address space as CPU has no business accessing it
during normal operation. And backing of such region will vary per
context/LRC on the same virtual address per EU thread.

You seem to be suggesting to rewrite even our userspace driver to behave
the same way as ROCm driver does just so that we could implement debug memo=
ry
accesses via ptrace() to the CPU address space.

That seems bit of a radical suggestion, especially given the drawbacks
pointed out in your suggested design.

> The whole interface re-invents a lot of functionality which is already=20
> there=20

I'm not really sure I would call adding a single interface for memory
reading and writing to be "re-inventing a lot of functionality".

All the functionality behind this interface will be needed by GPU core
dumping, anyway. Just like for the other patch series.

> just because you don't like the idea to attach to the debugged=20
> application in userspace.

A few points that have been brought up as drawback to the
GPU debug through ptrace(), but to recap a few relevant ones for this
discussion:

- You can only really support GDB stop-all mode or at least have to
  stop all the CPU threads while you control the GPU threads to
  avoid interference. Elaborated on this on the other threads more.
- Controlling the GPU threads will always interfere with CPU threads.
  Doesn't seem feasible to single-step an EU thread while CPU threads
  continue to run freely?
- You are very much restricted by the CPU VA ~ GPU VA alignment
  requirement, which is not true for OpenGL or Vulkan etc. Seems
  like one of the reasons why ROCm debugging is not easily extendable
  outside compute?
- You have to expose extra memory to CPU process just for GPU
  debugger access and keep track of GPU VA for each. Makes the GPU more
  prone to OOB writes from CPU. Exactly what not mapping the memory
  to CPU tried to protect the GPU from to begin with.

> As far as I can see this whole idea is extremely questionable. This=20
> looks like re-inventing the wheel in a different color.

I see it like reinventing a round wheel compared to octagonal wheel.

Could you elaborate with facts much more on your position why the ROCm
debugger design is an absolute must for others to adopt?

Otherwise it just looks like you are trying to prevent others from
implementing a more flexible debugging interface through vague comments abo=
ut
"questionable design" without going into details. Not listing much concrete
benefits nor addressing the very concretely expressed drawbacks of your
suggested design, makes it seem like a very biased non-technical discussion.

So while review interest and any comments are very much appreciated, please
also work on providing bit more reasoning and facts instead of just claiming
things. That'll help make the discussion much more fruitful.

Regards, Joonas

