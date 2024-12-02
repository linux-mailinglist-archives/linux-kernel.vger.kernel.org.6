Return-Path: <linux-kernel+bounces-426921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91579DFA11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685C2281BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDBF1F8ADE;
	Mon,  2 Dec 2024 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8Ki21Qy"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A801D6DDF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115487; cv=none; b=kxQRcGw4iIohCnuVjJvnysWRv19pvIDpSza680gXL2wZtCTriJWWLf/6Bdo5Uq3Orzt9lqDeDzwgE0SDCPuYsoeSiELpXZUCBRgH7s9grjXOjyz8sS5NSsPy+XbZV8Q4yJ4bszxSC5QvJ2XS+45ohsPe8vCKeRa6sRD/0+2stZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115487; c=relaxed/simple;
	bh=nwOnFLjkl/AZuun/GsZ/MT/Esupxc6jZTrkx7WlRFtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxKQtuqA0icAAkf8TqfS2v2VrLxNFiMuh+gkoKdD6prXAO+ykMUk5UEagkkJyBwjcZa/hQUzv+IYfaLqRsVzgrRU3RtpfbfHu/nelzITdA9DR/PpPJy8iQ3GVl20Pd5Hs44j7O5F++fcs4zYM+/JzY7Ub5ax/EbpabSgf4V6hEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z8Ki21Qy; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29e45280bcfso1369090fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733115484; x=1733720284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDhO31tk1fZx5nO1D34ac67vgcEF+XlfAfCpGqdW5mI=;
        b=Z8Ki21QyBsU+eNA1HqdAEMXlqb8i6Lqzc+ho+oawDBf6rqhZLn6l2zV8SvyIL+6Ov8
         k2yo2xowBhYTJqQK0YVyFVncFpUBCSzwAwiIcaREDtTifvsh7tp5Ku4aAHWKi7DQQgHZ
         zuF5ez44A8VthW+XNgkVDBN8Kqn43nhqIDYtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733115484; x=1733720284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDhO31tk1fZx5nO1D34ac67vgcEF+XlfAfCpGqdW5mI=;
        b=JlIWIrBVsSgRYRt8BWVJCTqG2n/UVFZLUUM4zCpN+pdCgO5wrrAggxdHb7bPZn6FXz
         OLACLJ8RSlNMVoOVUs0zOIPB32XuqfKgCAHK6TRxUGK9pE0aQjRE8sKNH6D+LpAz3l41
         V4HSCB4AS/IMvcUoxKSx4e+n1T6RK6JUsS38X9xMD5dhjPOqCKZ2UfVMMWokv0cWjBD0
         3HNDi4s1GHhE0TCFOXk66dlnKFzygHL5Aig2mJ/1xmGvWBqezUGJYlmVNs/N0Rd98ir2
         3GVnKhr4WCc/ImbmATil8iu4dwhusv3ATE2PY/XLd7QJx3fpUIGzJbksKTqiDrSG7sid
         NovQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUZhmQqlKAFjRyikZqaPafkNusqVlbGauRhTR2EGyep79NzowtgmGgmRtMDbV2sFz8i7XyyAywJ7oePXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxclUAYuHlkTTqJQ7iCgR6Y6yMIsyv5iTmIJ2nKZIO3wRIYua4H
	eQ5Fqxdq0IsgdeQyfl3+Q5PQbjBD2pMg/rvM8KPsnkEAVNTg/TMjBvwrLYRUKg==
X-Gm-Gg: ASbGncvCj82aXlAMjYdutYXrDvNLmXRwzD5ShnbcHvbyyglYu4p7NV7Z972avJiOmy5
	9p24nSylMjBp2xmB7ODvs4/oa3Ce0RjXN6fxnb6KXOM+TWDXvcLq5Ond90hkwGqwfXQqQsyL4CX
	9W6pVgfoeIco0TdoM7BM2xT2k1IPHe1g18QymxUjQx7fS+7BVjVgnSPXvfTlx4Gb5oDOTgSPfgz
	Ll3xIKMhNZBbVZKdSlA4X5kVR2KEvaK4N/UfETmx7+lWSvPXu2YZfGkBU9GL81Z2eXl
X-Google-Smtp-Source: AGHT+IFb+ZRLH+3t3GZ+Wqs0KteaVy0F6ImlvlAlGAnh/Pchain6QOhSaXFDzaByBXFgCM7QNb8V/Q==
X-Received: by 2002:a05:6808:2018:b0:3e6:3860:596b with SMTP id 5614622812f47-3ea6db6410dmr21148963b6e.8.1733115484363;
        Sun, 01 Dec 2024 20:58:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d5be4sm6970599a12.3.2024.12.01.20.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:58:03 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: fsl: cpm_qe: Limit matching to nodes with "fsl,qe"
Date: Mon,  2 Dec 2024 12:57:55 +0800
Message-ID: <20241202045757.39244-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise the binding matches against random nodes with "simple-bus"
giving out all kinds of invalid warnings:

    $ make CHECK_DTBS=y mediatek/mt8188-evb.dtb
      SYNC    include/config/auto.conf.cmd
      UPD     include/config/kernel.release
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC [C] arch/arm64/boot/dts/mediatek/mt8188-evb.dtb
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible:0: 'fsl,qe' was expected
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: compatible: ['simple-bus'] is too short
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:compatible:0: 'fsl,qe-ic' was expected
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:reg: [[0, 201326592, 0, 262144], [0, 201588736, 0, 2097152]] is too long
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000:#interrupt-cells:0:0: 1 was expected
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: interrupt-controller@c000000: '#redistributor-regions', 'ppi-partitions' do not match any of the regexes: 'pinctrl-[0-9]+'
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'reg' is a required property
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#
    arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: soc: 'bus-frequency' is a required property
	    from schema $id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qe.yaml#

Fixes: ecbfc6ff94a2 ("dt-bindings: soc: fsl: cpm_qe: convert to yaml format")
Cc: Frank Li <Frank.Li@nxp.com>
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
index 89cdf5e1d0a8..9e07a2c4d05b 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
@@ -21,6 +21,14 @@ description: |
   The description below applies to the qe of MPC8360 and
   more nodes and properties would be extended in the future.
 
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,qe
+  required:
+    - compatible
+
 properties:
   compatible:
     items:
-- 
2.47.0.338.g60cca15819-goog


