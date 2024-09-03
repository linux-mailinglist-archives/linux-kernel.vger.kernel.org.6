Return-Path: <linux-kernel+bounces-312637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D596992A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD03D1F2431C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CF1B982C;
	Tue,  3 Sep 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="L3P+K+cq"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D71AD254
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356000; cv=none; b=qhlK1YI65B+t4aouXpnV8xUn3GWaK9W+5kPVt6jpOrXWQDYCfnfDRExnYCzJx3cwN+2QpmrgAI4VaBCkivInV4OH1+goqD5t/7gXCpTMnMqdHm9IQ8GqNENsrpyCikk+1G7iB8cQEKmzCp/vtyr0NM7Ff2tw+wSNJEoZPA8NGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356000; c=relaxed/simple;
	bh=9dsYNp252XCXLeZVdDf5E51difa2bgrBMStutB0fu1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7aTwBLHR8QWNw+U6kk6jeiz/3DWuP+oS9nJFP2cO4P9CaUXRfJkzen0KVSDjRhd7NlGr9cK53RYitn9aC1V7a/ae5rXTIIJLfAvNssy7r9KPZTVNduSILjzW1m07V5iVZ3qjqZ/c7VELnfOx5owhGVfL8IRcltHBhaXyxqHuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=L3P+K+cq; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277c861d9f6so1818380fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1725355997; x=1725960797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ueq56/ihM5P7UHNM9LExxz3BL+BrqPFaFFbdMDA7T6g=;
        b=L3P+K+cqTD7FA+uxOBhtSR8FitZ6X1INcoZI0dLhngJ+HIwKO7SwmRZaot2zWoHHVa
         JMPoUqRoroviFuV2HLEa5L7jDWIj5fVq8W7G0HZeXGCqmxPgKqB6oSvMDiskAZPOSiXO
         c0K8Q2WWo88WbQLqsJtg703SIuE3yK2JxT/g3HifENV44Pbkcm7+PaJJ04PVIotLK071
         yX5ySLNnW5wNEIrwZ82QBHGPGJzE6H4Tvxy6ge8nZpnfkMWeHXxxxXR3JjS0UWHo2JoL
         EQ5xLgwf5ZQ63MLu7yXJ4tegHTIKZw0g5bBgSGUcfVKFxfFSfDXizmUsTLBTgiooM8G9
         mDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355997; x=1725960797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ueq56/ihM5P7UHNM9LExxz3BL+BrqPFaFFbdMDA7T6g=;
        b=Uk8LT1C7a4ID6u90O/xP4P6o4vULbKXbdKDIICXDmw4ZFjMY2F9pZCmKjjgyJodHbO
         Q5kGawi04oRGEgv4eVuv+sXFUZVMkuOmmGOUTpVCL8JIJYz7zJg8lpW0RSI+Paf31E7O
         Z6UoTHn6Y4tlb1VQnlq5c9Ge8Wuh2bBz/GEnaMALqWkdB3wEWK0oc2k863fmP2GGUCA0
         xQ0zcw4dFz+CMefCtSw05u3ZKgI0VYt5ZuaiWQHL4g90EzXdUqknP/5HY8/111PBgbEw
         bUMZTANqhFE5/jplRjGWt+imraUatBruNdSdjLpCtrap9PF/+cquArXM+LTS40RxRHKe
         +H7A==
X-Forwarded-Encrypted: i=1; AJvYcCXf3epAgupx9TNt7aYh0/HQFrXnFD4LgYh4CGZBQ1N/2qBH/NvWTS3C4X1kM8L4m5h9vytmP2bI0N4wBJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0VvZGV6kc7GAFPJV0GJbOO/kV2y5/zHHc8Jk9Edo9hDhwjN8
	IEgAv7OzzB9acEpUZZ55zVgAgBobKH0Da1NDQfFb+c0zO81tWYkhI5jSx8+wYg==
X-Google-Smtp-Source: AGHT+IHc8yX+S1ZXZeTcmQ5A8u1mvv0IrBsqppyFA35CEi2Tk/eV8DOVds8sW0bRplyZMtz6Ke6u7g==
X-Received: by 2002:a05:6870:eca7:b0:277:e94b:779c with SMTP id 586e51a60fabf-27810b95fe3mr3301878fac.19.1725355997608;
        Tue, 03 Sep 2024 02:33:17 -0700 (PDT)
Received: from [172.22.57.189] ([117.250.76.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d72d1sm8365868b3a.170.2024.09.03.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:33:17 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Tue, 03 Sep 2024 15:02:19 +0530
Subject: [PATCH v4 2/3] arm64: dts: ti: k3-am625-beagleplay: Add
 bootloader-backdoor-gpios to cc1352p7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-beagleplay_fw_upgrade-v4-2-526fc62204a7@beagleboard.org>
References: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
In-Reply-To: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
To: d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=9dsYNp252XCXLeZVdDf5E51difa2bgrBMStutB0fu1Q=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm1tfEpliavJH9xYgy4XhOMi5G/rvxrKEVED4yY
 F8oY208HKmJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZtbXxAAKCRAFzvXHieVa
 dFhAEACg46eymI+09SiSpRzRfg6b+SpXlknETkWrd/3opSTGuqU6gc8JKgGLfTA0DtVbDUwdJ6S
 eVdFWFdn/1co7872USRxL52+ATPTj6BPWlpvqMUvc2AcCC1cr/INciz0hIMueGsnQRtxdKWhRMH
 OhkrNEHey6kHn8fF14oUhknD8ynVMe7/81uJ767biwnU2muuLDZIyW51oVQxl3ocwIPGIXB/Cl0
 rgqb2ERaN5P03slQAYquN/Jvw5xgB5H9iZ8iA+JKU/Y7DcG+qBZ9YAP3990aA/7G4dFWQmVeYeZ
 X4mjM2BhMm1HrIJ+3wPaXPaMP7AlJXjpMCanj3P0B8dOrrdBJvWo6x0J+E2lWzhFyq6du2KF+JC
 LySq4rFgP918WAH1SUC+QaWXbeBbTMS2fop8jw5hx7wmHBSlyKl3sq7iYUkruTMnN6k2+615kl+
 kB8hoLCyHHvP8zlUI9FZxVt7dG1WpKIrP2/BGwuoTpLEjQlTV2eu4vTj+J4luZjYrhnADda6xnX
 G0TkUOUI/zhh4fxpGNjWJcHZQngTFcL38gmdHvT4ielcGZqlOBrcTLaLmHSL2ZymGNKWi+M0m3L
 /nYZ2dWcvAcvuTLuw7L+GUzMdnfRaf5QIS3w8Y2XQY5pq3hapEjBbq8FkDMReUKP9ZBYAKJph42
 emwpHqgEqQnwt6g==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add bootloader-backdoor-gpios which is required for enabling bootloader
backdoor for flashing firmware to cc1352p7.

Also fix the incorrect reset-gpio.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 70de288d728e..a1cd47d7f5e3 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -888,7 +888,8 @@ &main_uart6 {
 
 	mcu {
 		compatible = "ti,cc1352p7";
-		reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_LOW>;
+		bootloader-backdoor-gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&main_gpio0 14 GPIO_ACTIVE_HIGH>;
 		vdds-supply = <&vdd_3v3>;
 	};
 };

-- 
2.46.0


