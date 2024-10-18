Return-Path: <linux-kernel+bounces-371728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87919A3F44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D931C24971
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877081EE03D;
	Fri, 18 Oct 2024 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zVRx0C3F"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76221DB37A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257239; cv=none; b=gNz3FAD1HKWpHEwduoho2K9jNRcm9GJRtPyik81oIT/z0T6Ck8xdWXHNCD10KOzBC1bhA24ZJAzCtvkF6lIcMHEFGhbERPRB06jCI+FwZaZIUOLNqBVK8Fgfndc15tT7r2g1AL6LpraYOzSSqLY14gv+uX/JU28mVvI5f+IPtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257239; c=relaxed/simple;
	bh=NB45991K7Ms9jsA44c2xcFQtcsIBGFYUerUIzKgBLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/Ns3k62OR9SH1nhWpzgPTmgo+LCJ46m+STl4f1/qLygitMCKqJke6WayjAOu/vVy32CrmHjlccsz7irsqssot468cD2aD2vPjFAbUR/m7TIRnM33Mb1TQ+6ImbIBPnsXVjIp1Dy6Lbj4jhcxRmyJ7H41KZ/Kl4cCVC5BhhsT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zVRx0C3F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so22194295e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729257236; x=1729862036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlSYa9vfuktlSXtZvjf22SWyJ4rTX6wmBTHW3NREoxk=;
        b=zVRx0C3F8tCLSYy8ij8USM10shDdXUAsnULoVjQS+enFt9d0jgQR6DEbGtmDw4Cw5P
         o7BQxPFLTSNcZzCtzjriflyNe+Jg4Lu3mmAysjhj+esgXnJyjwN34helUBoGRk29YLk2
         4L+OE+RJ3WyUvoHQpIPTbHRBSF/QH0jKhQE+9yZeOO8KsdkhrEfVda6ZAoOnjFxgR5rb
         gStqFdQLRR6E0QoZsqeCOIgGAAebTzdhPtaK/a8z4lJEKps6dQzlfzz7QvwkgAtn2Vn0
         1pdCSC0N1xi14BO/r44r6nBwg5xeRTON8a/Opr6LhgDbaamWCadic/+GN7rVZrsvTwsd
         yeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257236; x=1729862036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlSYa9vfuktlSXtZvjf22SWyJ4rTX6wmBTHW3NREoxk=;
        b=vG0UIbaJhUUV0OekGMmZgm8M0+XuImmW0oBqiLsR7M5gCe+VAuYCUV2892WM+6KE0G
         LRbfTViXmeLgmBwTDQzT6UY8yUCxgtL+uZCEOsZdpd+fCegRvcvWmDRnRa9kmXXFJ+7P
         0fyfrfv0mJxaNZqDkZOplMaZH866m4w3WGtezTbXbUTi2oAeOnUkUg1KClUew6C98O0x
         UNy9AWQ1Um6si//lc3pKbdMJuKXzsJZ+4xcxZbR7sUUjr10wmC9awzCjc9lO1xWm3zWN
         p9K1KPIqunetYDcKSOwFJWcRg6fats+6GuxK/isJj6InEohIEFj4PSnCd0p2bQ4h1Rar
         5Ecg==
X-Forwarded-Encrypted: i=1; AJvYcCUQf/N270X9rnlxfbE3+8mVv6p+WSZatqxlqY6vd2x4evfzNA5orRKYPFV8sGUPjaaM0YII/5i8sjBuuIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanUVIt0J1fhUbzw1qpWIJ2SkNqIUp2RSLQHfcYVNN4JsxgwSM
	UxwDVuLLGTyzMtZxHSk5WlD596nfVGNXs1nyvppE2ttQnTbckGZ9j+Q7R6h+qzs=
X-Google-Smtp-Source: AGHT+IFtrLhtA4RdfGFjondj6Bc9qeEUws8zUg4yiVAIXWGgN6H2GsWFhKhx0HqWC/5WiPZ+dm1LxA==
X-Received: by 2002:adf:e791:0:b0:37d:5299:c406 with SMTP id ffacd0b85a97d-37eb4769230mr1778709f8f.38.1729257235956;
        Fri, 18 Oct 2024 06:13:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf114a26sm1897561f8f.90.2024.10.18.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:13:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] media: v4l2-core: constify the class struct
Date: Fri, 18 Oct 2024 15:13:51 +0200
Message-ID: <20241018131351.70563-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All functions that take the class address as argument expect a const
pointer so we can make the video class constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/media/v4l2-core/v4l2-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index dbd6fba93179..5bcaeeba4d09 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -229,7 +229,7 @@ static void v4l2_device_release(struct device *cd)
 		v4l2_device_put(v4l2_dev);
 }
 
-static struct class video_class = {
+static const struct class video_class = {
 	.name = VIDEO_NAME,
 	.dev_groups = video_device_groups,
 };
-- 
2.43.0


