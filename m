Return-Path: <linux-kernel+bounces-446353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848AB9F2346
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8EE1886689
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5C14D2BB;
	Sun, 15 Dec 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yI80LSIh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E51171C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260955; cv=none; b=gqJTURHJ9t3lHt9nH1Ke70sVGu+Wo1WzAae9NIlYRSw9XIntbI4We8Vp/8PwHcD8KYkplbHKpuuEsPLDqt6NtDqrjLIQwhXoFu5S/CMhPALfa+yzUXA230DBUWO2+NBWBibWNWx+w15/H+NikIpbJhEDw+lvtbmRpUo0aajL6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260955; c=relaxed/simple;
	bh=7HHYNzqMQmgM/ow/NBf1mF2AenbPAy2tDdDG3io4Ctg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jv3iZdDwFyc0s4wPvFqhxEhkdsk4ROuagx7Yr8bwO8GiU5K/dXLlqh7uJq9o4aITR5Phz5zIurXxOrD95jdS3mWXL7P1t2Xu4YnBjBbnl64c03oUaOs/HHXW2dIx+XxofAKw6N/qmzEM4DvOjMm3rtcRwVn3eKLsBRk7sstL14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yI80LSIh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3022c61557cso32679351fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734260951; x=1734865751; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SeDB0ItL8Yj1in2LC0z38zcNuwMyG0rmvT7gINHSHaM=;
        b=yI80LSIh4/I0gmdRLTlbdjtEAEIrjceW3MwxXCdf7czk0gq+tcU5lCp+FCQLMhDW2U
         v4LGrq3ceSrXCqH6l5M6CsXmcXqq0NiVyUF9bo3M3+jPC3e8eS8i0UZRFN5jCEGnmPOu
         L9YUO5zhIFOukpy052FBeyFRiMa+4EIaeS7IHtIJdoxtkd9ExasdCJJ0V8O0F76KokUB
         FkX015Hqz4O1F5PUhispr6ResBSU8jMb4PWb7P5iqRCnLEgiYr/E3Zh3PH/v1ubGJs7a
         rubrXiDt5wyrdYdvfc8yNKD8M8eaPPY/Azz8PK3SpiFZVL15wiqXLO6Ao1XyNVcK4OAy
         hFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734260951; x=1734865751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeDB0ItL8Yj1in2LC0z38zcNuwMyG0rmvT7gINHSHaM=;
        b=SgEA+EbTLEHjCXwr7riVzWpiztm+UrkDvN9GoGJ1TETa9xp5dMQD3k5oRLoPdZsIK9
         dJX7oYSCkXuhOi/ktDdZVl+VHL27GZwnGedHbKTTlqRlQ32iuablXyDYfZEfH0lCnv8+
         mW6rA1v/6dLoAnFEyNyJuyP6DRxm7va70dLbgbFnZ7EoA0OYcORLhv8slYInneC4v69J
         m4sJdgNAL+pmTCwJ0bWGzIPd8v/9qFHsqL6Z/X9sqca15xBlPBioaPbRZvyEw75eGR3U
         aQplvOdnTScR0pKcQBS1Jy7ikj42eFT2D/xYmvxrUU17e9A3V49ssRMyHZouhyPi1jDq
         ftsg==
X-Gm-Message-State: AOJu0Yyi0akha93jdnKLYedTeqyn7KbpJTd1YFb+dxIfnKABAfnvochu
	lqSEug+adQb2UaTthRn04HvgewyY9/ru9KNcDST+YxUn9TTWi55l0lHw0SWV50mi4wrFmVriJff
	r
X-Gm-Gg: ASbGncvNhKsC3rcSwiemgsdrAd0w8GgIgtMYw8Oum/f2lZIljhaeY9ZtRjXhjrlXqlE
	hqTfEpYgZpL1WCZmWMg4fpO1LYDco0by7ddmfUm3wE4MgnMthArBLNY1e1bchi+RXIDG0BHHjiV
	reNKjUQ/JtjCP9VNyYoKV6mIiRojvQ/W5JnopHYEhrvJAGwTPG7UIh9cT4nhNfV0H+wg7Ywo92p
	X0wo4n44W2U05uGcSHoPb8GFokn56mK7spY9civl8PtzSfaNW0elEHrNTHtF08T
X-Google-Smtp-Source: AGHT+IFLEfifCi6JDj/iZZTfcHQ+beHkrYhPMHVDqBtnumKKiOVDWta5zivt5uy/eOb4EPqSH5TH9g==
X-Received: by 2002:a05:651c:2115:b0:302:1cdd:73c2 with SMTP id 38308e7fff4ca-302544617femr28249631fa.20.1734260951044;
        Sun, 15 Dec 2024 03:09:11 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034404544csm5261531fa.29.2024.12.15.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 03:09:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm/i2c: tda998x: move under drivers/gpu/drm/bridge
Date: Sun, 15 Dec 2024 13:09:06 +0200
Message-Id: <20241215-drm-move-tda998x-v1-0-7817122b1d73@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANK4XmcC/x2MuwqAMAwAf0UyG7C1g/or4lBt1Aw+SKUUiv9uc
 DyOuwKRhCnCUBUQShz5OhVMXcGy+3Mj5KAMtrHOWOMwyIHHlQif4Pu+y9its2vVtC5Y0OwWWjn
 /y3F63w9f8XCSYgAAAA==
X-Change-ID: 20241214-drm-move-tda998x-8fb4321434d2
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7HHYNzqMQmgM/ow/NBf1mF2AenbPAy2tDdDG3io4Ctg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXrjUQBk298BZioDGsi03uy8bXYS2NvCInj35D
 2Lsa9K14r+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1641AAKCRCLPIo+Aiko
 1edXB/4pEQFtE5TmJ5hjKpoufomXtkzeuUWXe6tzTjCSPRWpJ2k9hifl1ocXtdxMdq8slE3ZMtD
 azSMdiRmwvQxv/5kvBqEqHPB1wbSQZgGh8OZ9dUudOyx2hw67P37P7f/0LjRtbzqpGLeBGiY8Mi
 6pD+MKbBj7nDu69sz/1NJ+bHtZ93g3YQYaTOZ7oVjNC6gtjy8PSnT+G/ySS3fvnNNowOdy7VKem
 e+5YWtjKyTtEXYWGAFZZiWQH+ZZhNXczbpbAWfQ4JxqKXAu6Y4XPBrjW41MOYLBNXl/5gzXDqge
 suOVxzwLFaG7yaXJLv/YvTM8h7wHXEu9VB13vITknkmQk0He
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

TDA998x is the HDMI bridge driver, incorporating drm_connector and
optional drm_encoder (created via the component bind API by the TICLDC
and HDLCD drivers). TDA9950 is an I2C-CEC translator, being present
on-die on the TDA9989 and TDA19989 chips.

Move both drivers to live next to all DRM bridge drivers, under
drivers/gpu/drm/bridge/tda/. If we ever get a separate subdir for CEC
drivers, then TDA9950 driver can be moved to that dir.

Note to RMK: I didn't change that, but I'd like to propose to use
drm-misc tree for this bridge.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/i2c: tda998x: drop support for platform_data
      drm/i2c: move TDA drivers under drivers/gpu/drm/bridge

 MAINTAINERS                                       |  3 +-
 drivers/gpu/drm/arm/Kconfig                       |  1 +
 drivers/gpu/drm/bridge/Kconfig                    |  2 +
 drivers/gpu/drm/bridge/Makefile                   |  1 +
 drivers/gpu/drm/bridge/tda/Kconfig                | 13 ++++++
 drivers/gpu/drm/bridge/tda/Makefile               |  4 ++
 drivers/gpu/drm/{i2c => bridge/tda}/tda9950.c     |  0
 drivers/gpu/drm/{i2c => bridge/tda}/tda998x_drv.c | 49 ++---------------------
 drivers/gpu/drm/i2c/Kconfig                       | 13 ------
 drivers/gpu/drm/i2c/Makefile                      |  4 --
 include/drm/i2c/tda998x.h                         | 40 ------------------
 11 files changed, 26 insertions(+), 104 deletions(-)
---
base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
change-id: 20241214-drm-move-tda998x-8fb4321434d2

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


