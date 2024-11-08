Return-Path: <linux-kernel+bounces-402485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 129FE9C284B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D051F22C64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58C2123F6;
	Fri,  8 Nov 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="do0jndcx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F72123D4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109587; cv=none; b=uXQFhNkn8oBThPEYL+Hp39Xuoz71TEYo3L2YuXYZir9LWfPN61dCrzQQL3wILbFyGTWl/rOX8SP9Xp0qcNPNb9d9wzaVmrM9lcvx++AUKzNYXgJ94t4XP2EtRPLxN1VpVv8PRBORac3CIfEqRPZB1/fbZM3WCcvERp5YShi8dCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109587; c=relaxed/simple;
	bh=EfyGlK3Kc+LIRlY26yFSzKi08ziN1UAhap7VSJOOiMc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jO+EAatYthFaUPWJ9IVfVjvcTXzry4MyOGiKAesuDoyl6HpNymNvyj91GjuZJmQk2nqQlkI2ypggFrRrKicGOPBY9YwuTYzqLO7ev8KhoTmZhs8X4joVpOfeDGQSl9uWTeymPsfzup+oDCQ9ILHnqDKa+RljmroLJd8w9RpR3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=do0jndcx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso41344347b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109584; x=1731714384; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8FG6zy5TUWlnq+xC0331u7ZC2AgCRZ0YVucMGPpFo=;
        b=do0jndcx6sqGaJ85dUb6HcY2JJoym9BBqDT++6kxJHJADAnUZtsBEiXjLMFcRObkuB
         ToM2tKmoN80E42wfFW97Q8Rb72GetvPscAH7EAE7IhhfqKg0ePTYqqOSzpz+yPWLh0eu
         O4Mk3Nn1N03n4WChnOQNir4OnYgytDgyoJRuVbtpA+YGWt2FBvhCku9zqgiBtnu0NVLR
         0a99JGWsEJAlHRUd0dHC2GJbagDOfhJfO3lxS8+fVziLYUJMcBXckGkjBSeh4Po8KXjB
         OUd3QsC6t/I6UvGTG5iWKA+eyWUnDyQ2jfeRanLNuaEOMC4jWUh6reSXX8DDZsdkrnAh
         b0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109584; x=1731714384;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8FG6zy5TUWlnq+xC0331u7ZC2AgCRZ0YVucMGPpFo=;
        b=J9d+xw8DKoHSZ53ZrABad3s4MpRUP6pcQblmbQfp7e7BJIRcng1E1fo1snlLAn86kC
         dQxRYgonaMLLeb76bnbE4K9hqYC0u+9VqRUpsCXRKdUlp9+wLn2npIdieF2rEBPv/Djv
         nk5eySXFYueLRE06jtdzHUFvRmtjbNykWh1rErbvF3x2KI0S4P7sF2g4wWU1xJFT/gtS
         qyG8n1YuyVZExrYhAYPqW1M2Cd7dJXRnlsW6OLMbKqYcAAq8gBn/Wl3Or1KfC44y70aN
         lRHz2AkNAgdEfruRkj0W57VFC/oJ83DJoxuXrcNluLwPTSaFiw0A+wgGZy0c7YG9GIHX
         DZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX67ThNI4XaC8GNXVqeuNjlsaVQ7Av/ejWaSTd4f5PBZeBZc0WSPJrDEEmfikU72KiCcZiIa4HFySv2xtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIPyyLWJIsCn6NdpD8TzXtIVLgv1NDnXrqVgqk4mIRz544wTo
	vedlS2u3QpaXmIy3PVy3JQ1p4D2uhIq4/jD+UpbQFeP9TejSFzwXujxGxlo9bOJc++aR2ubANhS
	49GbViA==
X-Google-Smtp-Source: AGHT+IHg4RSsHZd7KxofWdmf3WMrYAK9htxRk4zqCdhJjgG3IPf6PuCptYOSwoHmhhxh7CfReCPu0Lzm3Nqx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:200f:b0:6ea:34c3:742b with SMTP
 id 00721157ae682-6eaddfad76amr476327b3.6.1731109584191; Fri, 08 Nov 2024
 15:46:24 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:51 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 06/20] perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Pass a flags value as architectures like csky need the flags to
determine the ABI variant.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         |  3 ++-
 tools/perf/util/include/dwarf-regs.h | 11 ++++++-----
 tools/perf/util/probe-finder.c       | 13 +++++++------
 tools/perf/util/probe-finder.h       |  3 ++-
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 1321387f6948..86b3ef638fbb 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -29,7 +29,8 @@
 #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
 
 /* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
+const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
+			     unsigned int flags __maybe_unused)
 {
 	switch (machine) {
 	case EM_NONE:	/* Generic arch - use host arch */
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 3c3a908b9f36..0ef428d07bcc 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -90,12 +90,13 @@
 
 #ifdef HAVE_LIBDW_SUPPORT
 const char *get_arch_regstr(unsigned int n);
-/*
- * get_dwarf_regstr - Returns ftrace register string from DWARF regnum
- * n: DWARF register number
- * machine: ELF machine signature (EM_*)
+/**
+ * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
+ * @n: DWARF register number.
+ * @machine: ELF machine signature (EM_*).
+ * @flags: ELF flags for things like ABI differences.
  */
-const char *get_dwarf_regstr(unsigned int n, unsigned int machine);
+const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags);
 
 int get_arch_regnum(const char *name);
 /*
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c2ca94e29aca..7f2ee0cb43ca 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -56,7 +56,7 @@ static struct probe_trace_arg_ref *alloc_trace_arg_ref(long offs)
  */
 static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 				     Dwarf_Op *fb_ops, Dwarf_Die *sp_die,
-				     unsigned int machine,
+				     const struct probe_finder *pf,
 				     struct probe_trace_arg *tvar)
 {
 	Dwarf_Attribute attr;
@@ -166,7 +166,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	if (!tvar)
 		return ret2;
 
-	regs = get_dwarf_regstr(regn, machine);
+	regs = get_dwarf_regstr(regn, pf->e_machine, pf->e_flags);
 	if (!regs) {
 		/* This should be a bug in DWARF or this tool */
 		pr_warning("Mapping for the register number %u "
@@ -451,7 +451,7 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 		 dwarf_diename(vr_die));
 
 	ret = convert_variable_location(vr_die, pf->addr, pf->fb_ops,
-					&pf->sp_die, pf->machine, pf->tvar);
+					&pf->sp_die, pf, pf->tvar);
 	if (ret == -ENOENT && pf->skip_empty_arg)
 		/* This can be found in other place. skip it */
 		return 0;
@@ -1134,7 +1134,8 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 	if (gelf_getehdr(elf, &ehdr) == NULL)
 		return -EINVAL;
 
-	pf->machine = ehdr.e_machine;
+	pf->e_machine = ehdr.e_machine;
+	pf->e_flags = ehdr.e_flags;
 
 	do {
 		GElf_Shdr shdr;
@@ -1171,7 +1172,7 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
 	    (tag == DW_TAG_variable && vf->vars)) {
 		if (convert_variable_location(die_mem, vf->pf->addr,
 					      vf->pf->fb_ops, &pf->sp_die,
-					      pf->machine, NULL) == 0) {
+					      pf, /*tvar=*/NULL) == 0) {
 			vf->args[vf->nargs].var = (char *)dwarf_diename(die_mem);
 			if (vf->args[vf->nargs].var == NULL) {
 				vf->ret = -ENOMEM;
@@ -1402,7 +1403,7 @@ static int collect_variables_cb(Dwarf_Die *die_mem, void *data)
 	    tag == DW_TAG_variable) {
 		ret = convert_variable_location(die_mem, af->pf.addr,
 						af->pf.fb_ops, &af->pf.sp_die,
-						af->pf.machine, NULL);
+						&af->pf, /*tvar=*/NULL);
 		if (ret == 0 || ret == -ERANGE) {
 			int ret2;
 			bool externs = !af->child;
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index dfcf8cdd9e8d..be7b46ea2460 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -68,7 +68,8 @@ struct probe_finder {
 	/* Call Frame Information from .debug_frame. Not owned. */
 	Dwarf_CFI		*cfi_dbg;
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
-	unsigned int		machine;	/* Target machine arch */
+	unsigned int		e_machine;	/* ELF target machine arch */
+	unsigned int		e_flags;	/* ELF target machine flags */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
 	struct probe_trace_arg	*tvar;		/* Current result variable */
 	bool			skip_empty_arg;	/* Skip non-exist args */
-- 
2.47.0.277.g8800431eea-goog


