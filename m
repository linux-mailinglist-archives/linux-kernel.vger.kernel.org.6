Return-Path: <linux-kernel+bounces-316870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F096D666
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0931F24AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7B1993BB;
	Thu,  5 Sep 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gemYYS5H"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97427198E89
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533474; cv=none; b=r90/DMK8wzwe+Lz4C6Tn+gOxnLX+WkTSf3fC/mXbug+wVEtVSpwg8o8a36iLl39lBonz3BSlss27vM7z42ernxvoWFQeRWsjNStt1Z+yR6oJSbJUofiUtf7azMW4dz03+idpkK9c2ZY3lFAaqoTGIChCs1FSfq9H8oRwiddZ52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533474; c=relaxed/simple;
	bh=PxZK1UYoQiEz/5XZdh+TkbpX8o1b6IrqnscJH918Tbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EE72oLCmHFRUpXYDq1d2nrssDazWOVY9bioOw1i/4HCDn8mClE7xHnztEGncsc9yyHGFegWsb47DlZh8mB8MgV2OMEmf42s5Tp1WTqW44DyIW+okX84uGb+S4QhLWNxYOdyAqKE9ZTDLiFOxiHs2uabcsik0UbL2MMLUeq1ypZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gemYYS5H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d18666so4674925e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533471; x=1726138271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pve9lnNvOpeZGUhzPh1pcaBloPgbua89KV6dx7HbhcI=;
        b=gemYYS5HX/jIdB8RFQ/VlJfB6jAMM6GDNoUoJn0MTVm+WpH72ltkwcLCGVK5Y1T7r0
         o+pRJSdp+SdgMnH5PUueO7ng+CmDHp0gOz140vkVM1jLIeH6aEpGob27hzfFPBSuWYl7
         AYNqCkLeEnxjalx/DuKfboV2fFOgtiYrhp0/GagTTtV2KKTcC27fajFLp/Dw0pMriVv3
         9p3UUlkmGL4z+xVBE4XkFF8JbTLFGYeOfGGa5oBkHA/wV3Sm4idk4Xbt0nLzOGXaI6lV
         cz6QFKIxpW9vqOa/C+DRo0tXQr4z7/IwzzMvNEyMry7p+lqGzh24vii8VvhzpBOD1k/q
         E3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533471; x=1726138271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pve9lnNvOpeZGUhzPh1pcaBloPgbua89KV6dx7HbhcI=;
        b=s+xazfWY8ONpsHLQoVkvuJ55F87934lDsXPZ39kbIMwiZCFitWO8JbW7PavPX4T0bv
         CMocpEL0J06K/EYs5ZWR3NMR+SGJ5hYhskRnMmPYxIlSg32/ofclkaLz0nolXTg5EBX3
         lPaBYyCN4vPo1JT4SCENskTbUtoQoHpTQFb/rBWt8rexvqClBYNvlMExkXGnhi2Damoy
         9ZvXtSmdjMUPXU8GXDRLy8jfX5HvLCkaantEL7b9EMYyypKG/IpNrmMNcVW7zhRL4GdL
         xwto6GfTk5qxutYqoVR3TOXAHetakcNa1872nPnVlqHT+Oj25yzRe+hA+2DXAcHFSLVb
         +mMg==
X-Forwarded-Encrypted: i=1; AJvYcCWxQhuFnPm95dvkmSP4RMbh3UBY90NBc93TAX+bSzxfMmRz9uyTSJMadwFlHywsP0QRpUwUJKDNDQFdEek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMSEuI0OCnuEBCCeMlZRQTk7AAzSl8mAv87BBC1BVnZAJ8z9X
	U1hJBxGTBUBYxVlBDDGgesO8ZgYoSdDN0+uThWiRLO7pcJzZ7e3shaSHHSbw+3U=
X-Google-Smtp-Source: AGHT+IGNR6IhhEwS/jgcksvn9DO/af4hIbBkDS8ADbe7BTQ8BnykRnU/aKDonHdKsUgmQWK1V7Lc5w==
X-Received: by 2002:a05:600c:34c3:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-42bbb440201mr138466235e9.31.1725533470807;
        Thu, 05 Sep 2024 03:51:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
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
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/8] perf cs-etm: Use new OpenCSD consistency checks
Date: Thu,  5 Sep 2024 11:50:33 +0100
Message-Id: <20240905105043.160225-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905105043.160225-1-james.clark@linaro.org>
References: <20240905105043.160225-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously when the incorrect binary was used for decode, Perf would
silently continue to generate incorrect samples. With OpenCSD 1.5.4 we
can enable consistency checks that do a best effort to detect a mismatch
in the image. When one is detected a warning is printed and sample
generation stops until the trace resynchronizes with a good part of the
image.

Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b78ef0262135..b85a8837bddc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	}
 
 	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
+		int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
+#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
+		decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | OCSD_OPFLG_CHK_RANGE_CONTINUE |
+				ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
+#endif
 		if (ocsd_dt_create_decoder(decoder->dcd_tree,
 					   decoder->decoder_name,
-					   OCSD_CREATE_FLG_FULL_DECODER,
+					   decode_flags,
 					   trace_config, &csid))
 			return -1;
 
-- 
2.34.1


