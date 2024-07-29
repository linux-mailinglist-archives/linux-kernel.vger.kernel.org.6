Return-Path: <linux-kernel+bounces-265308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207993EF56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203D2B22A24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7737713CAAD;
	Mon, 29 Jul 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iafi4PM0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066613B286
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240081; cv=none; b=CzYgYCqgJuwxy4WXges2Un/LD0Nh/q98Kb0EPIzfy3YCFzNVADPQ+z3blPWJxlHe3uTqpy1EghDf6kZcWLWADtRhijPRyxBJ23jxKxxXfLnPV0gFesx3KZTyMU1SE0U+syAH01G5knWNlDEmgQ1s7Ddh0PWQy1k5rZOHHNhgV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240081; c=relaxed/simple;
	bh=Q7YB0WcALJsVDb7yxJK+rUTZPqhc/eLdyZInh9H7z+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqBPDVGoLWiz+ehN58iNx52pXDUHBm5OgJplzguNWBjRda5N6ixwGo4VzLNmUHsH/kc/aj7/u4SavsZyxMTSlb/bFBH+bV+ZWN/5ZkBTu+jgfzIOXB3p7vKzz7qxGS+dDuuNyOjiDyOEbIeQZZQTlHm7X9XRhZsgWBHHR+kNwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iafi4PM0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so14330255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240078; x=1722844878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29uxXeDOeLQP1GMl3yPmsnZHtmazUFEQgig3ecXgCqg=;
        b=Iafi4PM0Sk5dzHc++jYxn3oKOSC2hjB80VvNdUcq8lVySR5vZbQbGNHZme2oeWz3oU
         GSXNdwXa/7B6/3U99sCoHAo+fzEq3XyFklHSdiLg4sPLTCHTlZn/2dY2zComLSSTkluU
         57Elrh0BJx79tQIAGfUmcYHSrYOJCImuJqEhJuHPGDrv6UeowAEjscbSDXEdEVOWDDL8
         WXzV2Q/aaT0z50FZ4Z0uN4z2cIP2Qka69SWBOnwRO9DYy7KG1j4ahZ5ZnirRuVHF5br9
         6FQVW0fwbx8fIzA2FFI0nr7jWnuHGrxv6bW/zJD31zSmKPi1bX9rDEazah1prBrFOnlq
         roPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240078; x=1722844878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29uxXeDOeLQP1GMl3yPmsnZHtmazUFEQgig3ecXgCqg=;
        b=iOqyDJcTdGwxrXgRwnASS39ZE7wIBeLFQeKZxkyF/VLgTiE1aUfEV60DiGAYfUxhNZ
         htbhcA8ES6jl9MASLanpuZPpuSc7qoIQjqlxwDLwrFSgTA2r6lBZ0BXTK4B2ksy+BHIg
         HQ/LOUjsabsxa/z7dtwBBqVGGD4LsbWNHhlMNP2dTiHr1TPFqBz0aTm2ZaQQHd6EoS4D
         gkhbRkj0HqlcMGXOyXqOmZZb6SNpmYBuop7cex8bdKHUUdqPdUDj3oyYDEkKB4TNLmmx
         XsSwRUNu3iOYmIbt0FM0BhXRoeFAsrnaLPmtIe1ccVl8IX/q+FmTGesYDknV81+XEKpE
         4PuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsagyo4M3JkEHFKuQ+86/Z2ftLiJZBEpnpvTN5SUQsFhdfTn/vMitoGLFunNZvbeWmALdrW70RAftAu73PMzudo4Bg63BBSjLkm7yo
X-Gm-Message-State: AOJu0YywKwkZXiBCdwY4tlfId4YGhsh1XnHZAHALLOul82ciEeNew/ix
	prqVzajaQjy5fWLGX3eK7u4N0EPMgqQmqXdFbUvHccnLpI9VEUN3gk3fazkJ5Ko=
X-Google-Smtp-Source: AGHT+IE8Yiz/LWA3dIxdU0iaNYEV0D8RMGb+YexRP1/S+Yunh4kjB0gxOiHKJnPBRA9BZEvGWGKF4Q==
X-Received: by 2002:a05:600c:4447:b0:426:5c34:b19b with SMTP id 5b1f17b1804b1-42811d9af49mr44304765e9.20.1722240078644;
        Mon, 29 Jul 2024 01:01:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:18 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-am62p: Add partial-io wakeup sources
Date: Mon, 29 Jul 2024 10:01:01 +0200
Message-ID: <20240729080101.3859701-7-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729080101.3859701-1-msp@baylibre.com>
References: <20240729080101.3859701-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhore Vardhan <vibhore@ti.com>

In Partial-IO mode there are a number of possible wakeup sources. Add
the list of phandles to these wakeup sources. Based on the patch for
AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11..cd81f6d173f4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -126,3 +126,7 @@ cbass_wakeup: bus@b00000 {
 
 /* Include AM62P specific peripherals */
 #include "k3-am62p-main.dtsi"
+
+&dmsc {
+	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
+};
-- 
2.45.2


