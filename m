Return-Path: <linux-kernel+bounces-355795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E5995723
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED53283D33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105E9212D30;
	Tue,  8 Oct 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5jxMQQU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCC212654
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413452; cv=none; b=fUg13NgeiuWtLXvBOK5tSnblI2fnN1iHSDdL7u3p3KoJIC4UBcvznZATZiqxxtxaFABaGmGSQOe3e5zCjSCVujAPp+1EIUe5csRKxsn5d2lkcwzec7kvUfrbicaRmZ31o923FHmHi9owSTuyRud0HzfQY10t19Ocvb0Vy1M5I1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413452; c=relaxed/simple;
	bh=DIJj9byAHXn1Kt1Dy4gur+QJCszeVGQqHdNoJHskiBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cErZMZuJD36XsalwGb/Eio6FWK7mtB6u27LNPDnYX+AF+4ZXfXS7JY91TBswrRXTPz8wboagJPLfuO0Jso6MoeXGAADQpmCB0NajFnRijKb5gxkAbr2MxpnOHxb3hHgfMLie//ZwyFpzsyB3GEoeGVwKgfOHx/uKRuqF9HQ+RV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5jxMQQU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728413451; x=1759949451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIJj9byAHXn1Kt1Dy4gur+QJCszeVGQqHdNoJHskiBs=;
  b=c5jxMQQUAj6VkmA5TrrNNES3hemhU6Dh7dyXFKwJYRmZwNXMX1M0/SW3
   fOEPh+0Wf1T2gaqZCFkRzwl8DpUqEU0lMebasbzbBR8IQBv/8NW6gkK+c
   gyjQU/gYR7xIfFmglLEeffd6GQqCtGEX4zskjVyfnsS9gxbKY6Lk1moOT
   Bb4J5trIlWFxekBTcJRpKdynniwTKcO/5X4uXX1lwuI64qEGMDzEsTeS9
   ZKr16RIBJ1TpUkcmHjGr87Zv7VG2E9ogYDVEAb+hRjOsM2TsBuckl0YJw
   NBD4P8r3kxJsW9W+za+X58uKisbCYoW7Yak/eRQ1cEapPf+Q7uigQOlpo
   A==;
X-CSE-ConnectionGUID: nsXrBPqvS2GVkVCXygPtyw==
X-CSE-MsgGUID: BKCUQT3DQwuFiFkFQ4kRmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27097104"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27097104"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:50:49 -0700
X-CSE-ConnectionGUID: ln1EamaCTESp6sjNiyrVDQ==
X-CSE-MsgGUID: CZP2vg+ESx+f6xabEOwKeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75905091"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:50:48 -0700
Date: Tue, 8 Oct 2024 11:50:47 -0700
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
Subject: Re: [PATCH v5 30/40] x86/resctrl: Describe resctrl's bitmap size
 assumptions
Message-ID: <ZwV_B-4gz9tUaF67@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-31-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-31-james.morse@arm.com>

On Fri, Oct 04, 2024 at 06:03:37PM +0000, James Morse wrote:
> resctrl operates on configuration bitmaps and a bitmap of allocated
> CLOSID, both are stored in a u32.
> 
> MPAM supports configuration/portion bitmaps and PARTIDs larger
> than will fit in a u32.
> 
> Add some preprocessor values that make it clear why MPAM clamps
> some of these values. This will make it easier to find code related
> to these values if this resctrl behaviour ever changes.

...

> +#define RESCTRL_MAX_CLOSID		32

Do you really need to do this? Intel x86 architecture allows for more than
32 CLOSIDs, it's just expensive in h/w to get past 16 ... so I picked
that trivial bitmap allocator in ages past. But if ARM can have more,
then why would you need to clamp the value? File system code could ask
architecture code to allocate a CLOSID. On x86 that will fail when there
are no more CLOSIDs, so filesystem will fail the mkdir(2).

Or, since you put closid_alloc() into the filesystem code you could
change the closid_free_map to u64.

If you really do want to have this #define ... maybe you should use it
in place of the hard coded 32 here:

static void closid_init(void)
{
        struct resctrl_schema *s;
        u32 rdt_min_closid = 32;
}


> +#define RESCTRL_MAX_CBM		32

Intel x86 could plausibly expand the cache bitmap size (the MSRs
that store them currenly have bits 63:32 reserved, but that could be
changed). The only 32-bit limits are the CPUID field that enumerates
CBM_LEN and the CPUID field that enumerates the shared bitmap. The
length has space for expansion, the share bitfiled does not. So if
Intel did go to more than 32-bits we'd be stuck making sure any shared
bits were in the lower 32-bits.

-Tony

