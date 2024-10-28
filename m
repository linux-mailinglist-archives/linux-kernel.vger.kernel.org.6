Return-Path: <linux-kernel+bounces-384045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F79B2394
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406A51C21162
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EAB18B48B;
	Mon, 28 Oct 2024 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="isYBWge8"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0A18B463
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086790; cv=none; b=XBKqZXjDFxBqyECeVRS+2yULUBgZr5uXex5HrCQswEBfQcc9Wyp/4KDgg8tTbhD3xvNFFv7nlkuwNhL0VCz1jAP0VILd4AloZw4wESRCCTk+58WOFNN/h49xSEdh2+LwF9jj/UCIRpC37qPKETYubwfjce21GZYOOsJ3U/YVbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086790; c=relaxed/simple;
	bh=KZDYF/jddIYvikTmAtIIGcfQR++5pOmWB1T42u1iP6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANjqSIsgOtVUaEHKZUflCLp7LuEBQrchRNM0VHFwG6/6LKrzVHpZ+TUir2tMCd+riRucvS6V6Z97rLPlZT13LHa+MfMFLdx52WapMeEA9kvl9K8okG7HhoKknU7TXwPZeJ2AysILHemj2beMt4T7piBPHuuZeBc9Vl5Jy8r8mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=isYBWge8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so2854711a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730086787; x=1730691587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARDip39wIVC1qk/I+1tz8/feGtYsfateMnYyYJ2nUtE=;
        b=isYBWge8LIdvrm7FIYkezvG8T+pxsE8EX2x48dmBcUUFNweE3nGhpS64P36Tu9f5Zo
         b37IqGjHFaKd+cQd+ikjHGqxgb1MPbX5hcb6jx113CB0fbySStSKxFDi3aB41OFo3C38
         WdHwkRfLp8So9vklWC6OSv9YpylbBDZ/xtjHR9vHja97TYzFz26LaDVbJq764x7plm9h
         X1mI4MWKgTwdAeD+ULTJ5ppEJbneZuu11uhngex7E61fOL/WyZI/Vu8M4QZ4PiGgjjah
         fd1Vob5lCNxShUjqqUhDV1w5kQaIt02YEfWry+qeGKwosyCin6e/13xqkRT3lN2uW91b
         Smfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086787; x=1730691587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARDip39wIVC1qk/I+1tz8/feGtYsfateMnYyYJ2nUtE=;
        b=H9Kek1eiZ0RgtgQRuX5+kyl/epG9vaSPk6ojNGoh6wzrKgGtQW+BUR2PnojI07mriN
         cH2WHAcMopjwr6UY3TADWiOKI8ttq6ZbFDb27oqUm2saFhc3am6rh8xagU3iRQWmCKMp
         a5SOB6p7NAPhX5xiYa0gCWKoa4xTbj1U0SuGj8+nAgnajZle0Vq6hXEqEbv+oV47014K
         5/8ZKeMUm4sRnQvC31tTrYroXHgdVU8msTDdKSdjTL+smbn8KYzORpHGoLRL49XrsOwd
         axCTx7Rn+nJEfW8/TWnUlgTfVnQJm8yVh9gjK6Ro7vga1JX+eoeT0JZAUeYh2Vz52Zbo
         DAkA==
X-Forwarded-Encrypted: i=1; AJvYcCVMIMBhs4qkyjUEieuRbZvdMp9ornGeBk8B02aD0stIOnjEUsDBhe+Ro5yCjYl3MDuELPm/YL/fjhg1fS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+Udq7TcPFxsPSnX8Fgwwlzn9BbagxbZ6VJmgq4p34vKkFE5k
	Z4Dj04lp9+3emjZ6T5V5BenKv27Mknw/GENvvmcKyhYQ8d4IFj71H2l99O7jSXo=
X-Google-Smtp-Source: AGHT+IHaM+aLcSm1w4qstTcoHx8cZ8OUu/YAd0POOhZWcxfHlNfvpu6ayZbkZQqDbe3fkAu25t7G5Q==
X-Received: by 2002:a17:90a:b109:b0:2e2:da81:40ca with SMTP id 98e67ed59e1d1-2e8f104cb14mr8132454a91.2.1730086786918;
        Sun, 27 Oct 2024 20:39:46 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e340e544sm5961888a91.0.2024.10.27.20.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:39:46 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nick Hu <nick.hu@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>
Subject: [PATCH v3 2/2] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Mon, 28 Oct 2024 11:39:26 +0800
Message-Id: <20241028033928.223218-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028033928.223218-1-nick.hu@sifive.com>
References: <20241028033928.223218-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop the timer when the cpu is going to be offline otherwise the
timer interrupt may be pending while performing power-down.

Suggested-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 drivers/clocksource/timer-riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..166dee14e46b 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
 	disable_percpu_irq(riscv_clock_event_irq);
+	/*
+	 * Stop the timer when the cpu is going to be offline otherwise
+	 * the timer interrupt may be pending while performing power-down.
+	 */
+	riscv_clock_event_stop();
+
 	return 0;
 }
 
-- 
2.34.1


