Return-Path: <linux-kernel+bounces-562021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED779A61A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB313BF44A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D0020966B;
	Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMbEp98+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1D2066FD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980570; cv=none; b=Joj1KzB/q1kpVoDv3QcFj/aI7Q9Y4lFkn5ULO9pO4R8/enkXs+CGOZQ0UMRUYsuCPy3ZXqsBLWkCKT6dg1o/68uUyJszONB5O77yDsSXro4ChwPoX5NB6R7pV6PhiYMHA+8F4TDiyEGcZHDhXEHPfaPmqjQOf7aKsxLs8RGUbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980570; c=relaxed/simple;
	bh=2l2pCAvHR0xBSXF7mla1gKooALwHNfcFtf5TIztVWEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdbnvMReGbAQPfjGDaIMxUc3NOEPt+6LgNIHAnylDlhE5j6ES9E+C0LnltueOjvxplPoJu+ltVJkOCHxngHKaYiur6msd1uf19RNhVE66ghG/G3fnRBpCdP/CQE1bkrEaryCNdeWarEqdZND/tGJX9yRV/Lp72p5PY87W5vq1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMbEp98+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FECDC4CEEC;
	Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980569;
	bh=2l2pCAvHR0xBSXF7mla1gKooALwHNfcFtf5TIztVWEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMbEp98+EagkgEr8i8/CL6AvxLLjK+BAxL+Q3kPPc1rmqflMl7KY9H6VvaO6/EDwl
	 Hzxj6KsLk5/fBHuLYuIpT3mwHP+OdHK+XThGgac2vedk5SaSBRgvVYDpLQpsCnSkVF
	 Aqr/AUwxkNzW6CigSWmYGSRTtD85MYKplFv8q/PdpSK7WGFdn0IRIWf/xlug+XV+7x
	 qY7vsrBoAirX0gkzLiA+/25yK9ZNXllpkYe2nkJhIRQpr5OS2KEpAibjVJFkAvbZWT
	 U5hnJYz9cE2ob5OyZko/bUBQJSXGc1qus/Yrfe74R4HZgxtU1/7avLX0o2WnlECoJJ
	 OUaC4tFAXd/Xw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 03/13] objtool: Improve __noreturn annotation warning
Date: Fri, 14 Mar 2025 12:29:01 -0700
Message-ID: <ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify what needs to be done to resolve the missing __noreturn warning.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt | 12 +++++-------
 tools/objtool/check.c                   |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c3ee959b63c..87950a7aaa17 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -319,14 +319,12 @@ the objtool maintainers.
    a just a bad person, you can tell objtool to ignore it.  See the
    "Adding exceptions" section below.
 
-   If it's not actually in a callable function (e.g. kernel entry code),
-   change ENDPROC to END.
+3. file.o: warning: objtool: foo+0x48c: bar() missing __noreturn in .c/.h or NORETURN() in noreturns.h
 
-3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
-
-   The call from foo() to bar() doesn't return, but bar() is missing the
-   __noreturn annotation.  NOTE: In addition to annotating the function
-   with __noreturn, please also add it to tools/objtool/noreturns.h.
+   The call from foo() to bar() doesn't return, but bar() is incorrectly
+   annotated.  A noreturn function must be marked __noreturn in both its
+   declaration and its definition, and must have a NORETURN() annotation
+   in tools/objtool/noreturns.h.
 
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2b5249af7b0f..6b9ad3afe389 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4458,7 +4458,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
 			if (call_dest) {
-				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
+				WARN_INSN(insn, "%s() missing __noreturn in .c/.h or NORETURN() in noreturns.h",
 					  call_dest->name);
 				warnings++;
 				continue;
-- 
2.48.1


