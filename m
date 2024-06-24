Return-Path: <linux-kernel+bounces-226670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989669141F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ED6284AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26517BCB;
	Mon, 24 Jun 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5iseQFR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433F1BC3C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206964; cv=none; b=sxI/gQnknj48gjf0qWQXeAAq0qp3hFLa8YwTDV2Hy5C3Av+ub0uDtPkxXm04F5e6d4H6S+mxLcZa5S81ZQT0Hn9g3QW9ptiLIhQHHcsGtPF5ssCsKvCVTtV5nNQ8STnlXtds3yUsYa3dm+lGzzYsHDiTj7IG2eALEVKL3rFgHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206964; c=relaxed/simple;
	bh=50twyfEJ8ALTho3pL+ku6E2q/cus4h8CQVXWkBsgJ4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejo/FTGh20+0U/kC6moMrwmlFkFMfGdda12sxmltxpKbNMZ75e8Z0Ia+KarTw9tn4zfu8HNND5tKZ/xBdU0VpcxMaK0pYdChNozeX80j1icos3PljA7BBMmpSbEXWwrPXRZlsT6n335MBAe8g+nvAh2QAPCkt++E+k2hU1bVjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5iseQFR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63a988bdec8so74691907b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719206962; x=1719811762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1I8I99l7a+8VVN3a7Xt/piq3f28W3MFZ3VnliaJyPU=;
        b=Y5iseQFRU1iKk+YleCi7794DESJI6bmBUHk0J+kVJ2aoxLqJJb0U/sxiQhzriiZsM4
         FXgnWCKy/cwa7O70CGqcDjMAGuO4fXLKYSUL8+zREOivnsn7FPQfjgWMeq7Jx8nCOOOv
         GtjxFzrCrPWmIEU4bqRm7jSdVTXPTOlo21/1B5WVJWFREvr9lq3xgZvtj64aBXvXUhYE
         EuV7HqhsCXVzoCStfQVJDLxv2abbOUKqxSm4AR6JbWJ2szgOBuiL2B+3Ey8ArPByDsQw
         6IaOLegT93Oxw+Jx8hI+sGHLXQJBPkSXpCbWbITvUqMlBSMq3WZdv8K1DgWB6a3QEE/W
         Hsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719206962; x=1719811762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1I8I99l7a+8VVN3a7Xt/piq3f28W3MFZ3VnliaJyPU=;
        b=BbxjbMF2ZTxxconvEEUJ+3kPabpFjRHOyYPQEYdr8KuzesZOS8YIyZmy/EoBh9wyVR
         +zSB7H96mO9xrUcJfKftRpQuYgaWN/BhEYPO+y68G5PTktY8ngxW24wXHlDJpscVbd8k
         PcePbV77WQBfCA9DSTVJTrTMlmEArcZyXHeNZkZ5NLH5TW9T7ks9AKMogx5HZFS+sRlq
         f3i4YuodpQw9OmRkPwtjSmt674PLpTyvvCrkzJ57eBYqdB2cpVFMP2xIH75T9YedVJGp
         Puil7NVlfWgFeMab6pv/Q0Efi5LfjMd8lSpKXsL7kOnebslENR4c57kaoETlsckZfbZP
         pQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwRxuhEhnON0ASLLoUycKuDfzA4tkvprixnJMnTSegPt9GclGv7G4VrpR4zHjAhzx/VRRyLhiUcT3djGq40l+P4sR7yKqgPfupbS4C
X-Gm-Message-State: AOJu0YxAg+4q3fqWg0dr6ufFtHHyG0iI57lox2jJiMSkXZRY7IIRI3Bz
	UgNrPsAPOPw8ENQ02N+vzf2ikK5/p6egD29u7rPmBqIqFn3OS4mJP1U2x3XRRwMkAfevDMXxLe7
	ahqlj3+WY4WKGUHkKH607mvRLpg==
X-Google-Smtp-Source: AGHT+IFYTSVOMsLqJVDUxHQ8GFvdZHqCOqKjAi9xCBAxDVenSvN+E7dc9z9/aa2vq33ZomTzPFE3OUf1TIIi5BohR5k=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:1146:b0:e02:c619:732 with
 SMTP id 3f1490d57ef6-e0301098e9emr11043276.8.1719206962420; Sun, 23 Jun 2024
 22:29:22 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:28:51 +0000
In-Reply-To: <20240624052851.1030799-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com> <20240624052851.1030799-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624052851.1030799-4-aniketmaurya@google.com>
Subject: [PATCH v2 3/3] i3c: dw: Use new *_enabled clk APIs
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Move to "enabled" variant of clk_get APIs. It takes care
of enable and disable calls during the probe and remove.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 41cdfd6741e3..37092b8e964f 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1466,11 +1466,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
 
-	master->core_clk = devm_clk_get(&pdev->dev, NULL);
+	master->core_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(master->core_clk))
 		return PTR_ERR(master->core_clk);
 
-	master->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	master->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(master->pclk))
 		return PTR_ERR(master->pclk);
 
@@ -1479,14 +1479,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (IS_ERR(master->core_rst))
 		return PTR_ERR(master->core_rst);
 
-	ret = clk_prepare_enable(master->core_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(master->pclk);
-	if (ret)
-		goto err_disable_core_clk;
-
 	reset_control_deassert(master->core_rst);
 
 	spin_lock_init(&master->xferqueue.lock);
@@ -1528,11 +1520,6 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 err_assert_rst:
 	reset_control_assert(master->core_rst);
 
-	clk_disable_unprepare(master->pclk);
-
-err_disable_core_clk:
-	clk_disable_unprepare(master->core_clk);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
@@ -1542,10 +1529,6 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 	i3c_master_unregister(&master->base);
 
 	reset_control_assert(master->core_rst);
-
-	clk_disable_unprepare(master->pclk);
-
-	clk_disable_unprepare(master->core_clk);
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
 
-- 
2.45.2.741.gdbec12cfda-goog


