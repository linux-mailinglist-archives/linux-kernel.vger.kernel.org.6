Return-Path: <linux-kernel+bounces-524227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171EAA3E0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61297A8B09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E5F2135A2;
	Thu, 20 Feb 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5mN0vFR"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC0212B14
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068970; cv=none; b=J2tkBWKxD4QEhuqyF37+UWhH0oBuGeZwaxV3qzyzgwFEmiIY1MqpmJ7LbKA9o+Lo8dtW0eAvZuhT97dGTLzKzqXK/OvpjzkLYrdT2k7aIVBzx+oy9Najw2KuLF2hciQkoBsKJPR9oJsMwSym0Dd70MA392a5IU9pttSo3xJ3zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068970; c=relaxed/simple;
	bh=/VfHNWugQzZOouS7hKpPuUUlotDhboVqpoBQsz75KJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Air8OE04yyt9uJeBeH2akCfN75qYSKFFa5xmB8rppLmXBGWFRxSwuFGsif10t8POl8QCYN7OD6ZG1g2gpsrNaM6sRHeKwkDvq6e8kV2lWdwesw7bXq7YD6AF3IpOFXC5ElGuQ7aV/PNDh7CEhl47PuteVqN8zW0xFhbSLAypOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5mN0vFR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so916331f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068967; x=1740673767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNs8W2h+NxjkcVzoJNbEyvvCSIIo8azfvztr8o7DSmU=;
        b=n5mN0vFR1IPe65oQy+wbhA8osJ7mkeTeTJNjdDqudAuPm0weqIAeqMdiHBajOO5MVw
         BkJjvqaJeoDf7/zHNNLBzavmWK0x/uk+aB7vvoFr/TFssJLg0eYd6I4aRD9SO5xGmrKy
         LAumR0Q9NgNst1iJckuJLQj2jG1ckbcn7IyXXQG1ZBbujCN3g8er2BcHJog7tXAjI5tq
         c0Do7BFknFGODU2dp6+ObO8PE0HFD1xeJHQEA+lj/HNZJW2TkcILX6voJkE+nIOY5wxo
         wvzma5b4pTErJhKIAIRTo9NqZ368DWp67wCQL9/C9PhNLoQ3xmu5wMa2DY8Qbn5rq2Ap
         c63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068967; x=1740673767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNs8W2h+NxjkcVzoJNbEyvvCSIIo8azfvztr8o7DSmU=;
        b=BVelCvhAXXxh6C4nggt1o2t3/4CENFus1yT9GYDRAxFixKXMXSUn/66I6s4Z1dH1hq
         BufWibGTKIDVo1C5jHC7HGHWmT33/zRVihEFr7rLK3dmOWTTMFSGVx+riX33GiMQjcAR
         7Yv7GBWRnxdUi3951UiaqgQIaBUmstyagaHQJKJw0PgwAybFdhezIZ/UBcTNnCpQcM2y
         R1XYunQe1IO+S4hUq/52MIsypSlnigDdcyfcITGz8zcDvrBCBNM6V1Wtfzn0mmWWb7wT
         ALIkyz8faQh1s5ni+nMC80P4N+XgmSG0lFPO4Q2i7RA98gdUi/HsgHfoVt1+/RCMEwye
         F0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCURSn1ChPG5efpgsuvZDQlOMDebun4NDSmE4S7cCTZL127UxBId9VCcsWrUEp/TbGRlulTJD2tEDQRYSXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4lplBDk2zeqJU51OqL+wa/6KAduwuU1gguiNpWUStn40Jmwn
	9pCfn/Sp0rGbLazPQDsO+lOkTlaHX2e5th6PR+DngHxM1OBWlCDvQlEJGrNKYm4=
X-Gm-Gg: ASbGncvJFMV86MUkSXYq8en+vszJ9qVLyy2EcxAKUXpjNJ0gnipeJhMS4ZsGN65UeAh
	KpFxgtR3umLaR3XUfOdvT7szv5ZuW5IdQOrzx9BodJbvbdLJ59PtZEBQmHIB5A43QMc9mzs4uMM
	XDa3j0w8ftxUt74ilc940K+0L4K0oxt4aMihAnYvh14gBhaEn/nOyU5of2i2dxHiRAye7Yy7EXN
	gj9GomZ6VMTwh55Ko8lSBpV2sBj28pBH4N4gIyP5ykdmGaFJdMtGUC4YHojrQpxRPe05n52ouws
	wwFN1cLPFfMFfC+DMsXBkGTEw9YtwC/V8fp5lYBQ
X-Google-Smtp-Source: AGHT+IHjLSNxeifF/38VMi7dEG8R8mOoiltOqfkJG6DXGhVBYkNfwPD9ab3HxUNuKUZ0XFxpl43IYA==
X-Received: by 2002:adf:f3cb:0:b0:38f:2a7f:b6cd with SMTP id ffacd0b85a97d-38f33f3dba5mr15018331f8f.20.1740068966979;
        Thu, 20 Feb 2025 08:29:26 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm20813753f8f.45.2025.02.20.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:29:25 -0800 (PST)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] ASoC: qdsp6: q6apm-dai: set correct period size
Date: Thu, 20 Feb 2025 16:28:46 +0000
Message-Id: <20250220162847.11994-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
References: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

For some reason we ended up with a period size which is less than 1ms,
DSP does not support such a small fragment size. Adjust this to be in
the range of 16ms to 32ms.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 7466fe0c661a..049b91fd7a23 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -21,11 +21,11 @@
 #define PLAYBACK_MIN_NUM_PERIODS	2
 #define PLAYBACK_MAX_NUM_PERIODS	8
 #define PLAYBACK_MAX_PERIOD_SIZE	65536
-#define PLAYBACK_MIN_PERIOD_SIZE	128
-#define CAPTURE_MIN_NUM_PERIODS		2
-#define CAPTURE_MAX_NUM_PERIODS		8
-#define CAPTURE_MAX_PERIOD_SIZE		4096
-#define CAPTURE_MIN_PERIOD_SIZE		320
+#define PLAYBACK_MIN_PERIOD_SIZE	6144
+#define CAPTURE_MIN_NUM_PERIODS		PLAYBACK_MIN_NUM_PERIODS
+#define CAPTURE_MAX_NUM_PERIODS		PLAYBACK_MAX_NUM_PERIODS
+#define CAPTURE_MAX_PERIOD_SIZE		PLAYBACK_MAX_PERIOD_SIZE
+#define CAPTURE_MIN_PERIOD_SIZE		PLAYBACK_MIN_PERIOD_SIZE
 #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
 #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
-- 
2.39.5


