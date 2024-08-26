Return-Path: <linux-kernel+bounces-301484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38095F18E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E77D1F22859
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E8189B9B;
	Mon, 26 Aug 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="QB9lmH1C"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBA17A5A6;
	Mon, 26 Aug 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675927; cv=none; b=Qjpff2kNVJyqjz9lxpkhPROxQjuaguT4kEOyA6ttg8uYMOlxe8QRFM9QG1C6HaS05KLU8ZauWwSc0vVgDbrWExa2Kl3q8jFL5Q/CgpYMQRFdvhFgThq+pC3q0GhNejprSYDFlqphGIk5esoIlUGWPpLy7JGkTQ5sW/ti7IMbHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675927; c=relaxed/simple;
	bh=Y+06cecRQkpIjwtbfp8mUR8+EqZ58zlNYR+UcFF6W0I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V64y9qOB9IAwDGaOIjNsym44wrbEbLCY4fwjr8nqlQBAoNduMhmeDqapYoEYjFPcWrklq48UUeG0CkK9WHWCcDYywMug1VaeAu+a8BeIVX+exxDLjEGZse3V7S3F0hAZZ37BQM2Ut3tRhnTaVXmQKMQQoRgWKwHxz4q7LwmMHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=QB9lmH1C; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724675924; x=1724935124;
	bh=qoB8veCGA1hlCoOcjhzVWlb9g1hnzDQI3rPM7GtJDuc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QB9lmH1CXqXWtnxKKkh5mRwd2GFgGAkT2nDA5CNdJWdwcw4R90ttRwbdEAX4F+3gH
	 yzV3i78LsfGDs3wim0AnSzjqsCe6Wlp+ib73ic75P6wwgVbkYVi8YVH6YSyrNfRO7U
	 hQ9cYma0tQIDIN2u73hf2W9gnRRWQpogq2f2EbW1le4l801glOVldK5u7Yi/dhAeWE
	 LlecY1kSqTbNhudbqZZj7GqJKD/XRnxtZt+4ZEbp9oWtCC6fzC7pcTgCxlD1NKgmbi
	 6Ak+g97VIvxZ4ceWCaltaJl/Sn6A3fUShQdMwxXChQRgdnakBXe5AHvNk8hMIImbmi
	 eRppDw595Xe7g==
Date: Mon, 26 Aug 2024 12:38:39 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 8/9] dt-bindings: clock: xilinx: describe whether dynamic reconfig is enabled
Message-ID: <20240826123602.1872-9-hpausten@protonmail.com>
In-Reply-To: <20240826123602.1872-1-hpausten@protonmail.com>
References: <20240826123602.1872-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 4106beece6c173fad87a2a5fddc33f585c4d116d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xilinx clocking wizard IP core's dynamic reconfiguration support is
optionally enabled at build time. Add a devicetree boolean property to
describe whether the hardware supports this feature or not.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.y=
aml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 2b9903f05ef34..72dc6c586f7f5 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -47,6 +47,12 @@ properties:
     items:
       - const: monitor
=20
+  xlnx,dynamic-reconfig:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicate whether the core has been configured with support for dynam=
ic
+      runtime reconfguration of the clocking primitive MMCM/PLL.
+
   xlnx,speed-grade:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3]
@@ -90,6 +96,7 @@ examples:
         compatible =3D "xlnx,clocking-wizard-v6.0";
         reg =3D <0xb0000000 0x10000>;
         #clock-cells =3D <1>;
+        xlnx,dynamic-reconfig;
         xlnx,speed-grade =3D <1>;
         xlnx,nr-outputs =3D <6>;
         clock-names =3D "clk_in1", "s_axi_aclk";
--=20
2.46.0



