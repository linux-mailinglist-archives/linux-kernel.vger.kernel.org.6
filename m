Return-Path: <linux-kernel+bounces-307162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B896495C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EC7B253F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6531B14E1;
	Thu, 29 Aug 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBB0GUsC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17F194C88
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943740; cv=none; b=a+3hFtwfBSRokScNlQBc/uyZT9czpfztcNFXbMDDOKZrJ5Jt+MwNoyokM02o7JxdGRnS8sTcEuODekYpl7wKQ2iYyrB/og9+EHzmQE33+14sGgKJGIFLYOtbBQIZ4azKEmn4cJ2+jkqi85GH3HEkZ5LG9XJ/vU3fIJjvZJv1lvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943740; c=relaxed/simple;
	bh=nYv2bb7XfxKNsp6iwHeDKTU8xBSx4xj6FD8P1aDgmn8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pE81w33aYlalRvrrXe7V/P2CpRBNfQyPAer8rEyPK+etVe9LJEoj+erseCgY4doVLQu1sEs1CUg7lq2KpqpRXjrH/sNwIEgHn09n1OOHFnMWebqi+obACRGCOEFJFYYmt+S9593mncg2bWnuKvrVe+nvT1jYAfhx6/5nO8ksX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBB0GUsC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad26d5b061so15501367b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943738; x=1725548538; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M//MoxYK0AMxszDYFN10l0d6OyzAze+JY1w4Q9ZCo0=;
        b=WBB0GUsCEttr6p0XLWCo5ugJSCPTN0OJ+X3rJ1rpvEA9BIkMn79606RBmtmwQHndqu
         IPCYyWUQWiQMVc13ReC/e8ZYguzIWYOJ8NfMHzsmVzT1gP6U2TIigchmDvCxrfvNN1qy
         YeD2CsdfvyBMLDmRKpRJdYjmNUhNaXEnF9jYKnDg/uZQlj4Vt0f04VQZ5bfgVUBYhQuE
         /kLOTmGie6tkfPkJmE3nwKs7JLkCiF3NkWYFKzATQIOwHtsxEa8IkVYcKcs6Rd9vq2rd
         l8WNRUMWF9m0xExdHuBA2gRXvHHFyAm0n8/4f4x4K41V+ud9C15F5v+UndkUAMUX03QY
         +A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943738; x=1725548538;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M//MoxYK0AMxszDYFN10l0d6OyzAze+JY1w4Q9ZCo0=;
        b=FauXIpVJ8eGdkKiB36sSAtqYQBbuQlI/fX39IjHC3IPi2uzCkjJ2NI6kJpnfLVzGk/
         YcuU50lE5bVKxIJSFgKD2xMytlwLyEzhRtJL0mE3JJ4vBkxxuGS4sUoVCOzvhTICTtNd
         Qp3xKNC2mQmqC76GXj/pgY4xLeQKCnr7S0iHIM877C29B92wDAfeRqC73Sx+/po0jV5k
         lwkPeBnv8YmqOcnMdJnt7LVyR/VI85K47xJXNCgHe/TY62PsElllGgUknMl1lAsc/YJ+
         aRaZgFeztvIu1n2Ta+TmLomXQIklkxiNQrlY629Y/7vujWC0KviwbIWEjXZzyJUrCo5j
         k42g==
X-Forwarded-Encrypted: i=1; AJvYcCUDs03y/XGLvHQeDW8aeLOLj2crBYBWSuAu7W5c5PJievn50533LcVo8uW3wR5lA7VYZqJwx3w4EAhd83A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCC8TgMD4AKUBJ21xd0rwZOQgFvz2wE8FMhrAt5SkoSfX3QhK
	gAyRWjt16rNRQJs28kE91Zdx2NzXmITVjDe+UmpsGN3vU8aGkvyTr2OYPHtCRIkJVQt/Hs0D8Vj
	My5U6xg==
X-Google-Smtp-Source: AGHT+IHTmW8LfezKDBeNm1GiRh2MPaQCchyadCn8R7N6d4J0bgs53naPpqo8zLJglVVm2o8I/SAtbeInsOmc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a81:f007:0:b0:64a:d1b0:4f24 with SMTP id
 00721157ae682-6d2e93d5759mr637667b3.7.1724943738109; Thu, 29 Aug 2024
 08:02:18 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:49 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 3/8] perf header: Add kerneldoc to perf_file_header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some of the values are a little strange so add documentation to
resolve ambiguity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 07ff647197ff..3285981948d7 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -61,14 +61,28 @@ struct perf_file_section {
 	u64 size;
 };
 
+/**
+ * struct perf_file_header: Header representation on disk.
+ */
 struct perf_file_header {
+	/** @magic: Holds "PERFILE2". */
 	u64				magic;
+	/** @size: Size of this header - sizeof(struct perf_file_header). */
 	u64				size;
+	/**
+	 * @attr_size: Size of attrs entries - sizeof(struct perf_event_attr) +
+	 * sizeof(struct perf_file_section).
+	 */
 	u64				attr_size;
+	/** @attrs: Offset and size of file section holding attributes. */
 	struct perf_file_section	attrs;
+	/** @data: Offset and size of file section holding regular event data. */
 	struct perf_file_section	data;
-	/* event_types is ignored */
+	/** @event_types: Ignored. */
 	struct perf_file_section	event_types;
+	/**
+	 * @adds_features: Bitmap of features. The features are immediately after the data section.
+	 */
 	DECLARE_BITMAP(adds_features, HEADER_FEAT_BITS);
 };
 
-- 
2.46.0.295.g3b9ea8a38a-goog


