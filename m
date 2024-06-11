Return-Path: <linux-kernel+bounces-210317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA94904245
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2039B2884EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02214D8AB;
	Tue, 11 Jun 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slrw+cMz"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18543BBFB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126203; cv=none; b=XsdVAil4/w4wzrX+22pA/oSRTZE/yI+vazOoOD+YUlChx40hvolKNbKMdsey6MyocOL+A86gTC5SWsJ4DsWv9DVSVCmTgkRHulfca1L0sGdeiU6uE9VHkwSUAHYRhoMlhU2RHhqzCSyGO/oIr6YpDFWUVR+cPD/gYCJxFGEOeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126203; c=relaxed/simple;
	bh=1oz7gki1JBAUNilIN2nJWm3wkdsH+gB30VbNTMLX0iA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MXaV2tb/kolKGvNEBqFK8m3TSEvrEmEBDpdZgw3bQVlLo6d72n69uAciTUeImv8r55CxuGKjCw77ZJf+EMxWJaQziSIb1zBvN6lXSM9IRtdXiDwaO1gBYpKeYFhk/EnZ4tjGyXzHAndz+jJ/2YytfKp5gEWf/JPDx39woXioK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slrw+cMz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a083e617aso26463277b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718126201; x=1718731001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x32GJJg0AlSw6J5DmY/hNwb8LZyaDbs+mRkSRyx7dxM=;
        b=slrw+cMzaam7oFGE7q2ka4lbuntMgEAvdSFZfRJsV/ZBd3igUTgvSXiLsx8B3XRNt8
         M2YV9qnXBQwC/pU5huWwFWnm9bt4v4svGq7b1WsbGLtrBXK8adPxfL+Te0y2Uk+RR4Md
         T5PyPyMoNX4HcBiGuD0ZRZxoYLoO2naUbWcBDMUgAr6abFLFpMyyLcoSjIos6+6id+mh
         i3l4KBeHjlDE+9rmIEArrSix6curI5jTVn3lwKsHR8MsSpazBH8nVvMjZRwoXu+vka1z
         o4tj87FOEpThB8+UX/3ePI2SL0YuexGTyoQdoNI/cIUAA3UJsmL6IVjs+vkz+3UXJ4dE
         4ewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126201; x=1718731001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x32GJJg0AlSw6J5DmY/hNwb8LZyaDbs+mRkSRyx7dxM=;
        b=aR7O4UH0wIuMDlOLqyVDu+3xHQyKmP21Jgdu0jg/doBW8CaQujEROCldhvcQQxlcC+
         jVADsYAZKXLzFakUMiPXs4WicwML5Vo4DaD2exzLwb0NOurjCYo1fenH9J51uNImwiG/
         N6t/jDPBee6gTAuuLtsMWTeIOnCQLVGGj7NlEMImFQqyIRfWT5szqeJBdYe48eQiaR9p
         V2L125PMho/T9mgutnOkU0aH6F1mHksXsN/Dmp9nkeOaRc9s70fTdtDEQ2qI678JjjIe
         hcrR4r+tBNzIRePvyhxomwHzZrkSLFrhssZRwH6fSQdZpFMqJlFy/W4ygVow3nhKs7J5
         WvAA==
X-Forwarded-Encrypted: i=1; AJvYcCX3KJ/NGSd7GTTsDGOXE60LMrbxGiEvoFoa6+xNMBu+gpoygisARYn2tT+CJ/ZjCUJmvfPdt6zaRLi4e4NILYI9JviuRJqHoBKxlJFI
X-Gm-Message-State: AOJu0Yy7m1Kzv0QbQMeWCd5TpfbXOFD6+b0+Zvv1fVnxpyedHDJmf0zn
	ari0mhX29UYYUYXtYWpb3RhwxpewgNkJMLMsWK2XIm3SqKIlfBNqIlOH3/OZgONGmLVanMAzL0/
	5AIh1s2XTv8RAd5Uaa2tFfkVJpQ==
X-Google-Smtp-Source: AGHT+IFZGNAg9puiuuskmC+xjdohP7kvB0J4VVKVnjwy0UefCG8+X6DP4ehy6KYfVSkTF9cqPe0yp7vlXGzijUCB35k=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:690c:dcf:b0:61b:791a:9850 with
 SMTP id 00721157ae682-62cd568d31cmr39052507b3.9.1718126200989; Tue, 11 Jun
 2024 10:16:40 -0700 (PDT)
Date: Tue, 11 Jun 2024 17:16:00 +0000
In-Reply-To: <20240611171600.1105124-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611171600.1105124-3-aniketmaurya@google.com>
Subject: [PATCH 2/2] i3c: dw: Add optional apb clock
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Besides the core clock, IP also has an apb
interface clock. Add an optional hook for
the same and appropriately enable and disable.

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
2.45.2.505.gda0bf45e8d-goog


