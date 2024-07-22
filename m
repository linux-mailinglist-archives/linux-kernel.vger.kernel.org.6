Return-Path: <linux-kernel+bounces-258843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACD938D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D0A1C212BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104A16D313;
	Mon, 22 Jul 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYk+9vfW"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5116C864
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643176; cv=none; b=RwBFODox6OK6VGUzA5F1We2imOYGfDNozbEt5lbZE7axlKRU5EkJZ/lygD7hWGUI3AiJQ55IwfWMWsRwWiyub7bsQ/wxlzBrGT57zXE0mxjLTZTX7AHgyowW1C3VXdT7cCNB05kWi8Y2k9MRL0Z7hgLAgCaYEoginKVtK1jAnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643176; c=relaxed/simple;
	bh=nFFI9RKICO7tZQAb/+UsQYDgk3RpA4xkmXJTM26/t0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pm6g8xWDxo+CWbLfcUMdd26J4PvNdWmw184TrwEVLYDg92DDbmvSLafnQ69LhCbKFYSgFraeuTEeF82AMZOM2oLIBwcZiQGttNad4CFOAAIlngORvYhESKHx79bhVAxsZSl0/2rS7ZqjGYH7hNNuKwVU06HCyV8jzYQ86tuOtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYk+9vfW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426526d30aaso30955715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643173; x=1722247973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBWFBM+gp3e/C9sPG7aaILEvO32vZCwGZx3iasW4K4Q=;
        b=ZYk+9vfW70TrHJT++buTGw65uA45+55wFkvT8C7HvjCZgzIst6c5V8d2mHPZOvlSsi
         MJVlX0nXaV2YZfz346HkmlXZ5gbZ/3sQroEKpbA/ARDyGRmdHqvdTe8OLPRRwspVRT2H
         /4P4p8/2DVAtuYtIQRGX6sup3xh7wgRbeG/QoHyxKm0nr/lXB7FXGRrUCf/S6NwjEn9K
         ZcdCA8FJuvQ1UYV4OCKejlsca3fDiSH3pOdbAm8jkz7p7fCP3pNn5EgDFQEHZLiHty8h
         HbtDeF3HFCWz04Lf6uv2IqlJkoosyMv0KdSfv0vIfePHvi5C4YygTJGDA0AUtYlmAXW6
         83NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643173; x=1722247973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBWFBM+gp3e/C9sPG7aaILEvO32vZCwGZx3iasW4K4Q=;
        b=IVlKqiIzrbVqxAzscPj8fCFZas9+8VCF4IHcen/Ddm0HgaCb195i1nprpH7X0uGfFH
         l4wH2d17oWklRhUkIQ9lRL9aTDZOb7AFD9nmrlpx0ScSUrlydiJxpoXtrsC70GoyuYkU
         3wA9gfHxqH4N6HzA1vD75ljC9EV5K4wTy+EQyQHj/xuG1X1Was8CuU+X5Z10GcxqsL3u
         462ipRMSoQW6iWE9y7G53vxPFCY0cohr9OpcDH+tGlE0hyHGGBolcmo1SWsddRVWZ2sF
         P/gxeZncTy5Srjk5KPc7GlgK001LsrxdCetQLTslgd+mkYu3bBkQ/y2PAigfn8p9jOuL
         q+hw==
X-Forwarded-Encrypted: i=1; AJvYcCV/BNAAkQ6KJDKLJ7drauNkzIBAcDlh48zqHjM3yU7ewX5aagCt9M33TKvsAJDRv7UWnH/8EWtefD1RsT3LAI2hsQWuYZYtisV7GExs
X-Gm-Message-State: AOJu0YyN3YW0iEeq20gwpTNcjFig6dXA1vbhdemJ+kqVRZArkMlCL8Cj
	97dUsPc8oaLX/WU13lJy9kWxSC6sUOTV8DK9wZloPw8yqnBOCxCUFsbmWJ5zpiU=
X-Google-Smtp-Source: AGHT+IGYIdyL3I1JnwUVfQo4oAyFcYwPdf4bNyN/KdL9IsI3rZiBMwNwH2ZruyyHUHfolR/1azJbfQ==
X-Received: by 2002:a05:600c:4751:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-427dc52e886mr46427815e9.20.1721643173518;
        Mon, 22 Jul 2024 03:12:53 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:12:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 05/17] perf: cs-etm: Only save valid trace IDs into files
Date: Mon, 22 Jul 2024 11:11:47 +0100
Message-Id: <20240722101202.26915-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

This isn't a bug because Perf always masks with
CORESIGHT_TRACE_ID_VAL_MASK before using these values, but to avoid it
looking like it could be, make an effort to not save bad values.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b0118546cd4d..14b8afabce3a 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -643,7 +643,8 @@ static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
 
 static __u64 cs_etm_get_legacy_trace_id(struct perf_cpu cpu)
 {
-	return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu);
+	/* Wrap at 48 so that invalid trace IDs aren't saved into files. */
+	return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu % 48);
 }
 
 static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, struct perf_cpu cpu)
-- 
2.34.1


