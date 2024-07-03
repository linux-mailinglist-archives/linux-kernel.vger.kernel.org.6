Return-Path: <linux-kernel+bounces-239934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25729266FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6EB1F23813
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457631862B6;
	Wed,  3 Jul 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Se5z1rIF"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C0185084
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027289; cv=none; b=QmK+wZzlYql3FxeIbll6G9cquDYdAWXSVRR39eIdIXtaCMac74Z8qP6CJbM4k/k90tSHZY6fBtp0P243p94KoeIyvqXSAAzNldUrzi28+VnfWEdLD8B93zm2s90HhM6phKe+oj8GyIQMumEvfNhBnPocCi/YY3vyYINrq/Rp+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027289; c=relaxed/simple;
	bh=FLT+4gnVINf7KJ4R59I14FmcEQjfh9jmHIWgHUoNFp8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Jd5r6KayKxB+cfPPRjabrR5j88mEvnJ5kfBLgopZuShc3m5a90ul38fDvml1c7FsTGd3GfsOKYgT8iP0bV+XpIUAVXZGI2o8bTmIeFm/YHqnibucO+yObm78UWGisDxX6QLZoo482VQAqKGWMx/ayae23xCy1xlrqJsMaNg/6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Se5z1rIF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e033e353528so8589503276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720027287; x=1720632087; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKtmGrW1KJvIQ629mFQxU63SX5o3BneZ2oyJxXNdreU=;
        b=Se5z1rIFwHsSvZ5yMsKBNUYByHpppybNEo8O0tgV9EKzTFAdf4OQ1/UlnmG8fLY4gV
         qORiAgT3tBOb0pk6cfG3OIJfcYe7hD8QzpBjTnGkAOSHDz5TbKsy6fPlrjnIrX90fR6Z
         TvJHhr6GjMJeSs5Wf/WCSwZO1F/aLcEWe+mq6VknhzWLgnAHffJDfjnAehjvG3useSlH
         Rbdv9XrNcxaaUjzOaezlKA9b+Feyq1S/hOv+9dgwyfydqxCm5IuJoNC5swnklu+q0F66
         y5e7hIGIQ4Df7ZlOPxjJx9Hc6BpTLo179wWMKqmYDeLl4jdlRkFEAGQBllw5WzbpHAxU
         5tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027287; x=1720632087;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKtmGrW1KJvIQ629mFQxU63SX5o3BneZ2oyJxXNdreU=;
        b=nflGyi5YYLqrmMo25up2l7ay2A0qPl9hX2I33Nv0TTbCQ0Ukoh1gquQYFGlZnnW8vc
         lj+UvdmLlh5JRcBHBmMDCzeH5ybBRwhzgJ5f6pDGXK3icRZ7eqgWQ7x5KNDFNN6jOOI2
         Xf4LjrSXCb0GIXoIVQbDrzzEtoIpjNw3pftdzhZCmJEQz/7EdlVDIiADlKRvYnCWwNl0
         n2DPghhwaNBHuYXKojYp33HrrMmZfX/UOKcT7GfPirDmgsVFV1irtxFDlDy+XiCBr/qv
         RhTR5QVplfMAYmGhi28rDz0pjKu4uYZtDKROGJSk11PKMlGXHt3A0mMXmKiqJrmZgkQm
         jxKA==
X-Forwarded-Encrypted: i=1; AJvYcCUsNKEehNYzX6TM4cVUW05qxW89rLK8LONZ0vkmvh6rj3KYtJZ4z/TVHr4syMPnPHapSuflie6bp9Z5wP9ui6qvHgpTZlmfr1NeI2Xh
X-Gm-Message-State: AOJu0YwGJYwYdmfZiPnV2yYL8hkCFmHXbIyQWbbcYOo12mMKWfdD76w1
	Lwl2hGB2laSfGaSkjSeSSNk+/3lZAIp63C4vEYdhdXDCFCcVAOSIp+2aS5CvhxItgGKhK4C0wHo
	UP+Llbw==
X-Google-Smtp-Source: AGHT+IHCpYgI1BZEzBCU2eJZ/7hopipDE9WsWDyt5JVynM2pswdESfEjBC6p1Zsq9sgn9+jXRngYeqpBdgyf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bdc2:f28d:3877:f0f2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1501:b0:dfd:a911:5722 with SMTP
 id 3f1490d57ef6-e036ec2dc31mr24953276.8.1720027287156; Wed, 03 Jul 2024
 10:21:27 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:21:16 -0700
In-Reply-To: <20240703172117.810918-1-irogers@google.com>
Message-Id: <20240703172117.810918-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240703172117.810918-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v1 1/2] perf comm str: Avoid sort during insert
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steinar Gunderson <sesse@google.com>, Matt Fleming <matt@readmodwrite.com>
Content-Type: text/plain; charset="UTF-8"

The array is sorted, so just move the elements and insert in order.

Reported-by: Matt Fleming <matt@readmodwrite.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 233f2b6edf52..49b79cf0c5cc 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -86,14 +86,6 @@ static struct comm_str *comm_str__new(const char *str)
 	return result;
 }
 
-static int comm_str__cmp(const void *_lhs, const void *_rhs)
-{
-	const struct comm_str *lhs = *(const struct comm_str * const *)_lhs;
-	const struct comm_str *rhs = *(const struct comm_str * const *)_rhs;
-
-	return strcmp(comm_str__str(lhs), comm_str__str(rhs));
-}
-
 static int comm_str__search(const void *_key, const void *_member)
 {
 	const char *key = _key;
@@ -169,9 +161,24 @@ static struct comm_str *comm_strs__findnew(const char *str)
 		}
 		result = comm_str__new(str);
 		if (result) {
-			comm_strs->strs[comm_strs->num_strs++] = result;
-			qsort(comm_strs->strs, comm_strs->num_strs, sizeof(struct comm_str *),
-			      comm_str__cmp);
+			int low = 0, high = comm_strs->num_strs - 1;
+			int insert = comm_strs->num_strs; /* Default to inserting at the end. */
+
+			while (low <= high) {
+				int mid = low + (high - low) / 2;
+				int cmp = strcmp(comm_str__str(comm_strs->strs[mid]), str);
+
+				if (cmp < 0) {
+					low = mid + 1;
+				} else {
+					high = mid - 1;
+					insert = mid;
+				}
+			}
+			memmove(&comm_strs->strs[insert + 1], &comm_strs->strs[insert],
+				(comm_strs->num_strs - insert) * sizeof(struct comm_str *));
+			comm_strs->num_strs++;
+			comm_strs->strs[insert] = result;
 		}
 	}
 	up_write(&comm_strs->lock);
-- 
2.45.2.803.g4e1b14247a-goog


