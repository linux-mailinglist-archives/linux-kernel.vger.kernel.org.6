Return-Path: <linux-kernel+bounces-334919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3287A97DE4B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45C21F219B5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FC7DA83;
	Sat, 21 Sep 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzXKQBVk"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B756455;
	Sat, 21 Sep 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943380; cv=none; b=YtnnjE4a1M8TOt1VPhJuG73uwe0yaMIRM1nD2uLDT/Jb8iUPPtz3adYF+GhLaDlMTpc13xooibE5R93q1gsuEf1IxoHGBmL3skUuW526vps7J4WVHomlSLVuFltWkTNMwtbX8vWEKGJKJayZiKRYm7sTkVcrRfLr7Kdf5wiVkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943380; c=relaxed/simple;
	bh=hZDb48RQmiYLOBG0pnVxUMdhf6Au7DNWR8O4OZSUgu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht811mAlZA+WKU5W0ZWT/rHvqbT9p+vAaQ9CRM/mZcy4X9OOCc2wNOdWZF1thlmYsCFKLvnoG1r+u7DNqgHdyyXhoKUJYFBsz/VqEspIAuWZ5ui0Gpt59aKoocvEyui5k2V4qPZkxAlpIenH7xSK+QDE1XcRlI51JMQ6sRsNT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzXKQBVk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e65590easo306601b3a.3;
        Sat, 21 Sep 2024 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726943378; x=1727548178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtyt+qfHCrRWKEPMpavsPcf+YAF201xuLyqA3h9cbOs=;
        b=jzXKQBVkoDjLHEY/wc+zy6LW0f4IUKrz3uOTvBAjp6JDLCOuaGNBtRVof6whPJRmtq
         0G5Ua5P73ngmsGtrIeLsgt6L/onZRlaQGsJRleIoqzrCTDhPFe1mTbOAgDkz1NLRh0s1
         DlkvP5qFn3VeD7zCwixwmAyPOml6UekrO7oKcW/+eC6F3+9QS13XnFpYYaZaJBixa22a
         2lfKBDygY83+uDwo99F1letjCDcloiOYvXqle529372vr3LRY+Za9ND5irESp+xx5XLX
         d14wQy46yizwFxulks5S3m3TVE9DpamzuNHwRGG5cEAZ4xAZ2t2qt/OvlyYa/brf8AKO
         Y4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726943378; x=1727548178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtyt+qfHCrRWKEPMpavsPcf+YAF201xuLyqA3h9cbOs=;
        b=nmnTJ6D5EQ1Yi54L0M+IebL/CJfnImzxag2fBjrAzU4conx75y2UaT3vR+3U6vLxFS
         qZEdNiePPyxIh3p+qljGmXLV+1YC1Q6jHa00WlogKdI62tFCb+qEMcOCXy8T5yLo3bNj
         yQMoXZOAsBrUUpa4HqK8UXgkb5G8qJBY56/uGGXi0tXiL8Mv6zWg1JMOhvjlBhF9HVKB
         PZ6gFNOkXAmoJjgLA0T6AVqYimwQoRNaPDnswo3dcbC0giCtL31NsxotkiPPDG5pvvQC
         wG6woeHu2UhN/pgLk38kHUfqrF9/Aj6HEdW7LzFeQiu5gVb0h3CO+lC5fYXPuA6eNsUf
         Mv+w==
X-Forwarded-Encrypted: i=1; AJvYcCWs8B6Q8pCj0cmIlBf4zDR4ihzhTqLapD7oimcS02F/A9pqravm3sAlVeG674KssBwUymZxuZLWD22OHVFo@vger.kernel.org, AJvYcCXG/IzLhLvrBw+Z4a9Rs1p4CEBrV3op/9x6tqlKxg/BfTssfQ43yjx0BATsxlxWRL22neFCaheXQ3ck@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZN9PsJBTwwdTHF+rlqLLK7iA7wH3LPHSWM2GATXD6KTzo1jd
	D4Y7oH63lJU55LQ4Nu4REyOKwbeKqEcUPyNvYUxuk/Hb6yip75/vnmWOo4s1
X-Google-Smtp-Source: AGHT+IG5MPAQDzBMaTft5ExxYqnkMwgIWXsY418SlKucfqiS/K9wHLeFqGJID6CEG2tWHXKIYkEMNg==
X-Received: by 2002:a17:902:e5c8:b0:206:a027:8aa3 with SMTP id d9443c01a7336-208d80efae0mr44301375ad.0.1726943378503;
        Sat, 21 Sep 2024 11:29:38 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998b96csm11080441a12.59.2024.09.21.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:29:38 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
Date: Sun, 22 Sep 2024 02:28:53 +0800
Message-ID: <20240921182917.64756-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240921182917.64756-1-liujianfeng1994@gmail.com>
References: <20240921182917.64756-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LM7 is an System on Module made by ArmSoM based on Rockchip RK3588.
This SoM is used by W3 Board.

LM7 features:
- Rockchip RK3588
- LPDDR4x 4/8/16/32 GB
- eMMC 16/32/64/128 GB

Add devicetree binding for ArmSoM LM7 SoM.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 687823e58c2..1ed72df971c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -54,6 +54,13 @@ properties:
           - const: armsom,sige7
           - const: rockchip,rk3588
 
+      - description: ArmSoM LM7 SoM
+        items:
+          - enum:
+              - armsom,w3
+          - const: armsom,lm7
+          - const: rockchip,rk3588
+
       - description: Asus Tinker board
         items:
           - const: asus,rk3288-tinker
-- 
2.43.0


