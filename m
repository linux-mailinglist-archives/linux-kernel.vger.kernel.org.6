Return-Path: <linux-kernel+bounces-219692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B990D6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3C81C240F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0424B2A;
	Tue, 18 Jun 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HiQ4hNJI"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFB208BA;
	Tue, 18 Jun 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723394; cv=none; b=W1a/Wbpmp53a8wg6uJIOdAZ+NLV2eAyECtDmmpIkHaoRy2IlOxZB2w40HYMiJ1eGz453aBFEcGMWbmujS8Yuo+Vjnx9o79zhgcuw8HXPGDM0lHsM49dbbJ/1IzZWEOIPRFujjaz49oyunaQpq+ZzsMvY8XdumabhrwsdtE2TEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723394; c=relaxed/simple;
	bh=FtRHPEELXzbBNbusRjT6BdeH09HCW4axG1q/xSJBRrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Js+yUtMvqKUpELgZmTS9PhxMMFDLk/kRNfEqtU8U1afDFeGHUUVU7bhOFm2yyOV0qJIgi+2LGL0Cf2Ck1FsS66vHKMQZi7m/I1scQ1ryKywePEmg5rtoUM9FkKMbRHdUZQ6TlwSSn1PQqx08ABtoZb/HFT3e8wAvOr6RbV9AZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HiQ4hNJI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0252C0008;
	Tue, 18 Jun 2024 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718723384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f94KqMTfRjyJVz2Jo80eGqilFXtXAUqV9bBl+sW1n78=;
	b=HiQ4hNJIGi4KmoZacpS7F3XDJ0V4U10XkSgc3dQOT/FNjpB1HrMok629SYgeAke8bD8Frq
	VeAo41WBGLbNniRjgfayTxe4ItXxtNcCLJNp1NJvDy9wqmrZG14Wn7qKEGvQDhSEK0M6cR
	zaxTKbij6JszKtQHTjvq7T/M7zmDG9axeyz8/oA05UzfHaoeEeKs0sCaLsP5BhTc0faygj
	38tgERpIwaN0JadIjMYmF2AD0/9IiXPfb78j7vM228DWrhovd/Fmh2iBbz76rW7NVAe2aN
	yXVrOzS1Oqp0H+GiMZLWNwgsd6XdPHEn3nl0hGx9IP14YcXNlKOkCPLLx7pC7Q==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 0/2] fix TISCI protocol URL link
Date: Tue, 18 Jun 2024 17:09:31 +0200
Message-ID: <20240618150933.1824185-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

As the http://processors.wiki.ti.com EOL in january 2021, this serie
fixes the URL with a new working one.

Richard Genoud (2):
  dt-bindings: ti: fix TISCI protocol URL link
  firmware: ti_sci: fix TISCI protocol URL link

 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml  | 2 +-
 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml     | 2 +-
 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml   | 2 +-
 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml | 2 +-
 drivers/firmware/ti_sci.h                                   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


