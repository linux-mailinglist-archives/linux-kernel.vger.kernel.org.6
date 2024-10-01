Return-Path: <linux-kernel+bounces-345871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0398BC32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB9F1C22453
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826371C2442;
	Tue,  1 Oct 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHfalpA3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FF1BE86E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786215; cv=none; b=LCaqq70KV4rfuSqWmU2kMABeqrsEScsHEJLJhwN6+bCkE1WAb+eSDvvYgJTSQcMqVwNCjges0medOAUCgP5m5x3VB2u6/MEa/KOmQDcd3QxYQ/qVCUcEeZTEZlGXAoeHzmaTiQFUpBsLlsqn3hJS+WZnbnFR8NScK513bSUU5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786215; c=relaxed/simple;
	bh=eybNQXdLpYW5i4NVQlaeatFpoVaiFm2ZnZvyrdS1kq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+1wWml5pF1bKkmW52vQlsKr7JHSCfqJY1iuTq/MDMgIn5FMNC37zHD/vf1xKDcNOjbyciixre7t5ikHKY1/5Q08jvi3KcAO2r7Rwt4cglNSVZDIuM9kKYxFh2e1xAPMXdSRRuEM2SZfY+Ig5ZOEWwSALwIIRxBie1Pj4TZagVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHfalpA3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so49883495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727786212; x=1728391012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8XQ29Ev1z3ZNIlBXEVIBzyegIpbEqZs9xlXmgo7XMs=;
        b=RHfalpA3Xzj4Dm6mrIyb3MUhS1cFuW1kNn8jzrhbu+v+pL1ZZmZOuJNTehcymDlg5I
         o0Y1nJ9WFAzgXu/fS02bXezt30pSChNM+kMQtXiNnE9lbLHniOyUkLvKNSr3u+ZXDmY/
         uOhSWlY89Sld7m92HIJ8Ns1efbhfhpYGz9ULPbC9HZ/AYPaQ7NWasTOaYCA9h0UMuxkK
         AdwGtG7B99JqAr3LLZ4lJg9s+B9GxcPJC2odbCgLu8ztGrjhWKS9xADvfoBuFXCPhcaM
         yGhlBGqN6g1OHt5qFm3jeZKWtVvfCUuiJ/QzVfmXF5cXCTfrX6xidj6tgJsCSjP2JvNR
         ClhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786212; x=1728391012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8XQ29Ev1z3ZNIlBXEVIBzyegIpbEqZs9xlXmgo7XMs=;
        b=N1g6kijvBdarpMUCf3gXQ0xPRpg1M+KxKwEghAx2XfUxukCjCE/xanaPWz8Fn4W7Bq
         Pj4+Vi/OyVoXmMjSU3rJq4E+gN2lffRGmQPfnTDaf8DXowCF2PLzKyYYSPloQKO2HY4e
         GmAsuU04kWgP8ygbQjhlSvDrQHdjwJ6H07/PhG7R4MLSgBBFHgTWSd1tZCBzo4ZfPHat
         EEoYk94zrkYApidwVU6Br3AkClVE76+WUDOmpSYFHH++3tGmHh2DLwhMznvbpdMkjzOg
         0IJIODkriDBxtodufDRWvXX3Dr1VMVjxmpeH67281JdeESO7SLEvOXAuT4ARLha4ncPr
         cLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbdbczmLn6gqL6CNlhMGifa13z5e5sfNT+sq8mSHJRklGYAEKvTT2RL+qtD8AVPx2UD4Btan47j/FzC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCBVXpN2KnJ+mk8X3L4IXeeQ6pgHfgpjxFxMeClCC6josVbOF
	ZqWPxdNfspbQ+DJYPF3ifJcA2koRxlg7e53UdZrPuDTdaVEc9d2GYIpfyBT1jUo=
X-Google-Smtp-Source: AGHT+IFG7IXfEGF5ftViJBmZVAZL2Iklu38AJ+yFgyVeDQsg/kv1idzpQVLYVhL5YhLAcAFb2dd9KA==
X-Received: by 2002:a05:600c:a02:b0:42b:af52:2525 with SMTP id 5b1f17b1804b1-42f5844b396mr131572065e9.16.1727786212508;
        Tue, 01 Oct 2024 05:36:52 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36244sm180942325e9.38.2024.10.01.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:36:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf dwarf-aux: Fix build with !HAVE_DWARF_GETLOCATIONS_SUPPORT
Date: Tue,  1 Oct 2024 13:36:25 +0100
Message-Id: <20241001123625.1063153-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
which gets picked up in a lot of places. Without
HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
errno.h to fix the following build error:

  In file included from util/disasm.h:8,
                 from util/annotate.h:16,
                 from builtin-top.c:23:
  util/dwarf-aux.h: In function 'die_get_var_range':
  util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in this function)
    183 |  return -ENOTSUP;
        |          ^~~~~~~

Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback function to handle arch specific instruction tracking")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/dwarf-aux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 336a3a183a78..bd7505812569 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -9,6 +9,7 @@
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
+#include <errno.h>
 
 struct strbuf;
 
-- 
2.34.1


