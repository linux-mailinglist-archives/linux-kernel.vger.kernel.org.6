Return-Path: <linux-kernel+bounces-556980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B39A5D1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F16A3B5318
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B0265CC1;
	Tue, 11 Mar 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZWUnlNa"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5C265CAA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729016; cv=none; b=g6jxO/NE7x0EyDhzlsswpiJudmwB+Nro1R7XwRExXPK13afj84t5kBS9J9bNzqx0HFkVZTsWpf1ooRYN9lCY3eHdEAlOmErfoqJEPgu0X26hLoK6/BoQ440j+gDbnvwBLadW5KS+SLe18VBLXC4P36TbbELZonxE0ZQWrMuhwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729016; c=relaxed/simple;
	bh=H5KlZ/3j12Z08b+bvKiJZqtJDPyp9/HVMV5Qiv4l5dE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RE10Z4S1N1oR7j2aLkd65TpuavaqQVGzfZiWstsIE7RtJzX7x3qicy4PewtQtY6rQFFHuS7Qw/iGdxYKZH3J6e4curKrkQN4TuA9d0aG2JmEczQIrRQcWF6p3EjTehkQ9i80Ypn5Ib67Z2CyFe32lj+mReCJSI5zKHPxchY6b8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZWUnlNa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fef68ecc8eso36767837b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729013; x=1742333813; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x49RrI+y8H8e2leJnO29XuD2sUnGFNr6Kwf4AQYViPU=;
        b=DZWUnlNaCNCquVIc5nwt+bsNrXuNop6icM+/RW3fXmpaqZc28h1t5tCp1RK9cDg5Ee
         JTLkd4bHpwK3aENDpN1/b/tnsV5GKqTHyGTlLsf5MfetXHzu4rF4pLAbdfFOcRV1lIXF
         ilJHVXCGMn4HEuwCgsdH4x3pWjh8/Uzp34OrbERfvwjMIDbqi5DNb4eoMF5QuIb9TYCY
         LOiQeuXggoecva5IloHvrODVEoRXWxQft/ogZ31QRLrFwWMvcO0BUmDJ/ny2tYHT6vCf
         c7MVcNATPbtrM2slCafZG2uzKQeU9+xMdWaGcK36Zw+dE0qGOfexhRkJXw/k+8GPknFd
         7Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729013; x=1742333813;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x49RrI+y8H8e2leJnO29XuD2sUnGFNr6Kwf4AQYViPU=;
        b=Zdr0fgDxrNxsgfiFII+rqAOWYA9n8UP182HygYrswaINR6+wBSW3T5MPFQoZ3kvjHG
         CPZ4bfIQiyblt0uuhhdH0BPPRKb/3EowDcSJzilmYxqr2N2k8iCLQLhBWCV7Ed4eoKzu
         rl19Bu58iwKv75qMjmNPN6xet8EULsa+e1KBCPBscZ5KgW6ZpIdxMRq/takQjQ8lVErG
         CKFSyWQF3Ssw4h9b1/7eyfSSP89k3G/7o/d+UBvoNZu81MUYR4YfpLlgHRUoCPC5tSHO
         3hrpWnOy1dnM27a7yxu0xRTB8dwfKqGAawaKYlQuiCHhbd8iv00CJIGeO6Snrt2XbpEC
         2YMg==
X-Forwarded-Encrypted: i=1; AJvYcCWBI1dUAu7ArvPy7hRGmTs5yBQH/Zicpo+K5KICKY8H3kDtgeGdA+t2MfVZHYltvYxNm1cqhn6hAHiV3b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2/YL0RGu/og2qBWthYsld220iWw8+QRJke2MFC+Z8ALChVBG
	GEeHjy/DxuGkQe1v61O6Z/H6ZNNjJOaRPuXgp1rLinePmM2tpoYHMbUggSSRXxDxrSlCKAGCfXk
	/HdrdQw==
X-Google-Smtp-Source: AGHT+IF707m7mSPSEPJ18g9nVYQMveMRUqzHp/qCqbZlWYKZv4DrdCbj7BwpwXO+5c3lZla+2IjBtWNsAMmF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:48c5:b0:6fb:45b7:3b41 with SMTP
 id 00721157ae682-6febef7c8f6mr24077917b3.0.1741729012842; Tue, 11 Mar 2025
 14:36:52 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:27 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 5/6] perf test: Address attr.py mypy error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ConfigParser existed in python2 but not in python3 causing mypy to
fail.
Whilst removing a python2 workaround remove reference to __future__.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/attr.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 3db9a7d78715..bfccc727d9b2 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-from __future__ import print_function
-
+import configparser
 import os
 import sys
 import glob
@@ -13,11 +12,6 @@ import re
 import shutil
 import subprocess
 
-try:
-    import configparser
-except ImportError:
-    import ConfigParser as configparser
-
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
     a_list = a.split('|')
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


