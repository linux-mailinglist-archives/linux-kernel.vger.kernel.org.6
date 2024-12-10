Return-Path: <linux-kernel+bounces-440242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856099EBAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC44283DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D922688E;
	Tue, 10 Dec 2024 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MD+b6tFK"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BE153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861350; cv=none; b=DjK5Ggx9BEAUPKHQmxvYUTzT26S2/qxCZUd4/ViWpMkeRF+9s7OKNoDHRWKpQbt1+guY6mlA3j0IE7nTYUZkuuJbuTlfhGhUxxMZJ9V5ZUT/s/zXYtPA+y/aCEPAdPX38uM2FSQuykQ81KZcP3ohUX4SZuIzgWwjdeWbbE7zCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861350; c=relaxed/simple;
	bh=4TXt/fYrKAAtNwYRb9jxLFxe3AURh81Ap7PmCA7Zuko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FULLir6vjGOucPcX+kJC8m/eDKcHk4PDem8+MGePn4PPLFlxqR9wL53+wyC7+63fR765aqZKqe4UTcEr7pHm7Fv1r1J6r0tcSI39CaPOlShGgwQm7Z7XvzLCNPOdXtbtH4eBCeIZIjikZMoF9ty8KE01v84QG/zxSV9/+r9/W2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MD+b6tFK; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-296bc214420so4070514fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861347; x=1734466147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ0TIlLsvDETtZLHTX5LiWM7DaAh3n/2WyTapiVCEOc=;
        b=MD+b6tFKhWnGjIpS1AEFaW/QCSTV+yZyCMnkJvztpARwKujbPC0P/LTqkFILpnuJoG
         1I8314ofGbHo7iFACabWPxjPVN8smr9OHwI76XbEPlHLpWCGoe8MNQH1+SvtXIXLhoml
         CyqG6I/CbVFRWgqJGiCO41JcZ+AS/UaNQBPB05Fh7ZvABUftltgv1tGnxJ1Lvcbhh6v7
         c3hxDwdJSfSYyaqaNOGuJvHfybm4ANnF7K/S83iq+XmM9nlrHBUiu4m3h0/tlrfO0ivC
         Z1T8KrRbga/BpkWmkDYVdaKH5TrL80fp/x4MMu4FOkkLgwr1mRVdHl6NmwWwvAGEfbLA
         W1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861347; x=1734466147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ0TIlLsvDETtZLHTX5LiWM7DaAh3n/2WyTapiVCEOc=;
        b=l9ojp+tWKOKWk6NlXm1nmNhWqzCjoAAUqsf1r4ERt3U4KNep9pYQtrNgpbESxsGD0O
         xb7N2W6GhGS/hiQGttYre42cpZ/ZDJpsjkFtaX3DiH6A48UHKUjt359lXWDxptEAi0Xm
         QlPpzU2rjc2BR+NRm4rB1f4fJC/xr0QNpl0t9s2fKUqjbizYw86m+18z534A74HJ064D
         QBbCatlFTazwYwdAFlJKDm5p3rougGnjtOCQTG1Rw1P8Vdtu3RPRbfKL3zGisNqhB/es
         Mz7MnxRmcbwcsTHr3aEZ0awe0FHyZA62iyotzkbYx/FEypPMYLlAQ86Ya/oERCRxS46w
         NrCQ==
X-Gm-Message-State: AOJu0Yxq3C1aRD4967ymaCvvaz5eA9pdsOLwY+gJUXFaO6LLqCXFXETx
	9SESbEI+1zOY+W7nOJLxEgqKQ02WTp5DVqQBR/AamoifO/Zp4oGDH8Bfgp3PrQZC+22zPE60oy+
	7/1/4btwxdGxg4aT+QC1XRu2qwAj3Owck4Cwd3FVRnUxGws/rAWYQC6MrVVxYEB+cEzzoKCqdbr
	YJnLbGnrIOfcifpaxKvsS3YRaWY3YwcakQJLBh4pJ0
X-Google-Smtp-Source: AGHT+IFedsnHWxoacSC2bWy7ghFMHZFBRW8dlqVBGCMQ6X3BH3cx8puBGgp+Q31QTB54o9jv5UpXKEhJyNo=
X-Received: from oabrl22.prod.google.com ([2002:a05:6871:6516:b0:29f:c26f:686e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:230e:b0:29d:cc2e:8493
 with SMTP id 586e51a60fabf-2a012f3bc6bmr324133fac.26.1733861347684; Tue, 10
 Dec 2024 12:09:07 -0800 (PST)
Date: Tue, 10 Dec 2024 12:08:21 -0800
In-Reply-To: <20241210200847.1023139-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210200847.1023139-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210200847.1023139-2-ctshao@google.com>
Subject: [PATCH v5 2/3] perf lock: Add percpu-rwsem for type filter
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

percpu-rwsem was missing in man page. And for backward compatibility,
replace `pcpu-sem` with `percpu-rwsem` before parsing lock name.
Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
percpu-rwsem`

Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/Documentation/perf-lock.txt | 4 ++--
 tools/perf/builtin-lock.c              | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 57a940399de0..d3793054f7d3 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -187,8 +187,8 @@ CONTENTION OPTIONS
 	Show lock contention only for given lock types (comma separated list).
 	Available values are:
 	  semaphore, spinlock, rwlock, rwlock:R, rwlock:W, rwsem, rwsem:R, rwsem:W,
-	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, pcpu-sem, pcpu-sem:R, pcpu-sem:W,
-	  mutex
+	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, percpu-rwmem, pcpu-sem,
+	  pcpu-sem:R, pcpu-sem:W, mutex
 
 	Note that RW-variant of locks have :R and :W suffix.  Names without the
 	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7e36bbe3cb80..50630551adad 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2365,7 +2365,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		/*
 		 * Otherwise `tok` is `name` in `lock_type_table`.
 		 * Single lock name could contain multiple flags.
+		 * Replace alias `pcpu-sem` with actual name `percpu-rwsem.
 		 */
+		if (!strcmp(tok, "pcpu-sem"))
+			tok = (char *)"percpu-rwsem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 			if (!strcmp(lock_type_table[i].name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
-- 
2.47.1.545.g3c1d2e2a6a-goog


