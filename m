Return-Path: <linux-kernel+bounces-357307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A555996F70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E627F280E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DD1E2611;
	Wed,  9 Oct 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYSCu6RG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AF1E25EB;
	Wed,  9 Oct 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486556; cv=none; b=GAkt2KTuQkk7SYuiBJJ/bMmSHeKkmxvuqaIBalWF6k76aQmK7sQDRCeGD6Sc4/43jD95CmvmV5rAJ3fIbppHoWVnBIUHRbCgms5ZCL3wDpLPuAEXnhvGv5D2JiHFaGkVd7GoQYPKGpjNybc7Bp5KsoUm8/h8hNf7Tsc/A4iys9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486556; c=relaxed/simple;
	bh=8E4fr1Sq/NtXc9NlBNm/OB/QNGso+ly2Jqs2ZWzRZDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvYcBi7VDVx75bax2FJsIm1GSuvGzEDyARxyKfOAKPyeb82SnHnHR7XdH+fvx+YRDXwEyxcbQXjog4suRUqajGat/ilMZK2r8WXDpctjQkgM7gdyaqJt1vQj/5bXGWh+ggAEkQlJtZHodyM7QpFda5OCDpnZ95Xg7kuPCSlpffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYSCu6RG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c91d0eadbfso1246142a12.0;
        Wed, 09 Oct 2024 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486553; x=1729091353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEvUlk1jL136GgzQVqdT9mrooxY8Q/uLvCPC41MEpWc=;
        b=BYSCu6RGTBWRZa+gzFarYHW2uxnvLADBuaW5i5DL3Dk2Wdi2277SBIk7hefjy2dnDP
         mTCiOw7Xsag6UytaxdFCP5O24xghyCT/2xuYsSpg9tzYO3A9wAOKSor5F5PlUFnbO8Xm
         Ukts1atHYsPbOBx7rnnxxwB7rk0Kc8aVZpNVUC19+F5Rq1xegRzCBQ+Q/ACC5BAb3+Yn
         deaWcRirRjtfz1XGK1xQ0aY6nv1DXO7+d5GnYdktxngun5v/MIugJtUUWetrw6RRjdFG
         x4qr1z4p1UTfJn4WsR8RSM/maIcFOn3czdr78GYcHNO8oOLpCpPwjMNSFXsE9dtu2B5V
         DoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486553; x=1729091353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEvUlk1jL136GgzQVqdT9mrooxY8Q/uLvCPC41MEpWc=;
        b=iD31KVN75nIZ07cLAuzJE9O1PeRbNOt6YE5i6hH4Ip1MgmNmwWbARSz8ZqaJrsDZM/
         iGnDLG9PJDGMN4F4qzyVoejgWNIyDAPaTxgVrNPX2L8EmJdjdBf1nMw1JbxU6eT2DRfV
         KvfAwN5scoOsuRdM7qDsVmLMIunQ/ORI0WmsFkG/dmXfGZYMrPjkDxn5s54lDAk7nh4+
         i2T+J7Pg8fw/V3Z111zpLg/EV+z/ZvrZhbUa3HHLig3fBjG8QWvprCvbNNYsIJ+giqb6
         FM/WwXxwRZTsDp2jwf97FVcZvZmMRlDT5FqEuD3UU4lfV4mH9rcnm1VuZABH63plOLtP
         i1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxub6OjtWO+2xtYcp841bW0I1Y+/w9zrbNO2JlSHmODmKsiADcM6lUBFXD1o5UnmXtg8XEFWc5tLia@vger.kernel.org, AJvYcCXc2VzmwzcbmEqC+uDaCrNIAjAtZNtIgUbADuf+t12eVu4dTQB8wVbwCM/hQbhL7MdoAjz4kbGLBmEnOsac@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4TxtO5Q5gr9riXumI3rxBfBe1TCptb1YhYbFwrjKEovWUa0m
	U7tW/BJnGihCalccT/Hi9/bTvxA9wwJCJkpsJYjdot8Lrzghil5m
X-Google-Smtp-Source: AGHT+IFpmC0d/mSmKW6krwhiMHYg5RC1Y698kV0WymUaPKy3TEmRyQ4FGV+J9yIkDTIheiYLIN+iZg==
X-Received: by 2002:a17:907:9620:b0:a99:4601:b9d8 with SMTP id a640c23a62f3a-a998d34dd72mr221987366b.63.1728486552647;
        Wed, 09 Oct 2024 08:09:12 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-107.telecom.by. [46.53.189.107])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e7b19b8sm668861766b.154.2024.10.09.08.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:09:12 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 09 Oct 2024 18:09:06 +0300
Subject: [PATCH v7 1/3] drm/mipi-dsi: add mipi_dsi_compression_mode_multi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-starqltechn_integration_upstream-v7-1-9967bd15c7c5@gmail.com>
References: <20241009-starqltechn_integration_upstream-v7-0-9967bd15c7c5@gmail.com>
In-Reply-To: <20241009-starqltechn_integration_upstream-v7-0-9967bd15c7c5@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728486550; l=2054;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=8E4fr1Sq/NtXc9NlBNm/OB/QNGso+ly2Jqs2ZWzRZDo=;
 b=3lUOctdE19ggiM11q2NWrCsulpMt6YIvZwdld84ZfRF1xxEwgUNOc/0E6sjnhacb1QQpmn5rW
 +UfFVu+REpyCxjbZlh5SXgWHsSvzNbXq/x7EmsExNxjBBTHAO1nUPkG
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

mipi_dsi_compression_mode_multi can help with
error handling.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v7:
- fix kernel doc
---
 drivers/gpu/drm/drm_mipi_dsi.c | 16 ++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 2bc3973d35a1..5e5c5f84daac 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1520,6 +1520,22 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
 }
 EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
 
+/**
+ * mipi_dsi_compression_mode_multi() - enable/disable DSC on the peripheral
+ * @ctx: Context for multiple DSI transactions
+ * @enable: Whether to enable or disable the DSC
+ *
+ * Enable or disable Display Stream Compression on the peripheral using the
+ * default Picture Parameter Set and VESA DSC 1.1 algorithm.
+ */
+void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
+				     bool enable)
+{
+	return mipi_dsi_compression_mode_ext_multi(ctx, enable,
+						   MIPI_DSI_COMPRESSION_DSC, 0);
+}
+EXPORT_SYMBOL(mipi_dsi_compression_mode_multi);
+
 /**
  * mipi_dsi_dcs_nop_multi() - send DCS NOP packet
  * @ctx: Context for multiple DSI transactions
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index f725f8654611..94400a78031f 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -280,6 +280,8 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
 					 bool enable,
 					 enum mipi_dsi_compression_algo algo,
 					 unsigned int pps_selector);
+void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
+				     bool enable);
 void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 					  const struct drm_dsc_picture_parameter_set *pps);
 

-- 
2.39.2


