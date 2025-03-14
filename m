Return-Path: <linux-kernel+bounces-561917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D4A6188F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27362886CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF793205AC6;
	Fri, 14 Mar 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r86B2yOL"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451B204F96
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974524; cv=none; b=XvfQqEVqhXrIWwS6pUxa4J0SGWUPeSeFDmbKvs24fqV9gFpBNrzO6rhSmz/kJjV9tuYgCdlGYbC7M+R9GnsRwiOB8eGpFTSFR6DhsJVq3i504XcSN3Mj4VBNhQ9yk36sVufpirWUdYt4WFdt4rK6LN85g/YToUaDHVQ14Axiru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974524; c=relaxed/simple;
	bh=WZz3v+vsHhPD1tXnM2Sgca+yquBEKJ/qJRDwgWjeJjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4j9WJEcxXiH+e1PzindI+KJl7rkhhiHYVU0f61ufK2KyjW6HZOGtE1yfkrBx75CY2IDNDKVS30C9GJSAObAy7lpCoRDGJzboANmqrxojsqf4GeY2HJvJTeqx4cCbfqcU9YuMSrHqIwT2qe+MXEXmS246tGuumgIcn2H2s95hbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r86B2yOL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1274762f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974520; x=1742579320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/0LkOzwwvJNcYMQhvQr0pJ6M6A5VssVoqwJh0FipfI=;
        b=r86B2yOLrp5ovBL+sphVOm7K+tIjuBHFQSZ4+WqizlY5llipVKCrSY84Wk8kFSlOwa
         jxc4o7LZHP5h1wT9oIiUfYqMwCZetBrYCywa0qOngkxNwfbFD8SEwMePLXaT9oUUldAE
         2vaHBFec4+lgB+ri/yRit/iclJ7YC3JNFIcdNQTWFfeyBvJGu2+uDOJO++VKsUgsYuLU
         gFSxpIBnvExg5ozA1LOC3LiDKy0rwzXM56xLvGvRKYWsdzKDC/ty8XxivYvWWs+ZH4ae
         7W4gYAk/tNYVWRcsTh6DDqni1hhWfg9cZuLHrrKyfcCdlZcaIpG71ftPZUhxUkgj+/BO
         FgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974520; x=1742579320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/0LkOzwwvJNcYMQhvQr0pJ6M6A5VssVoqwJh0FipfI=;
        b=UuSha/rMmG8mcdg13y1rWEhFuDsix/nOyuSHEKdB8+NT77RulYcJZiLw/MItsOSgUL
         euygda0nGxqVo2C48YC0t+BUkZz50pU6IgP3ODG/WWllZuFAiwkk7XgoQuYc40uQAY7o
         xZrhTr54Brt734WkAdXVSehMjuv7ghjLkKgTJnBDcTx72/TeZDgwKL4u1SBkM5s8w1P3
         EqdZx73wGyG2PYmIYpSvbvNjGpjxD18jm1B/ZzCPZ3tq6DFV6nAA/FV4niNDlFvjigb8
         7ilI5ZM/K8YhQlBQBrXBQEBr5C2wsvZhCFqZJah4fDQ6Zqto5N/thvRJZLHxBHfzYClX
         dFDw==
X-Forwarded-Encrypted: i=1; AJvYcCWdSdOC01TP3vSPOMve87ZZLsEnmq2yrtkiLu/tVoNR8XyNVNFzFKvLTF+r3cmd6oEcSHWsOyp3QypWjFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJamSx8M6j1X7oJHwIljBaMPApkaCOt/nkCg1JbdGmsbj2sRd1
	LnqhmA37857wkFkplShDl3RHxvlSxeR1t4uYMgucYwcolQSqv3Vlmv0A3Vl2ONg=
X-Gm-Gg: ASbGncu6LPBfDovpodctg8pslytE8RD97XhCtIOtAGbjtNPMt3/7U56f/ARLWED7ZB4
	Ur+ZK15GYV/DEpggOg71EBuqf1lk6LzYJPC+NoStJAmGOVevQuRwsEVT4RezTthZKpo48E55CU9
	4TIvPVs0goubeUf5seJH0jZPReqPfzTCotWaUhf4BRCrjStxYsKfpUflDRX2m4Zet8uzw2IVS6G
	zJs/JfUofWDbMXvE0KxBTRQsxVzXKP1o0TwOROI5i4DsItnJ0qmX3UM1o4Wm5Hmm5NS2XU7PtQt
	CUUUx8GQT3MuAmaPNoN5A6fBiex6utggkCz9heSj40y1OtCcXaMywPO15nwJk9MBfnyIcJ5NhT2
	NcllF
X-Google-Smtp-Source: AGHT+IFSURXCATif01r54d+KQHoWw2qah8uuJQ120su2MkweaWrQyfg3Zuqy7P/UA//iCx8NnbbY1Q==
X-Received: by 2002:a05:6000:1a8c:b0:38d:ae1e:2f3c with SMTP id ffacd0b85a97d-3971dbe80bemr5173220f8f.25.1741974519796;
        Fri, 14 Mar 2025 10:48:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975afesm6117243f8f.47.2025.03.14.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:48:38 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v5 5/5] ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
Date: Fri, 14 Mar 2025 17:48:00 +0000
Message-Id: <20250314174800.10142-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
References: <20250314174800.10142-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Period sizes less than 6k for capture path triggers overruns in the
dsp capture pipeline.

Change the period size and number of periods to value which DSP is happy with.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 180ff24041bf..2cd522108221 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -24,8 +24,8 @@
 #define PLAYBACK_MIN_PERIOD_SIZE	128
 #define CAPTURE_MIN_NUM_PERIODS		2
 #define CAPTURE_MAX_NUM_PERIODS		8
-#define CAPTURE_MAX_PERIOD_SIZE		4096
-#define CAPTURE_MIN_PERIOD_SIZE		320
+#define CAPTURE_MAX_PERIOD_SIZE		65536
+#define CAPTURE_MIN_PERIOD_SIZE		6144
 #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
 #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
-- 
2.39.5


