Return-Path: <linux-kernel+bounces-334201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A897D3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212F81F24414
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE913AD29;
	Fri, 20 Sep 2024 09:43:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7414290;
	Fri, 20 Sep 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825416; cv=none; b=cQ1/VSHaWYG43uVGXMCZvPzOiiLZm+Ke4YX2gFimPRzzuIv0qG/wMrBq2hw0rb+XTW+0NeXUDGcMieJlrRFI4DXh730I0WcDAi3CWJhKX9bt4ihkBtQeS+OuHVqOiAKmKVYPzWumJaXv5zCnWD37IF8yDcWYoFLNrkIUtXyJLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825416; c=relaxed/simple;
	bh=64cYJJdaqah4X3XpaYTTjrMIdyGQS16vnN3+z5o7rdo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IUKZX/ZGZPZT3Db8ytqI82nO9Hok0pRUUsk1HIwS4R4WF06p8ajorz9KbX16e+FobonqnLo4eSmG35qJjaOhQXdz4u3F98igY/Wz2RLzMfDsLFF88KpnnsH14oqE2bO/oGwRXIRJBol/NFrJvXtimUPCtgiG9Iv2eOwjMpTew1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 059961007;
	Fri, 20 Sep 2024 02:44:03 -0700 (PDT)
Received: from [192.168.89.238] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAB5A3F66E;
	Fri, 20 Sep 2024 02:43:32 -0700 (PDT)
Message-ID: <e5149343-5a0f-4947-97ec-a61b741fadad@arm.com>
Date: Fri, 20 Sep 2024 10:43:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
From: Douglas Raillard <douglas.raillard@arm.com>
Subject: [ANNOUNCE] Rust libtraceevent/trace-cmd report
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As promised during 2022 tracing summit to Steven Rostedt and after a few months
of dogfooding, we are pleased to announce the Rust libtraceevent and trace-cmd
report counterpart, plus parquet conversion.

https://gitlab.arm.com/tooling/lisa/-/tree/main/tools/trace-parser

git clone https://git.gitlab.arm.com/tooling/lisa.git --depth=1

trace-tools
===========

CLI utility akin to trace-cmd report. Bear in mind that this is intended to be
an internal utility for LISA's Trace() Python API. As such, the CLI itself is
unstable (but that could change if people express interest).

You can test it very easily on your trace using the precompiled binary shipped in the repo:

# Human readable dump like trace-cmd report. The output should be almost
# identical.
tools/x86_64/trace-dump human-readable --trace-format tracedat --trace doc/traces/trace.dat

# Convert the trace into a bunch of parquet files, one per event. This is used
# by LISA internally to expose the trace as a set of polars/pandas dataframes.
# You could use that with e.g. duckdb and SQL for a no-Python experience (a bit
# like perfetto trace processor but on trace.dat, faster and more memory
# efficient).
tools/x86_64/trace-dump parquet --trace-format tracedat --trace doc/traces/trace.dat

# Show the content of the header and check that event formats can be parsed
# successfully.
tools/x86_64/trace-dump check-header --trace-format tracedat --trace doc/traces/trace.dat

Notable aspects:

- Handles traces larger than memory, including in parquet conversion which
   streams.

- Significantly faster than trace-cmd report. Both were compiled as static
   binaries with musl libc which has a notoriously slow malloc() though, which
   may be a bit unfair to trace-cmd.


traceevent
==========

This is the library crate that implements something akin to C libtraceevent,
but also includes I/O and trace.dat parsing code. It supports:

- trace.dat v6

- trace.dat v7

- (almost?) all event formats that _can_ be supported

- Extension event format macro/functions parser and interpreter. This is not
   currently exposed publicly but it would be easy. This can provide support for
   any C function/macro the lib would not handle, including polymorphic ones
   like __builtin_choose_expr()

- Stream processing, the trace is never fully loaded in memory.

- As zero-copy and lazy as feasible. Events can be skipped based on just the ID
   without  any field decoding etc.

- Supports both in-memory and file-based data input.

- Guest/host VM features (e.g. timestamp synchro option) should be implemented
  but were never tested.


Future work
===========

- The naming of both the library and the tool are open to changes.

- Both crates really should land on crates.io one day, I need to sort that out.
   This should only be done after names are settled though.

- Lib crate API is not stable yet, consider this a 0.* version.

- Lib crate could grow public APIs to parse buffers, so it can be used for
   other formats than trace.dat like the C libtraceevent.

- Compile time: the C parser is using nom. This is _very_ closure-heavy code,
   which makes LLVM codegen take ages. I'm not sure how to fix that without
   changing the parser. I don't want to write a C parser ever again.

- Feedback welcome, the future is what we want it to be !


-- Douglas

