Return-Path: <linux-kernel+bounces-351905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E5A99177A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D3CB20BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC315696E;
	Sat,  5 Oct 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="AVCvAsme"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B60156677
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139393; cv=none; b=QxkTS5moVhSfuT4WOJG6sOVyFjzrPwhprM8IQ6WaBD6gGbN9U1o3Vt2fPUo2aJyARJ3+8wSqEaRGFj6ce3iKMmriWseGVOkC+7SChq+bMrbnHedIt6RANNMaBhbqyvs2Onw6Iso9NHWFU8wEoHB/WH+ttnUuaxjSD7XTMWLJM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139393; c=relaxed/simple;
	bh=hL5LUAnF+UDbXaHFZ+fEtbiYCqaMDSrlvbOvYIhjGr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNze/rBh+9605qu4ensH0/AaoMCS/nmVzVI44KIJcWVNEGKlgSDyZK0PN/kkg+Q+89ImUvoIY82GO4iajXHYJvv+tD/33OiwmnulG0lGphlYxLsKkUtLj9bLWHnlYV9XZIDBgRLjXynUO1RfDQ7q6mYau82ICva6zfhxFV9dxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=AVCvAsme; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582face04dso26742101cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728139389; x=1728744189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q3v6t9jn9wO97ckfMU06Nl7EyqPnybN5v1LXUZU22Y=;
        b=AVCvAsme6XL+0glebVeWx4C7uB4SEK5XTEr82qNNJEeAkEv7WTtgehdAPVfOJjhtPH
         sLPad5AJR2Vh4ZahifHQczaXiYsRAyfeeHlqCsqmmQBYgJoJXNJhZo+SFaQdLf74Eu9t
         zwPx00nSssFLmCnu/hsOiJWsCdkmmGnJiYXCbVr9mjXOgcaa+GJ2WzttFYW7cPxqhHCD
         KIJJgGn5UpWurWnnLwY/ssL82HY8JFYnYArPIo34kACb6ymvWZC29lxI+xe35mCsSqXP
         qE6+Cm1g5VEO0bN7R+LeKSsk2lHwMlT8mpxQYltsyESquau/oKwagwTXiSKaZMR1P/RO
         2kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728139389; x=1728744189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q3v6t9jn9wO97ckfMU06Nl7EyqPnybN5v1LXUZU22Y=;
        b=dHYoXZQU8znqPmTgPRo6EWwh0sHqfUeN0QBB1/lgxwqbjvyWl9sgOXvqjGwiUyTNug
         CV1x0JC9s4gH93QiVI8Ad45xdCQoaTqnZr1w08krdT10bFAVFrHZyDL25IGqtb33Wjhv
         NXr/ex8BhIqjjbekuN9/GV9+SD/RGKid6oQWeZHzQsNGejJKgVRUDD+vbdVo+a/kLoOW
         r2ybarmIJE0p5jGM6N68Lwm2t7OwiBZQti72ZVTeSvRlX5tG/kLt4Ewz/v/xGpSDdriK
         OukFSYLyhw671YYS2XWrBsqLsDKUP7FjcOhH8gst31b34bUZYh7wk+022L6SEjty02b7
         6/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVsiATn3XsipViGuLj2onfsk4MfL7prP5OP56bYkXmTbOam1VklqBln5K88hxHMw0AMAf6D/CxmfMuy/VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCnlyxA2Fm3KRNY7C68uRFzLs+XcU3/3Gb2jzbJw1lrQIOjNx
	Nam0u12X5iPNg5lZXyrO4KeZq2jy22h78kZ9YxNEuykkR9/a1tYW8e+MjJ7ntEQ=
X-Google-Smtp-Source: AGHT+IEWb5+x3Y3IeQmM4IyDOj16+X6mmg0F0tQXBBJrX9v3mbYYdikTmesnSGEJYTvU+WKfBsip3g==
X-Received: by 2002:a05:622a:142:b0:459:a824:a1c2 with SMTP id d75a77b69052e-45d9badbcdfmr100318231cf.22.1728139389155;
        Sat, 05 Oct 2024 07:43:09 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74e9fdasm9072351cf.31.2024.10.05.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 07:43:08 -0700 (PDT)
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
	linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display hardware),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display hardware),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calculation
Date: Sat,  5 Oct 2024 10:38:10 -0400
Message-ID: <20241005143818.2036-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241005143818.2036-1-jonathan@marek.ca>
References: <20241005143818.2036-1-jonathan@marek.ca>
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


