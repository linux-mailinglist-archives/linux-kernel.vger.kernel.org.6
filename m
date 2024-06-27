Return-Path: <linux-kernel+bounces-231782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E26919DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890DC1C21792
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD5E1798F;
	Thu, 27 Jun 2024 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfne+aNt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CA171B6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459694; cv=none; b=Hg2M7O6bgd1EMdiYT9bRQXLeDPK4vjtQ36xEbXvbHUUs6O8IHNChzAWrXm1ldfJ09b69iGd4J4Obwkc7hYHwWMatPel2l8tzK5RyOBEvtceaB5pImflPTfu/xPuR75Mi1uUTaarBR1n76xo2wIBkO2RmyI0SgEDJLdnllRYTYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459694; c=relaxed/simple;
	bh=oliW5vuuwD3vza40p8EWFkbjux6cM39w4FtZNwDHQ5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BFAmuoHYf7Bmw+l5TuqbRYhDqr4lUPhXS4qPQBrCy5GOLvroxN5uzIWExNMzPWeNUdSdS1wg/GOwovL2SpK3OZAVZOrLAlfi1LtidZvMfFwU1WcQK4FhKl4TPMhg6G40HrJt1+VSOg/LnIPAZFtjm98FgmrQtgYqYeevy6lPJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfne+aNt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff189c7e65so15308127276.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719459691; x=1720064491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VfN6LKN9UpV/AtHOiz/7ta4IA3zN6HychBdUUeCjM10=;
        b=tfne+aNt+z855t5huPdiwx6EqowpcvhdZ6kiJ1VCEKF0E7wEQ8Y5XctuyWxKeI59rp
         vTY7V3iPmDQ1ilrYvv8it1iTB8WI3jJ3P5fPLJdCSl85q/DzzKuCuIrbGv36REea55B2
         oFnZJFjcKas46zib2rGAJSByvigRM/R4U9aj0YkXlhSNGUygZ/MBGyeEb+cNqsUWjRLR
         sKe5U5wGISlBEMi1DbBdmbYvQ0D3kFORDPi8Pjqlj7GS1hL3DC6SBpoNJ/Sg+8dOe3nQ
         tcwFBIlXnLtzeBkoeYo1fDmZemJ1fnGf7aclBjCupLP5V66bx3ZDZPb+4pXndkyOXedC
         zDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719459691; x=1720064491;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfN6LKN9UpV/AtHOiz/7ta4IA3zN6HychBdUUeCjM10=;
        b=w4jp43FbGqmhq6+SgUEtDmTmx8roqgpWbM69ig6/P/pE+6nCsKzO4Z4B+KO088/kgx
         IVeDBxl+63E+8nmH3EsaZmr0xzhOncKjp88R/DGj6YVlTDdUY8yxXViq2MX32+Ryre8k
         3Jj7YII4mBby9jvILwMe14A08W9UFEKSurDxsll0LeUJ9qWAq/4Fpc7c5lqtqDfOX4PP
         rlUyb4PglSBcaD0kERo4dFAFqN8IvuDpeZBR2Tgy83Pq0KbMtr3WbKiW8Zf8YVSaDlJh
         iuZflxOZ7Q1W4QJPjvn4HE/AI3cyDWjPquam2InfKRL9UDKtlgMBcywB9oPTWizrLh2E
         8cvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7eou0OKOZG2xzk44Xrp2GvXyUyA1TDWSzlfqmHrBsSacXlhAwhgtRSprg0HGbG6Y0tVf0VxedA/OnscLDZ+JmuGrNdozJFLepRtyP
X-Gm-Message-State: AOJu0Yx0UGpOJevavIQ59DRGxGwuKPXiZHHX85T+wUA1oYT3lEk28aLD
	0ft9WJWhdXDT9WI2A5rVEBIBMSPDvTVaKhaf/ykYQArW1k4gWUzDHdLz3XL0vd2VHmGjk0PBJuU
	tO+PIE8BMR7D6FiKrRjb1hJCngQ==
X-Google-Smtp-Source: AGHT+IGIQNKQcug/qo4053hTb1Q8b5FhJ00vTMf/lKz13G9EggldaPq/x0y3u9c/ZrSftf/dnDAtBduWF27TMMEmXTw=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:1885:b0:df7:b717:10c2 with
 SMTP id 3f1490d57ef6-e0303eb3559mr475694276.2.1719459691678; Wed, 26 Jun 2024
 20:41:31 -0700 (PDT)
Date: Thu, 27 Jun 2024 03:41:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240627034119.3938050-1-aniketmaurya@google.com>
Subject: [PATCH] i3c: dw: Remove ibi_capable property
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Since DW I3C IP master role always supports IBI, we don't need
to keep two variants of master ops and select one using this
property. Hence remove the code.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/ast2600-i3c-master.c |  1 -
 drivers/i3c/master/dw-i3c-master.c      | 23 ++---------------------
 drivers/i3c/master/dw-i3c-master.h      |  1 -
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/ast2600-i3c-master.c b/drivers/i3c/master/ast2600-i3c-master.c
index 01a47d3dd499..84942dbb6f80 100644
--- a/drivers/i3c/master/ast2600-i3c-master.c
+++ b/drivers/i3c/master/ast2600-i3c-master.c
@@ -156,7 +156,6 @@ static int ast2600_i3c_probe(struct platform_device *pdev)
 			i3c->sda_pullup);
 
 	i3c->dw.platform_ops = &ast2600_i3c_ops;
-	i3c->dw.ibi_capable = true;
 	return dw_i3c_common_probe(&i3c->dw, pdev);
 }
 
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 77a2a1c3fd1d..9aae5c8dba8d 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1404,21 +1404,6 @@ static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 	.attach_i2c_dev = dw_i3c_master_attach_i2c_dev,
 	.detach_i2c_dev = dw_i3c_master_detach_i2c_dev,
 	.i2c_xfers = dw_i3c_master_i2c_xfers,
-};
-
-static const struct i3c_master_controller_ops dw_mipi_i3c_ibi_ops = {
-	.bus_init = dw_i3c_master_bus_init,
-	.bus_cleanup = dw_i3c_master_bus_cleanup,
-	.attach_i3c_dev = dw_i3c_master_attach_i3c_dev,
-	.reattach_i3c_dev = dw_i3c_master_reattach_i3c_dev,
-	.detach_i3c_dev = dw_i3c_master_detach_i3c_dev,
-	.do_daa = dw_i3c_master_daa,
-	.supports_ccc_cmd = dw_i3c_master_supports_ccc_cmd,
-	.send_ccc_cmd = dw_i3c_master_send_ccc_cmd,
-	.priv_xfers = dw_i3c_master_priv_xfers,
-	.attach_i2c_dev = dw_i3c_master_attach_i2c_dev,
-	.detach_i2c_dev = dw_i3c_master_detach_i2c_dev,
-	.i2c_xfers = dw_i3c_master_i2c_xfers,
 	.request_ibi = dw_i3c_master_request_ibi,
 	.free_ibi = dw_i3c_master_free_ibi,
 	.enable_ibi = dw_i3c_master_enable_ibi,
@@ -1456,7 +1441,6 @@ static void dw_i3c_hj_work(struct work_struct *work)
 int dw_i3c_common_probe(struct dw_i3c_master *master,
 			struct platform_device *pdev)
 {
-	const struct i3c_master_controller_ops *ops;
 	int ret, irq;
 
 	if (!master->platform_ops)
@@ -1506,12 +1490,9 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	master->maxdevs = ret >> 16;
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
-	ops = &dw_mipi_i3c_ops;
-	if (master->ibi_capable)
-		ops = &dw_mipi_i3c_ibi_ops;
-
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
-	ret = i3c_master_register(&master->base, &pdev->dev, ops, false);
+	ret = i3c_master_register(&master->base, &pdev->dev,
+				  &dw_mipi_i3c_ops, false);
 	if (ret)
 		goto err_assert_rst;
 
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 8cb617b8147e..7e76ca381d9f 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -38,7 +38,6 @@ struct dw_i3c_master {
 	struct clk *core_clk;
 	char version[5];
 	char type[5];
-	bool ibi_capable;
 	u32 sir_rej_mask;
 	/*
 	 * Per-device hardware data, used to manage the device address table
-- 
2.45.2.741.gdbec12cfda-goog


