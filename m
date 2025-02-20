Return-Path: <linux-kernel+bounces-523740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A4A3DA97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C3B188AF04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB241F6679;
	Thu, 20 Feb 2025 12:58:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3F1CAA86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056311; cv=none; b=cz3668yblpNuUifFN9NKMnVgUPJRX6C38BEiqqbTnzDAS5EJQpl5G2Ch5guoW7gFwt7z8wszwtXmtAdGZw/v0HiGXBXKp3lRz4x47skHJgHzJA2kfWL7XwoDgCudakB8hWsEup4VjrEZsH5S2iN71vPyRnwKehW/BDwcsEa+QXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056311; c=relaxed/simple;
	bh=cdMsuvZNARNlr3OR3LT9KLhenut6xVoVJzsY4VsXHhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=naZ6Gw9pMLMUMy5AZNnNkEKi2TpU+pJNHKMaOQbLGa2JzPL4+TO77joOdkAuJ2pj2DzCuel7bgXLd8gl6YEQQis6NhEZ+6Q3SMG/viwoJ0un8w2qYhJnY7jKXU2pX3elTXy5MZY8QwIfDa4dQaMdp6pnJMbQHctFkBdS4Bs3P4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tl68H-0004lJ-S7; Thu, 20 Feb 2025 13:58:25 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 0/2] LED: Add basic LP5860 LED matrix driver
Date: Thu, 20 Feb 2025 13:57:55 +0100
Message-Id: <20250220-v6-14-topic-ti-lp5860-v1-0-42874bdc7513@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMmt2cC/x3MTQqAIBBA4avErBvQIe3nKtGibKqBKNGIQLp70
 vJbvJcgchCO0BUJAt8S5TwydFmA28ZjZZQ5G0iRUaRbvC3qCq/Ti8NLcPemsQoXMmPVTJZc3UJ
 ufeBFnv/bD+/7AbzLmllnAAAA
X-Change-ID: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steffen Trumtrar <kernel@pengutronix.de>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The lp5860 is a LED matrix driver with 18 constant current sinks and 11
scan switches which allows controlling up to 198 LED dots.

This series adds just the basic support for the device on the SPI bus.
It is also possible to use it on I2C. The interface can be
switched/selected via an interface select pin.

Next step for this driver will be adding open and short detection of the
LEDs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Steffen Trumtrar (2):
      dt-bindings: leds: add lp5860 LED controller
      leds: add support for TI LP5860 LED driver chip

 .../devicetree/bindings/leds/leds-lp5860.yaml      | 112 ++++++++
 drivers/leds/Kconfig                               |  23 ++
 drivers/leds/Makefile                              |   2 +
 drivers/leds/leds-lp5860-core.c                    | 276 ++++++++++++++++++
 drivers/leds/leds-lp5860-spi.c                     | 100 +++++++
 drivers/leds/leds-lp5860.h                         | 315 +++++++++++++++++++++
 6 files changed, 828 insertions(+)
---
base-commit: 268400f2b82359d6aca2742a104c14b4acd9cdcd
change-id: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


