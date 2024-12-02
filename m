Return-Path: <linux-kernel+bounces-427146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7769DFD3F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33777B223F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EA1FA825;
	Mon,  2 Dec 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="WwOm22q8"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E501F9ED6;
	Mon,  2 Dec 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132013; cv=none; b=lsQOFZmqdxMFBVUFeBefA60miLwEXnma65l3idpv7bl1Qs4NyKgAFI6VO38pxwPGyapqBDL5LISlwX13mgsQ1625uxeUekoOlOnBdi3Q8On+W4KyyH79vehsOnD3Yq9CBbWYLQMcCbJVbxmD851Ki9KZykMeZIZbF2+y1iBhIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132013; c=relaxed/simple;
	bh=q2/TuG7yKFoXdzqKP1wUj20VwhQGt8DvFdTmIr9B5Rk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y60sU1hh675Vb1DZLVyPvJPHK6zILSLEfJYevpUmjVgKvtz38B7r7MA6sGgFePUUuxKb6WVuojpaRBqqGBBMzRnMSdf9PXrxSxPKaqSGLjs2nVjw4LlByzcVaDH0RpCPG06uEbLwW7yzMFgfvjm+a4aebrIKpapN0BBUj+xgZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=WwOm22q8; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D9276C1ECA;
	Mon,  2 Dec 2024 09:29:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70E006000B;
	Mon,  2 Dec 2024 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733131787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aQ9gQ9NLx3YeYEp9py7HHOqXOZPX6LMc5xcGC9kUJ1I=;
	b=WwOm22q87uDJ7L4LtWTIgErGu8Gee49gZftFWMs/hM0F3EULHt2TT5fyTTCNk+5EdzwTCs
	Jyobnb1wYfyDJZIVfYRN7tv7IWSoQ+Gs3SKQVyKEA3qcVCoWtzcx/Yu1pbBdgGu6fqagIE
	jOMVYXYjhpZaXKNaXmkc+9RUHw2OpoqfVIqxI4VQV8Dqdt6ZT5hDhUbFJ1mEvbBER3qZdP
	mj6OYPCls8s8JVMsj6rwpe8adclXS+92dnLV2BSA/qDW2MP3KQP81AiCLpamnKfM1mIGR/
	In2Nnka0uxnZBG8VU415yRs5elSdHd/R0SsoEZ6/7DVW9WuBXKIm5Lw4JkKo0A==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH 0/2] m68k: Add DMA timers support for M5441x
Date: Mon, 02 Dec 2024 10:29:25 +0100
Message-Id: <20241202-m5441x_dma_tmr-v1-0-94087efe4243@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV9TWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKGba2piYlgRn5KbGF+SW6SbYmlmmWaSnGxskGihBNRUUJSallkBNjA
 6trYWAK9JNH5gAAAA
X-Change-ID: 20241202-m5441x_dma_tmr-d969f4cc30a8
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-m68k@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733131786; l=1090;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=q2/TuG7yKFoXdzqKP1wUj20VwhQGt8DvFdTmIr9B5Rk=;
 b=8LBi/g4xFgT2gUn/Hbp3XmpMSHOk0kdHPrWpjk2+KFkjJZi5CPwOTNvvKCd736I9W/wUbKWqy
 cgyqZxX+3nlC9EXyDAbSYFteZd1/T5hanx0BUcDqJbhfRr1ZiotR9ci
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

This patch series adds support for DMA timers for the M5441x coldfire
family. The aim is to provide finer scheduler resolution and support for
high-resolution timers.

The first patch fixes the clocks and a typo. The second one is the
timers support addition. As there is no device tree, I did not use
TIMER_OF_DECLARE().

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Jean-Michel Hautbois (2):
      m68k: coldfire: Use proper clock rate for timers
      m68k: m5441x: Add DMA timer support

 MAINTAINERS                         |   6 +
 arch/m68k/coldfire/m5441x.c         |  20 +--
 arch/m68k/include/asm/m5441xsim.h   |  18 +++
 drivers/clocksource/Kconfig         |   9 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/mcf_dma_timer.c | 240 ++++++++++++++++++++++++++++++++++++
 6 files changed, 284 insertions(+), 10 deletions(-)
---
base-commit: e3f432391d55ec21274bd16a04659b4a24678535
change-id: 20241202-m5441x_dma_tmr-d969f4cc30a8

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


