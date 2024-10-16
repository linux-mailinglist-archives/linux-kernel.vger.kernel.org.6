Return-Path: <linux-kernel+bounces-368904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5559A164C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A6D28113F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50A1D5CC7;
	Wed, 16 Oct 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7btLC9q"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC81D5AA6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122993; cv=none; b=LRXdrhWvrvKXoBoFYpFMBqqXR8z8fNr5Cn1SGOCMwIu6An6iAE3fYTMyxdFMZ7WtIr4W66tU2XSAwVaf3FBn5KBtUnS+HRLUqa8SgFs2/1iQT+XCCSdsqb9EwNFvWfFh/I/1cu7TeEa082ziNXpJ7xeMY8d2zE8l2vOzjTLlimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122993; c=relaxed/simple;
	bh=q0aVGZHkRF3gGqrnfUfdn795vPhfLHAqdzFkqawlaiI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ozJQta8p2E8SkK3jZyE8prvrct7ay0hdk/vkODa5afKvP92p4ObO7M8chcpf+FdzibXQUfm1cTV5g8MmuhV5gUJ9dqMTg6HFFCDpx3QM3iFMr5Z8fzRFqZcXh73RG4EDn9XtImZafS6UwtA+yNoqjMNHPsTDzxZaWtvxpyXM/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7btLC9q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2939e25402so585849276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729122991; x=1729727791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSFHT2nx5Dy93k/WYJeKcczC9L+HDPym6LZPWSj1SxE=;
        b=w7btLC9qL+A7fT2Ox6Brb4QuwKwJVOxyyM1wNsNgxNKDzW7JExPvM4rUB8ouaulhUw
         MLzj/1T6uWsySqMeRFWW7sKlpNADxD5f2tfc+sf0TH14paDvKuW51XQKJZkl/OJ8f007
         5ncSZz6bQnnzl+4g2nwZuYfNC0jtTPeKlbSSPBhmOB3z42Rlb4jJ8WdbFLlIP/GPgbl/
         QY3If2Qp5iuhIgJDIj1pLcbjO8Qcvcwsisx4cmcC/SyGXnh7EEipOzzUBCq/CFqCsx7x
         WSCOP1HoKU12q1hV5BwRbbNIldP/YNO9p3NZqp+TH5xdTvs95rLx4KcVwPzeROVhzIXC
         fpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122991; x=1729727791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSFHT2nx5Dy93k/WYJeKcczC9L+HDPym6LZPWSj1SxE=;
        b=Px05PY9zgrR2MizezR0kNCi0QNe1wfUFnn5YKhgNtjshICpBNxNSdmjDu5imRh7dZz
         T36YsH1+gLghJdhXtNXd6B5xHZRX3vv7w2F9RRAEE72DtRT561bw2UMC1+vq9sYMwRm0
         pn1wjw0oufhhs5YBpKbas/6sMKXP+zI9nWBSYXG97g0E5v5u40lN/BTq6glkK1/qJxc6
         JSxKqHB/yKpuXcFbxh+6WGEAbwUGD73HNsSaNRvzUEsh3AWPEJlckVcNQ8X5HjOwkK93
         qUxb+b/SF/bhE8YkGzGLF3r/eibSGkmMGtqBdSI86RG0yQtpeOMMBs6HkI8DkOMLDz8V
         LIxg==
X-Forwarded-Encrypted: i=1; AJvYcCVsfvAm1y3sCiD0MZbHuV79ly1KahML2Afr6nJgNPnLU6OkwKe+YOvq64RAsXBGZS2zgIZRiHwLCJKCLtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOIGXX1NevkEi4F2lVXgN+RC/q0UBmX7LE+YVRDwXtqXyNQcU
	csWE2/fs4RAxHsl0wU2Vyk+G5VNP996bdhL5EEp3juPx23pnlQKSDhvepLgxOrU/J6jyv7z5NCt
	Oi9LOiw==
X-Google-Smtp-Source: AGHT+IHK2vKtVHqXB+biJn4Sn9ZwQIhFZwk1XPmEiMSuixpaE2V3uVxlb+PavH3nTc4PlRYrlQXQG7ej9nLE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:947:0:b0:e29:76b7:ed37 with SMTP id
 3f1490d57ef6-e2978585cc5mr5263276.9.1729122990853; Wed, 16 Oct 2024 16:56:30
 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:56:21 -0700
In-Reply-To: <20241016235622.52166-1-irogers@google.com>
Message-Id: <20241016235622.52166-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016235622.52166-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v2 1/2] perf disasm: Fix capstone memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The insn argument passed to cs_disasm needs freeing. To support
accurately having count, add an additional free_count variable.

Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index f05ba7739c1e..2c8063660f2e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1627,12 +1627,12 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 len;
 	u64 offset;
-	int i, count;
+	int i, count, free_count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
 	u8 *buf = NULL;
 	csh handle;
-	cs_insn *insn;
+	cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
 
@@ -1664,7 +1664,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	needs_cs_close = true;
 
-	count = cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -1702,8 +1702,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	}
 
 out:
-	if (needs_cs_close)
+	if (needs_cs_close) {
 		cs_close(&handle);
+		if (free_count > 0)
+			cs_free(insn, free_count);
+	}
 	free(buf);
 	return count < 0 ? count : 0;
 
-- 
2.47.0.105.g07ac214952-goog


