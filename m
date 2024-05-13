Return-Path: <linux-kernel+bounces-178111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D848C48E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C821F2190E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BC839F5;
	Mon, 13 May 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="s9m2xquz"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7087E58E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635896; cv=none; b=q/DjuU45v/dvqYk5mAEGvOuKJXsWYQ9oQCrwYZotkdAipR68LVxHjqB1g1+fBEwyA2taJfdjOfBOF4nmZof4GKH730paybmckwAmqjsdDniCMnTrpgI9OoIx4Kg8Cc93SI01RIotbZ/9aKuyWBhbAom5xKJdyuH0lcQvN/xO05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635896; c=relaxed/simple;
	bh=Kr9UDK5KfJoHTz3suK1v0y1iPSQaijtXIRR3Ew0eZHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOWbCOiwtK1akHf3yoxKOXiJ0xWd6iTZBiYiV9o1Ty/cEuCHvybywg+bvvPh8L1kiu0jJM0vOkdSRz/NXFiMKDmTKXJL1qDa2Xhu7n9mLzfxrWzpmGOLsNsiUJdbVW1SH0JlgXC+I8B2nbbb4opj9UbkGNMVjhKbeY51Y4Wg6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=s9m2xquz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59cf8140d0so1122441666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715635893; x=1716240693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHM5OrKq8XtLFGFwS3E7+LYEHMOw759zWdrMQnI18lk=;
        b=s9m2xquzDHjwJcImvw2ftFWVY9zxwt/2yFmHNop3o1uR+vsvUVUb17CABn8Y0Q5kB7
         GPsu/JUM4pDkd14ry8EAMWiIpNuKNMS85rrDMDI/UvYhTkDHEOI4w32i4fbtJDNWCS1r
         fPyKP4SldT4SU3fkYFILBBNCyl/nfUck4CTZE7TZjnL2a31xhq9avQbfvNkZo+O+62wn
         Y1EUlKfAkYOQH6WNaBZIPPlhV6jW/NjIwTOVLPsrLdfROmOm+xRmSwZV33/Ckz2Rshs6
         ZBhSB1Bh5AZjPgFmxud6c3HXItqzYUeGYWk+K2K2+5bXL01YsQ6+yjmH5QWtpdFpTTQn
         gjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635893; x=1716240693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHM5OrKq8XtLFGFwS3E7+LYEHMOw759zWdrMQnI18lk=;
        b=Aomj19ifLjbn4xA/sXySNa8xCpkLScIQCVwOoKmRI6PT6Xac1lEw4STMAk2DyMUThv
         U7jimu0J/4dcza+Roupiw3AzT3L1IitbuRyRMvYt2qCRyNne4/waph6SINefgik/QGJy
         IZcczobPK7DmY5S7afCO1bczJRZeIcSLkKbZA76QobmnlSXxM1pTZn0f5serY14cz2R+
         fjTbGpumJCmlOK8MR6QCl3RLWZHLtgPiXDi4M6KWx288El3qZeM9w+EI0xGRHujVROFA
         X/P+S/deBc4+4qrJeIfomgDXFwk7dirq+B4p8H+iR7CdgFv6GEuDupENq//RMM+mj+Jh
         faWw==
X-Forwarded-Encrypted: i=1; AJvYcCWA3e++CXEo/YlZ4Mja3q/yjJP7qb3arYloTkPpqq6Rg6JxxAyR1jbEREHUoj5JV7xJZpZfDnET+BLd7pzewznBcu1IUC8ugGnnIfTz
X-Gm-Message-State: AOJu0YyLPLOzYNbY4h9cextXB7yVGJhXtkSLDhmVETVEPdV+KasXeK2f
	BcBEMpveY7kBVUYjYZaN7lUkz5fjHlV/Z8UxuYJnwWWv/FugQ7Uc77qL7CD4Xag=
X-Google-Smtp-Source: AGHT+IFRtIdiCU6HVhtdEvjPxTd68hHuSXaq7Nk9aW986VCC2SUhFWuj88xAWlYO1YHE9NZl0vVLQQ==
X-Received: by 2002:a17:906:7d7:b0:a59:b6e8:9ded with SMTP id a640c23a62f3a-a5a2d66a283mr687658866b.59.1715635893486;
        Mon, 13 May 2024 14:31:33 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17891f6esm644037366b.54.2024.05.13.14.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:31:33 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm: Combine identical if/elif code blocks
Date: Mon, 13 May 2024 23:28:38 +0200
Message-ID: <20240513212836.292589-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge the identical if/elif code blocks and remove the following two
warnings reported by make includecheck:

	asm/ioctl.h is included more than once
	linux/types.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/uapi/drm/drm.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 16122819edfe..315af7b19c97 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -35,13 +35,7 @@
 #ifndef _DRM_H_
 #define _DRM_H_
 
-#if defined(__KERNEL__)
-
-#include <linux/types.h>
-#include <asm/ioctl.h>
-typedef unsigned int drm_handle_t;
-
-#elif defined(__linux__)
+#if defined(__KERNEL__) || defined(__linux__)
 
 #include <linux/types.h>
 #include <asm/ioctl.h>
-- 
2.45.0


