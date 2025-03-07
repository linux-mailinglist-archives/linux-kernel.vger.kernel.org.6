Return-Path: <linux-kernel+bounces-551550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6AA56DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE33A7CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198C24418E;
	Fri,  7 Mar 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR0ar1UD"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B2241CAF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365260; cv=none; b=axHIVFyaHtc1hOGpW8gYvS+moVrMYm+PqA9FetOzHTQ7B2xeeIx0pxGnNAPEFw6Hj1tLsw93zQXBiaobvXwLrHmryqCZv4gXo8W7dt0e3FhPq0LT+7MR/SjvejayeRncuzZzddelSgTFmhVQGd4Bdi94nEwflxA7d+Ua5lL9O0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365260; c=relaxed/simple;
	bh=Vi+uu/h5Zd8rK2aatFelcFPD2hYQTWMEmZWHarVSvJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lljlPf+f/yQtFiHQP9lBxzLhHi1olnADHPCCV27vGcT97l6/je47v6DPpRcOzFgDfUJq+Xn031go17C2SbHxQhCnEFDTaRvlXhylF931GMpZprMFUKH62+hOjkCH9Zii9zKBvRHCjLyPjV2hoBHw5/9ga1+qmmrvyzaPBql+WEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR0ar1UD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bd87f7c2eso12091345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365257; x=1741970057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2I+AKiUaGilJvwS/f5X1LlsvDutZk3cs9KHKo4vYS0=;
        b=PR0ar1UDQmplYBsLMz+iMk8R2K7XnOCKR1kNZy+bp6a3+5bao3dgraraxKL8eGY2Oj
         OjklMHrWCYsMQboaB9PoKdMvImROlyvid/VRKgEp/XjcXs5jZQNc/Ncjuo1mZ1v9u11Z
         dB4KxU6UsoT/jMqshDcEfQUp/Anz1B4ae0ycwltsXK7oIWMLpsKO6j1Szjhy49b6rnwk
         N5r3FGK6yMLltQis0kHkN4Q9+hjZMjIGwGD91lGTm/dh4u50vm6F0hY9rOejpm/+ap2/
         2KR68qhPZLszXrPCsSNJendO5lHpg/h1f7HJl1qAgxgm+Lccl32oEJSm5q3Vg4kKZiO7
         vmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365257; x=1741970057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2I+AKiUaGilJvwS/f5X1LlsvDutZk3cs9KHKo4vYS0=;
        b=YwdQOfmLM98L34UBNUnhz8p2jUJIZX4zCfvNm2C3NzWZjoubnOxf9ZRxpIXroWZkg/
         ePccyIvd87AFf9SDzmSkxYyxfRwucwgDTPgGjQC/QDmsvaCBnmdLMoXbGNFYfyII5cLz
         JggH4gtAhAWnxfJAP2CK4HxNWCL9gr62ptiD2VLwibg4bGaJJHr+5oryBltXQkUdC0XJ
         VPkz1lQWnyAwu3wzCfxS+sGbjp9SJXHceA9RkpExTMrVz20GFGLgT9rdiap1f351BV7D
         DIhBlokHNjxhzlt/fOW24cAyr1jLN2rMs+64vjOb3y1SSy1kmSf7bKVnWE8AUGhbVs71
         EL5w==
X-Forwarded-Encrypted: i=1; AJvYcCUQNNW6XfuxXn9tHFUXEDQMiHY3MbMmBWkRSXhQUVsYVUJm8Vl1Xp8DB0MMA22ybQ+dJ0vOhYYTMywHy9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrW5v0ANL3TTgkmCPu/Yu1ZdgoBw/1Up9/BFT7SRTR5IqlCUyX
	MT4+RHy8KGwZkwKadLA0P0DLqnwEXukEJ+cEaXNcPVGE38jIOXBg
X-Gm-Gg: ASbGncu4gxllYez4mt+cAvOMpZF3IsaDgG975YnkRUQFEA3vH7GewXw86+ZI0q9t/k3
	s7XcMw4O4cdPEo5V4XsIQvd5y2EbpI3lpBEdB67bq8pp81Yl5MDim3ZVhrn9fUPgmrV3Q9OmHDz
	vhPAEOMijrf9J0C64y1TyQ4HvT0ogDgIsdKe/HyYeTpSrRdZghvulscZlaiNHpyQpmnf7TTlRZe
	Zp4QflTAawMzlGuD8LrassRn+I+i2hDEF1zdSJTWgP7SqRyLYVy/iZjT9BgB9UxE6/+HpR6vaBA
	qeSgvXJNXzg9NtUYhWdZk2o2z9kXp8tTOmL6b5jHDCDpH4U=
X-Google-Smtp-Source: AGHT+IE+/rU5pkLDM1WZfm1em60SGqLyoPo8j+dxcpf3SNDsL/ewtlrCgxTKAsjxe6CqNBfr06tkCQ==
X-Received: by 2002:a05:600c:3b92:b0:43b:c7ad:55c2 with SMTP id 5b1f17b1804b1-43c5a5e9853mr27338655e9.6.1741365256861;
        Fri, 07 Mar 2025 08:34:16 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:34:16 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 13/16] drm/vkms: Remove completed task from the TODO list
Date: Fri,  7 Mar 2025 17:33:50 +0100
Message-ID: <20250307163353.5896-14-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 74126d2e32e4..c551241fe873 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -222,21 +222,14 @@ Runtime Configuration
 ---------------------
 
 We want to be able to reconfigure vkms instance without having to reload the
-module. Use/Test-cases:
+module through configfs. Use/Test-cases:
 
 - Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
   of compositors).
 
-- Configure planes/crtcs/connectors (we'd need some code to have more than 1 of
-  them first).
-
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
-The currently proposed solution is to expose vkms configuration through
-configfs. All existing module options should be supported through configfs
-too.
-
 Writeback support
 -----------------
 
-- 
2.48.1


