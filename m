Return-Path: <linux-kernel+bounces-565452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C206A66865
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98865189B489
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E71C5D6C;
	Tue, 18 Mar 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0IWX/TnC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFF19ABAB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272324; cv=none; b=RoYxlabGcyvfB2hqpMLtmp6u5XFr/olZ2xu+Z+icQbRNfj378KCmH/bu0CY0MLvGaMo3ITr18TiLX9rDAuyn36ajv/HV9+hKr20n2cNhLx04pKfWCKhM3Cc88A2dm83wt95tfqpObEgVB6fL6eLdOCj09J3Lt8NQR93+MIztBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272324; c=relaxed/simple;
	bh=d5/SPH6Xszn1gnN5qqSdZHDkkc8zw3ZG8Oun46aesZk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XuLMhwDmntlM4b94gXy/vlDtALEZ4WuzRlejrFrUkkHAXgbQ6PWfPQKdiYce5XXZEX/RNsrK4c36qH4MV+DgKy6w0LektAlkbEsUSB1ctE7nybNtYxUl+xpEiVf+w5OE9ZGHKyHAd4YDVBfyioTbOC5hIBiq89GoHLV6pEDy2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0IWX/TnC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fec6c91630so73288677b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742272321; x=1742877121; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUkAIINDzOsP+PuNVteX8o8oIwqX+sSmcLnHXIaoPro=;
        b=0IWX/TnCQZK7vslD49s0JHa2D3hZRsB5MJ7Tl0priZ97uaPaMOt3X33rExPJZuLg9N
         cUbvLed6Dd71o2LIgMbR/4JxPmlnt+L6DKv7WigLqAH4GyHFahZbLO1esvyWCHefxxMv
         Tegpjb8NQJAQLj4RJSOtOqSl4RtdY7Ot2zwwfaEBDSMednD/DFyKJIfQJn3+tO6BF97b
         gj6ieM04ttXT5gAfoU/XO8lP/Dq59k9hG4WN2dJf6auXr0jXsdvc8T7lU/kRIxcaaGwn
         cRQPWZ8fnYfjPjNgqLwGsb81qZUkdcxhysEtHYrE57/6HAVSJ9AfJ2SyTYwWiSp4yO8H
         ctWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272321; x=1742877121;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUkAIINDzOsP+PuNVteX8o8oIwqX+sSmcLnHXIaoPro=;
        b=dtJgfPfuqokXD0L4srswGIY6D3759L7Ty6aTHWQwNd0NfEWFzx2vdrqyi4VbjJbwip
         wcPr7iFujUzgC0gP+4EsmSu/B8MgfGdqp0OUiOkFjdu+CAfXbpkwFfZJ3SfSdCIS/4Tm
         dKHcmN5ZnlMkGkiwYuxBgSHZHYznXzpufu76bsvNMvy4sC0rh/OcAuqT61lJiyVu9wRb
         sWRGKRSC4uddIkU+UZjPrmx120cGBCjteG4CLC2xv38iMJDCu7TKi2dDjz/a53ol/p7w
         c+vVBY2+ivUqYrokSUcWvE+MBeL26RRv1He178sf7gDEORFyd2jBsm/fmJP/cOELwUfA
         Kr1A==
X-Forwarded-Encrypted: i=1; AJvYcCUoAjHVgXtEXg8M/8BEJQBFxrduldpiYavlXs0SxuONA9gsAW0TrTGvuo+0CqZ6aI7GZ6S/e5ZmyTEQ4vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzgNlSV0ggJXaBkvKkkQKk15nO4/wng50cUZ+zs87pquSzwfz
	OTkW6cVKb+A9DDrG9dkxf+aeUEWktynp+Pf1QqY4G9KnsDn6U7k2K0V2zpWpzzl44uc2ZpB4VaC
	uYp8jNg==
X-Google-Smtp-Source: AGHT+IEcfXSAohVmxzPknUUIX08jwASTAN/GzdnD1c7IYI76WLUVAzrBv5lIoiUiC2EvtM1IH2Qkcs87+T4e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2c05:b0:6fe:c5cc:e1ab with SMTP
 id 00721157ae682-6ff46024ae2mr176667b3.6.1742272321267; Mon, 17 Mar 2025
 21:32:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:31:51 -0700
In-Reply-To: <20250318043151.137973-1-irogers@google.com>
Message-Id: <20250318043151.137973-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318043151.137973-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v2 3/3] perf test dso-data: Correctly free test file in read test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DSO data read test opens a file but as dsos__exit is used the test
file isn't closed. This causes the subsequent subtests in don't fork
(-F) mode to fail as one more than expected file descriptor is open.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dso-data.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index 06be7c5d8495..a1fff4203b75 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -114,6 +114,17 @@ static int dso__data_fd(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
+static void dsos__delete(struct dsos *dsos)
+{
+	for (unsigned int i = 0; i < dsos->cnt; i++) {
+		struct dso *dso = dsos->dsos[i];
+
+		dso__data_close(dso);
+		unlink(dso__name(dso));
+	}
+	dsos__exit(dsos);
+}
+
 static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
@@ -172,7 +183,7 @@ static int test__dso_data(struct test_suite *test __maybe_unused, int subtest __
 	}
 
 	dso__put(dso);
-	dsos__exit(&machine.dsos);
+	dsos__delete(&machine.dsos);
 	unlink(file);
 	return 0;
 }
@@ -222,17 +233,6 @@ static int dsos__create(int cnt, int size, struct dsos *dsos)
 	return 0;
 }
 
-static void dsos__delete(struct dsos *dsos)
-{
-	for (unsigned int i = 0; i < dsos->cnt; i++) {
-		struct dso *dso = dsos->dsos[i];
-
-		dso__data_close(dso);
-		unlink(dso__name(dso));
-	}
-	dsos__exit(dsos);
-}
-
 static int set_fd_limit(int n)
 {
 	struct rlimit rlim;
-- 
2.49.0.rc1.451.g8f38331e32-goog


