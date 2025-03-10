Return-Path: <linux-kernel+bounces-555163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC701A5A647
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A92C3AAD07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05141E1A3B;
	Mon, 10 Mar 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U71XJsGa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FD1DFFD;
	Mon, 10 Mar 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642357; cv=none; b=iIgvsWiPQ3Pi5AzgLdR4y/vUEs3i/2Y2VkZRVrYklWvnLsgXzWHgcSVUHnZ3ZeVhV3k7rBldwPiTGmqGa1jVto4z9viL6ESyhUqvLhVOAjPdxmTelbriLVleCamN4RyH/sNRZUB7YlTtj5DTzF6fyKqAoovIzH33yDuHB2j/77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642357; c=relaxed/simple;
	bh=A/Y97OyCtIpCIInftpTnduWsM/mIIWYNQHFylpxNUOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8ixlZs4mGBRjtsFVhYuA2xLua1rRTDm7W6qBbDu2CMNUOek/rOxlAqK4wrKGTHGKgJZPeatV2T5RSHK3uoGIqtTmAabD0tvYaL2ok4UDqpZfdin8BfODy36TmH+ZnyP0RLn/HkXtRxvtOVPGGcJOEVIxUjoacpM+mW6u8B31C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U71XJsGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F57C4CEEA;
	Mon, 10 Mar 2025 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741642356;
	bh=A/Y97OyCtIpCIInftpTnduWsM/mIIWYNQHFylpxNUOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U71XJsGarAJIJG9qAJrsmW0AHilfVhNgqDerCnrWNUPIuwcSQ1ozZ5gBJM6OCfK76
	 MlBVoe9xAe57bLu3dLg8cW1lwfoevg7m6EbVjSzkkcytIQX3toQj7drHoatstuFZDu
	 tTp2YY+B6onJAJPKU5kGW7FlJGWwAuvRsahEwznoDK2EETkNZQIfiZmDnjFV3PXpYJ
	 mqWQpcqkk8b8eE4rHgxrUxFvz+h5+Mh2AKJNfYd8IBVzqVIMJnS9KKAfUXHjwqPx8c
	 TM/68lsxCOBIhw5fbf2atWqAFOk3CGR1amKjWFpG0ziSXc0d8e9vbrEi1jAu5O/aWg
	 mxwSbKhyNSL4Q==
Date: Mon, 10 Mar 2025 14:32:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] Support .gnu_debugdata for symbols in perf
Message-ID: <Z89acl2ZP4j3iS12@google.com>
References: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
 <Z88KyA4PCzhMa-fK@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z88KyA4PCzhMa-fK@x1>

On Mon, Mar 10, 2025 at 12:52:40PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 07, 2025 at 03:22:00PM -0800, Stephen Brennan wrote:
> > Hello all,
> >
> > This series adds the ability to read symbols from the ".gnu_debugdata" section
> > of DSOs. More details are the cover letter of v1. This only has one small change
> > from v2: it adds the missing entry in dso__symtab_origin(). Its lack resulted in
> > truncating the output of symbols in "perf report -v" -- thanks to Arnaldo for
> > testing and catching that.
> >
> > v2: https://lore.kernel.org/linux-perf-users/20250220185512.3357820-1-stephen.s.brennan@oracle.com/
> > v1: https://lore.kernel.org/linux-perf-users/20250213190542.3249050-1-stephen.s.brennan@oracle.com/
> >
> > Stephen Brennan (3):
> >   tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
> >   tools: perf: add LZMA decompression from FILE
> >   tools: perf: support .gnu_debugdata for symbols
> 
> Next time please follow the convention on subject lines in tools/perf:
> 
> 36e7748d33bf6a82 (perf-tools-next/perf-tools-next) perf tests: Fix data symbol test with LTO builds
> e1f5bb18a7b25cac perf report: Fix memory leaks in the hierarchy mode
> e242df05ee5f2ab0 perf report: Use map_symbol__copy() when copying callchains
> 4c3f09e35ca999f6 perf annotate: Return errors from disasm_line__parse_powerpc()
> dab8c32ece27c7d8 perf annotate: Add annotation_options.disassembler_used
> b0920abe0d529101 perf report: Do not process non-JIT BPF ksymbol events
> 2c744f38da7aeae7 perf test: Fix leak in "Synthesize attr update" test
> 41453107bfc30083 perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps
> e0e4e0b8b7fabd8c perf maps: Add missing map__set_kmap_maps() when replacing a kernel map
> 0d11fab32714a2da perf maps: Fixup maps_by_name when modifying maps_by_address
> f7a46e028c394cd4 perf machine: Fixup kernel maps ends after adding extra maps
> 25d9c0301d36f4d8 perf maps: Set the kmaps for newly created/added kernel maps
> 99deaf5578cd768f perf maps: Introduce map__set_kmap_maps() for kernel maps
> 74fb903b212925ca perf script: Fix output type for dynamically allocated core PMU's
> 957d194163bf983d perf bench: Fix perf bench syscall loop count
> b627b443ccfbdd2c perf test: Simplify data symbol test
> f04c7ef35256beea perf test: Add timeout to datasym workload
> 15bcfb96d0ddbc1b perf test: Add trace record and replay test
> 38672c5033c3aebc perf test: Skip perf trace tests when running as non-root
> 3fb29a7514e727ca perf test: Skip perf probe tests when running as non-root
> ⬢ [acme@toolbox perf-tools-next]$
> 
> I.e. perf, followed by the tool or class (machine, maps, etc), followed
> by : and then the summary, starting with a capital letter.

Yep, I can fix them this time but please follow the convention next
time.

> 
> I retested and everything looks great, so please add my:
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for the review!
Namhyung

> 
> >  tools/perf/util/compress.h   |  20 +++++++
> >  tools/perf/util/dso.c        |   3 +
> >  tools/perf/util/dso.h        |   1 +
> >  tools/perf/util/lzma.c       |  29 ++++++----
> >  tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/symbol.c     |   2 +
> >  6 files changed, 148 insertions(+), 13 deletions(-)
> > 
> > -- 
> > 2.43.5

