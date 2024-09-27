Return-Path: <linux-kernel+bounces-342129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE9988AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EBF1C22CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAEC1C2DB5;
	Fri, 27 Sep 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jl0g8Vz+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4713BAE2
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466655; cv=none; b=cuOKMhz+t4MR7C7nrkrXmbwNC+++Tso8nYMeJd9e4BHs/VNXx2oWhzTJNNf0LF/1NwhGYMKqudPiQziVx3vaX77c2BIvv191t/jx4aakAF/IDBuuqt3otDl0A/T98Z/CsJowVkob9nR2i38NILvlK2FgbW/zGvE11D0ZE5YMDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466655; c=relaxed/simple;
	bh=K8q9IXe8qIpviHcOuGYp515Mdl6owfhbVqnML6iwuaI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Z3yApyTCvgN/74fiCQhyoP8BA7FYKq52JCOndBum2ilAiuomF62tAz5t4m1QIHJtUKsmjsc7o83wZSH9mOckdBy7ZrLcvMWTM/hsuds+voZzfF3CG6ScBCtz2P3dY3coHwAgJctBcH9Y1IRZTOUh0eWDXkhdTCwJvtOAoacr5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jl0g8Vz+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=SSSBP/b3nCsMC3CL687Z1QQwJNwcB3hiCtNug+UhlAU=; b=Jl0g8Vz+g8Bwg/dQ+k/jrkLVDK
	CQS7h42THZD/ibBZHJn6J2pPFRfWmlPgzW2C2VxuOVbQhGWbcvD+JaCMBuqJXtUdV/QA7DOFhOL2R
	9M35gN80mKhCNedZEMlV5H8rmHoM+0SYcs2Zf6Q/Xk2Gf2NuMfZ3hkMpsPL7b8xhVgF9ZOjmzyIaf
	o0un1xGG59iwfHU5eAAD4Imi399IVeMETTk5i3i7B6qAMPLAHutKCrTe3brkNubYzDZNaK06W23z9
	iJf806RiLPiC+3PA0/3HMYyGOtfQzeLoB+tJGljKbpJYHv0JQKRGjidgfhD87eMxfsW43LpXwtUl2
	ImzitelQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-0000000AVct-0mYP;
	Fri, 27 Sep 2024 19:50:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BAEE130119B; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194924.839606244@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 05/14] objtool: Rename the skylake hack to --direct-call
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to use the .call_sites and .tail_call_sites sections beyond the
call-depth-tracking skylake thing, give it a more generic name.

Specifically it will be used to 'relink' all direct calls to avoid ENDBR.

A compiler could only hope to do this using an LTO pass, and even then the
dynamic linker would need to get involved.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.lib                    |    2 +-
 tools/objtool/builtin-check.c           |    8 ++------
 tools/objtool/check.c                   |   18 +++++++++---------
 tools/objtool/include/objtool/builtin.h |    2 +-
 4 files changed, 13 insertions(+), 17 deletions(-)

--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -267,7 +267,7 @@ objtool := $(objtree)/tools/objtool/objt
 
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
-objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
+objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --direct-call
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
 objtool-args-$(CONFIG_FINEIBT)				+= --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -57,17 +57,13 @@ static int parse_hacks(const struct opti
 		found = true;
 	}
 
-	if (!str || strstr(str, "skylake")) {
-		opts.hack_skylake = true;
-		found = true;
-	}
-
 	return found ? 0 : -1;
 }
 
 static const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
-	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_BOOLEAN(0,   "direct-call", &opts.direct_call, "annotate direct calls"),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4838,16 +4838,16 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+	}
 
-		if (opts.hack_skylake) {
-			ret = create_direct_call_sections(file);
-			if (ret < 0)
-				goto out;
-			ret = create_direct_tail_call_sections(file);
-			if (ret < 0)
-				goto out;
-			warnings += ret;
-		}
+	if (opts.direct_call) {
+		ret = create_direct_call_sections(file);
+		if (ret < 0)
+			goto out;
+		ret = create_direct_tail_call_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.mcount) {
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -12,7 +12,7 @@ struct opts {
 	bool dump_orc;
 	bool hack_jump_label;
 	bool hack_noinstr;
-	bool hack_skylake;
+	bool direct_call;
 	bool ibt;
 	bool mcount;
 	bool noinstr;



