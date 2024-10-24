Return-Path: <linux-kernel+bounces-379368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE4B9ADDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2117EB22A20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5519F104;
	Thu, 24 Oct 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHHmfFt/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9E18BBAB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755213; cv=none; b=JkWdd5rMuxbIv1xLqeqTAS2v2RhSjad59Jfb1Dh7NiXOjtArf73jxaopCjYdcPIRCWv4IrRPPXU4SfRL/AprGOW5VufiSBs4F6UAUha4LZ2n4vtzghL8EjISRAtm8yM66EP7qi3U4pu/C5RJBzIrQJbV/A0bhRpzPkw1KxiazzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755213; c=relaxed/simple;
	bh=k1wh2zeNE6tcCQX3Z6B3EqKklNoAQpiPb5SUkLK5tUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GZPuAntRhUbbMI7v6T71awkTGISTNdI0taBGPM/NQTOclo5FQ6d+4SOFwem9yP0ZOJiHbd+5BOS71zG5+kNSmTJeG8HIFI051HOPvayczps3xmYdIHQC+Wiiqflvkd++rmYyqjnuIxMg13/Qfe5i58/MbyuKIQtlF1RJaCRuq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHHmfFt/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso11659207b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755210; x=1730360010; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emVhY31H9kbevrWQVBQDFf3nVCs1KfHQ+C3lVsleo+E=;
        b=CHHmfFt/+hMzBcghRBLuhGopICpUNb6LGk2JYOvmDg/22Ps7zCDa1PoqT+i38aLQ25
         jXLzVbUYTod8jycmXErEZwb2+ja/kAvZKoHCrvmPb6uZdxK/ZcwVFarTiC/On+qiZ0eN
         QNMXYOmlqpB5/FLrCUGulJU6eCjdG+Une92/BwGxu7r0XuMqlGIK6hL02ZaSsPuvZ8gV
         2PtxGiQk2Ctmq2G7ca2YNgtTC3gR2PDw8JjJrvBqufea7QoptGHqgQIEtR0Ex6Wuc8X3
         Td/rUh6BggBJQogrNdwqhli6rX6+yizM52hkhKMg9TDHpmbei0JQik/UxGWU0PMCMFOv
         80fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755210; x=1730360010;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emVhY31H9kbevrWQVBQDFf3nVCs1KfHQ+C3lVsleo+E=;
        b=Ifex0vtxNBwCvSJPbf1iImMxn/esc9ZpXQEqP3zafm6uduzWx5CC0ZuU+O38AQKzPG
         1RYbo1boxsaJH2f2PAo9RnynrUIl911KIcMu6letmR4xdjHj39Pplo5Mfp7DhlBpc1yY
         hrIZrz6zIsZJXw4zMPcRN7s19OnP4xzHPOLauBd+fhKRd/gIvvATg5sXa0ImFWEDq9n/
         e0zny88H4Ml71Pm249oXfVFI5hX1P6IQcIfd1TmWbVuAEd8zgyqIcrC2uQz3EzhNfU09
         3hnWQesZmNDMB6CoPq0ZH10kSYpY6IlEtZlNfl6JtYa8kg5GuEx8EtunqJ26lrCHJ7n/
         oDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPdJK2LKVcm60/MxMXj8xbzJr3nd1EZz3bqjhTwOKHucRV9WtRwxzL8RhJp2W5vFQTt6YRLJdGCv866DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKxbqzG3Podue1jcunfIybIc46SvfRRmzdhsjmhymkJaAIB+B
	SRBhlbySfa0Njz0l9RG1vKuSiaF9K6ItwT/8kYilo0F22Dr5BWtP5aKHGYGv+G6pOGS5xaKH/Nq
	ZO1HBng==
X-Google-Smtp-Source: AGHT+IGIdX+9UGh1ipFNzZxImIUQiwAu6jkH0seO0G13+GIts4a3kwmqAN+xljlGfhEuVFEiPznPJdl+Fepv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:690c:968a:b0:6e3:1f46:77a6 with SMTP
 id 00721157ae682-6e85814c3efmr1102067b3.2.1729755210383; Thu, 24 Oct 2024
 00:33:30 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:15 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 01/10] tools subcmd: Add non-waitpid check_if_command_finished()
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
2.47.0.163.g1226f6d8fa-goog


