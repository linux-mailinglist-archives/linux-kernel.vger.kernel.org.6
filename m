Return-Path: <linux-kernel+bounces-232322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B391A6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2DD28724B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595321662F9;
	Thu, 27 Jun 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pL4PMpBK"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5515FD0F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492265; cv=none; b=PQQYJFmBvaw50ZIKIS1K2xJ1sX6S/9zq8LzUDII0R0mNamVUCsF/HuP2+S+Zz7ZF2H61CA/xdHWpoSBI8y+/QzgRw6i847A5gKaNipWJPSZyw3fqdpmOg83vOl0Ipf6FTPXL+WOyT6eURrNMURF5CIdVN72HfsXjMqmncQPKvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492265; c=relaxed/simple;
	bh=pi3DHNQCv9R6UCFWH2MdSRk0b7vmsHj+UgIAfiRMFTM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPvJrzO4jb98mHLdUMuxW3LWpXM3SKT0cE+wf/Zy9mT2cy0axtFE4G1LQn9lvm6z7jyFVSxSvc6WiNpHkN6LVn1EuYExmEpTtVWzHsDl4iwstii+L5tNSs58TxRa2ZnMW8f4agEqOetRhI5/09mNpzPbWfpxBld7Etx1Wz81r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pL4PMpBK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a729da840a8so91896866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719492261; x=1720097061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoHL1adqPi6egt2LDvYCmnfXjH4AiRnMDVVthfhiOGY=;
        b=pL4PMpBKJZpPtQ1dpNQr5IEn535DwQOzfSkI3UeAuS/RCsjqhO3IdbV3U3o7alSA/O
         i63eKo9wZQqSr48L2qxMrI4aHyzQkDgopsZJA1l0c6PsD/HBzSqX5E0tJ1ads4uLLHjF
         npzh7/Im2WLNAj+eYCahku6z/sgleU9i1WFb1AKVjYUj+s8tN67YdOP13dlbi1IuDUnu
         0R1CkeLqIXGeVoaEYBIDIxDvj4WEMRpAKZ8Xqi0RwYju1Gb6XiYkZB0H0XvboCzCvnHT
         APBMgXzysyNyJf63pvrbIS3Zu8zDXxBMT0QzSVk6ibQeWVsLIiQYqTj5DX3czJ6JVPrX
         r/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492261; x=1720097061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoHL1adqPi6egt2LDvYCmnfXjH4AiRnMDVVthfhiOGY=;
        b=vmSXrsfpZEwKYmbcqhFHN4tO/NfdpXlOS0HhNjoex1OMc7xUA2RBorkMx4ObeksQpc
         Stg4RgHcud0UKX1Z4oFrJkkBqu8nyknNikxesZjbPA8oEvy3Y3vZ8/xSyy1zmf/210zN
         kLS5Q7sgaPsm8kl6UFlHbQrs5kg/U94IETSdFdjZrdH4WqN7V+qENYkCk7YOVFe5is4e
         qU/zyV2+kHO17YbRg/54TTHZMnuImO+4Cd+2JkTiAxqHhTg0hFiTWIo1S5J9waHcr1J+
         Dl1q6vNFQjgcX2Vs0xAqZZLhUbXRR+UB4R7VLVasYgnJhxfzisfAvn/XrIF2UyHhH6Vj
         M1rw==
X-Forwarded-Encrypted: i=1; AJvYcCVujDhz1JcO6eRpzLLGnGlUIiGVxsvn0qsXpr5l0XmDMNjnFPeCAoNEyw+9U0J/gh2dUPWGsvI+s7RppiXf6aZE2k569zLCHktWVHx5
X-Gm-Message-State: AOJu0YygUmCV0opi0sMFeywGpytAcLLqI9HhWnVMEx4h4N+EKKEPfCSd
	8tnhhK6NxuOBEo/4oespdHlM3ZcyskpOJiZCHy/9KW0xQq9rXv6b+8LBZRN9mFw=
X-Google-Smtp-Source: AGHT+IFeaiSpwuIh7g2JkEWpjFnfDJbPJTm3K8sWRedli0PvmQPwA/kwXIvdntky4Hl+GJAwNEAyPQ==
X-Received: by 2002:a17:906:99d5:b0:a72:58c3:2696 with SMTP id a640c23a62f3a-a7296f5d2admr226130066b.14.1719492261140;
        Thu, 27 Jun 2024 05:44:21 -0700 (PDT)
Received: from ryzen9.fritz.box ([2a01:2a8:8103:2c01:45d5:74ac:5265:59da])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d6fdf62sm57030266b.8.2024.06.27.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
From: =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org,
	umang.jain@ideasonboard.com,
	wahrenst@gmx.net,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_debugfs: Fix build if CONFIG_DEBUG_FS is not set
Date: Thu, 27 Jun 2024 14:44:19 +0200
Message-ID: <20240627124419.2498642-1-bero@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
vchiq_state") adds a parameter to vchiq_debugfs_init, but leaves the
dummy implementation in the !CONFIG_DEBUG_FS case untouched, causing a
compile time error.

Fixes: c3552ab19aeb ("staging: vchiq_debugfs: Fix NPD in vchiq_dump_state")
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 1f74d0bb33bae..d5f7f61c56269 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -138,7 +138,7 @@ void vchiq_debugfs_deinit(void)
 
 #else /* CONFIG_DEBUG_FS */
 
-void vchiq_debugfs_init(void)
+void vchiq_debugfs_init(struct vchiq_state *state)
 {
 }
 
-- 
2.45.2


