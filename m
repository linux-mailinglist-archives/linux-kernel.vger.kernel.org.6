Return-Path: <linux-kernel+bounces-371740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C79A3FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92CE1F22828
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481681E0DF2;
	Fri, 18 Oct 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GEoVn5Zi"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD16433B5;
	Fri, 18 Oct 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258273; cv=none; b=jZdcv22aaQZNsw+jjVEcFp0G76eXHckUNv5XEkm8JHo/HwvBwpfck2+zpqaPicjEy6GOzraZ2HdJeiHQPeAPs1j8NEwDeSvSCiXqeJ7im9GveTI3YPBhSkCrBdDy+7sE3tX5CfyvyGL5D1mBL0DdHeWJEEg/Wvza1kRC417uRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258273; c=relaxed/simple;
	bh=UypE5YTifqNi8LVaHaWGFhy4RZPAjKcgx16DwVQcQc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V3MXN5Htdv9MIjjeOof/9MSl/iwudq4RE4ceCXojEW5jVg1cwtu/V8IejM/fcpoD4VnvADCJzeIKHfH4klWutWuCnnGPVeyCTYQbkVI40tN/Aq/yvPTZsv9DmfS4yR4pIoRSLhjLCII1a3b282qyhQ8qwAhtpk2717wtWIMYSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GEoVn5Zi; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A18B7FF802;
	Fri, 18 Oct 2024 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729258263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e+T9+sV4VYe1A4VswfmwUjhqeHNzCFwIhnWxyoj4wrI=;
	b=GEoVn5ZibtC/ms0hzfF18nov0+MZyZH8wem4V/FcFcp1Nme+IG7AAdmfcsl2avCsRTRGo0
	IQ/Z1bwlapOuqoHQLe4BsC2+/JkaZuod89YVL5660At7urdP5DNW1JS9VGaIuz2i0KyytH
	JdjUPoL0Pprn0j14h1QKb0hGkGf+ADNBVeu9/JDwVDe7R4wnOEPQ1QUctCDLZPjV9QHprE
	O3YJzVxfIimwJOmTtUQu5MKpfUxN0fWZ3slqocSSxsOvB7I2gQFES6YMJz/V+k1hTldKqv
	MiwRoK18FGq3srESubzKD5eoSkelNIS+EGbxKFgNyDBpsEOQdh6OQwl3tRCt3Q==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH 0/2] Add support for the TUSB1046-DCI Type-C crosspoint
 switch
Date: Fri, 18 Oct 2024 15:30:47 +0200
Message-Id: <20241018-tusb1046-v1-0-a38312f18691@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhjEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3ZLS4iRDAxMz3dSkFAMLIzMTcwvLFCWg8oKi1LTMCrBR0bG1tQB
 isbKIWgAAAA==
X-Change-ID: 20241014-tusb1046-ebd08264789d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This series adds support for a Type-C linear redriver crosspoint switch which
can function as a Type-C switch and DisplayPort altmode multiplexer.

Best Regards,

Romain Gantois

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Romain Gantois (2):
      dt-bindings: usb: Describe TUSB1046 crosspoint switch
      usb: typec: mux: Add support for the TUSB1046 crosspoint switch

 .../devicetree/bindings/usb/ti,tusb1046.yaml       |  49 +++++++
 MAINTAINERS                                        |   7 +
 drivers/usb/typec/mux/Kconfig                      |   9 ++
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/tusb1046.c                   | 161 +++++++++++++++++++++
 5 files changed, 227 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241014-tusb1046-ebd08264789d

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


