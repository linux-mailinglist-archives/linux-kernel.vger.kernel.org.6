Return-Path: <linux-kernel+bounces-528426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7B7A41793
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4BC173B53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B601F8908;
	Mon, 24 Feb 2025 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3ks3Uaq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC231DDC28;
	Mon, 24 Feb 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386389; cv=none; b=eIPx5G5ZLA6jNG1XnVfkUw7MUWREQAn0BUs8QDM5K6/qgpaUuQTNKg8sZdjOt7JoX2r1kaPlFUNq26WxDNYgEj6HS4U6ZXnPy83ykOOAhset7io+kLq0SuPFiC6Ku/cmMirDFgPu070IUUZY/6e+Vm5pjXVmf6p+dKE7o6Tt+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386389; c=relaxed/simple;
	bh=OPib70z7RStdLqTILP/CTDIzshCEGAvZQiaDyNFFxIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shEZsM78ilKr9uAqcID3wzDtDpjuS++paOgX+9AyD/N//zpwiKXBZ+cfXhuKJ/nGbDKTRCTpkmDKU9k3pvoyUU06IdNTKsvKqA9FfAfad9+mWBeN2ii7Pe6DjOStNMllpEGDjY7t2BzPm0t8LpXUuhoXWA55ltT8Lu3MvxmbSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3ks3Uaq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21c2f1b610dso117657025ad.0;
        Mon, 24 Feb 2025 00:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740386387; x=1740991187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95SHW6HzB6iNhL/wzrH3WG7qpOIgT6dZkumEvj+k6IY=;
        b=K3ks3Uaq+YSU930lYDlice6Rw1iPLBsMk8pd7+HbiA3SPPcNQrJikIvJ7uYR14G0E7
         0ZByAWdVsIf1UMMvurkqFZwnCqithN1+s6PQH/X+L7bD5VPTVYqMsstP5VXv4kw182rR
         RgFmQV67eU616iOJSDxdynzWPEKvR/321UYy93MhvinE0qwM+kQPglKBVX0JBvtuvK8n
         N1spDT1IjuYor83a1c0jve+U1pPS9LJNAk5ZLBRyOt4qDh7Uc1TwK34lUHg4slCVReEn
         h5sTLmC6rMTUJrHr7KEI/bzLV7cbMfIqL4ZrVPVZ9RUROnyhnLN0DUXC7j6LWbOPSctA
         zzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386387; x=1740991187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95SHW6HzB6iNhL/wzrH3WG7qpOIgT6dZkumEvj+k6IY=;
        b=XPgtypLFQyNnX5HIsfvj8FibFArxRhCVClLK7wB+C0W8azY4y/cMnjChYihQaE8Jqr
         WBA1XfnqNsVqBnaRPTGd+4i9xJ64M3dk791BEM0qa0ghxlWZwz/tK8wP3enbZcYvoaVe
         GHXeQuPJB4tWHaRoYBEOu/OpL2oJkZLs7nLSFfSz8/6uzvWfmM+qZCUJUESeD0n81rh0
         5VzlFrFkrxcApyiF3/Hh9q5t5ndBZDx7Xzp23KYzKw7eYS36enoGkpxqDeaKXVbfm8jF
         3ZTuewIovmMFjX6YiGHyP5KALaU7Lv1HkB/MN6erSSKLtLcod0WUpKu99YUNXJVy+tHw
         cDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaBIpHsHLp5UHWhJ5lF7QuIVLNz8P8cWKYNAe1O+fLWc9phaYPROzw22GQVloH/funtbiPmth2SI9v@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZ+z2t1pdHsMWiKAIqtgjp/nKywqddUUCMnmq4nJknH1QeRgj
	6UVk2kjpCEzn7XoE/2qNcEZjQpYhqF4+Ue6l8YsduUZz8iwnKXyu
X-Gm-Gg: ASbGncvUZrAwKaow6mHgzT/Ht82EfF2SMIiOMXZdoMFkYsqSK/rJhfn554k8tgcDDQQ
	PuFLgB5jThVBIiANZg9Z0aG0+/2fgXwQykju+eUJsW+G7kNuUszXmkB6NyYhkVWewfMlVhW5eUr
	ghkmXMzLksKT4ljf2JgCPSNWy07PBfTe01hJdCzUNxpHJA0vgvA0FEQiRAlhI71IV56SIRYAZJO
	t/EV8BK1yN9buhCVpKfvkPR9ZXvyN60tqjTfE3gtGgMf9ArGK7lEdsIxq9kxXGbZv74Sz7+LRes
	WNNbwG8TQa+mRTKMTWyqw8bIeljLYRbbKRNv
X-Google-Smtp-Source: AGHT+IFre9XOybV0YxAiqbX3XhSPOqNf9uDTbDbMVVNdbMkg+GELuP1pFb1lBJN/C9iaOtzknuA7gA==
X-Received: by 2002:a05:6a00:2ea9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-73426cab14fmr26237456b3a.8.1740386386696;
        Mon, 24 Feb 2025 00:39:46 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327590ff12sm14634793b3a.115.2025.02.24.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:39:46 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Mon, 24 Feb 2025 16:39:04 +0800
Message-Id: <20250224083908.1880383-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224083908.1880383-1-yschu@nuvoton.com>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Need to add a new compatible string to distinguish between different
hardware versions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index c56ff77677f1..4fbdcdac0aee 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    enum:
+      - nuvoton,npcm845-i3c
+      - silvaco,i3c-master-v1
 
   reg:
     maxItems: 1
-- 
2.34.1


