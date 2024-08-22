Return-Path: <linux-kernel+bounces-297352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73C95B696
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D01F1C229E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27DB1CBE88;
	Thu, 22 Aug 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygVBahdR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EE1CB121
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333235; cv=none; b=inWtCgPpBR9gxyxy8Jm6PMHiVOzyJdjsRNll0LzT76uwlahAUh0+MXHTHiqZmiC5FrPaDBaj6SUKPtxP+rJlzPwvfXFFoNotsG3GtNAsS+q7eUtNWXr32o6ro5vj4Cb5kqdzT1TsFJxhZGANcMCOdkh41psAe+i0OGxMrmp58Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333235; c=relaxed/simple;
	bh=mmPcytjB8m6exAvgg/oZ+VjBw5w/3yH5XfcO1PfEurs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlJ5GmaXpky4w9iZ/E7GfwdbT8OfeySLIc+sjJx2/ldBUd+YO8y4V2WOqCucryoaAc+cQ0sr7vVDvMiQckDkn5FAAqNgkjIYfiwyQYQjRV371vmzuU3Efmav3wddF2nVipJzwxHp/sWZSb+56+9iAVjyilDj5RSEGJpV8KlJ/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ygVBahdR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371a939dab9so136107f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333232; x=1724938032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=heGIarr05MZ0K7mmp6CHQvn8aVfPPIQkNf3ZJw1FViw=;
        b=ygVBahdRZrMMH078Cx/+YPBzs7VsrQ5/y9GrsF76ck7YDWbs4boVqT7Xl55J+qOZG6
         Wza9kBLB5KLt1Y+p21AQP+o+aoW2OwfHJ4/pBsTd7Y2usqfIN6tozFDzaBpdjg4WZSE8
         GwoWIG0oyezZqg19Uk9AQ2lpUdWHXqHzekohjabE5ZTBJyXoP/xH6IIa8Kvm42d4J1wE
         otk1r0ZH9WEf0N6IWxyHjD58wtV4kJx0/SzjCGjnlywd2dnvQ+325A7GCLMwKOZNaFCY
         ku9O5LeKqJ5J1J2RXZribDEBwCAP+ww/xUAiwjHpKa300mZ1dass6NcPLe5OCGQbXqo6
         FudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333232; x=1724938032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heGIarr05MZ0K7mmp6CHQvn8aVfPPIQkNf3ZJw1FViw=;
        b=Q7telTL6FHqbfFaeAEuw5ZEelSK3phK2p3LPVzJj7KZkmZGrLBO0L16yLa5QF8nVbP
         Y1dsYVfaVsKr9Gq9I+VF5JCuXtYj0WSsKvISJk6/7jRHO5TEpr549krRYqH1fmjcR0dB
         OfNVWj6soyqdzH5UG3SK/kJHOe3Cfm4IB7cgkr9S4kVaBP6wQdQEZQHFgad/uSoWR9Xd
         73+yckrGGkeA39Xxm+B7Ya7sKbGTrFH8NUVqvCyHYgi8huHjvNynKCSB/Mo3aocqf1cq
         ACx0zE/axIDrrB+uF1nYp3AQ5o9I42T6rQckU1BXVnKCm5Ow4+Ss3i037PwZic1iIzsH
         TUdA==
X-Forwarded-Encrypted: i=1; AJvYcCVEtf8d9vV9SET5ls3+CRQtg1waLNbwkDNLKZChu3AO7UeKw6Svy69FBWlMN7RPoX8kOMa6lGkpo4gsl6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+64aFLeIHRFVSaqKHeniw5szXWzx+GUz1zitYLA1zLNmRJbEj
	pMfkllK8pXgnSyfbBi9Vu6Eah57DIfThVMBkcq9WkauHjCPBu2wNzYpEWPffYh0=
X-Google-Smtp-Source: AGHT+IHnNSVQHM2d9IRfmql1uFIKdsWiicdATDg1EWg6EFTqcFXlV2endQY0D9GvUsxJ5J4dgUJ6zQ==
X-Received: by 2002:a5d:6d89:0:b0:364:8215:7142 with SMTP id ffacd0b85a97d-372fd584d52mr2486942f8f.1.1724333231717;
        Thu, 22 Aug 2024 06:27:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb6bsm1703531f8f.21.2024.08.22.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:27:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: i2c: aspeed: drop redundant multi-master
Date: Thu, 22 Aug 2024 15:27:08 +0200
Message-ID: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'multi-master' property is defined by core i2c-controller schema in
dtschema package, so binding which references it and has
unevaluatedProperties:false, does not need to mention it.  It is
completely redundant here.

Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Reference:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/i2c/i2c-controller.yaml#L114
---
 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
index 6df27b47b922..5b9bd2feda3b 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -44,11 +44,6 @@ properties:
     description: frequency of the bus clock in Hz defaults to 100 kHz when not
       specified
 
-  multi-master:
-    type: boolean
-    description:
-      states that there is another master active on this bus
-
 required:
   - reg
   - compatible
-- 
2.43.0


