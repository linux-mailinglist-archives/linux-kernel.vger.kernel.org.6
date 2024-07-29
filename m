Return-Path: <linux-kernel+bounces-265306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C993EF51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CD41C21BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9713B58E;
	Mon, 29 Jul 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UiYTBtZy"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F101386C9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240079; cv=none; b=D+gWt0W3DIbmyx40Vo6aXJ1134773UIWJjEusEBaNV9M/g+MJyI4vKDl0EqOi388Fhne+cRvkTZTro/fnJlcC+lHEu2e09wxNpKLxWmOm1ODIdL881O4wZh+4HatS/++0O4sfkOBe827SihSNlFfyx6enBcdzXTelZf3G/TMDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240079; c=relaxed/simple;
	bh=20Wfk3w47c2eDHVGu9FwABnkA+VXPgQxsX/7uDKiMEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJp+57/OrJmPQtKmTwmBFmDt7QsAi7epNjyydHgiLvIpPmvxEQJqyKzDwlPzdoWzpURulHJIzg2TZbRgvS4hbbzo3skefEQI942s3h1Y/WZHfjqwik6LasveyaV9COUrOLQh0A5BvhV3HEfwjn6GFet0tFlPkBls1Zy1p2omgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UiYTBtZy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368440b073bso906629f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240076; x=1722844876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lznQr0jMS1hTSLYpt3zZD9a+rnGG0mWFLbB4ZWDI+Vo=;
        b=UiYTBtZyGB1h56ntZKJauKrG66oNmWsF1cHXyIownUkwZO9w9OYQVJ6FcwPKQXV/az
         lQw6/2Bq0Gw1CVC70Y7WZtNJcPHdB3tSYo1bjIzw5sJPliZPVRzCRDF5AC36DDN9WpgK
         rf7Drqt6RZF45fWoXXz7SUyt0o8ZR1jdmMZ6k0mAmHgddZ/M6CB01QyR9ZB1aoHnJ5cg
         BdeGeD69MxM2ipmMrb6sBMFozgbBWwMgxKy+dqWaqMFC0hl4YTlPSKjkmu1LEZlvREl7
         1AMCE1bgQbHqiEOnTnJb3uyJfZJwRP9JNNp4VkxbG4xXS/v+yh461z8XUJQdl1LCzBbg
         HDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240076; x=1722844876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lznQr0jMS1hTSLYpt3zZD9a+rnGG0mWFLbB4ZWDI+Vo=;
        b=MoACPphoQsRKP67FxRLpu+61DUs5O3t9bsQ460dMg4nxQV4kJRZWHTjSBd2esvvKfD
         6/S8ixPZJCsI7Wf4VVgr6lc196+Dv4waeqwH1kwopNakI/QSbNLaiyqsr0KPhD8TmJ8F
         Mj/2uTCvmZFwrP5tsyHEBkqjW1/KcCvBGGeU/ZEse6HKocIlXNSYR88ZqLFGe7TmUvLh
         19rjXmceGSk3F9ROtAHFhetgCd93sgxmpgqEN9O4uGuClStT7EKlRX+jKVGuiyGaBVe6
         78F38hB+XCDwYqiHIKldiViptNFjYrtHn2fhvChs85M4VXsehMdmBGvo9YxPUq4oa8wu
         QMkw==
X-Forwarded-Encrypted: i=1; AJvYcCWkUZamtkQiDxQkcRis/VEmCRG9XMWZBo+pcd06hmiCDhEXRkbPDmg43KLWyujozpVchYevMChoa4gy1SEPYNQGXZzM+rDAD/neJdsc
X-Gm-Message-State: AOJu0YzIpEjY1neuLhcg6Xigj4rZQxWYz4HdPA5Wwf2MEG2kwfQBX9WB
	Pl8q1hTTLn4j/uxG2FoKFBTz9ARDOZJsc3c4GAj/xr1vUMy9ICdJKHzZ0wbeowA=
X-Google-Smtp-Source: AGHT+IH/sKkBGs22dutys1BjvCqtKuAkAgjEZni/gmQywUyTEpKEfEuJOGjetR+NjIPAma/Q1+SuTA==
X-Received: by 2002:a05:6000:1101:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-36b5d7c4bfamr3707368f8f.9.1722240076629;
        Mon, 29 Jul 2024 01:01:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:16 -0700 (PDT)
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
Subject: [PATCH v2 4/6] arm64: dts: ti: k3-am62: Add partial-io wakeup sources
Date: Mon, 29 Jul 2024 10:00:59 +0200
Message-ID: <20240729080101.3859701-5-msp@baylibre.com>
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

In Partial-IO mode there are a number of possible wakeup sources. Add
the list of phandles to these wakeup sources.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index bfb55ca11323..2bae8550c900 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -122,3 +122,7 @@ dss_vp1_clk: clock-divider-oldi {
 #include "k3-am62-main.dtsi"
 #include "k3-am62-mcu.dtsi"
 #include "k3-am62-wakeup.dtsi"
+
+&dmsc {
+	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
+};
-- 
2.45.2


