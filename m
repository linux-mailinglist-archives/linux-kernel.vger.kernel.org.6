Return-Path: <linux-kernel+bounces-284604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DD19502FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E801C224BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5AD19E80F;
	Tue, 13 Aug 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ/40GFM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7C19DF9F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546322; cv=none; b=O6UoPKJL0UqcjDluy3SqT4fQmL0HtLnaURWlIAzRuwKGHRTBw1NASQC2BGCYQWwmjWV9nhgbR2ql3jVJHpygtk1kezwY8JnI5guuOmhg0TrZ+9Su/HMeFkeihv1dqo3m/dDPOLzNwluha1lsG4jkyLWMAZnt0OK7HONvYvB9vQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546322; c=relaxed/simple;
	bh=20en9IvoseToki1ZM++avUf+aFbymKoGL2rG6HuSeIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE8OxPhApeL1jBxURaLcK2LWKUUVW7aJiPg8MSCrMxyql21AXGk3P9RzetBvyRy2UMwaArfoYxXUc1Kt78KotbxTT7QflQizfiTDczO/ed1W10ztOCMM63G391fKQzSae1utkJ4Ec9hiJ5+PhZBE1DAwNBQdlKVZ8l+54dVX75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ/40GFM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d18666so39544415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546319; x=1724151119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZftJBc7W5kwvvNABWDGPxvru4sevjwR+IU4HN2kbDT8=;
        b=JJ/40GFM/Y1zapAcSO3apH907Ke13qOQzT72G8h4Wu/EJNvFpiC4l5yOIcOfUISBA2
         5xBCgtROuHkFc6jWrXcqDfU3hM6Z4y3y63foUI8ULKnB6A+goYN5UCWHz63gwRdwsAFb
         4SuHIL1dlGicoC5b2XNJNaCEoy7vxvKvuQpqaxxawM+FJWUE+qOd9Vkk9PYNZRgiz8vI
         ibbGIQi4cVOGBn7T5VbdAASoFSjdx85AfBW4EMvsKChjLBVoaGVGv0ubQM2XuvulKOe8
         b6dXraD8vQ1T/FyBoHF0W9iEMgS4Yl+dlhJGoZn/HhWSmRd7thxOE3M4enk7z6l/FE5J
         R3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546319; x=1724151119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZftJBc7W5kwvvNABWDGPxvru4sevjwR+IU4HN2kbDT8=;
        b=rhUHqxB//1Bw7ULcJ1IUIW9oS5MTzJfBWLWvvpr1RRRmGU9e+s00e8Ic8blny6tJ6D
         IrQehwFN2pDCEe3Vf0LQWI20cd0Zmd2qBsRj2zmlK2HB21chkWz3irjzViPrqrxj7Ijh
         9X4PX2uV7CIGTwz+/pj6CoAPC43xu+hi42sLNQq/FhH4biKiH1R8CY1QUK06bXNrJelS
         /hXcoaqLKPjnEfNW1M33wdLR8xL8bfsOcrc3iKsEPmAt8muheghKJeinidpxyuv+cgrs
         y0gewXbDabbdojOAnC79oZR2ei1pt3au1h30OpU8YH3z8s+WEiLm98p2x4vbjZ3l8b5I
         N8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV854a62kQpD9WdbGveSj0/YOjiaitR9XhbrjffhSaTHoji4RMqFqT2v7TBe80OCTLWag6mqGprqXRb54X121SKBZzN2rmTeyaqr774
X-Gm-Message-State: AOJu0YyBkGiSeFBTEzmV/AsQqM6chkQgO33vmxxDGYSKj1rSM4RhsY2s
	7hRB14CFARc4+0BWbl4l8YIQXWrhkmofZFX/yFbBOVx4siC6qveH
X-Google-Smtp-Source: AGHT+IGmYYsdBOSQGdHs8roYpDqyGK4MJTVsNTujjltjUQNx3CKHicYkYjxIfPWC0fDyWxdLgRP2XA==
X-Received: by 2002:a05:600c:4453:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-429d486e85fmr22635355e9.26.1723546319268;
        Tue, 13 Aug 2024 03:51:59 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:58 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 17/17] drm/vkms: Remove completed task from the TODO list
Date: Tue, 13 Aug 2024 12:44:28 +0200
Message-ID: <20240813105134.17439-18-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813105134.17439-1-jose.exposito89@gmail.com>
References: <20240813105134.17439-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the configfs related TODO items from the "Runtime Configuration"
section.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ee71d1a569dd..a8c187f6c0af 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -229,19 +229,12 @@ Runtime Configuration
 We want to be able to reconfigure vkms instance without having to reload the
 module. Use/Test-cases:
 
-- Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
-  of compositors).
-
-- Configure planes/crtcs/connectors (we'd need some code to have more than 1 of
-  them first).
+- Hotremove connectors on the fly (to be able to test DP MST handling of
+  compositors).
 
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
-The currently proposed solution is to expose vkms configuration through
-configfs. All existing module options should be supported through configfs
-too.
-
 Writeback support
 -----------------
 
-- 
2.46.0


