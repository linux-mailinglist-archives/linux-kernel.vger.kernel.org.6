Return-Path: <linux-kernel+bounces-247991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59692D724
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8461F25CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB35196C7C;
	Wed, 10 Jul 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsGkDBh4"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DA1957E7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631120; cv=none; b=jvJ49QOfaxTX+0J4k3SM9KD/JKWs2bK1YCiAR9uF8vLJQ7P06GIF+XnTVB9U2nLr6MXYslioGqxSfHud1G+Hv2Sx5qGrkTqS7ZQXqvwh/iJeu31nd1noqVv15Dd5WpYNYNhCVsQL9Mly4DXdQ6mBwsWxSmRgSiJ2Cf7YA0F/XKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631120; c=relaxed/simple;
	bh=4u4EzVnigRGaEkzIutm5rdwG3oK439XpXPx5hpNTB2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvD7YIaU4LSvh6k9fTR4HgK4jFlHJGwQBA7s+cp5EEtMhLxtmAyP1BHxnOjGS8M4uy+xTh7UbcnzImI0eXk7CiTSSK5iK/mQe/URDeP8D2qBIPZ3siPwGddcMXNcioIiyiSBkL5fYkI/fbE1v+qahPmyIep7rIgWQRCycT3fvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DsGkDBh4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3678aa359b7so710233f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720631117; x=1721235917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g1Yb1+vfOCpHonxF+Jqbu5p5cwpmV8OmQtPa+jVmyk=;
        b=DsGkDBh4bRXaavMvuqB/oQezv1jE2QdIFeLx4Ihe/nBwclajIIjRUwfruDljE9JFXv
         t2OL9AwPQjVDezw1LJAGFqHpnNow9oaZM/q73aOs90fH5zjcIPkQqpaddmMKUks5EKk9
         GQUNo7cnhjvalgFE3DFfx7lCXKTYwr/WwQKX/yKEV8wx/tBHF102lO3tT5IHaRI3hP5o
         dbZ4goidzy8xqRIzqUQ+FHL6gtb94bagPZjpWwIDEZZe3OehhFvnMqoTLbUB7/nF68cS
         I2tKCuZyQOIjRhKlwHEU2wXXLyguorxvuSM1ctKqyu5haZr3iBK/VoLk5SZSgVz/lrQi
         GT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631117; x=1721235917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g1Yb1+vfOCpHonxF+Jqbu5p5cwpmV8OmQtPa+jVmyk=;
        b=V1rE4V5O9ccDtmQeEERjhSg24/Oh0rHAembxVUqDUUcJuqi+Jik/Wn++3jIGvbEV3A
         RAYkHwT/1Gv/AHf8dDp+5ERRtBgTwiemIPNkfMl9o6KOo7wUHDGCpCapfenP0xKHoo3j
         VtBCHfK6IvnPUfXlkQ1l9xYO6luVEve5nLR8i5I6CqEg+NIq/9MJo57sDEdUxxZBu4dy
         4eir2cVy51n1YtX5ajWmpNAU/UELTyEQ2Dp/MzUvwAWX2hWHCTIhF/BVysF8iO8jPqux
         lX4/Yu5ZUDmjU0I4yUtMMi4oAtdYmtwulk+Co+gG380WSORMiZMLYMVaP1mabDViCi+g
         bKbw==
X-Forwarded-Encrypted: i=1; AJvYcCVucnQW8TqTJ4qwgwp3Deg0IS9u+STJv7KXNOSHRHuQtfz7O9AhrUGcICorpWHF4X0OiKgNUUeVn9kcIqXNOjHEKhNn3Ko6qZLiM56N
X-Gm-Message-State: AOJu0YytDIYwZHTDpr5P5ITnhj6fyvXTEtpTLlIOQurP0tsCNsURyhb+
	Uii/Jd+KTSq6gH9pdpyQflsqC+wcuaO+Te9/ul9MBGc/c9FHXcgrSvw2PBeDTiA=
X-Google-Smtp-Source: AGHT+IHrRXiCsidR4X+LasiuthOFj9ICKMJe5oQgZWQE5LzqBbT6SBTjtUxtWEVsNWAdJXaa53sXHw==
X-Received: by 2002:adf:e0d0:0:b0:360:8c88:ab82 with SMTP id ffacd0b85a97d-367f04de8e6mr260014f8f.30.1720631116954;
        Wed, 10 Jul 2024 10:05:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:65e6:93ca:5f80:ea9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7dedfsm5838446f8f.24.2024.07.10.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:05:16 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 10 Jul 2024 19:04:58 +0200
Subject: [PATCH 2/5] drm/panel: samsung-atna33xc20: Add compatible for
 ATNA45AF01
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-x1e80100-crd-backlight-v1-2-eb242311a23e@linaro.org>
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
In-Reply-To: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

The Samsung ATNA45AF01 panel needs exactly the same non-standard power
sequence as the Samsung ATNA33XC20 panel for backlight to work properly.
Add the new "samsung,atna45af01" compatible to the driver to make it handle
these panels as well.

While ATNA45AF01 would also work with "samsung,atna33xc20" as a fallback
compatible, the original submission of the compatible in commit
4bfe6c8f7c23 ("drm/panel-simple: Add Samsung ATNA33XC20") had the timings
and resolution hardcoded. These would not work for ATNA45AF01.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 9a482a744b8c..fd56fd02df87 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -333,6 +333,7 @@ static void atana33xc20_remove(struct dp_aux_ep_device *aux_ep)
 
 static const struct of_device_id atana33xc20_dt_match[] = {
 	{ .compatible = "samsung,atna33xc20", },
+	{ .compatible = "samsung,atna45af01", },
 	{ /* sentinal */ }
 };
 MODULE_DEVICE_TABLE(of, atana33xc20_dt_match);

-- 
2.44.1


