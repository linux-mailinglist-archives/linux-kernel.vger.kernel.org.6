Return-Path: <linux-kernel+bounces-352936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0CA99265C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3051C2244B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B2D18BBB7;
	Mon,  7 Oct 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UCdxM4z3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nsQQT/wh"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD67187350
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287396; cv=none; b=SsvnxEP7CRID6sHzTkSBMC1MAXCgaTD7XWxO9p0qTWGI11TsTBDSkAL+O7vDKk+w0y9ykkBT7i7HX8/FSAbgOmi0MOYU5gQfw0OcK7LvLwyZdHUZ+j/mE8i0V/EsqLMe2veSADb7zXdR8e6AYp9chplfsdI2PlaShFhr79tVFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287396; c=relaxed/simple;
	bh=t+SSc58pRa9dF96eiAENXfn6+7v89CEiXLw9/jLcoOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3937KFrRA8CNtQms1Q0yZwOJXgJ1gGOidHd9l292ETNmqe9cEXY3Zx1E/wQI22Bmsq9Mh9m+CHc0cM/DO1201fnpiG4TSCyknbivifNqupXKbweOwdVMjh63vbyKej2MB82RfPfTrW16N2u5A333U4RKKhLY0FDiFElBazrhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UCdxM4z3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nsQQT/wh reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728287393; x=1759823393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zjq6/mLElLzForcfEdP7JJAydMypWN/J3ts8pfgq4bY=;
  b=UCdxM4z32SmqK9W/ZBng9taGHO4mqGY43JipLT+yNbZ3V840K6t5uVt6
   5X3Vwh5gC90A/2OttAULFLRxFqr+eMfYp+om2HxPZ3Gs5SlfbDpSbe08A
   ZtilfOzyBeVZtqjS9g9aAcvXHoo1LyAtC3At4CLI2m5Afr7zAmx3RMvSu
   5u8EV0u2aLLeRqqruoeHalUCTIjJJSfQecaId+5Xvvuo96jfyM4aLwoco
   HHUnKqnM/zzE8bgwPsp/No0rT+ySK9T8qhfI86EVncL7af/EfHPkQlI3z
   TODYdyjGS6Zao4CeSKPWKcrdTOiJl1uBDaA3eIw3DHwVO3mr16T+8jLRP
   A==;
X-CSE-ConnectionGUID: bdTunqN2SUCQUzsR3ZWF+A==
X-CSE-MsgGUID: d8bTec5eRCKZKTcSewTdwA==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39297574"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 09:48:48 +0200
X-CheckPoint: {67039260-3-514F5986-FE9EEFAE}
X-MAIL-CPID: 93F41BF1A8196A682BF9D7703E417665_5
X-Control-Analysis: str=0001.0A682F28.67039260.001D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C5A016BD2C;
	Mon,  7 Oct 2024 09:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728287323;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zjq6/mLElLzForcfEdP7JJAydMypWN/J3ts8pfgq4bY=;
	b=nsQQT/whKreqMqcMHIpUm7Xyw0TwYeSUnI7n6VZL/q46lzMlH6Dh3TnqvU53tVXXYLRu/r
	RTjj6SC8KzLDE9O8zExGwtjjzhF7OBIfBomFsCosEMjiCUaEV369vmiuzMRgV7HdX8QKee
	xWAPVTGul6MET/jriBQ6D6jwZHc6zSS2UE6Fu1yMIOn21olELOrDqBFpwjvHOxNIwKkzE5
	GDhtyKseI64EE/DQbPgozkquMWNSPZS4tzm1w7KYDwjPqd/g3PVm4pqx3/fdCuRZKwjrra
	Fn7leJVmowiKluvYBVZ96JZ0XrHrX02tuhX0hryzHO7Emmh0laK8qeVRA+GSBQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 2/5] mfd: tqmx86: improve gpio_irq module parameter description
Date: Mon,  7 Oct 2024 09:48:05 +0200
Message-ID: <fc552b4e7ab11234a6874eee9943c3b64bad4bcc.1728286453.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Clarify that "7, 9, 12" refers to the valid arguments that can be
passed as gpio_irq.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: new patch
v3: no changes
v4: no changes

 drivers/mfd/tqmx86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index e15b9be98c2db..7b2f9490a9af5 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -58,7 +58,7 @@
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
-MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
+MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
 static const struct resource tqmx_i2c_soft_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


