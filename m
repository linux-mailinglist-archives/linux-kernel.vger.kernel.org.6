Return-Path: <linux-kernel+bounces-280726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9F94CE0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0F21F234A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77819580F;
	Fri,  9 Aug 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iH5Ib4GO"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9B19309E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197285; cv=none; b=WBnGbNu7vsnhHCgeVIPBGK3+VKwyFKo1mnehfq5Ccjyc5zu1h+lddfvMAFJ6qO6g0nQAhDHUc+4mASi1bLeipy+uI/RjLmmmzN/Jy2fE7eIY8a3agHFr24cv1G9GblV0Ngi3ve5NegA0um2k/YQEAQUovVvaUTjQf0Ee1b/6Kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197285; c=relaxed/simple;
	bh=8nN98tpzOxdJLkBol1d2DI55X2A4qjjQjWbNntYK5SI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/X8V4R7QNKPlgGP5nhI2vjy5bssq0zkFRQ4LB2iz7x83lO9OGNJP3acGXqimc/Ky+rAv3zVUOBxPVvMKj5Jadjh2QUjTh1zcLD7j/SLXTxgvXbngn+wK4uMOFJ2vrLx1Q9b8Kng8o0hd8R7LPQKzkpew7JpwULo+FI3r2eRrEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iH5Ib4GO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3685a564bafso840205f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723197281; x=1723802081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EU6S757EEvdN3w56oF3eehAgxdHj+bjsMSmHNikXzw=;
        b=iH5Ib4GORwrmjFpi5rQEzwIXrGyfM3tSro1TBRuzalo4YeEBPSEzoEkQBGyH6L9/ly
         YDdBPPwJispvsUDOdtuZf8l7y9xCeWh27B32wKYyoTV9xxDgcJYc+qRw/kju9BH42ET0
         JqZuW1cLOGNXTWyVpZS0pTxqfKi3uru8uwKKQMQERTfWaX0wYgCoGsU+d5AhkJbxyaj3
         M/Xc3a3rr/1pDi/NIB7Px7ing0BURwDtbLSNMNWnJuCg8W25560f0yAc3QSqHdDIyYPr
         uvWWUZ9BNroQTzRM6V22dev/Jdb5bgSQurw6TL3n6dqBWo+bfPvDsPs47f81Kw4DbAfi
         aKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723197281; x=1723802081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EU6S757EEvdN3w56oF3eehAgxdHj+bjsMSmHNikXzw=;
        b=tLOlVwhRv2rU6dYuiEYtphdkXt6CLpWtvaQts228Pco6briAEd4McXqh0cLM73XBwX
         o22fa1n42ZybA/eZAfSXUJzxKDze9BCS811VGCJj5JPZtoMpowvkwXOA3imkedqTifOT
         oQwA7jjHsK/3pcgmwTE2N4XA+n4AOp3oxR9Hppeu9ZUYRG8AxFV6bP+ZtwL2vfrAArt1
         pAyCXQYYbmaAMljTSsIB3/f2SGTCFAHaA7HRkH17DjBezkHQ5uWEx+OF1B1CPAgb8KTV
         YMrDPjyGETLF1wdgCfPYpVNMnIHPhUqn/k0wFSi/VMFujVhSSgFNlmBRmr3Qqvq4FRKz
         YYag==
X-Forwarded-Encrypted: i=1; AJvYcCWDhGZkJ9p2/z4FJtdJDOUOwW1aGtAknjulacDQxGpjnkAghx3s3Gtc9Bq2tvEeTuF1y3Zajto6/4N9p88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhNC6EfRtwQ29yS/+Rap9pkBS/zaO9n2vammRrgcqAwkdgrdd
	5hNle6RdsIdwe3KBY0YvT+FzMcsWE96yoZOf5RbHPQ7azuwfIvu5aMdrduxIwpQ=
X-Google-Smtp-Source: AGHT+IEbbNulu8afLxaQLN8NWyJIZFYrmXQldYKP8toTLqGaJ8C2nI0Wqby7kdrFsbMk5339zxnsKw==
X-Received: by 2002:adf:eac7:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-36d612f11e9mr959936f8f.53.1723197280917;
        Fri, 09 Aug 2024 02:54:40 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2722969fsm4786562f8f.105.2024.08.09.02.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:54:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test trace_btf_enum: Fix shellcheck warning
Date: Fri,  9 Aug 2024 10:54:22 +0100
Message-Id: <20240809095426.3065163-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shellcheck versions < v0.7.2 can't follow this path so add the helper to
fix the following warning:

  In tests/shell/trace_btf_enum.sh line 13:
  . "$(dirname $0)"/lib/probe.sh
  ^--------------------------^ SC1090: Can't follow non-constant source.
  Use a directive to specify location.

Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 7d407b52bea5..5a3b8a5a9b5c 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -10,6 +10,7 @@ non_syscall="timer:hrtimer_init,timer:hrtimer_start"
 
 TESTPROG="perf test -w landlock"
 
+# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 skip_if_no_perf_trace || exit 2
 
-- 
2.34.1


