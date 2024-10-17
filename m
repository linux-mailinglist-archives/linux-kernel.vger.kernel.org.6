Return-Path: <linux-kernel+bounces-368924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776F9A169D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B1528381C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142416FB9;
	Thu, 17 Oct 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTuZwr5l"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9E2905
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124048; cv=none; b=UATdGwJ5+hPPNJxPsR2XMvMI0I8sd31nVi5e1AYI7EGV0BDHCYaddLYKcL/OzeITXopsLyi0HKTqyuDp1DwK5hMpLEljYev+rsrM0qPHTe1SmPlg/FyXSOeASgyF7U5aV+2C1EhXOOzX8XJkoPob/SI7EDY6G66vwoqQUHTtupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124048; c=relaxed/simple;
	bh=EOP5l6y1kUpRzEu33igUG4tAL/TMJqk/jq6xRto8d7g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NAp31SWVpnoT/axBBNR8sOnrrkNeIE6Bd2tZOhOAVJ5otTXw+0+gNRheS/lXcTQoYQRi2LTXmZiGpFOJOXei1q22CZzN8SbCeNe2PdbdMmpXrr5iSM0Bk6D0Acd5N+kpu+bt2oXZkoBXbpuKlS7mcn2SqCRWUCrpo/lD4LIgcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTuZwr5l; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29716957d9so651968276.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124046; x=1729728846; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Zgjnj0m5GCDK5RZDSEvmChYUUBqnb9Kjcf22Xw9GZo=;
        b=YTuZwr5ln2aetB1xztLNVhC6vLuiQXJ9CzX7ZpiUXM2LFAJzXsY+p9WRNIxV+HJLMt
         4nEhLFJXtmH8WXW66NuvdUBemQ1xlsM3NioMgLlW5ODeev6SFSm24+1+cBZtJrnDiUcp
         yfbJUC5pOhPBPP6Gb0/KVdlyxdnRAq5ey7A7S9Oqy58ffvHXli4PHhkSm5Kvbgbyv601
         kYtq1TzYWLLQJb8hTBG2Tw6qcNZqS0YtI4ua0xlH9jZz7FdCZmRjANBuiywLHGWrRrv0
         HcJ3VJN9Y3YWoNcVr+0YbYk8iwWClr4RMTeQ8nsovQeyCr1kD+DWIxjn/N8LuyPqekXw
         ZA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124046; x=1729728846;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zgjnj0m5GCDK5RZDSEvmChYUUBqnb9Kjcf22Xw9GZo=;
        b=qAUS++gDGVeN6d9hDT6HEW9qP9trvT5adVlfZey93UcPBGOUe/FEC8BsQF+sV/Cl/L
         Sr3SqHmuQZrt/HM1L7aSJVKPTZeUYx0enNqk4NFvVLGaYooao33/UYJISNYOCjPRHYff
         R2egodGZ8ShDSI1hAjrcagnPn+D5lw1xL5ITbQDnjJ4ksEOHudsy0u5w7NKTVOZS7Esh
         0yxEAJYokZPs1obs8MszcbXnrd836xcfp1SCrxTSrvBoEUpjrLg+ADLkMYl44odetRHI
         zDZw+PrPFWTkENlcBA7kGfDmPrv44umx9TsxBlJEXR0x74/6K9+37sNve3NtBSfAyOYw
         tOTA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9yIJXfhchu96rsl3R8qOjvXEQTqgBbqu87qkkaIOVdV6IdFaY7R7wUjgiAPM6DFTWkpbeLhxDVL3ufY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7rHBKv3WD/4K3FKZH/uu1ROT/SpSKRBV0Du0sSf3Jncmz57b
	PO9ZTeul1jDNh751r4pZ5HIKVNeT311609WAItQ0Y8vVv5R5h9KOueoQa5mrquQ47VQOeXQkfok
	WAYJmwQ==
X-Google-Smtp-Source: AGHT+IG4yOEShi7bfA//zRBXm0HyxwcMrNGTLY2U0O7sKDY8krpaQf7LbxB/HvXewatFXm/5ipRsL7HiuJQ8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e1d:912e:9350 with SMTP
 id 3f1490d57ef6-e2978559a74mr9642276.6.1729124045785; Wed, 16 Oct 2024
 17:14:05 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:44 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 01/11] perf build: Fix LIBDW_DIR
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

Testing with a LIBDW_DIR showed that in Makefile.config the dwarf
feature tests need the LIBDW_DIR setting in the CFLAGS/LDFLAGS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4ddb27a48eed..c1c7c25887a7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -162,8 +162,14 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Must put -ldl after -lebl for dependency
   DWARFLIBS += -ldl
 endif
+FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
-- 
2.47.0.105.g07ac214952-goog


