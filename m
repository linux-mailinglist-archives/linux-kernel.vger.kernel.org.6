Return-Path: <linux-kernel+bounces-550731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61FA5635E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60C03B3245
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410931DE3C3;
	Fri,  7 Mar 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4F8cMnp"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3C1B0F0B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338946; cv=none; b=W3tBQIU7Tleahh5VwbZcU4leBgW5upe65q155wmnjfwPU9RmIu8HcJfz8K2sLdKHeI43XzqIDprZZnh2P6h/0XA5AYPNczJTnc+qQ0ZT7/8hx+VAO44dxbGKQQdswkZfq/R6WaPY+GFf8sBVemp2SwcSBYxsaOFy0hOu3JnxseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338946; c=relaxed/simple;
	bh=uDhPB6Wdeu7O29cFjTPggdUY9LUO2iDKwXeCsXYIMjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PG0p+u+OaDfvG5IxXduTtm+cr7IjVOvwinClnIvj5tM2qOQWyHVUD+jR+VbdK3tiUc2Zxs68K+lXhQg/wpBM1Scx6MvGn+cePjVKCaHJSDxkJ54qPG0QbeKDuk+pQw6gV3H0T1dqGxLg5sH9TBkgh+rpS6pHXFaNO3MjZQBtdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4F8cMnp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so3169431a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741338944; x=1741943744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTEQtsNDpMTEAuo12CfPbUrfIXkF/+bRSFAzAmu8bNg=;
        b=H4F8cMnppXZpFiKVdDrYdEwXX1A4Cu7GyaE/JCwxN7dIA1DtaQmJjyfJgvTQZc0MRc
         l9jqHOOCVSnS6rLlHaAmjCJTHCgihseYzxb1AmJ7fkrXLB3BHnwL7cS/SRkNo1aToXfD
         1qnMo4lQaOto86jzMLu9scnJuqoTV40gi45n6xOpsifre4eRtbyW3rBoiT7zGYW87EXs
         uJE41Kv1QFT8yTMEe8MvAxoPc/SO2/57LyQgLrJGh0RtqP6khccsLfLFsqAsicfvrVqb
         KqmEiEqNmy2ielaF3b+PY4b73Xze7buSyIaAfm+qwgdn6I2ekcGoWPOHLSrEqepXgzNI
         mRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338944; x=1741943744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTEQtsNDpMTEAuo12CfPbUrfIXkF/+bRSFAzAmu8bNg=;
        b=o0zEzmPitfaAj6iJ3dOxETne1g17NUOyChpOCTebM5aOta/Tlmmj7Zl6oZ5aG2KUOU
         8j2OKxkVTv8qlFx938PqP4LMh8ZZGmM5Ts5uzCiKUKv4b+9O93znhBoQCAof27n1z8vq
         vnYuVbsCwBsLZOXT0jUjSffcQ7iAGTqwyfI3B/5CGKxwHMR9Ov+GMqHM0FGqs4tcrWBR
         TaKiUITIUQZgHS1VzzNbXn0NMwoPQI0y5WAjfOBZFKjnUqzBtkc0Tv5W1Bp6dJceoRAq
         Oy3udj24XmUdJm/AZ74QMHixjfeRcvLuMSs/xUJ7ioY+q3PE1heu66DhIZ8G32FPWgyp
         yH4w==
X-Forwarded-Encrypted: i=1; AJvYcCUvK9VHBeRQQF50MR/X/HJFCkGNLGhzDiHZs/Ykiz97FaQS9Yftf4F4oQzDuptkSbLbF1pNfhg9snsMFxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9MYKBPY7Ef3vCMEHHKxN2hBENH6+XA3rAY039fTWnBaQt1/h/
	tLf1ZEDRORkE6PzeuJ4pAVjOfSXoqSQoBTu5GhJD2xYyZJUXB1nG
X-Gm-Gg: ASbGncu7dzPc39lRbVm7ynjFeCUIoExNh65Yuc+ZGPIxnAAH+aR2jYj7hoxDOyg5LiU
	xyt+35XchHlvI9LRFrbgVnCsY69VoqJaPgmza13xGpBY4q873+RPLPJ4qqGxWUjZnFuDlrhaEM5
	mOqjGCToh/2RrAkL8629mr0fb2dwk9VcosiaU7PhSgw7yz2rigYBkhs+EBbBwp+l5jfcZGnEXa8
	yXurD7iIJNNP6YyRHWr0y0WT4IddVHrJxEipmfADSvyvfa5jy9DZs9fjstGCrG3o6sCxMmioZ8M
	9gWGKmk7aFRm3RFC8PW409lD0Pq2s2iCQLOxiEvzivaG4zn2D4mUmFz+0vBdVyg=
X-Google-Smtp-Source: AGHT+IHPQP3t6+AgORSL6BXyyzUz4ljqlr/LPYND1h52ZOt9zldf8tqnLuWoYqmIFgWN7aKpCbjxsA==
X-Received: by 2002:a17:90b:3ec2:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-2ff7ce6349emr4649914a91.11.1741338944384;
        Fri, 07 Mar 2025 01:15:44 -0800 (PST)
Received: from distilledx.SRMIST.EDU.IN ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109de11asm25563985ad.31.2025.03.07.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:15:44 -0800 (PST)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lujianhua000@gmail.com
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	asrivats@redhat.com,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 1/2] drm/mipi-dsi: Add mipi_dsi_dual_msleep
Date: Fri,  7 Mar 2025 14:45:18 +0530
Message-ID: <20250307091519.245889-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307091519.245889-1-tejasvipin76@gmail.com>
References: <20250307091519.245889-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces mipi_dsi_dual_msleep to make it easier to use msleep in the
case of a double-DSI panel.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 include/drm/drm_mipi_dsi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index bd40a443385c..d9bc0d79dd82 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -306,6 +306,12 @@ ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			usleep_range(min, max);	\
 	} while (0)
 
+#define mipi_dsi_dual_msleep(ctx1, ctx2, delay)				\
+	do {								\
+		if ((!(ctx1)->accum_err) || (!(ctx2)->accum_err))	\
+			msleep(delay);					\
+	} while (0)
+
 /**
  * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
  * @MIPI_DSI_DCS_TEAR_MODE_VBLANK: the TE output line consists of V-Blanking
-- 
2.48.1


