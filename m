Return-Path: <linux-kernel+bounces-441010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438C9EC7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DF9165F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D461EC4DB;
	Wed, 11 Dec 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJZIZlWN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082311E9B3C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907359; cv=none; b=HjnFII2DYLVUyR+RoTYUr1DCM1A+k4CTr1cNZT39naUXyivSQOUE6H2AGn7tTvJz9PTmjUn2dm0CZq1z53Xa7DGmaN5eYcDtW89k1GkeNnIzLjvWGVZHPddEjcGWmhB0+G+QJStsADAwal+RpNu1M7/uhthNSrdkZKi2Ao20lSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907359; c=relaxed/simple;
	bh=jU2cTye6u+MqjljYXpav0xuajR01RvYb2NHvhER20GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lIsa/Yi09s8Qm2QVEskD/7zfBrbPPPKkFUT7slhuf72m4pdIUhUvdhTVnH7wZgiVhffzIoNWq0GHQgMyW6Gthj0FcYGUlrPRJjdQzHP2Kl9/Dc0Oy3PCSREr7PdSC0XqNL9gOulhgthRBbgzVw233UtGEQE2a4flDLiR3/OtwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJZIZlWN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361ecebc4dso1694625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733907356; x=1734512156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcHQmIuxvuepl+FXqoONmaD12Al+psUsKwLo0YRh2mU=;
        b=NJZIZlWNYqOiSgjbqzuh6QzfZ12zqaWvN3cJoB7mqGcn+6W0KGd0TV9aU69ezJMMMM
         xbC2Zv6ExScE40T5/nIhbi0gVp7qsieXwJF0Gm8gxcdm2eJ9VF8QBL6JqlKKsvmtpCd+
         mwMY6ZTou+gBhH4InjQe+1QDxhfxUNUjxz6sXTtO+7KjK8e5yzkDfykydzi3LojRisI6
         7NDWdRI+t61bY3ZdQOhMqRugKpDQcmV4A0jPpwkwMzeKdHA7B/OD+v61cAqZNcy0a3SX
         tLiOvnbOr4ExCPXNmwRP4rNgeBrCZMMY/pk2euwNNJgkkq1wpSEDRF5HtifdpnDcIRGy
         B8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907356; x=1734512156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcHQmIuxvuepl+FXqoONmaD12Al+psUsKwLo0YRh2mU=;
        b=njH81j8hpyp3yl0XjMF3IewbzyGuZcV1dq3jwRYlGHs4w33aK0FPX4qKjRS58XlL9M
         lSI5mGTYuOC5EAKHTedSNhW/uWfFBYtudJZFRB5ETSv7k9qIvd5G3CJ0mjmvDvoISfnd
         f+wtAws260Cv7HErHeYTBA2TuH20od8JQ+S2iNjJXQj4gdVWJ3SkpPOZezvoK4hXhcpN
         kWTm+I1N03FZXqwuVWwKgSX/LFMiy+Wk0VlWNsGc7kVH+Uc+TWR767C1ZikkzMISbYYs
         lmqQiDVm5VCfpKg50A0KxzU8VssHbnrfp81jaY61LQzRZ88j+2IlFxbbzU+Int1aK0zw
         sWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqjl6qkSGFyqidstvI6PxBuFAiR3D183JrCx734lvLwT2gu+VGMSidn8f4a8x4+APwCsgn0LGikyn4Bug=@vger.kernel.org
X-Gm-Message-State: AOJu0YydadDM51mzUoGySZNu7Na6crv98R0PTT5ffjYZiAWCJFOMuXUm
	APr1qMIjBadG9gP0GM6zrTiH+OfRTgJLU880tnTR6XGq0oRMuPqkC/Mk7nMj250=
X-Gm-Gg: ASbGnctQ6cgO7B/m20YK4WO5tQU91LPRxKUR8kZrg91D9kIjA6JSwYf4ZChCinjCSw+
	EQh11JrC0GDnQ8XnxNmE8Rahn6sZDqjxKJo2iO9SM95wN6rbUnIO+Oo5LprEAxgAtwwgCOE6oL3
	Cl5DARaaovfxZeOVcb45GIwcSCjPDWjDQ2ccP3OWN1GjeMZ4UnxynQXqz76lkaJ2XcHDsq6Aw2E
	VT/bG0wcFjKe2kYwclS7vHFBEqg8uCe03KLlbsS9aVFApoqByuXJ+A=
X-Google-Smtp-Source: AGHT+IEIfgzMHSJgClgRVEQhxy9voa2z51hrr/ck8y11zNHvU33CoGimomwfzx17Egq7xD4wppeDWA==
X-Received: by 2002:a05:600c:3108:b0:434:f953:eed with SMTP id 5b1f17b1804b1-4361c4406bdmr14985805e9.30.1733907356354;
        Wed, 11 Dec 2024 00:55:56 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm257204185e9.44.2024.12.11.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:55:55 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org,
	mhiramat@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf probe: Fix uninitialized variable
Date: Wed, 11 Dec 2024 08:55:23 +0000
Message-Id: <20241211085525.519458-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211085525.519458-1-james.clark@linaro.org>
References: <20241211085525.519458-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, err is returned uninitialized due to the
removal of "return 0". Initialize err to fix it.

This fixes the following intermittent test failure on release builds:

 $ perf test "testsuite_probe"
 ...
 -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
 Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
 ...

Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
Tested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6d51a4c98ad7..eaa0318e9b87 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 {
 	char *buf = strdup(arg);
 	char *p;
-	int err;
+	int err = 0;
 
 	if (!buf)
 		return -ENOMEM;
-- 
2.34.1


