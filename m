Return-Path: <linux-kernel+bounces-307163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6D96495F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C348B27898
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36C194C88;
	Thu, 29 Aug 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwdNzjPq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CF1B29AA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943743; cv=none; b=L14uD0p1o7ULMklZfeODdBFKunnd8cjJ/LsTKLJaqXSliTJja3Afx2cu0LoGDL5Sv+LrZYo0XXE41tXyDifwIDBwjygnOyYRdkw/0w/E8mP2fXzsU0YOgLgNRbKLaVBovpMfnc5YxXog5UTRWdmlgxEt4DMJZmarUEorD+5hMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943743; c=relaxed/simple;
	bh=d8IwRgzU6IVwfT3fOB5yzVRUcKFqP32FXJTEN4UXaQc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l6L9Zwt41QqzBEr/w/xN32S8MzGx8WcTQFZkgTGnFu5s+jkEDzwmwJ4SR4GdUtZn64Co2LX0uA3VOvFplCIjPPjpOtdwBSVvG6iYcBaL2yr28GZsnEd9nGMLOcw0q73QhXdv2UHliXPgwHBErPs4fNoxogvU3TKqr3QINqppnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwdNzjPq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e13cfd506b8so1214726276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943741; x=1725548541; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhwOndd672eQTsmeiahQCx8DV4+qjBSQD+DApZqBRQc=;
        b=QwdNzjPqpbrbNICxGyTlinbTLreCGYfWMpx1B0vArbVMIhl+DaUlkcFasV3dUwHSC6
         w04dmyLmKD4jeDDYKWNGbcmeeIBJDe6TQDVZYfQNPgt0iSiRWKQtAJNnNrI76UVPF4DF
         RE4BSVqdEbYwoCEtEN4vgpfGfenkchXzt08WqyVVbnggpB4GHwxFQA1JbFCb0ftmYTxJ
         8O/vrgdwm4dttSYAW6ZTpMLEDoAwNDcGW8aStX+k8vhWLj8qG9GUm16c7jjyu8DVpC9g
         yCG1/IK7xkC7haPH0kseB3DYPAbp916onYlikpns2Pay9IqLylqHUgDY1cvnz3VMdPny
         n3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943741; x=1725548541;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhwOndd672eQTsmeiahQCx8DV4+qjBSQD+DApZqBRQc=;
        b=o8KYGaVQU/XH9XbjUZzB8ShcXfVFtWsI9pDz+3mdNCnCR99uxvk2T3iy0FbX9RfRkt
         bL8H8wGvCco13gzAvWmWk0O8W5S9t3NQOeZg3hWrPptb+H2UaTaWBVT2UonCjfHcEd7A
         KJ7GqJnu6Y+sKAr8l/YrIDru1Emhp5tm8MPHDBI+tuzxZGEEicSBteqyzyd6Bi/CbfdI
         wtaMUPlmF/C6n51vjWaUdiBOkP4Hjv7OwtR8Ml0buKsEPrzGuLfaz1t5WCV2kCM7pslB
         l6R1F0NXa4WXRSmdKIlN71GEmEEG18QWkTFxBbcuXM19SiPMX/PWQF6EPBovvnH31vWE
         elag==
X-Forwarded-Encrypted: i=1; AJvYcCXv3LqlaXVZTrRw1d/FZ9lmS6YsRpmdc9nHoqtjMCJA1FA5F3GpoiJic9GwNnhoTXE3a/NzMUBtQRQZ2r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsH9RYOsYaian/A4ZIhqf/2e94sqPOOissHpBkbdBzXfjmEKTw
	qNSK3ZXEqK0cq8AZOLFKICdLJIARF5YZsjAxIfGbQR2DKAEA9rNqjgtVn7xPkFsUHzQ/W2D9znX
	SbO06Jw==
X-Google-Smtp-Source: AGHT+IGanMcnYgYr5sBz7VZyu73qNQxkHIbx4GJrBetIEyCLMHA+YYkqVY2DAscY/rtVLupMJi2rIh4g1d8n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a25:7cc4:0:b0:e11:69f2:e39 with SMTP id
 3f1490d57ef6-e1a5adee523mr37264276.9.1724943740764; Thu, 29 Aug 2024 08:02:20
 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:50 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 4/8] perf header: Fail read if header sections overlap
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

Buggy perf.data files can have the attributes and data
overlapping. For example, when processing pipe data the attributes
aren't known and so file offset header calculations can consider them
not present.  Later this can cause the attributes to overwrite the
data. This can be seen in:

```
$ perf record -o - true > a.data
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.059 MB - ]
$ perf inject -i a.data -o b.data
$ perf report --stats -i b.data
0x68 [0]: failed to process type: 510379 [Invalid argument]
Error:
failed to process sample
```

This change makes reading the corrupt file fail:

```
$ perf report --stats -i b.data
Perf file header corrupt: Attributes and data overlap
incompatible file format (rerun with -v to learn more)
```

Which is more informative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3309fe7f1d12..65c9086610cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3986,6 +3986,24 @@ int perf_file_header__read(struct perf_file_header *header,
 			     adds_features));
 	}
 
+	if (header->size > header->attrs.offset) {
+		pr_err("Perf file header corrupt: header overlaps attrs\n");
+		return -1;
+	}
+
+	if (header->size > header->data.offset) {
+		pr_err("Perf file header corrupt: header overlaps data\n");
+		return -1;
+	}
+
+	if ((header->attrs.offset <= header->data.offset &&
+	     header->attrs.offset + header->attrs.size > header->data.offset) ||
+	    (header->attrs.offset > header->data.offset &&
+	     header->data.offset + header->data.size > header->attrs.offset)) {
+		pr_err("Perf file header corrupt: Attributes and data overlap\n");
+		return -1;
+	}
+
 	if (header->size != sizeof(*header)) {
 		/* Support the previous format */
 		if (header->size == offsetof(typeof(*header), adds_features))
-- 
2.46.0.295.g3b9ea8a38a-goog


