Return-Path: <linux-kernel+bounces-279141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A894B97C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402BE1F212C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DD189BA0;
	Thu,  8 Aug 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyBedtPD"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BB146A97
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108173; cv=none; b=EdmJ6Eiculb8KTmC1YjhqYGwHHs8Fz4xcvKZdOeuuSaL1w4iSbQCraR+xmvML19bf6/xZTVWdhmGpEa8aHcn3LVzuewAu+b9G/YoIm3rb6JPNYgnPnT9bvrOIBjiH6Rdifofl3uI9BTkJ9+YH+nJBc/7ioCWjmZG1RmOJfz/1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108173; c=relaxed/simple;
	bh=l+TMunnaDzYEBDNbqkyGomfHVtIf7SPRSveFE+c8bCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pTlov8ICGnKNawJixcBVcdciPiwqy85DqzeFUgJOZ6Z4SxAbVFmXIg2UbFeI5oKYpwauwNc9779IzNYMI/Fd/RhnEkz7na+fGjQHgM40Q/EW96WBc1l9UY8fjsbpDhn1gy8OIZYne25JPRMzqMRQXH/4H3hTU0mgsBrDwNafk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QyBedtPD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so597432a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723108171; x=1723712971; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6K1xKrigqLUKfosZWg5PePAmCLxQRgMDc7IWF6RGgE=;
        b=QyBedtPDXa1SBAY3HAWIEX3HWunEOjnk5mfau0UX3fvVBYYk9qmdiCvCqIxDk9YUs5
         rpo3Y/YCs83UoEWDcWm8nKxr0XbWvTorsAJ9GSCxgrRSU4vNr03u5CXE5xS7m4dDU0dU
         /GnGmbLNkFgxlmvKY5Q7lBwq7DNL36UI/3JZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723108171; x=1723712971;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6K1xKrigqLUKfosZWg5PePAmCLxQRgMDc7IWF6RGgE=;
        b=DgNRNtNJVZuAlj284WYgrV522JeciTZzYv5XyFIWBhR1Fji7XjVvvk+RAg5NZGpJ9Y
         zJio3EAXeZDQKXdE/BTXbNNnj5mvpE2zVlpOYAt9oD4BARlcRkf+kf2HaCVc/4Pz0fjQ
         3UkXHVcoWQAnIQA/FSioSoAMwvw7m59kxvjRNY8rpQJhwnVDczZRtINsbMQ8loTEvVzj
         Antaqxr+xxlg5gLtm3Xh7TMZDj5ItjKO9pKvXa4fvqFb9abZf0Q+GuOB/Cx37Y2BHOd2
         0a2v5jT7+efSLSTMQECML7a7I0yw15QJE0xtUVesEEv7DgQpC38AH7y3anz6SRf2+3L9
         2w+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUopaW/BcLy49hP/MUIB9V6NxW8P0Jt69LbtNj2/FbvNb1MA9EbHkKkvq2M/v6/XtYOJ58bk9GG3AgM1Qy9fn/pp817tIVkW73OpyGW
X-Gm-Message-State: AOJu0Yx2YI0PbbVLUZvjPEHYYP7p6v/V66R+WmpowbXaOQYl3bfTsuog
	S/G+6vibsMLL1kmxQNsMlRIWJ3Kt5nUc2pCcTKEmQIjAkNNuKaPxsU1daqff9Q==
X-Google-Smtp-Source: AGHT+IEpIPr/0CxKkHq6jZNXwMVmpNr4/DF3EQ3KKvxR+I1+GgdpapQxRaKB/YWa0tZ6ccU9yAFqBg==
X-Received: by 2002:a17:902:d488:b0:1fd:7ff5:c673 with SMTP id d9443c01a7336-200967f6b7cmr16916805ad.2.1723108170942;
        Thu, 08 Aug 2024 02:09:30 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927f40dsm119661445ad.229.2024.08.08.02.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:09:30 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 08 Aug 2024 09:09:25 +0000
Subject: [PATCH] arm64: dts: mt8183-kukui: Add trip points to each thermal
 zone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-kukui_trip-v1-1-6a73c8e0b79a@chromium.org>
X-B4-Tracking: v=1; b=H4sIAESLtGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwND3ezS7NLM+JKizAJdMzMj02SDRFOTZFMDJaCGgqLUtMwKsGHRsbW
 1AEhUmk5cAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-37811

Add trip points to the tboard1 and tboard2 thermal zones to ensure they
are registered successfully.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6345e969efae..1593ea14f81f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -978,12 +978,38 @@ tboard1 {
 		polling-delay = <1000>; /* milliseconds */
 		polling-delay-passive = <0>; /* milliseconds */
 		thermal-sensors = <&tboard_thermistor1>;
+		trips {
+			tboard1_alert: trip-alert {
+				temperature = <85000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			tboard1_crit: trip-crit {
+				temperature = <100000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
 	};
 
 	tboard2 {
 		polling-delay = <1000>; /* milliseconds */
 		polling-delay-passive = <0>; /* milliseconds */
 		thermal-sensors = <&tboard_thermistor2>;
+		trips {
+			tboard2_alert: trip-alert {
+				temperature = <85000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			tboard2_crit: trip-crit {
+				temperature = <100000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
 	};
 };
 

---
base-commit: 21b136cc63d2a9ddd60d4699552b69c214b32964
change-id: 20240801-kukui_trip-6625c0a54c50

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


