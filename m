Return-Path: <linux-kernel+bounces-180569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C618C7046
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D071C223C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E515CB;
	Thu, 16 May 2024 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPAMiHZ+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8F1366
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826552; cv=none; b=iUN+wMiBX2jKMLpkoiCaHUQVr2+5ecL2XkMuSZ6kDBePt3dSy5v2VLGVDJYU6PIcUHooKNY+HC+dWhpurdf4eHOih0F3V60Eyx9misN4iVdlBAngAT03mCCr0CsIqvPa3D8B401W6ZvdzsH1LEiskvxp2mxLaBRWZ9rdH7Z2/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826552; c=relaxed/simple;
	bh=IIkEL27j5qp0KhvU0CThyFm99wsNzwA4fdJ9xC6X5xo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MN6xTzqmHiG1UO+/edNIcbl0fJBxuUCeurcfyejnTKlFK49paJZvBHrRKBJqqHk+KGxgiubU5V3czph8TlELzY7yhQ2pcaVoKNIRQstuEZOnR9CTBgm/MbDHRbQec9HynpXt6ZNEcHm+eefVo8z4gYg60G3plz1JU2QyovqIthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPAMiHZ+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f082d92864so25896585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715826549; x=1716431349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylKzb7dfxhYrNsu4O3QTBN7Pz1PLfr8QWuGfcHzgVrY=;
        b=NPAMiHZ+mGrD84yyMgYbYbhb5qyCD/D8WqdMgd3rxu1RkbH2m+VVsG/ED08ZS0buLL
         KNaopYowMp5NXGAGaIOACXVpK4uPAdfSXJCbEwSZzHkojsYJdIzZQTUX9ZTtqeF1diex
         iUh5k6sI+r+4n8g0BnmK2/n4K0czvAZln3ctMLYA+gZVavQWX4KDu4om0uBjbRB6MdQ0
         BLoHHic39PIoik3AQhrfE/CM2kgtKzihehrEb3JCX1twQ9vZ941pPoz3G83PSZQAsB2c
         +5iftAU6Fird7fZ8MThu/tU8kfirpZiiirrC4TdSTHLcR90MEe+QtTLLsJrLqgeKW6HJ
         j0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826549; x=1716431349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylKzb7dfxhYrNsu4O3QTBN7Pz1PLfr8QWuGfcHzgVrY=;
        b=FQ1kAldSN7kF3xuhbhUcFBdBs4L32AtGjDKRFn2GyITvnJsx5xwI7y5H35KQpw1Bf4
         g1Mz2DOk/mo1/rpZKVC1tuQG5TMJ4RktxDVRYJtEB6BuRCYCgWOBiBosBFcde8BahADY
         zNLozlnhI3YDSJWUK82v/IiuHK1mn+qViaUPa7Isev8xqDXCjIW2xkjoelWt1ZkPS/Mu
         A2w4V0d956ZHT20ST5MsxGnYaQaJb3FJ/oJMX7JGAeiZ2t2pMtuDm7NhKqwBUZKy3Q/x
         r0AV/uELeYcdlHZe9gXR7rjry/+Ke2y/MRQRmdBSvO1gPHFePE27GMxAjkUpBdDeOJ9O
         Nspg==
X-Forwarded-Encrypted: i=1; AJvYcCXhtBWCHOCpT9zURV5LPlTnqmVdrFsEAKXKCRB1oiA4jez/zgVOrTR1ZTbaTI9O7Q+BWDehrY/RaDCuxqCKcOUer72JHvfvZ93sGfTk
X-Gm-Message-State: AOJu0YwC2RweRwPygme7fWyrVDVZRjCnTo9BcsGE5K9Om2bPe4m5qGlj
	cWIhCZ3r0X0r/pmL+3Y8uY/BuiV4Q/zUjy+ZtTwDr+B6PNo8AweJ
X-Google-Smtp-Source: AGHT+IFCDvih2Sq680TsFRlr89jhGuDy3ApG+kGUrzzeIRsdOeB48Bj+5o0oxG0AAySe6TyFzsu2ng==
X-Received: by 2002:a17:902:7893:b0:1e2:9ddc:f72d with SMTP id d9443c01a7336-1ef43d2af36mr168568245ad.26.1715826549066;
        Wed, 15 May 2024 19:29:09 -0700 (PDT)
Received: from mari.. ([2804:431:cfd2:fcb9:74c9:b9d1:b3ec:e1e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada405sm126405175ad.92.2024.05.15.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:29:08 -0700 (PDT)
From: MarileneGarcia <marilene.agarcia@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: MarileneGarcia <marilene.agarcia@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 linux-next] nvmem: meson-efuse: Replacing the use of of_node_put to __free
Date: Wed, 15 May 2024 23:28:38 -0300
Message-Id: <20240516022838.8609-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free for device_node values, and thus drop calls to
of_node_put.

The goal is to reduce memory management issues by using this
scope-based of_node_put() cleanup to simplify function exit
handling. When using __free a resource is allocated within a
block, it is automatically freed at the end of the block.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
---

Changes since v2:
The patch was updated.
It was checked and there is a blank line after the last 
variable declaration, it does not appear as an added line 
because it already existed and it is not changed by these 
changes.

Thanks

 drivers/nvmem/meson-efuse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..52ed9a62ca5b 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -42,20 +42,19 @@ static int meson_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct meson_sm_firmware *fw;
-	struct device_node *sm_np;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
+	struct device_node *sm_np __free(device_node) =
+			of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 
-	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
 		dev_err(&pdev->dev, "no secure-monitor node\n");
 		return -ENODEV;
 	}
 
 	fw = meson_sm_get(sm_np);
-	of_node_put(sm_np);
 	if (!fw)
 		return -EPROBE_DEFER;
 
-- 
2.34.1


