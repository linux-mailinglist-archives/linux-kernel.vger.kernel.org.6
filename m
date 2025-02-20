Return-Path: <linux-kernel+bounces-523220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23437A3D3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB93B5827
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F01EEA35;
	Thu, 20 Feb 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2pBD7oE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F361EE034
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041394; cv=none; b=YRvKKRLvdZWlcrZW/cG6+lGLrXV4QwpkisQ0PROw12Q1/HQn1Jx7Ex/+BTsNDTYCH4vVoCi465XpaXiXVnNct6bU8FDQwjFeQ06LFWXLKp4uIn7XCnkJNiMcBRwd+oiP+V8rxq/6q1dMsLnKzKVXCGsCxReI+de2NfRgUBaXhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041394; c=relaxed/simple;
	bh=N8uFxJ/OSVfCTHYL0fWdJhMBm8t6zWJNTT/9BMTrCWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GH9+ooO3C28amanuIFDOxmuIktzBiMK0wzzaaSEXkm2Vfu8kXIj2YkLPxSRhD8tzi2NgM5afXLG3CmdfUTdXwp/U8B6m8k29vrtXErY7EYOCqY4ulHFd9ZWniF7UGLruW1br3H6OhcKzhA0F/BMMjsRZzuQ1SZl+znRzfO4C5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2pBD7oE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f3311ebd7so10916f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740041391; x=1740646191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJXzQcKpjC6CZ1FPt2dx2EE9wOEBpGIIanU5vnzaL4Q=;
        b=o2pBD7oEOZklFXfSRASil452nxtVcRCPVhA4RbzTpMpklF0SPgo5ULEiYtywIUAxP2
         zRdwOIdbyztwaPE7R5QQWrhyRPxcrEkq3xOzV0nd9cRSzVcT/JiIRa0wIBSzFOnkXE00
         iAM0dSrLTrcCSpkGp5zAfgUfugc0r6IwZF3M/vGqGZpyNJ3Xrc9yWN0pcufZov/VuJKl
         izZ7pTNsJDHyHnL34EJlBdIdrdEIyUM81vyZiHSBoclRceE1sQ8M6nNvEBLU1PWwGES5
         S+qvQ0uCvygTdnS1ikN1oHPMIRH3DuMos+ShairTkSxxtiI+sjLrSYzVZ2/dFjNhizAs
         WF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041391; x=1740646191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJXzQcKpjC6CZ1FPt2dx2EE9wOEBpGIIanU5vnzaL4Q=;
        b=Vf0Yyv6SK5eAKF5tj5NpONW5Zy6y04uRtup64u8zi+cxVYDwQ4MufvuCrwF8GwWfXt
         4XT71/VvJn4NxOyBQFTwHw2PUP0C8wfD5xeyTGWDYIiOXDPUTx6sAOn2/nDl9Mz6U3up
         OLGzc3fiY+U6ZkvdR9LKYV5o3AuUIXZe/XZCPaWOti/eJbSG+Ddry8YF6uTuoM5OWds/
         uf0w6q1FLQmoMaftl3BclkbJSl10Gl9SxOeBAByxtzSMuCouQudGAHWHgWMfORXv7yTB
         3PnNjbjbyb2BJ6N0tqW+gd5SmXo6XVqEG2LXPW6sV1rB9UhNZZppM49Jao7vQGLpDjHE
         /38g==
X-Forwarded-Encrypted: i=1; AJvYcCXHmWB2bYosUBGZ/cda6cKrItqGNv8YG98mCur0tcSjw8S1642kYgi7zb91GdI4pTroAdwu2c0D1bI1esw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nx8Ub1HhgGFw5jExfAgrJJe2xbQn8j8dwd7LrK7xu4gCAW+N
	XnmnUtbMt7APT7P3uRYc7Qlp1NC/tJ+JZANjZVDe1kTO62CPbmkYq7GHJqASnxk=
X-Gm-Gg: ASbGncuIsTpaRNWQFvEV7crVF0x+NjO3CS5eGMVsUBhZtvaAjLpfWtQIr5f/Ch2q5HU
	vBmlm1M4PWoi9D4LeL0CYOq+6YJcWWAUnYgNUJnSOyLd4D+gGelsUPpnSGOYcqWvYNhhiLA7qBi
	qhZfxvKuALxB8UXvb+Tb/hrfH8sLJuwbTvkAqRAu/t6fXLaDrgH1g6F9DQAgdg7nnGk/a8+5W5N
	qTjV3t8/FDKDZK0lKsaPfSfvhK3z+NTMMAeDu4llrGPzc2mgJqgaqTn74MiSmaQjWBptNzw0tee
	WfGrkI7GMVT9n+lEEgidIksPFJQo2z1Q9WKA8tbbwKWGTGAUUWgXyGpCY1A/sYje
X-Google-Smtp-Source: AGHT+IHXM7cOccdUhSXKFU3mEX2nF2lbPQQVqigJRm6lDJmZRSlAds1B2+C/UsvisVUpZJ7YUOjKHg==
X-Received: by 2002:a05:600c:3b94:b0:439:94f8:fc7b with SMTP id 5b1f17b1804b1-43994f8feeamr35786635e9.0.1740041391025;
        Thu, 20 Feb 2025 00:49:51 -0800 (PST)
Received: from [127.0.1.1] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8397sm234417565e9.36.2025.02.20.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:49:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Feb 2025 09:49:42 +0100
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8750-mtp: Enable ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-sm8750-audio-v2-3-fbe243c4afc3@linaro.org>
References: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
In-Reply-To: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Enable ADSP on MTP8750 board.

Reviewed-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Firmware release will follow up later.
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 9e3aacad7bdab6848e86f8e45e04907e1c752a07..8eeed7f2f7766326cfc7830002768087e9783b9b 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -784,6 +784,13 @@ &qupv3_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sm8750/adsp.mbn",
+			"qcom/sm8750/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


