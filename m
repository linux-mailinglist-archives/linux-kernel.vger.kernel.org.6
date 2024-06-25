Return-Path: <linux-kernel+bounces-229394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F5916F30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F69282912
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88561176FA4;
	Tue, 25 Jun 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvDEkXGo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE617C7AC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336384; cv=none; b=hlcOS5SO79KnwYq3VzW7lw86Bibgwpw4BYPg1/g6Ps4v+w01ThcHw2SNIP4Jjh315oT/7cdDB9E5as8UEydPUgJuNfUkhgAVXAF2WSjBIpRsbl0ZYmj3iFMmkUfIJZRbFLuTKCDstaqfNn9zgx7Di3VqMmXgrcEy6OFv3g/Wc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336384; c=relaxed/simple;
	bh=4f3xu/fTKlsZKLAxp35O5+huY8NAWRnMLMbKlqWg7eI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UiIhUgu2m9mmLbEtTGaxqnEzcvRln1pVLn5K+jMnndq1UfdhO3WUWp8ceqfhhZpMjfs5wU8E429zIBNI+XGH4ToYgQsHopuAW1Tr+NNQtXnoQ/5LhDlJeGxo5OSy/4BLU/RYjvktG3C3lzhJnn+ZpkUnAFJpE3kLngQGrii96yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvDEkXGo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-643acc141cbso32542717b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336382; x=1719941182; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=dvDEkXGoJFB/3MouB5XDJ7dgmWHHS/tz9iRyILDKwObsk40Xj8GPw/oz/JtiUCkuY/
         YHAi6BUChX5pIHWlijdX+PFC/sTcVCqIXc3Oro0F9Ne0Khxgo57pwnukyX/HKCVvUclp
         hKpVV4oJQCcC4YeCG9ov5EvAjPQSch6RINkuyRJ8VbUcT0uYyfj/aoAnwBU/98CrTm3i
         LTYdMgBF/c2fKlw6f+U7STc6Ahk3DCAEJVFqnXJOREcxmQGubzive2YNPbwytyZXZXYX
         XyAK0J0zWL2iA+Dmw77AT/7U7tNirxP9br0sDqh7stxfwEnANpefGqvOrX4SMsWTcRkF
         jWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336382; x=1719941182;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=mqL7sjajQq3Tg16kFdMfyh1MntG5/LM4YNwSTv1yR+CP0r4yhrSMpe0dv7uk0YLPl/
         L8dEwVVwDAk1pCDWlAHvIXq5GXF8o5nkEp45TwD0P1rMIvbRUd9wss/SpaedxWkMdDq8
         chOFqHIKm5ThrMZqmaWQG521FORqeXRIpp/Ir+EzFhcUXLogPK/XtQkiS93Q+uxtOmUI
         dO7i1N/Wt619rBGbnvByd9uVaST5hDblOZtbR9VD1NwMmECgiu1bwQhqlOUtjuh+FcRf
         kuVw0AMfClJGg0iSG1xi1XICIJL+xtscrHh/rB+UrkqsT83aw2IuIbbaRMHCDAfv7rUC
         lrxw==
X-Forwarded-Encrypted: i=1; AJvYcCWLa5yBjGke2H/V8Ur98G8w0Ela/BRbjzUGIsZ+bi3OlLzBTt2us00NpSfa7X56u/c4lF2bGrkwj7QPH0fXCzGMPFxuFh9BrsH3w8mB
X-Gm-Message-State: AOJu0Yy5T5PN8Ue1Of/6/MLNYF+8KaHO5APky4LWvnhgD0pq1egT+CKM
	O4D5ZkqeJi1yqFtMyp1HpotVTcHcuCOnAc1RLGMG1XQwsct6gGu7Wc9hcjR5mUPqRUalhUy1nyw
	VbdgY6A==
X-Google-Smtp-Source: AGHT+IHTa5kZKd9h8ifXYMe2T99DgFi/uV4x8OfhUXLRdl9AjprPNPjesq9BkyxfvYvf643IgrcWtu2wbIrp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:f09:b0:62f:1f93:939e with SMTP id
 00721157ae682-642544fa2a5mr2623767b3.2.1719336381892; Tue, 25 Jun 2024
 10:26:21 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:43 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 06/26] perf kvm: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a3b903cf4311..692267b1b7e8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1603,19 +1603,17 @@ static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
-	struct perf_tool eops = {
-		.sample			= process_sample_event,
-		.comm			= perf_event__process_comm,
-		.namespaces		= perf_event__process_namespaces,
-		.ordered_events		= true,
-	};
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = kvm->force,
 	};
 
-	kvm->tool = eops;
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
+	kvm->tool.sample	= process_sample_event;
+	kvm->tool.comm		= perf_event__process_comm;
+	kvm->tool.namespaces	= perf_event__process_namespaces;
+
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
@@ -1919,14 +1917,13 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 
 
 	/* event handling */
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
 	kvm->tool.sample = process_sample_event;
 	kvm->tool.comm   = perf_event__process_comm;
 	kvm->tool.exit   = perf_event__process_exit;
 	kvm->tool.fork   = perf_event__process_fork;
 	kvm->tool.lost   = process_lost_event;
 	kvm->tool.namespaces  = perf_event__process_namespaces;
-	kvm->tool.ordered_events = true;
-	perf_tool__fill_defaults(&kvm->tool);
 
 	/* set defaults */
 	kvm->display_time = 1;
-- 
2.45.2.741.gdbec12cfda-goog


