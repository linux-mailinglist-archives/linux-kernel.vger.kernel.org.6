Return-Path: <linux-kernel+bounces-368926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA59A16A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122102838E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF01804A;
	Thu, 17 Oct 2024 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp6MW2rx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B6F9E8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124054; cv=none; b=RS1GN1s0c7hLS81icszxZ56A1nkpOLewEGnazxV5QJvzL0X64o9udGZ/KoB0rks3ReVFCJgeW6Y6OdHavjsP76ONefyN+3yFHjPKNQbKXWwrh/PJVm6KHJw4r/4w+aCNEM+j0rLHnyx2s3ux7iyS3hEQXUIonkonhX9XpcUjnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124054; c=relaxed/simple;
	bh=N/FNDdzSnGn6rfbPuY7fZE8oRTOSouL1X1kHuL97eWg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rqOMF4rqL+EJ85uK9m0wyS/GZ/z9fMno2XWW5cTb2wuj0n4/OCN7lEVKpJ0tVY5Q6sHv0yDUOBYgifOoFBwiQlZnpnJpytTK6fTNRrDElOe3yDWPZKoMMWos4wIM+Sj4IrXUd7xpCkYWvWVBnbtbxmLSEUD4CafpxY2PVqnAWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp6MW2rx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035949cc4eso546419276.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124051; x=1729728851; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vpg7UjVbvMTf2T5M8RY79W0YJsjIkpvO45Q8v0jMOdQ=;
        b=Zp6MW2rxNPZM1Y41dj1VoDB4MvuHTrhRSjQDsALG5unIbRmG3sqVM7mpfuT0D28UT8
         SYrPC02sH49eGX7sJ5GHmjbbkNi4WWzTe470fi4YounBPlcBKUMzNOg5UgNL7ZPCn5Ur
         4mUmzIg8I/3Thi25a83RfwtTcV8w7ErVkKhAxGmc3YrEMcEzHdX5saAMnHEk4VxUu39p
         dG+hQGgFMoBKQveYgj4w9vvJsRm2eifkS6ABpZaAijOPOeN9FXJYyp36WnHY4NDdlGyB
         glGqD8Kxse4GuDSaWuqj49QEVEHVep0nKs5wIeMs4sdOvIFxsV8D2ECkM5JNtuZjPNLQ
         SydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124051; x=1729728851;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vpg7UjVbvMTf2T5M8RY79W0YJsjIkpvO45Q8v0jMOdQ=;
        b=CMOZ2QNp52VytzFHKPvn0Zb+QvBYKd8opRr/X4bcilOzXzZBxj3hwKVi6m1S8EjKcG
         cd2o+Ux+fkPdXFEvzgiQhF4FZTNEHbXkuLAMAmSyn7U2jh+MepnFxYToxuO1UPOg05t6
         2tCqSrtsoM9jaEq+9PAdyCrqxPB5olc5hF7lemz4wTB1Oi0dnivuwgOyEdTCuGnhQTS6
         TprrKp/MAe/f/b3LQxKgqJGZeraZbYEuiw/CL4taJQw75PmycRUCcprTZEE58a1Bzokg
         a+/FYyfOsYOCQuztF+imm5ArdeniUewEOXsxPGC8Ac6xSkRX3pqJtcCv6mVi5DKdNMJv
         xeVw==
X-Forwarded-Encrypted: i=1; AJvYcCVeE1IpvF8qDot6aMLIYe6NpebCxzx64N79LS+YExrMEBaKleZ4H3DJG9YdxnStO+2GeOMdOThmhXof+tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNhrvWtE0hivqzB80c++P4VbMvZuLPVgOsZt88ADTd1bYmwGT
	7Hi3e+w7iTJltbL1wb6UeTago/urOsaamfIFTh35H4ZivojPZxcCRUQxNRON2sE6QC2uG75pElD
	M/wfPMQ==
X-Google-Smtp-Source: AGHT+IE02udqyL0ksFlRpgHYEs+RBRyhfL+nQeujKZ+O/NiCK6Bw9qW9/lbqOGgoYUwDeDIjpi9bLcuBC4kZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:9e0a:0:b0:e29:7454:a4dd with SMTP id
 3f1490d57ef6-e29782db2aemr7708276.4.1729124050459; Wed, 16 Oct 2024 17:14:10
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:46 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 03/11] perf build: Remove defined but never used variable
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

Previously NO_DWARF_UNWIND was part of conditional compilation but it
is now unused so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index cc2cfc3aab40..dd5468b8b5de 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -756,8 +756,6 @@ endif
 ifeq ($(dwarf-post-unwind),1)
   CFLAGS += -DHAVE_DWARF_UNWIND_SUPPORT
   $(call detected,CONFIG_DWARF_UNWIND)
-else
-  NO_DWARF_UNWIND := 1
 endif
 
 ifndef NO_LOCAL_LIBUNWIND
-- 
2.47.0.105.g07ac214952-goog


