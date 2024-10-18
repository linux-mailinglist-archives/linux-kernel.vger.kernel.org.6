Return-Path: <linux-kernel+bounces-371838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE69A4113
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2F1C215B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892721EE03B;
	Fri, 18 Oct 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E5fpE67A"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09445189F55
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261504; cv=none; b=RerfE4XSMbShGq4OHnYhTDlUxsgftbs+UvdYV2i4l7JgScf2u0+uZ4FVru+eNTuN8bzFwQe0m+kB+A0Bc//jzgst+38h5qg8+sg42qslya88oG6XDj83JaOPduit0Cro+nadDgnVHabP0tFwqqtCh/KrKTckhy66kTuyW1pIn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261504; c=relaxed/simple;
	bh=1vHVy9hi6vUA/eK5T3wKQkLm+Sb95+8JoCyrN4xYjKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H/VGgBSALkZBjC2+pEKKoyOQSJ8eBolvOLxZkRgYIt+TD/Eyzd1bvg8YuxAF3p0kgCvhrYJEixe1dIojQ97Sf9nNWgXjIG9dKTa6VSVWDWhJhZTixAvRf3rHouebXRhAsFOCWJHopomAlkQkm7oMij+iEL/pqUYl7uFx2PivY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E5fpE67A; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608564478bso19062821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729261502; x=1729866302; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2B9vhc2SFVP3CT/mLHkci3az6bQEYsfmzgWk2Lo2Lw=;
        b=E5fpE67AXktyruaNcDrekfDEGylGoVcwrTrReRM/dokcLy3OlRHCE9nGcuZ0yWks2P
         JZqiVNTmHLU7pdtd0KosW7/ueKM/4zGYKPWHHhdqsae0x+LAJUYJyF8R3p/actxxO5Bj
         rMlc524RETM4vfegEuARABOJRStacZEHZRR7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261502; x=1729866302;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2B9vhc2SFVP3CT/mLHkci3az6bQEYsfmzgWk2Lo2Lw=;
        b=nhOcFsd+OOFO1p/a42MzXQKmSU2/JuCxpNxOFuFWvs3Q1NRee0N3zWzl8Hovfb6whk
         oTgTcZgJ6q1X+4gB/KtypszQPsldpFC/UnXpr6Ft/QpBStL3L8ZHnAoFwWE+i7FZvFwc
         fTXYeYYIUUXP9+9aHSjDOmrZu1grI7Ayt0R+NfszHZPKpwZMwa5qkO9bGic1T2xJkA1e
         ry0ICpA9QaIxWWE+83z5lPLE+Dal8J2/FD2uJGnnoCP/Ckbpf6GNOFTlPkfYez+4d213
         aysuSuVcICjPhtBy40qqSS+Ic2TZkHcofMylR6XlZDC9qMfuUmvX3pHN3/6LD5qDpdZL
         S8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUJIglWV6RrZr8Q87gj71DL0en1qyOqQcPhJi9+gOoLw6pEKLOa2FQ00BRhSYvidf5/hg61NXNwAuAxpjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHCay16wfb/MEUepq4SFV7qaoRBU3VCnRIiMYesQg/AoSK8h3
	fOfm77sNkyuveywEOdDvdPT6EWub5YB/J8vhKlJ0ZQbExBrndocgMjS9Pneq3w==
X-Google-Smtp-Source: AGHT+IHDGxra/LweNKvZFVWUD4hpitjKLmeEVaZjlfP7UeY0EwsgTk0wfCZVTGsM8eLhvrIywbSFWA==
X-Received: by 2002:a05:622a:1790:b0:460:9cb8:9d84 with SMTP id d75a77b69052e-460aed5934fmr40485081cf.24.1729261501759;
        Fri, 18 Oct 2024 07:25:01 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460aea455f9sm7596101cf.64.2024.10.18.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:25:01 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 18 Oct 2024 14:24:59 +0000
Subject: [PATCH] media: raspberrypi: Remove redundant "no IRQ" message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-rpi-irq-cocci-v1-1-b597595e98e4@chromium.org>
X-B4-Tracking: v=1; b=H4sIALpvEmcC/x3MQQqAIBBA0avErBtQEZKuEi1kmmo2WiNEIN49a
 fkW/1corMIF5qGC8iNFcuqw4wB0xnQwytYNzjhvjQ2ol6DojZSJBMMU2MfgODqC3lzKu7z/b1l
 b+wArjufeXwAAAA==
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

platform_get_irq() already provides a error message.

This fixes the following cocci error:
drivers/media/platform/raspberrypi/rp1-cfe/cfe.c:2326:2-9: line 2326 is redundant because platform_get_irq() already prints an error

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/raspberrypi/rp1-cfe/cfe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
index 045910de6c57..4e99cccd9a20 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
@@ -2323,7 +2323,6 @@ static int cfe_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		ret = -EINVAL;
 		goto err_cfe_put;
 	}

---
base-commit: 698b6e3163bafd61e1b7d13572e2c42974ac85ec
change-id: 20241018-rpi-irq-cocci-878e4a82ea2c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


