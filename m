Return-Path: <linux-kernel+bounces-250539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664B92F8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E730B242DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB716EB77;
	Fri, 12 Jul 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLhojQtq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFF16D4CD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779764; cv=none; b=tai6A9WDJox8gBd5dULcLvVtvD6H6XgxC+dMbRE64JWhgxfHhZ4+fw5PDGVZDuhPTn8WsR2ByL0oE9lBWe4iFGdwYu62WVW45V8CS7lDAvnAHTwt4IjnEdoMQqQUbXm3ic0msRbDHRYlOJmhbTsTLc/uQaRIUv/7woLzmsDWeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779764; c=relaxed/simple;
	bh=OF5kuBWRBeBlB31dyxyZ6fG75qUp5sguPS+co/ixCEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIu+VgD/fIstCpq9F92K/KOUwLTDwt/n2DZYTer/sJorzJ1Q1VOfkdg8rLR1VXzTr+EfnHbwLF6FWotsnRklD6XZeNygH8VZD0R132eaRx8F0O16Jp4Vuokv9YzGF19eUwbdnaAHQdeAo/PJQAuVfj6a5/COIrulFL15q/KzF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLhojQtq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so1130362f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779761; x=1721384561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dUxw4pnzTq6V22lhZXyELBpDIT+OtfcjZAN4tSNlkQ=;
        b=vLhojQtqTByMRzkqNWRruGFpkqEfzSI+tS98ySAWqvQztO8XxEnAG7Q4huLNOEd/zx
         ikL1IkcuvsvAvXbrnbcPBju2W8Hr6MuCmdvFq5syExul1YIkWHOEpco8jbFG8/JriJRv
         Ngy6LqeWwSEsjQAPCK57PScC+GR6/KjW7EcaJe2XFYAlW+IhxqjjKT0qAA5fOnCNymBa
         RaI4q9pnelkt7HZFERayDQJCjCIjPlzwh6n1zjRH3kOf1VE1FXKlG5rc+QkqLmlhSina
         Lqw7iChqlRQu7lIZoaphhO2IWHH9sZSLqrb+qVpCoViTkgoFRnICrkbXlyznP4r/ojNq
         QvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779761; x=1721384561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dUxw4pnzTq6V22lhZXyELBpDIT+OtfcjZAN4tSNlkQ=;
        b=XAgLSBWZ83UMRX4C/kMizDFYKFvtVQxf8bsjQdO2pDutdvDrdArJqkm/3fPV8Pxijk
         Nt07DtFwOinDB0XCyiwUJ4Fa8boGrDZFvvMf2jSnGA3KFvA/4qm0QX8mB4jDdEwwoIZN
         /9VNzk6pjk1UnC1BCGCCMdtiHygSTZtna4lfE89QzD930Z36DJtDdndqvAuqfnTRuhA+
         3OtwC11UaFJAcjpQkuP0MNfjf9ZuMZWgyZ+hmiSzZkJygJxHLTdmpv9UP3wN26Q0WTNK
         4SAAFFEskH587tdo+rSL0Yykpvg2ja7KtTufGZnWqF03p4eaaHJxT+nQgWmylzhJH2VL
         PYKg==
X-Forwarded-Encrypted: i=1; AJvYcCXwAuRwEr4Az9Ef92kSeru6P8BTwhtjZkEr1LEZse7Fp8fOtVdbQ6x4rdculpBDWJ3SPSoTEGiPCrEr8dsoJVq7FkN/QpJF0Ccw4MVj
X-Gm-Message-State: AOJu0Ywh396kxqJbQwQevH0lR+Yz2mzJpD2ksYmiycks7G+BUPOSt4PL
	tUn8slbIbsCXMvDWBqvYOr3xC5uyirlJpWHE/80vSpG3zNtwth64mRwF5etzEmc=
X-Google-Smtp-Source: AGHT+IF+R3RQarQUJDVqwDOdNbdiQNMbxNXEfqhZWKHIvM9InYkmtV7hlxj0r3Fieyfyj3lD/5Omtw==
X-Received: by 2002:a05:6000:1b06:b0:367:96d6:4c2d with SMTP id ffacd0b85a97d-367cea6b830mr7924712f8f.25.1720779761602;
        Fri, 12 Jul 2024 03:22:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 07/17] perf: cs-etm: Print queue number in raw trace dump
Date: Fri, 12 Jul 2024 11:20:16 +0100
Message-Id: <20240712102029.3697965-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Now that we have overlapping trace IDs it's also useful to know what the
queue number is to be able to distinguish the source of the trace so
print it inline.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 2 +-
 tools/perf/util/cs-etm.c                        | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index d49c3e9c7c21..b78ef0262135 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -41,7 +41,7 @@ const u32 INSTR_PER_NS = 10;
 
 struct cs_etm_decoder {
 	void *data;
-	void (*packet_printer)(const char *msg);
+	void (*packet_printer)(const char *msg, void *data);
 	bool suppress_printing;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
@@ -202,7 +202,7 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
 	const struct cs_etm_decoder *decoder = p_context;
 
 	if (p_context && str_len && !decoder->suppress_printing)
-		decoder->packet_printer(msg);
+		decoder->packet_printer(msg, decoder->data);
 }
 
 static int
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 272c2efe78ee..12c782fa6db2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -60,7 +60,7 @@ struct cs_etm_trace_params {
 
 struct cs_etm_decoder_params {
 	int operation;
-	void (*packet_printer)(const char *msg);
+	void (*packet_printer)(const char *msg, void *data);
 	cs_etm_mem_cb_type mem_acc_cb;
 	bool formatted;
 	bool fsyncs;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 87e983da19be..49fadf46f42b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -762,15 +762,16 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 	}
 }
 
-static void cs_etm__packet_dump(const char *pkt_string)
+static void cs_etm__packet_dump(const char *pkt_string, void *data)
 {
 	const char *color = PERF_COLOR_BLUE;
 	int len = strlen(pkt_string);
+	struct cs_etm_queue *etmq = data;
 
 	if (len && (pkt_string[len-1] == '\n'))
-		color_fprintf(stdout, color, "	%s", pkt_string);
+		color_fprintf(stdout, color, "	Qnr:%d; %s", etmq->queue_nr, pkt_string);
 	else
-		color_fprintf(stdout, color, "	%s\n", pkt_string);
+		color_fprintf(stdout, color, "	Qnr:%d; %s\n", etmq->queue_nr, pkt_string);
 
 	fflush(stdout);
 }
-- 
2.34.1


