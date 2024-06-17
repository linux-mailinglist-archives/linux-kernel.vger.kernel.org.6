Return-Path: <linux-kernel+bounces-216655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1190A2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE952815AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB80176AC8;
	Mon, 17 Jun 2024 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAQrmNdg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2B10A24
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593367; cv=none; b=k5cgApHpIJwCy2ctlKZnHcQaAJoBVPw35DQgSsZeOa4FIbi96uHmXTjsWipnfn4O6Atzt/gKqxsDAc8RpIri/Qk26WSyKG6H8fUV3IcP/oI5+hvWrCo6yy7Kdy7iabz8UkhNbHAUK/zAdD562LBdzJ5OZiT6rqqeOAtt0VTqEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593367; c=relaxed/simple;
	bh=JHm0iH1Rb3LqS2iI0OkGlo4WQOAGVuUe4DDjBAFzAs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZuTYYosqc2EFEEkXc12CHLV7VRRUkDq1Ludbqh4jMTNtmrjk/Jh2gs6TnOPyedm/GxjFFq8V9HDwJ8hcavYRDaW+t7b31XCHmcTevE0U135+IMM9TyGdpODTfUf5KGPUob3MFgudnvgCFsj75WUMpaxnIYMJ12oYi7XQN5Beh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAQrmNdg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718593365; x=1750129365;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JHm0iH1Rb3LqS2iI0OkGlo4WQOAGVuUe4DDjBAFzAs8=;
  b=VAQrmNdg8B7L1Db29Hsl0tf32tOojDGg4X3Em21pHgLDBXo8B+ieLP9q
   OkldPHtxjFgrcePSlrcFS0tWb2/NseGycXSjvwvH9rNlsX82GMrCpdfeA
   bwsYRePIuBLrlPHDr28/kfaf6qhgMdY25JxAgTmFwpbEWlBHw3xfNjOD3
   H4z0/XgxcXIeZzjDTU7nm6n8IDqfBLFOKx4N+/CaHzAqxy6vIVoesQeZy
   4+mjf26Gz72RiVP8oXXeq9f8XrztJ3WUvfAXQ9+fvqIgUfCbp3nZnN1nD
   BNzDmlrezcZ7xstC1yDXrR4jYbeKXA7wpUTwFcVemtxqlDUa9eHbwLgXI
   g==;
X-CSE-ConnectionGUID: f8oUYaZYRRqhz6UFKj9Mcg==
X-CSE-MsgGUID: iugYQ19vSp63/9gxB2tZag==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15543459"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15543459"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 20:02:44 -0700
X-CSE-ConnectionGUID: 8drbOxcXRJOZxX7pLAGixQ==
X-CSE-MsgGUID: VoZAwEpqSROUevimrQ0sFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41776956"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 20:02:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
  chrisl@kernel.org
Cc: baohua@kernel.org,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  ryan.roberts@arm.com
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
In-Reply-To: <20240615084714.37499-1-21cnbao@gmail.com> (Barry Song's message
	of "Sat, 15 Jun 2024 20:47:14 +1200")
References: <20240614195921.a20f1766a78b27339a2a3128@linux-foundation.org>
	<20240615084714.37499-1-21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 11:00:51 +0800
Message-ID: <87r0cw5l3w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Barry Song <21cnbao@gmail.com> writes:

> On Sat, Jun 15, 2024 at 2:59=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
>>
>> On Fri, 14 Jun 2024 19:51:11 -0700 Chris Li <chrisl@kernel.org> wrote:
>>
>> > > I'm having trouble understanding the overall impact of this on users.
>> > > We fail the mTHP swap allocation and fall back, but things continue =
to
>> > > operate OK?
>> >
>> > Continue to operate OK in the sense that the mTHP will have to split
>> > into 4K pages before the swap out, aka the fall back. The swap out and
>> > swap in can continue to work as 4K pages, not as the mTHP. Due to the
>> > fallback, the mTHP based zsmalloc compression with 64K buffer will not
>> > happen. That is the effect of the fallback. But mTHP swap out and swap
>> > in is relatively new, it is not really a regression.
>>
>> Sure, but it's pretty bad to merge a new feature only to have it
>> ineffective after a few hours use.
>>
>> > >
>> > > > There is some test number in the V1 thread of this series:
>> > > > https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b2=
6@kernel.org
>> > >
>> > > Well, please let's get the latest numbers into the latest patchset.
>> > > Along with a higher-level (and quantitative) description of the user=
 impact.
>> >
>> > I will need Barray's help to collect the number. I don't have the
>> > setup to reproduce his test result.
>> > Maybe a follow up commit message amendment for the test number when I =
get it?
>
> Although the issue may seem complex at a systemic level, even a small pro=
gram can
> demonstrate the problem and highlight how Chris's patch has improved the
> situation.
>
> To demonstrate this, I designed a basic test program that maximally alloc=
ates
> two memory blocks:
>
>  *   A memory block of up to 60MB, recommended for HUGEPAGE usage
>  *   A memory block of up to 1MB, recommended for NOHUGEPAGE usage
>
> In the system configuration, I enabled 64KB mTHP and 64MB zRAM, providing=
 more than
> enough space for both the 60MB and 1MB allocations in the worst case. Thi=
s setup
> allows us to assess two effects:
>
> 1.  When we don't enable mem2 (small folios), we consistently allocate an=
d free
>     swap slots aligned with 64KB.  whether there is a risk of failure to =
obtain
>     swap slots even though the zRAM has sufficient free space?
> 2.  When we enable mem2 (small folios), the presence of small folios may =
lead
>     to fragmentation of clusters, potentially impacting the swapout proce=
ss for
>     large folios negatively.
>

IIUC, the test results are based on not-yet-merged patchset [1] (mm:
support large folios swap-in)?

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.=
com/

If so, do we have any visible effect without that?  If not, should we
wait for patchset [1] (or something similar) to be merged firstly?

--
Best Regards,
Huang, Ying


