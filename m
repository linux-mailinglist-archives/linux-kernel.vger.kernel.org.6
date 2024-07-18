Return-Path: <linux-kernel+bounces-255819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17BF93457F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5297D1F232DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B64110A;
	Thu, 18 Jul 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cqzm34n+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9671B86EF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264443; cv=none; b=QS3L0uTjUfk2KedV6TtNdZu1yw7/v+xk8uu3u3r4KoCvNx6bQNyl7ZFwJewTzoDvR2GvvejVowB2zp59lyC3fCZRDheEv3N5uPgYkSEKUDNZd/w0Twih6henGs29FgyTEtnnfVCUBN9rl4VIzFN3p1/mWousY2R5gJYc2644NPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264443; c=relaxed/simple;
	bh=HQ9pjS5EUr1pSL3eFHsOIf2h0mDHhIWLrampeLYlMAs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fVduk0mugXIqzs12xxuXr8SbdrT/zR544aL7OFYPUuCCnM+Nd8tY1RWO0MIIc8f6ujljyA2iewb8LVsmhLujRBSkbZTsGUivLf+imjgpD0ZgJD7tLc3kgC7O7NievC+qe+mdoYPCXE+TNcUpg1EJzwVi5wrUdCOVbRmNhXNxQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cqzm34n+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654c14abdcfso7013047b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264441; x=1721869241; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rfk9ucJoML9tijv9a95Eu3szNeRcTXRIy2V/XQr/gxQ=;
        b=Cqzm34n+XsYfliHmsC6eCxl1AtFWGMX24ljMwmNkZnEUoE8jOG43Hcg2OT0b1Y3tVA
         c3Mni9YXKsy07iE4pd1+ZtRtU+VsaOtQvXYjNF8zuod/7HvOP3uRaOzhRJbcXKDrHiF/
         WHWMPNkJLdWrbqoorkjxPr7jQ/PJWNBzloU78vhugxoNOPjSqcZAcHyXsPFZnCZ5zRIz
         aMW9O81JZB99b6+5kNV6uDBpxSOPg/+gKaKKlGS0srSIsxGHD8E0P8rurNMmI/hSD/ow
         0SkwwSRI3RMUH3fcgD/V3iAskN9F50+y87Jpj/qqCyhLuWKUybcArKe8d5EMpVniIWHt
         i5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264441; x=1721869241;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfk9ucJoML9tijv9a95Eu3szNeRcTXRIy2V/XQr/gxQ=;
        b=nnnoOq1o9qekWhd6LbXJzzM6tkJwysk9pfIBJKNBayqQbdj8CpT38YvTSpQ2oS7cA6
         nsjUtra0Ss4D+xedHxgi+cUsdDVsDF3uug4L836zVEi7qeRem28+4w2PKnTlUh8zsxxU
         HdOZzrosgMgrYNw3deGdWvxtDThQriA+JGaz/Xah8Di39O4FRVB+A+DF7KtmU1Tr949g
         gFchk5sVXEx/wmIvcq6vrCD6UYM9XOT0QuF89R3O2T5sNkzIztGBRsazoAwaFj1N9CQK
         5ZQ5Sfia1zL3eerDp8QL3ltOL9eft7FsswlutBLqnUVKUh11ijuCqDHgtvwyXR7cqRO0
         bDOA==
X-Forwarded-Encrypted: i=1; AJvYcCXEEWd+7ttEJthI320CWWUQVHBPBYHuWe2QLsRSUfxmAR4KGS7wDiDyL/FVwrI//KYJNpybHNYeegowPtvnWMSUNWqawbPTmpb+Srpd
X-Gm-Message-State: AOJu0YxgAlNzc/YS6P8yZXmUZJZRYb2dw7eDr/uQwyX+cqypeuFHHcZl
	v5OoHWwYgLxyVpSKlc3UJZyJogrIuwWYbvRJbGFDtVehPPTb2dIiIRGQe4nP+qC4lomH9fgppfO
	k+JRmvQ==
X-Google-Smtp-Source: AGHT+IF1OSvxnc+b1qvFcgOaFfrd5/kufXk1J812jAsRRfTuvf0iLiBjVTC4aFaquSt3jO72OgbZ/5EwdMFh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:4784:b0:665:24b0:e936 with SMTP
 id 00721157ae682-6660a82d4d3mr115707b3.4.1721264440715; Wed, 17 Jul 2024
 18:00:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:59:58 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 02/27] perf s390-cpumsf: Remove unused struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct s390_cpumsf_synth was likely cargo culted from other auxtrace
examples. It has no users, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/s390-cpumsf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.1089.g2a221341d9-goog


