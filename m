Return-Path: <linux-kernel+bounces-188734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE208CE613
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22751281630
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935C129A6D;
	Fri, 24 May 2024 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IU6OUHfl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BD12BF25
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556821; cv=none; b=IuPaLJcOplxaSfoJghsMRFO74dPC1xA8Wo+3A1ZVWjYKdeVdXGphBTdp9hSMIFl8ktLoBJNXb+E78jRSZjcQwLqC/fbJ5FQ35AWwB8Lp5FB+3Od02cJP+z9LGhKQjWD3WBUkCESsBOSKXya1uRjjUA2NjC1wR8f0t2HDdxnBMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556821; c=relaxed/simple;
	bh=OWccy+nICEZUKQPwByjtML13iQY9e7N6XueMvybRfeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOGKm9xEzmDFtqvwnBhKjVVUPp9GAcp33Gg8LBcx99VPRr1dqbTjNaTvaOtdsnfAbQ7tn/Q2FeLFTH8DuQAqQ1dFTLjVkbdpYWPL0Rd60XFBhfptZ7cryfObZ3rxGB4ufjWLUF5TweDwbj0R+4cqDHwUrgj3qttt2YiTfL77ybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IU6OUHfl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f8f30712d3so467209b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716556820; x=1717161620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7t4uYmRqlJLrpJDiHKBdOulRnB5HHZ6HHejKDBAJ1A=;
        b=IU6OUHflzIQ3LfNWG+D/bimD1ibzNlg5vbkENyYCu7VHlHbOHRRHO+56AyE9NgAB/V
         xo5e2KJC7hBIwrbnoo+v8WIxMq4po4ctp3cLrHpXtc8mBenItZMbem0Z23Vu0BJXu0wP
         sQssISbCmrgdCOw3bJ8q387P63TlDeWi26icPSnwxjd/AH25VwumZh3GGKcn4Z0DqKFI
         cv9riteRHBYsetWnnlo7m3Y0asSU32i9+kGfhFjPFD7Be6Q4Ku2+4aDowjzspS4YiDuT
         Tem0EglvGkJFzlQ49/niUDtDQ9UM7a1NpLdeLGgJkeAbljc83KopoVGofRibhA0hNsbi
         R/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556820; x=1717161620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7t4uYmRqlJLrpJDiHKBdOulRnB5HHZ6HHejKDBAJ1A=;
        b=BPSIgjq0HNMN8UcXA9g/y7RBr8UM3s4huwjHJMQxRJHXwTJPBAJlUggzWt8lyDiE2a
         2JfUaoRFUp9CGE/SLaYkLQ77LzVR+IP6cQBES0xZ56XGch4xSjkgpnvAbW7MAtl34HNP
         kH+BMFkA7/T49nluotDMn4uKkDk00ttIAqTh1XKkiS0vAih5mbNhLW7T9pdy0BNFSfDK
         cUWkE17kW/o0bLcfA11SFeFiroDWZui9Q69scEeN86PczqqOqjx1NF3tv9zQdce3vCHx
         bS0eC/lOWFKq6Q/2weHxq6OQ3cOBEF1kbTKnDsXRGKWugoVggFDGOV1zP8nRrase1PWJ
         Zl8g==
X-Forwarded-Encrypted: i=1; AJvYcCXQZ05nZt/kuTdJntLT0QjBe8qYrHPna0V7mD/xhVUHEutujDPsJ+AADEzrnWmlpNzNH1ZZfH99F7FIFpbh2MmM53DqGSuD/4hfmEXb
X-Gm-Message-State: AOJu0YzyizFdzTFdv6R0Bwmch+6YHYhFqQ4gg4B52aE9seRGO4EhzOlX
	OOpr9yzYwDpFCa/y+7GV5VhoULHDlx0M5oqJXxgnRRlnO74wu5fVtTblmGqe3lQ=
X-Google-Smtp-Source: AGHT+IHKqrriJSvWlSL2AXQz2HqI+Yiz7gfhITS8Gwwie2F6zWm4wV2V3P9tfoiHsWR5eUyC4vIFvQ==
X-Received: by 2002:a05:6a21:3d86:b0:1af:8cc6:abc7 with SMTP id adf61e73a8af0-1b212d28770mr3034833637.15.1716556819791;
        Fri, 24 May 2024 06:20:19 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd2d492csm1117852b3a.179.2024.05.24.06.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:20:19 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 24 May 2024 21:18:25 +0800
Subject: [PATCH v4 5/5] drm/msm/dsi: add a comment to explain pkt_per_line
 encoding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-5-e61c05b403df@linaro.org>
References: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org>
In-Reply-To: <20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716556778; l=1190;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=hsA6cTh9A+abQ7dtFiITzQof1AHhT8P4eUkFfENrPaA=;
 b=rda5R/WGjjaZFeTS5BHxnspwaWD3dcdhQZQeU5xyj00vWyacOIsN9uG3MPOVi/pV68aZ9Wj2n
 NWcHKDGTT4NCuaISuJLgNbItYGSL8mEmt1TuqxUTZkwhEHUl9RABCqe
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

Make it clear why the pkt_per_line value is being "divided by 2".

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
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


