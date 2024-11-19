Return-Path: <linux-kernel+bounces-413687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E49D1D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FBBB241FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1019B5B1;
	Tue, 19 Nov 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgrJ7bWm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80F19C54C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979122; cv=none; b=b+ccHwwhTUAmRPdRTvviby4qd+HejL6H/q9IJKgD2BmuKZVCxLg3xBJxo9i4Eu7LZ4kJ0eRa9d8rfQOipjwGlD+2zxGQLjUuGBy2jDfB0EPcxiaz7DThM5HLHOfcGGj7db5bB9sanGBoee/Qy7DsdYvT+yaZMdzMcuTVUwkwrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979122; c=relaxed/simple;
	bh=TibGVYLS+w6eFScQZIl1dSIHMEHWsRVbxEMEGktnWmY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=B2beiH3N2pBEMefrYKe0mzgcr3+1CcAsGMtm+d54ZPpmx5Bf4IEwVC/WHU9urloRAcp0lpUa4AwO9j5KMMyNIZACfWjSWoJbsDLm9/fORUqkg5zgpLrjIwD17nGGSMvhlqgQVE4vH2xXqEg2ulv3S38rzZNy3qn/h/zWNO8HFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgrJ7bWm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee7856bcf2so40617617b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979120; x=1732583920; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dG2rHpz+DZmFY69Ow240psf3XNCS4leK+RB0Jo+u5VI=;
        b=cgrJ7bWmasn1xpBTNITg2kNikmVVoqHm+sq/tvibdKnR4Yg6u0H4k0W8jbudlnfp8E
         2DWn7Q5xSBrDegYAlg14QzxyaNY17XOXfGk7RxM9RceFlecc+8q89RbZYgXDTX8FVUKu
         Glub2Qy+rE1j/KLdJp+ZZvi5eD/+twvHxop61B5wl+25eS1R4CTBUpoA+AOSzOrIy12h
         9BSRA56MTWsXqmqmvnrNzIrUspLkznWpsK7YR5571q0PdK3nh21cpW0Jbo3aBRJ1wAcA
         rqFx62jRJV+v1dkgaH/DWXEKyHCaP6SzS5qW7dh4eWnvXhEJNK8DinPW75cOJCz+sZS2
         2XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979120; x=1732583920;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dG2rHpz+DZmFY69Ow240psf3XNCS4leK+RB0Jo+u5VI=;
        b=JbZNCEtvR783Q48YbSNkVqUMledTbctGXh7tdMIGRc/PvI8jlrklYdwlk47RSV3AYY
         Dm0PFFbuGWzUN/E8K6j8p5SG+dovHSM0dD0NFX2HG0jaMTALfU43AZAwicPJA4+Xs1ur
         O9+QO/yX9YdB32XgJPCZhDdeu5Dp2FWR7Ouv8UPjibnZpgXl7aCg0E8RM5NhsOyD/MhD
         FS6AnVAxWALt6kjBdIAO8ip6Nk4+wspH3UXUP9I1ND/PMwFXCJIGyPvcHTwUEYDM5vr9
         InkoLNypbpWe3+8lB5nZL+u2JMHcX0zUqpzoD7zU9Y7OimMEvQfWugMN8Y6PruZRDfS2
         DrNA==
X-Forwarded-Encrypted: i=1; AJvYcCXHpg9oPGOBlk3G7T4ujQdCracvl/mqIZ2tlg5q2q3IG48rFB/r77SUSb2QayPjhZZZSdv77OBWcIhoryA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+9j1rpuDTF7R1yirbv4Zr/+oTlUhesmPG64KIQPXnNHg3LKC
	zhbAhKMsA7mqD6LGT5HK1Z/YomYNw4POtsNVddBk9te3NfWzN/ocpem3Rwodwt1+74HLdAJani3
	UwJrqag==
X-Google-Smtp-Source: AGHT+IH0fWK9l/ObxBt82Gee4SbsKlCa/RgYCuQgUP9WU5mzStOrp3fYvTUu8INRKh0lKzORqbt9AzCVDCVj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:8bc1:b0:6ee:5091:4254 with SMTP
 id 00721157ae682-6ee55cf1b83mr945287b3.6.1731979119740; Mon, 18 Nov 2024
 17:18:39 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:44 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 22/22] perf python: Correctly throw IndexError
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
index 893aa4185c03..b4bc57859f73 100644
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
2.47.0.338.g60cca15819-goog


