Return-Path: <linux-kernel+bounces-432763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A39E4FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1575168A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD81D432F;
	Thu,  5 Dec 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLvQM6vG"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5B1C1F20
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388030; cv=none; b=Iei2QUc8CsUsyYakLeGg/7FnIhpufNsSc87wh3XpVVn7khQwjBmfEgMaXvsyxA+P18Ycn8LxFrhGsjLDdn/Ktok9MLQamwdSB0LUPV8HYjMM8qT7mw2pYDFtsqrRyJV4t9y8QHCs8w/wV27hVbhBh8SLLe1EkDLrzMjI8/F7uPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388030; c=relaxed/simple;
	bh=xjXR+zk+M/gbXTMjCLEiAICwQMABoaPIj5xLhMiEpGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoBAFjI9/g2PMn1KLKuFZPuBAbNRER1CRQBhFTJXqN+CBKPe1BfVByxRde3AVSZpFd6j6BlFHi5lFJF1hqFTQL2SR5CK4mCPXvNpPVlyM7fqKtZ5XBew59Hc+tNuOUIb1g/D9q/usTV9UwKjI4k68Ev8d1by8Ul23EXmRgnvO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLvQM6vG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385dc85496dso79515f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733388027; x=1733992827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DH+J2UQA3VOyjrU/P16pyU+YqVrTV2zl0tHrALJVR1E=;
        b=XLvQM6vGdICz/PvnTSce5Qqrors0BfOzfkuVAwKLamHvQ6+JWBS4ICkJpob+HeU327
         VQ9BcAA7gg9dhqkima6HTs+A3HrCbRu2ul4gJdW7u3kqMbwTJq3IDsl9NnkJWKGdKpIy
         ZgTHPTfyq0oRPn/Jo4puZ6P28Z0S3gLmzJWejK5k8g+ROP75oqn6n9je1cq9PgeBoKW7
         5CQ6NSWLheJdMTDV8mTXejJ67sbEfX0CqERc+6AaczTfpjfLW9XyN2rfYkWiHcGL3XP2
         9WKEoB36/4QqhcjHb7Sp6icO1H86lE1/1vzdzQo6j888k8lOPZfIOf1U3MmFClH4B7ar
         jxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388027; x=1733992827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH+J2UQA3VOyjrU/P16pyU+YqVrTV2zl0tHrALJVR1E=;
        b=Kse3Vx8tf2ByQ3bQ7fweyrlAqCvfuZEriNOoWmDQSJxyEOPVjaia034TogmJdijD+z
         MI5RhngHBhvGKqpjMH8bc/p3DtYxP5x9ftYT76mtkbxBFI+AOrisC5+VIpmFenETBL+j
         vRC1TMe5GtvqePGZLdANnS1mMtLOe7QKpZlBUfHeupX180/FPBdBCA8o2KmnfTQoFq7S
         OJ8n2A9hqHSH4ZsXYPFMb4iE59jUFkUaQ9ovmp1Xs41p+TVsb9QrNYdd3FA5JcaSvhQv
         vHcI4j3Exyd8EZLYVDdlFDU7haqixCGaXTyFjzZFTkgLK+HX0rcGoL3r3iIULHkPkMfe
         lUlA==
X-Forwarded-Encrypted: i=1; AJvYcCUvLdG2sO2bbJUwLzAMNrt6wHH5934o9H8CWa88ENaW5ziBI5dXaQGnTYc9SM7kNV+FIJoJ5eHMDe0LOW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQDr0Vy6tf0J1hge17w4T/Uw7WpcY2VY/vPwylyV+LC2+crJB
	L3RVGmoAs5BkI82H48JKGmuuWkiSSKCcQiBk02jdP/mNXzASaZN6UytmgfrkOzo=
X-Gm-Gg: ASbGncvOUvhAg8R9yWSOlspTI7/CxKUngFIzHUCbxK7dShPvj3UE23BNeNtxUelgP51
	M8z390UcGKxYZLtms9wF7fHrLOXmgb66c+KAqLb7MSCaiL+fgNwHBGRrNhTPXgU/J4KyJW0wAl0
	S+Urh6XlJWNRTGJeJGVa7u5vfkaqa5qIVlvQD6lrtGK/tUDo4m+CNjOesGjHTLhJzEDxP1rWPzx
	1kHILQwcJu2e11wsTzZzI4eOuLgD+1lpr1wLKHP92TvG8qhkU/63itpbqSd57oO
X-Google-Smtp-Source: AGHT+IH5z3TSEXxivD/BkQB0gvwva92E/y7Ua/n01z4CyjTb5eBwOSqHS1jSJiEwgXjn4T4axoxYhw==
X-Received: by 2002:a05:600c:3594:b0:434:a1e4:d32d with SMTP id 5b1f17b1804b1-434d08eef18mr32429525e9.0.1733388027475;
        Thu, 05 Dec 2024 00:40:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dab9esm15935965e9.22.2024.12.05.00.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:40:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 1/2] ASoC: codecs: wcd9335: Add define for number of DAIs
Date: Thu,  5 Dec 2024 09:40:20 +0100
Message-ID: <20241205084021.35610-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of DAIs in the codec is not really a binding, because it could
grow, e.g. when we implement missing features.  Add the define to the
driver, which will replace the one in the binding header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dzmitry Sankouski <dsankouski@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a2521e16c099..d2604da619f6 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -159,6 +159,8 @@
 	{"AMIC MUX" #id, "ADC5", "ADC5"},		\
 	{"AMIC MUX" #id, "ADC6", "ADC6"}
 
+#define NUM_CODEC_DAIS          (AIF4_PB + 1)
+
 enum {
 	WCD9335_RX0 = 0,
 	WCD9335_RX1,
-- 
2.43.0


