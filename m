Return-Path: <linux-kernel+bounces-178022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D688C478F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A405D2822C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C0762E8;
	Mon, 13 May 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fCRZUQ5W"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC80757FB;
	Mon, 13 May 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628861; cv=none; b=ic0KIjN2lonL599WKf/gHk4MohxEfnlEn2frSH59ZAAuLawRBPoCTQfdJj+TE2dn9BRroW3wXZjUsEv16He7D/ikngaeDPEH2k6GwcXriCGcq+md011GzXWL7ZiroRH+8Sh6MLIFLiJxnDulPsyI1LnzV0Hkl0gAgGmV+ogaA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628861; c=relaxed/simple;
	bh=dJoqXVo0Q7zv+qowijfqNrjP7/+VXrBVxDoC8oO2fvQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=noPaNyx2c9J8qi86GhmudcBrvoM5ohcRFvnlwAAguw5w3h/zJtyWwNor2NFe9DKS38RrxE183w5h+HbdAkXGXO8jSkZikZTVuw55/5vXsBu8ZvhbOB3+788YSWUx+oN8VR9JHHNYLf7MTZY3S1zzMABOrep+2CvBQpxA/lXoNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fCRZUQ5W; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1715628850;
	bh=dJoqXVo0Q7zv+qowijfqNrjP7/+VXrBVxDoC8oO2fvQ=;
	h=Date:From:To:Subject:From;
	b=fCRZUQ5WEAZkpJz/zb3JRy4mJtYCeOjh9Shw4NN/hVzV3UalMy3qYdR6Tq5n7fgJS
	 K/ewV60dIJhut9kIrR+j1vPsI0O0g9OyTr+ftmGUgVooc8MbyXo5UaJfjk0QJjuo8S
	 9gPPzyP3RY9D4BJBdNTbf5ZagvMmmAh6YG1cn8v07l41AdC7UfUcxLK0GoJ0LDNXAw
	 YBsgImy/M+4Z8NBFVGYrtEZMpnfwtLd5/B93p3sewovnFuBWdrSqbi0cqf7zispQxV
	 VlWQs6iSYye+BPt8d0UA4SjcN+O+Mfky5FDgsyRu79L5rVzzlhaUtoCvgCF5FlKDzX
	 TpqFUpsL5/vrQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VdV6V5dydz109Z;
	Mon, 13 May 2024 15:34:10 -0400 (EDT)
Message-ID: <5c0e0cc3-b849-400c-90eb-2b7d115d2f66@efficios.com>
Date: Mon, 13 May 2024 15:34:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RELEASE] LTTng-modules 2.13.13 and 2.12.17 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a stable release announcement for the LTTng kernel tracer,
an out-of-tree kernel tracer for the Linux kernel.

The LTTng project provides low-overhead, correlated userspace and
kernel tracing on Linux. Its use of the Common Trace Format and a
flexible control interface allows it to fulfill various workloads.

* New in these releases:

- LTTng-modules 2.13.13:

   - Introduce support for Linux v6.9.

   - Removed unused duplicated code, add missing static to
     function definitions, and add missing includes for function
     declarations which were observed when building against recent
     kernels with newer toolchains.
     We plan to adapt our CI to add jobs that will report warnings
     as errors when building lttng-modules against recent kernels
     with a recent tool chain so we can catch and fix those warnings
     earlier in the future.

- In both LTTng-modules 2.12.17 and 2.13.13:

   - Fix incorrect get_pfnblock_flags_mask prototype which did not match
     upstream after upstream commit 535b81e209219 (v5.9). Fix the prototype
     mismatch detection code as well. This affects the event
     mm_page_alloc_extfrag which uses get_pageblock_migratetype(). Note that
     because the kernel macro get_pageblock_migratetype was also updated
     to pass 3 parameters to get_pfnblock_flags_mask as its kernel prototype
     was updated to expect three parameters, it does not matter that the
     lttng-modules wrapper expects 4 parameters and provides those 4 parameters
     to the kernel function. This issue should therefore not affect the
     runtime behavior.

   - Instrumentation updates to support EL 8.4+.

   - Instrumentation updates for RHEL kernels.

   - Instrumentation updates to the timer subsystem to adapt to
     changes backported in the 4.19 stable kernels.


* Detailed change logs:

2024-05-13 (National Leprechaun Day) LTTng modules 2.13.13
         * splice wrapper: Fix missing declaration
         * page alloc wrapper: Fix get_pfnblock_flags_mask prototype
         * lttng probe: include events-internal.h
         * syscalls: Remove unused duplicated code
         * statedump: Add missing events-internal.h include
         * lttng-events: Add missing static
         * event notifier: Add missing static
         * context callstack: Add missing static
         * lttng-clock: Add missing lttng/events-internal.h include
         * lttng-calibrate: Add missing static and include
         * lttng-bytecode: Remove dead code
         * lttng-abi: Add missing static to function definitions
         * ring buffer: Add missing static to function definitions
         * blkdev wrapper: Fix constness warning
         * Fix: timer_expire_entry changed in 4.19.312
         * Fix: dev_base_lock removed in linux 6.9-rc1
         * Fix: mm_compaction_migratepages changed in linux 6.9-rc1
         * Fix: ASoC add component to set_bias_level events in linux 6.9-rc1
         * Fix: ASoC snd_doc_dapm on linux 6.9-rc1
         * Fix: build kvm probe on EL 8.4+
         * Fix: support ext4_journal_start on EL 8.4+
         * Fix: correct RHEL range for kmem_cache_free define

2024-05-13 (National Leprechaun Day) 2.12.17
         * page alloc wrapper: Fix get_pfnblock_flags_mask prototype
         * Fix: timer_expire_entry changed in 4.19.312
         * Fix: build kvm probe on EL 8.4+
         * Fix: support ext4_journal_start on EL 8.4+
         * Fix: correct RHEL range for kmem_cache_free define

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

