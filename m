Return-Path: <linux-kernel+bounces-408039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3D9C7962
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B1928671A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7941FF5F2;
	Wed, 13 Nov 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVr+GHjt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC41E1C38
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516965; cv=none; b=Y/gU27Zk326QIcr1+LdLhuHeYMovAcJXpRavl/Et74uFtaJKrsjzz8cLwXy4pfRCAV27tFKtBPOuRzKs57rp7aNThMgGe3TklsFicZb2JCgYy9QgXYOWnvfJnQW/diTmc4R533c5MCaL48p/g8u2pyJ3x1nE4KmdTp0M/VXDEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516965; c=relaxed/simple;
	bh=KhrrPKe7vIHE0T1AZ9VXSsNl1IkVw8BKbNVwlgzjjoQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=LBi7hJ//H68OU3jWBmkIfAUVohcHwrZYHvEIJoCtj50LANCZXwDINWCjrpIBky8EMo2uaTwDnbJfQKfmN03F4TIPDqAxX/vb0LKJK6zjacPkplwlTNK9mm32fVGaw1P5iQTpTs2Nsnc+LdsbwK0t0vnbkJsDNk6zSofhIhzqOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVr+GHjt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so14064295276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731516962; x=1732121762; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L+V0k3XPAXmnG43u3p674HXKA6KoBO29C9FYM4hkixQ=;
        b=uVr+GHjtAtj/2xp52uanYsGfYzbhbWVEWbXLjO2Vmq8yOXxe1/V/RrKf2UE6Cnzbnw
         w7q/EWHq/2Pjwh64Q3q8s9lplfuLj34Hz6n+9cw1xsqySoAvyEgYBPJ7K9kDAibLLtGK
         anFgpWFGCDg3Pd9L/sCYfFKo1RUy9jCEJ+FGEAo6zkF7vlRKVpFylCNu2OXXO+OSLxrC
         IlPfd0B1syF/75APuWnW97Thyb9BzCKi3ODS/SDybZ0bx4ySKRvk6UNIHfryhCD1gWcw
         0cXe1lynIbFAuC5fvwnYJcA5IYT2OlS88F8O6+X71wiTP8IOxR7ZnkcCQyqkDITDT2bG
         j3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516962; x=1732121762;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+V0k3XPAXmnG43u3p674HXKA6KoBO29C9FYM4hkixQ=;
        b=KiLDNsjTqy71HASyJm2R60YVfiR6/OTvTNxHUusotcpAGukJxpIgVGzaJHMqbWkFVh
         rAkUqhhDfAnaXtETKVKCszSnVSNDGsuhAqiHmHTVWiiDdHl01LivpMgu4E15AHfg4FRv
         8/BY7ZJ+Avds+HbKtRJ6uW/zgoDRMnFVfxaeW7N9C0y0Y8avuZ0pHzKlfEZy05hAmNZV
         Xmh/pBkCyul4sqW7L77K3j5U0IeDOhgbimNZsdmPevUE/+H+ltC6O6W67XUIWwz1mVx2
         qLH5TA/Sv2slpX8JZKwNKQ71CnKyYWgnqmO+LXQKDdDQGs3sdrspjIXBA01tBVQMXNnI
         G+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXsVN7sKFX9jS9e2trejpj1aoc289Sq2ppA7eU1hFxc+7M0flvvD9Y/WOpyT/LRnxU8nC/XmJcHFCV/OFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpzRqH+453lWVzx8IrQhpKNfOwjNm6jFtRqZCTi2X6kyi5pgX
	aUyAim/fVbUZGOTfSFmfKnICda6nIS+2b0v93+fMlWvR6Fart2HCzwp4R3VHAEx/aQviswiqXB5
	nsODu5g==
X-Google-Smtp-Source: AGHT+IGvQ+kdAce1NUAauszdwhpxP1WrhuGqEC/mW/M0hscdCrhGUXjO2u2QURd78mtp7VKccYIOr8ZSDXW5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a25:9004:0:b0:e24:a28e:9399 with SMTP id
 3f1490d57ef6-e337f85ef60mr16884276.4.1731516962118; Wed, 13 Nov 2024 08:56:02
 -0800 (PST)
Date: Wed, 13 Nov 2024 08:55:58 -0800
Message-Id: <20241113165558.628856-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For big string offsets we output comments for what string the offset
is for. If the string contains a '*/' as seen in Intel Arrowlake event
descriptions, then this causes C parsing issues for the generated
pmu-events.c. Catch such '*/' values and escape to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6e71b09dbc2a..028cf3c43881 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -430,8 +430,11 @@ class JsonEvent:
   def to_c_string(self, metric: bool) -> str:
     """Representation of the event as a C struct initializer."""
 
+    def fix_comment(s: str) -> str:
+        return s.replace('*/', '\*\/')
+
     s = self.build_c_string(metric)
-    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
+    return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
 
 
 @lru_cache(maxsize=None)
-- 
2.47.0.277.g8800431eea-goog


