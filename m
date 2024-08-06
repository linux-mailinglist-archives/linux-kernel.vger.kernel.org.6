Return-Path: <linux-kernel+bounces-275613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5809487A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C61C22235
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1510A0E;
	Tue,  6 Aug 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TAhbkbgL"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1561AD51
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722911747; cv=none; b=FlpBQ9jaHJAcEwjWagbafAl0pDK8Gng2cUE3CkYDd7zR6L/selCiiVWyMthkPIsvPcEzvZJUro2nPMB5KN5D+Z2HJzvSusUTStB1YKchAPSTkxpKOwHshu7wt+98DA9u2JgrUG+HMTA5IjIH+5OU3LaUPOpYLljmMqo9YkuKdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722911747; c=relaxed/simple;
	bh=qIg8yzlF2xZhvsCt/8paM2r2Z8UqmNY3G8iwh67a5fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gerOlcluL37rxRZw6koqomKGl6TarbgggGD7Kw6810GtStgC/Ad1fNFYeUMSlL7ATu2H5/fZ87OrhzNTw/xP0pSlZOV/8SlnLW4IrDgyyIx/wbRq7IAgkGs3fuTCMZw9VJ96H5KCFLql6hiZUmYzSJvROhI5JCiS0kU/SinrAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TAhbkbgL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd66cddd4dso2960215ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722911744; x=1723516544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCIdnG6JlOPVFpWP4R3rnPh1itu4fm9+2fAZBr1oqW8=;
        b=TAhbkbgLIiX3/riFJk39uqiAUnGfF5C6eoKKrrDvC31FjclSDdqiol0sVnlsrNsPL0
         WRjyRtvhZvuAbX7YFlKeUmhe5szOkPNPYguCJpWT9o6Qn4WABpARdvB/xmiFxPfvUwK1
         9qlXZsKQ2fkUaA/bYLgEWuJwDhavkt6c2ROXc3I/VIQWCzzrP8zJ9J+IYDTTEym8VKFb
         UGFxvnpjeTA4c6l4hxMUBCdfqXdLIafNeu1a0Gsbq9+tuhirDbI8Xnom5BwdUQE40fUy
         HpjiYpOZzq4BHpsZNw74x43+Dz4AJPLhiQwJ3awD4MWKDGf0QmR7d5g0HKsTT2wN0SEO
         kfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722911744; x=1723516544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCIdnG6JlOPVFpWP4R3rnPh1itu4fm9+2fAZBr1oqW8=;
        b=V44yv83l0DFbO38TlHL4PUWamDBXKD+5F1tDHA5Z5XFgu+i+K06Lo6IlgQoGuPufue
         Mcsro8M4yPx9+sXoZFdHs5N8D7+BkoJH0wqXXSkmf/EzW7+NNjidJhNoj5Q/Epgfwumb
         euoilKi+GX/0hqcvNFyoJN+lk3+lcbyfRRIpObRFKKFTteIy5IG35mf7nbjPF1ZOuG4A
         qY3QMMDOWwThChLNCqqsiXEa9Q2RbRSIyMngNNhkML6WiwnEzhFzLw1OsTm6vvCq6cgs
         PqCv5BCm8N6RqUuFe3LybOqGgshH+r8y5bwLUs5r+TCz11x0JCYdugOV4J1iBp6LRQ76
         +a6w==
X-Forwarded-Encrypted: i=1; AJvYcCWCJS6dlWkXdmIOqAJzij/Svgs1gMkHEvqJvjBpKYjQDKbxbaJoDaxOxp0i9Vrn1bOscZzS2nwBPH5aWgOo9eObzN5bP1SbRXIoxzJG
X-Gm-Message-State: AOJu0Yzd4m+UdsnczusOC5beAdZRv1QgABoNwJxTJ3bFdEUO2UpU/3RA
	wwnbbKYFh/iIm1/XV+R/iOkc33lH0orhj5yRXkKLKpWPdPtNTDadqPumeq6mV38=
X-Google-Smtp-Source: AGHT+IFYA0lBl/EuXvwzMNA/hmZojSyuazTamcGyj/T6TSZSajcF1WFR5fLuVBhzpa8nUkWGuA4B2g==
X-Received: by 2002:a17:902:d4c2:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1ff5722debemr181766045ad.3.1722911743995;
        Mon, 05 Aug 2024 19:35:43 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59060107sm75725155ad.121.2024.08.05.19.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 19:35:43 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] perf sched timehist: Fix missing free of session in perf_sched__timehist()
Date: Tue,  6 Aug 2024 10:35:33 +0800
Message-Id: <20240806023533.1316348-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf_time__parse_str() fails in perf_sched__timehist(),
need to free session that was previously created, fix it.

Fixes: 853b74071110 ("perf sched timehist: Add option to specify time window of interest")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..928b9041535d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3121,7 +3121,8 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	if (perf_time__parse_str(&sched->ptime, sched->time_str) != 0) {
 		pr_err("Invalid time string\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (timehist_check_attr(sched, evlist) != 0)
-- 
2.25.1


