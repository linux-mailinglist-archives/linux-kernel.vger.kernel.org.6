Return-Path: <linux-kernel+bounces-361949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2699AF46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934D91F22396
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBF1E765B;
	Fri, 11 Oct 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="cYm8Lpge"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4661E2019
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688827; cv=none; b=e8EaKX8HAGGfajIcVPMhOu5Y64AOuAQLSE6eWk6AQ34IV6prAL74KCZ2TQNw61GFhU1fa4/yaz3eS7ZwPyO3GW5qjGjZoJOJEy8kb0AC/ga6FEq+Ud9IqR86Kze74y41QP/x0ti9H7lIfPhriFXCNFLh+dwRK9MSrTvXuCUBZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688827; c=relaxed/simple;
	bh=seom4uCMX8ojzm6Z3txLhCRgIagC4wOlyNgA6lYM/NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyHlof4na9n5IvWMl9MOR8VjZpxaR6+pZSAtaw5A/0BYbefkjJoQaNhY45UtSpxKY86SP3tevKm51t3fPdZaB1HGRaKmeJagGaH+gV7oqdjIbNGXFCWkmMbP0gO/yWJmdFLDar4VE8QdmbD7Jz3ym5/n9IT4N7fOLlnbYI8LTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=cYm8Lpge; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afc5e480dbso155220585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728688824; x=1729293624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNQj9mklc4l6H4BuWdWir9/o85V9oVFW514rZ2mNMmM=;
        b=cYm8LpgeqdBSDmlVuuD8VORxiZL/lWpVyQ1wnpL/s08XOqD0Awv7Kk8V8D7xkEAANU
         Q6CSyIq/KrbSGyP0ggK48Ba0wB9cdUs1cfEDHWIsY2oJR3TCuyMyMyjazPPoUWLi20iE
         27rkGFG/p7edAjdaoYlgmP9qY+SIocZ2JQZjpfVwrYn4zI9SvxJigYMS9skenD2L3dnp
         GrxJNjvLY6LmiETBxzSo9H5iHALCljU8SOhuOtvctqOJeRaYfskDUvuE+4TPJR5bj/r0
         1Sye016mQ5SSrrBvifiEnu390c8OMV/rpVW881qtoLRGZxRzMS0p4ut7Nbp8YkL4cahE
         uTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688824; x=1729293624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNQj9mklc4l6H4BuWdWir9/o85V9oVFW514rZ2mNMmM=;
        b=u5iptZAynrOTGSjgEyD1lT/guticyNBEqB9HX/Gav+Ma3O7C9bnSrtygJQv8YYLwFl
         FdrVNvKl0wGYZJ0rYpxgpUxKdPKYV6apHf9gcwyYI7FmVlH+8aj3m+aW0t71Jl6stGO5
         wa8P0M74QroixEiobYbIsq1L/FU82wHSCksdxymUYCCUj+IicLWQ2sqA3MsFXWVwWY8n
         sUWJbSpvWzB009oCcNgaxaTyi52eK0XAuoEiKAsfb64gcGUa5NrAtx3ymFnp8Gc50O7V
         ZzsYGHXL3KB/neiaLybKaz97egL2AdRYF3iDfckUnafwTFE4lgfLLw6CAVX6Fid+iZKO
         Ybvg==
X-Forwarded-Encrypted: i=1; AJvYcCWXhRfejvPFdsAE84UuyMUSdsZCO8NWr4YJpvE65L5LJTU4C6tC9FG63GWsDKNvazCDne7h6Q0IBxE4+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHPfevJJ5dkvyj0MzNso+bD6thejPUz6GbYx9Z2DkVgOeZ3vT
	ED3PmPMyOP31+Ef7njwLlS0Te4D8JnsvSQAgiEiR2S6PCKLVaKaoTAk/ezWcago=
X-Google-Smtp-Source: AGHT+IGcrSoPOBKvbLBtsjhkFspHjqr/dhe1nXcQ7/0vfufLIC9r3UFaacGLWaiPOnaDehUqUByn1g==
X-Received: by 2002:a05:620a:29c4:b0:7af:cb6b:b510 with SMTP id af79cd13be357-7b11a35f816mr625444085a.13.1728688823823;
        Fri, 11 Oct 2024 16:20:23 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11c0a8902sm89949785a.31.2024.10.11.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:20:23 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] arm64: dts: qcom: x1e78100-t14s: enable otg on usb-c ports
Date: Fri, 11 Oct 2024 19:16:23 -0400
Message-ID: <20241011231624.30628-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241011231624.30628-1-jonathan@marek.ca>
References: <20241011231624.30628-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2 USB-C ports on x1e78100-t14s are OTG-capable, remove the dr_mode
override to enable OTG.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index f05523cb51cd4..6343f34b978ad 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -1152,10 +1152,6 @@ &usb_1_ss0 {
 	status = "okay";
 };
 
-&usb_1_ss0_dwc3 {
-	dr_mode = "host";
-};
-
 &usb_1_ss0_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss0_hs_in>;
 };
@@ -1184,10 +1180,6 @@ &usb_1_ss1 {
 	status = "okay";
 };
 
-&usb_1_ss1_dwc3 {
-	dr_mode = "host";
-};
-
 &usb_1_ss1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_ss1_hs_in>;
 };
-- 
2.45.1


