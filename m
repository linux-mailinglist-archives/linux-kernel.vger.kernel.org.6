Return-Path: <linux-kernel+bounces-440049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1E89EB7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83116282BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09623239E;
	Tue, 10 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GGfhwyP+"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C34230245;
	Tue, 10 Dec 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850826; cv=none; b=bX1GFt/9KAABM0lTy3prP4uHwxfJ7B1SRag66pTG4TIkcnChaT9w4r+uPttBmYEkhcY1ZF39flVPXJVnwGV8rx6qriHZg50qw+wiJuJmJxuWENYBjm2/uFys73pGUKsDsrOKlprjWRtVWI/Ow1NaqYkyEQgJdjlzp+2nLnpZIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850826; c=relaxed/simple;
	bh=9qqAHr5QsQ2sxTokkMCEtWEqsg26LY1s5P9jVA6bJfo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GyDDJ/cqK37SnllhOALeY7+ICRn+R+iGzTQ4aO902JZj+6OM34H18/iJDUVe/ORe5BJDf/DV3X1pyf32lu8YZGfrrV3v6ImzEs8zOayks0o/mZdhBWu59NkjdPAC5sn3uL/ZuBPDNEnMAu3+XCJJfG4Yvbj5ZtVJH9s1rbK12PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GGfhwyP+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEDF520003;
	Tue, 10 Dec 2024 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733850816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XTJbDWjxUvBLgkJN40OxV8a7OiikPNfSSCtoLl7PJTY=;
	b=GGfhwyP+KJZG10bYUlMsYxyLQKw3DpsWgMqT2Xc+wo8q5txQxD8Cki9mpkI3I2IEeqywn0
	08bv8CwAHfWGJLHLzFCcQjTZo8svG/uf/zK7zaXz5iqDP1YP8TMuVyHaYz1SJS3f5IF/5d
	eT4qemkeKtUCKkKqScnf+CiCK9BQZ1XF35Vtx9UygdHCykCqH7ARdrKvGTr71e0fjUINzX
	mD3lUqTLlCKJ1GOEmFs33IEVBSNw8m8oMaL2oVCv84Rt1KYunS19D1GxsxqR6wnbRLgm8s
	hs1/Yz13+JvTGwjHsSZ0YXiakGsQsAYas+JK4VHOsKzSYG6HIalJe0XPGy1SFw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v6 0/5] Fix USB suspend on TI J7200 (cdns3-ti, cdns3, xhci)
Date: Tue, 10 Dec 2024 18:13:34 +0100
Message-Id: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL52WGcC/23MywrCMBCF4Vcps3YkxjRWV76HdNHc7IAmkilBK
 Xl3Y9cu/8PhW4F9Js9w6VbIvhBTii30rgM7T/HukVxrkEIqcZIaWWa0LjIqcxiEdWctQoB2f2U
 f6L1Rt7H1TLyk/Nnk0v/WP0jpUeCgtTLBiKOc7NWktDwo7m16wlhr/QIAJrkOogAAAA==
X-Change-ID: 20240726-s2r-cdns-4b180cd960ff
To: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

Currently, system-wide suspend is broken on J7200 because of a
controller reset. The TI wrapper does not get re-initialised at resume
and the first register access from cdns core fails.

We address that in two ways:

 - In the cdns3-ti wrapper, if a reset has occured at resume,
   we reconfigure the hardware.

 - We add a xhci->lost_power flag. Identical to the XHCI_RESET_ON_RESUME
   quirk, expect that it can be set at runtime.

   At resume, to summarise, we do:
      xhci->lost_power = cdns_power_is_lost(cdns);

The previous revision merged both XHCI_RESET_ON_RESUME quirk and
xhci->lost_power concepts into a single one (the quirk was the default
value of the flag). Now, we separate those. It simplifies things
because no additional compatible is required; we can detect everything
at runtime.

Have a nice day,
Théo

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v6:
- Drop two upstreamed patches:
  8e3dc6a51cca ("dt-bindings: usb: ti,j721e-usb: fix compatible list")
  d7fad3c5c53e ("arm64: dts: ti: k3-am64: add USB fallback compatible to J721E")
- dt-bindings: fix dt-schema syntax in compatible property.
- Change the approach about xhci->lost_power and the
  XHCI_RESET_ON_RESUME quirk. They are now separate and are checked
  independently at resume. The quirk stays the same, the flag can be
  detected at resume.
- Drop many patches, now that we don't add a new compatible for J7200:
  dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb compatible
  usb: cdns3: add quirk to platform data for reset-on-resume
  usb: cdns3-ti: grab auxdata from match data
  usb: cdns3-ti: add J7200 support with reset-on-resume behavior
  arm64: dts: ti: k3-j7200: use J7200-specific USB compatible
- Link to v5: https://lore.kernel.org/r/20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com

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
Théo Lebrun (5):
      usb: cdns3-ti: move reg writes to separate function
      usb: cdns3-ti: run HW init at resume() if HW was reset
      usb: cdns3: rename hibernated argument of role->resume() to lost_power
      xhci: introduce xhci->lost_power flag
      usb: cdns3: host: transmit lost_power signal from wrapper to XHCI

 drivers/usb/cdns3/cdns3-gadget.c |   4 +-
 drivers/usb/cdns3/cdns3-ti.c     | 109 +++++++++++++++++++++++++--------------
 drivers/usb/cdns3/cdnsp-gadget.c |   2 +-
 drivers/usb/cdns3/core.h         |   2 +-
 drivers/usb/cdns3/host.c         |  10 ++++
 drivers/usb/host/xhci.c          |   3 +-
 drivers/usb/host/xhci.h          |   6 +++
 7 files changed, 93 insertions(+), 43 deletions(-)
---
base-commit: d1869e31ecb0bb7397c6a04c29f281864e9257e3
change-id: 20240726-s2r-cdns-4b180cd960ff

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


