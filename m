Return-Path: <linux-kernel+bounces-361884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73C99AE6E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F131F243B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5F1D2239;
	Fri, 11 Oct 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUYiItyV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E81D1E63
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684250; cv=none; b=mp3fwbGRio0fzsHVuxlLBF/ZD4H5Tm+FqBNFrjmKBeO4XyP5BD1w5KQ4OMocDL4oYbPknUQCpfsuHy6iUgNWUa9QlYo4JiyqTpwNDjYkvA9pHmFpYAH6oUY+zBMwx4tVqJg5H1r5KF2Vpt1M6MhvEx6l9Ds5Iw/XZMfZ4uK5/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684250; c=relaxed/simple;
	bh=32CmiUO1Nu2w18z0VnqAHZyV/SwfhR5oLEkO3QAxKfY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WholSniUe72frJP3/E/uZGdQwe2wZWKbF+iAxw5NtwPaETcjgDanqHEZBN0sf1hlQC8wfiwIzXet4UFhuxbo4p/fTZSyl6316NSjgmRZEbRbQ+7siImwNXhecqdTgkrIADP9lsGn1Mjv0dytYOd2SfWt9l1hwH/3imc5w/QcBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUYiItyV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso3507111276.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684247; x=1729289047; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZqf2//xoOnb1H5/bkKLpMOcQ8vCY8XnITbcBJn/Kk0=;
        b=XUYiItyVexYmSCGBksEkVp7O9ddScH8lPGOrdlo/WY/drSzJY7RZ1+i1dD+F30A5vv
         NuTl4IAuwiJNrWnLwK6ZehbGOI5Z937VVkLOwXHrZ5YjKBF2bW6K4WxFSL14Vsj77a4/
         ykO00OgomaDsC5r4fyMRpxHKf1jYbSoYawvI/zF6KfkfcDmT3K/qQ0fTiaINIyok3tKa
         P4tCQQ3glpir6OsLBPvZQGU5cfm8gCoWnnyMeSfFDUMiJkdDSgHIHaV+zFuHUwL3XBQC
         salC0cUGKhGf1HANZRTZdiukwcYNW5yqdsGJu+lSdFL6SSkjsUqRzzTn1x/COr7+p3oK
         y2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684247; x=1729289047;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZqf2//xoOnb1H5/bkKLpMOcQ8vCY8XnITbcBJn/Kk0=;
        b=TebMuGtjteEZ6dBlA5Y9rCH9582bBxhee93tuJdna/oigwVaN0GA4Pd67G9CEfPXf2
         p264cOM8r33fhbQifOqkfdR0ixpIasGF6r1N7p7p3ketRMSZEi/6j97zObYExoCqnhxY
         GP0YVVhz1/2vNbz5SOHdWCbt3Sp14sAaADnXx8/KQWW3XQv5Wrf3RYt70zDv+bBOP21q
         x/lE6LXDvzlLFOdzz8Wun8fRZRxfQ0xVIKponFqxWxzpckAESPw0R5kHtyc8snwIHHWa
         YuJ/udchMeL7x780xQwn2Qkvn/o1Cm/M/FKGmmnf6ZVd1lSg5aBu55COI1RLF7/bTz84
         t90Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH00StyiDa0EG4JuLAQ1WMYw+jgNsCIWyadW+RA0SJX0xapCP6vjVmqTW5m1+cRnbA9bg/DS9pynyV8o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCY9bRJTNIpPHLDTE4MVjZBeFOremB4whjNSO74Dv9yTTrBRh
	xLNkHsQTI2/xs1d7oZZc1IrF4yt/h3A/dFCZszsGXp+cKUApNa4t7bGOvZpA/Zql5lL5HrWy4X1
	ycQkORA==
X-Google-Smtp-Source: AGHT+IFnQwK3S6BS+70+ID2qAC5s213z8mYXWb6kgkgpvLhH25KIn26m/qM2zLiTiXCF/WTydr0Zy+VcCrx+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:ae8c:0:b0:e25:d596:4847 with SMTP id
 3f1490d57ef6-e2919ded25cmr12084276.6.1728684246675; Fri, 11 Oct 2024 15:04:06
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:47 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 1/8] tools subcmd: Add non-waitpid check_if_command_finished()
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using waitpid can cause stdout/stderr of the child process to be
lost. Use Linux's /prod/<pid>/status file to determine if the process
has reached the zombie state. Use the 'status' file rather than 'stat'
to avoid issues around skipping the process name.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 4e3a557a2f37..0a764c25c384 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <string.h>
 #include <linux/string.h>
@@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 
 int check_if_command_finished(struct child_process *cmd)
 {
+#ifdef __linux__
+	char filename[FILENAME_MAX + 12];
+	char status_line[256];
+	FILE *status_file;
+
+	/*
+	 * Check by reading /proc/<pid>/status as calling waitpid causes
+	 * stdout/stderr to be closed and data lost.
+	 */
+	sprintf(filename, "/proc/%d/status", cmd->pid);
+	status_file = fopen(filename, "r");
+	if (status_file == NULL) {
+		/* Open failed assume finish_command was called. */
+		return true;
+	}
+	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
+		char *p;
+
+		if (strncmp(status_line, "State:", 6))
+			continue;
+
+		fclose(status_file);
+		p = status_line + 6;
+		while (isspace(*p))
+			p++;
+		return *p == 'Z' ? 1 : 0;
+	}
+	/* Read failed assume finish_command was called. */
+	fclose(status_file);
+	return 1;
+#else
 	wait_or_whine(cmd, /*block=*/false);
 	return cmd->finished;
+#endif
 }
 
 int finish_command(struct child_process *cmd)
-- 
2.47.0.rc1.288.g06298d1525-goog


