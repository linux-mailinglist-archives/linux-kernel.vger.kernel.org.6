Return-Path: <linux-kernel+bounces-174986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6228C184E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625A01C2162F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABC1292D7;
	Thu,  9 May 2024 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAIbD/4j"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220612C470
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289646; cv=none; b=Ks+kPWPi4duQoBhftU1Hk9syLkkIbHflPViHDi3ywTqB5qwv6Ej0redCuqLCdAQhtUEhri+YSfmrrPMs+6QXtDE8KHrxbiucC88Tnfx1ks6b7cbkigeyt5Tp+whUcVaHDUpUAyfHHdZhH/oXs4IL+3304yS4JSvZ4awSGVWTXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289646; c=relaxed/simple;
	bh=9SBs1y5K2hzjnYPD9Ky3KqU2SZnDlGyGsApyJDQKsvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXDgJp2ZQTbCtWs7ThZuYiehdqv1M9sDrPGJS75paVVi9ddDOqlePaPP7kMhjyGgA1znul528Zh8vcw59Bj7muo1XprChOEn/87TmgDFJYEj+c9/P7mX0LlEzN8oaU/yiS9hZs0swOTGpIMq/8eYZs6ZRqwDZFJ56hK1kS+x0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAIbD/4j; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f0602bc58so2281982e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715289627; x=1715894427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSmAuCxNU1y3XahseuBRK4nFztnrZzASjwN1faGf/vg=;
        b=OAIbD/4jbqPYK7SKir9nHkskHASBA17iFqPssaPwo1EZI+D0RbxSSfs5Z+yCpHdZls
         2cj+2piPdccfOyWO/PmUwNK38j6bBSjyvEf1ckzla9VbHa4+TNB4kH4E7MOwNsaAxhRN
         hagXvpz354c4rzOAV3cW9N7KSGenz3OIMWOJqyQ306tEWslWhJYg17yqJvvePSQF0efb
         xQ7H7DMJaG/ZEjWGWWkzu3dLsRzaWqnp94vhL+gSmVqms6l5UmsuiJY4BnE6RlyaEAR3
         mQMcBuunwBjQ9Nz0gSvwfrUIzr4Js8rN+7b/HmRCui0kAngmLRSvFH/nZ5D5OUMbyg0H
         qeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289627; x=1715894427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSmAuCxNU1y3XahseuBRK4nFztnrZzASjwN1faGf/vg=;
        b=NYT4s7/WxilC1/1sPvh+UPIOWR9SJjnOLwFZSnllUr1YCDHIzbDMDLiuWgnqxBw7Y0
         PRbM5942iiNhseqaKDJVTvTzSDw4SvDnrwsGRPeo2O7fgN4qLlcToPtqo3+eS18B3hJ8
         X102c0QMhoSXpbtDoPMXDpvi1JtiEJjcTE1uHyG+qUBo7Y4mp7/Fgb5WAbIEvgf26BUe
         KWo4y3wb50lbndOW7NIwBagD17il6oLO5XADXsF1LokdbHvKOg+0TkNfMwbUYBG38Tv7
         s5edjsuuH/H+LfXV0bXOFtpCjSCunHV0HSaxhuCjQCsmsCLwyTgohC8/gygQVU5BjXkt
         Ylkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8uBxprC51mioG+BQVCSx8+wjbQPNJ901vEStsqlPLEFr3+3xCEYP1TnUjPB9vE/xAJUN0F02VvRHFgOQfvHGycGmmDIKKiVnIsGAa
X-Gm-Message-State: AOJu0YyvW0v05Pvn9m47W/dtZoDbrdKrCgrD6yKO0ky8ADgbGfy4PUqY
	0FLK4z1WXmKhQq3ylhje+KEdih4g5YxnkRxRfTFy9Mn72i3IIu3NM+Lh/5paXjK7KtIHmACAnTr
	z
X-Google-Smtp-Source: AGHT+IF3MbOHWe+Dd5cqT5itXTVz7GOfcbFYKIuZDqCR1HFSbb9PonNq/bo4qHWf+nls5HUXo433Dg==
X-Received: by 2002:a19:5e5d:0:b0:51f:b3b:6373 with SMTP id 2adb3069b0e04-521e0c63c91mr1124319e87.15.1715289626701;
        Thu, 09 May 2024 14:20:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d898fsm438832e87.208.2024.05.09.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:20:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 00:20:22 +0300
Subject: [PATCH v2 2/2] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-panel-sw43408-fix-v2-2-d1ef91ee1b7d@linaro.org>
References: <20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org>
In-Reply-To: <20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9SBs1y5K2hzjnYPD9Ky3KqU2SZnDlGyGsApyJDQKsvY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPT4XEcEqWGu8gIgOpNkqDt6I0aZl6LpNHXOET
 V6MyCND2Q+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj0+FwAKCRCLPIo+Aiko
 1fCJCACVl1Tw8GbFfpEssdYtGcEkG30m5raWG9Fh2513tdXK57a5ckqCyrL0UTfa9/a8hhidWFn
 cr/f22s7eR6cHMOArnoYrfA8LPtP+j5QNmGZpYd+RsBFja7fvTaS0OcfU72PPiGucFCdri3em1Q
 JuefnV2vAE55nQSfNzMwxyJb9b3QvZpAl7gkxQRRi4/PLrNQib0q4XQ7E7YTqKzEGar72mR58nr
 9OwO46TWEVauAGhgvg2ry8FSWGSr+Lx8JmahgGJ2+znKRNmnJL2PS+Rvuv545LDxxv2dK1otRQm
 CAn8U8TiOFVBlinh5cl2ZBGjX5/NxLq80+OLy/eR44GeyqoP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
declared.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 115f4702d59f..2b3a73696dce 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
 	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
-const struct backlight_ops sw43408_backlight_ops = {
+static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 

-- 
2.39.2


