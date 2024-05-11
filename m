Return-Path: <linux-kernel+bounces-176772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F083B8C34AC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A556F1F21D60
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782B552F7A;
	Sat, 11 May 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lplMtEJI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA344374
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468433; cv=none; b=EmznJ0lzCZ1cVJObXgPSVQZ4K4oAQvMZxKn2PU8ZU7rvR/o0wySReX/zCfrNJi68TUOrDiHmYxReKzFmmwKFSaac8y5YNRFzFofCNzdR02RJMQWw9v0t2fCvKAlvtwwdJLx2mqsY2dLwlIKw4CgsxJajA/on/Ao/5WPFIVWgRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468433; c=relaxed/simple;
	bh=TlWCMSv/jiIpOAhYCOFQPYQOX5V6nOBAcUqCISh5VBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTB7mc+/ZRdTPVEIBbvYnvhQt9gI6mTlKTsEletAzCf9TVeGm4cd2Cr21nlZfHGQGcs3Y+vZ1xoIsXbERAnH6Oa0s/J7zNDmV8xhHo4Yw1ig326SbzCcm4MqSLeJkFg0cAQAXANCpaCz8YvzcJq5C6ajy0iXslcQIgaEi/yZkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lplMtEJI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f3761c96aso3715075e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468430; x=1716073230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nGZSIFjpA7hWloLyPIcqlN98kQdeAEpnzUWGCLT48U=;
        b=lplMtEJIoqyD+6HjDfZWjOO1OzgKG/5FypnCRGOkQ9kP5O1U5BQZrb1iLpzqdgQc2V
         ltwbMe56EBkiC0kzt+S4RvIQlx9adS3yQPYb3TyY47uqXgQXyi81UMihWoX0GSzf5Hhu
         VUKg7FIl9Acj7nvVqCrBJGnVKVYyz1O1uutQnb2X4S2y/kMDjgOkDjVNo2kvzBm+sOOm
         JicCbg+e5MpC+PaLrmqeBHVCd4Z1es+oq8WB1IMlmic97w2XEY01aRSxRricmZNpNq4F
         oCnGAiiBfQSwEMsHN2z79S+NbNo8fpN69pYH2PTvu7Gf3rbE6sg4En+ELYwi7gImsRik
         xXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468430; x=1716073230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nGZSIFjpA7hWloLyPIcqlN98kQdeAEpnzUWGCLT48U=;
        b=xG4VVTFKNjr2zLALMiR3xaGUgD2OIUmqkIZ82DIEjenT2FPulrdxYgvCYRs/1+Vt5z
         BOS2cmc64n17QM0T+B004mTdRtKgabDPRGf2PFqPdJtaikzia5J8c0Z4jOQV9MradIdG
         cl9gAh9hqPfiHqf/f4y398Q9khEGl/uvSay6rJan5NA/u8IhYRhmIlRd0CFEbQYaAIc1
         fQIJ2ePraaVdyMQfBNEN9rYP7jvdLz/st1vvOPye70dzN3gqxXcENRvJb6Rx0LN91uAC
         4KHOO0sr/gbDuS92R64k7w+h8Ouy6qLVZPCe8hgqYYQk2cfPAVZOdeaLyBEw0qfYa6Xf
         sUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLNGTZEltuPZOxj/OVENmypKrPAeUaAxaApJDx+CIGpIwIgcUTuY7HO0WUkELFlsZ6wmwGzCzVUpHEyUJ54UkSr57XoB13fW+vPLC9
X-Gm-Message-State: AOJu0YzrdII3R86AxvzZDtbnrfdM8UQagoYurWJ96TeSPL4cEB+VLdZ6
	rH23qhdFjgw7cYT8EjpjeJVqb55UYO9G9ObolKdqLDJhyaKMEElvFGHaeZg6adI5HD/EgDomOa7
	q
X-Google-Smtp-Source: AGHT+IFN8eHZ/0IbW58SHvJPhPsmpX0SzkQZ4t3TEmoTUno0Y/oeyw/EDzIQKLC65rQedkw3MXcf1w==
X-Received: by 2002:a19:6410:0:b0:51b:ce76:7813 with SMTP id 2adb3069b0e04-522102779cfmr4901016e87.58.1715468430358;
        Sat, 11 May 2024 16:00:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 02:00:22 +0300
Subject: [PATCH v2 5/7] drm/panel: innolux-p079zca: use
 mipi_dsi_dcs_nop_multi()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-dsi-panels-upd-api-v2-5-e31ca14d102e@linaro.org>
References: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
In-Reply-To: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TlWCMSv/jiIpOAhYCOFQPYQOX5V6nOBAcUqCISh5VBk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iJ3hmcn4EtNeWFrKpLrPvOewe6cnuQ7sp9E
 0aeMTNOOoKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iQAKCRCLPIo+Aiko
 1byICACRic7Hv3T681Ko0ZMoic2jYP4/lNy59Ox1wuPogwymz/YevHKOtV7wpqvZq2B5Z09txZE
 PS9NErQ8qcnj0FIUnrVL0gk8eD4BngE2qtqB+W26m02Snw2Vf1r/yljaS1zjbkFdFioD73Nvi6n
 m5eDY29Uqx4tWFgEJSpza1ztnCCUDuV+uCYrC/MIjgjAVvBdr7tBiTzh75clucUXL82kgUVSly/
 zu81FiBlcCL8u3Qs9LxZZH6xW4UNfCAwTRCsaRpTLz90KKDetFOouiOXfD7LzsgA5gICO77VJlM
 2ujcztYjWv0s6ESj54AhS+GoE0ZVKIJOgTZrWi+JDdOW3ECC
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and use mipi_dsi_dcs_nop_multi() wrapper to
simplify driver code.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index ade8bf7491ee..0691a27a0daa 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -224,21 +224,14 @@ static const struct drm_display_mode innolux_p097pfg_mode = {
 static void innolux_panel_write_multi(struct mipi_dsi_multi_context *ctx,
 				      const void *payload, size_t size)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-
 	mipi_dsi_generic_write_multi(ctx, payload, size);
-	if (ctx->accum_err)
-		return;
 
 	/*
 	 * Included by random guessing, because without this
 	 * (or at least, some delay), the panel sometimes
 	 * didn't appear to pick up the command sequence.
 	 */
-	ctx->accum_err = mipi_dsi_dcs_nop(ctx->dsi);
-	if (ctx->accum_err)
-		dev_err(dev, "failed to send DCS nop: %d\n", ctx->accum_err);
+	mipi_dsi_dcs_nop_multi(ctx);
 }
 
 #define innolux_panel_init_cmd_multi(ctx, seq...)                 \

-- 
2.39.2


