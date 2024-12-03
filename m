Return-Path: <linux-kernel+bounces-429266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE789E1B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA010B46729
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45911E32A7;
	Tue,  3 Dec 2024 10:39:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7F1E2600
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222358; cv=none; b=lCv8cFx5iIXYzGpuQ7o0SMh54wTFj9YI6CNU74S93D1c0p7N35ZBNiqZep+TIpdQpOee7ISXltZXoe7G4aExK+IZm8uDHvfbTtZZmXAXiSryV+BUDroVytAmB0KnhBqNdqAoVVP29gOA9VYlX8VZjBSD9ytHChkcizciqoyMsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222358; c=relaxed/simple;
	bh=7eftw6vTVAZ6qV7FZ2xrJN05h5veZj7YhZDDwKfUJdA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CXXCsXJsImlUdBQHeuF0284G/Ms/2LNY+AXtQwD/AgEXyqY25laBOn8i4AWArbLWM9J9TQy6d7hiufllt5B6zQenkn0qq41MSPX2TKvZpt3/Q4MCTg1Q6VuMxedITaW0WVxVVhkIxKJ3Z1PFamKWGjLrSlmgjUxpVHdSmI3TiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1tIQJ6-00012Q-0j; Tue, 03 Dec 2024 11:39:04 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v3 0/3] Add support for Fujitsu MB85RS128TY
Date: Tue, 03 Dec 2024 11:38:34 +0100
Message-Id: <20241203-mb85rs128ty-v3-0-79107d54d839@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrfTmcC/2XMQQ6DIBCF4asY1qUBRISueo+mC5VBWRQNUKIx3
 r1oNzXdTPJP8r4VBfAWAroVK/KQbLCjy1FeCtQNjesBW50bMcI4pUzhVysrHyiTccGiUiCpIkR
 VNcqLyYOx86E9nrkHG+LolwNPdP9+nXxOTqKY4EYI0gquiO7kfQLXv6MfnZ2vGtCOJfYLlGeAZ
 YAzbUqojaG8/gO2bfsAl/4CbuwAAAA=
X-Change-ID: 20241129-mb85rs128ty-659e81900957
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Schocher <hs@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=7eftw6vTVAZ6qV7FZ2xrJN05h5veZj7YhZDDwKfUJdA=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYkj3u78/r0M3t33fFq0Ua9NjV89f8zoULC93eV5vbUeaC
 aOet8LNjlIWBjEOBlkxRZZYNTkFIWP/62aVdrEwc1iZQIYwcHEKwESS4xn+yt1nMA69sKfjzCoJ
 Dd7Ls+UdsyaETE4/Ex9wweqASJPJdkaG198Z3nreW19+6cxFzQg/a6sl9fOemclGu0tof7v55Gw
 8KwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The Fujitsu MB85RS128TY FRAM chips behave almost identically to the
Microchip 48L640. This series adds their support to the mchp48l640
driver.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v3:
- Alphabetically sort compatible list
- Link to v2: https://lore.kernel.org/r/20241203-mb85rs128ty-v2-0-42df3e7ff147@pengutronix.de

Changes in v2:
- Correct dt schema in Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
- Link to v1: https://lore.kernel.org/r/20241202-mb85rs128ty-v1-0-a660b6490dc8@pengutronix.de

---
David Jander (2):
      mtd: mchp48l640: make WEL behaviour configurable
      mtd: mchp48l640: add support for Fujitsu MB85RS128TY FRAM

Jonas Rebmann (1):
      dt-bindings: mtd: mchp48l640 add mb85rs128ty compatible

 .../bindings/mtd/microchip,mchp48l640.yaml         |  5 ++--
 drivers/mtd/devices/mchp48l640.c                   | 28 +++++++++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)
---
base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
change-id: 20241129-mb85rs128ty-659e81900957

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


