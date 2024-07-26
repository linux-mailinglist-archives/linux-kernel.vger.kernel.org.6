Return-Path: <linux-kernel+bounces-263600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9B93D822
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874CD28251F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561B4EB2B;
	Fri, 26 Jul 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JNU/tS9M"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5532D611;
	Fri, 26 Jul 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017883; cv=none; b=Hkyt9ctIe3ZC+oKLSJQ+ME5yySHUqzcLOahktpCetSFnzsF5MkW5FKII7V69qTTeuR4dqdwr9e3wSwUd90iBTC4unVFzonSIEGNa9wB9NnXCF60if8UAdEanC60vycMazw7mTw5qj9F+23Kh9b55W/WnuO2v64uDcGKuoHLhh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017883; c=relaxed/simple;
	bh=y0aifFpFzNsEAjy2SimRCfMt/eNN8A856yZr5Zw3+rU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L+ozfDUA3pOK2PKHE0WpPeh6Oy1aNJR94SWP7twdd6U/I2dTVBA/7PVI5L6TsEu8l0BbXO27OX8c6a30tHkJgBpzXyytF7v4c/FzzZIgR7HfwfgnML0hc1nHFeRAg40yEXUvO7e2TcCKYOTJYCBbaq/Qg9/PC/c26hiX1iA+p0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JNU/tS9M; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2D5BC0002;
	Fri, 26 Jul 2024 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+M5K/FZ1fAvJSe8Y1/x7LcWzZnw1g2sjOGJPV2jVE0=;
	b=JNU/tS9Mh7WpBflvpXUS/z85fsM7MHw696PpFSdfx6nVZiUmf19DLGTEstvovUprPn+g3w
	ouUbnL7/zqVTOTmz9XAkKUoJQBtzvs/E7PkTGCPcoy5A6Jq90Nq86vHPpO11bJGqHYZJIR
	wrez+is5/I42XaeTPsKE/kU1mGLQH9J5I4vgkR5On1lc502eaA3EoBUzNlSCcQ5MaVqGcI
	9k0eIrCWd+xFXIEsumwY/bdAL0//nK23lF5eM58sG6dpqw5JllCaPMxrXX8/Qnt18AjaXt
	8CJ6SPLIDpXaAqYhtg7/kFctS7WRdansnSpi3F3iNsFG3gEY9sb+WgDbXJnMjA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v5 00/12] Fix USB suspend on TI J7200 (cdns3-ti, cdns3,
 xhci)
Date: Fri, 26 Jul 2024 20:17:48 +0200
Message-Id: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEzoo2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMz3WKjIt3klLxiXZMkQwuD5BRLM4O0NCWg8oKi1LTMCrBR0bG1tQA
 hrSxnWgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Kevin Hilman <khilman@kernel.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Currently, system-wide suspend is broken on J7200 because of a
controller reset. The TI wrapper does not get re-initialised at resume
and the first register access from cdns core fails.

We address that in a few ways:
 - In cdns3-ti, if a reset has occured at resume, we reconfigure the HW.
 - We pass the XHCI_RESET_ON_RESUME quirk, meaning the XHCI core expects
   a resume.
 - We add a xhci->lost_power flag.

The previous revision had one big issue: we had to know if
reset-on-resume was true, at probe-time. This is where the main
difference with previous revisions is. We now pass the information from
wrapper devices back up into XHCI. The xhci->lost_power flag gets its
default value from the XHCI_RESET_ON_RESUME quirk. It however allows
wrappers to signal *at resume* if they still expect a reset.

That means wrappers that are unsure if they will reset should:
 - (1) set the quirk at probe and,
 - (2) potentially set xhci->lost_power to false at resume.

We implement that for cdns3, by piggybacking on the host role ->resume()
callback already receives the information from its caller.

Have a nice day,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v5:
- dt-bindings: take Reviewed-by Rob and Conor for the first
  patch: "dt-bindings: usb: ti,j721e-usb: fix compatible list".
- cdns3-ti:
  - We now do have HW init code inside cdns_ti_reset_and_init_hw().
  - It gets called at probe unconditionally and from ->runtime_resume()
    if a reset is detected (using the W1 register).
  - Auxdata patches have been reworked now that there is default auxdata
    since commit b50a2da03bd9 ("usb: cdns3-ti: Add workaround for
    Errata i2409"). We now have a patch that moves auxdata to match
    data: "usb: cdns3-ti: grab auxdata from match data".
- cdns3/xhci: those are three new patches.
  - First, we rename "hibernated" to "lost_power" in arguments to
    the role ->resume() callbacks.
  - Then we add the xhci->lost_power flag, and only have it always copy
    the value from XHCI_RESET_ON_RESUME.
  - Finally, we set the flag from the host role driver.
- Link to v4: https://lore.kernel.org/lkml/20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com/

Changes in v4:
- dt-bindings: usb: ti,j721e-usb:
  - Remove ti,am64-usb single compatible entry.
  - Reverse ordering of compatible pair j721e + am64
    (becoming am64 + j721e).
  - Add j7200 + j721e compatible pair (versus only j7200). It is the
    same thing as am64: only the integration differs with base j721e
    compatible.
  - NOT taking trailers from Conor as patches changed substantially.
- arm64: dts: ti: j3-j7200:
  - Use j7200 + j721e compatible pair (versus only j7200 previously).
- arm64: dts: ti: j3-am64:
  - Fix to use am64 + j721e compatible pair (versus only am64).
    This is a new patch.
- Link to v3: https://lore.kernel.org/r/20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com

Changes in v3:
- dt-bindings: use an enum to list compatibles instead of the previous
  odd construct. This is done in a separate patch from the one adding
  J7200 compatible.
- dt-bindings: dropped Acked-by Conor as the changes were modified a lot.
- Add runtime PM back. Put the init sequence in ->runtime_resume(). It
  gets called at probe for all compatibles and at resume for J7200.
- Introduce a cdns_ti_match_data struct rather than rely on compatible
  from code.
- Reorder code changes. Add infrastructure based on match data THEN add
  compatible and its match data.
- DTSI: use only J7200 compatible rather than both J7200 then J721E.
- Link to v2: https://lore.kernel.org/r/20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com

Changes in v2:
- Remove runtime PM from cdns3-ti; it brings nothing. That means our
  cdns3-ti suspend/resume patch is simpler; there is no need to handle
  runtime PM at suspend/resume.
- Do not add cdns3 host role suspend/resume callbacks; they are not
  needed as core detects reset on resume & calls cdns_drd_host_on when
  needed.
- cdns3-ti: Move usb2_refclk_rate_code assignment closer to the value
  computation.
- cdns3/host.c: do not pass XHCI_SUSPEND_RESUME_CLKS quirk to xHCI; it
  is unneeded on our platform.
- Link to v1: https://lore.kernel.org/r/20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com

---
Théo Lebrun (12):
      dt-bindings: usb: ti,j721e-usb: fix compatible list
      dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb compatible
      usb: cdns3-ti: move reg writes to separate function
      usb: cdns3-ti: run HW init at resume() if HW was reset
      usb: cdns3: add quirk to platform data for reset-on-resume
      usb: cdns3-ti: grab auxdata from match data
      usb: cdns3-ti: add J7200 support with reset-on-resume behavior
      usb: cdns3: rename hibernated argument of role->resume() to lost_power
      xhci: introduce xhci->lost_power flag
      usb: cdns3: host: transmit lost_power signal from wrapper to XHCI
      arm64: dts: ti: k3-j7200: use J7200-specific USB compatible
      arm64: dts: ti: k3-am64: add USB fallback compatible to J721E

 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   5 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   2 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   4 +-
 drivers/usb/cdns3/cdns3-ti.c                       | 151 ++++++++++++++-------
 drivers/usb/cdns3/cdnsp-gadget.c                   |   2 +-
 drivers/usb/cdns3/core.h                           |   3 +-
 drivers/usb/cdns3/host.c                           |  13 ++
 drivers/usb/host/xhci.c                            |   8 +-
 drivers/usb/host/xhci.h                            |   6 +
 10 files changed, 136 insertions(+), 60 deletions(-)
---
base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
change-id: 20240726-s2r-cdns-4b180cd960ff

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


