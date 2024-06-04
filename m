Return-Path: <linux-kernel+bounces-201415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F254E8FBE32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E9B28389A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64C14BFA3;
	Tue,  4 Jun 2024 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUnRLdGv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51414C58A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537359; cv=none; b=TZ4hkumG1dzWqffWoC476dkTDBoEr/zHcK6wo9Pc6wafzi6uEH2M9z8kvbUUdZoG39siB/6B6MXyN2E12EiVjC8bQ2Q+XowYnF6NYXiIfVu/IUsCruiSUxV+8XP3c68S23+WR8UwkTd0w0NR59f8G9et1Iay86EitAPbLbo2qgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537359; c=relaxed/simple;
	bh=IOvBn7Nyio2Q5k5EJinHxCGnyjUHnIrr3ge6E0zpSHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWHon+5Ro+LZy0/wx/p/ruorx12ZzFalxMDJthWBi0SgIizW5r2QH2syWlbk89bAFJPRS7IQbDTsyfxorE/nP4ePIREi/K2g6yPtMur1Tk+7dBCjFbOrGD/oEhdE/7m8d54G9gWr9BYUAuqqxKI/UPh/wyfXe6ihq9/Nwo57WJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mUnRLdGv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f61f775738so43437325ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717537357; x=1718142157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqRKPEKWRhplNDOM25p5twkIQfLSqkZ96KCbc1M+Mzk=;
        b=mUnRLdGv5Fa2RdJPVbPK/VA4ywRULMLrTl9ZokPrkJvnktC/W5p9x5xou/SATv9HTs
         FWr/oAOY5N26Pv48iRT2nYDDhQIOpP9S9hI+byLdPOveQ4JvH5e3Hku91LTE1//XMekX
         l7buNQmOInKww6R8g6IDD9e8EIS1dfTA+sNEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537357; x=1718142157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqRKPEKWRhplNDOM25p5twkIQfLSqkZ96KCbc1M+Mzk=;
        b=ZHYycp2qHMfvI4khAkZ66sjbMs9U7YRR0MmFGWCKtEluGyvVOMaSUxf+taD+hQgv7F
         ODQWyJYHhjNojviDHlkV82nFNjrZ8aiPfoU1GQOFrNIHgbffqnF1KL6hgwE/3MzkQyt8
         NSGI80oweJFzvpQZinciNj0kCqaMpwviFkrP7wmiHA+M02qQksipUG/5l1ysgtN/SR7L
         Duyz+94JPIod0uZkgMf5eF2IXoDmeUAhTb7Jf9LAsoO2GUH8qbyPnjqJvT7Zl5LNVN1/
         OHcGImpoasAddlRhD7IWKsMa3vGnrzLgOl7paXmDFC49rFKuUMMQJnulfgJTLd+4GhKl
         ZArA==
X-Gm-Message-State: AOJu0YyOuaWQ9lmnvWXbc/+T/vdyEr4OvVfH6OfbqSUZCP+E4HPxBSOb
	F3whukjoJQkvfUtT6dSdejTGAUzsTZ8WwBvG8TTXWAbVPT6gd139YJjqO+d9Dw==
X-Google-Smtp-Source: AGHT+IGUaXR2dqUozpVweS1vyHr9chwC5OlcDsV5AJ7BJUmAiiMFibIo5WHvLjglWhoIQUC3RvtDRw==
X-Received: by 2002:a17:902:f606:b0:1f4:64d9:5cfd with SMTP id d9443c01a7336-1f6a5a5ca36mr10300155ad.42.1717537356867;
        Tue, 04 Jun 2024 14:42:36 -0700 (PDT)
Received: from localhost (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6a39bb488sm5416775ad.267.2024.06.04.14.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 14:42:36 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sc7180: quackingstick: Disable instead of delete usb_c1
Date: Tue,  4 Jun 2024 14:42:30 -0700
Message-ID: <20240604214233.3551692-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604214233.3551692-1-swboyd@chromium.org>
References: <20240604214233.3551692-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's simpler to reason about things if we disable nodes instead of
deleting them. Disable the second usb type-c connector node on
quackingstick instead of deleting it so that we can reason about ports
more easily.

Cc: <cros-qcom-dts-watchers@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 5f06842c683b..b7de9fd3fa20 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -10,9 +10,6 @@
 #include "sc7180-trogdor.dtsi"
 #include "sc7180-trogdor-rt5682i-sku.dtsi"
 
-/* This board only has 1 USB Type-C port. */
-/delete-node/ &usb_c1;
-
 / {
 	ppvar_lcd: ppvar-lcd-regulator {
 		compatible = "regulator-fixed";
@@ -136,6 +133,11 @@ pp3300_disp_on: &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
 
+/* This board only has 1 USB Type-C port. */
+&usb_c1 {
+	status = "disabled";
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 /*
-- 
https://chromeos.dev


