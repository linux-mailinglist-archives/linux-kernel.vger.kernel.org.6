Return-Path: <linux-kernel+bounces-402160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391109C2480
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1891289345
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019691C1F10;
	Fri,  8 Nov 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT1cD7jw"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9CE1C1F09
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088554; cv=none; b=K3Ls6xkKM1HTMe6z7oRAqWKK+iDgigZHl5I6yGoGQluT0uLyPtY4uGxIuP6whI3hBMO0aO768sFEN7c6RylYN8oqQbpZ0jCHp/CdsjHPcwWgjnzdJP0Qs3lpq78tJSkVT43obPbs3IAS9yRz+uu6Cjsh67YeRqk7hFcMfAoq+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088554; c=relaxed/simple;
	bh=JR2W9BY58B7KI+DPucllOVM9yijzERRopT+DlqMeLCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BYj4qd8y0yH0Sd6NnufA6vZFJBm8Sdt/ONvkF+pEZR5jMk+hiUzTMJiJaaEiuEju7+Pjsto8zjLPFTLNytcCfmdb4dUJI839qHAfxXncrekPuibbGofwczeRCCyL82KBZXeRVOBbLnFi5tNfVtDif+orqchCiuLmOoib1mOVVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT1cD7jw; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71817b35f3fso2126479a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088552; x=1731693352; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=fT1cD7jwLWA7tYaJn8v1+GiQJ/iVEhBlcMx+erME+SKldW2QJJTsq4WqyALiESauTE
         uyiAntZHgnK6qAbqagZ5LuhXluMfdF4vBix0I5y2cKm5SchLqAgf5x1QzI1jmN6Gcv5/
         Dx7tGVp4LaG/qf5AAw9bQ0MY+6hla2xPwQJU2gmsAS32jyZiBi/AjTSLdxynXqZ0cR/K
         EAfVmxD73PUfV8CGTTAtOtK3JyUA7FYg6bc1EEbgqjC6fcgJ199z/a038uT/gml26bHe
         xEgo41w38RdhW/Kw6ldxdjWBd+1o54o0Axov6tBCth4Xw9T5Hf5ynJdXWyB/7JxHd6pH
         9cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088552; x=1731693352;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=kzgTJ/oo9H4WhXZfkbms6QY9Vep38Q2ytLkDljD42b4/XvAMh85ckVVBq+5BOD1s2z
         5o7uOioVNlPRM4j6C8PN4c9Tyc6W2lPPfMM+x/e8rrDOLcT2xsatzKLDw5kSPPAUOxeN
         fhfZFWmZKOHx0CMd6xtFK2IrLarqXhW6MekV12vUbncRC9giSgAIcxBRU/B41qpGVP38
         hY+72SXPWVWkUFkQZF89x5YOvnu0fZ8bF/x0OD9mEbukubR8gScopHjGf4zzqlVHNdNR
         7Jaupke0bMJBg1LTrcWi1wtiq9bBJfiYCroVY9PRbZAqalt5ytdcm59gMT0Vbh3SBUaR
         vrCA==
X-Forwarded-Encrypted: i=1; AJvYcCW0th5y81UOUlkWHAAhU4dcv7Ovtzgtli/5AsuyxaOjaf1YAMgArHSzvVPPiipL7dexWEU3te9VLx4NWdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7U8LymwLSiMy2Oa5+P7HCwB8LFwYrTxBK01VQb/aRqrID8lM
	n5i+H2fwEnECtGgvx6LkSdtLdZi8C9y+Dc8Gav3n9KYNK8jYF0h1OoDpzVuka9xjfrNeV8wFsS/
	C6dI2/g==
X-Google-Smtp-Source: AGHT+IEAWTZOnwTQFoToY0xNhAjfb0Ia0T03EjU5HdYouUS56VsfaPEHa+Wy7A6wb8fWps+6s7hfhOFdAc5/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:d885:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e337f844041mr2415276.1.1731088188463; Fri, 08 Nov 2024 09:49:48
 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:30 -0800
In-Reply-To: <20241108174936.262704-1-irogers@google.com>
Message-Id: <20241108174936.262704-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 1/7] tools api io: Ensure line_len_out is always initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure initialization to avoid compiler warnings about potential use
of uninitialized variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d3eb04d1bc89..1731996b2c32 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -189,6 +189,7 @@ static inline ssize_t io__getdelim(struct io *io, char **line_out, size_t *line_
 err_out:
 	free(line);
 	*line_out = NULL;
+	*line_len_out = 0;
 	return -ENOMEM;
 }
 
-- 
2.47.0.277.g8800431eea-goog


