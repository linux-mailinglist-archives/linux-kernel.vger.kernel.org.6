Return-Path: <linux-kernel+bounces-257078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644609374ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF0B1C21BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96E6F067;
	Fri, 19 Jul 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d93U3cLX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1E46426
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377071; cv=none; b=AoH842G+mC493R1CG0FiT8TgDtOfzYiJa3Ho9Sor8QRQV6ZoqPysu6urQS4UsY8j60ubud5enegv3pvGoVbytpkJcdDtOrEORZzlr22C8c0U8Q1F8OVPy2rgNMZ5rHGakhCzjaD6DHK5i5ctipiIJ2QDmEa67OzsKuFLmiA3Qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377071; c=relaxed/simple;
	bh=QyvfbL1Dt9Lf/qRb/Tq/QxZnlpQmlGqWdt0glv+CBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwhJYIv8tlSqmaFgh2QSd5E2+1fy1OkSSQn7qgFin7WwwwTkXXcxWGgKYreBPWd27qro0kxs5PWfBPNWbWaO3HdQhwMtoL9C7EZQB/t5UtqYIqiTFRi9uCNfxlA0EOomImSvylETvDMvVoVmGZSTntvx8DQbQC8bvdBqA6gQa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=d93U3cLX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd66cddd4dso2681455ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721377070; x=1721981870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pKe/8ymbuAK5Ax3GUIQcNZESBu/C5Eo8hDWQvxiYB0=;
        b=d93U3cLX14y0iH2BvfAI4C12yoFPYVjUpTDZpEY9aYEADlT1hwx6fmdoR8m74Wi+ai
         dLnwJ0PHem8jBa5RnjXTR6abuU3ypyDlEFPfpwSzK7hjb0owVZooE9xrWbXa1TgkWHyt
         xLbHyOKHIznMbtUbHJrz8J4C/RAFwCVsayJ87VGv0Kd4DHdlZSluwf4QUxjfh38B8QHc
         wjDdq8O8iFfSDOhcP1GwYuIz+RM448QuWY0GkugSPlGgUoa7G/wSBIQR2YI/sXRIViOh
         8eCxNKhGLmh3cKtQz8Ct5AswevT+uxcNIB6NQA9sN/Kre53AK/7amZRSEDAY4dghC/UI
         t9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377070; x=1721981870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pKe/8ymbuAK5Ax3GUIQcNZESBu/C5Eo8hDWQvxiYB0=;
        b=fokupMwd5b0HIFaG+RSN0uP+oJTV6YsIx92iI6kY4LoApcywr4E0yauGmrjciVw2RY
         NEz0p7DU6kjhEiiRTM7Uza/jlWxOCHDyWrlxcVY3T1RhjnCuEQA7XVrebTfviCf8uU7S
         rSKtGEpdGnkaGvrc8PQzbGaLY3BEHrII7uo13Hr98kOXDudmm9sWQYwWsdnXKUQMRxWp
         rHB2sE6cCFXXymyPa17EcaHIpndE1C0VW308QzGCHIOVpwVRthF2GrTOu40400a9aU9U
         bmqPuKBmMUO9xzk/fnjMoV629/7laluM70tLGBMOGvORlO79+BITgmWCf+1JIZmqKGAw
         IyGA==
X-Forwarded-Encrypted: i=1; AJvYcCV+pOBTvRfmiui6Tx1JXlEWpVnh6/2Nu4u5DMl4TiTI/Krcc1n+hR/GXfZ4MHSHAu+wZQK/1IsMnEcW8+u8uD0eb54iFB9Q/5+vkkrz
X-Gm-Message-State: AOJu0YzVbA2Wc6pqwE4bCu8lkQr63qxZmg6HXtTQo3DA32lufFIe/Plu
	y6X5YMqA9GQn8ip+IOYz0wknFrPHTac0m3NIDnhnn225UAevT4070PNKuABrw4s=
X-Google-Smtp-Source: AGHT+IEikfqPPIxLyXm7DyKRFHJ3A1M1Ps2TrqjIqzYPMuiDYFdEkDVoM5sL+AWzL4BN7joBqln2Eg==
X-Received: by 2002:a17:902:db07:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1fc4e165dffmr72867495ad.12.1721377069552;
        Fri, 19 Jul 2024 01:17:49 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d5db43sm8442355ad.280.2024.07.19.01.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:17:49 -0700 (PDT)
From: Eric Lin <eric.lin@sifive.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	Eric Lin <eric.lin@sifive.com>
Subject: [PATCH] perf pmus: Fix duplicate events caused segfault
Date: Fri, 19 Jul 2024 16:16:51 +0800
Message-ID: <20240719081651.24853-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if vendor JSON files have two duplicate event names,
the "perf list" command will trigger a segfault.

In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
pmu_events_table__num_events() gets the number of JSON events
from table_pmu->num_entries, which includes duplicate events
if there are duplicate event names in the JSON files.

perf_pmu__for_each_event() adds JSON events to the pmu->alias
list and copies sevent data to the aliases array. However, the
pmu->alias list does not contain duplicate events, as
perf_pmu__new_alias() checks if the name was already created.

When sorting the alias data, if there are two duplicate events,
it causes a segfault in cmp_sevent() due to invalid aliases in
the aliases array.

To avoid such segfault caused by duplicate event names in the
JSON files, the len should be updated before sorting the aliases.

Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 tools/perf/util/pmus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..e38c3fd4d1ff 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 {
 	struct perf_pmu *pmu;
 	int printed = 0;
-	int len;
+	size_t len, j;
 	struct sevent *aliases;
 	struct events_callback_state state;
 	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
@@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
 					 perf_pmus__print_pmu_events__callback);
 	}
+	len = state.index;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
-	for (int j = 0; j < len; j++) {
+	for (j = 0; j < len; j++) {
 		/* Skip duplicates */
 		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
 			continue;
-- 
2.43.2


