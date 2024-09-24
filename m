Return-Path: <linux-kernel+bounces-337356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F898490C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA216B210C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9781ABED3;
	Tue, 24 Sep 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loUhXXD0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CA1ABEB1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193889; cv=none; b=rQsckc778aQufPqIfKAnJW0dUAUmbWnsB9gSyH/lgpmpFA7RxnldJ7164nlG5xMk3jUrc7odRDiosdooDXW2TaxkawHys7GnvVmYkeogZ7fZs9mwpJDp0UsRZLFdSb/AMLRBgpOebLatgjgbxWUPkDgXGt8KAAbPt2uWn4Z1hIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193889; c=relaxed/simple;
	bh=lOIkeFxBr9KJmYjHvA6kEldEhr5V551MPVf7R9cQ/Xc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sjU0xJSCvEKZQIyGT+iWXwTOeh9aoBxNLWj36Zy4KR9TGcRJB2wi7cUOIP365E4DLKZNWmdHibNDi7DdWI2oq8TtuHXpkB26yzHEXZBJOTZKoWd9eyHze03E5RmD11s5e/Jlx9irTHDi31TMVCTXHfUlidn2DF/e9HDGh8JGfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loUhXXD0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2146737f2so10232857b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193887; x=1727798687; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3t0OVVOToxT9eDI/sUQz+XrDg6OUTflpEIB0w34UBIA=;
        b=loUhXXD0z9lob2woxmM9lgwOUzGLr1aUd1x4+TJzX4beO05zNAFkDmRSHrJb/OhGeS
         +/e6q/EnqchYvbENClLl1rpISfCMzTIBeBs/7kmevJgjNQR4pc/LXOM9fhiQ4heSsQIT
         mxPqPZfL0uBrFh0TbQWBfsyeMwN3uwklCTjdgBWMpxAepJDcuH/FoCfadfX9wriKBB+m
         FfySFtewlViWzEyvBnaeh2GwP5atPS29d8Shm7kQkJibacsQLiQvhbADZ4E+7eVlW3Ff
         2TlD/+thyWJ2kjWsOn9tHoqGfcVA9ul72LQ+L5hyvhJ/AtNp3yNNlI/iu7rIzhk5Fzl4
         ueMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193887; x=1727798687;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t0OVVOToxT9eDI/sUQz+XrDg6OUTflpEIB0w34UBIA=;
        b=HbZnhbpiTcN6ojtinUlx0QQ+WZOHEu7cnXyMTYxcwjKgx9KKK/oyb375+rlyjbzV5y
         KcDFmf7tu7KekKCMhZ+hHTKtmKqVXQaMPsqyCiNdrfvxRuWsCLOLYek/fgbd9bdSOZ8m
         98IC6cjFgtWK7f4wqOOFv+jWG57ST0GCYd0ovHjToO3SYg95bZMEWhuXIxtPnVyLDL6m
         15QN6QAC1Cfs6UV772CZDYVCocxekbPrIHU+28wtzRwuehi+GP2YEvZ/gCpX/Hm0LO3A
         kuyzcp0nvtRf8yUA9mrGwYYjGtP0YfsjrVtPHNJGYcYwNoxdSNzi/2KGxPGCdpR9z+t1
         NbJw==
X-Forwarded-Encrypted: i=1; AJvYcCWnl5wgxXJId2LMPOZqRMVpolVjqrd68TI0zJneupoUNNKLIpLliNyvsovhjU2jvtWCLbsbw4PNOY4BFVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQR6cSnu8W559ZY7lLizFJFcLSBw2Q4FB5eoSQ7iuKAT5fRKk
	ijRypxYaljqHnlFb/87g59lLVvJirjmegVX1vTDib3Ia0OXxTzQXm+fY+KWqrP8/OnD/6UQVVfe
	rJg2kvQ==
X-Google-Smtp-Source: AGHT+IF37gOj9FE2Xs9jnvIRNygnS/TyFwBKwryzuDiqUK2T+INXLVMaWw33Z/HlSNoZvxxm4oauHzQyspya
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a81:a783:0:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6dfeeff6918mr934617b3.5.1727193887266; Tue, 24 Sep 2024
 09:04:47 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:09 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 02/11] perf build: Remove defined but never used variable
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Previously NO_DWARF_UNWIND was part of conditional compilation but it
is now unused so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 55a39211496d..182e14e39cd5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -753,8 +753,6 @@ endif
 ifeq ($(dwarf-post-unwind),1)
   CFLAGS += -DHAVE_DWARF_UNWIND_SUPPORT
   $(call detected,CONFIG_DWARF_UNWIND)
-else
-  NO_DWARF_UNWIND := 1
 endif
 
 ifndef NO_LOCAL_LIBUNWIND
-- 
2.46.0.792.g87dc391469-goog


