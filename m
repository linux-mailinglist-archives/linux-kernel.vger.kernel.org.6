Return-Path: <linux-kernel+bounces-340890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A09878B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57411F244AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9761E188596;
	Thu, 26 Sep 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcCzoFNk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2018859A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373089; cv=none; b=Ol8tdsrgNUYdFWuyqyIoHu9KYTSqdL0mswWEv7Cu0KWNnGYgqIfNtsiuwXteqgWLtzHxYn5ngPmI1kaL7LR9/Uu1sKiCw4hvhXbF1dDPYTSHkQ7EFV1P8Lqr81F6qIFakAswI+C/9z491bzJVMXy/jbJYVibyy+W02FCyuuc+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373089; c=relaxed/simple;
	bh=foXPCyI9uJrt93GKz0k1BW3ly2utLN/4L6ObgiunCuI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q4mPOePmOxMcfShUW5ahMfF50NZwkq4jHWjtNFrL/LKYlJXNWNuley7xuQXYhl/twh4d+eRR/B9eoRvz08QjIeiP/mJxjUayt+xV1baNLjqP0D/TTnp+LfuX0Jx99tx2xhjqnYZ+JD/rLPNNcMp7KopLC0b7tFeCnUDCqe+C2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcCzoFNk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cc76cae1so1336419276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373086; x=1727977886; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqwUZ5eUe4iklF8Xk+lZXZRX46OOuvGthrg/T/Zy3Mk=;
        b=FcCzoFNkQyW8ZKPw/Gt/qDnkwuoKtunGmt5okQTyTl9//TlfaN9qU8AU8eFe26j4EJ
         zuuDIxb8tmuCYdWec9rToVZ263IgNHc0U1ze3wSISdH7yp1PxvolcLK3tiM1jL3jlrKh
         MqoZzdRQbzHt8bFw0Sn3N8ooiIutkTWuwbDQBDXOJd+rHk9j8ikXQh+yQ4Kff2DDQJGf
         IGvuCZnHTrOY50CIDeMsibvfKS4HxHf1Xfcxz5MlNq0XB9EgBA41Z07ITFMQgQTboAVa
         +ODG/uTl2owpxtp350Ref27hZNXReOmE2fEzeOiNQ8I8bQs7HHcr/i4qRgzcVc2vyKQa
         quCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373086; x=1727977886;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqwUZ5eUe4iklF8Xk+lZXZRX46OOuvGthrg/T/Zy3Mk=;
        b=Sp5xEC0m4V/1RsfyQy4jFxgbwoEK8hw2mO2r65B76tbrBeA6QjUoWHTcMjKUW7vy0L
         HQ4uCR0eJLweczi+u0WCNHdKPYqnWQLHMWzovchBTi3l7mhHedEnEp3vGYoYegmkhAmr
         vySIpKdZNMAxoZwvqkdWmpdQyrMF6eHZ/QH5TiInTBV0+dYcAfnGPa1iU6DQx3bZ8eRf
         iklOhtn0Bh7o2CDqEg3Mkju/njp/rbUz88ZYUS6DewPf9Y8DCE42EeR/susVxo/qU/ZA
         eBYbx92ISm2mRQeJ+Qj87Zv9yu/SEj6rzRiZVX/b0nqlCEKWSNRSvZNFZk1QUhauZdjg
         RPEg==
X-Forwarded-Encrypted: i=1; AJvYcCW/AvQVTE12KZyhhGol9oO/zQyozjOPhNKL7/LX0iMUylQbDSWhsFjItfkPJYhFm2NrEIHZVrawj21Zq88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/47dNE+VFJiRryRli/fArLo1YAbKkUpdslBLEOW1GOyHhLbsO
	aQsIwP5enL9c2fG6d5JjiDnVtj6nh6r0LZkk6FG6Wxo9sJ4KOvfx3g4ozE3LrQZTkSLvvDlRTY9
	SQovVKA==
X-Google-Smtp-Source: AGHT+IFgHj1mWv3ulmIT4mivZPGYAAFQtyIqw+hluK5Yu81t3+mtz7zbOrhohYQVbuo7YHb8sF3VDmH81Xxp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:6902:2:b0:e25:e2af:7e7b with SMTP id
 3f1490d57ef6-e25e2b00185mr20989276.0.1727373086533; Thu, 26 Sep 2024 10:51:26
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:31 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 18/22] perf jevents: Add dir breakdown metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 62d504036ba0..77ac048c5451 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -781,6 +781,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+  try:
+    m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+    m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+    m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+    cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+    # Turn the umask into a ANY rather than HA filter.
+    cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+  except:
+    return None
+
+  m2m_total = m2m_hits + m2m_miss
+  upd = m2m_upd + cha_upd # in cache lines
+  upd_r = upd / interval_sec
+  look_r = m2m_total / interval_sec
+
+  scale = 64 / 1_000_000 # Cache lines to MB
+  return MetricGroup("dir", [
+      Metric("dir_lookup_rate", "",
+             d_ratio(m2m_total, interval_sec), "requests/s"),
+      Metric("dir_lookup_hits", "",
+             d_ratio(m2m_hits, m2m_total), "100%"),
+      Metric("dir_lookup_misses", "",
+             d_ratio(m2m_miss, m2m_total), "100%"),
+      Metric("dir_update_requests", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+      Metric("dir_update_bw", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+  ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
   try:
     loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
@@ -904,6 +939,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog


