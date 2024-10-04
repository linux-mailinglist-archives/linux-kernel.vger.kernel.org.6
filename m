Return-Path: <linux-kernel+bounces-350425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 536309904FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD744B21AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06896215F5F;
	Fri,  4 Oct 2024 13:56:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF12139A7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=rqsmiiOqTgEY3ITULHaE+a3tSiObP7Ncq71xCSuYqxG39D6dDpfaUV+qmOK75NtfaONKXXyxWncowQuEle61xSHM+PPNUxC+i+6pHyzY6RsPyiIwdgVHMGKvFu8+kkX44ldSEv1/+WYBbexkfhqMQmG0YO+q3JJ7LmJiR7Ott0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=W5gg0bmYi+cHGHIRHDi7OUpL3uRLaizOzsk2Cu9nxag=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=neKGSdKBzSTtY46/IxZ+arlmHLlzaDWn8aIF2IeqenFbNtCheQ+NrfE/gCZ7yXRLw1b4Ifsb2UQ4PVmF+nc9NL2qb537S/O5O7qM0QWZR1fbWxGyljgWh/t2lIBNQp9B61NyevBJMEbvKv+pcz39kHbvIYlX4RUH0DhydMk2/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12DC4CED2;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio7-00000005C9Y-3Gia;
	Fri, 04 Oct 2024 09:57:23 -0400
Message-ID: <20241004135723.638567806@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:56:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>
Subject: [for-linus][PATCH 4/8] x86/ftrace: Include <asm/ptrace.h>
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sami Tolvanen <samitolvanen@google.com>

<asm/ftrace.h> uses struct pt_regs in several places. Include
<asm/ptrace.h> to ensure it's visible. This is needed to make sure
object files that only include <asm/asm-prototypes.h> compile.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/20240916221557.846853-2-samitolvanen@google.com
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/ftrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0152a81d9b4a..b4d719de2c84 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_FTRACE_H
 #define _ASM_X86_FTRACE_H
 
+#include <asm/ptrace.h>
+
 #ifdef CONFIG_FUNCTION_TRACER
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?
-- 
2.45.2



