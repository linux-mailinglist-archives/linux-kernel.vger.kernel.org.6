Return-Path: <linux-kernel+bounces-182430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC08C8B41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE194B221DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644913E033;
	Fri, 17 May 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiRmMzy4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438113DDBA;
	Fri, 17 May 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967532; cv=none; b=mIPyPvl8QY+kXT5wAoyKIgpbO1bboU7g6+Ml2QaN9Mq/+jJ4ldG6wPR8jUFlspNqhxjqwOCSGsalwhVcHDoPeUZWuGouWmJzQ3th/abjLfyxd2LzeYhf64Syiz6FkGd40OGTPKp9aF7BA5xby7luSie0ZD9X3q62v/7y2zx78uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967532; c=relaxed/simple;
	bh=+6xmUuFoJdiuKxVTMJX0m8QQPSKTC6AKBTcd1AEIKxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0LGfs0Scw9mzm7QLB7uDsEG07C5dQteT3E7GHushwMtDGBdKvgwYxCki+UJJghUjW8N3gElV7KdNizm+BjzMsldO5TJmokkPVWTDSjlU1oB5bQndlR+Nitg5kOQcLTKsXjpbNn/EEPgUp0HNFqa4EpSCuJyKhrQJlJUtCtoZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiRmMzy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EDCC2BD10;
	Fri, 17 May 2024 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967532;
	bh=+6xmUuFoJdiuKxVTMJX0m8QQPSKTC6AKBTcd1AEIKxA=;
	h=From:To:Cc:Subject:Date:From;
	b=UiRmMzy43xH69lnb5dIN4HYkJfyvPJ8ChK4+QsfsgYKc6qtgMOGPsd++Axbj263/b
	 HIz4lrw0ptluHtlb0sEoRwspp/Sfglrj+sMRHosf7D6Q3bwRJDx2mCTFsUkK4LgODp
	 p8F5c9q6vsiCW2xALRIVNaV+8ToDOALQN+V2hEYiCOqTZtzbtu8hsYBSUreLVz2LDV
	 yrt7uL6328ioL3VYcfH97N1Vl4JFbTgRjTBigXWB1fyjYa3HGx0v5v2PbHSY3+wWQw
	 kBjUUbPKWsiLG6BZua4N6bcL1hKWVyZMPJUu05yfG/9yViqM31z0D1J51TESp8G4ot
	 flMzhAVso27cg==
From: Conor Dooley <conor@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: pwm: describe the cells in #pwm-cells in pwm.yaml
Date: Fri, 17 May 2024 18:38:46 +0100
Message-ID: <20240517-patient-stingily-30611f73e792@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ajobRxG+RrftJHg3Lr8GYdDju6XYt5f0f5PWJsYh350=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnu09RmfpQMS5tcfHMy1+58jugza/bJCYlaNBhFXfJaM Ce69LdeRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbSpcnwv6zAuapz0ak1OTz+ qx7ou23ZOnPf8rnBGy8du2miJf5u3i1Ghithx8x/ntVfelfNceocH1GFqAKfq4pXrkabfL3s/cT BjxUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When commit 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings
to json-schema") converted the pwm provider section of the text binding
to dt-schema it also updated all references to pwm.txt in pwm provider
bindings to pwm.yaml.

Most pwm provider bindings had a reference to pwm.txt as it contains a
description of what the cells in #pwm-cells are, albeit in the consumer
section of the document. Only information in the provider section of the
document was moved to the yaml binding, and it contains no information
about the cell format, making all references to it for the cell format
unhelpful.

Fixes: 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings to json-schema")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

I yoinked the wording from pwm.txt. Having "Typically" feels a bit
clumsy, but a given provider is free to override that order AFAIU.

CC: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Uwe Kleine-König <ukleinek@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-pwm@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/pwm/pwm.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index abd9fa873354..f2206ec3c7c4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -16,8 +16,10 @@ properties:
     pattern: "^pwm(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   "#pwm-cells":
-    description:
-      Number of cells in a PWM specifier.
+    description: |
+      Number of cells in a PWM specifier. Typically the cells represent, in
+      order: the chip-relative PWM number, the PWM period in nanoseconds and
+      optionally a number of flags (defined in <dt-bindings/pwm/pwm.h>).
 
 required:
   - "#pwm-cells"
-- 
2.43.0


