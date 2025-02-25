Return-Path: <linux-kernel+bounces-532210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA71A44A26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A799F188D5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3E1A8F95;
	Tue, 25 Feb 2025 18:20:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114619D886;
	Tue, 25 Feb 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507615; cv=none; b=BDnOJA55I5JGLVIeEm7Vpp+LFjElvoHhBiiifcwBfz+QuMJ2d1atKpQYncnOXMIBKccyEL4DV9g5SKpG5KK+Gj29j1XDllmih0ClM6WG3u8ooCVNKyrDwCSz/CI5j1f0Fjxhev+DqtGg7ruyvgZ2YarigRtuVUwz1Cld5WIKSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507615; c=relaxed/simple;
	bh=2YKOghZ86hQATb80S+0y70FRgLQaXaEINmhPfDP613Q=;
	h=Message-ID:Date:From:To:Cc:Subject; b=TuWvOBY2VsGG5GmBtXRwBIgqAKaSodOWqDuKphpRGeEbfiXhBQnGb+3Sa2csRqBwJaMkEmNyKFLpkduPyw7CRCqK2eAhst5KstvNG9ebloqDt9u4T2v1LaZtSGFeAcozJJWOmAx5sn57AfCKJIvfO46PL+zC3XmPSVePp5a1/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6936EC4CEE2;
	Tue, 25 Feb 2025 18:20:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tmzY6-000000095XP-15hU;
	Tue, 25 Feb 2025 13:20:54 -0500
Message-ID: <20250225182004.473875894@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 13:20:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] scripts/sorttable: ftrace: Fix some bugs with sorttable and ARM 64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


A few bugs with ARM 64 has been reported with the removal of the unused
weak functions code.

One was that kaslr_offset() may not be defined by all architectures and
it's reference would cause the build to fail. This was fixed by removing
the kaslr_offset() to check valid mcount_loc addresses and use the
is_kernel_text() instead.

Another was that clang doesn't do the trick of storing the mcount_loc
addresses in the Elf_Rela sections like gcc does. Clang does it like
other achitectures do. To handle this, the Elf_Rela is first used
but no functions were found there, it then falls back to the same
code that all the other architectures use.

When reading the mcount_loc and creating the ftrace descriptors, the
architecture specific function ftrace_call_addr() is called on the
address from the mcount_loc. But because the unused weak functions were
zeroed out, but KASLR can still modify them, it can make the address
invalid. The ftrace_call_addr() from ARM 64 will crash if the address
passed in is invalid. Have the valid tests done before calling that
function.

On bug that was found while debugging this but was not reported was that
the test against the nm output to determine if a function is an unused
weak function or not was triggering false postives for all functions.
That's because the address in mcount_loc for ARM 64 is just before
the function entry. The check against nm would see if the address was
within the function text, but 8 bytes before is not in the function text
and this would cause all the functions to be considered unused weak
functions and there would be no function left to trace.

Steven Rostedt (4):
      ftrace: Test mcount_loc addr before calling ftrace_call_addr()
      ftrace: Check against is_kernel_text() instead of kaslr_offset()
      scripts/sorttable: Use normal sort if there's no relocs in the mcount section
      scripts/sorttable: Allow matches to functions before function entry

----
 kernel/trace/ftrace.c | 23 +++++++++++++++++------
 scripts/sorttable.c   | 16 +++++++++++++---
 2 files changed, 30 insertions(+), 9 deletions(-)

