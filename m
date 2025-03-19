Return-Path: <linux-kernel+bounces-568897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9EAA69BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D9619C4875
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE16E217F5C;
	Wed, 19 Mar 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT8fTloY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261A7E1;
	Wed, 19 Mar 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422024; cv=none; b=Esscy7Aoj3AUWSZ0emPVrL+5dBRPPuZnynk4wQ+Uy9cta9nXReKrdorb8+Izz7AW5N7wB+p5fLfm1MOx5uWtMkRBPfw2kU1dQeB1OxzNPly33ifst0ThJYVe5BQiG0K2KPXTPlhH6fAEpY9tv2TbM52+H0QfK5o1HtGH6/RKNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422024; c=relaxed/simple;
	bh=kmh/hAovTpQ+Y4EsMHbXdMfe/ivjjIw0whfEgG4BHXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc0uRxSSkiG9YjdiTzvUu8N0Y5hG8lEFfzfMRVln7UWbkDQqhfmarKLFjoRyhvX/kr6VOfFQuoqAp0m9AigBV3DC6GprIeKF/lj/D8fUziDTLMiWmI/ezZ96CnUwynSqlApxeCoyIBWECQ/Zcw6k/s/6gjdn5ipxMgoIh7a1dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT8fTloY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9DCC4CEE4;
	Wed, 19 Mar 2025 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742422023;
	bh=kmh/hAovTpQ+Y4EsMHbXdMfe/ivjjIw0whfEgG4BHXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XT8fTloYdVTM53YryP55n3LufVmhdEWOI4+bR30xzGorXR8Qnjj4CUILj8pgGVKoX
	 FA7J/XK0Om4fH5bZkvjvcPpOOZdqoidQWmK1nRlRWt6MH1yCudpYkS4T947gIoKO3g
	 t+GH740bpidSLx4u0HA5XU0QoAr/jCS1GivpvhSkOew2grWDEp3FsilBMI8yIMfGE5
	 HM3glQa0SSCI5RY7ghBNoZMEwbhaoYq23PkgIIIzShAeMAtwieVc53y+Bt/vBynPkq
	 3VmjcxnAbXOuYCdYkkd6beZLFwjKHWGvPuFQuxoC4FA3NxbzmzZQGSW8nTX3ExQHcT
	 R7O9AeBBXV5lw==
Date: Wed, 19 Mar 2025 15:07:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v2] perf trace: Implement syscall summary in BPF
Message-ID: <Z9tABRzmYYYUyEFO@google.com>
References: <20250317180834.1862079-1-namhyung@kernel.org>
 <CAH0uvogx1-oz4ZjLpcTRArTb2YJOyY1h1pccMXYSgCnHYD9bPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH0uvogx1-oz4ZjLpcTRArTb2YJOyY1h1pccMXYSgCnHYD9bPA@mail.gmail.com>

Hello Howard,

On Wed, Mar 19, 2025 at 12:00:10PM -0700, Howard Chu wrote:
> Hello Namhyung,
> 
> Can you please rebase it? I cannot apply it, getting:
> 
> perf $ git apply --reject --whitespace=fix
> ./v2_20250317_namhyung_perf_trace_implement_syscall_summary_in_bpf.mbx
> Checking patch tools/perf/Documentation/perf-trace.txt...
> Checking patch tools/perf/Makefile.perf...
> Hunk #1 succeeded at 1198 (offset -8 lines).
> Checking patch tools/perf/builtin-trace.c...
> error: while searching for:
>         bool       hexret;
> };
> 
> enum summary_mode {
>         SUMMARY__NONE = 0,
>         SUMMARY__BY_TOTAL,
>         SUMMARY__BY_THREAD,
> };
> 
> struct trace {
>         struct perf_tool        tool;
>         struct {
> 
> error: patch failed: tools/perf/builtin-trace.c:140

Oops, I think I forgot to say it's on top of Ian's change.
Please try this first.  Sorry for the confusion.

https://lore.kernel.org/r/20250319050741.269828-1-irogers@google.com

Thanks,
Namhyung


