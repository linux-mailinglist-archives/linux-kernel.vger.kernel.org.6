Return-Path: <linux-kernel+bounces-401160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4839C1694
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED7D1C22AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4451D07A7;
	Fri,  8 Nov 2024 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umfLTCbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9B1C3F06
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048472; cv=none; b=GCJRpu1PejfSviKb4inobwOfH7pTNvn5PPg4glaAOYIBk6bh4Ct3TeXS6QMobfXzGc7cI5lOBmkwFpKqLEdm3PNs6sP5S4TGHwWimtJP7t1xdeqBAsM2/vhYNkVet6zIM5n+or7dWy9XbYYjm8/vhKV4qYoL0Csrmc2d0FKnHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048472; c=relaxed/simple;
	bh=aeB/gVKII4FFISWvHdRA+fZvh4oKNPS1S2q0rYFs/fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxH6opR3VPKWtGaoOAFy1qNh+Ic/eBMbU+WT6Nq/sNn4HNZFrbmLyum9HjednLPo5BvdSJSE99wbDjhnY5351to0lGANUKFIL4Uk1GFIIEUYvnPPuczPLwoOfYiLPwAFbMbXCaNX0FLChzIKZnRRq8gznDV2YugC5RQ6ndy5TBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umfLTCbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2559C4CECE;
	Fri,  8 Nov 2024 06:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731048472;
	bh=aeB/gVKII4FFISWvHdRA+fZvh4oKNPS1S2q0rYFs/fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umfLTCbRFOYdoSKy8+gP7W6TZEx7yZMSU+lY4qjZCBpO1qWERybZJ6MraG0D6tCm2
	 Mo+mWQEC72ags9X/E+MEoKZ6WaahnKPU8HcGyBGwoh2MrextLtYJpH/Rz3QU9qUMHX
	 cxJJ/7untBNngWj9mZISEDDIs8EjE2/Vt77Xrlft/7giU03FKWglYYPyj4TL/+NkDk
	 Ye9CaytPvuL/zgbJVIwz2AKp5QVIezDi060WGGn0f8SxvCGuPLSVGwckcF9lf/pZdg
	 wpF2ZyUxs2Jtzjo4mORYUkPLlzqmYVLuQKqtDEBQ5UMnROA4ngDVwLRifa42vFv5Dc
	 ZXwMynTQl7gPQ==
Date: Thu, 7 Nov 2024 22:47:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v5 0/2] perf: Relax privilege restriction on AMD IBS
Message-ID: <Zy20Fm7sVbfReWBE@google.com>
References: <20241028200153.1466731-1-namhyung@kernel.org>
 <d5187836-3c1e-4bdb-90a2-779d3c1f086d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5187836-3c1e-4bdb-90a2-779d3c1f086d@amd.com>

On Wed, Oct 30, 2024 at 03:22:02PM +0530, Ravi Bangoria wrote:
> On 29-Oct-24 1:31 AM, Namhyung Kim wrote:
> > Hello,
> > 
> > This is v5 to allow AMD IBS to regular users on the default settings
> > where kernel-level profiling is disabled (perf_event_paranoid=2).
> > Currently AMD IBS doesn't allow any kind of exclusion in the event
> > attribute.  But users needs to set attr.exclude_kernel to open an
> > event on such an environment.
> 
> For the series:
> 
> Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks for your review!

Peter and Ingo, can you please take a look at this?

Thanks,
Namhyung


