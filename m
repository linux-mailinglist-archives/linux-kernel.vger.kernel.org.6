Return-Path: <linux-kernel+bounces-427147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A99DFD40
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C424FB22F87
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178D1FAC4D;
	Mon,  2 Dec 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="WLHmGzy6"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF61FA169;
	Mon,  2 Dec 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132014; cv=none; b=LXh2vD1MJiMTcprVJjDruftUhObYgIc73Hmv/01FrOYWP/Q0voxIMDoh//Hipo6ca/rXyLTUwZPthB/8ZsY1Mq5Pu5uO+RY6eOuFqwdJ9WHVLObXJmx70omBAq2l8z7rVlmIcZNx11HfGC1iV1AR3BntQoUg3A9meBwJrefXPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132014; c=relaxed/simple;
	bh=dXv9UMNqu6BeT3cBWgSYEHVcvEIHnjdQA4VyGo4K/QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YV8wWNU3+UN1zZGkohM5NqSypb+2mcayR3+XWmGlhagexbexHYnKobCrhFu27t2tXy+WMlgn53bmtGfKu4fREyTjS5cYxyD+FMhuRaZWhfihI1yA4yWVTzfdA1rwiX95jGoAhmNOX0nBYqbBba7VF0Z4xixi5Ro7Ij+sfS43HjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=WLHmGzy6; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A9CDCC1ECD;
	Mon,  2 Dec 2024 09:29:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DF8D60011;
	Mon,  2 Dec 2024 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733131788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWb82E0b51yZQ/7U153TCkyyUUcuJzNrMgO0GHxp80M=;
	b=WLHmGzy6DDgGxfCi3dDRmltNajmNXNF8XX+3wL3fG4yWQHuE9b12QH3NRYvXkI9h7PMm4l
	0HPnbKWQx9r7Xiedqx3f4QTYwCCNwVGsh3hh6tbBVgd7R+ry2Iq4Vz9LBzqx70rHR1jUca
	a1MxB4vR9kHAU7NL6jeStQo2HSIYKxJFetptHD831RZJRuVh3/xsIZnl64iJhVunmsY6xP
	4PmV5Bkk2zbCnddWP/DV/coZS7SIi2dH31wp9YFQ+sC3+f2CB/ZWKguA/TNgrBV9sAI100
	/I193IrRf1ixBSs2OOTFFMp7QPc9q+8PhMHgAgptqLVJzO1BCfM5GD/NkNH7hw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 02 Dec 2024 10:29:26 +0100
Subject: [PATCH 1/2] m68k: coldfire: Use proper clock rate for timers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-m5441x_dma_tmr-v1-1-94087efe4243@yoseli.org>
References: <20241202-m5441x_dma_tmr-v1-0-94087efe4243@yoseli.org>
In-Reply-To: <20241202-m5441x_dma_tmr-v1-0-94087efe4243@yoseli.org>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-m68k@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733131786; l=1954;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=dXv9UMNqu6BeT3cBWgSYEHVcvEIHnjdQA4VyGo4K/QM=;
 b=2HRLiRSME9ccAR7IXB7i8hOJLioXAr9aGqqIkrdNbDkL4o1JSHBRnTTjqJoBss1EjaH8KYhB/
 jeYoxkY8TYTCaj1+TzClPiAtiD64DmVDkxj6f/LXNJ1ugGpSVl/aebq
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

The DMA and PIT timers are clocked at fsys/2. Fix it.
While at it, fix the comment naming for DMA timers (duplicated tmr.2).

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/coldfire/m5441x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 405e9d5c832c0d41978615a646de21f2fce61afb..7a25cfc7ac07570ff15da3c55d080a717cf93a06 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -33,14 +33,14 @@ DEFINE_CLK(0, "mcfuart.0", 24, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfuart.1", 25, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfuart.2", 26, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfuart.3", 27, MCF_BUSCLK);
-DEFINE_CLK(0, "mcftmr.0", 28, MCF_CLK);
-DEFINE_CLK(0, "mcftmr.1", 29, MCF_CLK);
-DEFINE_CLK(0, "mcftmr.2", 30, MCF_CLK);
-DEFINE_CLK(0, "mcftmr.3", 31, MCF_CLK);
-DEFINE_CLK(0, "mcfpit.0", 32, MCF_CLK);
-DEFINE_CLK(0, "mcfpit.1", 33, MCF_CLK);
-DEFINE_CLK(0, "mcfpit.2", 34, MCF_CLK);
-DEFINE_CLK(0, "mcfpit.3", 35, MCF_CLK);
+DEFINE_CLK(0, "mcftmr.0", 28, MCF_BUSCLK);
+DEFINE_CLK(0, "mcftmr.1", 29, MCF_BUSCLK);
+DEFINE_CLK(0, "mcftmr.2", 30, MCF_BUSCLK);
+DEFINE_CLK(0, "mcftmr.3", 31, MCF_BUSCLK);
+DEFINE_CLK(0, "mcfpit.0", 32, MCF_BUSCLK);
+DEFINE_CLK(0, "mcfpit.1", 33, MCF_BUSCLK);
+DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
+DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfeport.0", 37, MCF_CLK);
 DEFINE_CLK(0, "mcfadc.0", 38, MCF_CLK);
 DEFINE_CLK(0, "mcfdac.0", 39, MCF_CLK);
@@ -167,8 +167,8 @@ static struct clk * const disable_clks[] __initconst = {
 	&__clk_0_14, /* i2c.1 */
 	&__clk_0_22, /* i2c.0 */
 	&__clk_0_23, /* dspi.0 */
-	&__clk_0_28, /* tmr.1 */
-	&__clk_0_29, /* tmr.2 */
+	&__clk_0_28, /* tmr.0 */
+	&__clk_0_29, /* tmr.1 */
 	&__clk_0_30, /* tmr.2 */
 	&__clk_0_31, /* tmr.3 */
 	&__clk_0_32, /* pit.0 */

-- 
2.39.5


