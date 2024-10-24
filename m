Return-Path: <linux-kernel+bounces-379512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90569ADF89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F07B1F22BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0C1B3933;
	Thu, 24 Oct 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nvtSGN8V"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3DD1B21B8;
	Thu, 24 Oct 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760078; cv=none; b=Txlkig/S0fDYJwYRry4WOLiMsC7cAwwNr9lAZsGXOcp358cLLFeTpZeVdZfDniaAxeGLs0hTxIc7FEbs6qSVSpv+kBgpHIsys+dOJOX66VHSnG1drCU86V48HUg8I6y04peYpf1Kx66apdiazz/dYiIr7cYi4HbLWbiuQIxr1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760078; c=relaxed/simple;
	bh=IbKxZ4SDmQ0F/BJLjloXdSocPx19ISWagXO6KmOzM+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NQdzVtQp4NcPqUOUxeibX4HviyHPVwr4k+x6Of8i40AC072LM1rK1InD6U2+g94gCgHYbmgHj7KBul9ncvYi0b5HVcnWF4qvOZF5SE1R5hChPE67jMJq2oVlChpDQAX2VUz4m/bDnah12Ku4yHZ2wCsK8zs437dhSCAFlLHClXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nvtSGN8V; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D565C000A;
	Thu, 24 Oct 2024 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729760068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X4QGME8t/jvHkzGkoOj3E0l4H/GbPzxU1alYrgfWB48=;
	b=nvtSGN8Vsgpbo7s5f1Hz0wnQKnSywzd+9bS4NQn+l92+/g63WzLZZne0Uf/y7Dww0fvGX8
	6VqtgA70M6W33m0SuR06PZDZ3+S2iHaxhUBB2EMYndF+6Da1X3RkA+9y7gR3k22J2iEq1A
	QEylzvuSNSn5pfBl/6d8AWPOFNvbNA8GNYxqsmwrmyPL92qaL66D1KuS/XyOgciILyy6hX
	fTgioiZb98bYGq3ittExZ/FPG+E/gTAeX6SCw6WkSa2Wnw9BAdbklQGvqt0d7NYZ+gEQ8R
	cHZCqq1zio3ZWT4suuvSWI729N19USGLq/Aoxg+ygsPbQhs6nE1BfwczgBGY4Q==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v2 0/2] Add support for the TUSB1046-DCI Type-C crosspoint
 switch
Date: Thu, 24 Oct 2024 10:54:15 +0200
Message-Id: <20241024-tusb1046-v2-0-d031b1a43e6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgLGmcC/0XM0QrCIBTG8VcZ5zrD48RcV71H7GJO1w6UDrVRD
 N89G0SX/4+P3wbJRXIJzs0G0a2UKPga4tDAOA/+5hjZ2iC4kMhRsvxMBrlUzBnLtVDypDsL9b5
 EN9Frp6597ZlSDvG9yyt+1x+i/8iKjLOh1S2KCbXq8GJCyHfyxzE8oC+lfAAydsxdogAAAA==
X-Change-ID: 20241014-tusb1046-ebd08264789d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is version two of my series which adds support for a Type-C linear
redriver crosspoint switch which can function as a Type-C switch and
DisplayPort altmode multiplexer.

Best Regards,

Romain Gantois

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Fixed indentation in dt binding.
- Added locking and svid checking to TUSB1046 driver.
- Link to v1: https://lore.kernel.org/r/20241018-tusb1046-v1-0-a38312f18691@bootlin.com

---
Romain Gantois (2):
      dt-bindings: usb: Describe TUSB1046 crosspoint switch
      usb: typec: mux: Add support for the TUSB1046 crosspoint switch

 .../devicetree/bindings/usb/ti,tusb1046.yaml       |  49 ++++++
 MAINTAINERS                                        |   7 +
 drivers/usb/typec/mux/Kconfig                      |   9 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/tusb1046.c                   | 196 +++++++++++++++++++++
 5 files changed, 262 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241014-tusb1046-ebd08264789d

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


