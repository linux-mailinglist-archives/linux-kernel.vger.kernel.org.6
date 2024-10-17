Return-Path: <linux-kernel+bounces-370184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A09A2933
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C7BB22764
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD91DF27D;
	Thu, 17 Oct 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhT+ymHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D11DEFFB;
	Thu, 17 Oct 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183159; cv=none; b=GwaiQRwTxCZCuUfUegxP51xlccXXVpRDiB/nXrEr0IjxNmiBkvDLoJad8+O2Mu7jHBc32MOBffSQSR2N56SV8b3Y3S2dZI2a6ln19M1UqGRH/g0+ro+klg+wOjdsXI3kMuemgkZouxsofChWS9DIITC0Xxh1grpmXmKzK8Acch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183159; c=relaxed/simple;
	bh=ZV/1UNXAO6nBHwQ6t+xezb33aKR4GTpXS+8P4n5bmos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YFrA3w8kr/GQU9UslXgCFAOTJSGmYmgGJvGDOMCak0Y8UCpcbq2mK/Q+Kh47kxaqp5cuo9YevBqltcnzsoYoBQdURuvo8b7hqmkUwl8dwNLZA3lpjFbfbQfk32hLBFeUH8zWU5fIqRJxsM6+ln83g2bd2k31Cp+lrpKbQmSNtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhT+ymHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF2C4CEC3;
	Thu, 17 Oct 2024 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183159;
	bh=ZV/1UNXAO6nBHwQ6t+xezb33aKR4GTpXS+8P4n5bmos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XhT+ymHhf3A2Gd2fNhaimuvgUko8UkLQCq7sHfjUDY4YxWLp6BugwJD2I6yGu70WJ
	 317FynRPSrEWK/vbVHsUfdpQhh9EVGlUMghHXc7FXETN44hvdwjibD3k+nZjWE+W6T
	 eGQBSVIBhryZVzYqEAFNe3yPieQf+/hVforsAqx2I797gyVsKkLr79+hxDIefjATSN
	 lLxHvMzVC3DNgAZjgw1jvcr902z0lptLpmLRVSFtohaxaeShZJw5e0kDaj7L5oDRj4
	 Rxdpondqy2ewjLFh4NPHTUzhLHwKHSzCWn8lGOcE+qCvwukVBOb/gqh7mKJhJEEsp4
	 pwcVbVYR3ldLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <20241016160413.51587-1-irogers@google.com>
References: <20241016160413.51587-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tool_pmu: Remove duplicate io.h header
Message-Id: <172918315932.639809.8479132536704193683.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 09:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 16 Oct 2024 09:04:13 -0700, Ian Rogers wrote:

> Remove duplicate inclusion of api/io.h.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


