Return-Path: <linux-kernel+bounces-326666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FA976B81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8444A1C20FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF321B1402;
	Thu, 12 Sep 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CFX2wCDr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="U42Kzqwa"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988841AD255
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149900; cv=none; b=aQXhKC8BGDNbMzBY/FTrvAVshKjBQmHs85KVgXpXdhWcc4I44XTrWZtGccbIyrvnX9vSLQALxUseVpYRyaMKizxZNxa28hD5QUsYPi3bSMk4F5HH3lhtzcLS1jpOcyWqgxMr8ZGsJtdSS9UBDGVUW7yv0n/3Xj3TCq/q8MWxlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149900; c=relaxed/simple;
	bh=AzwnHGWkK7VpKzbfuRm2kSQvWcgMhIXD6o4S1W/KhIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I88I0U/Cbj9xpw0/hET+PLOSRy3cdvm2k1aY429slTEsPEgHvNOEqT3x1dTgDPwmSE/y/3oWqAIXYSZuRw+Fj8v39CTyazAITQ0n+wDmtvwYcLhvPatQHU3BnA3fNVlIcUS60VtdZH7AHuaN3PQ97p/yoktnt5ajFA2lhvufIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CFX2wCDr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=U42Kzqwa reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726149897; x=1757685897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ogz/oRtxLj6jNr4AfJmwW8w+miSpO1LWWSgYthfG7Y=;
  b=CFX2wCDr7xDUxFJYSMmCMOX/0ZRBn//fg1ALNCQkgtklY1Cll8lOMx1w
   uDu+vRBArK2087fFngkKB4uerzs+1QOcRAJU5OZlT6SqJTFa7aUFCvFaa
   j5SLSDhSOInSTi7eINr60cMwzwpYnRCgg4yos1R6iZothfiq4hLDPsU63
   LARufh5+MoC1LkEJ6wJ+tmBsP3KMGarHKeEee5xOasNJtJpHhy0gU8P31
   4xMoCLfj455lq0pJTpVyEZKUCyFgluky8OQe8g7nopeDFycAhb/JmLElb
   uWwCzTJi2o6TqSJqynSR+mFHm127YT3iiWy+UxKcnQK4wHlnnTGFgIuog
   A==;
X-CSE-ConnectionGUID: /3Hf7wGSR62KpcVpgAo8Pg==
X-CSE-MsgGUID: jGGTV27FReW403NnkKMivA==
X-IronPort-AV: E=Sophos;i="6.10,223,1719871200"; 
   d="scan'208";a="38915414"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Sep 2024 16:04:53 +0200
X-CheckPoint: {66E2F505-29-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 2264A3C5C1646C938DB6058EBB6FE075_0
X-Control-Analysis: str=0001.0A782F29.66E2F506.0021,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86A6A1650D2;
	Thu, 12 Sep 2024 16:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726149889;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3ogz/oRtxLj6jNr4AfJmwW8w+miSpO1LWWSgYthfG7Y=;
	b=U42KzqwaZkEy+nyIK7B3OllxmxxtJYwZhNMozqApV9Azo99NxdAHT4l1LX9XdKu7gme72y
	WUlq5hKIQvRjgZT3snfjdJJOi3lgquvL1YcNb+JfIPknwNqufWc/eEoOAf/y7uy+HcWThd
	U+vj2ZyWy/DQZEH1QAn0S18Ky2QBfPqXAPMd/UjH3I6WhMgwNpycsd6MrcCYqX59XOh6ZP
	sdT0AGGtWJdyWuzJ8oZ4CVT91VrYPS1/zL6dfHEfG+i3p9tYOAmxsD9RHpTPhfbqFRTumA
	ayct3ugzUxJnbJGtcQ0yOXrS5U6z0K9eQn9JV6nr8okFHNVKw9Ftpl9cSZ/2aw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 2/5] mfd: tqmx86: improve gpio_irq module parameter description
Date: Thu, 12 Sep 2024 16:04:09 +0200
Message-ID: <7820e3881bcbe14557887adee625289e42041c3c.1726148801.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
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

