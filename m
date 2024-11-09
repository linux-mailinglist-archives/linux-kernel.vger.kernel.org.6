Return-Path: <linux-kernel+bounces-402705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C29C2A9B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B71C23292
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E11474B2;
	Sat,  9 Nov 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LINTWF0L"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56787146D78
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133154; cv=none; b=GSxw4C48ViqrGyv60s99MIvQWMChnHEHk708/phfHBqkBuA7oHf3GnbXyI/p9Nb6AsFPLXwO9vAVSzsDMkVbODIm6zGuz+IKj3ldpetGvHXdn8l5VAKtrl+p6RLDg89WtbV9fqSsw/TQWmmmqy1Y2+twcpkDtu4WAYR1X0YbUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133154; c=relaxed/simple;
	bh=cdFXS6YbU6dHLZsfKNNJ3CV8t/rR/3/1BmnroI/EmI4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=bBOHkRp9Dmu7TF/m5TV1AIbWXOf89nsdpS/JlMWQ+YmDnZ2R+dL9dOPpOswXTBnMYhrGMcf7s88zjLf/z9ByPgGPoLiaOddSUhduKyZ3Pq8n4he/+JWDC4VO8FdQYFVQAAdqyk0j7tqmgVcP/ZHBYAVS1GDuGMqH2BDs18z9zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LINTWF0L; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so4834872276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133152; x=1731737952; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m24ezova7J3GENnmHxuIJrSil1dVDJzqrtZznCoBSNI=;
        b=LINTWF0LAIkda7RAlnxKvdOE3C7bfMMXN5ShsIeQUoXQpCo0iqUk8x4o0umNVtMzqc
         HBCrCrFxfM8N4MD/xVpLflfSujsLaW+BRXmnU3iJao8YYb8+J0KCved325i9xfROA9/v
         XnFuI6OROMHXm0N7NYvTOtxbNzbP47oC7hX2Dwg3hbMQAEoDgo64Wi1waTBxRmtvF6Ha
         vIfVm9V90k8vXQ8qutwwUyHGjaC9lOuPwI6PxCYq88mbCUjnzOebf6CBXNPLfrs2X3vn
         DeiDoKSPHLAgLsX67ZXGnXEwjBFQtkVjYjGcuPQiywIDdW34MYVfd/ncNhwlw6XdpWYH
         tRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133152; x=1731737952;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m24ezova7J3GENnmHxuIJrSil1dVDJzqrtZznCoBSNI=;
        b=gHzXYGTNg7mSQT6jUPrBuWkYIHzGrtJ+fEdpGixDEMwk4Ihl0zwCOuoIl/Twd4Murb
         iF+OlkaQ+wknAuMTe+hO170gACTK+goOpytwNjQQZOkmZ4u6/f4IDWmblf1EPKiSTauB
         L5wru2dMMOi4SYTVouqUeixdE99OTmXrk5UmLENVLR2h+0VuqPcQ8BENSFTfrupdQrRv
         jkSI8GxHQuET5650kXl6fbCCIHIzTWj76/uXR9g7B3/wfUq57eizE+2q+SK8j6dFBybW
         d4QMl/rl/u1Ny0c2Ce/AlmW8z8AY90u7pFquN5HNa9/TBYWrTOXC0081Rw4d33YDRLfz
         H9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVewYQECxQwwfjRce12TnXdhIio0oI30CkKBcVaa7k69heHMHduX7Sej8HGnDFWNPpY4i1OVaK2N7Ejtb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPU2Yx0tNPEKEgZ4xva4EBW7Y7Ut+wzxViKQGzE9bzfA6l0bLL
	qWwMRIrWf/5BJEgOfZlrZSGCplyU3KwdvM74umhkvaGl+Hd/i/A5cm+FU7AX759GJqFbvhnd6H+
	m0yqC1A==
X-Google-Smtp-Source: AGHT+IEjWicK5LpMHUtvdfgpqNM6nhMioZKKQMcNun1xBlhB3GtyO6nVCSa+gmCfKwcqfavz2sH0Ixj1poWJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:8b81:0:b0:e2e:3031:3f0c with SMTP id
 3f1490d57ef6-e337f8d41a3mr4031276.7.1731133151533; Fri, 08 Nov 2024 22:19:11
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:09 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 22/22] perf python: Correctly throw IndexError
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Correctly throw IndexError for out-of-bound accesses to evlist:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles')
>>> print(x)
evlist([cycles])
>>> x[2]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: Index out of range
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0d71ec673aa3..25114dcadd21 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1071,8 +1071,10 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	struct pyrf_evlist *pevlist = (void *)obj;
 	struct evsel *pos;
 
-	if (i >= pevlist->evlist.core.nr_entries)
+	if (i >= pevlist->evlist.core.nr_entries) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	evlist__for_each_entry(&pevlist->evlist, pos) {
 		if (i-- == 0)
-- 
2.47.0.277.g8800431eea-goog


