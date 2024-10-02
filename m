Return-Path: <linux-kernel+bounces-347924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F798E061
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2323B2DC02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D31940B0;
	Wed,  2 Oct 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgeSlCGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE551D1319;
	Wed,  2 Oct 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885529; cv=none; b=t9xOGDugisfgD0nW+2blwgBL6kzQ2dZxEivpSYIM6GYd+oKTYCezwcHKz8NXUsXamX/Km4rOAQIpyMRYmskaUxG4v9ZYarfIvnMcJ4PLpwLwvp2LTQPYgrpTcTUgfF5uBksNzYI9thJpfMyI5n1y9xqjLdyGbQHJRdX26bAUa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885529; c=relaxed/simple;
	bh=A0ybPXTauo3eopVMr548or5pJojT5HcHFGdg3+1LGss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU9lJ1IwaQul6Gmf/0EhYQSfRysRi4UIMTw/eouY1BkoCha0udHG9qJA9Kz28gprnN1+/ORoMJZdI0dZ8SR1qUHR0OvrVH6Er/mD1MNAR35Mb3d7UPQjjepYg/3AWZul4oJM1PsJkjUBscORMd8r2TacTCKHx6aHPMeaMngiKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgeSlCGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C027CC4CECD;
	Wed,  2 Oct 2024 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885529;
	bh=A0ybPXTauo3eopVMr548or5pJojT5HcHFGdg3+1LGss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgeSlCGztSM2uY6msbBtrEbcKNdXBO4Qi8QZ2WOB/c0rzr/lDnjQqylxrP0Ac1ftd
	 KFsaVKFqbqNeMen4CUQc8zXtF7S+jh+9K3zODUYj15WUlHyVbPa3dUaq851W85i7mG
	 XbYyTB9FPI7jnrkWyAd+CTZpLb0oweQhDkBGx9mVi0oDHeR91Vq3cKtxxSJ8lNVYBE
	 2eqA+ba9UkdS/dq0hO9fr5MkDyaiLF09OxQ7Khvs6ptJpC+mhyUiXTjkkxlaNIY+yt
	 o9ub8hu+QPnYXKllYSBy+G/TIRRJm2HCpAHJMX6DnzzEW8Hh4n6jNSSdRskjuYOz5U
	 U34RzHRe4YrNw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v1 3/5] dt-bindings: riscv: d requires f
Date: Wed,  2 Oct 2024 17:10:56 +0100
Message-ID: <20241002-deliverer-recite-2c5a05f50721@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-defeat-pavestone-73d712895f0b@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=9IUjV4XrSlnqf+oDMep1HvXRpMwxZk7xWRthmNV0yIU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/Cya8DbpyT2Vp46G40F+7LI+IKCaqCn3+2rrLkun79 3NVux9ZdJSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiD/8w/DO1tlndwuS5gKf5 4P2Fqv657TOuPryf+6bvVubye8zSqgoM/5Nk/QruvvfMEf9qnsrseOLjD/s0ebfKjTdmB2RznXk pywgA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Per the specifications, the d extension for double-precision floating
point operations depends on the f extension for single-precious floating
point. Add that requirement to the bindings. This differs from the
Linux implementation, where single-precious only is not supported.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b49289..779f5cfab806e 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -564,6 +564,12 @@ properties:
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
     allOf:
+      - if:
+          contains:
+            const: d
+        then:
+          contains:
+            const: f
       # Zcb depends on Zca
       - if:
           contains:
-- 
2.45.2


