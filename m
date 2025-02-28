Return-Path: <linux-kernel+bounces-539555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11136A4A5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EB33BB46C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3101DEFDC;
	Fri, 28 Feb 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPSipR7P"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3861DED53
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781435; cv=none; b=SEmqasZVjgkpcTEIRpkqt8pyjxOODDRO8zerdXQuQdQedsKashWjU57oiM5oYEOQ74cSHv5Qbx8i2IIZUZ+SkYa/AA/pM+mY7ph0KvGDZiE9uulVEnp49oTvLpv6qWOKrmK0t6gYNJoaWLMMj1tb9thH/LM0Q+olHoBaSoshZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781435; c=relaxed/simple;
	bh=txn0P05cQCFrXxSXwvz56otvn2hrpJG2Johc1iskpbc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=VqIH+WohADTmRQa4QJWnfVSqIHwEYtUzBGPMuFEMekDor0DIeEPU9DicoJIHw0VWwzptTBX/+lJNF3jfPHrC3SdB1fMYEEBK0Ax/8mBoYbOfcjcY3m1o+IK9fjzJuFeMqzgQh2HnqLoX0vNxu0hPsWVGITTqxbNO7Ss7T5tVrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPSipR7P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fd4e4c7e02so16470767b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781433; x=1741386233; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT+nPv2tYgupeaKy7eqEuPRMTJ57BlbBsuhS7nbNqeE=;
        b=qPSipR7P2rgdkG/kWz8lod+lLspE/S7IGk14hKCkvsVvAe5ibXNIPErRHX7GkOGb5i
         4+521Vrrt9YYIMgJVCV7Oq7ujgz9mk6unRvIs+fcDAgCQfWfXWmrC5Pkjqb66eZCW+TS
         lv40dFw87VKaSmuGZgbGoQaZ2VjubNCicn7xYq+wQWwLT+Muv/VEwV8NypRwm6tNDgxq
         qo6Cq6o8GkmtnmQm4xL2RiiNxGiMWs9W9lG8oVEBzS0GINenKctMvVq8BEU1e8QsLrD8
         85Mn2/zNUtbZbqIXglL9QUKA04UsOvV+jOraPd17aUGzxtZ/QnWMKB2gsx7hYrk2qbfy
         Atfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781433; x=1741386233;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HT+nPv2tYgupeaKy7eqEuPRMTJ57BlbBsuhS7nbNqeE=;
        b=m3uIa/xdPMnAosFvav4Q0mr/oFA+9ZDDSHuD6s/B3oaGJhMG3SYzwWgNaI0Q1BQ4LD
         AAIhRuCf6FpIGbSLvDNqhnE1GjuhlQRVYdG/bur/JosHwK3ctxhIX+en4A17swCVygT5
         T7nuaFXAbIgENxrtWBH+PdoUwLCBoNXQlX22/nqi852t/jCkOO7LH/oCf6bCWXpissVO
         YEF9D15y1IixJvq97erexeGjOMVIZ2++VwMZwIHh98Y6m9s4h/IR660oPBC2UpxWdUqG
         W2gfQOARcN4IHs9LymzCxaVYW27AAJ8F3tpUkZszInNHV/LJgiqCpSwStS3f8p3panjo
         I29A==
X-Forwarded-Encrypted: i=1; AJvYcCUCVf6btGIWJhxJPkQejXwtXPeJqSkYM0vgKJWBxsvSQay9puknsR+h3POJkehGTWjG2L1mcEb8ZtSk4JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxABwpJvtsjWDoe0nQekCRXBaHP5i0prNJy+0hgndMs0boJcaVS
	JgiCFpnc+ImNzM+LVsLFJ+GY84iuVlzBy5EHklJr72lmgFnmJBXF76uSGNbY5vifR4P+/c3wAPi
	NzdVJKg==
X-Google-Smtp-Source: AGHT+IGMXYRBfiYKFmm/2HsXNIce5dF6aVnsil7+fnx7h+OYMmaozsXrjJsnVHcWdb0mTBHmTv3e3OdlQMjP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a25:aa90:0:b0:e60:a52a:377a with SMTP id
 3f1490d57ef6-e60b2e817edmr57514276.2.1740781433136; Fri, 28 Feb 2025 14:23:53
 -0800 (PST)
Date: Fri, 28 Feb 2025 14:22:58 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 01/11] perf debug: Avoid stack overflow in recursive error message
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In debug_file, pr_warning_once is called on error. As that function
calls debug_file the function will yield a stack overflow. Switch the
location of the call so the recursion is avoided.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 995f6bb05b5f..f9ef7d045c92 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -46,8 +46,8 @@ int debug_type_profile;
 FILE *debug_file(void)
 {
 	if (!_debug_file) {
-		pr_warning_once("debug_file not set");
 		debug_set_file(stderr);
+		pr_warning_once("debug_file not set");
 	}
 	return _debug_file;
 }
-- 
2.48.1.711.g2feabab25a-goog


