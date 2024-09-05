Return-Path: <linux-kernel+bounces-317923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07596E594
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7021FB23A74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788E1B3F05;
	Thu,  5 Sep 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qRpLy/JU"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B81B12CD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573807; cv=none; b=HKXaBu52weXJFddLOT/kgAzXNeH3HDopWsarEJFKVVQjBCF08eFU3tIcIeYjC9r0QUvvZ5LeqbNqDQ6WbWjcczNvDzDfmfE5/P4F+VeuzsOXY1/mH7lIg2fbGSrshdZM8wmr6v7GtZV9nfT8LD35repF625uGawuFrquUT3BC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573807; c=relaxed/simple;
	bh=19dVWBfAz2qQyZpfPFRGd9UeDDF7grrhUskEDkVzmzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJu5fxg0hCzeKaLBiy+aNVvzCnXQH07+vBGJ8i1M7QFGKWTPbSYRYDCMHHcePbpJ7hMjVnKjZAZ5wasNsuiCreCIR9OfDylnh5Gg6RMxm0aWz/NRV1Nkd/BTNvYyHkrQEe/Nlq752jNepMjmfAxp5cLpDRYfXMlPTXojJziS0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qRpLy/JU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so1017428a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573805; x=1726178605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGF3ZvR6Fk1EmILbsDBIodK1mVWIH3FK2lGT48LkIFc=;
        b=qRpLy/JUO7HI7kozWpdEFNvConhf/2e6PUOrULTrZ8swKv6Zn31hRMP62Pjg34MJgU
         nZAJPuftKFpEavQYFINdc0KNA37iQXeNeSeAycwAppjDyLFILldynUnwvpj4nayq6+G3
         X4mGbWQJ4iycm5+kXEYuwtAgSSyVvprhjqcGEcqGkzKru/BEDkJOZ0dfDkPSmY5XdOQP
         J14dM+mXbeOL2LuGlX1Yj5+5ebOtrKGkXUvUVL7vh6ViRwouiXwmzqYppZotY0GgimzQ
         FreivmfUvtBiMUPrRJAw+oTPfbFMoD/7V1IGT7w2gDzXidNUUQlN2DFPx0pmmD0w/bYN
         l3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573805; x=1726178605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGF3ZvR6Fk1EmILbsDBIodK1mVWIH3FK2lGT48LkIFc=;
        b=FS3dy5IY7QP5Qnn57v+smsT++7OObiq9yutYtSFWVdoNzHhbLJNWYpmSKQGwC1GJ73
         QyRKmj59pdieM6eS/LQs2g0wqP72VZEOTC3jfa/+PCyW3ccCPRfWZcuK6cFhZmD8oq+T
         SgEqiFqOKxtvFFET7ONVvjhJaxUGLZDhYXyja8UoBrtu0MkEAP4QKpMIOhL5r1cA5+u5
         mJhtAi2D9LaDakaFeK7SGxP4G3lwCbwmA+d1Zn5TOW37h3mgmM77GuS3aeH/3Z9O3e4I
         1NxqrnGTlKct0kkVY5XMfRuzJPFaOopz08fNC6yrWJj14NHxwlHr1jUORibHVQvMwbxu
         f1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjHI9G08KlAeE1hGuZ/L1OK/z548Vnh1lTGgogyfyQcsb96gkZHvPrxd6IzYecUN4HaX972iHOYnozjGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7A3BFNzsS1h2XdleBuEMsIfubIUI60s4Wghq7j9PYSc8Wgjy
	J+W34691ApDP21qjOJifEK00IFeiwS4Z6WzgCXOiyWgJSEzGYgo/lKV9MScfpC7vCroAljCaiKg
	pEcg=
X-Google-Smtp-Source: AGHT+IEEZQJ3BYRsD9DEp8JNQ2/hJbu7/Bjm8uuHapoacYf7CN7DfNZaZ1J2hXEGctMGI+oUfBCHvA==
X-Received: by 2002:a17:90b:2315:b0:2cc:f538:7cf0 with SMTP id 98e67ed59e1d1-2dad4de4cf2mr938741a91.4.1725573804645;
        Thu, 05 Sep 2024 15:03:24 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc110c90sm5156a91.41.2024.09.05.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:03:24 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Thu, 05 Sep 2024 15:02:51 -0700
Subject: [PATCH v3 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-lpm-v6-10-constraints-pmdomain-v3-3-e359cbb39654@baylibre.com>
References: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
In-Reply-To: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=19dVWBfAz2qQyZpfPFRGd9UeDDF7grrhUskEDkVzmzY=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2iqp5OPapR5bQHp7ItAEA/sVZFXbOQcpAExfx
 4p/eKOdq/WJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtoqqQAKCRBZNxia0/vG
 Ze+kD/9kvy4WEnApYeODVoUBr1Mgsmt5CwDgDFM8VvblBDeepFM2EET3Dx2SlF1wzOh5BhlfFJ5
 N8AOOchs1mCxPNBao6sIHxiShE+aKu5BFmcvJHGrvaPoxkLSvFYI9Y4sKUCmg9jlxkN/cbIEhGr
 1OsJpFaZaXZDEzJc0yj5Xk0Vym9eV6F8wpGCtZRj53XSXwizvc7oL3kVXasfokc80hNDdLo70fH
 eJ4TSihviTqFEEfNSPfp1jPLwRTX4vYoxAa4OgdVeyWINN+9ActgTmrX85VuG6rbqg7aDAUluNA
 btUoLoiEjTLRAxLJhLpVY7fE9PhygcTXAaIbS6GB4R0E2mEIEP00F92Lk9KuCV09SKLcIhrc66x
 poPC5s++GKwQUUGJqIf7Wub8Q5gp6msOeZYkTzCgPlj36usjFLdPQKMYHEkvw+CxVuIazRQUeHc
 7SGlKiU1rU7Wa6rwvr5olf5krLoUipV8dDFiEu3YGkb0tnLKGnbi5npa201SBjnxmCI9IHjm6kI
 cgFqsOOFPM9sgDy4YYfZYPwhdJlehRsq2kxWNjxyqELEpF5NZRG3BjS8Nd4u9y8YMVxZjmbdQrZ
 /SwLnGzrdUXfGOp3L2NYwnTPAmKCxb+vVXWDWwSyu/lUDxcVmyP97+HTjnErXYZCWN1fNt0Mq2m
 OJhwciWUdKdq5og==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

When a device supports IO daisy-chain wakeups, it uses a dedicated
wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
wakeup constraints since these can happen even from deep power states,
so should not prevent the DM from picking deep power states.

Wake IRQs are set with dev_pm_set_wake_irq() or
dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
when the interrupts-extended property is used to describe the
dedicated wakeup interrupt.

Detect these wake IRQs in the suspend path, and if set, skip sending
constraint.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 1ab1e46924ab..747a7a33c0a9 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -82,6 +82,13 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using IO daisy chain wakeups,
+		 * we do not want to set a constraint.
+		 */
+		if (dev->power.wakeirq)
+			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
+
 		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
 							       TISCI_MSG_CONSTRAINT_SET);
 		if (!ret)

-- 
2.46.0


