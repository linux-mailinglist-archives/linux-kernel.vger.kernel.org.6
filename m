Return-Path: <linux-kernel+bounces-272471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3F945C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB09283DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D11DE874;
	Fri,  2 Aug 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZI5lUgU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BA613D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596041; cv=none; b=qNkHcGih0H0mpwYxkT1PRkg5YJ83X1MsQhBewQdOs2adRnnYKkqcNqUGUTR30AqH+CE+GNlWuc5b1ZTITSXot04cqz99av7nMtTBATIQwc7l/9VaXahs/ieb7vyefkuoADiUOG4MwnsoNYvoAjZd+rtxjpftF0dMoldOkY2NGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596041; c=relaxed/simple;
	bh=W3k2qVNyuZkZT893TNnnlsdcL/dnwQiUDPlQIC8IsGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKXyQDu7YMPEpmW5TKz4RUBI2qKmHg1BAYlNlH/to2PUU+b79lIfn7GYpmdfP/5DGKj5atZqd7+63Ed+qbe5GMod/DrrvXqXL9OdmPsmcYqR9OGiguFLZ+flHkXOaPxh1kUlKEe+jhKGrUCoTGALbVIZWfH+coiu8Y4RR5hx2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZI5lUgU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281faefea9so41526415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722596038; x=1723200838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7Dr0n7009Osu6At2MK4/anwH9MI0U9oAcIhAwlkzIw=;
        b=NZI5lUgUOY6BFscr9/5Pwuo6MgTYVZ8J7C8mtAUebPe5T6X6Da3eR8MYa1cOKSCp0D
         jaGK6XYtw0M3l2oKLepnviQwToZbozG87/plDtp1hBArauNK65DRZxE4WNHyl3fRDUT/
         L6aBKj24sSuWPiW6mXTCNeRzL8DTrVlKYwBmO7u6Zxg7sI7l7f+34Gunt7aDJSTwfxNU
         o3TTJoGMwemY1GbIL6tsB0rKfUCWbrmP9qiP8GvPKSDttTqLx+J16i356LC1OmncISCX
         w9y5ZXn85cyargc13NdYfdm7o+5wizcgjyKe3whIJw0iOviLOmrC/35tgN25kDAbrHGG
         m/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722596038; x=1723200838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7Dr0n7009Osu6At2MK4/anwH9MI0U9oAcIhAwlkzIw=;
        b=QbFxR1PgB7MWgBTzmSSiHHLIqhZqfTYjvbubTzny96qbTpaVPTf8bm8miiVnS3vvMW
         gUcsqsooGJC9Ve/9StjG0rbONgvZtE9Dns995JzaZuvMeseN0qdcBdW33+KvITtpNJyr
         SHSOxCqDE0IK9az0yqUax64A1fHQf3EkVEvE/yP3sjU5lP1SvEOgIVBLqau3HW5pQgFI
         Swgw+f6BET2xAXVC8m9op/2gChmcLNY8SYVipltdeF0iPBxSYhAyKBt1+u16iyeEqnth
         eVo8f3Y8tL46JPzELxMpUbqs75tTTsdRG+oK9kJaOZIQ/x65WA2UbQAejwUmDMkHX+xr
         IjTQ==
X-Gm-Message-State: AOJu0YzVEpTUNvWlsA/YH2mzAt7yM2GpfWiRs/y57oya6j1+Pu8I7lKS
	hBZd3ZpTl8K0kJ9LHljg4TVTV/pShtZU2oAW6DXogAI5pFMXXywVzcEaa2cwCnH9gRx5CfnaHEw
	i+1o=
X-Google-Smtp-Source: AGHT+IFb9LhZT64CqpWqP+bdwdX02NxjxA9v78/EehVjlumFJh1+ABYER1FHg3us71gvalOpldYGIQ==
X-Received: by 2002:a05:600c:1546:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-428e6b7c1aemr20635345e9.23.1722596037778;
        Fri, 02 Aug 2024 03:53:57 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adc7dsm89534845e9.14.2024.08.02.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:53:57 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel/bts: Fix comment about default perf_event_paranoid setting
Date: Fri,  2 Aug 2024 11:52:55 +0100
Message-Id: <20240802105256.335961-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default paranoid setting was updated in commit 0161028b7c8a
("perf/core: Change the default paranoia level to 2") so this comment is
no longer true.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/x86/events/intel/bts.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 974e917e65b2..8f78b0c900ef 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -557,9 +557,6 @@ static int bts_event_init(struct perf_event *event)
 	 * disabled, so disallow intel_bts driver for unprivileged
 	 * users on paranoid systems since it provides trace data
 	 * to the user in a zero-copy fashion.
-	 *
-	 * Note that the default paranoia setting permits unprivileged
-	 * users to profile the kernel.
 	 */
 	if (event->attr.exclude_kernel) {
 		ret = perf_allow_kernel(&event->attr);
-- 
2.34.1


