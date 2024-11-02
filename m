Return-Path: <linux-kernel+bounces-393200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B49B9D94
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133311F235D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0482158862;
	Sat,  2 Nov 2024 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPinLDdP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AD482EB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532178; cv=none; b=cvx4rtExsb2eXne8Q3SHZ+lecJhR6vLeItbVci6WxYRYQ6YcujFbWtasDVcKgtpqpfX9l0h/lis3toHC3pEsETUc9agAu4trtK/sf9ASgiUbA+JDc/6X0oWmnX42yrtgV0TcWbNPgmqXxb25IXzzLcM3Kkxooql+mZ1Yqp//yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532178; c=relaxed/simple;
	bh=0UelXkPPHtu3Lbgh81jbZ3m39fj7o+Lntdf2ZlzEBXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bwnSgMcQsw10yssFwMaokC0zishsvz+3rzelUxZCHAwEEo0XjuQ3ZPPgkT7zKAcA9ppU0FBERKwYrS6CCb08ZU7gBEeXRMFQ9VAxYuG/StIWwXwjSG2QKg+IXUtfaNi/ITOmr4SyYZrrEB51i7yDsaCIvFfYuCdFR4YxwCRFv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPinLDdP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9e897852fso58485537b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532175; x=1731136975; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=hPinLDdP/Gw4O1MYEbyW2O1A7KdPsfpNlBCP5GjUZPZxawCENADGATatJ6RpbOXoQH
         jxUqixTuXckjNQL8Kx7qH1XTRp4ou5fd+l6YOXnnGJU5yVAns1+IzP+TCt3tvwzos/M8
         HayCcQflf19bKJwNIKW/eaRenmRr56AzAGKQ/avcW5ibGCVeSyVx5nuN/72vowKRkBJh
         6a+RX85ji5PngC4+7rpJNTeUgX+ERtUyqd7A6NGEkLdT59QyU2+TA5QfHlKhNOtZ/gtA
         MUXmq1ln+1LK/bWBi9fg71QopMgjr0pwFHcF4K5apb1DC2Frx6PunSiiDNsiiNLTaAaH
         0Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532175; x=1731136975;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=VoQNlg/q86t9vDtcCVulpxLZyl5ICAEF/xFIKOalgN9ie3uJ6NDGcUBBCflNi6rGx3
         r7JNPMp8sw5l9wC2iCcpNa2EgG73olFlbYmmdFpPthua30fSNrbN1E0OQXPi9IiPQbHH
         FBPbznq0ReyLpl78TZP5sEOs5vXUN4xjSIyqZEBSc6o2BqzBbL8WO3leTZOOGLxWKSXd
         P+hxI8xXPP0PNa2crNhDVEDxaOch+O3I1UKQnyzz7qc+zmVXhNai0+qKNwS4RmdWAMpi
         +0JR4oBGD5wvv7PXf/A9kY/1V/VDviKyEPM9xnAIalRiAZjbyffhKcZUVf4k/6ILFLsn
         nsiA==
X-Forwarded-Encrypted: i=1; AJvYcCWd5EXtVBqVb70cYOCCqbhjGzzWnTaWI01AlrGguO6O1Pka2SwJZqfwBzWpSk0RiHfqRo3mLibRQiiK5k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2RzOf4ONpWGLe9u4riCRlqDsGcAztXLqQrhABazhCkITB9lw
	1gWGMXpCyDyc6SuUdXWxl8Ca6dmxa8GyYMFo/MtLal+Rm8Wir1XybK7jhULDPL0yn5nbWnBaPVt
	OMR0/8g==
X-Google-Smtp-Source: AGHT+IF21gMzgWnRaUKTKbXwNyiHym2o8AuHXef8LQcQlcWusd77OnFCfPRuJOYkl8uUuhlLFhhWKw08INli
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:3808:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6e9d8b214c0mr15194697b3.3.1730532175462; Sat, 02 Nov 2024
 00:22:55 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:43 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 1/6] tool api fs: Correctly encode errno for read/write
 open failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Switch from returning -1 to -errno so that callers can determine types
of failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 337fde770e45..edec23406dbc 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -296,7 +296,7 @@ int filename__read_int(const char *filename, int *value)
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = atoi(line);
@@ -314,7 +314,7 @@ static int filename__read_ull_base(const char *filename,
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = strtoull(line, NULL, base);
@@ -372,7 +372,7 @@ int filename__write_int(const char *filename, int value)
 	char buf[64];
 
 	if (fd < 0)
-		return err;
+		return -errno;
 
 	sprintf(buf, "%d", value);
 	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
-- 
2.47.0.199.ga7371fff76-goog


