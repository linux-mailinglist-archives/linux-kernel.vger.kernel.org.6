Return-Path: <linux-kernel+bounces-446710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D49F283B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C1D1640A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A9136345;
	Mon, 16 Dec 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bQo9Or2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77501136337
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313618; cv=none; b=q/NDN6gGjjWtgbc0EOHJRGLz+N2SUHIf/ntb4AGEPVzaat8ohdQoUDvBg+LROJm9UTJPShRBsZHPPmmANsbvGSSUD8rkfECiiE86NkiMARQNh8T+sWjRHbEqcemabnk5CSHJdeyd4ulpNRm65FyUzbisPOJgBl8dwGj08pWQh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313618; c=relaxed/simple;
	bh=iEVYgx/hxX84VyoDEpscAjkrNLwDJylilFK5OuBYN9g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k1TCIY0ZY8WP84JkwZyOx5Os5miD6H31rRgt6o6TF8qUXEneU+0hmBR2vd6t+3Lr+3L5xhs97qZMz2aeTDZyfqXes0p2eJIiRwqEraYHkEzguAgLb4h382yvpG5zyxS8By+8JdyXopjc1rqg2TK3PF400/bmb/z7gIX0zocln9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bQo9Or2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e4c27270591so819457276.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313616; x=1734918416; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=2bQo9Or2DQaDZb+IOytzFpTNi0ar+5mtAPEDnoCgunmAMMS996O8TwFI0hMVGuuaFa
         oqb8vj4Fd5HZAPqxkSRcSG1ZH3gK5+EMyzzALKZhBYhqDq7/aZ6DqRg8zdbssHWG36WW
         OkzCUyxnf1lo0/0ccWuCmxlFaNWqaxWhUe+wmhpl/gpPJqrxSk+8QJiEq9H1Puati8/6
         wYPye/vMAVxEARNf66mzaQDz/5RVFkDLZnQ7weEGbFSi5T759bgSmF91uU1Equlx1hu4
         fLW4E9klkNMPLIuG9Y+5HwsEkjxkBF5LcWApcEeigRRtGG2Ye7w+SMU7vG3r4lYh+J7s
         j2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313616; x=1734918416;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=QhCkNqVciiOatIC4ttGFrHL1wKOvsuZOzSSbkX25mPkWJp3Dl51eOBDdX/ToH+Jhe1
         /x3a6wtZ0x3/CJcZeqmfF3G6/5w02CmF2k6KAI7qr0TjwLchUcPcM2/BNHZVdxxlU42K
         1SUV5go2BD0G9ANNl2zElkik+1SS/lwp7JXyNcHqSfQ/I8ToPvKqxAwdzl3xya9PGTNm
         yyFDvvoSl53gHCPoFO2TyldmZzcOOJjszgXY8j0lb6mOFaiVBVRd4CVL+SFEwT7Sov3Q
         QKhMdl/ANloFiMF5/Q1/rz0VqynpiqXsdFZCd3C+x4GPI9ScB55ZHVcR4gaaKdGSwM20
         HXZw==
X-Forwarded-Encrypted: i=1; AJvYcCV3IO1HaOyoR56y+fu6l6yVf0PEg+Y+kA/pzb1eMCyHmZG70hP7mh23LooPbLyDAHGUeO1E0UxMYgQuTRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFodzMKS1uU4w3DJklC2ypDmGNovx5i0uVyO11INyuyPr32Qdj
	aUBMCpDBXGg/IcjDJVXovFLtNIfZIl8yBDacBTHZkbtncH1dzEiTrtM50CX6IN19JTGcAejcA5F
	ozCCmkg==
X-Google-Smtp-Source: AGHT+IHzhopf++xHJgpWcD61mnNsp8wVUb1egX9jwPAyVVZFjVKzSAtoohRp+jls2hjdFscyiBoONmBj9leR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a25:ce0e:0:b0:e25:d46a:a6b6 with SMTP id
 3f1490d57ef6-e434fd22102mr7287276.8.1734313616433; Sun, 15 Dec 2024 17:46:56
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:37 -0800
In-Reply-To: <20241216014637.304761-1-irogers@google.com>
Message-Id: <20241216014637.304761-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 4/4] perf record: Assert synthesized events are 8-byte aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Capture that events are 8-byte aligned and avoid later misaligned
event problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..a5689d0e93ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -624,7 +624,10 @@ static int process_synthesized_event(const struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, NULL, event, event->header.size);
+	size_t size = event->header.size;
+
+	assert(PERF_ALIGN(size, sizeof(u64)) == size);
+	return record__write(rec, NULL, event, size);
 }
 
 static struct mutex synth_lock;
-- 
2.47.1.613.gc27f4b7a9f-goog


