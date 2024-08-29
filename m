Return-Path: <linux-kernel+bounces-307726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC396522C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEAB23D79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20511BA870;
	Thu, 29 Aug 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJkuUDrf"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B318A933;
	Thu, 29 Aug 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967593; cv=none; b=DCEBi7ysoAsQ+o9ZOw+Xjo33rR7RUMg9cDOKTXyVgBEQ1hzUsPHfVpWMgyxLch896RMhgxbNE9Kjo9DbYDVOAFn2KF7DmLJeg/lJ2EtlV2sfNKozadnmo7sFbE1HKNp23ZR1aGo7UVGGgGr5GeTA45IQL1TuVnoaYjLnDeZGx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967593; c=relaxed/simple;
	bh=RLBDa7+c+1N9VT8EMcbRtY55xJBqKFKsMLU2PqJWLvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxURQ6Taz1nY/a8IFz2eA6I8IaudkrvDOMPj8Rfayhx+tP153ugvfox7LEUAklSnvU77uMySnkNjo85YStBQ/6haoOYoerIJ24DtvoNEXs2bR2qx5iGwpvOwyOFkje2OCOLwiK5/C/PZOGhsBAKEJJBu6wfTDXSNKkNfYbOHMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJkuUDrf; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a22127e97so43050739f.0;
        Thu, 29 Aug 2024 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967590; x=1725572390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0DPdrQ9B/42k3CR3V7dRuDpUGlZwPQdRvEarnDiqnk=;
        b=TJkuUDrfnfVMS4LjNcqMFfvVtzv8SD9v0gq786gE7IcQF7ML0hOyRlL23fnvvsm7P/
         M6LlLoN6r3BDRblipQEK02TTjki2mCqOUvFrxaEWIpxTVUds5DxQZchIo3rxaLhsXHEo
         +32eui+tCGN1/Tu9UM7wvOuKJwK3xGvNpd+Hn8/VvMpCrnCriP/+4/BSE5OrWChCduln
         HYWRdeitTv9CbqEuSbL1BZAsgEz/Ga3tn3HYX7N8ebmF2fZJGEYkVs+7SkOF6vTUuio2
         o6AHs7hSKx4e/vJuya/1sReJsfT4LNL8yXv2UEkJZEuuQCZUQYUVoFOa31fzo2AJVAtm
         9qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967590; x=1725572390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0DPdrQ9B/42k3CR3V7dRuDpUGlZwPQdRvEarnDiqnk=;
        b=WFsQvWOBqjTlsmDNPzlCK3Nr6xQPk/6IOTPN3J9VnOkjNRB3zeKGoSU9hb5TBkRWhs
         Bp5k/HFmqYYHpvn4OqQ4heNd0Q4Xt/giawJzdKV3QidAPtA9A+yOYsHKC/6vfD+7omhN
         1uMm9KJZ9L7XMs+nkpdLwJPHa7fo40OJiTYHGspjj8RLWfZLJmO/vVlNf+krMLxL0mfm
         hJS4mAGDFBejHPcKCQ10vrBOKsmSWDozBaM9Jg+t+f2tS2PWNQoe8Q7euskgvx5SAVFX
         O+b9771c+cC6AawxhhVnC/K3AWcGmuGahQtUfDWQLM952wxaeFaj34Gtq50MdJZr9tAd
         F+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Sc86CHHuStr1LTzH7izDroFlkZ8tgJGboeCKSGa+dCbgjFLcVSBQ7pFlhguTMid5wfSEJYBYycUE@vger.kernel.org, AJvYcCUL6rL1DkbZh6dOWg/SsN20RSZLtKjCFd3GD0ZjkV+eS+ev0ks5MpMNAvucoEqeHkO2Wu7MWmL0z13YTfBe@vger.kernel.org
X-Gm-Message-State: AOJu0YxSasOgWCOfd35Kga59Uwx5TsDxUjBrV5R38DJeM8bzNUosdJy9
	BA9PCkoJwwLlG4vzq2PItX7B20C/P3kROhNjULQ1TBWHsCScK53sb6TJjw==
X-Google-Smtp-Source: AGHT+IF+yqiWCQuGsstUlVTdQ0DB/5raKxTN6/X/u2NmV71pVUioeSF2FCnuO5yUHNX6O9/0SwRiaA==
X-Received: by 2002:a92:cda9:0:b0:39a:ea4c:2982 with SMTP id e9e14a558f8ab-39f377fdb6fmr58165265ab.10.1724967590408;
        Thu, 29 Aug 2024 14:39:50 -0700 (PDT)
Received: from hestia.. (216-71-44-235-dynamic.midco.net. [216.71.44.235])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afaf38bsm4957755ab.19.2024.08.29.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:39:49 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Jared McArthur <j-mcarthur@ti.com>,
	Andrei Aldea <a-aldea@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Date: Thu, 29 Aug 2024 16:39:28 -0500
Message-Id: <20240829213929.48540-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This board is based on ti,j722s family using the am67a variation.

https://beagley-ai.org/
https://openbeagle.org/beagley-ai/beagley-ai

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Andrew Davis <afd@ti.com>
CC: Jared McArthur <j-mcarthur@ti.com>
CC: Andrei Aldea <a-aldea@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v3:
 - Apply acked-bys from Krzysztof Kozlowski
Changes since v2:
 - cc more maintainers and devicetree@vger.kernel.org
Changes since v1:
 - switched to the TI model am67a over the family name j722s
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 4d9c5fbb4c26..5df99e361c21 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -140,6 +140,7 @@ properties:
       - description: K3 J722S SoC and Boards
         items:
           - enum:
+              - beagle,am67a-beagley-ai
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.39.2


