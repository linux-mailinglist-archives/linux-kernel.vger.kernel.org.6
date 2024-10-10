Return-Path: <linux-kernel+bounces-358096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40F997A21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2F21C21B43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180263A1BF;
	Thu, 10 Oct 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3b9umA4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08A1925A3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523318; cv=none; b=tCCZUwHMDQ7DfoJXsOZ4Qo01yGP1E3hQD3IKhC2baJUnICHgwP1N+1kXmh/2astd0LFKYmfkOYR/vnb4qb+lW0tsKJaPmzMuZ3MTTnZCPWzY14cuZf2Ueow2PiJce51WC3Gq2IRE0NaOVSP/9vc9YSHhXPR0+19a2ZvhQR5cvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523318; c=relaxed/simple;
	bh=FQo9E02Bn3mdVTp4UYBsHwuKn5WnsZDVjaQO28W85H4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qK3mtIMlS1Kn8uxcZLmPR/BEGeWbLau9odTCIUqGnTBEOqHJQhmFEu+xTvhureJ981NFLYGPWazITcUQmK3+1IB5AlkR2ZRyFLCqS3L+jYFNkpEp0jVZGDkTZA91FOZTiVVtBZqR2CyP52iGTbA2koV5NgRFLvc3gyw8DimfFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3b9umA4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e920cf6so10460267b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523316; x=1729128116; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6prvQ0QcTA2Zgvk0fmsEl8IIT0Zop3+WO9YOOT65awI=;
        b=m3b9umA4c7dXW/HDJs46hRd+fZvwOAru6mQiloIe5/KyFvdr/Za/fs4ntsIwoFwYgM
         jpP6dWSDFNFBWvArKMY0hHJuAMSTTUnvx56y6PfEhDzWesl9brhMKXu7tWuHSxFNeUkp
         bAnymIR/sddr5EF1GilLuHu+ZsTQTS2nCnHbqHfv3HsDORPapdNEb3Vdxu/uvYKZOcnF
         PeHfX2autZaEWwO8R8HnCUURM3ga5S5iFoysvjoSk0HZyRVzNWl+4KpjGmYGFjPsau3U
         TLtuSL0PWicXRLYRzmEY23AqGY+HzWldicnYiJ1jGCKoRiCJISFLTqYSQNLiwc+WupNO
         z4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523316; x=1729128116;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6prvQ0QcTA2Zgvk0fmsEl8IIT0Zop3+WO9YOOT65awI=;
        b=jOylngeo8yfh1AcF3oxRjcP656JjW6Zi8FyhT2fI0L2QI8gskVhB1CFtJv3LspNI5s
         DG2iAM49znBupY5qmPKLMOzvZYUK+ohCLrjlxOEJBSJajbYm/LZ7BZL4FSplVi32iR18
         NQay3aHz1NxEB6nA0Ow0bVGpq4oqRwOHm5KICaOrpKr4BimGNcbrV5aPZQ5S60UEKc6f
         p9LKINmMLZAVsoX8Qf2kpm7RQv521iE0xLrUuEr2Ni7C6cAncLd8kvGlJQ/gxMseKV1r
         wcAdrsvzpBiOerChF8Kl8WlEFETrZ800JkMC+ldL251ijpNaZAJGkvY11e5wP7O1lUph
         gjVw==
X-Forwarded-Encrypted: i=1; AJvYcCXAT42IBZodiVyIEPtoIbrfne38BU96Ck0hr1mDNNA2RTrfwyIO42nC77pIEBW02a2VZTVdlWmc98foxLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8b1AIhsR+TpOk2V19u9O2B5EexjTap3kCoUPT6Jo5qKqGO45c
	3kx7szeY5G4/2jQhgPnCZlJOx3tS2qUMSsXByxuyaAV5qC7z0z8R/r8wdNiNxcThLPfIHd9hjju
	uzSb4xQ==
X-Google-Smtp-Source: AGHT+IGl02iKtMag4kCRH9LX8ownm1gRPRF7Oeo1w0LTYkYyH4dDmIB6/0LxgIS9tAg9HLgfNYcTC1WETIps
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:690c:6681:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6e32215bd01mr1195137b3.3.1728523316141; Wed, 09 Oct 2024
 18:21:56 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:34 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 8/8] perf stat: Disable metric thresholds for CSV/JSON
 metric-only mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These modes don't use the threshold, so don't compute it saving time
and potentially reducing events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3e6b9f216e80..936800c01c72 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2560,6 +2560,14 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (stat_config.metric_only && (stat_config.csv_output || stat_config.json_output)) {
+		/*
+		 * Current metric-only CSV and JSON output doesn't display the
+		 * metric threshold so don't compute it.
+		 */
+		stat_config.metric_no_threshold = true;
+	}
+
 	if (stat_config.walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
-- 
2.47.0.rc1.288.g06298d1525-goog


