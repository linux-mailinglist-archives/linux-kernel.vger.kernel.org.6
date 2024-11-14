Return-Path: <linux-kernel+bounces-408880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C961F9C849F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF6F283A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB61F76C5;
	Thu, 14 Nov 2024 08:10:10 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B791E7671;
	Thu, 14 Nov 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571810; cv=none; b=Pqft7HBDZWnDcaiKuhAKgbOc3vbotzzoY9dK2m8hZXlUzFcmJq1+zPGFzwTZvJiPa4BaB3Bgk9fA1TG8LIPNr4WEzDGroHnH0ORQ/McxKT73RAfj4lHAem88uVzIXfE0tt7gkmjLxtRjZ3DTBCGiVMa6lzX+HUEAFjd0hsIKGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571810; c=relaxed/simple;
	bh=RObspLow/vmSzR3SfOzFDEHNR+ZBABPfxilqDSddnKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OEASDrPPTulTF1cTgehmkC0gzsZPJS+mN02U1gJqt1AdBMPwlHl6T3o0jk1GYZZCoEvLqHfWrQKN29PLCjKeHO5lh8hsISR+FhSX+OZEayrUvQAFwLP3+tiW1Ptov9zEr4WZ3s46w6RiTzaRZSTtHEI0eSIyDgXpcOW1XbFku+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.192.66.22])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id 5ED02120;
	Thu, 14 Nov 2024 09:02:22 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Subject: [PATCH v2 0/4] usb: typec: hd3ss3220: enhance driver with port
 type, power opmode, and role preference settings
Date: Thu, 14 Nov 2024 09:02:05 +0100
Message-Id: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH2uNWcC/42Nyw6CMBBFf4XM2jFtbXi48j8MCxwGaYSWtIWIh
 H+3mrh3eW5uztkgsDcc4Jxt4HkxwTibQB0yoL6xd0bTJgYllJZSaJzDDeM6MSE5G70bBvbINn2
 JR7YxYF4WUulKq6oTkDyT5848v41rnbg3ITq/fpOL/Kw/e/GHfZEo8FSWOcmGiFt1ec3cDw8+k
 huh3vf9DVOUd3rUAAAA
X-Change-ID: 20241104-usb-typec-controller-enhancements-6871249429f0
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>, 
 Oliver Facklam <oliver.facklam@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731571341; l=1335;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=RObspLow/vmSzR3SfOzFDEHNR+ZBABPfxilqDSddnKs=;
 b=PSoT6OaI4mRaAUirMhdhkGkxUK73cnsB5U+nng/ljoQ4qMS7yvQ1zOqLdrwGe1G6MA+320dxu
 bdPsCzlTEPVAqf28TPxyW/I4iClLiRTrDHmsNL1KXHatnJb+7k4jC1b
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The TI HD3SS3220 Type-C controller supports configuring the port type,
the advertised power operation mode, and its role preference
through its I2C register map.

This patch series adds support for configuring these registers
based on existing fwnode properties and typec_operations.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
Changes in v2:
- Better support optional fwnode properties being absent by setting
  defaults in struct typec_capability and checking return code of
  typec_get_fw_cap()
- Link to v1: https://lore.kernel.org/r/20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com

---
Oliver Facklam (4):
      usb: typec: hd3ss3220: configure advertised power opmode based on fwnode property
      usb: typec: hd3ss3220: use typec_get_fw_cap() to fill typec_cap
      usb: typec: hd3ss3220: support configuring port type
      usb: typec: hd3ss3220: support configuring role preference based on fwnode property and typec_operation

 drivers/usb/typec/hd3ss3220.c | 172 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 24 deletions(-)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241104-usb-typec-controller-enhancements-6871249429f0

Best regards,
-- 
Oliver Facklam <oliver.facklam@zuehlke.com>


