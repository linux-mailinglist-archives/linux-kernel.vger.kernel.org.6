Return-Path: <linux-kernel+bounces-275051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADD94800B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DF6B2218B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88535166F3A;
	Mon,  5 Aug 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NMShuwxV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D538165F02
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877705; cv=none; b=XXYSWmVvmdEouKRt7C4+KvENTc9Gmkukce2cUTtkzd3KPfjMOQWH1uAsro+5FKn1yEWS+KOAdp0Go22Kk16fTGwwBHuYSFqbhc5IBgxRE/7aYYFUHWmLpKoR5OkooKzCuZdd1ZXEDRTYOkXWrK3sRseVmeXGPtTtuqKNwOYEwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877705; c=relaxed/simple;
	bh=fOe5QDIhm46dQdSVHJGmHBXXVLPxV84ny+khM/6SGgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+nw9X0krFXlLbpnZmdeLF3bKdZoiXWbDHlrjCDjrj1Njxqrfuf8mQSgYW2xX0UScT654HzP1Ry3AGFS4WgRe/Aq8I8Fg/hZLhk1MoDJU2DZz7+nCeQmH32ibJ0kUt073vw+ft4U6BLUZ0eoCFzC8bKFr+kCL7ZXfjbXK1VFSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NMShuwxV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so69568355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722877702; x=1723482502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3QCvU8x9eSdTnUH/pY66ZSSnVDaNlbO0nUbs5TfmmE=;
        b=NMShuwxVG2cAT01+Z8UNjpJ7Ybv/WqZfAIxTgenXYwVlIj9z0wQaYGO+rfyoeJqqz/
         aX3Qa4wkM8xSMUaB+YVeO3CN77qtQJ2Zeyft2yObHCWoC518HdKZumEA4LG0B/Qcp5z9
         5rwDWJV+An6trgxNiMvb5dtGRky64OJ3fZZBwq+0NDlV6e7CNK8FFTMQj7QszBJLOLtL
         U4WCKSEAwi2Jr2hGyPRnxIdDf8T3/pbr36dIPB/Weg5mbUCrvd2Tar4Lz5siGIBjDruu
         tf+66qdY6kv89JTV7c+SBhWftqEDTv1/Zmakv9QEki869MxrS9weA/MA230mOsVktgnY
         4bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877702; x=1723482502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3QCvU8x9eSdTnUH/pY66ZSSnVDaNlbO0nUbs5TfmmE=;
        b=g7tNeTWDo2ZbkHDq+vzjRvaoiVaftl62SK5pXyUnvrNYSRGiGWsDgVLuy6H+c/dBqI
         MfaGvfelgBEO5237gUyhaImC5Zu6siniybF0f447asuVLdBRRFpN6P0Zof79a95/ERsh
         mGyR7Oj5NjFdLX1hsR9sRqTH8qdBm31mAx4RGoiKcbQaugz6YVZVGrmd/yrRATItNX3J
         iNNlMfEcAMN6u7OvPf8uYa4Cz4v2RIA2+zr8mole9RfiCPoW1UnIkFlWOXI4tCE2X2iS
         gJGfKC7Vf7VS7tCnLmjHLn65n9oQ5WPO+jCApkmme6fmY+weW28kbz86JarQTJwnQwoP
         SdIw==
X-Forwarded-Encrypted: i=1; AJvYcCXuSBMhyu3gtwmC8lAx+JOOC6Zlu9GtD126CQ+lNRWUkamZtII4JFQR3G5+TcNPNcg//L0/19rTeOjMVUYFulZXiO3uVS+yqOXIFNQZ
X-Gm-Message-State: AOJu0Yz0g0fIa5z7Ibd9/Wdd2TW+ohbXHrBBDgE8XreTLM7udpzKcb3G
	EWBvsYo38ttfT0k8YkvYMbIxKIo1FQeJNCUufBQAPUft4VeZhBLpGR6wK7tvRBA=
X-Google-Smtp-Source: AGHT+IFinL2kt0ZW+r82mUcGc1zlJrmSNwuXUXZfjbMwG1TtcCy8HFpn3h38ghrGnzazOEgNcLxCiw==
X-Received: by 2002:adf:eb12:0:b0:368:31c7:19d3 with SMTP id ffacd0b85a97d-36bbc0c2750mr7750290f8f.9.1722877701966;
        Mon, 05 Aug 2024 10:08:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1068:b792:523c:3f73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e97esm10356486f8f.37.2024.08.05.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:08:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 05 Aug 2024 19:08:07 +0200
Subject: [PATCH v4 6/6] arm64: dts: qcom: sa8775p-ride: enable remoteprocs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-topic-sa8775p-iot-remoteproc-v4-6-86affdc72c04@linaro.org>
References: <20240805-topic-sa8775p-iot-remoteproc-v4-0-86affdc72c04@linaro.org>
In-Reply-To: <20240805-topic-sa8775p-iot-remoteproc-v4-0-86affdc72c04@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, Ling Xu <quic_lxu5@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=mHSCGz1vQWW9mhrvbgAo4snXP+mGs+r8C/sTB3mqlCc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmsQb8KeckY1dBX4cBouclIxBCjT5mjB6g1lWPt
 ijm97Csy/mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrEG/AAKCRARpy6gFHHX
 cl7XEADbpwFoWvffOqD2lveInv/RW+caWonCTr0Cctqwo8NtqJ5oSZOXrHYmXwGGmlktFlTqTB8
 1QXUJ4OBrOiKiYbh/25dxZ/hx1VN8aBshOkw7mXTuHp9thMTngy7IWThFHE+C7NrRjy6I7J3pE2
 525cuvUz6guQ9p9s6GISyaqvaWIR/fQwOkHUwRmtMS44jOXh88f3YDAbcYreKHrisrGtnxwQcug
 rHrDGPJJe5Unv9X7oKhuq115PcAR4pjHqPUCbelXVcQOSnkLdTpJg7rEOsCqqd2xqyb3r7Uopc7
 pTvnYqQ/U8CvZPeta1tCdj7d0gtmj9Zf/+12wjqnkpEm0bgILHTffWMKE1QsQyl/A4IRIkTNh0R
 nmccBR1HRCSZ1kzDeisHzTdNL32A9jn8tnWR335aAr+1VCZUru4fjZQeAQkyfUUm3sjqsuzb/Y7
 aBdQdyLjdL0bcDxk10BokTLbjjokyHdUDGIZn2Ctk4XivyqT40eza8QXcTdeP6dZoGc8CiBTIS+
 wqdM6JC7DPnDkWNqScYd1o7t7IhyAbtPO+xNcG21pa70cnMzJvFO3dib2ucJi9JBEaq1fE/YwVq
 R7sjAgQc4qMUhF0GEIQkfs5EIBvm9yMG2LO0YYLy9aY5KBowG/xPK4939aRzo6hHCJT3S128gzs
 6ELaNRmQ0PCvelg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable all remoteproc nodes on the sa8775p-ride board and point to the
appropriate firmware files.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 2a6170623ea9..0c1b21def4b6 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -702,6 +702,31 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+	status = "okay";
+};
+
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
 	pinctrl-0 = <&qup_uart10_default>;

-- 
2.43.0


