Return-Path: <linux-kernel+bounces-292796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E5395747A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE183B24241
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980121DB456;
	Mon, 19 Aug 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQGICLNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0D4642D;
	Mon, 19 Aug 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095969; cv=none; b=FsBNuWe4YcMkRIwIxbtLREFoJsMAJqfrgHHmEDMlKv+Yr58wds91Nb+YmNr032IESQIdV45rkpf6CmxZj6JdltVGmo0R+uUsec/gyiB94f1BszQH+YQ7t2guH8ycvPK65O2sRzBviIoHJqtyNd3esNQKoiBsbHH3+6glKzlCMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095969; c=relaxed/simple;
	bh=nMVr/YkS0qLNXSjgWsWAp2JR5/sI8RK1CYxLr2FGqFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0+movV/eV4RAvZ9k19hQAwQzEb5xQw5Yaac5I/htTqmbcDmOyHPQs4FEemXOdbbJRaXjf2CjCwQr2/1LHLfrwoOZ1Gk81sOqlFQ9pkm/zBUrWklAWS1S+fjg02/PwHvvH4asur9PihYUSeJBzlqUVW+Y80veD25PV3TW8IQwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQGICLNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3049C32782;
	Mon, 19 Aug 2024 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095969;
	bh=nMVr/YkS0qLNXSjgWsWAp2JR5/sI8RK1CYxLr2FGqFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQGICLNGMbRY+SVb4OLMc4xeM1u677DthpEMWoOhTGkzaRlCP6xWnUgxtAeuuQnN/
	 zSBABU/yd80QHOh/P64RpteynNtHB2dbG+gdJpp7xLtjBxGXbAbTJzroIVeFkI3OyQ
	 ho0X7bQLvSW64Pb6fXaqjh6XlKLIFVqJXZr/6TAtKLyiRrsdoMQowJ6MaUBRwgrW7F
	 VIaoqDfDVo8Bb0zAzTrxsEHBOi9of4NB1iFOG0PFgUDxN/h8VIjznNDrADZMg1EP1L
	 ePjJJTVlcPqjrbWe7Pqz99hcnyYCe25i9xQx6Xp3XMVFaOpRlAl/Y7PZbH3A0hLyI8
	 TUK1YzGshCvGw==
Date: Mon, 19 Aug 2024 16:32:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf record: Fix sample cgroup & namespace tracking
Message-ID: <ZsOd3b2whGxRQHJr@x1>
References: <20240818212948.2873156-1-namhyung@kernel.org>
 <CAP-5=fU52ZcPUM1QMgAQ59GOouCCJyUZOQs2H7Gt8zB32+0C1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU52ZcPUM1QMgAQ59GOouCCJyUZOQs2H7Gt8zB32+0C1Q@mail.gmail.com>

On Mon, Aug 19, 2024 at 08:20:26AM -0700, Ian Rogers wrote:
> On Sun, Aug 18, 2024 at 2:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The recent change in perf_tool constification broke the cgroup and/or
> > namespace tracking by resetting tool fields.  It should set the values
> > after perf_tool__init().
> >
> > Fixes: cecb1cf154b30 ("perf record: Use perf_tool__init()")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

