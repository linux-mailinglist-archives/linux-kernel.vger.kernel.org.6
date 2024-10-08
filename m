Return-Path: <linux-kernel+bounces-355609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11619954BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F82E1C20A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C761E0DF0;
	Tue,  8 Oct 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Qb+Btck5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984144502B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405890; cv=none; b=Lm/rWVkTYw3RD04R46nWa3M2PwRtOzOHLxcpEc92SPX3jjnV4PZ55XQ6zkeRl4M7O1D7o6xDAH8DYph7R8g+OR2kWQuSMfFiVXf1wClnT9Cwa10Zsgp5MSRJohgo0jsG19MhhzrRIK28ZuazRhb/Tp9F94CTPeXKFRiXHIUJeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405890; c=relaxed/simple;
	bh=sJAqb0FICA4pzkRbaP/5FyioZYECOA41O4r7xx1IwiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s2Tf0jvOX1AkuxfjM7DeKD58mgPOldoes3lH/l3J7/N8Zy+fs3luQsRH3XGNVydKBYH9MCNu7vY79+JVixJK334JuRdIplTU7xWataO7i2f53fAxfPUF8N+mhACC2jOh3EmSYNb7wl4WyMWEC1Zryy0ERlCRzbIVtpt+/5baxL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Qb+Btck5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43058268d91so1115305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728405887; x=1729010687; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udKngyn+COgJHxzCzBfjM15Dlpu8/Zt6WSESJW97sjY=;
        b=Qb+Btck5JDpcb3WA6cOQB+Ak5yqj+CCPNN4eqOYlGEbmg3YQ2g8jooZyWlNp/w0GQ1
         dJOj8L+y3zLe3l9iwG0SG9yOaZs2Z8BSbjH7MSw3k0VWwcj9jznqFLEP847c3PuXv2kf
         3HlWpTliT2Na4jKVZNnHjAIITfFG/1liDU0rZTjeW4tQVCUKRVI7v890RayyJ2dQuaFw
         81a0T5OxJpXSV/YD2yDAmmQTU1gueqppNTrBufMsfbKlnpozJwqezbAwoFoa0jP/iu9H
         sahB65c1VphhjFJf4sCdsjjBXHOYD5uv5PDYl3055UKJQwBhDPHlnApZzfwNe+I2RMkE
         L3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405887; x=1729010687;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udKngyn+COgJHxzCzBfjM15Dlpu8/Zt6WSESJW97sjY=;
        b=c9eOv3bEjD0oVUGsqplYyhXPnm6GvOmcm4JTOyy3+q5ks28ooGcHbVdzbG/aq1bYo5
         ow8KDzjc4VfIAuvzFxIXQIEKc7AoNFvu9ctVI9Er3Vyl9aVjm2vrqNN0SzbRFZVrmRA3
         SMh5uEhGeTNhlJ3YZCF6qRu6nL17H63WAeaJF5lBLdCKgG9naSUzadFOF3k+qFn5wNpA
         4IHFCheGfEt955Y3sQbGGIUFbRQOqdM+LiHCCannR/LDGNgjg4WPU+bLV9SCFSgUXziV
         mlM683/+2EolkXDlXiG0jGO1xdVlib1RI6w9nr3o3s6Sq8kPIBrW39Jev+vOS/FZy/6T
         jMmA==
X-Forwarded-Encrypted: i=1; AJvYcCUMCYgG2Iy733SnPfJKM1+gxeNrjnx/EM1y4kVHjM0DAXz2lYLP4DoZK1bqolu+H6WwYhDmz6uO0xJ6pY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16/PkgoH7URvst53+IEm1PtkASy4TMlinuKgZ40cZ1sKzePQd
	9aF/jp6+wY4keWqbES5LLjBFv/35XgHiUYaSmSmpYRuc3zJGVhecdQvqH+ja6Os=
X-Google-Smtp-Source: AGHT+IF27i1dGmIROblQGzX8h59SOUWQT8qB9G5dks/SKZ7D0pTTjd6iXvAjWXmjbSdIpGlxGbY7dQ==
X-Received: by 2002:a05:600c:512a:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4305887c481mr458385e9.11.1728405886643;
        Tue, 08 Oct 2024 09:44:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm132133155e9.44.2024.10.08.09.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:44:46 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 0/3] drm/vc4: 3 minor fixes from mismatched
 drm_dev_[enter|exit] calls
Date: Tue, 08 Oct 2024 17:44:33 +0100
Message-Id: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJhBWcC/x3LQQqAIBBA0avIrBtQUaiuEi1Mp5pFFgoSiHdPW
 j4+v0KmxJRhFhUSFc58xw41CPCniwchh27QUhsl5YghXVi8wZ1fymicp03byVjroT9Poj/0ZVl
 b+wD4y1sfXwAAAA==
To: Maxime Ripard <mripard@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

These are 3 fixes noted from Marek's report that he was seeing lock
held issues.
The place he had noticed was actually triggered due to an incorrect
change to a conditional, but also a further place was noted where
it was possible to leave the function without calling drm_dev_exit.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
Dave Stevenson (3):
      drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_lut_load
      drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_atomic_flush
      drm/vc4: Correct generation check in vc4_hvs_lut_load

 drivers/gpu/drm/vc4/vc4_hvs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
---
base-commit: 2c34a5464007c45142af009d13c668b0630ef9c0
change-id: 20241008-drm-vc4-fixes-4aceb259455c

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


