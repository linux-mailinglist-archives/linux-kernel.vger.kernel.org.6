Return-Path: <linux-kernel+bounces-368385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856169A0F42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F1EB22FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64C20F5B0;
	Wed, 16 Oct 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wY88EJA1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24720E013
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094660; cv=none; b=mGvcE3tLaNXutO/N/BtDB8utDCT1yU7FX9A9TdD7A4GrIAOrAa9J6Pm19ln8uE2pvylNmxdpKqGyLuYu87JZkmgaHvld5NDIpfrVyCNXqqfZPyG8G/aJoD5pKrDJCzzIHz20SrDdH5lNZ0PkK2oF4RUm9w1g1I38OI4QwFBEpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094660; c=relaxed/simple;
	bh=rsrRjdXFsw1zqlE9yI9qOJKxcWh0+Zmduvrfpm+of48=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=OuokKpx4koaHsbqlKFG2LN21UzcbjZN0oC+XS4DjxtyNRvJUNIcRXOuzndBVVhYdR3I5VHgrkkmQeTtJK8iqUiDkI2YX7aKmMOHUSsFHlXROKR3aV7tVk38y160BhHlNkjS4/afYAgVGi9hFH+YTn8Nt2W5SiS50FRjRmRpqZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wY88EJA1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2605ce4276so12098438276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729094657; x=1729699457; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSYeyjKcx92ZEc/VnHoFN/wUNlf5dg+yo+Qgoftk8gQ=;
        b=wY88EJA1Suyq8TlU6pzrs+waWa3PZD36t3bg3TZ1tisTaKhDAQ6fTBbi3X3ZiY+q88
         bd71D31QRH//zy193nfGJZUsxwtKPwZabzwjT1UJ7UhJtcRb240CdHP0pzoWD72VDU2o
         RaXpBslVz9uJEGSD6dRwfgMH+JZbHX9ZurJJ0u3EGvrw2wxGHzqqwTampc9pMc58eXhT
         LgzwKg6mPLeSv+RC+1i34u4QPJnWZrh1iOKRsyplYGXXC94iBDOAZDkvjQyKuIjLHBhS
         qASb5RIx3jfJjz75DKPcKLFoXBfgTs45fv/jAu1kNMNulvizRF0GSfznh6l8EoEcSGDp
         QK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094657; x=1729699457;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSYeyjKcx92ZEc/VnHoFN/wUNlf5dg+yo+Qgoftk8gQ=;
        b=Lxe83x1P9eUvV/w5rRFigpvWXSuLuSYOlJe5LQ4870oBqR/h478iCY9/WEyKr/REiw
         GOd04SMYpBydXYYMtgn8yqNZuu2WMwvZbqKUI8gE9mytXN+Ysvl33voxMKOBAh75DN08
         sc43eOvZpXZPBIuBjbvzrwJaWaTzgxnX97a0G0+KwkzguAC/zbyBJ1wVX2zgGWaNKPi1
         b5ZVWfj/lkZ+knYYRS98tY+OJMDOyRbfDLYXhjvr7EkFnSYzr6h8+jg25rwpI8Vf/5cj
         YiheYKN0O39t+Xqy/OK2F+wW+uLq2W3acj5/zsGP5y94ScN/vpOcCLZq4tjDSIfT87E8
         rmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWfhTdG2fm/iMXWSAfBXMrAkKxtmJRrlQfuzOGyeXBhX+qHPoEWLQBWS6kS2NrIc8Ek9XUkuwh75om2LLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxY/VKruMbJd7N7C3Uq0q77EGJgL7btzClnWzk98bm9FXHRKBp
	eWcDlWRM1Wl6EmOuzVKVsMQf7rmAmaMIm+yiGozddyLGfxqH8/aP3g/7dhoyxHljLVS4VXmsBWi
	xL5X+Gg==
X-Google-Smtp-Source: AGHT+IFN9QIAUX+G7dHHxMOSStW0LKTyts98fvIunCBBIU8jmmsbmlo3lu+jhizVefZJsBO/7eo9xeApLYDE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:26c4:0:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e2978319b29mr2465276.5.1729094657082; Wed, 16 Oct 2024 09:04:17
 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:04:13 -0700
Message-Id: <20241016160413.51587-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1] perf tool_pmu: Remove duplicate io.h header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove duplicate inclusion of api/io.h.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410131417.ynhvnEJb-lkp@intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index bd1cee643eb5..4fb097578479 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -11,7 +11,6 @@
 #include "tsc.h"
 #include <api/fs/fs.h>
 #include <api/io.h>
-#include <api/io.h>
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
-- 
2.47.0.rc1.288.g06298d1525-goog


