Return-Path: <linux-kernel+bounces-319788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9597023A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9644B1C219BB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AD15CD55;
	Sat,  7 Sep 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilUYbhCm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91F158208
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725713493; cv=none; b=q0fo+5L28HbL4SEJi5B1OkYWWRfAKDEkUvsIC9nPmhD2PSpxLmsPgegGJqCvxoo76z5bdIT2WP34KayHfGKmz1nsrIFwG6GlKEerZHPCy0qCRuSroejAuYGxgIh3i8B6uRQ0xa+PbNEmGULnlTkbKSw2Q5djpid2h8BhzRf5yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725713493; c=relaxed/simple;
	bh=EDAXLCTGPPctvNYAbbxm7Me0iB8kQf85A6o3WySte44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTqPEir9W0FGFISjKxXlWDa6mLzlv2zks2qU3RZR2C2mUM/DOp+FsMtSY8AzNgnIti+Pv/A0yaPaoa6X5IesSe/ZULYR/fIFWk/oul2o4Ge/TySwD70zz99CusSyuxxPegFaBL1aohb3UGLDDgHZv652W75Ssx7o9jH0O9+KmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ilUYbhCm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-535be093a43so3673598e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725713489; x=1726318289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovDRCBi9iSRtbdH6fDiVUosmGhlKDzrTgtDNR4gXIlI=;
        b=ilUYbhCmQCgTZTqfwMLj+j/vDiRbimucJ8YLzR1VEHUprkHWL5Aiy0QWOyPw9f3wkg
         rLGkGgBzD4tRXfBFHY4JNqqIoYE89S+ftOsYVOYN9+K/mzvDVchsQR2sP1hAc4Xuxp84
         fd17sg0UoWCKigeNmWBgbUdaf0/ol66nxvE8K+mK4jekzT9YnWrXJqthJYw8wgvC98zh
         uzucPfy4llqJcR0mo1iI7iIrVJklbpAeksI9rcOtHCpsiKXtGFdvuy7m8RMoTckEgqp0
         m6QKiBt04tWlLWm+InHZ0n4Ps7GPkc1+3G5Mk1HnC5IwMDV1no4WUU1BJtMF34jVEWOP
         yPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725713489; x=1726318289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovDRCBi9iSRtbdH6fDiVUosmGhlKDzrTgtDNR4gXIlI=;
        b=wQ2aqCZRuO4p0aZTgi/1uISnTMuAaQeUYCos+tMkxxbcHKQp3aC7awzSGQYol92Rkk
         gNpt8/solZgXJqOxGtqQSRO7/eeOwJKQ5AzN9myCfzgGowxYlMq3qCB86hd+GnlbGD0O
         cTNgYyj3X4SPBi26ldtuqc44BAvt32/nX5WV5lJfyMsD7FwQnU+sFSj4eavZL52wet6m
         Mmn3oEzBl+GBZln2U0yoAdcHUt3Uej50T0nhtpFf0wjGg91yHC/ucyqktEbN+l9wp3Uj
         Vqu2LpciAa4uSFt5TWVWPcwWJrRZo8f96he2qCVLDy7eL9ALMjPYFumuGF/jTsHhKs2S
         jPag==
X-Forwarded-Encrypted: i=1; AJvYcCXjzlvweru/qd7KnXNWj3ghyzo3b5ki6YdnmWgJ5KpMtdIXFVxn0gotGiC2WNxY1B39FssnHjrM7qIVOfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPvgUnvTvwZvpnBhx4/03ixtAgZm68VbaYYkJQXFBzdg8JIP7
	QPWsrYKg0Y0w9VQ5ASQ8a+j7YzziQMypr7T2PkZBk2h0ZhDnyhsmfjDcM3EZcD8=
X-Google-Smtp-Source: AGHT+IFRLP6B4nwWLei4oiZ9eJVykUHiF61kCazDdU+Lymy23QexZJLmiNTHXHHfeRqcK/qMfKZiPQ==
X-Received: by 2002:a05:6512:108b:b0:533:526a:cd08 with SMTP id 2adb3069b0e04-536587aadaemr3979874e87.14.1725713488509;
        Sat, 07 Sep 2024 05:51:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cb76fsm143273e87.177.2024.09.07.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:51:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 15:51:24 +0300
Subject: [PATCH 1/4] arm64: dts: qcom: qcs6390-rb3gen2: use modem.mbn for
 modem DSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-rb3g2-fixes-v1-1-eb9da98e9f80@linaro.org>
References: <20240907-rb3g2-fixes-v1-0-eb9da98e9f80@linaro.org>
In-Reply-To: <20240907-rb3g2-fixes-v1-0-eb9da98e9f80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=EDAXLCTGPPctvNYAbbxm7Me0iB8kQf85A6o3WySte44=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3ExNSAb8ooJvGwtsasu/bAtl5E4plsGYfi9oq
 STuYdYhAzOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtxMTQAKCRCLPIo+Aiko
 1RelB/4xAmEY9VpCP3yhvRhZxxAumpIxblm+ZQ3B0d1JhgGZ0FxPEfcj8b+QxSb8KOCvAcD3V27
 xtPKzJRe23eFzSNHGOnpMNfn+ofRNMpq1Yp6b1lR3kNWQtWS8g74GjjUO5yAAVBEDn4aYnV2TI/
 BxP2YE0PWrLdrJoIW0Pj27k4BezOIIuRv0prTJ9mflsL/ukuocv9T9lBytJXh6o7OCc1xyysngl
 qGJI6A7qvSF8Dm2KGWYouXrsXi/pmIFvd9vAOgOVGQzOyAIzlcSrEGmZiYP2R86CJHVRuwwX7Yh
 Frk1B5Ym3ZRixKENHxuZ/8Fk1sESDFVuf12qCTGEjTcaWyrG
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Newer boards should always use squashed MBN firmware instead of split
MDT+bNN. Use qcom/qcs6490/modem.mbn as the firmware for the modem on
RB3gen2.

Fixes: ac6d35b9b74c ("arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 0d45662b8028..5d0167fbc709 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -707,7 +707,7 @@ &remoteproc_cdsp {
 };
 
 &remoteproc_mpss {
-	firmware-name = "qcom/qcs6490/modem.mdt";
+	firmware-name = "qcom/qcs6490/modem.mbn";
 	status = "okay";
 };
 

-- 
2.39.2


