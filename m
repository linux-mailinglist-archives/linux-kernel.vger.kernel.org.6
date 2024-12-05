Return-Path: <linux-kernel+bounces-432509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25599E4C50
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F061881A49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DAF191F60;
	Thu,  5 Dec 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnnrcNqs"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04B18FDC5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366035; cv=none; b=hVE6YwKKx31O2haNSYtHCqFjEgn6/PW2fllsBgs/r1sUJfSA51elg0ExgmEIu7xSn3IDdpeqjdgT++kDiriGURqN+3lCsS3220CmrOvNCG0rCzqAPCRkqsH+eRVme7vovXj7ykYf7+qcIRkjNgTV3s5+w3aE3HEqiq3JPi8tA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366035; c=relaxed/simple;
	bh=YRQBf0W9frh8FEHOrg3W9F5a40CVpeTKHJworaSbgRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqZig5YvIMG+QopY+9K+ctA/kpaG+uBMYS6imI0F5VtlPK75Xvp8/Xv6QJjcbWq0roDi+X+V4bo40Dc+jyqKonIQHCJtxUYNQ9REYw7b/LotQ1z9OcJhgiHRduSBknKU13Ed/+Bjp68AA87yE1gMdXLpGoZMxXLYXA+GoC7ocK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TnnrcNqs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a83c6b01so2734695e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733366032; x=1733970832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbQg49fwfqiAPqum0vO3xu6S8El0T9nuKTumPVo3HTs=;
        b=TnnrcNqsn93sKAISSgUaYd0yus1Q+fHfc2Mh40HZJOsOGHITxzmlaAJ0i2eg8ek2Hs
         CCGcAy5ZHIHbZKxYpc+66mcBuNzh5so3b6a+pPyl5w4L/LciqjXBbdC44NvO0FUToNWm
         4DJYDI5A39PfSIAsjWe27tnK6xNiOrnmCSGZJufq1TRab5It0k8h2eytrAsH8oz+OOJJ
         wgxzHqUOZgZSQrprjAsOYojxw9encbZJfq3dFFYHosqwmMBL2TnE6WMOSpicKyssauQx
         Kr1tYeEA5uGrPDIBzj0Yn+ypDUv/V41DQBOkAWus7CZQBXHoV3pd9UuwU74NwUGYoxb7
         z9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733366032; x=1733970832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbQg49fwfqiAPqum0vO3xu6S8El0T9nuKTumPVo3HTs=;
        b=psgomMW/RdjI6Nli6hAxHE+EdBwuF8en/zQnbf6uvetDlwRnaBTx1ZRhpaGhj5bFgH
         Cr/ZOlIxvF23Ti57gMPoYwkb91pvIvIA5gx/BClB+mpmrAVXDmONlkVQWFlaMzRXZCmm
         XUxZWzgwwypuA1b1Pe5s0H+EtVZX+PQesvA34hHm0GuB6G9gXdUwZV1G0Bb231OjTTah
         mARKPwc59YJ4KFhZazPYSSs121t2KspkIoMF6onOhxPsdhYJuk6cvwzvojUdJ/NUN4bT
         JyDEMUHst11/MWkyiop0xCYb4g4e/CGGGnHmzgQ7dfZ7PMUVCJn2H/bRaBL47PMpbQsN
         0ggg==
X-Forwarded-Encrypted: i=1; AJvYcCU42MmztvE0buuFxi9VQZK4LmB/A31+R6sFxYRt9RW5O0zfbMqTzCOXxFGT9joOB6NZSGbYOEuRaN81LFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaO2FdTTLbeogJbR8vES89uGnHNNO/Wd9dgGwugwPJXWUyDoop
	duykXO+MjYzMnzixiVpN4vBxscV/DnyH255oI0Tsc7XEvifGhEjh+RcAwTzRTEQ=
X-Gm-Gg: ASbGncs8pLxvqq/gVBNFy3NfjbhnCkpXog9CFww5iygp3hFkDY9S4FuCXl2fYmAE3e8
	YErDRIgYwJNQkQ8RfqyDEouGnYLmRCRku2z8B3arKiumMb8aIqHY0bgAyrx/k2OGTWSjBU4OJ3q
	boDpe4s7WQ5LVFEntqi/qGGkanLbltWw1a5IRegspueHmWYPs3FKnFnN+8r5uPEtRQHj6lSQ0KR
	JE+wbqrJp1E48iT3oOjA2DPX9C1o0LpP55mopFubvVSdXydxSEtiYZLKE5qy3S7Rwkl
X-Google-Smtp-Source: AGHT+IEr04HIyGIAbnMgCxehAiEsQghxVfR78l+LYpgdbWvEFCUYjvf5mRhaEkf1BZj3PO52s5tGig==
X-Received: by 2002:a05:600c:46ca:b0:432:d82d:6a6c with SMTP id 5b1f17b1804b1-434d0a1db91mr81932695e9.30.1733366031850;
        Wed, 04 Dec 2024 18:33:51 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273440sm44444325e9.18.2024.12.04.18.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:33:50 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: dts: qcom: sdm845-db845c: add i2s playback support via LS1 connector
Date: Thu,  5 Dec 2024 02:33:44 +0000
Message-ID: <20241205023344.2232529-4-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205023344.2232529-1-alexey.klimov@linaro.org>
References: <20241205023344.2232529-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DB845c board (RB3 board) has i2s signals exported via the first low-speed
connector and this is also required by 96boards specification. Enable
playback support via this connector. Since this is specific only to DB845c
board the pins configuration is also in this board-specific file only.

This playback output is fixed to 16bit, i2s format and 48 kHz and works
with simple DACs.

It was verified with the following commands:
amixer -c0 cset iface=MIXER,name='SEC_MI2S_RX Audio Mixer MultiMedia3' 1
SDL_AUDIODRIVER="alsa" AUDIODEV="hw:0,2" ffplay -autoexit test.mp3

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 43 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 1cc0f571e1f7..6ca719281788 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -707,12 +707,21 @@ led@5 {
 	};
 };
 
-/* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
+	/* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0 1 2 3>;
 	};
+
+	/*
+	 * Secondary I2S uses 1 I2S SD Line for audio playback on
+	 * LT9611 HDMI Bridge
+	 */
+	dai@18 {
+		reg = <SECONDARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
 };
 
 &q6asmdai {
@@ -762,7 +771,8 @@ &sound {
 			 &quat_mi2s_sd0_active
 			 &quat_mi2s_sd1_active
 			 &quat_mi2s_sd2_active
-			 &quat_mi2s_sd3_active>;
+			 &quat_mi2s_sd3_active
+			 &sec_mi2s_active>;
 	pinctrl-names = "default";
 	model = "DB845c";
 	audio-routing =
@@ -852,6 +862,17 @@ codec {
 			sound-dai = <&wcd9340 1>;
 		};
 	};
+
+	i2s-sec-dai-link {
+		link-name = "I2S LS1 Playback";
+		cpu {
+			sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
 };
 
 &spi0 {
@@ -994,6 +1015,24 @@ reset-n-pins {
 		};
 	};
 
+	sec_mi2s_active: sec-mi2s-active {
+		clk-pins {
+			/* sclk and ws */
+			pins = "gpio80", "gpio81";
+			function = "sec_mi2s";
+			drive-strength = <8>;
+			bias-disable;
+			output-high;
+		};
+
+		data-pins {
+			pins = "gpio82", "gpio83";
+			function = "sec_mi2s";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+
 	sdc2_default_state: sdc2-default-state {
 		clk-pins {
 			pins = "sdc2_clk";
-- 
2.45.2


