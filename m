Return-Path: <linux-kernel+bounces-284883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D6950663
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6778A1C22474
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4719CCF0;
	Tue, 13 Aug 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vT7dA0Vw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCB19AD6E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555489; cv=none; b=Sp3zu3oHbLn0w/vw4nSQNqL4wZSAsh/CWSOM73lhJv7QHEis/A4S4Zwmins3lPJAUC9BrjV9eSVymmTjZjKpgiWo7P6nLHeZ59sTTYTSVtok1V02Fw2FEvskJ7TMx6qaoC5iD7iY1qZSMWsn/A0O20DyH7LueSfu6wl+JxU/ibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555489; c=relaxed/simple;
	bh=vbJDszVbFZo5V6bkkKmF3OewIJREyf0evahZxMqFmW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ea/WsTl0KBxj7D11iLP9FXTfaQMti6HO+vSS8+PlQr0TPWh1k3Nj1sq6S4WEgEY8H2xD5PT1U1sPv0NqIyd9Y4FMj0xNefgbSZfoSUq8/ALvmizeYykQ1hPixDdhFQxt9o8rN7cBlH8AvnIeuCnlnAktE93JT/ytXrkQpTjm+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vT7dA0Vw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280c55e488so32137045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555487; x=1724160287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuKn3zCZ70JZQp+93StFA2ZNN01UscP73ZJf7VHOy5k=;
        b=vT7dA0VwxJ589CnnVfryw7r8F9SlPL3hXCdBa/2R2vtqDdaQ+txWSkC1ced3+Lw4jx
         RieNeeFGPMn5shhxfxFmbOq86LcJBblAvLW+FjiziE7TK9H9Pxihx0/hjKNPZRQ2Zy6m
         5uMusY9Gd24QfxiCiTdOuDHuFv6YqhOz67jr0+kza49ltmM/6/8dBAgHqRIFYs8+6pPn
         FE2RLZj0manfhFG5aOmmbzJM71v980V0DxR3PKxTI+uneGhmWRFCy++XblUKOuMLCRRE
         19CsAx6zbMz6ghxHPKCzT3GcjJ4PpGi6K08k2X0vTIyRbZL6qzCSIxjphigLseKk0iyp
         mAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555487; x=1724160287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuKn3zCZ70JZQp+93StFA2ZNN01UscP73ZJf7VHOy5k=;
        b=q091fEyHCdPnVyPoZ1sR+z24k9pqCU/upA+5QnqcYcA4EtGO2B5YgcZyp+cJEETQtK
         fStbnXiW6ngR9F63V8fgo1lBR9ffiwxi0c3rBRCmeqFW6q7Gn+gHEwIBpeGLI/qLYKK8
         GA7LJ3JDTXJMU9aodgK7lyB5vqOj4gt/KOEYfMZcKuQcm1+uli0+owhQ5KQZD89RAFC0
         y9IskKvvcv6S0UrQcHewZYUms4TjuhlX48+v458XaEHE0thJ662x9BbYmFWvN8/LVxR8
         wNyuvRk5p1Mp4F1MiDguRae+iA357tty+6ICBitGgK4YFNN1LRdzyn4mBtPK71pSD5h0
         Yy/A==
X-Forwarded-Encrypted: i=1; AJvYcCW7RCo5BBCyruD+Re7DneYYI0bubpY28t0bPdXQI+EbGZekBznyhyKSn/q7bXbOwJjYyoT3W6eSuah9xmm6xUekqvAtzUuKEpIktn5C
X-Gm-Message-State: AOJu0YxrBurrorMoNhzp8yKjy9g2PiIR63q6PSVivzvPJ6HdSirVv0Io
	tEGReojZ47PWjzKz//rXvqlKEnkPAkJfLgOQ7Fjz1T3Jimba2jasGW4fDxtlafc=
X-Google-Smtp-Source: AGHT+IE5Wty2PhcPyeB3adoas1B2d+fRB+FpKrHGaJmkMiJ3JOcxRs+Gg6UES+MUF4AfDgXHAeTrVw==
X-Received: by 2002:a05:600c:4689:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-429d62f6d77mr23808865e9.14.1723555486482;
        Tue, 13 Aug 2024 06:24:46 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:24:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/7] perf stat: Make default perf stat command work on Arm big.LITTLE
Date: Tue, 13 Aug 2024 14:23:08 +0100
Message-Id: <20240813132323.98728-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The important patches are 3 and 5, the rest are tidyups and tests.

I don't think there is any interaction with the other open issues
about the uncore DSU cycles event or JSON/legacy hw event priorities
because only hw events on core PMUs are used for the default
stat command. And also just sharing the existing x86 code works so
no big changes are required.

For patch 3 the weak arch specific symbol has to continue to be used
rather than picking the implementation based on 
perf_pmus__supports_extended_type() like in patch 5. This is because
that function ends up calling evsel__hw_name() itself which results
in recursion. But at least one weak arch_* construct has been removed,
so it's better than nothing.


James Clark (7):
  perf stat: Initialize instead of overwriting clock event
  perf stat: Remove unused default_null_attrs
  perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
  perf evsel: Remove duplicated __evsel__hw_name() code
  perf evlist: Use hybrid default attrs whenever extended type is
    supported
  perf test: Make stat test work on DT devices
  perf test: Add a test for default perf stat command

 tools/perf/arch/arm64/util/Build   |  1 +
 tools/perf/arch/arm64/util/evsel.c |  7 ++++
 tools/perf/arch/x86/util/evlist.c  | 65 ------------------------------
 tools/perf/arch/x86/util/evsel.c   | 17 +-------
 tools/perf/builtin-stat.c          | 12 ++----
 tools/perf/tests/shell/stat.sh     | 33 ++++++++++++---
 tools/perf/util/evlist.c           | 65 ++++++++++++++++++++++++++----
 tools/perf/util/evlist.h           |  6 +--
 tools/perf/util/evsel.c            | 19 +++++++++
 tools/perf/util/evsel.h            |  2 +-
 10 files changed, 119 insertions(+), 108 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/evsel.c

-- 
2.34.1


