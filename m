Return-Path: <linux-kernel+bounces-187142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E18CCDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870DA282212
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1BA13D28B;
	Thu, 23 May 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MflyJX5G"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BF13D254
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451359; cv=none; b=ioGBPXkbfQOP2S2o4DSQtjJzadqK7S1eZ8lURiHOSfnnZ0EtnG0MGza3EZv1oim9n1wsuQSo1Pw+scwZCvKmBu0uVKDvaoZ7unUVgUvuNRWZLSCDcogKkXGDkgffStXMCLwQ8pSK5c6BDTHUVSnRVa9aqjFyDFHhFo7rjcoJG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451359; c=relaxed/simple;
	bh=C8sDWgMYMARKdYlzfVvMcP8JVf4fovQSAHLrQ/W78ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQNI/OqXgMODSVCYf55QeWcBeQTvcvN0X+8qUuRTnqRYq9BpNQ0Q43UaHPPFZEz8bwKzKwD5eL7zVKQzGaY6qfLCL+nUdCZ9uaysQ+3HmhwiRJqTDApeL/8ZFnDPQZt/09eb9lYI/a2URAsbUzdJbdnaiuQc+vkMHjUhcHXQSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MflyJX5G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b5898so48976195e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451356; x=1717056156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UTV4+P4H7+uVsIxGGCjRLk6NaFdUSwIupMLwjHFRwo=;
        b=MflyJX5GmdNEZOVx8gxV+s2BqWbL0AEKxWngPJRYW5bxm8c4Sgi4btVpm/mwGy8+Jm
         oYIu+227wy7VWszkgklDLB1+ISveGUq/k5y++2PrR5hN8wY3kVm+lO+GNl1fW0ABodiZ
         pHhJ/wFFNSCl49DcZNcKnQD5uG9fy2aYDa/ejXsh9cj67dTAX/mK8aAirb9S9cwdYPCN
         oH/5FNgJGlqTiMIrpVFhGAkclwN7UCYxrgEZMgFlSGg0AVRm11M5/AWUsjOTUhr33Au9
         3f/ziaRoY3CXvjB/rj/9gihFYMQ7LHVIdbirJJ8UfBSIb83JcRTVUqEa3vWRL7O5Xqgd
         Wy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451356; x=1717056156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UTV4+P4H7+uVsIxGGCjRLk6NaFdUSwIupMLwjHFRwo=;
        b=qyD3HWTujxJ1IyBrPRMybiCTdJ0pSIrbOi2+/+rwjrBqJVAkM2m78lRMi15g+YN6Zi
         9tOnHK8Vc+W5GrzwMfz5vFPi7krM7MFB1fdql6Dy/R7CxpATMeGUHgncsxja/lVcrHUU
         V/8Eyk8dU0aw0GGj+h4KSP36uz1Lhr+yt8ixx7swBmEJ5Of9RIZob4W/wcyxeubvIeDS
         09TCUp006myIoRbBhnO9CYmD004Eyj3ewtiC4YxAZdYr3uTqUlYp87HZV5IOhmL4krjU
         AIK6YM8ZGG/vWj5/QbpOAFcU+mXSab/vGdHVJzcOkcknGmUnOgpejpi57ADVBrJPK6cS
         Ce/A==
X-Forwarded-Encrypted: i=1; AJvYcCUwvUEmXX4WWlabITlv5GicTlqiZ01MUZbZvu0ySUMHDI86jA+59hJhNuRLd6peyu/KHVtjlPh3IzizjsDIpQIK703rpR11TmQgfdgs
X-Gm-Message-State: AOJu0Ywi2b+KpdypzPPg9Gbgk0FIctqta1y8+/Bg5aSMcSaG7HHH/n8t
	2ZTEb5L7M2xxiKW47P1OjISb3GTgQEI+q5VWzj6dGbArOy9OH64YpVHBB7Y34n8=
X-Google-Smtp-Source: AGHT+IF49vNHWfiYKOhW4GUh5UvdNVwkXdUWhLerjr6nku5L1GZw3HL0bskA3h4PrdU7ztVf/bakcw==
X-Received: by 2002:a7b:cc14:0:b0:41b:c024:8e88 with SMTP id 5b1f17b1804b1-420fd344e28mr30256415e9.33.1716451355819;
        Thu, 23 May 2024 01:02:35 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:34 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 4/6] arm64: dts: ti: k3-am62: Add partial-io wakeup sources
Date: Thu, 23 May 2024 10:02:23 +0200
Message-ID: <20240523080225.1288617-5-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
References: <20240523080225.1288617-1-msp@baylibre.com>
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
index f0781f2bea29..9ffa6652492e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -120,3 +120,7 @@ dss_vp1_clk: clock-divider-oldi {
 #include "k3-am62-main.dtsi"
 #include "k3-am62-mcu.dtsi"
 #include "k3-am62-wakeup.dtsi"
+
+&dmsc {
+	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
+};
-- 
2.43.0


