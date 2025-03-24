Return-Path: <linux-kernel+bounces-574023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB49A6DFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05247A6CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ABF2641CD;
	Mon, 24 Mar 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9AOue6h"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382F263F4E;
	Mon, 24 Mar 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833811; cv=none; b=qJKlMJgnjGoKyayOSjcKA2PSZYGs8qx9MYrl6Ry9vq0RTbMJrUR+dRPFI4DGRHtJ3dUjMrPweyDqJIRCnjjuJKSGKhKWa9Idzauny/QATD6zUKKS4133SXyzRFHc1O/osQEboYDDkICgPmCQxTTc07i6xAZnNlagfqVO37RxJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833811; c=relaxed/simple;
	bh=C3XAo9qh2gj1Wbuwolnf2JOAUQZCs6fKOeKZA1fqa6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKcoRHQtLkOQ0CPtjRXSnhisGZVnPwHqKR1rHwN0Ocddq+R6IzsPxcDl46o+eXD14ZXQD/9y6DvfD+Cw0l+bRO18ierBVVaKasejmFxu+rlU+cukTVBFpp4uXJG/IW0lxAu3bTr5WEWqV7gXcAYnrnrI07Ut/lffYxekvHv+Fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9AOue6h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso31243945e9.2;
        Mon, 24 Mar 2025 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833808; x=1743438608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RR/33HkyWRVzBTpKjMr4gmsX71tawz+FueWvMxXm7FQ=;
        b=G9AOue6h2ucnD4sDy22oaILanjSuf5geGycz1fH+YYWlQvbBwdVizYGXKoXMefMXsE
         zL3l7dFa0rxvCvtUdRSjlcdFrLML8qa7mGDFBjUitcLkaN0sd9+38C1P29dudtoR/1Zx
         tMdLDNR6ltVdVw8uhmj5910x93hMuitUu0OcyUyRfGUMbo4tLqEc7KbF4LOXl3MQxeFf
         1kSSY4bAnGVClNRDsoAkCwkPbJuqZZdm28AK1jY2E/9/y2INWAfFu5vEBQshnM4GlQgG
         AOxv8mz/pHdh1+epJzuoxajfLME7x1JV4FfU3uXhYFmPssua50gE7vteriPh66NAt2pv
         3W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833808; x=1743438608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RR/33HkyWRVzBTpKjMr4gmsX71tawz+FueWvMxXm7FQ=;
        b=fOGTSi9wfWyGjh6rbnhctkf0NosY9xha3C3qX6p1w5o1WII0V5qvmaDcMPirH1xqpV
         zkMRQ5/tZeIW1A9CLLr0m2S2N+prlOBN2sdk9Xf5g6Km233dA6zObLYXUFpWwPWoYrwc
         QV20qmkGAmElNf81oOXhBrKmLBp76eSN6BHwyPZbcqC1qaazJykfkUj2gTHbt0Wfi7W+
         1yz1xJ/9b68Yns5hRbC3qKxjrG9LdiDssVPKn5LbeLC0NGvrWN3fsjSa1pn16ifQbbBZ
         /kNcEfIADdK9efrjcfB0ztCr8rKmbs5A0QNe9lGx4fliY/qjw0rsF4IORWU6T0g9hqns
         ibQg==
X-Forwarded-Encrypted: i=1; AJvYcCVfriTij7v9Mwr1r2q3W3lSvJqd9AS6CJ53eKgkxrK64G1NSm5mor7Gk/ckYjKnHcxTb4TFXooGi//MZ+oG@vger.kernel.org, AJvYcCXw0SsmUvv+oHSrFieJWnd61wZLiRwl2thwjK0tOTu7yiq9styPoSpfpzVt4aanYmSRLV1v0JiZ8XqH@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2ifM9nAYZjtbSjITk71D7vFjzN+FApEzSDyLQ1UwGPQKNJsF
	6Wd16JOc96WkkQBqDgvFIEnMU6fhxIhafvtECay8EMywoqMs28K0
X-Gm-Gg: ASbGnctzhdsHcdl0OMeh3aifqIaMSnxVNyX+ZFiwUq6gO4P2vQ1agrOaVuYaAXZCbWh
	i0GacwDyzn28d30PRDDP8Q18eKsVrsDFsp3bgeIhYRsjyXOkJztDpLjrgUhfIjNm+0zYwMC6fpi
	vuGcwVc92n29G4gBK02VMdVVjEbuNsqgQq9zFig2eBvkmsXhkbHgEwF119SzdfiPWIm6RFUfige
	RkpNJtBantPSWpOiU7+5aou973Qx20PJNxy0bYr5o1/A21Gbu0Ic65QV2XQsZi8orEu0SZe7p85
	FrG5l0uLZCnbDWrhDTnf7/EtwGtiVnZ+kjGbBE+b0Rc8v1A7El/JFMRA2D9S5BFte71MEV2MBQS
	Ywv4W31g=
X-Google-Smtp-Source: AGHT+IEo9FRh6+xI/yyeaQ866fq+Tvmef9RLHhF10hpOmSRuuMOdP7oXv8eQi8BJzr1/UzfTyIuU2w==
X-Received: by 2002:a5d:6da5:0:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-3997f958f34mr10877702f8f.46.1742833807619;
        Mon, 24 Mar 2025 09:30:07 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm124106765e9.34.2025.03.24.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:30:07 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] imx8mp: add support for the IMX AIPSTZ bridge
Date: Mon, 24 Mar 2025 12:25:51 -0400
Message-Id: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The AIPSTZ bridge offers some security-related configurations which can
be used to restrict master access to certain peripherals on the bridge.

Normally, this could be done from a secure environment such as ATF before
Linux boots but the configuration of AIPSTZ5 is lost each time the power
domain is powered off and then powered on. Because of this, it has to be
configured each time the power domain is turned on and before any master
tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).

The child-parent relationship between the bridge and its peripherals
should guarantee that the bridge is configured before the AP attempts
to access the IPs.

Other masters should use the 'access-controllers' property to enforce
a dependency between their device and the bridge device (see the DSP,
for example).

At the moment, we only want to apply a default, more relaxed
configuration, which is why the number of access controller cells
is 0.

The initial version of the series can be found at [1]. The new version
should provide better management of the device dependencies.

[1]: https://lore.kernel.org/linux-arm-kernel/20241119130726.2761726-1-daniel.baluta@nxp.com/

---
Changes in v3:
* make '#address-cells' and '#size-cells' constants and equal to 1 in the
binding. The bus is 32-bit.
* add child node in the example DT snippet.
* the 'aips5' DT node now contains 2 memory regions: that of the
peripherals accessible via this bridge and that of the access controller.
* link to v2: https://lore.kernel.org/lkml/20250226165314.34205-1-laurentiumihalcea111@gmail.com/

Changes in v2:
* adress Frank Li's comments
* pick up some A-b/R-b's
* don't use "simple-bus" as the second compatible. As per Krzysztof's
comment, AIPSTZ is not a "simple-bus".
* link to v1: https://lore.kernel.org/lkml/20250221191909.31874-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (5):
  dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
  dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
  bus: add driver for IMX AIPSTZ bridge
  arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
  arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'

 .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 107 ++++++++++++++++++
 .../devicetree/bindings/dsp/fsl,dsp.yaml      |   3 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 +-
 drivers/bus/Kconfig                           |   6 +
 drivers/bus/Makefile                          |   1 +
 drivers/bus/imx-aipstz.c                      |  92 +++++++++++++++
 6 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
 create mode 100644 drivers/bus/imx-aipstz.c

-- 
2.34.1


