Return-Path: <linux-kernel+bounces-329842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A197969C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8872826BD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEDA1C5791;
	Sun, 15 Sep 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNXXgqJp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599781E49B;
	Sun, 15 Sep 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726403997; cv=none; b=eBlveB7GMr4dPQHHswjSVadzRgDb7GBUKHeXDJVmziDA3GVFLkW86tk+9z4z8DzXzbuVsfqLiENXe9rfMiBfIpQ79E5DunI1qL8BpncK69hItgxarsZRb7o7hM2lQYcgCPWRYuhfCh33CyWsqrqn4lyVWaUFCbRlZ0V1KIe1bC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726403997; c=relaxed/simple;
	bh=Clr2rSHeFgY0iiLEITlY+Okn/Qfpa6MvIgNMUUsH9DY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=arzaay8EhrirGkMcp1BISgZB3NAB++OAtOD4osy19WlxKwk26KQPTeJY4QdabezOAPKHaXyJoEcgRMjisPym//2k9PIRjNFnACsTniNS2AEslaVkgQBTpaVa++bp85e2twrPFHiFzWAHFeTlwL/wXX1QWjo3q2OqX6iBNl7Gkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNXXgqJp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374cacf18b1so2162597f8f.2;
        Sun, 15 Sep 2024 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726403993; x=1727008793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAJvtt6cCaAPu3t5jkNa8gI7ECPeAAidmTEnPEphaJs=;
        b=nNXXgqJp4Rp6B4CHhVrX1G2Mth72FkZdbRJn8G24bYgG8RTW06maRj74V5Bb6dU6hx
         fIMuRpbZ6P7X5+PyTSUp859MzTMa6MmJv1eL0kmj0QtHqquz290AFQygxuChEWDG+JT1
         KPKx5TaP0Ug+9BpN9QLRwSQ21B77gNCi3DNsXFrMAJKbnVsnd270LDjC39G+MD2tmjjC
         SBWgW8QRDwdnLTeLzZLikMNs2gCcptXDyUqBHAhJ5gx4HERKwaKb9hwvbGk13iioNMiT
         1jhUvqLBQ3VuhXuF0VDRfJQ0p6MVfpQy/sTsI9jBo712gay2zKtU6ddcFCxT7Fcv+77A
         W32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726403993; x=1727008793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAJvtt6cCaAPu3t5jkNa8gI7ECPeAAidmTEnPEphaJs=;
        b=WgtH6Jnyu2XwgTcQ9ydWylCylD1OBnHnh2SklPhDTloBNhHd+xY9YINTVsJGkzC5P5
         TRAXyFm0Z3sxKJdIVsDB4NfRet40Em0xbSXudKh6Wj/wmOn54qjxh5PGH4bZnaxDMu5e
         hlQCj8Dgy9G/CZGXKk/b+foYenu1bUxrCI4qXzr0Qffq7IofBIPFskXFTyqQh8at0DdG
         32PM/4nRnHEcyCEkUWaqFH+K4kXdMBeeAj+uSRGkB+xoEy2ajLHQ28XnVpiWusBx8HzH
         NdEU4bQurn+IGUegm0+aFQTmGAQesLOYkv0lLUGX/Xtvft394Qd+lJFrsb/O/yKJ6Uuk
         9jCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqzAdvrRMLnriiLxsySJJIhyuFd8hLA6M0KrKZ3LtpF3qDG9ly+JPFe1ELu65eGrZHguqVLITzL8a6ZvcI@vger.kernel.org, AJvYcCUxgyM0lRIBE3v40aDJ0MVahO00ElOB1Bz0erB8jjZQWonUvJCvcOwvclRp4+RDA/TN+qtMNMuG3Um7gfhDZ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKY620y/6Kd6WZFV1CuE1EQ04pAGvwXJTGI2yzxOXRTjUXUaT
	6j8GYwIbGfxJ4kOGEeh/hf7PtQcK7kz9eQYpcrTt8mMF/JUw74IE
X-Google-Smtp-Source: AGHT+IHBPPBKefp8NRK/dgswYdOSXCV8qCsyXvN01NXfuxQbDklw/gSHxJdtyH6/9QHf15El0OwTqA==
X-Received: by 2002:a5d:5e0b:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-378e8cd72fbmr2497222f8f.39.1726403993391;
        Sun, 15 Sep 2024 05:39:53 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4a46sm4599867f8f.14.2024.09.15.05.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 05:39:53 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] drm/rockchip: Fix a typo
Date: Sun, 15 Sep 2024 15:39:43 +0300
Message-Id: <20240915123943.105118-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index 441248b7a79e..c7780ae3272a 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -77,7 +77,7 @@
 #define SOURCE_PIF_PKT_ALLOC_WR_EN	0x30830
 #define SOURCE_PIF_SW_RESET		0x30834
 
-/* bellow registers need access by mailbox */
+/* below registers need access by mailbox */
 /* source car addr */
 #define SOURCE_HDTX_CAR			0x0900
 #define SOURCE_DPTX_CAR			0x0904
-- 
2.39.5


