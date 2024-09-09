Return-Path: <linux-kernel+bounces-322042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA3972342
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0744B2309B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1418A6BE;
	Mon,  9 Sep 2024 20:08:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B94189F39
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912508; cv=none; b=jYCkg0EDaT4hF/45CLcxk6yJTa1GkzemGuxPElFp3p4j+DNm34OipBoW9Ixm+5zoR5aAjjpWsT2EBwzebuOz/uucQdomIIfL3lx4Ln0apT+d1yi7fuJgJqGmvVjw+Gf982abOhFd1MK0k5M6ElpS3c6D1vTs5+yuS/nP44oQayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912508; c=relaxed/simple;
	bh=OFjgyyRprw/ih+C+zV6y2ZtnnjCrHiQhxZyG+W+mYNw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rd6Rb349N26uP2lCAPmjND5pCywtQcly+A4pgB5uBGAf4rNFtVryChl7h+eKA5GIZmktrCu3ldDOOZ5mueWMF6RBEoHqmSRcVpsR5P/1g97zcOohm7+FB9SVjLFzyaqHTibo2qVP1fgHIjWSbfvxfmBkayLm7I1N4HQqWCCZc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80337C4CEC8;
	Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1snkgW-000000009r2-0qgX;
	Mon, 09 Sep 2024 16:08:28 -0400
Message-ID: <20240909200828.062668680@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 09 Sep 2024 16:07:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [for-linus][PATCH 2/2] tracing: Drop unused helper function to fix the build
References: <20240909200747.898018585@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A helper function defined but not used. This, in particular,
prevents kernel builds with clang, `make W=1` and CONFIG_WERROR=y:

kernel/trace/trace.c:2229:19: error: unused function 'run_tracer_selftest' [-Werror,-Wunused-function]
 2229 | static inline int run_tracer_selftest(struct tracer *type)
      |                   ^~~~~~~~~~~~~~~~~~~

Fix this by dropping unused functions.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/20240909105314.928302-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index edf6bc817aa1..c3b2c7dfadef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2226,10 +2226,6 @@ static __init int init_trace_selftests(void)
 }
 core_initcall(init_trace_selftests);
 #else
-static inline int run_tracer_selftest(struct tracer *type)
-{
-	return 0;
-}
 static inline int do_run_tracer_selftest(struct tracer *type)
 {
 	return 0;
-- 
2.45.2



