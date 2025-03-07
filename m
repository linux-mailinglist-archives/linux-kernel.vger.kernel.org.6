Return-Path: <linux-kernel+bounces-550585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FFCA5618F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA547A7F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB31A5BBB;
	Fri,  7 Mar 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNOqysNg"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA31A23BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331377; cv=none; b=dCHkelZeQ+2envSxwh5drRbn0GgVxygpaagnw+STJ98FDzKpzRAXUGmCPlCTyX2E7qkzWbVdwdKdu1KcdLudSinphwBBQaObNcgHhrYLtpWaMLML9WOVgBWxQ+IZWQWZHwy/PRpPe9vVR6zaAqtEjmko7XY4eDCdTAQszY7ajjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331377; c=relaxed/simple;
	bh=pd0N8OHSlq4OJlDzwaqlGUrXS61Bisz7SbjdJpuUGOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSupJvdrzbMSq4AsoLf+mqyb9sL/7nq466jwIMM/olNZGc/5nzIQmpFwbjU+SwfH9nPivhkhAmsmlQh0q99OXKG14Miw85K/Hf8/0SPIw0qV8gvT3+1Fx4OKXzcJ+n8hQBAT9CUUfj2S8IgpBmqzvQhGWuh/IsYrlcAICle0LfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNOqysNg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac1f5157c90so239805666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741331374; x=1741936174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wniv4E+WoHofg2EefaZIUI7wXURdu3G5MTws6unhcqg=;
        b=SNOqysNgMJCgShB9NvN+4L+XKIGLCBnurfuthEdExu+xH/3tnC+rgMOL1EWpjUu8u3
         kzAc/rG0jAaq/nbbfjqxynZR/GzetMNx/WqAZGPUrecstnSvJUupFn3wlxembNVb7ryt
         a9idOGL53L2kjZe512GAPeSkrqM+L5YGBbLB8sBlfHhe73URP9YtUzsEVhxPN+Nz9ZqR
         M2OHeyBqOcVcHKdwQPRGEv7Ir1OyTY1kYYvPsjCxjMuKoxJGcTUEmf/eeDl+oRUrwwFK
         MgN93Fi8XhnxvkL9WQmbLPr7g1etwR5hLh0YA5rZUGEUXHRb9+vM/E76y7c83lNQ9sEx
         NJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331374; x=1741936174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wniv4E+WoHofg2EefaZIUI7wXURdu3G5MTws6unhcqg=;
        b=cbpGHxOrIcVjuip+Cyin2EW+WvrJPWZLkvzUofp0uMo6oUNhqGdnd/QJIlayDY86a3
         eTA9V/+470PVEazoLoL0jNKftMlXjktJEWgfI2Zn3Xk+KLxfRqNdSnFFakZFaMJ0/QXr
         KNfepKJ5cEABgjKyjY4CXH0hHxQ35Cqobwylt0tH4OZV2q3dxQPkFUBYPdtsYaIw/Xs7
         nRKCRQdlRwfiKP1Qft6HYA7dI10jYu9a1S7KFMJ+ak1SYPOn+p/luRteAB5T3X3s3WFP
         9UDkJIV0ZEZZdMMveDn1LgdokpreaTHgrny8IffzLvpGaYnuaCz1Ro4dZVKmB7JUGLJm
         qQew==
X-Forwarded-Encrypted: i=1; AJvYcCU+6/WIwbEReeIjRKjc1Enkx7Q9+rdNPekyJ2X1fL0BKYyfjQ+Tme/slCW4/rOtDeIxjhORKIucQfVxXes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7PqrpfgvcDZ0aj0SDyySHGfn+O0j6xtmmYHI56FaP4DdlsuHd
	buJqcA2RmzINErMWxyfCBkRfevVNaEJukr/6ohZr+YldCl4RI9QWH4htn8Dure0=
X-Gm-Gg: ASbGncvcMh9AXlzSnIYVmuHPYsxBRvPZHxjWflA/nc8sHwjp4PTvVWGP4NVBioSllbX
	vbMdugoKsWMxwr57zq6lZnEIr62TDn51U+CoFpQo7kVVQ4cSxnMn7wVcS/KpNq05k06piteHe5k
	GVCSuolTJoqt2HtZ6pUMMpFQ/ZeR9PZ/u+z4ZSAsR3uFe584AiXYf2pJROcgjCmmzzkRyn9+dy/
	DUjKu98xWtTV/kCbJGqVtfY67odMnkGebHpVVZX7gXDUsZi9lEF6vyxFJL4UVMb90H5flPRlSlO
	sH9JYr9OxqBjAwwAS9D67Go5DO292n4kjxilBNruwDVxjXI=
X-Google-Smtp-Source: AGHT+IF0KaGKoKQ0ZmXZEsOFxWg8sSpp1Vsw9yIcHJ+SGaPMD8IAbrnteni9h/1sI362IMHH/z2chw==
X-Received: by 2002:a17:907:3e8f:b0:ac1:f5a4:6db3 with SMTP id a640c23a62f3a-ac252b59b7fmr256783766b.33.1741331373859;
        Thu, 06 Mar 2025 23:09:33 -0800 (PST)
Received: from [0.0.0.1] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239735b58sm223243366b.117.2025.03.06.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:09:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 07 Mar 2025 09:09:07 +0200
Subject: [PATCH 3/3] mtd: spi-nor: drop unused <linux/of_platform.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-spi-nor-headers-cleanup-v1-3-c186a9511c1e@linaro.org>
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=722;
 i=tudor.ambarus@linaro.org; h=from:subject:message-id;
 bh=pd0N8OHSlq4OJlDzwaqlGUrXS61Bisz7SbjdJpuUGOY=;
 b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnypukKVNCvkCFmlP5mhPK7ENR68JcZ+kMslmWE
 eLWKFOZxdyJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ8qbpAAKCRBLVU9HpY0U
 6ZX8B/9zgXYPJVYRJk/KxLCVN9dnyt0VEJFakZJkE06vVuH5s9g7bkF3XBQr/4TnnpAYr8dS/eQ
 jFci5ZsvacZMoTwAVsomvqvoSW3SQjlhooXECygfCHI2Eewr/0Grdy6gC2mrWrUdy8WYZoZYvcJ
 VimAPb2CIb7KPIreyWmeVSfLb9QZIaV6D6LO8kqgzEbjWd7laU36pdGuOKcFkJGQ1Zxg/Xd7K5J
 sqOlHW3nQPTt17g/sBfTbC4W4ipHUFWali6/FnqLK1DlQV3/Z8moY1Hbc7jVxAZB4HAl+yeHaoO
 9Clb2+o0PKiQfrLLXmx8MPrIJ/NGSA8DcvWxsLNY8mIgw4PL
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp;
 fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D

There's nothing used in the SPI NOR core from <linux/of_platform.h>,
drop the header inclusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ec298a285f820383b2c1d9ef4462a000d1b3b861..deb284e95dbe37fee275fd6bbfcb3ae04e163edc 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -19,7 +19,6 @@
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sizes.h>

-- 
2.34.1


