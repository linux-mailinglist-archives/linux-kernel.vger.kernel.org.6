Return-Path: <linux-kernel+bounces-311506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC29689F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE007B231AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F920FABE;
	Mon,  2 Sep 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOZN8l2K"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D820FA9C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287404; cv=none; b=A133rtKPW2fYBWldUkzvWR/QrgqFVysD4ipYb3dUwO/jRmZTpYcoVUHdh6+jd8Xo8aAtLwCP0jQWLsOG7yBSs8a4sBKeJXDJN8+iMw7WChHK4zSUPiMPWbivt3vPozwEjJdFALFPRm0jGkjTnI3/PC8uthlea6pwt4kfBqnqlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287404; c=relaxed/simple;
	bh=Zxcd9LkyYaOSN8fvwJ1xNiYaqqcaXioGlDiVsAE7nXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWaAd78RPe9n62n2BDDXI7UWuHikjgK1gqKURDzSQUeENT7dkqRExZkrpiEEI6ryet8XMdcOezBt/W/5Y8UMVd4aqvMwTlFFfxc/cxBTs8IZ++KjBvzk5PnZp6ZNXze82eczG5JItv+5YktC4jzEVTW6Ir1wASilW8yWn6AQ3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOZN8l2K; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so468695566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287401; x=1725892201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9WpMPcffP4bVIHfwlm0A0QBWfa2okRCbCAWMVHxhp8=;
        b=dOZN8l2KCr2Y+vGtCzd3Q+SiA8sFntkZAdmxRZXTHWxXh/y6X7TiT0Hd5b5ltE3Dcv
         6U2ICQcIgy3xIVNnStc6UIznGjGypt+mV74UALn8qpWr2GipE+iv2gqG2fLx5NfClKFK
         uW7+Zo4f4WgeaTEQ1qd1HISQbraFMiD1OqXcnIZtV14YBvvApy7ySVEIXYNe9I7Tu7Ec
         gv8O9DLlWtwyypsxDcDXOFd91gLiRSAm0vIqg6qlxC3HFP/cLmgPYzP0lTv+8mMspVvK
         bd89+7vZye0mCw60j6b1GqL6ZsccHlMLoMAItoE35ELrUvcS3tO3jIL3TX242sBlkz/F
         XUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287401; x=1725892201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9WpMPcffP4bVIHfwlm0A0QBWfa2okRCbCAWMVHxhp8=;
        b=DK9glJhWKFX5FzaktBRn7p960pyfWfd/OJNiIrKkLMewOKKwHw+xHuhZIpu2xganep
         cQMZZVpYLqoHK/DMTDm/Svyo52GHHTkgRggt2yWRLOJc+WkmUIKxYGo48R9aFGGfTicQ
         7zg7xUPHE0HfgqHp46sHbt8YtMhZd6Ljk4cut3u+5AyTI/J5SxIua59azxW7O6p5kq9/
         TRl/wRSwRNtnhvIzZK0MmUTC7O22/MNJxPb9RzazgNBJqKLUFqS8tUTturZ+F3LuJfgn
         fn6fcvDieWRSJCRh1/EzrnhsYnni3Lir7w8IcmNGNHvhQcQI2oOhau3oRjoQR46V+xJy
         Z9zQ==
X-Gm-Message-State: AOJu0Yxb6obnDXKign6N9QmZzRDHf3QPnArLgyy6Z3x8IH7F/ebTWCHR
	kwbS28YHY+v/6rLD0Sd5EiLpsuDRfRs7sIp3961c5NZAxBHjY1bZV4nsSCTS74E=
X-Google-Smtp-Source: AGHT+IHh4os20I7TL5kdbM9kzi/iA3oh1B8pPaRa8MBFGxXYwl/jTfa24TfHXNsPjAh7hUGEhbliFw==
X-Received: by 2002:a17:907:d8c:b0:a7a:aa35:409e with SMTP id a640c23a62f3a-a897f875407mr1216860666b.25.1725287400995;
        Mon, 02 Sep 2024 07:30:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:00 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/9] dt-bindings: nvmem: imx-ocotp: support i.MX95
Date: Mon,  2 Sep 2024 15:29:44 +0100
Message-Id: <20240902142952.71639-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 ocotp compatible string

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index e21c06e9a741..b2cb76cf9053 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -14,7 +14,7 @@ maintainers:
 description: |
   This binding represents the on-chip eFuse OTP controller found on
   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93 SoCs.
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93/5 SoCs.
 
 allOf:
   - $ref: nvmem.yaml#
@@ -36,6 +36,7 @@ properties:
               - fsl,imx8mq-ocotp
               - fsl,imx8mm-ocotp
               - fsl,imx93-ocotp
+              - fsl,imx95-ocotp
           - const: syscon
       - items:
           - enum:
-- 
2.25.1


