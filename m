Return-Path: <linux-kernel+bounces-251058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FCC93003D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA851C21B84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DB17B42D;
	Fri, 12 Jul 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGNGynvT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821617B40E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807955; cv=none; b=mk1P98sNr07D+Li8s2R+2XVbnw7vOSVeWcOpHnQcLPZMGtEuejr2Cg6j5NWNPLbwd0w4xOU2M1BCg1vfU9PvgDqvS4aXnDaD3V8paBRZdR61RndtmYEqEDtip1d3B1nuHTRNxnEU7Y9MWUveSEb7TjiG6MqbSNXgP6606eyPNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807955; c=relaxed/simple;
	bh=5L2/QmV0UtQIb+mYzp5cKQ3gtaLl7JsRv/EFzdZAMCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KrTPPtPNmmkPXRcHvx/gyFAHD4ZH6dVsXvVuunWiNffjemTpMFaCzykbMcn0gYwdCpFTECvP8mJlH1UlLwjBQvUiXLAPgXohGI1IOpb/9JFb+Jws1IekeDg5u3nH3QVSU87UW+TJxlz6TcxaPPsZXqeP497UF7cM36oCwafuKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGNGynvT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03fe45dc0bso3904637276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807953; x=1721412753; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8vxN+BliJztZySzkr/g5CS+2PgB0g7RSTmLzIMrgEM=;
        b=jGNGynvTj0Cz1FibCSuMBAt80y7S0syWA2f+nwkor+oqqTTeg3gStwTF66McR7QMRf
         /Exwga0usnxl6chNl6MQ7IRq1IIz/Rly1vw9s0xqhunuQD21sywwUneLcRtqb/4G6xpn
         rPD7yexfAHu0hH7SiRVPNPr7Gop+9nkbQmh01fd+rcP75lvVjurXxhGtcQOGymwyfIqU
         Xqh1ArDTiKN71SzBrksi9SWmrvAe5k+nZHzsMGU+5l4FilvR2xv5qNZdPWjiSQweieOa
         vOQ/peSdvFEX2GU+XQGTorw/QI7Z2rgSkEMeWU8W0iyBAGqaY0GABrxjvCkouH289b3H
         WhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807953; x=1721412753;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8vxN+BliJztZySzkr/g5CS+2PgB0g7RSTmLzIMrgEM=;
        b=i4CAOy30C+A8QlSMWEBBH9pCdV3OscFj0IV+snrkQ4B95ANgN2nuPGhthifMaQQRux
         gdKjUPxxQs/gJ+d1VYgPHRgBiTINks1X2LGZf/ueTxXVi4reDDsNCMpcT3IxlByRvRi3
         j9Ytv3QcOSbmEbqU6gKblDN6F/xdALgtqEBvahYWwPLFlKVjLGD0gVYb5AcDIWP2zUd5
         UWdeGC1JBWUpa7fCzHwSn32zAfmHUOA0ujfDm8yh4mDkWTEL7wQSIdIOoIKZ0tqf5EG9
         S8evh4t+GswzVVf6J2IhzJPdbd3uUV9x6R+TB7iiZa4Unr3tEPKTnT3Tm0MALYk1hCy1
         QK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6gT19c48tvlGby9UApA4yVzO7HJsUbCQcfDPIUtpn+hBjI5Si2xbeGqYIvfY5XOUklhR8ZPVqTLJPQIq9az5r+vDv90ecIhUhUrpU
X-Gm-Message-State: AOJu0YzLufpw9gPemIIjaEDAEThKDOGy+6Utur1f775h7NlGO7IO0ha2
	hm2Hr2GePqT7w7+i3sDUdYrEtZPnlJDelpld+gXQNApmemxmBjJ162Jhcp8om9YL+PN1qEikJGJ
	75HEZNg==
X-Google-Smtp-Source: AGHT+IFvEFbuuviGSmLFXUVSDoQ/Q3jbvrU0W1ZoOeFfj2ue4Hk0CIvrQDw/sTMW/RbAltKLHza9t11YT2eW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:260d:b0:df7:9ac4:f1b2 with SMTP
 id 3f1490d57ef6-e041b04f0a6mr910569276.5.1720807952786; Fri, 12 Jul 2024
 11:12:32 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:51 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 10/27] perf evlist: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog


