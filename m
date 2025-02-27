Return-Path: <linux-kernel+bounces-535625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8DA47548
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D5E3AF9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613EA212B23;
	Thu, 27 Feb 2025 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFf41PQT"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249E17A301
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634742; cv=none; b=fQSsrtYRkRtGkB8rWHdEWWmJCZ13qQbmcpdKJUY+Bm/Ihuav6AMdQn14Y3DxcG5uhg6xYOhAXaWy1hGi58g6Uuvl/HZaG8r2FzFIRvN9t5kg8yYG5wK0UVs64ribkeW9NWZTFvYVmoQvW99bZdQAz+UHGrxGFQjuSZrkyXbiYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634742; c=relaxed/simple;
	bh=DEuvCIslRxxKZ/FKUxXpjIuiKOQKihAOFte4f/C4jNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MxnLvgTbbPPFxNHpPvbEjCGzxoJFpQATREd4z4Fw/6mmnfz515qZG/bvv/DnNeHa8lIlNvziKo5RI/5zPu84bw8JktrvgWB9bwWgnmFVSTM9oSOjucrZgSRJ/qfS0CS+BTFTxghKhDFikIYv59ymA8DxBlHAAJkP1Y8cKvSOTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFf41PQT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so1415365a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740634741; x=1741239541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pghRppAKQix00kejEXNfKBFBvnS4forjjInAnQO9KcI=;
        b=GFf41PQTYso3gCATujauVARAmpP0SiHIU+P1hLPf+0wH9PyQpC+tQ+3EKpQEmaAz+l
         glNDrLmwJk5VajNb1XdJl/wRPOMm+78DvTE7aFWVw6lwm/+mzwgQQJNJJZyOdG99/mTc
         ngPwLUdQz9gwfn1VJoFW1WvtdQRy5t/YQaF03LRT5G3cRk3vMBK/qoDnFZY+OyoGch7z
         aKf/9TGaxhB3Yph1bjXs+asa2mQBAJa4WU5yjTugWcYRtU7HCWZLVOC5jBfH3xkmsfLA
         eRxrwh5T6uwEBuWz7bVe1cPaAyAxKKWOi46lXsAK3reBD/Z4XjxMMgx991ZZnnh8qSdk
         Z/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634741; x=1741239541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pghRppAKQix00kejEXNfKBFBvnS4forjjInAnQO9KcI=;
        b=d+gtIB3GMhaNRrA5Lxjs0TmXdvI8sEjQ5M6hURU4kzy71gNTzoFv8Ne1C3KGWHMT9V
         qhEq2gVYHGPeLnDNkjq6nt45JQoGdblzHwaaGLDSbh9DfxCkRr0WT3eHVyhILx5KpI91
         Ul/1mOhzELf8ASSX0CAvDQS8pDvT9KohikKdfAInapRsnEaRSmFKU1x2BnouysYHqnfQ
         bMO7E45JfsAZYshX27+xnktBYc13e6XYvOa0SKBqQPTpM5VoX1kkai3eVqDSi+eldTQu
         CQmgqMitPCL1nAgYMNLKpdwIGcaMjxl0x4mFHKO8f+ylSe+tQZBpqt9CnPs2uDfQWiLk
         YTWw==
X-Gm-Message-State: AOJu0YwC3fahke6oZY9ytrHFqutJchNhVXDLzJOLo95JIWF9jB4NlvRb
	WISkCLgB4OgOjpyxLq+2H4yNrjIT89XwWSN5vN/qYheXy/eRlFCtTb1qaPVhwYhWBptcIkSNnW7
	Ug7QOra3RPOYt2fAhp6Nx1GNfKOGsd2gYAaAEkwpHrNRsT1c0qYGGokursEUDdeHtjk2evFf+Es
	YozdWbS55PcRRgH7HbqJIn+/CsWfXQg3eLLGIUoBcC
X-Google-Smtp-Source: AGHT+IGDNLiy4TmeTGBNX6d6KMAvnzJaCLBPWpNTSqo5m1Hz1oPdH0VFfPvKZiXe8OoS4KZFmsQmJatgscQ=
X-Received: from pjuw3.prod.google.com ([2002:a17:90a:d603:b0:2fc:2b27:9d35])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:100f:b0:2fe:8c08:88c6
 with SMTP id 98e67ed59e1d1-2fe8c088e3amr6768145a91.7.1740634739885; Wed, 26
 Feb 2025 21:38:59 -0800 (PST)
Date: Wed, 26 Feb 2025 21:34:07 -0800
In-Reply-To: <20250227053738.788153-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227053738.788153-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227053738.788153-2-ctshao@google.com>
Subject: [PATCH v1 2/2] perf record: Fix a asan runtime error in util/maps.c
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com, 
	leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If I build perf with asan and run Zstd test:

  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
  $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
   83: Zstd perf.data compression/decompression:
  ...
  util/maps.c:1046:5: runtime error: null pointer passed as argument 2, which is declared to never be null
  ...

The issue was caused by `bsearch`. The patch adds a check to ensure
argument 2 and 3 are not NULL and 0.

Testing with the commands above confirms that the runtime error is
resolved.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/maps.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 09c9cc326c08..41a99e1f4b50 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -1042,10 +1042,13 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	while (!done) {
 		down_read(maps__lock(maps));
 		if (maps__maps_by_address_sorted(maps)) {
-			struct map **mapp =
-				bsearch(&ip, maps__maps_by_address(maps), maps__nr_maps(maps),
-					sizeof(*mapp), map__addr_cmp);
+			struct map **mapp = NULL;
+			struct map **maps_by_address = maps__maps_by_address(maps);
+			unsigned int nr_maps = maps__nr_maps(maps);
 
+			if (maps_by_address && nr_maps)
+				mapp = bsearch(&ip, maps_by_address, nr_maps, sizeof(*mapp),
+					       map__addr_cmp);
 			if (mapp)
 				result = map__get(*mapp);
 			done = true;
-- 
2.48.1.658.g4767266eb4-goog


