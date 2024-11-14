Return-Path: <linux-kernel+bounces-409882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D589C92DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14431F2362D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB301A9B5D;
	Thu, 14 Nov 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbzswBpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA01A38E3;
	Thu, 14 Nov 2024 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614624; cv=none; b=VPi58cAomZjvmjUqi9A4riLEyLglezbBtvGCjv0rdRPRDo24dhixBi/sO+KmaljX8zNY/4e7kqWdgZLvwV/dhWfLsthLsPNCzZ6riD4Aa9c7Wq10uqyZucBjcoaKi2mS4x3EYIUweUNM06pJyQDl1vdmZGDX0oISa505P48pszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614624; c=relaxed/simple;
	bh=PA0F2kpO5gQp35yrtbIO1CSen39ZwxW00f7C8QKcD70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um41l2I1LfGtSj9upPtjA5s4ZTWfkllBfRbOeTIlB5OVu/tF/3iKAXJ7WZ4J+jR8Qki5bMJvEMj8GGeZ7Atx0HhOLnTq1n6XbnQKBiV8fQTxt2iZRc+Gj9s1sshpgZzz9COehxQGztAVr3A/M1tRjMIjDqFdyXJU0HRYhTnMjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbzswBpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DB3C4CECD;
	Thu, 14 Nov 2024 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614623;
	bh=PA0F2kpO5gQp35yrtbIO1CSen39ZwxW00f7C8QKcD70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbzswBpIgXd2FH7CAGIOq4YGdtO/9v6QhnpaquVHdtXLMgVX3lKVhOyWPDFeonfoC
	 W7NilIIsyNpASdSGt6wIxS36aqphekJcuVdxkNvUWaOiChJtjmvF50kaZR43h4QDVQ
	 +boiAUyrGK99fa9p+iS0vtOql8Tnf9zWoFuSSIohv656YSkmYiR42kNVpVAAaU1UFE
	 gSBmxYBihkWh90/GJd3Tgb2NHYEPm8mL90ZN5E4n656r/ZmsjsNhwQkxz0MnP850cF
	 vVm266Ung2IXShB+SqPBIRx2OC3cEF1gio9af0bWhQWymzPSQicazLKklJ7tOP+3pw
	 P7KAyXStKbbtg==
Date: Thu, 14 Nov 2024 17:03:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Fix perf trace tracing itself, creating
 feedback loops
Message-ID: <ZzZXnC9wdyFfihVn@x1>
References: <20241030052431.2220130-1-howardchu95@gmail.com>
 <ZzOLU-9QkwGHsb3w@x1>
 <ZzY57jorg1wScxq5@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzY57jorg1wScxq5@x1>

On Thu, Nov 14, 2024 at 02:57:02PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 12, 2024 at 02:07:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Oct 29, 2024 at 10:24:31PM -0700, Howard Chu wrote:
> > > There exists a pids_filtered map in augmented_raw_syscalls.bpf.c that
> > > ceases to provide functionality after the BPF skeleton migration:
> > > commit 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skeleton")
> > 
> > Thanks, applied to perf-tools-next,
> 
> There is a problem with this patch, I'm investigating it now:
> 
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> perf: Segmentation fault
> Obtained 12 stack frames.
> perf() [0x6229a1]
> perf() [0x622a8b]
> /lib64/libc.so.6(+0x40d00) [0x7f704364fd00]
> perf() [0x4b5f2e]
> perf() [0x4ba3e6]
> perf() [0x4c03bc]
> perf() [0x4c0663]
> perf() [0x4c07bc]
> perf() [0x4c0b05]
> /lib64/libc.so.6(+0x2a088) [0x7f7043639088]
> /lib64/libc.so.6(__libc_start_main+0x8b) [0x7f704363914b]
> perf() [0x412265]
> Segmentation fault (core dumped)
> root@number:~#
> 
> (gdb) run trace -e syscalls:sys_enter_exit_group true
> Starting program: /root/bin/perf trace -e syscalls:sys_enter_exit_group true
> 
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 1965197]
> 
> Program received signal SIGSEGV, Segmentation fault.
> trace__run (trace=0x7fffffffa5e0, argc=1, argv=0x7fffffffde90) at builtin-trace.c:4330
> 4330		trace->filter_pids.map = trace->skel->maps.pids_filtered;
> (gdb) bt
> #0  trace__run (trace=0x7fffffffa5e0, argc=1, argv=0x7fffffffde90) at builtin-trace.c:4330
> #1  0x00000000004ba3e6 in cmd_trace (argc=1, argv=0x7fffffffde90) at builtin-trace.c:5490
> #2  0x00000000004c03bc in run_builtin (p=0xec4068 <commands+648>, argc=4, argv=0x7fffffffde90) at perf.c:351
> #3  0x00000000004c0663 in handle_internal_command (argc=4, argv=0x7fffffffde90) at perf.c:404
> #4  0x00000000004c07bc in run_argv (argcp=0x7fffffffdc7c, argv=0x7fffffffdc70) at perf.c:448
> #5  0x00000000004c0b05 in main (argc=4, argv=0x7fffffffde90) at perf.c:560
> (gdb) p trace->skel
> $1 = (struct augmented_raw_syscalls_bpf *) 0x0
> (gdb)
> 
> I.e. when we specify a syscall event tracepoint, we expect to use
> augmentation, but are not setting it up.

We can't assume that trace->skel will be always set, as it is only
initialized if trace->trace_syscalls is set, so I added this patch on
top of yours:

⬢ [acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0f8678142fbfdbcb..14794725669d49ee 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4327,7 +4327,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
                }
        }
 
-       trace->filter_pids.map = trace->skel->maps.pids_filtered;
+       if (trace->skel)
+               trace->filter_pids.map = trace->skel->maps.pids_filtered;
 #endif
        err = trace__set_filter_pids(trace);
        if (err < 0)

