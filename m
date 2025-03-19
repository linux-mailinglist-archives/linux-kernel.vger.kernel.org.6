Return-Path: <linux-kernel+bounces-568757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8EA69A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B06980097
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56098214A71;
	Wed, 19 Mar 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daX5vn9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABC1E0B86
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416206; cv=none; b=G91qk9zs9Un+DylXHFtl7NOk3H2SPUps+A4zGTeCrMB4LpGD34eUhcJU6v6292D3NZsLmRz4Ykc4Wv53PFVgK+59XyEIzDkJcgOYQn+Vx1k5uM5Za6KWKCeaMVJ/nP/RUhbsR/yyzZYAhHBhTF9iYttvh0bH7nZzpH10hjQzWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416206; c=relaxed/simple;
	bh=8zPT/n4Lu1XncYDLHyW7jepsox1cBlAn/Zp3LerDahc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2sGmFnsXKdWWaw7/9Bpp9M8P/gn/XamC/WR0og/QJH2YhmqztmSJ090hreuWTdSDJ+ttjkfJ16mwUbAahR+/XWCi2+rL+wCmgfK/7l3Tkg4KRkLxdrQ51iyisGXJonUQ9DOLzJrTdcNCwcyzdLAeFbJ63fkKHi2mIb5aDpN/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daX5vn9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0E1C4CEE4;
	Wed, 19 Mar 2025 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416206;
	bh=8zPT/n4Lu1XncYDLHyW7jepsox1cBlAn/Zp3LerDahc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daX5vn9hY/tRV9fJ10/I34CWJ/7kxLohe5sakf2v1fOO10QX+y3Zhv0CqDaDDQuTs
	 dGSH7yPWY7n9F9bql7JgUW42kpO+zlZhOclCQwYUl6pvjB0cTe3yeOU7d15zsccQHM
	 oAi4J+O/OCnVZOvVGZGGlyUDSoTLWzzxEdyuQREiiuHo/Zwc923o5C36NZsZKIytDM
	 bd954bo0glCwUYJV5nDTiKXGDxmlzDiowZdyTaomNRGTDQg9gOs7dNXB2U1Hd6K8ah
	 pSK7mdkiFDgjZPPH7FWwEekmwGfNwVGhE8s8VAWOSHaJt6vMV5k1qjLxTDohLPGpMG
	 qQQshYMtDg4JQ==
Date: Wed, 19 Mar 2025 13:30:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH v2] perf/x86: Check data address for IBS software filter
Message-ID: <Z9spTE_M47M4qpCR@google.com>
References: <20250317163755.1842589-1-namhyung@kernel.org>
 <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com>
 <Z9m20YMkMfUDBxgv@google.com>
 <d1dec8b8-10c8-4da0-920a-d1f744543253@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1dec8b8-10c8-4da0-920a-d1f744543253@amd.com>

On Wed, Mar 19, 2025 at 04:24:12PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> >>> IBS software filter was to filter kernel samples for regular users in
> >>> PMI handler.  It checks the instruction address in the IBS register to
> >>> determine if it was in the kernel more or not.
> >>>
> >>> But it turns out that it's possible to report a kernel data address even
> >>> if the instruction address belongs to the user space.  Matteo Rizzo
> >>> found that when an instruction raises an exception, IBS can report some
> >>> kernel data address like IDT while holding the faulting instruction's
> >>> RIP.  To prevent an information leak, it should double check if the data
> >>> address in PERF_SAMPLE_DATA is in the kernel space as well.
> >>
> >> PERF_SAMPLE_RAW can also leak kernel data address. How about:
> > 
> > Thanks for your review.
> > 
> > I think RAW is different as it requires perf_event_paranoid == -1.
> 
> IBS allows PERF_SAMPLE_RAW irrespective of perf_event_paranoid. e.g.:
> 
>   $ cat /proc/sys/kernel/perf_event_paranoid
>   2
> 
>   $ ./perf record -e ibs_op/swfilt=1/u --raw-samples -- make
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.371 MB perf.data (3957 samples) ]
> 
>   $ ./perf script -D | egrep -A2 "LdOp 1.*DcLinAddrValid 1" | egrep "IbsDCLinAd:\s*f"
>   IbsDCLinAd:     fffffe00000000e8

Oh, I thought it was enforced in the core layer but it turns out that
it's checked only by tracepoint events.

> 
> We have two options:
> 1) Restrict IBS + PERF_SAMPLE_RAW to privilege users.
> 2) Remove all sensitive information from raw register dump before
>    passing it to userspace. (Kernel data addresses and all physical
>    addresses are the only sensitive info I suppose?).
> 
> 2 is better IMO since it will allow unprivileged user to use IBS
> with full potential. wdyt?

I'm slightly inclined to #1 for simplicity and safety, but #2 is fine to
me as well.

Thanks,
Namhyung


