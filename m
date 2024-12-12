Return-Path: <linux-kernel+bounces-442723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07299EE0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EE8167F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAE20B7F2;
	Thu, 12 Dec 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztxe7jyg"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B6558BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990737; cv=none; b=hUZGXocWOBV0f7XP6H7NVFwBCC1T82A6HvMcUYpxvCCxxn1jmWc5L42cckFpbI9iLYqsaqzGVIj/Yk/bJgqtOzZAHf+SJ4759emQnz9ERMFo4xeARorcLZp2QzlhW5MRjIDhKtWCl3BAkXrHIqsH2RFtLebOU0VSLqDxOMbMmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990737; c=relaxed/simple;
	bh=yqB0/GPRcQDx/x2Af/mlqf6+hKzIMv4AZqz43FGoaOQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Ew6lSRMItsFBAziUTs8g8Q9bUoUVE07Ho6QMxsGFV45S/xQGg3NPMumQCc6ygthloC9G5Xpvp/b/yRr2GKUrsiEvyyZAlfUoj+nWCwD6gKsA1rPKgZ0mANEfE/P22DTr8LNFlvoMgvd10Ow8dG24HaP06bNpCla2UbhVgvyAho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ztxe7jyg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3c7dc4bd41so422438276.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990734; x=1734595534; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xx8jjmLWLaNrzTLWOTiBT3mcX72ApM29yyW3EYU8tWc=;
        b=Ztxe7jyg23+YM0A4Sb3iX8lUH1LtJ3dAu1Qxqrq8xhHd3PWeR6tWLBLmil4+W+vcWS
         PO9DeLkQK8mEMH92gtACl/kiLvmAzf5w7rLGQ0F7sCD+JBrw/ixumZI4oNr24xsKtRZW
         9EDFxgREneH07bUGi5ztEuGWUNgg4zXkrnitLugjdCO6g0asKlhmjHqBr6SIQgRjn7vB
         smpBUWlk8+nY1eWB3Tv557egJeetBi5PSRVBG7YuhBHpPR2nnhL7w8QjHDiAi++pHyqu
         5H7SGNCbxKZGhZU8jsS34Hb9kH5BKSdx93zA7xNIurlVnXwSRH59afGR3kgDncNt1W7z
         mpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990734; x=1734595534;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xx8jjmLWLaNrzTLWOTiBT3mcX72ApM29yyW3EYU8tWc=;
        b=cUf0Y7PPOi95a+G16unXul8xZgSlqMD5dxrYxK36HaOkKtnj/DNWWXFwoLN1W9getj
         nnwv67C+oNriSvn6mpx399ihHSJzC2AW8PV7+ai+6L/oFezP/Zs1KmTox8RA8WtwDKXz
         aJvvHZgpEs7fHDoJBntdxB9l66iUikk/SrOsOw8uYBtpylT4TjT5KbvpR5NReqUh++rR
         Rg/9sTbf2iMGkTdPI0lsbDo3m0Fq+XrgH7pe6iEhsIJcvf7en5ZhExT18HTKqVlIQH7y
         J8ilpIzaDrwXvOqErUOpGTYPNDoGJJn5W7OOYAcligtDH00hLb1psDBoUiqEnzUJKT+x
         ewgA==
X-Forwarded-Encrypted: i=1; AJvYcCVi63JBAdQSw5G5WlpPYi08P2wvvrq6pM0zkrkg2A5b5dDXferBpl6IyS+YtFF8VCUwqdVz9OI2T6dMgSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPz693SMTBNOLg2iq8C7Q8475dQcrDbufCMjZ8eIp64772+mx
	raBzVMiTHX2HSZTc6MRLJyKHB5N/3papIN/5b4cUuiXVhaLtskcV+74m3yAARiTkV0f0DGU4jBp
	/vkPLbA==
X-Google-Smtp-Source: AGHT+IESbMp1bRdGyzcWTColyA4uyZXvAYYXGzuS3Kl3isywfeiyDfYWMaodiV5KNSAdllszta0WfMhw37SQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c22f:1975:e7cf:849c])
 (user=irogers job=sendgmr) by 2002:a25:3611:0:b0:e39:95b8:a83b with SMTP id
 3f1490d57ef6-e3da21d5616mr1623276.7.1733990733836; Thu, 12 Dec 2024 00:05:33
 -0800 (PST)
Date: Thu, 12 Dec 2024 00:05:28 -0800
Message-Id: <20241212080530.1329601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 1/3] perf synthetic-events: Ensure features are aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Features like hostname have arbitrary size and break the assumed
8-byte alignment of perf events. Pad all feature events until 8-byte
alignment is restored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f8ac2ac2da45..5b14244253b5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2401,6 +2401,11 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 			pr_debug("Error writing feature\n");
 			continue;
 		}
+		while (PERF_ALIGN(ff.offset, sizeof(u64)) != ff.offset) {
+			char c = 0;
+
+			do_write(&ff, &c, 1);
+		}
 		/* ff.buf may have changed due to realloc in do_write() */
 		fe = ff.buf;
 		memset(fe, 0, sizeof(*fe));
-- 
2.47.1.613.gc27f4b7a9f-goog


