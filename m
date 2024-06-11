Return-Path: <linux-kernel+bounces-210178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6090407A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43A2B21B54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FC3987B;
	Tue, 11 Jun 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/teeE0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687B3B791;
	Tue, 11 Jun 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121065; cv=none; b=XHiqDf+jcan3Lk+8JjJlIlQYWA1sheFeR1jejQ8xS5ut/YSHOXZtvPPf8AOwhRDISZVGANSoQYw/YBjl+iAiT7dCfQ1dc4DqLXITS+WjHQK62bqU062W6Wcd30F4Q3sCy1TOsZj8JGuF3KUfLEPX9W1WC9HqzYnS9UdAHC11VD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121065; c=relaxed/simple;
	bh=EZQe5/HnTww6x2nEO1a/sr9nJZxv9d+5ZjS74clg2LY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHdIkr5PRhs5TfNxc3nIG9pg3yPwdVeTHm0KW06H+j4dP8xLKRspwzNLVOcOuuMBGMpU/r+t04PCLRfSW98sQGH94PX6TJ+GjGRK/8iYPN7eqncDELA1Js5D3pYg4BAZCYG6faPicki7fh6vwvYKAZb2XE/ik1jTpdCdQEw2Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/teeE0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA0C2BD10;
	Tue, 11 Jun 2024 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718121064;
	bh=EZQe5/HnTww6x2nEO1a/sr9nJZxv9d+5ZjS74clg2LY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W/teeE0Dmia180ZRLOzNknOOT8F3PQ3R7sM1Y6pEMJOXc3b7PEQDsFe9wX989b47+
	 1GgAPNTFpfgnn480HxRYEDrqaPresY0mt9klkEyjRk2CaL42vXC9ewb+0+trt3SNDp
	 VnSxqHj9itgXa2CXSig18SBuRNAh/WJWZKfHszSUSdp5g561EkIN3vNj69bcL3GW1v
	 GTp2LK92t1mxHuvgXe/TNiOnyZ8VBhQRtUwO7mo8/FHbBfFLJSRbBHxdO4yInrfXE9
	 EmYRdZKraOwez2nZB69FjmE0NgYPDxfWeyjz4/PDqV8kEHdxA6Q8GBljGRqzF2nMv7
	 0loVbALKvaAIQ==
From: Namhyung Kim <namhyung@kernel.org>
To: weilin.wang@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Song Liu <song@kernel.org>,
	James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf evsel: Refactor tool events
Date: Tue, 11 Jun 2024 08:51:00 -0700
Message-ID: <171812103921.884988.5218086373127987409.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240503232849.17752-1-irogers@google.com>
References: <20240503232849.17752-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 16:28:49 -0700, Ian Rogers wrote:

> Tool events unnecessarily open a dummy perf event which is useless
> even with `perf record` which will still open a dummy event. Change
> the behavior of tool events so:
> 
>  - duration_time - call `rdclock` on open and then report the count as
>    a delta since the start in evsel__read_counter. This moves code out
>    of builtin-stat making it more general purpose.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

