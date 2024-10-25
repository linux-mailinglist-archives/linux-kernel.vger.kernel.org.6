Return-Path: <linux-kernel+bounces-381322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF09AFD9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B2EB24BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9B1DD9D6;
	Fri, 25 Oct 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ls8df0w3"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF61D54E1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847025; cv=none; b=HmWWmUTijN/skpO1ktWMkK+CuosIRpgI8xbfGdk/thAlWnnf3q4NMrMEjkxuJfHOxohtrpBStjjyqVK4b50Xhbs18DqZTGsavubruagFdceFazLU6lInC+e73Ief7X2RhEMFZnI5bhAAleUQPOyowP0NvLZnGQoQg3JDta6eTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847025; c=relaxed/simple;
	bh=fRipP0VupOjbutNPJpp1Ks0QKn1SzrbAH6lSGoJ3LW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TprbuYeyQA5bJmJ/qBQ5AIfMx/HHlzBukkdYbg9B1+e0W6xhMMtACzSFRrjiVCXayYZAbq95s3EsbsTQdc37r2Gzt+z5eu3gZlZIGDq6HFMVK6UPN+KEtVHUoR6g6GNW0HPlM5WwnY801vkOip5rXVuzPHaGgSlBCcn4CjTYkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ls8df0w3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1321328f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729847021; x=1730451821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01A1j94vmhd+ARl+zBAKJGbXXIGCTBMufeRwg2gBhf0=;
        b=ls8df0w3vkAx4ZWEA0QMVgI6+n/J7x3tNpawaukf48n56nSO1vUc8/lSt66ulN2IF9
         vuhwEd8fBJDKdoIVOtsJMJuGrtgTv/oinxYqrr5Ue6+ouOx6eqX65KW4KuTVnIf7Eo2E
         /JfWnM5zoZ8jjCmJW4qu1RTybZbd1liENy/nGDnDF3vc6TdvJ77/cEl3aA+ZC88kZmkU
         qaF7wS0agnubxy57NW07XAVT4LmghQxP6nWAsGkcB2Z7rkUOWgSJm/3h22uT7dznt/p9
         NrdLiGWFPTS8LaP9X3KdBf2DEecJgz1Sj967RKEcKijnLwIS6kcanbgUryuRutrNy4dj
         Q3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847021; x=1730451821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01A1j94vmhd+ARl+zBAKJGbXXIGCTBMufeRwg2gBhf0=;
        b=UUGOBQPkDUcsKlemltslzhoB1qOG1eAnWsFfaKeFhIaFhF1oERB6YGosY3xqnsKH8K
         h+HmRMLKhNCHn5ZRxC24HOhjf8hAIU0QGow2llSe/KMjyBjHJd+9gQOJ3I2k6GHhsGP8
         BfQcwOVnDGOtUj91ZdQ1rFhcH3HzbKZRg9ayrLNvCjZEK1Ikpvmy3mahDzVKz0+rKADq
         z3/hwHfIMxk9vhR8o3uDPy0tgFhaP/anhuXwTSTHBI5NgZzChUoWbk17owYVp8DlqbFx
         UFxMrwwGVct9YRQwpvzyw9fahIaVenOqNSr8Evk2YVmDPiaZ+TSl1n3CbW8thYNrNj7I
         IJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUicki1I4rCDrQXYL0qYL9SH+mZpznRcyF/ml9lPq2aERwHbULi6+GAfuBRs6L5K0S4AGQIb9dSytw3s/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMAzDqhK7SIuFR2St9WJvnMwmatBVJP0foErNVwCnp77wwoHLi
	VVJkbyfls/5nB8ajSRLwchKe7rAjXOWJYujG8Lc12obud6H5XNfi6NU1JIXJn78=
X-Google-Smtp-Source: AGHT+IFzkO91rPDtKnROlYlIiYOGngkrNk6KEIKDxXZg1cjlw04ELYhDD9KA0T464/wEBQtr1iKAfQ==
X-Received: by 2002:adf:f581:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-380458f38abmr3019953f8f.49.1729847021421;
        Fri, 25 Oct 2024 02:03:41 -0700 (PDT)
Received: from pop-os.. ([145.224.65.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c73sm988689f8f.72.2024.10.25.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:03:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf stat: Also hide metric from JSON if units are an empty string
Date: Fri, 25 Oct 2024 10:03:05 +0100
Message-Id: <20241025090307.59127-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025090307.59127-1-james.clark@linaro.org>
References: <20241025090307.59127-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We decided to hide NULL metric units rather than showing it as "(null)",
but on hybrid systems if the process doesn't hit a PMU you get an empty
string metric unit instead. To make it consistent also remove empty
strings.

Note that metric-threshold is already hidden in this case without this
change.

Where a process only runs on cpu_core and never hits cpu_atom:
Before:
 $ perf stat -j -- true
 ...
 {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : "0.000000", "metric-unit" : ""}
 {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "good"}
 ...

After:
 ...
 {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
 {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "good"}
 ...

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a5d72f4a515c..9b7fd985a42a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	if (unit) {
+	if (unit && strlen(unit)) {
 		json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 		if (thresh != METRIC_THRESHOLD_UNKNOWN) {
 			json_out(os, "\"metric-threshold\" : \"%s\"",
-- 
2.34.1


