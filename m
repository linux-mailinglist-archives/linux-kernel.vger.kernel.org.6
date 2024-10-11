Return-Path: <linux-kernel+bounces-361397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A799A7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85132856D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8E19ABBB;
	Fri, 11 Oct 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="KxtzA3RV"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CD198826
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660458; cv=none; b=mm0r7mviA4a7DOEIt8N75P5QdhMn0olW7+TEsQfuNBZTzfkaWrzqe/Z/2yS0WI6z/KaHgMgWn2MT9NSLq+sRFiIQ9tGs7uSoTa/Kt025FGtRC6XbUguJ+mrBkSTp8p7w4JSiZPmuQAvmJkRnmyjcE9pb8hBO3NojSOQ9IRAOpZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660458; c=relaxed/simple;
	bh=PP45Dg1iGyv3y2H3r24fUF6A1hgqS1Bu5leVBaRAUcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdY6QrG432YMWUAYaV4WBWyd90V1qBBYH1KQrKZSw/N4Z26j+Odlc6R39HlywL9Q4l8+2aTpR1PSs38K0xreKspFNYfaMdw7NxkTlq4N9HUnyd/U+7wZ0slHHOI+XcbahZ++w/SrjXsCD8yODadFjA5g+Ce3tQs0u8+KIG2U9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=KxtzA3RV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4603ee602a0so16601601cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728660455; x=1729265255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfIq3eRh8OI9mTcVWpkOySISef6TcE4+YhZrQqF6xqI=;
        b=KxtzA3RVMif7UHb+6bjH+A/aOKt5C3ETC/+hTEvr4MDG4ciZkhnTWaHGCBq8lEs4S7
         u5av0gZSodxkt57nb4IyX4jTGncRQLBxNj7iyAC8kKOmNuMtE7CvQqEfcvQJI880sYQU
         vZeiDVKIO+THsGUBzYPi3MwEnI5AT3n3Ovn6W9KGZb5r45pY2n/esU3YpwP+LNU15/vT
         fXifnrB3EvyZ4YnP2+itPRduGLgUXeDNKgsc4IWLDanaIdOXBnT6qV096XTY+rE7+0To
         gG0D7MZz3oIykJ863CukGk1XXQbnbn0JSHfg6XBsDO1LD6ZMQeWq4Bzm99pBpJl8ACHy
         k/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660455; x=1729265255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfIq3eRh8OI9mTcVWpkOySISef6TcE4+YhZrQqF6xqI=;
        b=GAmPzFhYcTTSDESOERJYmguOhFmMokM1uA5ZL/O5R0Cgw88Gn6kzx2sn4M7C3ahD92
         j3q/5FcSpf+huToUHIpYazKpKv5MRPGAb9HUGGiy6gz0DS2NORaKdvZV5TTt7ph04AUQ
         Dj8UkBHq1vXqzDdps+YKeJdvnyddsnXy3ZpxuQYPLS/aeNcbnpbCRww7O03u7ZUvLdCT
         4Dhj24a1pLzi9/img15IYh805CCz+/pOCAjxwxurMezYgUWUCcDGsjoxQ/LRM7lJkRGu
         bgMf0m6tbl2dBUTbQ2NYhaegmZ8tVX0YElUDAFg24ficGOgE/Yug8b11OQ/v5beEIjAK
         v9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXtz3vXtZr+VdkNywTMj0BWZfTG9Sum+rZwC2bC7aWLwQ1pCsLixcpmQ7Ofk6JNgMcBxPryz6UBuaKSuL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynzm+3MD6VMsmKuCjhphMVBah0x4wBrKte84BqxS5sT6lFVP5o
	69s7bBbjuIvtMBhHrOEvXQ3Dq8aqChMcxFSMIqUBuJjz7F0WUrTJXIVnIPqOLNc=
X-Google-Smtp-Source: AGHT+IGQig3AH+6PsHNsgNhCOMU6nyFyU97psC6t2DSMG/IxFOgutRPzphS2AY3CaiEXqetYDbD+Nw==
X-Received: by 2002:a05:622a:4c8c:b0:458:3154:4d0d with SMTP id d75a77b69052e-4604bc2d776mr43570241cf.37.1728660454899;
        Fri, 11 Oct 2024 08:27:34 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d5220sm16344131cf.32.2024.10.11.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:27:34 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] arm64: dts: qcom: x1e78100-t14s: add rtc offset to set rtc time
Date: Fri, 11 Oct 2024 11:22:43 -0400
Message-ID: <20241011152244.31267-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011152244.31267-1-jonathan@marek.ca>
References: <20241011152244.31267-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See commit e67b45582c5e for explanation.

Note: the 0xbc offset is arbitrary, it just needs to not be already in use.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 8cd08c3a93382..f406c3a63d6a1 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -897,6 +897,17 @@ edp_bl_en: edp-bl-en-state {
 	};
 };
 
+&pmk8550_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+};
+
+&pmk8550_sdam_2 {
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };
-- 
2.45.1


