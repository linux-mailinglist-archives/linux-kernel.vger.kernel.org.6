Return-Path: <linux-kernel+bounces-413261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906A9D1679
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2511F2222B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF31BE852;
	Mon, 18 Nov 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRWVdoEL"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8091AE016
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949062; cv=none; b=FdX58+hESI8Q2BvYtqgcbnVMA0DNDPBj4o3fvWNbBOzD2ByGrDQDDIgufcUSdlbGnwguVU43PPg79ifYV/SKYlOg5GNGlROtc/5QfF0SuImvznUGmNchWWJJV2YX1PtjTn4RmlDnWLjLzKXQ7LPOmDyjxw+v14SnXJWrrgNas1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949062; c=relaxed/simple;
	bh=4ifOo5HliVyw7qwcm+9kfBZTDeIkGDadeXt3oI+BDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG42fHH6eyfyXjvqE2bnT9nC6efVGs3TUSFCKhpiMhl5aYsa7aA2NKFEMofco/bLe0ofoMXm4jfSApUb+LuNZAR3xnSzZ2ZtdsbVkVNk5T5bBy4lOURc7FwWXLEN9lIaNULN8/TF2snq346ThWYyBV+1ENWOqISU8wkH7UVsYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRWVdoEL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Nov 2024 08:57:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731949058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnvzeJ3O9gPeNSZCwNiEkgkNPJiLx/mp4rGBRuic5qA=;
	b=JRWVdoELd4W5uZS4m8k0rySCUmgr8kw73NEKQaAIu4akIv8GogBCWfI7lt037Dw8HSa+0N
	I6s5J/U3Xf1uffTPuXaXaEBz6stJDwqxnhBbsl4QMRhhZ7ZWjUyFFLpYZsK036aRgRB8OS
	XnWqiNUit3fJCa0Yknl5YzBQYY448Ho=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Colton Lewis <coltonlewis@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: perf: Drop defining
 `perf_instruction_pointer()` and `perf_misc_flags()`
Message-ID: <Zztx-EBqXcFdBSPj@linux.dev>
References: <20241116160506.5324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116160506.5324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 16, 2024 at 04:05:06PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> With commit 2c47e7a74f44 ("perf/core: Correct perf sampling with guest
> VMs"), the perf core now handles the functionality previously requiring
> arch-specific definitions of `perf_instruction_pointer()` and
> `perf_misc_flags()`. As these definitions are no longer necessary for
> RISC-V, this patch removes their implementation and declarations.
> 
> This change also fixes the following build issue on RISC-V:
> 
>     ./include/linux/perf_event.h:1679:84: error: macro "perf_misc_flags" passed 2 arguments, but takes just 1
>     ./include/linux/perf_event.h:1679:22: error: 'perf_misc_flags' redeclared as different kind of symbol
>     ./include/linux/perf_event.h:1680:22: error: conflicting types for 'perf_instruction_pointer'; have 'long unsigned int(struct perf_event *, struct pt_regs *)'
> 
> The above errors arise from conflicts between the core definitions in
> `linux/perf_event.h` and the RISC-V-specific definitions in
> `arch/riscv/include/asm/perf_event.h`. Removing the RISC-V-specific
> definitions resolves these issues and aligns the architecture with the
> updated perf core.
> 
> Fixes: 2c47e7a74f44 ("perf/core: Correct perf sampling with guest VMs")
> Reported-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

