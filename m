Return-Path: <linux-kernel+bounces-250537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D999392F8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6509DB23D88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FE16DECF;
	Fri, 12 Jul 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPugPovE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0C16DC16
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779756; cv=none; b=WtQmCB5O/nlpBDJ5ltoiBGbVVM9EH28EjBXqqHwwZIAm/2hu7DVYhdsde7BqmwIlFGdp55dLsn+2NloCA8dhOP1p/LCzvGfd+T2JDwulEp246Q/8IT8P8anX8ReEurUPZLhYTn1yjK2Ddu4hs1YUYM7QQmJK5MRmHhYHkzooZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779756; c=relaxed/simple;
	bh=T/WP7J/zzVpNhlOiKhMNQnmY6ZxBLAXZgTkXJ/3HlbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+un+pvyqo7PJGm3mMYhJqWV8xSH/L+YxZFQVIcHgWIxy84g+v1YP7v4+yscXaJsAojv749uzNRhNPJfxjdEp7jATEwo7Le2DnCfJz8Ohp4EFMnqaeJLmvCjMHVKuOxXEOsbUoVQ8f2WZ/B/Vb7HtDLMDgc1aub0Pe2exme8p9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPugPovE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367a464e200so1034388f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779753; x=1721384553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAEjb2rsZzI9cp0F4WnNKSmv65r49XxBwIOcuWflPXM=;
        b=oPugPovEm5pJKZY8KXPD7TEdYkuL7XavF6GMq5BizD8L4EqdrtosFDyNQx0SCBfxXx
         XYMbgJuf0iyRown2hYcsYpaZhGabp+SajTWpfyUIpC2Da/PAb68AJ8OD1EVuLf4mhDss
         l/MdNs9NyrB42j4/fwhvOu3wnVuIy6QTObJuy2/ASbJ45XplQcVsGtPK4WYuDUJ3jfcJ
         e5+C59PElMCDCMn+Q5PFVRTAwZOf56U8kowxl+rttgmYlJehL38ZNg40jF8G9WmVGoCZ
         VpNo5nravNZGoo3yoCByvrkXVoOM0ES+6KyeNrRj4d6JUPgMPHurEl4bPCOoEFADuRQF
         Vd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779753; x=1721384553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAEjb2rsZzI9cp0F4WnNKSmv65r49XxBwIOcuWflPXM=;
        b=oLWPeW2TlOpRchm1GfyxxP5iCArL31dhBidpXSDq3dc60Ds1zzT0vuWAQn+3x/D8I7
         Hj/X6eFhNQxIGhvHrDE9I1+mf0l8sl0Jsw0iOEIpYkD2NxbYp7YxssTYDlzlvNzonq4C
         +wN+pUvlOtG5OeFvoIzfuviGe29Tw3dxrpjm1YRKsGjUpzIt/MEIuiMtkTNX8mObTq6S
         U1gbqnO9P3XMJ3Ig2jNXNqt5RA1u+WR+BGNKdbpw3ylEoh5SFacW6awJJ0qbaVBhhds+
         fR4dc5mcOJLAPWV1vG2lb3QMmPFVjAO0YzMC29lThWLGv80QkiE9LTp/n2D9/VXHXjDJ
         fQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUePL1wKU/crz2u+X6poLJTwCXdVbshK4S3zsJZuAw/ZJQhqrkjo4633FEjIZF9ZCfJs4np2rGcpKbKJ5Dj/wlRzHh9abtFCA6aqynH
X-Gm-Message-State: AOJu0YzQHNJx6M7gOPxms2R3Xf1cPpAzNHCM1gcdWVzJS/LiubtThA9A
	V33w8KklM5pi96bT1BESmjLMxuUCWlXEvfYtGg9c7npIj8qoVA1wPfnQYJfk9mU=
X-Google-Smtp-Source: AGHT+IGPjnTLfBpPGirazj3MagWZ4dzGzTQ2NX7i1Hi2QXi7FbivacQqalO2G5Sx2vx8cy0+g+npzA==
X-Received: by 2002:adf:fcce:0:b0:367:909b:8281 with SMTP id ffacd0b85a97d-367cead9313mr6585747f8f.59.1720779752806;
        Fri, 12 Jul 2024 03:22:32 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:32 -0700 (PDT)
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
Subject: [PATCH v5 05/17] perf: cs-etm: Only save valid trace IDs into files
Date: Fri, 12 Jul 2024 11:20:14 +0100
Message-Id: <20240712102029.3697965-6-james.clark@linaro.org>
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

This isn't a bug because Perf always masks with
CORESIGHT_TRACE_ID_VAL_MASK before using these values, but to avoid it
looking like it could be, make an effort to not save bad values.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b0118546cd4d..14b8afabce3a 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -643,7 +643,8 @@ static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
 
 static __u64 cs_etm_get_legacy_trace_id(struct perf_cpu cpu)
 {
-	return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu);
+	/* Wrap at 48 so that invalid trace IDs aren't saved into files. */
+	return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu % 48);
 }
 
 static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, struct perf_cpu cpu)
-- 
2.34.1


