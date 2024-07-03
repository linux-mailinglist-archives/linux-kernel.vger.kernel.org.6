Return-Path: <linux-kernel+bounces-239764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E2926516
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B241C22769
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8CF1849FF;
	Wed,  3 Jul 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvtCIXjH"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A018309B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021085; cv=none; b=DcLDDMEOERXvMIuAFYceqZrmK2Kwn59yg3P2gw/3NwKLyeIfYwzIw63KJv4/DphfO0ZPIuwyFdHUx/qhnk1VIQfEgDXkYx4b44AWc1KJ2WvzYDsWmn8EQ58n7Am8vE9yHDax95dQr/HfWg2T2ZBHln2YsW2dEnAEmMZOiHAi3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021085; c=relaxed/simple;
	bh=A8h6qBLOlBAO4Nf5Z1u5nWAte8uqhP5kHvTzaAaJZ+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiRgaQ0aYgqM2keIOHeIFMTbv1Hs8DLAYVLmmrZXEZYtM604fC6Psau5qsMQi5ZIojCyQ4FK0/ng/njFapDuIHTF/sIctDxu1ay6Hf0mdm7Ny0e0JxWO+PGTlADd/yRDH16fGBZiaogEdvq5HTCxGpZQSk/duOKb4fgF18QpHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvtCIXjH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so563203266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021082; x=1720625882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DvuUcSFwNO6KhZ/DbrjWlR0SnoFpdvXYRD32tmG/+Y=;
        b=mvtCIXjHcoeuPC2tvfkZLQwcuiKSFxa446IOmHeZ7HE9kk32KI7TwWaSGV6jxQlb3k
         /sVAsQUioYhR5UxOYY6rFPwwhtivgdfpIbHHhWm2CMy7vHBbo0mPobqtMqBFkkgyLSUA
         TWcWGjcDqKoHd/ahs1NJejtW8paxPA9ULGLk5xza6PxyhMSfHO42LdsafbF8WR/J6fmI
         C/BxZ3pORx6OZJVvXl4x8b8C9wSNjLJ8rArE0wM9mfVQ/AQIqPnTz2gV7hBPIBKJRVdg
         jSWB2SMYvZu2+dYqqYPUWXRkbdeTGEgy3Wd+JlNK485PsDh5F/E/xsG+2292SXUieptY
         ixZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021082; x=1720625882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DvuUcSFwNO6KhZ/DbrjWlR0SnoFpdvXYRD32tmG/+Y=;
        b=HTFEx+RfQXd33hIn57QbjlYkoz9ybP8DMJWaKkF5ZdBr3pMXDm3Q4eIg+HEqwroXeW
         6x3ZJwq993QCJPfvQdVUevFxCDgb21dc3IR3QjQqnem8Q42LMJ2AjoVVSrZ44strA1qU
         NqDoL3shWjOgLUPUXAyX65NBW+eIVA9RyexVkEtxBjJShls2MFBherGdYQzW62lgJfLg
         UHNW9sI+8L/6ptGmU+9AEekW53b/ud5Furwt31MoupCnVERs5tpTJbxwodrDgEncuIb6
         JwTR7MXTwN+RUnLqYL3mh8Go+7bKLFaH3eCP/tO0+EQk7f8+wzkB7w5YviaEjDF+p/k4
         fFiA==
X-Gm-Message-State: AOJu0YzG8ZjbeK7SOwytvrmjI2nyBMJ9clq/V9yZNp9hVxi8c/lhIChN
	JxB3Z1RrGU1y7mrl+w2ONn+YH7T8t7wLZDQH0mgl6PjyVvY9Tf6/
X-Google-Smtp-Source: AGHT+IHCQ80mEv1/7hzgKtXN4Pxvcf2tTNEkA8d6/nsYXqmAct+j4z6C6IBojaFFHMQaQ4EikNbPxQ==
X-Received: by 2002:a17:907:2d1f:b0:a6f:48b2:aac5 with SMTP id a640c23a62f3a-a751441f052mr926878266b.15.1720021082289;
        Wed, 03 Jul 2024 08:38:02 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:38:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:38 +0200
Subject: [PATCH 5/7] mfd: tps6105x: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-5-aa6cd00a03bd@gmail.com>
References: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
In-Reply-To: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=722;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=A8h6qBLOlBAO4Nf5Z1u5nWAte8uqhP5kHvTzaAaJZ+g=;
 b=0aDXAOV2yQ6SgDy74o9G2xuTzpilnDRzguPUcMJe60B7GRpVMf+4+PYXAUexv6XzXyTNSv5Ts
 n/Qk2O/94yEBgZU2mES9qotIgWXd8xKOvX/z05dIzLdMlcrOHx57PXt
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`tps6105x_regmap_config` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/tps6105x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index 0da1cecb5af6..e2f6858d101e 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -23,7 +23,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps6105x.h>
 
-static struct regmap_config tps6105x_regmap_config = {
+static const struct regmap_config tps6105x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = TPS6105X_REG_3,

-- 
2.40.1


