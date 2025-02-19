Return-Path: <linux-kernel+bounces-521873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6DA3C362
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419511725F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B141F4624;
	Wed, 19 Feb 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvc2HCEm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857C1F30DE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978227; cv=none; b=GUQWd628dIMUKKkQ1fT77k7WHvbmYjnQTskFcwExYAQrzFUlleRmHvLJME4/oPw7vJ1nwpQi6kvvMxZLPodyWPGokbWsUeRzJJ4sm+8UY187V3nqIW/opKWO51SihBAzNfSZnILEREoVlSSf84MC9XVB2AeAktFR/igXAjpfZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978227; c=relaxed/simple;
	bh=5Ef/H9SQz0qyD6vdyn2cJCrQtQNhElDaP1JYvY7e3sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKxs+NpggKm9wqJyB0taGppWsT3wPcCgTT1/r7mecTrRtL7EFXPWkf1UL6NxebAmhR68+dMZ02tqxgZhobe7EmN5TlFc23Cn5oI9roVSoI8KVNlDBU58WM356mLeXhfDbgJ6xK/SHXyY8mcQJUcNGhFYMU6Ze9xYSyQZUH3UKwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvc2HCEm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so47389785e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739978224; x=1740583024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AB8I4wegTQXb4Nt4v2IoDrjBpPCGZeradmAL978Ns8Q=;
        b=rvc2HCEm003zi3oHKix3zVzhhJYyenN0h/SuqjE7ECNtQ35cAm2aq6QCF2MLsWBdbm
         k1IpHQcDXREzOKBWz/ONaBCBLHkL2wysnqr9v2PwX53S4RE+/yAHx/8v/4GgH3tVzvdq
         JriOpjotM9Zb6Znr+4JPDibbIjR+J6CpdVnyY5mziZs4aPtzrgMYf4lnwBdx+2MPKySG
         nCr5dP5LTlPTdcFKorMzlzUeXol82e4KuGV5RC9hbY3vIng3L6qikjLkowtpjiHkyfRV
         WJv093EwdiE2jH059rRJ1XNYjOBkhormcPGsUWyrOqo5WbdYaJEOZyR8iYfqzfgBFY+B
         4ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978224; x=1740583024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AB8I4wegTQXb4Nt4v2IoDrjBpPCGZeradmAL978Ns8Q=;
        b=ngBUH1joanTWB1xXU6cdy9oAIuqFNAkvu6jsQQ6IQv+bzEk8u1gfuIqqZ44Lbily1t
         gE8QH2uXhYhYnFaLURCDHqoy/QZJGZVbf7lQxD8s1F65o8xBtm1wJXDL4AUnr8folV7f
         gHLtWr4ggENUjak7AycahPmi6sg70rGJ9CJoRfPXW29DmU7kx5gXpPF5GJT2Pv/826LZ
         n8pFiyVK/WTeRF1muHuh94dSsg1BuWFDya+zbf/ytJsCPL4peSgqiI0JFh98slHTp/LE
         5IIBUboKM0mnfY/7izn4hDwDtOiZbzky3zIT7k8vM1orCPzaOdxXnY1ybybBZLodd1v+
         kYVA==
X-Forwarded-Encrypted: i=1; AJvYcCWFe4cTh3/7i1KFFcUwUQoi5OYtSveO7h8+OpEocq8XX2g+x1krcf+VOlgpwZjcAuELTsv31vcJvgUlwyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozsRXhoiiDzODJpwm4JWitZC6DRH2PraDrMtZu4m291B6RW+5
	HQbDBGffiytf02u8lyhj3ij7UF0Rn7UDJ6y09tVrSyuvMBsASlHHHxsveDYUu2A=
X-Gm-Gg: ASbGncsURkVJVGDZbEkHA8eFM0zpqOv/1INEFlm0ph+TblP892FNFFd+r6dn4/RA/zV
	0KxcM7LyOs/bN+Z0gM1MQW9lfUPHxnKnqwS+youUfz6MPWkZafz6xrEjfsj+s4QT8pvJdifjb+Y
	brxZQ186b0DiA5gC5b1BLJCW3JSmdHx5jQK+MKLkpzn8j4Vj/NdU4Up6BFc0YnKu51uB0+wkgby
	jvjElh2IWAXbpbMJ85a/pnfqUaP8wvc3lQjPwoCcZlgjvMulf99y52I9zU83reaoB1rIUT+8MqB
	n83lC+Dt/OUePBk=
X-Google-Smtp-Source: AGHT+IFghAhU4CVYMM0z3nQZRvpFSkI5KSPb68OtzHjy/xmGIk0I938mkd7Bxd8Al9toNUNiuN4WlQ==
X-Received: by 2002:a05:600c:1f0f:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439865322ddmr114719455e9.14.1739978224110;
        Wed, 19 Feb 2025 07:17:04 -0800 (PST)
Received: from pop-os.. ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm214703065e9.2.2025.02.19.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:17:03 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf list: Also append PMU name in verbose mode
Date: Wed, 19 Feb 2025 15:16:21 +0000
Message-Id: <20250219151622.1097289-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When listing in verbose mode, the long description is used but the PMU
name isn't appended. There doesn't seem to be a reason to exclude it
when asking for more information, so use the same print block for both
long and short descriptions.

Before:
  $ perf list -v
  ...
  inst_retired
       [Instruction architecturally executed]

After:
  $ perf list -v
  ...
   inst_retired
       [Instruction architecturally executed. Unit: armv8_cortex_a57]

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-list.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 9e7fdfcdd7ff..c19826f218a0 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -163,11 +163,10 @@ static void default_print_event(void *ps, const char *topic, const char *pmu_nam
 	} else
 		fputc('\n', fp);
 
-	if (long_desc && print_state->long_desc) {
-		fprintf(fp, "%*s", 8, "[");
-		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
-		fprintf(fp, "]\n");
-	} else if (desc && print_state->desc) {
+	if (long_desc && print_state->long_desc)
+		desc = long_desc;
+
+	if (desc && (print_state->desc || print_state->long_desc)) {
 		char *desc_with_unit = NULL;
 		int desc_len = -1;
 
-- 
2.34.1


