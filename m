Return-Path: <linux-kernel+bounces-188797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AEE8CE71D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82DAB229FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2001112D77C;
	Fri, 24 May 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V8XIZtmX"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142F12D748
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561125; cv=none; b=T6qMRv56JqIxudK2slCQY7LF+25DfWcx/BHj2ZR1Oi1fmw+irO0z2aVY66shQqwVafwj/5UYQGc90NA+TXpls4zbFxqQjG91T+yzBGFPkP3rykMy+JynFtcQprM8zqjZo1VaMasPv4m7D2Zm3CQ2LQEr2x6SC8F+SGZZTKpiC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561125; c=relaxed/simple;
	bh=mGHJTIEqaOM3rGni2f2k2W0qT+PA8lgJbBpgTIxC7k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5L1DQPMftPMBN+y5thCV+DVG8VRfrpCPXD7+oCAvY+y+JcIVtK2yObkPeXIjEZ7TPeuyYkPNLkIaRhyRXXPiKnFICxGSNqu/y378luQvZxMhmQ/pVN2ddn9xNpN36sCpMPZ1QsqQfv43h6b+tKbzEvv5ldj8KSyU26UfC4KLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V8XIZtmX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295f201979so1081552e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561121; x=1717165921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/1Ee6H1I4b4eaa21f1IZfthFOHfX8TRhLVEevdwWj0=;
        b=V8XIZtmXCIif/wk8caetPmdFoyx29DqFpr+cwKfx5KMhPHl8ymU/CCkuBbD4OLYqZh
         Tdxmh9LECY1R66vLE2C67avS54JiwgRQo+ynqnTcWai9sPxLjHtthbYfsLajATvqdqB0
         UqOE15EtlNmxhD7Ktq45e6dAF67F4qBDNDtJBsZ/XDA0BiY08P9kSrhm6OJZj1y0lMAw
         17z9Qisyylrbt60om8G8ZjH8tmxQMB+NB/NmNG4Yvxw+pt7cP2U/FCMjsx3SJwyOZS9G
         fzn22bQAbLRiJTHHWPeAlwp1uaUzpjXwv4sseocijwbjFhGYxLOVp+jKCU66pnlNnFLn
         WtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561121; x=1717165921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/1Ee6H1I4b4eaa21f1IZfthFOHfX8TRhLVEevdwWj0=;
        b=D5dIOafzgslweGy2KApQHovPR/UdFbpGH8SjSngLhBOAfkfuXSTjSe6jcq5y4VwwKJ
         yOYKs7V8eN2Bo2DCr/Ne9UpzKb8KC1+A+TZp6+pcVZGAMS6A8wH5It6FYbpFxGfqS7DM
         qNpQj9yJ4957E/5ihJ8i/lRjHKb2zhEVkzPpZClEmOTCS86lmmlrClwAPUvBOUeMge1d
         JWZD2EHK9AGoaAK5qhK/NcxHv3Vh7wxJBUG0R2gj8oEvk6F1rEpCE2I9ooETjPwxmHY+
         xJhofux+qjjKnxqIglv6ae63abHTukOtHje4XydL6N92XKhnl+TKb8Vo7s8q5xih8iAV
         2tsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwRdfTgQg6L7C3WLkCmaHvKvpxaoItZ8XNmGo0ulW/yYEz12p8YpguGUhR2TCFQr2pzAJAk0GNquy8gLf8UkGd/hqPrLUq5TPXS8CX
X-Gm-Message-State: AOJu0YwYF+TIBrYNcrEh1JX79pQyG1OO6z0WLpXPnEPHCn0EJczECYBK
	Bpd3e1Wy5/wIsFmS1metQCTiaho3rCbitFN+Xj+JD3jIipm1nJ2aTRdWzfywDg4=
X-Google-Smtp-Source: AGHT+IGae8vz7FD8oFzDfF3fXF9u1uERG6J8NuAfN29z6HqiuN+X4zLPzr4PMF9xpcgrJ0L2NyAUgw==
X-Received: by 2002:ac2:4c24:0:b0:521:f000:5d1a with SMTP id 2adb3069b0e04-52966ca837fmr1547324e87.59.1716561120954;
        Fri, 24 May 2024 07:32:00 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:31:59 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 4/6] dt-bindings: thermal: Add a property to select the aggregation type
Date: Fri, 24 May 2024 16:31:48 +0200
Message-ID: <20240524143150.610949-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524143150.610949-1-abailon@baylibre.com>
References: <20240524143150.610949-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new property named "aggregation" that could be used to
select the aggregation type when there are multiple sensors assigned
to a thermal zone.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index fa7a72e2ba44..e6e4b46773e3 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -111,6 +111,14 @@ patternProperties:
           coefficients are ordered and are matched with sensors by means of the
           sensor ID. Additional coefficients are interpreted as constant offset.
 
+      aggregation:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - avg
+          - max
+        description:
+          Aggregation type to use compute a temperature from multiple sensors.
+
       sustainable-power:
         $ref: /schemas/types.yaml#/definitions/uint32
         description:
-- 
2.44.1


