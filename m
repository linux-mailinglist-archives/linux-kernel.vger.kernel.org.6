Return-Path: <linux-kernel+bounces-192097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889ED8D1859
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45832281752
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636616B745;
	Tue, 28 May 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vcf9VNi4"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89C16B729;
	Tue, 28 May 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891636; cv=none; b=KYQ+v9pBoCxmR1SwIGYHQIrX4ZMWRaRPDYvnd5M7EMm7/NJyAICCZMoxxx90I9fOWgYJWKhBbrGeAQ3CAF7pPkn9YHXWb6MbXYlbuywPkYviHRm5X5V235nx3rIfPUA1P0/YhvRRw4dgY1bu2PG/4DvLBwF+Xf5GJav3gh7ff34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891636; c=relaxed/simple;
	bh=ViR8Udm3r/8e8RITNn1t7ns7zufnKVllfdjhJnE/Dvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2x7c+c85tWrAFDFct/zSydDAEaiSJDxIVIgyoy9dBbSuS/keebJgHG4ixP3TdKXu/Z2giVp/cAFYGGYWQpR8OXtwuGkD/Dz0LhvQ+J4X6f/Nb1zC9TRHsqco65lvYR47tb1elg/zyQk/9Y5PZSiSBYlImSYr+Nb80gP5p5nvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vcf9VNi4; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4D0DE24000B;
	Tue, 28 May 2024 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716891629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=amToApSarLSNqnXhX0wNJ/SchkoaLpTlnt9nLIsw7Xw=;
	b=Vcf9VNi4oHVeaX/E9kYettn+xE2HkeMekUBAz7m8jxAWawVImMompaxF05MT7VUAVqGD09
	EY9yGRfRa5E3HexRQf+yD4Ng16ORCE9XPnMJSOYkU5HNuihzDlF3lWD78hpWjV5QpEAaIq
	22ZVHCszbVvXOXhaWVczfVBsVGFL23qlt/5ASmqDAHmZ5y9j55E//Yg8tNmU0tDrnTVXNi
	mkjw0GXvDmASHLZy8luNQtpoccFlHysn7tlseV7afxknTDXmdzwVckxn28AaRraUne9JkE
	fmsL6ee7uBSIGk5ak2ttjutCD5flBeT85cIXcCdtOi9H4eqvQJhgxmia2H8cbg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/4] usb: davinci: Add PM runtime support and improve HOST only mode support
Date: Tue, 28 May 2024 12:20:22 +0200
Message-ID: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

I've worked on adding PM runtime support on the DAVINCI's USB PHY
controller. It revealed some bugs in the MUSB controller that I fixed in
the last three patches.

The platform I work on uses the MUSB controller in HOST-only mode and has
been designed to save as much energy as possible. To do so, the USB's
VBUS supply can be cut off by toggling a GPIO, this triggers the bug
fixed by patch 2.

If an USB stick gets unplugged, then plugged back while the PHY is in
suspend state, a BABBLE error happens. This BABBLE can't be recovered.
This is fixed by last patch.

Bastien Curutchet (4):
  phy: ti: phy-da8xx-usb: Add runtime PM support
  Revert "usb: musb: da8xx: Set phy in OTG mode by default"
  usb: musb: da8xx: Remove try_idle implementation from host-only mode
  usb: musb: da8xx: Implement BABBLE recovery

 drivers/phy/ti/phy-da8xx-usb.c | 49 ++++++++++++++++++++++++++++++++++
 drivers/usb/musb/da8xx.c       | 20 ++++++++------
 2 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.44.0


