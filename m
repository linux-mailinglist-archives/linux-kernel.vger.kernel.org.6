Return-Path: <linux-kernel+bounces-514882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B619AA35CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FD718845D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FE8263C71;
	Fri, 14 Feb 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALXmw46E"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3A264613
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533668; cv=none; b=MTXtssYjGJl1wliM73DMIYAAMJ11E0nwmqGINalNnpHluVEJQBTjQG7ACpZ57LyBFcAOUg5d3oDq7uaYmV7iR21DCOhTKBZmWm1+9bfhrM+SSmdQRxlPbpnhgAyXJiNX9RQcNY87hHCcTdq99JuxwfrEw6kZe1CzJyS2qlKj3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533668; c=relaxed/simple;
	bh=otW1RJyE4F3ikNxsbuQW9V3/snb/w7z5xN/QWk8BC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEBRAQiobroWr2qkPBOI62SXHQlDZqEOTUemMI953EoOUQ37lB47gPeyUCr20zfiy9nRzSryeGqy5gxxeSLdzrc8+VmJIWGDOMBJUomSCiQ1vF9FlL5NVNa61B7JiCkncup0QxIISKlzyYX9ZfGlZ4AfnFF5DGfl/rCCbOxprNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALXmw46E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43965592e1bso14224755e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533664; x=1740138464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVmtBhEiVyNl8QZ1O6tERZVz1PTbfN4nkq7rh5ldJZo=;
        b=ALXmw46EAmdDbux+gnQvxdAAItaHAzpiPRcORketR/4OIkPYUhxVfroUulD030GxfS
         exyLzHT2YJOCwfUoTFAc6hnmAIXMg6WoKOAmPzBhjp0OXe86P432VzP4xXUbKjmQ3LgI
         36aTLj6R9femqQHQ/z4zUaQdBquJrVGcMHP4t4kgqJ5t4we/1Ycw0N+dvrA9KKrLYGGb
         bfLiu3+7/8WZdm++KekJb5i//BtrcnaUXCrpd0UwUoVnp97gRMHefZ52scdXYIcNGupD
         zq/7Tz+PZXtSHOPUIePcIo21Lt0B4iy4VE9yDb7O+/Abk/g6hj90CaWO0gSWkE+MD37q
         /JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533664; x=1740138464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVmtBhEiVyNl8QZ1O6tERZVz1PTbfN4nkq7rh5ldJZo=;
        b=L+1+mudHBSKhBimMDHTULkrziURzOOjLMcI1YIhYXM35lAk88y5ACm8RbsrQStr3pR
         krH1919XvOyXxzppbscSVb2NhTSO0JpA4j+VdDZtZgUz2m3WWXjSDuFUTZ36CXMWaE/b
         wh2mbXIogg/u/eEss/G2SEkmkjQkvSXL7RuaMd6XA6SeN4mPTqmS+IUT2D+6bmsjbXwn
         iZwQTPdx6kHGtMHfKnQz+BIIzUrhSxJeWZvo7AyzyG6X9ElkL+bJLfAlz74grmm6RmQQ
         +rWpTkVZATICElmTVK9gWWKGDgt+zna6KLbScLr6xhnASs+4eFj9VuaJF0yE3pVz46Vk
         ewHA==
X-Forwarded-Encrypted: i=1; AJvYcCVRxEA3qOXo8I6TTTeRcUxYg4A4gilt3MbsjHvhtnqg82lfw1LWysSlClEBo9dhSKgeyRGJemVppVdensI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kZaWjxYSnIjA72gP5ieWLrYtfN4G0gE5bIvdRAJRMbdy1s5F
	AZQGhHxoTiEN+wUUsDrj0lTZHRixDXVYRxBqVnhJJATLMWxGXa49
X-Gm-Gg: ASbGnct08cZOHT9geGbhmhM5zF6sd6QLjvZvqKAVAyyhgn1T1UvReQcCG9X9wQo1c7F
	DnNKAe4au/uhY9IJSHf83UYLumLkP2sud6sVMyQLnYhjqapvtdMhFuN+eLIHmm4ztkI6hZNdILN
	omEE/4/yVuWCYdVjXtlzdfIANyUPl3vVN/BzG3onlB+bl4AZodsPL/6CORoNuMoTvp+bPv2vkWO
	DsmUF9dfDQE4a9axcfBWpQSufihDGrHRb/+ofd87WIGuZvbrpqAPCbRtRvA0uY0OIP/LSPILqwF
	fNyOjV/u5LqGcboVGHIKbFL8NItu0lnwTbjnKVbqF9odNt0NBi4=
X-Google-Smtp-Source: AGHT+IHJe9C5L7fJm3g1s0tX91oj/gwWsIwn+t9Y/6w2fpyFGBvil/NIo8HpbEWwojtJCTK1tz+sJQ==
X-Received: by 2002:a05:600c:c14:b0:439:63cb:ff7e with SMTP id 5b1f17b1804b1-43963cc00d4mr82079965e9.10.1739533664177;
        Fri, 14 Feb 2025 03:47:44 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:43 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 09/17] staging: gpib: hp82335 console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:00 +0100
Message-ID: <20250214114708.28947-10-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx
Use DRV_NAME defined as KBUILD_MODNAME instead of hard coded
string "hp82335" in request_irq

Change pr_err to dev_err wherever possible

Remove pr_info's

Remove "hp83335:" prefix in messages since this is
printed with the module name.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/hp_82335/hp82335.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 451d5dc6d340..982544d1b382 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -8,6 +8,10 @@
  *	implement recovery from bus errors (if necessary)
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "hp82335.h"
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -274,26 +278,23 @@ static int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config
 	case 0xfc000:
 		break;
 	default:
-		pr_err("hp82335: invalid base io address 0x%u\n", config->ibbase);
+		dev_err(board->gpib_dev, "invalid base io address 0x%x\n", config->ibbase);
 		return -EINVAL;
 	}
 	if (!request_mem_region(upper_iomem_base, hp82335_upper_iomem_size, "hp82335")) {
-		pr_err("hp82335: failed to allocate io memory region 0x%lx-0x%lx\n",
-		       upper_iomem_base, upper_iomem_base + hp82335_upper_iomem_size - 1);
+		dev_err(board->gpib_dev, "failed to allocate io memory region 0x%lx-0x%lx\n",
+			upper_iomem_base, upper_iomem_base + hp82335_upper_iomem_size - 1);
 		return -EBUSY;
 	}
 	hp_priv->raw_iobase = upper_iomem_base;
 	tms_priv->mmiobase = ioremap(upper_iomem_base, hp82335_upper_iomem_size);
-	pr_info("hp82335: upper half of 82335 iomem region 0x%lx remapped to 0x%p\n",
-		hp_priv->raw_iobase, tms_priv->mmiobase);
 
-	retval = request_irq(config->ibirq, hp82335_interrupt, 0, "hp82335", board);
+	retval = request_irq(config->ibirq, hp82335_interrupt, 0, DRV_NAME, board);
 	if (retval) {
-		pr_err("hp82335: can't request IRQ %d\n", config->ibirq);
+		dev_err(board->gpib_dev, "can't request IRQ %d\n", config->ibirq);
 		return retval;
 	}
 	hp_priv->irq = config->ibirq;
-	pr_info("hp82335: IRQ %d\n", config->ibirq);
 
 	tms9914_board_reset(tms_priv);
 
@@ -331,7 +332,7 @@ static int __init hp82335_init_module(void)
 	int result = gpib_register_driver(&hp82335_interface, THIS_MODULE);
 
 	if (result) {
-		pr_err("hp82335: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		return result;
 	}
 
-- 
2.48.1


