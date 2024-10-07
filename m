Return-Path: <linux-kernel+bounces-352755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25069923CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7E282D25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68013E02D;
	Mon,  7 Oct 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="ZeY5+Ac8"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B3139587
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728277567; cv=none; b=QvgLYZOdmAzbcQzJXqlSnOtFQNySFYRuXcKwhP15+VWdpcq2v0FtuvFl1zvD4ZhXEcifEd7+ETr8Gn2Eoo9GpUkHAGzS2EEXoXBFuJFW/fIrxNg6ycIge6ITPilN37gGHTKH77UzUJGRTex1Zm8IYtgun/6NOMWBw1hIGnd0YCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728277567; c=relaxed/simple;
	bh=ujofgh8m5JTONe/z8Xr8Vbo4E2Up1qzrwf2x/zVO514=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWPfBO8XXvyJoicxA5zHcLXheREWgjxe9YKgD0u8B5uIxyiBYsQRyljhW9Bva7IvnWETvFPKK5zuzoehcoVncAF8Rm94AhYrOYllZ6ZhaqsYrb5Nk52HWO6gHtpdjM/xjVVcOoz/y8nzeWT+WhmJ1vToLNDQoUUpA8WjHHDBOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=ZeY5+Ac8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb54eef205so38274706d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728277564; x=1728882364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c05QmqKO8Yo45LGADbAWzf+kRfAr29i9++XErp7UJmk=;
        b=ZeY5+Ac84cmlNYagV0vHpvxbTL1A80LOTyPqX8wF8Wt66mzPMIu2WE0Kh3o5T2Ap0V
         fzF77YnypYKclslFpg8zQiTgZaCsQz+UGq5krKwTQPGysbCztNZQqfInoeqUL3+7YJ6Z
         Gjc1+/eB3fSwu2dvvdBCIdTqnf0COTFH/cKA0XfikiNXKMkyEISczFzuU1d1zOtHXVkw
         quN392X4w8XEQ1wcab7wDmg/UqeacUUzEK3zk8L3rwSNCN/j1kbtiOwWftQ6Di28e5H7
         jLxcmouMg72fmKJGT9zy6rMMWcY4pDCGeTi/8sO5kzlnHgeamkYLYQmUe1BX+J0SuGO3
         mhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728277564; x=1728882364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c05QmqKO8Yo45LGADbAWzf+kRfAr29i9++XErp7UJmk=;
        b=UBiro8QdyA3WisLwDzpGViunVPqkv8LPyUj1hn0SKyCi3QtrBz4585jmYQwshaB82f
         fwUfInCqJqidBjpPpsrarRNeFpQmeDxmMqlS9s3xKgc9BgTZyFuSVWi90+XDDxWdmvpW
         JlCaTHaWntF40ojawXCmSR6OH9T6vnfJjRIua93VS0AZAXX82h89c1nnk4gUH6RsTgiG
         0PY7vN1yuvAW1Ejq9sml44Ua5/iEmGqXlrSgTH0orwNiQBJto/yd4Enj/hBv77T9Pk7d
         3P/eyQwIQ5fMA0BujGM5KT8rlT6TE6wgouFvUhq4EbWR+YSFlcPdA5C32JFeIa2mxmno
         aUXA==
X-Forwarded-Encrypted: i=1; AJvYcCXUki0wcGhEG7aD05e/ASruuO/VN1Sv/U9NJIns5bBu1jpNM1NE1YMPfKJqfkyHJN/mBP+kiHV3a8JMWTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHydvXZrGEZt7Aya5FZJr7XSZPh8yNxz/UrgIr1QY2NXjAXrNe
	B6Yc8bvgkuK3uFSRyP1rHSsBpRT7751nxlxRQi9WCUKemV9IKIE+XlkYW+/Jkmo=
X-Google-Smtp-Source: AGHT+IEWxrxm89ar9oCXwy8ju2UWdzVDET69V1sE10TCiENXP3CF9q530YGphHlLEbICHowgYDYfMA==
X-Received: by 2002:a05:6214:3bca:b0:6cb:2242:df32 with SMTP id 6a1803df08f44-6cb9a2ff311mr159433696d6.20.1728277564552;
        Sun, 06 Oct 2024 22:06:04 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba476152asm22452216d6.126.2024.10.06.22.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:06:04 -0700 (PDT)
From: Jonathan Marek <jonathan@marek.ca>
To: freedreno@lists.freedesktop.org
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display hardware),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display hardware),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation
Date: Mon,  7 Oct 2024 01:01:49 -0400
Message-ID: <20241007050157.26855-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241007050157.26855-1-jonathan@marek.ca>
References: <20241007050157.26855-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When (mode->clock * 1000) is larger than (1<<31), int to unsigned long
conversion will sign extend the int to 64 bits and the pclk_rate value
will be incorrect.

Fix this by making the result of the multiplication unsigned.

Note that above (1<<32) would still be broken and require more changes, but
its unlikely anyone will need that anytime soon.

Fixes: c4d8cfe516dc ("drm/msm/dsi: add implementation for helper functions")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 1205aa398e445..a98d24b7cb00b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -550,7 +550,7 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
 {
 	unsigned long pclk_rate;
 
-	pclk_rate = mode->clock * 1000;
+	pclk_rate = mode->clock * 1000u;
 
 	if (dsc)
 		pclk_rate = dsi_adjust_pclk_for_compression(mode, dsc);
-- 
2.45.1


