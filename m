Return-Path: <linux-kernel+bounces-311497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B209689DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977A61C21883
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BB2101AB;
	Mon,  2 Sep 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="our+n1dJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268119C564
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287119; cv=none; b=HTXU20nvmGk5n7feB6K2n49UjXKZoQ095zcUU5ihvg9RZuHtPdvakOwxQ+1CIsJAaNOee2AfuCAlHdVRRNuJX3HhHe36iyREOaOTR8qjCZrIH+c2a2jbfEBvKtT8Cq/3WkV+lwry6ZcgLt/GGN2SLn5QZsljkBwdDlUoXN1V+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287119; c=relaxed/simple;
	bh=1p9ZYsgfYl9w1ahgCSip2Y1+Xpu0d6d/IhQhSnKTzsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdjFgMxb2l5I3C6TytNvadQ7PTovJgvAXvFGesmwMExyU5P+0ofkyU5SL/8j/71NCASA3xV5Kh9cyI1v4D+ilR0pTjmgG0MKFOHd7bww32h92UivaBsgt8SZaAO9hutYuhaU18t9VkzvGcYrPVUg4REuUNfUx4tt12nOHKgcXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=our+n1dJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so653703a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287116; x=1725891916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGYe8FRwEPysTL7JlLl5YYHpFyLeeNEEyBqCLIl1U9o=;
        b=our+n1dJRI1RLpOKTfsbAH3Bmlhb6mAEBrvlD6TeZyDt9DBz1n35C9lVt67XODCPzC
         vYbApoSed+PIQI1zEOC+McO0VpyzkMCwlMhCI2fYD1tIUjq337dwB/8uBaKFqWiCwVYB
         YD4C9fjFk51nFZfOYvnKm/NWE0b+PaaqiviHWPmn1bWvY1MR9GEKE/5Vw+n/n88O9NCF
         GAch1gvx9S8wIpQc3VRbzHoEn6puzfDeSOJJvgv/sHJ/FAOjjJCQQODctWzIljOYC8gf
         GAfHLey57zmgw6aHKaT6ewFrb62yqFqPeqZPHFS95MOIJHs0TzZYJwfVuADqDjAxS/Rb
         Zmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287116; x=1725891916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGYe8FRwEPysTL7JlLl5YYHpFyLeeNEEyBqCLIl1U9o=;
        b=QsJp9wAoOHqkMjrP8ye40JEiV4d/D1EHve+EYaFMOHu4ScKKf4J060ssDp1xF31wzv
         2zPr2fdynStUQbHKRM4WSRHFlBAtDKZwR5dIy5IVU1esD5iqQ10i3Z+sb2fmb02fQvBu
         Kv57yyAhhciUEeZE3nlkP1jZuzvYd5SodnOPXcf/0UhKxsoTw7LBqD6/K8LtuFBQBrPt
         +UhbT72zAFODvGdCvUaIFOWfT7QdUf4N1s0QL3DvXSW3AmsalFr5GPgOI3hTpvdGAfN0
         oYZ/bKWtIImmnKwUW+Sojbs6YjhADj6rHrz+ZpC2dp3ROwJRfbK8e2Iw/yjfquCTQiWV
         du+A==
X-Gm-Message-State: AOJu0YwUOu11OsECWb+0sqfRElGwS1xpSha4PtYLHuDFcPhXd2gAxMIJ
	ubBTSjyvXDzp6fiv9StcYqsPHzOcq9H8thM5pWnsIyQGXGMAglHD+ubhy7VE+cAkIGL+1rEG9SV
	r
X-Google-Smtp-Source: AGHT+IH3mKV9fsNzOnA9an72CwXVGXCCQRfUmLteUKyWbYEBa0jm+DFgDSbJfmBkAM98AY4wQeQ3gw==
X-Received: by 2002:a05:6402:5243:b0:5c2:6319:b1f3 with SMTP id 4fb4d7f45d1cf-5c26319b228mr1203308a12.38.1725287115747;
        Mon, 02 Sep 2024 07:25:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a3f5sm5308881a12.2.2024.09.02.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:25:15 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc
Date: Mon,  2 Sep 2024 15:25:09 +0100
Message-Id: <20240902142510.71096-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

devm_nvmem_device_get() returns an nvmem device, not an nvmem cell.

Fixes: e2a5402ec7c6d044 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 516dfd861b9f..33ffa2aa4c11 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1276,13 +1276,13 @@ void nvmem_device_put(struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(nvmem_device_put);
 
 /**
- * devm_nvmem_device_get() - Get nvmem cell of device form a given id
+ * devm_nvmem_device_get() - Get nvmem device of device form a given id
  *
  * @dev: Device that requests the nvmem device.
  * @id: name id for the requested nvmem device.
  *
- * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_cell
- * on success.  The nvmem_cell will be freed by the automatically once the
+ * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
+ * on success.  The nvmem_device will be freed by the automatically once the
  * device is freed.
  */
 struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
-- 
2.25.1


