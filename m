Return-Path: <linux-kernel+bounces-376748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FFB9AB573
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDB1C22EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535D1C32E2;
	Tue, 22 Oct 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3TdQYhh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047D1C2DA9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619330; cv=none; b=U9SGwZyifrg8Hq3928ZjcC3MG30vayrPM85BdHsckHxgWvOsN3/ZP5UTRS3e+bEgRELbPKUjgBtAhUKxRNI0XViFCqJo17zG0wPc/ea2/NAWSAeOODNSKQ/80cIXII52f9xEiKVKfUVYkfYSen6WuyUoS4E5SwL4kn9tPfcvO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619330; c=relaxed/simple;
	bh=q0teOZsrdito5XX3VJlBtqEWeBOdDyb6RO0HXi1/UeE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QvLMky7D6oxw2+2x17J04DusiR9MqAo1t1U5m88KMkXxh7Uj4rNYCskImmNSw38F9ulE1iS2wvDL5GVQYOz+OYMdlNke9/zbG6iKOQOp6JbFzFAFtj+mGspKUu9OArAQFSAIuwkrnwk5qGRINV7nP+Y8bqLFe/JW53GshVaFO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e3TdQYhh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so109694187b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729619328; x=1730224128; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9n8NzOU9KMox6wY1PORoT9jCMHpWvqad4YBz0eGPMI=;
        b=e3TdQYhhzgx1yhYOQvwUwwN+6Q5QRdKUYHUEm3W6+zI8YTUutUA759s6QlN4jgxtih
         LrtXkBnP69zZZhpr8F/ge6/Bs+QKbNT1JS/nlIpe+FGwn2uidzmZ+jUcHKWpo3AjA1jp
         PArKmtiMBO6CGWlqU6wphqfM4KKUShXwVykNeHiIuz0wNshGr06JuePwlNigYhsHFtUz
         obikBWHVJRrkvPGVZhfNwCJaw8Xhu/SoLl63wSTGaggZtHI6Zmao76YRlahPMvG8ddkO
         216mHJKvsMsVrsjURr1CG4LK7o5oFv3ikKkUDCQs867kQGzk9RHFqv5ZbUgVcHZhatsO
         SY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619328; x=1730224128;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9n8NzOU9KMox6wY1PORoT9jCMHpWvqad4YBz0eGPMI=;
        b=TXz0YXv2AiJErGIbM2rTpwmChVtGI2LJVP+uXnC8oYDEqzHXNhNB14ptM4dBn86Deu
         fzITXspJuYps/6vLQQ4Ii299LBF+64WL7WPJid9dpl51EAAeX5pY1rAO2qsI6jhubA4/
         BOFd1GpTwzFaFDqL1iBXtblnhhzwed3wh7vn5cA+IcA8RGCMPY75a7XabraP08eOz7fV
         FZ/DQTRua+3iFc0GzUoHGtMa8jO6R+X9OsJDopowWTd7VjRNrcKSac9XBPFNDejQWq3X
         Qcog/lMnn3ARDUkmsChSwFk2IyhJgwPphKvh7tIY7pvew3yOAwh/ciqUXKazwaJEb+Zd
         3SGA==
X-Forwarded-Encrypted: i=1; AJvYcCViP81QVEg8OpxcKmzAtLrv08sSe7OcSrEnS1pCpmbXmTkpvjVgYhJ9ehsCuQzAKoW3lCZmsAN+Ix7YpUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfZCg9Wokved0NyY6NbTLugd43g2RALp4dDxJY6QGwFkFLQ0i
	7kZ8pFSyLEw4K2CYw5662PBpjP9m/1gU6swhtU+lgZo0XlHH94dtO1OE/UJmJ9PK2Y/KoIvaxNf
	XzYjeFw==
X-Google-Smtp-Source: AGHT+IHohwIVluFWB9W6VjZ+fIxCmDIBSDj2BjMKx75Bhz0Q/apI/loG+/7cFXe/HkFwRxRM3d+qRquwBx31
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6902:b0:6db:c6eb:bae9 with SMTP
 id 00721157ae682-6e5bfb868e1mr4162867b3.2.1729619328276; Tue, 22 Oct 2024
 10:48:48 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:48:38 -0700
In-Reply-To: <20241022174838.449862-1-irogers@google.com>
Message-Id: <20241022174838.449862-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022174838.449862-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 2/2] perf test: Skip annotate test for sanitizer builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Symbols vary and the test breaks.

Closes: https://lore.kernel.org/lkml/CAP-5=fU04PAN4T=7KuHA4h+po=oTy+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 1590a37363de..199f547e656d 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -4,6 +4,12 @@
 
 set -e
 
+if perf check feature -q sanitizer
+then
+  echo "Skip test with sanitizers due to differing assembly code"
+  exit 2
+fi
+
 shelldir=$(dirname "$0")
 
 # shellcheck source=lib/perf_has_symbol.sh
-- 
2.47.0.163.g1226f6d8fa-goog


