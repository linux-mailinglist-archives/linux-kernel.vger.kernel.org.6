Return-Path: <linux-kernel+bounces-311507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFA9689F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A0BB22FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C413E8A5;
	Mon,  2 Sep 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wf/joCvH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887C2101A6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287406; cv=none; b=Tu1r5sdF1x6vIBvhkj8zg8i/x2LxVdb2Tr/wnTIoh/pGny7bOHC+QOFJAgq/njeT1bFbOvUEsRsRbDcVN/YbFpO8//0zUn7Waxy0jQaiQwg2bZUMJGHdwLQF2pniVfbYC5hNRxa8N+2bgs0zrOvtPn/Y/QxISJrzxqDiKds3dsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287406; c=relaxed/simple;
	bh=6S/BL58l6DGslYCysih6MHL7TQa+dxFbkVKivoprPbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0mulsXR80RIgNINNW42viKlxvikDWGe97l3w0huYCrLU9z8c+1+DsEVG0chnvYlLXCLg37lJXAmNLJ7IuXBnDHmUkQcDMfyLNYTOiDN5T0X4dJgXCC/wicSaqr8Op3jejGReW1BJ0B4UgiII+ZGUAbb+hQCsaqD1WEB+zt18a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wf/joCvH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3f163e379so69491221fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287403; x=1725892203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQxhPfaSfEzPkFbIFbbXZUYpGA0UFHQtGXmB6Sa6n/8=;
        b=wf/joCvHBCikFDYVotv0hB3RJo1hRrBPj7Qhf3BUpS0tsYghKJkwgZt1t+HHUVLxF8
         baIjF8Wx62QV4X3R2ux12NykffTJY09a5ht6x3U/gGTj89LDkZniU1/JtkcZyXmffm3K
         AWU16NEcY5WV3H9amAn2WzAKpwwAiV5GFi1Mk8+Sq41utmPmhu/XRLB5FaRtOVVoeJ8H
         uYwr056p0kHCbIPjxbxcre1JZaiHMYegfGOuy2PKMnv3tyIqNl2CUzBolM1TPlhG5gCU
         D+W/MgurQpPmtA2ajUCU8qanzyUn9hsLOtJPfyU6yL5QWJE/bqWFlxt9BElIfvkN4Peo
         RIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287403; x=1725892203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQxhPfaSfEzPkFbIFbbXZUYpGA0UFHQtGXmB6Sa6n/8=;
        b=wR+K1Oaqhcm7cGPsV62Gx9Ly/jLUQmTVMqYUVqbEIZhJRCKULHdARyVy9LIC+HVOJM
         +gKAKe4//E5HyeQM40gXKLHNrh5FnVUzj1I3lrtFUHilhzPXk9VvTaf4assZvln/54ib
         Fj+AOYsC9gINaXA78PrpwJCYg9GFjvAOGngLhfXuE8LqNFp0LYZGqJV10a3T3w3Zc8rs
         nO/uGbXok7QnRlkXOlibRoYftC15huz21RghRHmlOMcjtUebnBKZnpL1koNuIJBHfZXn
         rM82atH6/O+iwrU+WGQjkWpR/8gPhmuhMNkVB9zdVtaNmBLuQNAFfWBRJK6DfS28EyrU
         KmxA==
X-Gm-Message-State: AOJu0Yx30juv/jA08O8ikIpXgLzH2v8XPzOt2u+//gSystGDEIY4tqUv
	vfWBOlSe6nwcHnXhWLY2OxiSiYmBqy/Vgh+CRlxafGNQeKscgnBB1oQ63RAI2QE=
X-Google-Smtp-Source: AGHT+IHUBOhCeHWiu2UPzso0/FqzEudFCnhMC1OGTyF1ZmMpGjeRgQlzF4CynvEu565yi7iUuWD83Q==
X-Received: by 2002:a05:6512:1294:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-53546b1e1c2mr8611155e87.4.1725287402416;
        Mon, 02 Sep 2024 07:30:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:01 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/9] nvmem: imx-ocotp-ele: support i.MX95
Date: Mon,  2 Sep 2024 15:29:45 +0100
Message-Id: <20240902142952.71639-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

i.MX95 OCOTP has same accessing method, so add an entry for i.MX95, but
some fuse has ECC feature, so only read out the lower 16bits for ECC fuses.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp-ele.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index cf920542f939..1ba494497698 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -14,8 +14,9 @@
 #include <linux/slab.h>
 
 enum fuse_type {
-	FUSE_FSB = 1,
-	FUSE_ELE = 2,
+	FUSE_FSB = BIT(0),
+	FUSE_ELE = BIT(1),
+	FUSE_ECC = BIT(2),
 	FUSE_INVALID = -1
 };
 
@@ -93,7 +94,10 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 			continue;
 		}
 
-		*buf++ = readl_relaxed(reg + (i << 2));
+		if (type & FUSE_ECC)
+			*buf++ = readl_relaxed(reg + (i << 2)) & GENMASK(15, 0);
+		else
+			*buf++ = readl_relaxed(reg + (i << 2));
 	}
 
 	memcpy(val, (u8 *)p, bytes);
@@ -155,8 +159,30 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
 	},
 };
 
+static const struct ocotp_devtype_data imx95_ocotp_data = {
+	.reg_off = 0x8000,
+	.reg_read = imx_ocotp_reg_read,
+	.size = 2048,
+	.num_entry = 12,
+	.entry = {
+		{ 0, 1, FUSE_FSB | FUSE_ECC },
+		{ 7, 1, FUSE_FSB | FUSE_ECC },
+		{ 9, 3, FUSE_FSB | FUSE_ECC },
+		{ 12, 24, FUSE_FSB },
+		{ 36, 2, FUSE_FSB  | FUSE_ECC },
+		{ 38, 14, FUSE_FSB },
+		{ 63, 1, FUSE_ELE },
+		{ 128, 16, FUSE_ELE },
+		{ 188, 1, FUSE_ELE },
+		{ 317, 2, FUSE_FSB | FUSE_ECC },
+		{ 320, 7, FUSE_FSB },
+		{ 328, 184, FUSE_FSB }
+	},
+};
+
 static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
+	{ .compatible = "fsl,imx95-ocotp", .data = &imx95_ocotp_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_ele_ocotp_dt_ids);
-- 
2.25.1


