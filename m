Return-Path: <linux-kernel+bounces-337361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C063984911
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9001C22D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B711ABEBD;
	Tue, 24 Sep 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XGYN5eE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D51AC8AE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193902; cv=none; b=D07pNR1n9toJeM75geXzrlHDD0fDH/mO+CPOsG/b9QHHzcFuoEkZ8rxvsSsa3jfa/MvuiEbGj9+mK5cGRm0QERV/9RkbjRPcdXSH00msR3qVk2nJn+jeFNctYE3irP3Ma/mmEY8571HWYKLiSzQeTfS1IgSyg7VlncnpY5y4Gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193902; c=relaxed/simple;
	bh=K1y0Mje8m3N8dndehLVLcK715auTxacs2f4JEK1wA7w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iX+yrnYjJ1IbOmRoyQsl64twasXPrcUrVlZmIYfHJXCNtxgtagqkqIVH4QlZ6ViF8asnS2RI9BUXvzXtIbdPzc1H8Uoo4wih1NgMT1gzlVAZ44Skx++04WGx/rR5aj73CEt61D/zkKD25Ps85jjuEN5mOna/4vfOXDZBBj0AnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XGYN5eE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2146737f2so10238127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193899; x=1727798699; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13Dc2kNxgsJ010+fs+f/kwyOUj5isZdPOF/Qd6jwZKU=;
        b=4XGYN5eEThvyWpBfuBzTOSZ9YFK4Dl4jn1VGoVMy9z9ADAiIltLkbT8NqcU69xWzFk
         pD7vK2xeWk6KIs0yqzUr/JvTUJkueuXVbarmKvdj6aO1SrmQINVX9hYy81mB5GB3j9g1
         1rauXEivFo76nYQQl1mB8GelDhtverQlkv3+pI8r87ExWYq18pVuc2L2ZkZC54TCBwmm
         h6xn2KkJfBozJ9UU7Ohe2VTiYZBjJ/X55mhRprnMzT0Fp4Sp/qCtmzFqy5EE849W4TS3
         SR4H2MabH/RfJBNxzJqINhGyI5f9iRbbsuqpKRMPHaFuH5imDwC1xVfgluapgLNrgbr+
         DAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193899; x=1727798699;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13Dc2kNxgsJ010+fs+f/kwyOUj5isZdPOF/Qd6jwZKU=;
        b=DxPnDWh4SaOIHBaJIy3Ls9ecEI2mKnel5b2I/m8sg7BbibuY3qTd6ALB00Io3iRGhX
         szmDclHJEEKyCLcGV2rKHXkGmyRFKXnsqHYj81pN7utP1enW2gDH5QZQOSptmSnVp2fQ
         kHFKmVJrsRhDRVFEPoIklFKYGStO++cVSGIF7+d9tQ6eal9VRhUWgC+wQPCEyxJ7hfqd
         NxLcFLT9YWiPQ+Sep6bRTC42olycb8D3/FPsQWMGnMZ67YtudwH/1TZ1Bl1c+3h3so6p
         /IH3OPz9XbOLharUbO8wLt2zlfiVdnV++nLFyMfH8lPPfIAAZWeWwwzcHs6M5YwSfqrI
         ycqw==
X-Forwarded-Encrypted: i=1; AJvYcCXlsvrz2Is9t8+7Vyt76QPcOuuT+h9YxtuXndrQ1N1xRELs2VQ38gb4kSGHWJ9Ewkv1SsHvq2GGBbzT+hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymn5fUBA4Ldt30a4oA7SXXTebw4QrZi1e1hhCgJ6oEPCiCMgz1
	TXaD1ysJI3F6O5bvab62+9L8taajbvxs6HBs34JPRDHFui1i5ycl52kl2wj69XGBhartJU25F/L
	Mj7LJxQ==
X-Google-Smtp-Source: AGHT+IFC/V2dI9Q8GDIisaM4xJaSH419Ve6aOH/o6dp1dUD7HUUpOn9kWS+/jRg4GXNEjosZl5fBgGRmSB5d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a81:8603:0:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6dfeea02193mr1014227b3.0.1727193899303; Tue, 24 Sep 2024
 09:04:59 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:14 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 07/11] perf probe: Move elfutils support check to libdw check
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

The test _ELFUTILS_PREREQ(0, 142) is false for elfutils before
2009-06-13, but that is 15 years ago and very unlikely. Add a test to
test-libdw.c and assume the libdw version is at least 0.142 to
simplify the build logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libdw.c | 10 +++++++++-
 tools/perf/util/probe-finder.c   |  2 --
 tools/perf/util/probe-finder.h   |  2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 71c6f8e3b0ee..2fb59479ab77 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -41,8 +41,16 @@ int test_libdw_getcfi(void)
 	return dwarf_getcfi(dwarf) == NULL;
 }
 
+int test_elfutils(void)
+{
+	Dwarf_CFI *cfi = NULL;
+
+	dwarf_cfi_end(cfi);
+	return 0;
+}
+
 int main(void)
 {
 	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations() +
-	       test_libdw_getcfi();
+	       test_libdw_getcfi() + test_elfutils();
 }
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 78f34fa0c391..7434b38596b9 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1379,10 +1379,8 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	if (ret >= 0 && tf.pf.skip_empty_arg)
 		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
 
-#if _ELFUTILS_PREREQ(0, 142)
 	dwarf_cfi_end(tf.pf.cfi_eh);
 	dwarf_cfi_end(tf.pf.cfi_dbg);
-#endif
 
 	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 3add5ff516e1..f0149d72310c 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -63,12 +63,10 @@ struct probe_finder {
 	struct intlist		*lcache;	/* Line cache for lazy match */
 
 	/* For variable searching */
-#if _ELFUTILS_PREREQ(0, 142)
 	/* Call Frame Information from .eh_frame */
 	Dwarf_CFI		*cfi_eh;
 	/* Call Frame Information from .debug_frame */
 	Dwarf_CFI		*cfi_dbg;
-#endif
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
 	unsigned int		machine;	/* Target machine arch */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
-- 
2.46.0.792.g87dc391469-goog


