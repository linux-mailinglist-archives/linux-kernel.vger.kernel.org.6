Return-Path: <linux-kernel+bounces-440118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFF9EB914
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FDA28126D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2212046A9;
	Tue, 10 Dec 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hii1bNp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919A204696;
	Tue, 10 Dec 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854224; cv=none; b=f+Xh2sZRnc8bbFgYuACz6V1e5DCRT/Y8SANWoHiT/Sggdt7CzsBsasVuC7A3SBJx+K6Jo3qc9y8dRReFGEVh/AHVWaVjYmiQq9pnaJMeaUoty+ZCKlNCMpv3rtkov9/aIa+4FKkTfWzbfffHP95YKC7q0jnza3cNA0i8RukadR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854224; c=relaxed/simple;
	bh=lp1TUjNspJzYk33DGagyaO+1G26pRYTDVB5oy+2mDH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQlYv5oeZhWxLLJc4olqKL0EgjXf4gA/HpyYogo44eqlKX1QXh29IdBrTEzjLUfPqUudFMh6kh+YLfuci4mWNKP6HKutps8cWvIjFVzY8u0/ODTkkTEcS/Ywh+RHdQvtLEan8gx66aXNxfEe32BDzxhWcZ6If2L+2rmsJzTj1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hii1bNp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC2C4CED6;
	Tue, 10 Dec 2024 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733854223;
	bh=lp1TUjNspJzYk33DGagyaO+1G26pRYTDVB5oy+2mDH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hii1bNp/rQgWLNCGXs3EIRYEzrbQYZybIR9Ek2te83yvTMMOwRCkMqt+m3oSeYGyF
	 yertm6LsIGhmmxR8TKAPiDRv5cvQPvQw20TmQEhALw1AUaw+9Xt+xLuLI4xmgyI/Pd
	 dlr0vKErUvcc1FVRG4NaICzNtFhDdy2xHBvSZjOgKvi+k+qH2xvbujn97Tn6bBc3xb
	 YA477U4k1jwJvcJZPKgbZm+lYMxvQrcmkw+Xx6ZXTzr3b/QpqvaDjYE+zRmkt8YNkS
	 QlTR2pWHhZUb9/DDMQ6Hh3MFe7APleAIVSlZA1tFECc7xDyOkg/uDZNUORTFSpX8mG
	 ytv06FbrGB5eQ==
Date: Tue, 10 Dec 2024 10:10:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>, thomas.falcon@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid
 platform
Message-ID: <Z1iEDRT-44aynAR3@google.com>
References: <20241114160450.295844-1-james.clark@linaro.org>
 <20241114160450.295844-2-james.clark@linaro.org>
 <Z1hHc-Q-TKgagORu@x1>
 <eb8301ec-50af-4414-89e7-5d49585bda47@linaro.org>
 <Z1hLEQwYE3ymbrIr@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1hLEQwYE3ymbrIr@x1>

On Tue, Dec 10, 2024 at 11:07:13AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Dec 10, 2024 at 01:56:21PM +0000, James Clark wrote:
> > On 10/12/2024 1:51 pm, Arnaldo Carvalho de Melo wrote:
> > > James, the second patch isn't applying to perf-tools/perf-tools.
>  
> > The second one applies on
> > https://lore.kernel.org/linux-perf-users/20241113011956.402096-1-irogers@google.com/T/#m2a3587fb83e6ab2d970bae25982ae9d6c8d9e5cd
> > because that also does an evlist__remove() which gets fixed up.
> 
> Right, I have to test that series on the ARM machines I have access to,
> but there is a question from a tester that is waiting for a reply, I'll
> see if I can reproduce that problem as well.
> 
> > But the first one is ok to go in on its own.
>  
> Agreed.

Ok, I'll pick this one to perf-tools and leave the patch 2 go into
perf-tools-next.

Thanks,
Namhyung


