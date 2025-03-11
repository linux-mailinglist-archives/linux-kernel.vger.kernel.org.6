Return-Path: <linux-kernel+bounces-556981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417CAA5D1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC19A3B9E78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49868265CDF;
	Tue, 11 Mar 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGehfEsA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36F264A9C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729018; cv=none; b=bGpxaVRWEvRxP2IxO44+wPtz45ek05yytKznDZfONOpxkLEcicDKbRqHNeRaAXd5NUuG/WIzTKdnwF/6NBtWa/Qdun62PWGJwhKX06c45nTsHVe5+pxcVQMwfMGDHy7EvTp+COZyTl2Nxb14otOfuz1nCVsbLgltVrqm76gBqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729018; c=relaxed/simple;
	bh=mLsQsEIO73xBmM9vsJ3R8Kz8fz9in2ymsfitS/Q+6AY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DRL0WNOtL46PWH007SvyHsxzI6acP1ql7D6Z/XRW5ETRwIgiba9NLNB79CXs2Pq35jZEPDGOvRg8jOYkyciRUSvUWCBerwVu1Ym9tgxEOQ/zjqI2tX7hGalsdYBIPHmvBG6nlJ2xYWF2Y+7kOTPWakBF9lrtcgKgpmgJ+Dz2RAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGehfEsA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fef9aaefb9so27066147b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729015; x=1742333815; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8gu1Di/zUmYbn8tyF2eqH0X4o4XUYppeibtvEPtbgE=;
        b=TGehfEsA9Kq+0Fcp1R3fkBNA0chl+X+vDjKayC3O1q8ZG0TgxM0M4MLuT6CkJJdHAW
         wMKGhtSgaaEl2kjj1S0tY0OL8im633QMKy8vCf7jNqhKPVUKJyUHRyCCB+dCWmj2rV2H
         AJMoCDhZNdVGh9Mi8EHeqsRNsPdWl9cYxh0x1v6gP5KvVEZLY9YLKh34P/LCOyA9BnJP
         xeg47M/WoGw1C8VXV2/j3wIdnkBGG8Zh0ftP2hkXbTLGaceb9YBFvyUUhSo1zoyXPZrv
         j/npBb74v+MJlkjoF7FG1vvCgEugrwWSDOy4L0kFWqGiLNeUgfK3msxoxDrJElAwG+YC
         nbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729015; x=1742333815;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8gu1Di/zUmYbn8tyF2eqH0X4o4XUYppeibtvEPtbgE=;
        b=kZXPpb/z/GGFFXmJ4UYJ8sPXFlc6d4IcCGxlMg7FsYt09Tmomw3LKAe0Y23/POVSBL
         daaWrZOitZgwUX3+uAgSPhD67wBJ4ysa+kPE/cQOytJfDXG4s2cXZx5bfCrFPzCkDryw
         nadBOBFjCWScnljBkyL2Jmuj7nlDFKe3TPgsaPSLkvxrixCcTVvDKV34s6RvEbqrld2x
         5iHmqjyiZtY5kF+tcBINCOhRZU0sPkmVLNGG0bBQAJTU7fbd5oe0iyUL/u/K1u/gtXvg
         sy1bfaN15CEbSV40wnWh+uMuh2OAb8ctc2TC6q2dLoJD3qAwJZTiYfiqthBarGvk/YBO
         nRow==
X-Forwarded-Encrypted: i=1; AJvYcCURhNdij2TeKXqOmsNXGLv9vNZ8Lj2nSlwq6AKbqtLdBZ2cpiSWxL+yTBVH1nxg8aFGxZgiYOwKAOvJQd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysflYP0LTtcUFkYWrBWlrGMypjl1jU5Ha1aaxwq+nWB+7I3Cqf
	0nAicJpY/lr7tgk9lw/Qf7HGLQvc4ih2/CIyd5omKerFrGlf5FJQWKN/+HiiccKn6SuGcvNIzAl
	niTjt5Q==
X-Google-Smtp-Source: AGHT+IEz+LFN4quqaR5VAHqEapOidJstD7y2hXW/NZNzazTPdcKioSLliqOChxoYmOm5OavNY12rjDD6Xthq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:2651:0:b0:e63:7636:bedd with SMTP id
 3f1490d57ef6-e637636c624mr1408256276.9.1741729014879; Tue, 11 Mar 2025
 14:36:54 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:28 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 6/6] perf python: Fix setup.py mypy errors
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

getenv may return None, so assert it isn't None for CC and srctree
environmental variables required for the script.
Disable an optional warning related to Popen.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 649550e9b7aa..dd289d15acfd 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -3,6 +3,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 cc = getenv("CC")
+assert cc, "Environment variable CC not set"
 
 # Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
 cc_tokens = cc.split()
@@ -12,8 +13,13 @@ if len(cc_tokens) > 1:
 else:
     cc_options = ""
 
+# ignore optional stderr could be None as it is set to PIPE to avoid that.
+# mypy: disable-error-code="union-attr"
 cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
-src_feature_tests  = getenv('srctree') + '/tools/build/feature'
+
+srctree = getenv('srctree')
+assert srctree, "Environment variable srctree, for the Linux sources, not set"
+src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
     cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
@@ -71,7 +77,7 @@ else:
 # The python headers have mixed code with declarations (decls after asserts, for instance)
 cflags += [ "-Wno-declaration-after-statement" ]
 
-src_perf  = getenv('srctree') + '/tools/perf'
+src_perf  = f'{srctree}/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


