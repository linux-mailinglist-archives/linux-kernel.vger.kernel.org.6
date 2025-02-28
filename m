Return-Path: <linux-kernel+bounces-538904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0813A49EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEFA1742FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65B272904;
	Fri, 28 Feb 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yS5wuYoh"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F6199FBA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759793; cv=none; b=mFxRMEryEHAblCoF9dDa9D57AyB9cuEGcdxLh0GXLMxI7VKm3Cwm5v4QN15BcnUYex2bpchAuYLbZscnSbPMbywokPEs44rCjQ3s/gWw9dcXk2pWzXc3J7Hk7jcuTSvf6DoxamHSa86IJQnKX/jwsduItGSFUzEs51G37YVIuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759793; c=relaxed/simple;
	bh=UMUMB04Duvtt1hisoD9El/5o2j4ORykTX88imss5UUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAuj4RZ8gNHGujhFkcNje7Eyg42XjMc6aqF24WZJvhquB+Dw9VkYWB8kuzzJ9LDieRyJycuY044xsZpPd7SdXNR2frk/6tgWbSO405yyUGf/dzsttfJNs6zxmwZuLuGBOhu7f2BLl200LjWLb3IYtoxpHueQ9ywXNlOs31Yg778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yS5wuYoh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390df942558so1824172f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740759790; x=1741364590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9NRbb2H47YH88i6L1c0H91IgGIN8sJwVUopLL7++Gk=;
        b=yS5wuYoh+WcM+/mRR6da1K+ieuMlInn+BlRyHhDTw19oJmYi1C9XPzmAbCPotmUY9l
         +Zyr7wXdWZKsBBvzWV8+gCquHD8pu0NOYfoXAyN6KVo29kbt8r992QD7QKp1poBqduwN
         SQl8kaEd5HXITXH4/EbnUzgD9HLe/rpuxRibj2rkB+6ESnAPffyEGE6U3bNBKVaXxttV
         bORhgu4VE04xhUqcb4pcyG1s88q7jXWNwdWTRH2f3klmlyieLNVY8qJfeUdgo55jPrIq
         7u7gKmSwuH3NMrgEN1mITSn3Gb5PL1mq8nr150vy5szZQChE76tJX8yH3eZU2KJX1vwr
         IDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759790; x=1741364590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9NRbb2H47YH88i6L1c0H91IgGIN8sJwVUopLL7++Gk=;
        b=PW7z/UbqtsMYsc1JsA5VAXL4G0673rpwk9LybwapDds21m3je2mBa7oGDYGGnBsBUz
         Lbza0FfwYW15+OGDcS7Rf27CFnmj6/VrScmPVJBmYzfhVn/EztlsywAXrspgAfpYGJyR
         NGxbyxg63GeEbtyipu9o8MeAX5DkxZf5iIEZmZMQG7PSGg9BEIZPMbSXndjbZJRDr8Z7
         jdhoqOcWS4vJtVY28piYYhNDN1mCGAQdaJQCW1QhDPDq2zxpINrtmS3vyyRcM/ghMEdZ
         OS8sIdipIWAXetYQF9cBR26QUQVp5tQRAkOlJvb+x12ZRrsWkmEloFOoMH/1mUOKRazK
         hdFw==
X-Forwarded-Encrypted: i=1; AJvYcCU7At7omuZFVuKFSQ51wYVL2gPdcYpnNrmZ3SZjPwB4Z09eNMglKl+nA8OxOvHVHI9NIOCFusWQFuIr02k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxnIyDraG1V7md0Qu6OhgS0jhxON9lJPoKw0Rwt4mpj7vVnPd
	bFNFc5Cy1UgUSG+2Zs44C5ZwnyXHb5gGYQeD/QA6YCJ5l7SePYGythHl4YwTybo=
X-Gm-Gg: ASbGncsPcwzR1ANJfFlisbFqjKMJMDuCMfTuffM2BHWfBnM+dkkcIgehJ4FwNecrLL1
	IlE3yfPfk3/wYo8k9FiQRj5r7DwQSvZLmkuIM7JvSDh5Z8mPfrbqCxxFZTcEVS4kFFX2qDWTDoT
	iHoFeXvV51wWufXG3q4kqe4o7waumzO2N+Bk0rK53hVbVYNkS/ZiqJ2yI1+3r+CH+cfkbpqbgI8
	179j9vvyZDwsObc6ar0Kzuk/14J/UMWQixwX1PWDN4SMn1/jYNzlh89S1rhzdc7bh0O6j0gfDQt
	pfR2uADN3ARTaJ3OMDHlD2XLY1YrG9Q=
X-Google-Smtp-Source: AGHT+IGtvBLdlQKwy4eRpJlFTD3uaH0lWK59AI4HrdVHengzh1kTNPMLeyRP3eg+L8x2PLVmtb6iXA==
X-Received: by 2002:a5d:5f91:0:b0:38f:3c8a:4bf4 with SMTP id ffacd0b85a97d-390ec7cd27fmr3516679f8f.6.1740759789972;
        Fri, 28 Feb 2025 08:23:09 -0800 (PST)
Received: from tux.Home ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53945bsm93905965e9.23.2025.02.28.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:23:09 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qrb5165-rb5: add compressed playback support
Date: Fri, 28 Feb 2025 16:23:08 +0000
Message-ID: <20250228162308.388818-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Audio DSP supports compressed playback on this SoC. It is required
to add compressed DAI and separate MultimeMedia DAI link to enable this.

Fcplay or cplay tools from tinycompress can playback, say, mp3 files:
fcplay -c 0 -d 3 test.mp3

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 7afa5acac3fc..dcb7dca20415 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1018,6 +1018,12 @@ dai@1 {
 	dai@2 {
 		reg = <2>;
 	};
+
+	dai@3 {
+		direction = <Q6ASM_DAI_RX>;
+		is-compress-dai;
+		reg = <3>;
+	};
 };
 
 &sdhc_2 {
@@ -1044,7 +1050,8 @@ &sound {
 		"VA DMIC1", "vdd-micb",
 		"MM_DL1",  "MultiMedia1 Playback",
 		"MM_DL2",  "MultiMedia2 Playback",
-		"MultiMedia3 Capture", "MM_UL3";
+		"MultiMedia3 Capture", "MM_UL3",
+		"MM_DL4", "MultiMedia4 Playback";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
@@ -1067,6 +1074,14 @@ cpu {
 		};
 	};
 
+	mm4-dai-link {
+		link-name = "MultiMedia4";
+
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA4>;
+		};
+	};
+
 	hdmi-dai-link {
 		link-name = "HDMI Playback";
 		cpu {
-- 
2.47.2


