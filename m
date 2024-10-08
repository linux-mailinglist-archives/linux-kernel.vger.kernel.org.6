Return-Path: <linux-kernel+bounces-354301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA70993B81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49CE28306C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900613C90A;
	Tue,  8 Oct 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgRHxFbU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702018C335
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345620; cv=none; b=KkV4CqavJQnAKiQB8ydMYuuTqGwx7wDKS2iTOZ8Xo6WQL6DsDzqC+FK20FldEjERr/Fww02cl9tnN5Ig6FDLSc3Zi1QbL05BCoe+OGGU9T4i/OPY9UopjTChK59IwzPY4JL9U2exhKE1MwaU8pF9M/0sz/bDeO/j2h/+0mUwk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345620; c=relaxed/simple;
	bh=mEpj0iMPhBBU/sf9vaoLlpURmXdhk6gx52/vlsBsuYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5fxWSILrdt37knvzwftmj54u1VGaLilrerwD2v+QWAhW7eROvh7PiQ9JR8Zk3YYDtnyJgnSTj68X+61RzEtXvIY0eXbm9pa8OJjeJ+vDmVLDVEND7awnbsxAoV2gK4Rt9FjVgcEqFmRLB7irbGF4GP2iCy9t6w+ov7LBgwNR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgRHxFbU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728345619; x=1759881619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEpj0iMPhBBU/sf9vaoLlpURmXdhk6gx52/vlsBsuYg=;
  b=NgRHxFbUp8fqeeD4gu1GG3ZTt1hKSxiMN9D5yUzr37KdvDqR3bcWj63Q
   qLZmmSjGEaOz2ZOjpPKX7TuxWqzN1W+OT0a0lyOEJUVeJQ3hKBne8Pbog
   9e7kKrtLvPWERzHhae6HbZoDvdj1AaPr3OnNBRX9Fz1STdtnRbTnMNiJ6
   NPAUsydmx5aTvt48llarqMeJ7LxaFTKyKoqSnONshsQBmIh9jLuOvMVAh
   PwC+S1ZrTBNviTkfJOoYsu04OimcLdsTJHzbVIOTBbmhdNGvLKs8aY97/
   oO793m09fpHKCbjkmq09bC2jIvMZB56t3I6VAd0MnR9hkWUKK/LKftIcB
   A==;
X-CSE-ConnectionGUID: C2C+gWRZQ++zZPMBKrzLNw==
X-CSE-MsgGUID: GJqwyIvoS+aw59WjD6Puag==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="30399826"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="30399826"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 17:00:18 -0700
X-CSE-ConnectionGUID: 5PUMPXgDTASH2bsizRgkbw==
X-CSE-MsgGUID: KUlCu8l/RhakU1pIKTHFVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80472239"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 17:00:17 -0700
Date: Mon, 7 Oct 2024 17:00:15 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v5 17/40] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
Message-ID: <ZwR2D4ISzIrZRTHi@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-18-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-18-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:24PM +0000, James Morse wrote:
> The for_each_*_rdt_resource() helpers walk the architecture's array
> of structures, using the resctrl visible part as an iterator. These
> became over-complex when the structures were split into a
> filesystem and architecture-specific struct. This approach avoided
> the need to touch every call site, and was done before there was a
> helper to retrieve a resource by rid.
> 
> Once the filesystem parts of resctrl are moved to /fs/, both the
> architecture's resource array, and the definition of those structures
> is no longer accessible. To support resctrl, each architecture would
> have to provide equally complex macros.
> 
> Rewrite the macro to make use of resctrl_arch_get_resource(), and
> move these to the core header so existing x86 arch code continues
> to use them.

Apologies if this comment was suggested against earlier versions
of this series.

Did you consider replacing rdt_resources_all[] a list (in the filesystem
code) instead of an array (in the architecture code)?

List would start empty. Architecture init code would enumerate features
and add entries to the list for those that exist and are to be enabled.

The "for_each" macros then walk the list (variants for all entries,
for "alloc_capable" and for "mon_capable"). Note that only enabled
entries appear on the lists.

There are currently a bunch of places in filesystem code that
do:
	r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
or
	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);

those could become:

	r = resctrl_arch_get_mba_resource();

	r = resctrl_arch_get_l3_resource();

Then the whole "enum resctrl_res_level" and ->rid field in
struct rdt_resource could go away? Remaining uses look like
distinguishing MBA from SMBA. Perhaps better done with a
flags word?

Advantage of doing this would be to avoid the generic
enum resctrl_res_level having to be a superset of all
features across all architectures. E.g. ARM might want
to add L4/L5 resources, X86 may have some that ARM will
never need. RiscV may also follow some divergent path.

If this v5 series is close to being applied then I don't
want to derail with a re-write at this late stage.
All of this could be done as a cleanup after this series
has been applied.

-Tony

