Return-Path: <linux-kernel+bounces-278057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB9794AA42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EECA1C210D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660B7F47B;
	Wed,  7 Aug 2024 14:37:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79137D412
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041424; cv=none; b=YTYE/3yyLpXdohPZLnN9GU7ioFoAdLGc2II1IKT45tA2g73AwAgAMWH+WpROBDlMFyNO+qPjRSpgXk+8SsFcBeZIjrxipy5z55qByBWQvnJDjO9O7pdJ3/immj7l42l1+EIz0/up0JOQBs7To6dqhCxPu2MyeQnHigzGAE88NDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041424; c=relaxed/simple;
	bh=/ShUO5gWWyQPEk/n/IYfO27GTJqaZHpFeEF6y5w9DLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dr7PYAjahtJ04CAtqrohrBEz+2BCtvbzDDRRjp9M+Uf2nne5keBmAYFxT6tBE0B/nSJYM1stw1RKNM9GQOPWh6g/qDz5RScvbE/9GXSOELHqd+3DVXklqqWIKwBrSTi6l4/ygHme1IjZYgRoenVyet5D5iPLK8k2caUOEYdnutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sbhme-0004Iv-G5; Wed, 07 Aug 2024 16:37:00 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/3] External VBUS port power handling for onboard USB
 devices
Date: Wed, 07 Aug 2024 16:36:50 +0200
Message-Id: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-0-f33ce21353c9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOGs2YC/x3NywqDMBBG4VeRWfvDGIKXvkpxYczYziaRRENBf
 PcGl9/mnIuyJJVMr+aiJEWzxlDRtQ2t3yV8BOqrybCxPPIAZ1F6dIwj7rrizA4xuLgkDy8FdmL
 Lw2i82SaqkT3Jpr9n8J7v+w/z3qe+cAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

some PCB designs don't connect the USB hub port power line to the
dedicated hub port power pin. Instead they use a host controllable GPIO
line to enable the VBUS power.

This patchset addresses this use-case by hooking into the
usb_clear/set_port_feature() function and call the usb-onboard-dev hook
if available. The usb-onboard-dev driver is taking care of the rest.

Regards,
  Marco

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Marco Felsch (3):
      usb: hub: add infrastructure to pass onboard_dev port features
      dt-bindings: usb: microchip,usb2514: add support for port vbus-supply
      usb: misc: onboard_dev: add ext-vbus-supply handling

 .../devicetree/bindings/usb/microchip,usb2514.yaml |  7 ++
 drivers/usb/core/hub.c                             | 22 ++++++-
 drivers/usb/misc/onboard_usb_dev.c                 | 76 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h                 |  2 +
 include/linux/usb/onboard_dev.h                    |  6 ++
 5 files changed, 111 insertions(+), 2 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240807-b4-v6-10-topic-usb-onboard-dev-49040782d2f9

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


