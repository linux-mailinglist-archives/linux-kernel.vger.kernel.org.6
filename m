Return-Path: <linux-kernel+bounces-377850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A449AC7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A240F1C21657
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA919F46D;
	Wed, 23 Oct 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mb1TAjTP"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247721509A0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678879; cv=none; b=K++gN/Mbc/oGyJ3snIST1TH4QNgdxog4EmkK3BAWUaeM8L2IXaf0k3EC2XNjn62JSbrQYSluUbaKamMkyBJGLCndGXNuOl+4weQ2uiiXqvcpiXSaoona1rleVHyIQFFyXA8GAqNjsRwQMf7Qz3jOgrQn+1z56KyLGwtPJklM7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678879; c=relaxed/simple;
	bh=fL83B1RhTvYeFLJc1qRE48GBXQqFblks4FJTX8oJ7P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXpfjdtRGHQcH4N8SQBf87SNaNR56fBQuAaBMNO6knTXFaxjG1hEJ474x/Cff+9xWO8hyEyOxIUEwk2u2akrEdj/GIwEGPuDem+zIwcLx2RG6yzxfrGGlHxuOI6Sbz1feiQhjg1jtuaAfxKEcgXAXe0hJNuHp4sHHveT9BJm60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mb1TAjTP; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a39cabb9b8so22686755ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729678876; x=1730283676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd1HfFQMWC9g4f0GP0KU25BIxdhvF3UuIyAywYBFMAY=;
        b=Mb1TAjTPlF7mzPYboVId7RddFgvsOmER11OMdZekqYjRn55B96NDjytxdhulsctt1P
         bvk3rA8r8P7Qi3joti8Vh/peiJPBwxOrG6/dNfmJEVDY/IjTHXlQzrCft2qlABAf2fqt
         a6ebitM/mH/Ut7NdzlcjwrMJG6HIqHV7A1btM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678876; x=1730283676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bd1HfFQMWC9g4f0GP0KU25BIxdhvF3UuIyAywYBFMAY=;
        b=b03GrdEaf26U0jJNS/WQ/piKZa/pRIb2Wf2/kEbLKFBj13LF6kfmtw8ZX/vGsQnXPt
         QH/Sw5BCis1DjXCBghTvE0XU5L/sKxhct05KiZaS1xnUPXCN+WhSyi8sth8PUKLqnskT
         5oWRMSDuICMXyZhuv/0t5lSW0MxHCac6YV6KMN6Y9+sNh2Z29Iv/Gzf1Tf+dBUae3hnl
         LCbP/6voexBLXwfpTAwNAQBOHe3Vqg3/eQCmCCQyt6cM0FR/haR/L50JRqzNbUuTiwTU
         elQ6f2+O4j5nTQDhWmHLUA29OmzXdkzkO2e7PDtdvsQAzmH44D6TyKLx/Hyf+ADKFiWV
         GorA==
X-Forwarded-Encrypted: i=1; AJvYcCVjxeYPFjFi88Th95g2wPGJn3Lsg23L0eZrnw3XSL32XWLmip5bAVsnBT5ZptbqPyH/1a26z2nz2zgPfCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTssPKaCi3JRBVcIZT2YAxs/gZLcUmjOKtbIYoBe/TVDphlD1x
	XabZiG/irrRefZga8iicwYVj+UwiXLElkt7iS0N0GJLoh/KBtWExFRMv22rhJlPIB8lIQhTc6gM
	=
X-Google-Smtp-Source: AGHT+IE6QFForZlKyA0hU2+8la5Uo19ZimvhbDp1m01L+egZ+QO08x2ndnoyS7s4J9Oe9465zQjmlQ==
X-Received: by 2002:a05:6e02:219b:b0:3a3:9337:4cf4 with SMTP id e9e14a558f8ab-3a4d592cbe7mr20862945ab.4.1729678876040;
        Wed, 23 Oct 2024 03:21:16 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:eb47:48a4:644a:4aed])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab583d9sm6526349a12.49.2024.10.23.03.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:21:15 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mediatek-regulator-coupler: Fix comment
Date: Wed, 23 Oct 2024 18:19:21 +0800
Message-ID: <20241023102059.512352-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two minor issues in the comments.

1. We balance VSRAM voltage based on the target VGPU voltage, so the
   comment likely refers to VGPU.
2. .attach_regulator() returns 0 on success and 1 if the regulator is
   not suitable. The context suggests a successful return value (0).

Fixes: c200774a6df4 ("soc: mediatek: Introduce mediatek-regulator-coupler driver")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/soc/mediatek/mtk-regulator-coupler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
index 0b6a2884145e..16df12d1c2e0 100644
--- a/drivers/soc/mediatek/mtk-regulator-coupler.c
+++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
@@ -74,7 +74,7 @@ static int mediatek_regulator_balance_voltage(struct regulator_coupler *coupler,
 		return ret;
 
 	/*
-	 * If we're asked to set a voltage less than VSRAM min_uV, set
+	 * If we're asked to set a voltage less than VGPU min_uV, set
 	 * the minimum allowed voltage on VSRAM, as in this case it is
 	 * safe to ignore the max_spread parameter.
 	 */
@@ -108,7 +108,7 @@ static int mediatek_regulator_attach(struct regulator_coupler *coupler,
 	 * this means that this is surely not a GPU<->SRAM couple: in that
 	 * case, we may want to use another coupler implementation, if any,
 	 * or the generic one: the regulator core will keep walking through
-	 * the list of couplers when any .attach_regulator() cb returns 1.
+	 * the list of couplers when any .attach_regulator() cb returns 0.
 	 */
 	if (rdev->coupling_desc.n_coupled > 2)
 		return 1;
-- 
2.47.0.105.g07ac214952-goog


