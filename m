Return-Path: <linux-kernel+bounces-226669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EB9141F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35057B23F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591118C38;
	Mon, 24 Jun 2024 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ3P2j6F"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469F1BC3C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206959; cv=none; b=eMTaUTQ44k8b41UgtZQoF1rWjkhEVhApndmUR0dcAbn4Ga1j3pXRLoXYM86+3FWhkAU9r9p6aarI5aQrOmu9l3eDK7KqF/6YrxMsl8FoBA0ze9lgmg5XDRIF9nnguHCSewVbwv89JbTPI7Dw1alCP2IsUVWS1nKcp+ypC3BV+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206959; c=relaxed/simple;
	bh=8InZIp7y2zwsO4oF6fUGa/AKQ9soRf44nwDuYbc/fZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhV0c9UnTy9dCjxyV+cumv9b5/psArKTcJ1BZGp6WrcNZ+fVr0KtCuIw/SbqXc5wBe0t5eA+Bn+yKmlgCAD25zwGSUGNNkeavz8uIYBEKI/yBFAgFnpcCqciQeR1s9dHi8gIuMSmk2KfDE64iFyA+qAXYMa8Jc8hKPZME6GEtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQ3P2j6F; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso8158029276.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719206957; x=1719811757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1lDGMLBKOZjPQERPgHQ2A9MuACw0+8pMDHkdqTSITw=;
        b=PQ3P2j6FIp0z8UcrJEeANyB+43hqZROi1TVjPCGiCDykbWkrECMQZa/XNyQQVGZ44j
         LFd25UKETZLW8rUilZDBhizUUOMer+WB06a+OAeEG+qWamwbTuQSEdY4gKCKpxE+zvCX
         DBeWtWYGrsjNjx3hPTw9G7W8zzqFPG6s/GYkD+dx48qJVj9HF2lXXtvhhgLR5mlhbQHF
         TVosdzXF8TVlUUObLVO7EAWlDJfeT60n6GsGLRFzb2o6B+PtEsWVHTIonQnOOTaKVxWM
         1Hb5la7muxAemVE9Ac9vy4QcGTqftkV8JhTgTqD71Y0v3tLXRa/bjadhM+MAW2UZth8q
         iUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719206957; x=1719811757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1lDGMLBKOZjPQERPgHQ2A9MuACw0+8pMDHkdqTSITw=;
        b=BFxukh+ctEXFfOk7IAAj+/RsxtHll5BIwu2RhnteS/gcTq4Bhlbt/SPMbIVGqznpN4
         E1tdk3fHLA4NNFHDNQDR9/3vAZWntboX+P1R1tfljqEzlDzWFW4Byoj+UeveZ0ABKptB
         GYZzWJbAcux5NrrsZiIgcC3IK8M4jzab3BehRp59/syz0OTpUXsQ/XyZT3mr5CmfAU8T
         EJDh1lx+WZVZ/BDYADMpHvWsUaK3JNU8RfTLsoypvdt7umP1ApgrDquy3PEL9gu7zkRk
         o2bEnMTfrPqkseebrB1MUwR/wot6bLMVTGckGeny+kfQmjI8/IEA/qn3Xo9FPOoOGIIo
         7V3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPoT760Qfe+W+YVas1nvljp8M04raDpPSAh20v8E+GO5l1hl1DUQe8cSX/RV7skgSpfnNwf3WT5JfJAuHRvtkUOpTE4ohNATYk/ngD
X-Gm-Message-State: AOJu0YxH1ttaUBcKCHmHOt0Lz0jCm2We537XNhaglY5Ky37uDG5dkq6A
	EwNeA/vEbgt0aR+jcLZiQ4g5/3uH1LEgUzBQ62h5prkOX+aIVEvx2lWrzCVIKj44zydb10Ahu5g
	jLsKGiGG/C0+7G3btNmUw/gMYuw==
X-Google-Smtp-Source: AGHT+IFg4S5f43LgnXGlfi54t9Ut10DZcSLiBehSOlBVrIz63/P6FEWtc9+rMh5c0FMT9ZFPAyecpjuZbGRYntXsAoc=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a25:c747:0:b0:e02:6dcf:e9b2 with SMTP
 id 3f1490d57ef6-e0303d64058mr25487276.0.1719206957343; Sun, 23 Jun 2024
 22:29:17 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:28:50 +0000
In-Reply-To: <20240624052851.1030799-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com> <20240624052851.1030799-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624052851.1030799-3-aniketmaurya@google.com>
Subject: [PATCH v2 2/3] i3c: dw: Add optional apb clock
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Besides the core clock, IP also has an apb interface clock.
Add an optional hook for the same and appropriately enable/disable.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
 drivers/i3c/master/dw-i3c-master.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 77a2a1c3fd1d..41cdfd6741e3 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1470,12 +1470,20 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (IS_ERR(master->core_clk))
 		return PTR_ERR(master->core_clk);
 
+	master->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	if (IS_ERR(master->pclk))
+		return PTR_ERR(master->pclk);
+
 	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								    "core_rst");
 	if (IS_ERR(master->core_rst))
 		return PTR_ERR(master->core_rst);
 
 	ret = clk_prepare_enable(master->core_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(master->pclk);
 	if (ret)
 		goto err_disable_core_clk;
 
@@ -1520,6 +1528,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 err_assert_rst:
 	reset_control_assert(master->core_rst);
 
+	clk_disable_unprepare(master->pclk);
+
 err_disable_core_clk:
 	clk_disable_unprepare(master->core_clk);
 
@@ -1533,6 +1543,8 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 
 	reset_control_assert(master->core_rst);
 
+	clk_disable_unprepare(master->pclk);
+
 	clk_disable_unprepare(master->core_clk);
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 8cb617b8147e..50c38e790c0e 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -36,6 +36,7 @@ struct dw_i3c_master {
 	void __iomem *regs;
 	struct reset_control *core_rst;
 	struct clk *core_clk;
+	struct clk *pclk;
 	char version[5];
 	char type[5];
 	bool ibi_capable;
-- 
2.45.2.741.gdbec12cfda-goog


