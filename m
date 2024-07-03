Return-Path: <linux-kernel+bounces-239762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61136926513
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215831F20CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D411836D8;
	Wed,  3 Jul 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2bMwvdY"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E418306D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021083; cv=none; b=DYeLUtTzgHKH0Z4hxVur/l74AqfCkdVX/Kbwv/63Kr9y02iuj0TmSuxeWqM6+LAYkstvlj8sML+2IxIc5PQNXqRu445lYSwI3Zm7m9Wcv0ggnACLukBx8TYRjiMALhDFU/4RImEKfIpTAMnjWokkHX10Xd/5SjXC/nebpyYI/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021083; c=relaxed/simple;
	bh=8tMNatK1sJi4q8SWgKJTcOEOVd74qA+MZpB63bLVf40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8ElMbYC3sSLQDgmsxfFkQp5WaRgOu54OW+Hs5RhasfRNl+XplstRCFzsHKubD493elprf15y4aQ3Y9qQQ30xiKK012PLfUaRPBjmh02/7r2SM/l3YICn3pz8cbU48uQP4y6YeUHfXjwh76W6SOOnfrtVyJRc9JCZMPT0oKTxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2bMwvdY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso3093863a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021080; x=1720625880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+SGNEsXbL97x+/CVxCXK+2nldG1TcI8vle2Sq9kOQU=;
        b=m2bMwvdYMu9kgFIITBjT2lAiASEIgEKvar9RuMT5MOIHLobsyb2cGpGlhUmYfoTDEu
         fD29DqrYm0HYaBrecYPFFG268VkRRIP/rHMHNGB9hPzGqbjUy9fJkGJbY78XRVylO5Hf
         QSsmYG1iUcq3JQe4TQLkLGrQqHIamkdk7wD/1OwlWZHnLGcW4BlQBN+lemk0HWC3Wddk
         B0ErGw3Eoj7HVHA/3Yvgj7zgttZmoyKi47l8QZ5uvmdU6F/boUB1JNGlT15SG1wk7uFP
         kh/W92/WBG7nVnnT4tAyGJUuqHQxsUK8XR4IwpEtgXqFQKWqrlz3mX+7s4wuJNbbwMb4
         25jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021080; x=1720625880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+SGNEsXbL97x+/CVxCXK+2nldG1TcI8vle2Sq9kOQU=;
        b=WV1d/HJHlQ0WWkVMr0CkHyPpCAZ2TFOkcUUu4DjBwL+5sE28MY04iRUm1wo+FFfo4l
         mQgLbMnv5ZR/X6vWr9NwI3QScNYr2jj81A6YaEYrrGvXQ5WRT+DiSPKhPYHbzo0u9OM/
         qj0f10AO0PHRM8TjXT5hPbod32MzhO3R+oyJGSU6oHtFZopD78DZnlV35yU2fi39GlYY
         lr1oMSzgt0KGgIsXou+pm8y8SQlLfG1vmTDCQREm2DuHe5ytdakuB3AHxXUmDxtqRuXX
         iAKT6/Njx+jbMLaFvVdv0PgIg9FMAxmZRrvp/JWYke6AoZTx4AhyKwXGqTUo4wTjDba0
         wBRg==
X-Gm-Message-State: AOJu0Yyl0rqdtA/6P3idBMH5LRvEZettJmUEnJVurVdfF8Lt/cFrHLtX
	vvKyroPJUlcv92zIXla5LKmDZR1y1H2L6M31lZaxcF3uQ55KKWKt
X-Google-Smtp-Source: AGHT+IENzhhrUxWbCitwYBlyHkjH3e1TKb3joGsSiXgzBe4l0rhKW78in1ln7eLqEn19G4OtGBjFSQ==
X-Received: by 2002:a05:6402:366:b0:58b:9e7c:bcbf with SMTP id 4fb4d7f45d1cf-58b9e7cc15cmr2397363a12.36.1720021079945;
        Wed, 03 Jul 2024 08:37:59 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:37:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:36 +0200
Subject: [PATCH 3/7] mfd: hi655x-pmic: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-3-aa6cd00a03bd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=764;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=8tMNatK1sJi4q8SWgKJTcOEOVd74qA+MZpB63bLVf40=;
 b=AVvXYso+UmdzYbKeaDLFULDlT2RlG/HrJfDW4yf4Ap5vBO1x4//8r97EER+jmE37Hvsp5M2Im
 SD1uZbsw0NaAUCLo7SRKTTIc07GchzH4N7JRHWV0earYvndaUlks/LZ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`hi655x_regmap_config` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/hi655x-pmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 042109304db4..5f61909c85e9 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -41,7 +41,7 @@ static const struct regmap_irq_chip hi655x_irq_chip = {
 	.mask_base = HI655X_IRQ_MASK_BASE,
 };
 
-static struct regmap_config hi655x_regmap_config = {
+static const struct regmap_config hi655x_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = HI655X_STRIDE,
 	.val_bits = 8,

-- 
2.40.1


