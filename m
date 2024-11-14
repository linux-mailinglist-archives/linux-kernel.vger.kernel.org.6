Return-Path: <linux-kernel+bounces-409890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391C9C92EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3BA1F222B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408A1AA7B4;
	Thu, 14 Nov 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx+hSU9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AFEEDE;
	Thu, 14 Nov 2024 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614961; cv=none; b=MOrdBl/FLnfJs+XY+rtwFt97qc1pROOJSmHf+lZw4Uak5pQIL1DFcz/cSWxW0Y/MpMKGslRkxrQMRwbjtZdfvtXeFJ01MWL+bKB8qDgP3ZqRyG0anWyYaLRzxudiFR8izBBIIuNjcpXik5Nf7BSDrWJxJJQ66QmPxjd93oqwD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614961; c=relaxed/simple;
	bh=Fr1kftOxCiTzCVhmAtoA5Ndc4mJc/APKukxNFg7ESl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in4GGJNMTaOW6WSG0EYjUEOFB/vjkKB/NdtNsBupHogOj8vdSCdXIDHbdGLLDUKwgH3ru3HpZLUTxH7P4ljcvA/VjX44uAnTQL7BHOkrkLNakJByWS7wahwi/Pc3m8I7z1C3dQ8+jYtOW75xHH1fJZwQuG8Ua0IWJDE81sXOy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx+hSU9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95667C4CECD;
	Thu, 14 Nov 2024 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614961;
	bh=Fr1kftOxCiTzCVhmAtoA5Ndc4mJc/APKukxNFg7ESl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx+hSU9VU6DYcegaoErvLryi88hb3EMLAkOm+LwP6n2ho8navUxUkzUdnqj98GSZP
	 0HExCleRJ4Ni+bVsBM5LCN7aZNxli/+rNlxmxMDLyLXAq1CwWYmCdJJFwFv2QtHV8q
	 0Tmk+/L6qer5CjTbWaL45NJK4q76HuoG/7AJEPk/wIQ3N3xb+7xuNsSVmH0VqlsIfn
	 n6rXMwGwPzd9C0c7R9gmQjb+5hCTjZRq5yLfuI/olCyAK5UJEiLpAlrDsjxfTmfGuw
	 XPjpPLPktUszZ9LiFbHctMHdPoG0JJMhZ2UiQ5SnMNZUbVCWckN89xut99RBlv950Q
	 tKBFJH8ntfWSg==
Date: Thu, 14 Nov 2024 17:09:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
Message-ID: <ZzZY7U0AFk3245vy@x1>
References: <20241106234518.115234-1-benjamin@engflow.com>
 <20241106234518.115234-2-benjamin@engflow.com>
 <ZzY1bPtoyRH-nRIV@x1>
 <ZzY20vZluj44w1Gt@x1>
 <CAEmfU+v8KR3Bd8w7kOX6ScGig106zh5gW9P5fwAw-BF3tmAp7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmfU+v8KR3Bd8w7kOX6ScGig106zh5gW9P5fwAw-BF3tmAp7A@mail.gmail.com>

On Thu, Nov 14, 2024 at 09:44:56AM -0800, Benjamin Peterson wrote:
> > On Thu, Nov 14, 2024 at 02:37:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
> > index 8b70324bc5b4fb4c..c37ed6bb9f7e8fab 100755
> > --- a/tools/perf/tests/shell/trace_exit_race.sh
> > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > @@ -12,10 +12,10 @@
> >  skip_if_no_perf_trace || exit 2

> >  trace_shutdown_race() {
> > -       for i in $(seq 100); do
> > +       for _ in $(seq 100); do
> >                 perf trace -e syscalls:sys_enter_exit_group true 2>>$file
> >         done
> > -       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$" $file) = "100" ]
> > +       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "100" ]
> >  }
 
> This all looks okay.

The test is failing for me as there is garbage in the output of perf
trace even with Namhyung having already applied your previous patch:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline --author benjamin@engflow.com
12bd434f68ea45c7 (HEAD -> perf-tools-next) perf tests: Add test for 'perf trace' output loss
efbcd2cd7eac10a9 perf trace: Do not lose last events in a race
5fb8e56542a3cf46 (perf-tools-next/tmp.perf-tools-next) perf trace: avoid garbage when not printing a trace event's arguments
⬢ [acme@toolbox perf-tools-next]$

root@number:~# perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1982428 syscalls:sys_enter_exit_group( k?m)
root@number:~# perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1982430 syscalls:sys_enter_exit_group()
root@number:~# perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1982432 syscalls:sys_enter_exit_group()
root@number:~# perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1982434 syscalls:sys_enter_exit_group()
root@number:~# perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1982437 syscalls:sys_enter_exit_group( k�)
root@number:~# perf trace -e syscalls:sys_enter_exit_group true
     0.000 true/1982439 syscalls:sys_enter_exit_group(, loads 8��1)
root@number:~#

So we don't _miss_ the events, which I was noticing and brought me to
test your latest 2 patches, which I applied and added a Tested-by, now
tryint to figure out this garbage...

- Arnaldo

