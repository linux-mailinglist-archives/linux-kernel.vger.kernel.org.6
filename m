Return-Path: <linux-kernel+bounces-330742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01C97A3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5B11C27000
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150CF15A86B;
	Mon, 16 Sep 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjAl9MKK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E415A876
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495113; cv=none; b=RyDtEijHPgUZYEegftGJ+bbxYAu3zOGRsrry0WpY1S9o8ZnpZrE5sCUGl86tdQwvym42FLswyk6Iz3auefqBj7zNPRH5EL6ln+Uya9gcezO9UNVh2Iqy7HUHyaxcUN+Wsfw2RBmRNRWxHMSvDe1pCeHnOH/KgjPZf8zjtDx/vzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495113; c=relaxed/simple;
	bh=3cu2k6gc2jH2QRlu3LXOLx+bvkQ+zgDEXORBnmpwwJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbbpxSgMyza8vkpygXa7ED49/v0IGSLpMiDhTPFpa1fs4/ftdshMrUrrxQKrBics4PINJk7wiMg7l4jMuLTMQyp+uzjSiWpS2+is3aBYzYPt6YhNTuv6u4UlvSNlVWByHXAE3LBncVnZFYnB2b8mBfIP50A6H/5+8ufqGYf+jCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjAl9MKK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so3370323f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495109; x=1727099909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6I1ojreNPMnAqnnyAmn/bcHu89TPQPwVi7gpVoP/po=;
        b=DjAl9MKKA7VI4fhjfFLwW6yztxM5O4IIYnm/UzZJ3is4T6kVz+9Xcgdncx7WvZzoeQ
         nRk3JaRmIZRO6D6XhiZektTzbF7dBsDWc0/ej4yrk0DiGHo6/ViPa4zR0xYf0L/atFMb
         6M3R5+WP7RznOfH7U6yFAvvf+LvwWNFyQ/7MHHSvwH0V8l8Rs6zVcC8M1yE69LGBbN9k
         GU5Wq57Nn+NXUWD6wgBOMKBkNZQ5TWMQEbqPJJJV89ssIOZWMSKJPpSqmZG/y6neNzYd
         1zUNwODc7dRTL3RQFRfRRQcrasvMieIFC6fMyZOHPMyjvfx/97XJP2BKkVxhjxh0BAQy
         AF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495109; x=1727099909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6I1ojreNPMnAqnnyAmn/bcHu89TPQPwVi7gpVoP/po=;
        b=pw++0SNEQwh6jYe4lrz6egQ7ltpdt4Dz4NuIibKQUlNnLZzvC7D7nLE7H9MCPA1Qv6
         hRHSM925R1QcE3Q4bvvo3/U+fG4tkOQWIcS5pIoHJ5zSK/8gesV4ZOGKYFqABc+gE7vT
         b9DyLRu5LyHGfB1BIkj3oTvUnKm8tl1Wlf6tAXHX0mw+3lPrxF6g4qqqAU1qGI5shwhn
         kBMvt+LSebIPbu+1Cr1OodNaDOgIJaeDNXf7ChPrnbI0v2GLCe1EqV4b6penMJ5T3/n0
         o6f46yTRQ+HYSvYxdmHnVMEupIQcdJa6Kqpu9LuXXWmE3MaGrD1RNDCfc1KZ+kQbVjKy
         Asqg==
X-Forwarded-Encrypted: i=1; AJvYcCWYkABGYjjmkxB4C0lLkP1mrcwCLEfs1MMybxMZB5X46UofCA+dpgYXpkSD+fRCEZXWsnGvDhZtRv13vbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eqmkLvsyhg1r4As5o/031U301S1JfsC7y97dvMlmCsOwhI4o
	+WaB6nvF9BCzhZnUtXtmCRoRUlElgD1BA2AbeHJn88UNAwHMjOSu20UrGd+8ks8=
X-Google-Smtp-Source: AGHT+IFsrj9c9D2EcipbKadvrs/i4J9td9eJ+dOatQVeHhmva8RKXjoSO6yE9qOqsI6nilv8hZ9Unw==
X-Received: by 2002:adf:ae51:0:b0:374:d157:c019 with SMTP id ffacd0b85a97d-378c2cfeb36mr8698434f8f.12.1726495109000;
        Mon, 16 Sep 2024 06:58:29 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:28 -0700 (PDT)
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
Subject: [PATCH v3 2/7] perf cs-etm: Use new OpenCSD consistency checks
Date: Mon, 16 Sep 2024 14:57:33 +0100
Message-Id: <20240916135743.1490403-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
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
Reviewed-by: Leo Yan <leo.yan@arm.com>
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


