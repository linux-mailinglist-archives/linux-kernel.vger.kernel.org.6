Return-Path: <linux-kernel+bounces-550584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF65A5618E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E423B511E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738B1A23B9;
	Fri,  7 Mar 2025 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5eb+yu5"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F21A3163
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331374; cv=none; b=Rp1RXNzuOpfxscBhosRdWQdxHT3IRjT6jErc0NjP3S2txHQntnD3WbnOoWoFqlXxf9j8xIO3rvjzb4yDcXwi1vN4A3n2c5HAB6LkhVLfdZJBZC4lLy3KCePJU7iZFuNaiTbA19S1k+lS8YHdrMGDyrefwDhK7rNojJMDE+LQJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331374; c=relaxed/simple;
	bh=/LpeOqsM8NBgOqW35TPTqO8VCHLgeHC6lYd49z/YGJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWsLCgseN4XnhgC7INxPnIGdUTAQeF404jfH/psVTi9XEFYDvqIV5V9mIZq789DqlqdDV1mN8WpUBvatbJ2fJ2bFog5ajKmcCe27ZWlUXXvZLFjfYiE1HdDlhZSQSpTsRf7g9WUNiB8FMx+oytMcpYtnWzXYr/kUrM9nGHfxTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G5eb+yu5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390cf7458f5so1392782f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741331371; x=1741936171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoHAISknFV0nfp1OEo18Uj1nilezf1cqFzlBYUcX3F8=;
        b=G5eb+yu5QthUG6YwH6CxB1OYFJ1MP3LVYYHg6RfTP4R71l1dgImdlqutmFFMCo7xyz
         sCP/7xFWyPQdGJqd6UaCC6iRmhlldjQ7csSe+7X6XBb6qVVA52/E29ZA0/4BJr9HFMXv
         7yEyhPp+/fT67AUZUPH9W/DNg2Y4fBhp8VEBtk3sy2zB7u1X2wvJUoIT23ldt49fdQ0z
         BUN/IU4Vl6WNlZ8Z5rNdqnlqKjS4eCmms9O/dr4KLyk9WPtVUnXOXbT1VStiaIsu7jIr
         rKssS4QU2Pzpj4M6y849xs8bPVmcuBeTc02C3cZWJsLTmkFabnXvoteok0u1NUGHU+wR
         zmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331371; x=1741936171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoHAISknFV0nfp1OEo18Uj1nilezf1cqFzlBYUcX3F8=;
        b=GeT04LgiOEsEbRpdSde/hOm+I9RcB8AAnCksFDx/dOWuqXuCaoY8z7GFrwVfWV9j8B
         hKlRrRwOJOCf8NnHaM4drHd+ox2B1+kDvaJ3ozavo/Zkoe8TIl85lz9fDFCbbvpCAkJ4
         DWOeaYw/mf7fbrdSEqKIZ0Sz8i1w8KrZlKdXNCdUmlfcDcjtxM8CChxLbKphHOIvuPW3
         8cGU6+Kfwx/10ot/KtgYWFs9iRKj1qGwsSZ0WQLr+MTaRnsot9tFfCvVszEwiTWrfDaE
         G+bdROvc0hxe/zK7425oe+HxEnOHj4+Wie4Sf/yMOPWVTDgJJgIhPvKlbAK0VjiYGS9v
         xf1w==
X-Forwarded-Encrypted: i=1; AJvYcCXQQjA/K/zmEokrD/BojGk/pKTry4iXxYaHBYQGs2k62+y/ytzNAE7/gzzjbY1Ehpvk7HmtQf3hoWGz9Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4tqLBQudGqRa9zUy2l+4LXALhGiPwmHWb/gDTpoHberRBOq2
	X+TV7QkVweNs29IL71KC8jsKHPIBh1aVqrRwmREI8jF6MeNYfyPDysJQaHCD9pM=
X-Gm-Gg: ASbGncvrZP4tQokqCHRXsTdxlIavkGlQzbbBh+yjss2g+W4TLcZLwdmaDFOt0Fk+1tH
	eyJ/siPV+97m8/WmQLieGwiTGMDnqAxAY2C9jTg84l8wNZ2kX8n3Ip9AhJerjTgUhnRifuJqVBJ
	P44QVSK7Jc6LLKmDZwZuyN/F7nHwfCBt+4jSQJrd+RkzqjlJJcxxlwLbYg4XZFiurj4tuCH1Iz0
	VmzE7F5XUQJrNtUViQ/skWVa2ZzYrzbyochciPfIfiZMQI61xzPr7AzB5kQhHmdsLd3jXYIOtVj
	MipzMdx5mg5sNyiD8P5wQHVJslPUm7x4vlgQkAHc742Vfzg=
X-Google-Smtp-Source: AGHT+IF/M+SrLJzFQCBlgX3ewlX1/Jbu181O17xaopK9LG7eLVDZOJxGUfHeMhBYb12XGxIvhRhdXg==
X-Received: by 2002:a5d:5987:0:b0:391:2a9a:4796 with SMTP id ffacd0b85a97d-39132d244c8mr1532370f8f.18.1741331371047;
        Thu, 06 Mar 2025 23:09:31 -0800 (PST)
Received: from [0.0.0.1] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239735b58sm223243366b.117.2025.03.06.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:09:29 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 07 Mar 2025 09:09:06 +0200
Subject: [PATCH 2/3] mtd: spi-nor: explicitly include
 <linux/mod_devicetable.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-spi-nor-headers-cleanup-v1-2-c186a9511c1e@linaro.org>
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=984;
 i=tudor.ambarus@linaro.org; h=from:subject:message-id;
 bh=/LpeOqsM8NBgOqW35TPTqO8VCHLgeHC6lYd49z/YGJU=;
 b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnypujSncdDY3lu+Kfn/F8gf2vcWtuNYxXuyWJt
 bsbbSmL3nSJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ8qbowAKCRBLVU9HpY0U
 6a2HB/9jjqb62VUS2jdrCibdtJXByXkv4kqazmyiCgZAmL2vijZh/v4GxBLzYJM5OYJ1WPCtAEv
 mtxi5DNLgZc0q43tCRY8oeL2rJJQWtaKgANED6neq0+oIwvbdWsWfXGzpGVl8PRpd5gfTIHvcB/
 p56MfgzhEFoSqW4UA7FJVb0rw+cddYw5WOUGb2vxC/BfFt9UxFnAsFJ881dtkHxPtMGV4Xy6Dqv
 z4APYw/aaR5N37BSqR6W8bRaDJzcMQdLsS3Auk91usanoQgEmqmT5JwCRoc9BdKhAaRTHu4brdu
 WCtpYC1gPuOY1lB879kKWoeDw1Udn6TsxLtZqlJBiUJvufMf
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp;
 fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D

The core driver is using 'struct of_device_id' and relies on implicit
inclusion of <linux/mod_devicetable.h>, which comes from
<linux/of_platform.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1091c83294fa33393f27f914efb254da7a7524a2..ec298a285f820383b2c1d9ef4462a000d1b3b861 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/math64.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>

-- 
2.34.1


