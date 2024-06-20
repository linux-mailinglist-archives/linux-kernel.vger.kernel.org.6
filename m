Return-Path: <linux-kernel+bounces-222699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6619105E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E441F2771E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0911AED47;
	Thu, 20 Jun 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="SPJOThOj"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342161AE872;
	Thu, 20 Jun 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890004; cv=none; b=IlSiL58rVpOIKJG4RmyYcevFZyouJkw0jfCxjr/oX+3jiIl3FjqOdGjnBOIONu4OswiNAJ1TtQZ2gdQLM9sOUGAZDBeE8RWCrExXW/vzZMf6zkaaTwTxSwAXYwJPLRh6+8E3d/jqb1+Sggp3pQql3Vh/65FdXfWXUrhtl49kb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890004; c=relaxed/simple;
	bh=dzpFwyNp+pQPgfQmVxgbYBcFHA5gR50/XR282v0SEcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edVVdiMeyOOiGA8ShpKdAWe3MEXAgtogIBLBosWgjF3FNHZljc93oh78B1eYd6V/RQp+fwVvmtu20vFGvowBud1lYBeY+WTTwAMA5HchrOcoq3pu45b9XecwjdzDHtqsvwbPAwp5f/QUC6ZpngwN4/BAVxr+7pIZkhCqCPuH3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=SPJOThOj; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 86F019C5BCC;
	Thu, 20 Jun 2024 09:26:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id nTj3k_ahoqKC; Thu, 20 Jun 2024 09:26:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AEAC49C5B16;
	Thu, 20 Jun 2024 09:26:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AEAC49C5B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718890001; bh=kZy1t3SqU/2B4N94w0esQiUo5Iw1qFVhQrzWef9QttY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=SPJOThOj6CLFR4t1Cy7pxc+I+BJgSv37PQCaD4U5PbgZA1lAlOtoeiylRGKH5d7ue
	 JmUuZnVGAOf7tUP1lkMCOTYB+tFYmRegjuZlsHZLMzAW9oF+FAo52SJBsKyhz4ysXg
	 OzjUtAs9J+/H9GaVepDBF5auwtyQz8WkuKbQaaAOcAnG3lT9AXLHUE6o/ea8rnYq51
	 gDll4eOCnSOLx9Ms6UXKcLQKZIy4ZwgGa7kwrLCog8fYhRt/xIu8ulG5zM5n3r96N9
	 rUZZBJOs/8t09KAMeqYacFjF9cBp8nwABFCVIHr7Zte4JixFLQMzfNMS6Pq8gK+LnB
	 lAQkpf7ibb6sw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BB1ZjeK5dvWS; Thu, 20 Jun 2024 09:26:41 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D55729C5BCC;
	Thu, 20 Jun 2024 09:26:38 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Subject: [PATCHv5 7/9] ASoC: dt-bindings: imx-audio-spdif: remove binding
Date: Thu, 20 Jun 2024 15:25:09 +0200
Message-Id: <20240620132511.4291-8-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

imx-audio-spdif was merged into the fsl-asoc-card driver, and therefore
removed.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 .../bindings/sound/fsl,imx-audio-spdif.yaml   | 66 -------------------
 1 file changed, 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-s=
pdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.ya=
ml b/Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
deleted file mode 100644
index 5fc543d02ecb..000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
+++ /dev/null
@@ -1,66 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/fsl,imx-audio-spdif.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Freescale i.MX audio complex with S/PDIF transceiver
-
-maintainers:
-  - Shengjiu Wang <shengjiu.wang@nxp.com>
-
-properties:
-  compatible:
-    oneOf:
-      - items:
-          - enum:
-              - fsl,imx-sabreauto-spdif
-              - fsl,imx6sx-sdb-spdif
-          - const: fsl,imx-audio-spdif
-      - enum:
-          - fsl,imx-audio-spdif
-
-  model:
-    $ref: /schemas/types.yaml#/definitions/string
-    description: User specified audio sound card name
-
-  spdif-controller:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: The phandle of the i.MX S/PDIF controller
-
-  spdif-out:
-    type: boolean
-    description:
-      If present, the transmitting function of S/PDIF will be enabled,
-      indicating there's a physical S/PDIF out connector or jack on the
-      board or it's connecting to some other IP block, such as an HDMI
-      encoder or display-controller.
-
-  spdif-in:
-    type: boolean
-    description:
-      If present, the receiving function of S/PDIF will be enabled,
-      indicating there is a physical S/PDIF in connector/jack on the board.
-
-required:
-  - compatible
-  - model
-  - spdif-controller
-
-anyOf:
-  - required:
-      - spdif-in
-  - required:
-      - spdif-out
-
-additionalProperties: false
-
-examples:
-  - |
-    sound-spdif {
-        compatible =3D "fsl,imx-audio-spdif";
-        model =3D "imx-spdif";
-        spdif-controller =3D <&spdif>;
-        spdif-out;
-        spdif-in;
-    };
--=20
2.34.1


