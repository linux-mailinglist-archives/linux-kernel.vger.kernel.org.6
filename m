Return-Path: <linux-kernel+bounces-194971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFA8D452E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA476285D28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DFF143759;
	Thu, 30 May 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1EScMSU"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8EC14374B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048668; cv=none; b=hQAnqOspUknCl/N6HVmukevfolq8DrJli5JcAXJlQEfi1DNuRRGySO1g5kQnBMTEJJmzHLYK5NU28r5UfAEEmXkXS6dou5P/TGmQNpDHVQahDhzi514UA7Ilc9OlLCcZ2YEsQscGiimdrGZS4gFxq6stVvoppZGOSeV6IoFHOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048668; c=relaxed/simple;
	bh=0jPSvOpzSu/1ntW+xRb8IeoZJjfEOY0fZfjsMUnNYOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIFGDdUHOn8nM/FZTN2tR0SP72hMmy41IlthnQIiwzOTcxM5olroJQYUb8YZ9AaI13tVFt8y5sIV6MGL7QkzQ1g+XG2lFT+qQGIP82BAgxe1LYiKjEzeeyxHCzM7pK+6kIXtCd2/zXijSwROvKH5/R4omm61i15PebWKkM4ZIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1EScMSU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a52d2688so4416655ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717048665; x=1717653465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Spln5gkQq1YOd2fgu2vLWG7jbq/zrTdhGVBswcY5AYE=;
        b=m1EScMSUtrSxYyOI5y132Z4mB1HhGmbxr+wkZ7xSx6Zxp0SQ3srjBC6fd/2IDsC8U9
         CnNck767zEpUPOr4OI0kLby0e+cGR0L7ifwGUN784Eg9+QDyChjFQJOglF+RPRo2iJRZ
         WJXAeCzmsN4fgxSP73sw2dA7IE7onBWTQNL2OKGf7NJhX1+xb0NUMmzvXBRShtZcZBy5
         GUyCQ5P++CgECixG1zsRngmJcGMhh5uMJ7Ow6vMQnLbTURI2HiPPZIxJ62NtwNO1y9E0
         RUQtuL0VC1EQs4fOEbhYlTUIJ37H7N4b1G1Itlw8ehl83UppKqdEwHa1eluZbGq1Jgz9
         zwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717048665; x=1717653465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spln5gkQq1YOd2fgu2vLWG7jbq/zrTdhGVBswcY5AYE=;
        b=ugYoj09kL2bKM97Vs7lsV+UvdXI3TH54ddzOaaRvVb/wbqoCoi+Kekp3eQ8Cnzj12n
         Hcpdfvwl8llOLLkx+lw8+Cm4DkQAOGzGWB7snPe+oPbCL9PNy3Cr5Ox7wuk8iP6rh56E
         D7Pti9xa31eYk0a29TqmxsTiQIzor5f24A7uft8r/49QEajVfVu8juaMwS+smuYNt5O1
         EnOfzEoW4v8nma9G0BBdqRH0ZKbOhGztq+Ba0dt57rYcsNf4rbk0Yf4v+V7zJ42bPbaS
         BYxmSEZWt7uPPpcfn3C7/JaMzVd+R25N7A4us7/mrjlgV0c66gAg5lAOXRWdDjV0aSJo
         QExA==
X-Forwarded-Encrypted: i=1; AJvYcCV8NhT3J9rHDjvyhKlvD+qAvpTyyKkOqtUzPB1ALTPHs7viFGavfcqJ3JORrK5IHP2XEgg7lj1Pe6514hQDhipeMylG/0zGCCNNHNLF
X-Gm-Message-State: AOJu0Yx0EFsw1A/wPekZ9+HmQm1PbYFQng1mCZEwCJBYJ1WcpT7ku5uY
	0PBncMZ88XLIJH40e/vWDpu6AUituv2wukKayT9W1NSnixOCySF6Kan9pZYxXgs=
X-Google-Smtp-Source: AGHT+IFHGmhHD4um0/YgnzgPupfzLskpRYLEH+5hxpvbNZcFbqfu8eTLCu216oAgm44KsWnK1kos/A==
X-Received: by 2002:a17:902:dacb:b0:1f4:f1dd:5b5 with SMTP id d9443c01a7336-1f61961b919mr16621095ad.20.1717048665030;
        Wed, 29 May 2024 22:57:45 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75ffc6sm110006705ad.9.2024.05.29.22.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:57:44 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 30 May 2024 13:56:50 +0800
Subject: [PATCH v6 6/6] drm/msm/dsi: add a comment to explain pkt_per_line
 encoding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-6-2ab1d334c657@linaro.org>
References: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-0-2ab1d334c657@linaro.org>
In-Reply-To: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-0-2ab1d334c657@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717048617; l=1459;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=Ol91YDKyTosh4Px1J+abmBIR/KLUuHmXbEEWr2MUT+k=;
 b=GFoJEfJHKwlXuosM2S4bqgls61tMVX18LSIpIQv6l2QxPPxTGxRqjEQ5KCf4se6vDZ7v9Uygl
 rpXXCtGSUOFCwJ8drM2z4tafHOOc7L2ce9pH+dbtzRUpMPwf4YHhP4s
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

Make it clear why the pkt_per_line value is being "divided by 2".

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 7252d36687e6..4768cff08381 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -885,7 +885,11 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	/* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
 	 * registers have similar offsets, so for below common code use
 	 * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
+	 *
+	 * pkt_per_line is log2 encoded, >>1 works for supported values (1,2,4)
 	 */
+	if (pkt_per_line > 4)
+		drm_warn_once(msm_host->dev, "pkt_per_line too big");
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EN;

-- 
2.34.1


