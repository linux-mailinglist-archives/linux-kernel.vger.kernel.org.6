Return-Path: <linux-kernel+bounces-310077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F98967481
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE07B21A8A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2E39FD8;
	Sun,  1 Sep 2024 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZjB4tqJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8D3A1DC;
	Sun,  1 Sep 2024 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725162163; cv=none; b=haRdHNTK63yaa6C+hK6sDYakSNKyJs6mfRGToSTujdvnzUd+UmpB8cWiIu5iNfv9rgWBRz/VvdMPnu0rAakdXPXaulWA4W0+8g106qc58DOgWSl9fFtuOAfKjDkBZ5WW9nMoZh8xAo215mc0KUnWwGIj/Twh6Z+anE/UqVlWioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725162163; c=relaxed/simple;
	bh=/O+xoU3YukFNUl7NhIeid6XseqUUuazw4yq/PqekXOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9Vuorc+Yhto0hwXNEcEYKHbiNSzl6FGy8CCSbDn2Cx3w9Vchh5trzgDCpSvOehjaT4/LqeanGTZHrH6YC3pr5yBWgUP7hpN8f9kBa2eGzTc4vi+K4+3s0FvshdbXoSFwqGJYcD4/RIzBl16FxlMJdrwa1GAmFOPeKgmRpHY/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZjB4tqJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71423273c62so2434279b3a.0;
        Sat, 31 Aug 2024 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725162161; x=1725766961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X+/CCCJdHsPQtIkli72FdNOUA83CpBm1xJ/DRLJla8=;
        b=GZjB4tqJhVSN1OPEsjiBo46uTFK7WSkItfDvFg7LZQGJB01osVVE6H+FNZh81/g/bw
         k6bKGra90Oe9Tblk5ohsQ6RiMAPGzUGFb6yGGfCcaLIXUZsxMqr0wYvk9ehej4izXQE6
         I9rD4SC8mDcL+YnV5vXU20GvlfFJkw2z0yymSmeKF/2MX7Va94lQQV289VKbkP7KW7zC
         x+mc1e/3V1obhQNEHQyAJhEJwkmRnJsdMaDjhdTrqWCCIMiHTuUThSIeYkTJTdsKvS8v
         mFmomk074LO5Ov81KImkk8NZ6GzAwrqKwXSugq7nDhT11Mx60m/TGIGEv8jV3x/Xt+QP
         W/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725162161; x=1725766961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X+/CCCJdHsPQtIkli72FdNOUA83CpBm1xJ/DRLJla8=;
        b=G4u8ODwtVBCfB5wJDQ8D694vFX2BxokPZW8vg7oGP9A5FN66iWJlwTXPZJc7pV3Ikt
         JpY1d1mjygaagTzj2HojgQJnqfgj7488YUqcqkBze7gpux48IsYuJR3eogzXxUOqmSjn
         a3vvCicXQtQcBb76NV/GopvOLL/tZeUQnU6Ryy4UwbBqKk8Fkx7jYQ1pf0Y/qwJitvm/
         RfNV3AhSL6Eizp7/zjX+HbjUDXguVvB7n4tKCAq8PwrNpYF3ojz9TfWmDcV70JShTFNa
         2pzc+0EySP0YgeKj4MrF3Tfr7i6KwkAXLkCF47CQWc3aoarcB5Rk7boqrR5mCGBp4imM
         2Lzw==
X-Forwarded-Encrypted: i=1; AJvYcCUkV1l7M1pvaJ0oTBvuvq+KC06/Ob8KhgayFLahsPJwCnzamRIyM9pjLiz29OoE4eQDwLnY++jwIkzm@vger.kernel.org, AJvYcCXNbdjJFH8msZNAODax7jGGMiF55Y+r5C9yawi64cAhsCqn9FTn/G76emGcAG0dKvaNlw68fxaLZkg1kjYr@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUNHZNFl8T1MzBLQ7zk/vhI8Qk9xJtg2DlnSWEQL14rhrVoex
	1gmRV3QN5h0xEEGuXNAuHij1XKwExfffaj2KUJ/Q/Ni7nNXghYnq
X-Google-Smtp-Source: AGHT+IErgWsZXv7smRglnCflkeOjudhULFolSyci/zrSk+ZWtbqCA1BERr3NORnUsdJcn5DSCwfNaw==
X-Received: by 2002:a05:6a00:1786:b0:714:1d96:e6bd with SMTP id d2e1a72fcca58-7173fa7c84dmr2181901b3a.13.1725162160903;
        Sat, 31 Aug 2024 20:42:40 -0700 (PDT)
Received: from localhost.localdomain ([49.130.72.113])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55771ccsm4826767b3a.43.2024.08.31.20.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:42:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	konrad.dybcio@somainline.org,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 2/4] irqchip/apple-aic: Skip unnecessary setting of use_fast_ipi
Date: Sun,  1 Sep 2024 11:40:05 +0800
Message-ID: <20240901034143.12731-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901034143.12731-1-towinchenmi@gmail.com>
References: <20240901034143.12731-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use_fast_ipi is true by default and there is no need to "enable" it.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 5c534d9fd2b0..8d81d5fb3c50 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -987,9 +987,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
 
-	if (irqc->info.fast_ipi)
-		static_branch_enable(&use_fast_ipi);
-	else
+	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
 
 	irqc->info.die_stride = off - start_off;
-- 
2.46.0


