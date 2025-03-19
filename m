Return-Path: <linux-kernel+bounces-567705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9027A6893E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB864189A623
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869C6253F1D;
	Wed, 19 Mar 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrkSzn/Q"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9725335D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379401; cv=none; b=m9a9fsHvh6vkGgscgMcMeSgjefRWBoRUE71M/+az/w1ZHSuI8MwmND5Ufh99jNOUwWEESG/yTkb4xHV4cWHwXnm2ztHsTAib4+SwuVtDOnc6dN7Ay7xle8Jhde+9bVKFkBCEhCW4xnPXv8QM3QhTlqEvSYO+rq7q3tT6AaHLo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379401; c=relaxed/simple;
	bh=73qH9kupjcKo/+QCqWZum12a/i6EIIrJ8vVYr/mhaM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUYxeivMtULwkZh71RuD8kXKG1IypIVAGfSffkgxCF1YBbyfMIYB2Jc9A0EWowojOiTC8jas6p8Zsdo7UuxKRK58PutK/z7TZSmwBzlr7hvSOWCKxiLxJPnj6DA1OYwVaMUydFhuslqrbelC5BH9UWv65zuQ69tNawJPyPfAc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YrkSzn/Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso29645955e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742379396; x=1742984196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTPIZGzjZ0/Ur1/7O/E76kCbNyjmi3E/Bqq7iXSjCV4=;
        b=YrkSzn/QWbxkyfLSwlvkPImsRpGMC5ksyEgysiDQ2vZCmppYrlZ2CMR19XPIM7hhWl
         fRcxzTOQms+f112wlZuvjkSGjgB6CpbXxyB3vgucV/+MwAmquF5sxFwYA/DsiCJl1HTq
         097ks7e3RLsRbY3kWglk5skOL0pw59NEbkQxsaZT9QFfDmYE2R6sfRwaCvs6AOIeYsiQ
         XlHF2J30eZ86ctvkgQnMbAOIdHWylOn4yuv+1FwyIRiVadj9oUGDHVxCgXGKgLPvSewT
         odqQyX2aF9FU1OL1T0kttXZomMoyCLQck8vRceH3fQyAmWn3Fb+zzoDVXmccuFUcKyGh
         SAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379396; x=1742984196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTPIZGzjZ0/Ur1/7O/E76kCbNyjmi3E/Bqq7iXSjCV4=;
        b=cfw/SHRXgd2Ch/lDQRmFEvSGzGvENKJ6mLkLJP89jcLpLhWL/3RSk9k3CZX4875Myv
         o3Amxb+5EkwV3QLZInlub3DW19jjhWK1Nq8HM7XYFLT1NfbZULiJQ90gcsYwv7MST9xA
         l7SG7sE+r5a+27DDz1FZ0x19Gg7T6imx2gyj56ATR3zAI06aAIUA7fDYQwJceQVreisD
         s7HZFvBWYjoux0Z/jGaGBj4QSXBkFgOs/xylU9v2Jk1ccsuHWCwgm1Ed36vK3sE/tlNz
         REqxc1rWDF3JV2DcBQ9ya/IneXXHozOvCe3T0GVVA6RMhTv43dCp2KGYcVb5+8ZdtKD2
         /X+w==
X-Forwarded-Encrypted: i=1; AJvYcCWg8Qh/1dO9yBdXi1HaD+KjXf8nq1Q6lvDV2Uqvye//vZ48rXCJeeUJCk3XQ65t2QM/5FY4Yp7YcANAsAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6T11c+cVEXAv0F1lNYuB3oZJr9UHdTqN2aXd1jARBW+0N2qd
	A1yNa6LRyyror/UR0nphyEdTnNqxtKVOeKZawRyqSVy2pU8PtedOA2P6U4QCTcM=
X-Gm-Gg: ASbGncvZ8gxFA86GmAV3GkiyYaASoGiztUxn6+QrEotRxFpOiJhIqNEmtkh5hU6x9Hs
	eFqXMT/X68WaZliktlPId0WQ1CsJBqN5k65pxfGOY9ARx3mldQFJbv38hTZAm6Z5+9qIOHobXSS
	3uuWZQuOKUOPqN3WoVt6sFArt73YyfK+r7VfUBs1Vg2g0KAVFzYb4VdoXALADzbDGMfzaq0mKTK
	LKf4NcU7127C6GG8eRGy0C3dLnhLtgMR4drU2Y2XdTMcnpsc/ghqij75c8DFS4f9pgE1y5f07ZJ
	fwDcHbfaVhVZz9QuHZAV0P8Fhb2arBQoEhnZDG6tTuFa44lYKEADMHxagQ==
X-Google-Smtp-Source: AGHT+IGidbRkyN4fpsX8yXNIbim2xYIaPUHPGDKY9qwe4rkB267sscnqlloGOWlyhqEXPwPJpvgswg==
X-Received: by 2002:a05:600c:3c87:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d43869a27mr11135355e9.28.1742379395971;
        Wed, 19 Mar 2025 03:16:35 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43e35sm14302995e9.14.2025.03.19.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:16:35 -0700 (PDT)
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
	Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: intel-tpebs: Fix incorrect usage of zfree()
Date: Wed, 19 Mar 2025 10:16:10 +0000
Message-Id: <20250319101614.190922-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zfree() requires an address otherwise it frees what's in name, rather
than name itself. Pass the address of name to fix it.

This was the only incorrect occurrence in Perf found using a search.

Fixes: 8db5cabcf1b6 ("perf stat: Fork and launch 'perf record' when 'perf stat' needs to get retire latency value for a metric.")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/intel-tpebs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 50a3c3e07160..2c421b475b3b 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -254,7 +254,7 @@ int tpebs_start(struct evlist *evsel_list)
 		new = zalloc(sizeof(*new));
 		if (!new) {
 			ret = -1;
-			zfree(name);
+			zfree(&name);
 			goto err;
 		}
 		new->name = name;
-- 
2.34.1


