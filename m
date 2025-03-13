Return-Path: <linux-kernel+bounces-558906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A1A5ECED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C643AE24D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217B1FCD0C;
	Thu, 13 Mar 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hZH9EzLM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D61FDA86
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850537; cv=none; b=obBYPLM2yZJUpz7DFmxGSUoR94OXaEMkcAPd50p8pRuno8B5jGotdz/UZzVqRY5wgwIuzzOTOaKeqEMZmxufp4YKfzuqj+teV7vKe3iEtI2ytgdVKQw2Td/1/bo/pCR82eAIHa+x6UFEfCSmC/dvQ7WbMyE4E/16d8Ep6+Uwt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850537; c=relaxed/simple;
	bh=AE5A2NiuhhYdM1sWAknuDe5X1OFs+sj0hwKEzFeDmoU=;
	h=Mime-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr46QaKZDScUZVfLxYlRC10xsa4f/detuqhIA30zV9CAs8fsSAOYxzqtTrp+FMjNYFM6XMAVy7P+DK1x+t2jSIm995zZrVbJ8GUwy8/oM/czpytriVuxqBLiXAJ7dZ/UYBoBabdKw1b89MdZ7zEUBWsFq2eppkDacE0fJIlgJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hZH9EzLM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaeec07b705so100378666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850534; x=1742455334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpEzXfsqBkoX4MatYvv/s6fQuJuNm6IXmUv71NmaMxI=;
        b=hZH9EzLMG1zuEgH0KFLAGmFJ/cotpjsWT/Ssy91D2uwi8hwyAefuARJ+0HjrcRbniW
         ZOAT+wR15Akbeo6yh7jdBxYrVM45yHtAZjd4/B5E7luifn/p8EXJu5WuPBDB/t4Jxp3v
         4zIiU9KydcW1s1x75BvASN8Herg3uRixS9DMQB87IjcxEGy1nRXYbqetZdyORHDQp9Zf
         eqdpoUqiaQqYOKgIDY4EReUgFQT+5Iqih6GgbCySbjUeJK1OcO7fCbDUGLnJpLgMr7Bd
         PyTtFqI7XS2ozavRf//w0qW6bZEfFwjfOOhBV9qJSuYZgNPPvz3i008m1BjPBrLmaI3e
         hsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850534; x=1742455334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpEzXfsqBkoX4MatYvv/s6fQuJuNm6IXmUv71NmaMxI=;
        b=Dlr3qChzUoO+lxTcwzhAW8HqMbFW7/noibd+/XawDFgq7yq/oZYCH3Chu+g01opRb8
         8MCGm67EY0lnG61E/mPcnTOWdSCaOlofRZ73a9MBCgGsJcKDMziUHSnjdLUPOqnO4lYa
         41x1jlJuK9tv8C+OILKC/moPbyxQk75ozDZhA1P8zi1+hFIeqKA7x4F12FQIOP0NY4gV
         Y4vDXwS46lOL0A5v1c55aXVWddSFByYdxIc+Q/OfIrRHnW+3FE3GT4P68fJ2siJgxgYB
         j+b3PflmklDPJyLJ4CwLTx7RED6ZcHAIy/k0sX9cjL0ZJdzc/jmFDsbD7VOtonLNYK4O
         OHHQ==
X-Gm-Message-State: AOJu0YzR7zAHMsSRpxMd5CDg4LlyHRxl4Q1rUGGGlK49k8Gc6dlnaENJ
	lgvb6wIXwT91ZBOYvi0m2IZxnnLkMHP0JXS6gLtB9qEGBGIPvGLNwiDNSWztHH4S4R47tnoIAtI
	F1YbHKhn0GzWbNwbCvdTb8fVImgHFp6ozJOI7
X-Gm-Gg: ASbGncvAPjLiD/+XVs5PJE8rDImV4abikgNHgvk+lyMNRPzhMVwFdjRm2YECjs99de3
	losuC44EKLlowqOMruncfJWyGDfuZU6SyCim3jQRSkdROXzvb2WMtd7zNrvvNwoRFqDqONgvz3E
	ZCj3sx+yhB9WhcuK4P4jpHXZ6FzKE=
X-Google-Smtp-Source: AGHT+IHhlNrNpiMA7L0JPZsP3KNrZZ1fOZ0mF1oPxXrCVJMx5bfO95h7bBq14Q+DG2+I0K7s3DVDmcJBTCJXGgDAuEw=
X-Received: by 2002:a17:907:1c15:b0:abf:7406:a5c3 with SMTP id
 a640c23a62f3a-ac2b9ee8733mr1323584666b.51.1741850534007; Thu, 13 Mar 2025
 00:22:14 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 00:22:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
From: Aaron Lu <ziqianlu@bytedance.com>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
Date: Thu, 13 Mar 2025 00:22:13 -0700
X-Gm-Features: AQ5f1JqvOOWc7Eu5kkoNljS6MLk_wH52rWSn_S_LjFzatT5ufD9JuvWltz5Q9LA
Message-ID: <CANCG0Gf2ZbnffwNVoBSu_+y4sq0MoMYPwwgsnfg53Pf2enwJZw@mail.gmail.com>
Subject: [RFC PATCH 7/7] sched/fair: Make sure cfs_rq has enough
 runtime_remaining on unthrottle path
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

It's possible unthrottle_cfs_rq() is called with !runtime_remaining
due to things like user changed quota setting(see tg_set_cfs_bandwidth())
or async unthrottled us with a positive runtime_remaining but other still
running entities consumed those runtime before we reach there.

Anyway, we can't unthrottle this cfs_rq without any runtime remaining
because task enqueue during unthrottle can immediately trigger a throttle
by check_enqueue_throttle(), which should never happen.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index be96f7d32998c..d646451d617c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6058,6 +6058,19 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];

+	/*
+	 * It's possible we are called with !runtime_remaining due to things
+	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
+	 * unthrottled us with a positive runtime_remaining but other still
+	 * running entities consumed those runtime before we reach here.
+	 *
+	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
+	 * because any enqueue below will immediately trigger a throttle, which
+	 * is not supposed to happen on unthrottle path.
+	 */
+	if (cfs_rq->runtime_enabled && !cfs_rq->runtime_remaining)
+		return;
+
 	cfs_rq->throttled = 0;

 	update_rq_clock(rq);
-- 
2.39.5

