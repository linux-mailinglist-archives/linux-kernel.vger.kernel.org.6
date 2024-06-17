Return-Path: <linux-kernel+bounces-217939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D490B693
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946981F23F38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410431662F9;
	Mon, 17 Jun 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0CyRYxv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C215F3F1;
	Mon, 17 Jun 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642195; cv=none; b=XDm6n9s5GBH/3vuWLiPXpcUm33C8y9ayGUz/PklpoPmI/CvAaCAdQytjIeaBLy5LHeqdz6zpAr05nXNmsl+P7kuFKYuRQdWGJO1tSTMSHvPMHKgZb+5777buYs8ZdwogR8pl0Pd1Vvub9UyP9gJEP8KqjCEkg+FtD0GUpDtzlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642195; c=relaxed/simple;
	bh=PafAoQuauL2uDpvEMoalA/IWpx3Yh86pLH0rQoSNF/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m5mo3Znm+IiAIr5cwlQJGQraNu7Nfl2YLHgt2G0HAwNM20vJDI+lZE4+X1OPWqfNFXhvuuZ999mqpXil29p0thuOI+S0ijfhLl0883EwMzyOcKxQjlC/9V0IeyzQjXBuifi3HmMkT/JdgK4LuZBbram/K6pFJnQyxIN8mP//4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0CyRYxv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so5442093a12.0;
        Mon, 17 Jun 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718642192; x=1719246992; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RX68X2X3/LgY/l3MYixd+6MA7bxPaVTf3PwZWrV/Y9Q=;
        b=U0CyRYxvXMytLI7M8yXo3wCut0trPpVPo0VEEa8Ysr6fh1cYCE/CvuW3R3Mz18yftq
         LaVym8irWG0YxN7kTZ2yjraDNNfNi/EDDBRYNAowFIc3Q6hW84AxV/JrKCAjGhXkaRTV
         QQcP++6pQpefZLIkdwt4kA4P/Ckhu8KrAlrXmrV8fZIWafnV5wSrfOJL+XFaOZJrPNUi
         Gb3sDc0Ygr090Y7Xzr3Gg0AJ9PnyQv2ULzScRM4aGMXbuUHBo9SknkJ0VbD2jYUX0GEo
         6PnYdju0Pm/SZ46ovKwCeM2mP59N6mlChxjPMPXFM8hw9dLqdj0GwUf4T12uK2AhuvI1
         DehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642192; x=1719246992;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RX68X2X3/LgY/l3MYixd+6MA7bxPaVTf3PwZWrV/Y9Q=;
        b=Lu0rFRudfL/PMr8biqctIDVKhJalrq66GqBtKqNAa8ysgyYcMJE2gjz/Zu+3xoCnPm
         ekLe7OhUpLcINeaiq4emNIq+FmXQ5xMo2xFRSQYvENvji1rpu83HKgItgo6MdrP1YzL0
         mj23vKAqr1gvlspqhQ4fy8hBfYjBSJ2rrW2pTfFBMQsqgxu1wgKl5vj4VRI51iegjsCW
         2xOHEGq+UxUlb9yd+s5RYbhJAUZP7+54ucbe8NW5HC8lNePgXKdDpZ0JUBRvQN2xITRl
         6OZhHXJrlACCO/m0AbEfeEf7HgDTygd7QSnv7aWk15xHPyk+bVwjpGzunf1acThbS33p
         UtCg==
X-Forwarded-Encrypted: i=1; AJvYcCUC2wA/K00+wdbKkFiMSqMTdIScsvPxV730/RAZJpyYCVMbDgj0vtoOzxI6MCiLPkHOI6OoR1Vtt8gPqxa1cyURhtLe1Gy6w3ezxHO9yvZNAkgoTxQbhskb4MjnI3pPvycQNPCTw2psrw==
X-Gm-Message-State: AOJu0YxtnCwK8oLqVuKUJnLMVu6WzXfRxw/31kBcHlurXjtR1JcQ32WB
	f7zRvpuhSzpuv9YrjWzmouZzVqNOROmdoPAtw3MG2Dp2niY1S1tLw4jf5A==
X-Google-Smtp-Source: AGHT+IH71gzLrAlo2d/fCViNvMGwCFnTsuGXcX3WVOzNheI0BHq7kjsmP+W4eSqwxgAmyFq1J/kUtg==
X-Received: by 2002:aa7:d294:0:b0:57c:cab3:407f with SMTP id 4fb4d7f45d1cf-57ccab34137mr4262219a12.9.1718642191987;
        Mon, 17 Jun 2024 09:36:31 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b032sm6618545a12.92.2024.06.17.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:36:31 -0700 (PDT)
Date: Mon, 17 Jun 2024 18:36:29 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: hwmon: ti,tmp108: document V+ supply, add
 short description
Message-ID: <ZnBmDXfnDQXNXz3k@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

TMP108 is powered by its V+ supply, document it. The property is called
"vcc-supply" since the plus sign (+) is not an expected character.
While at it, add a short description with a link to its datasheets.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
  - rename "v+-supply" to "vcc-supply"
  - add a short description clarifying that vcc is actually V+
  - update commit message to reflect this change

 .../devicetree/bindings/hwmon/ti,tmp108.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
index 8b5307c875ff..0ad10d43fac0 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
@@ -9,6 +9,14 @@ title: TMP108 temperature sensor
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
+description: |
+  The TMP108 is a digital-output temperature sensor with a
+  dynamically-programmable limit window, and under- and overtemperature
+  alert functions.
+
+  Datasheets:
+    https://www.ti.com/product/TMP108
+
 properties:
   compatible:
     enum:
@@ -24,6 +32,9 @@ properties:
   "#thermal-sensor-cells":
     const: 0
 
+  vcc-supply:
+    description: phandle to the regulator that provides the V+ supply
+
 required:
   - compatible
   - reg
@@ -45,6 +56,7 @@ examples:
             interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
             pinctrl-names = "default";
             pinctrl-0 = <&tmp_alrt>;
+            vcc-supply = <&supply>;
             #thermal-sensor-cells = <0>;
         };
     };
-- 
2.34.1


