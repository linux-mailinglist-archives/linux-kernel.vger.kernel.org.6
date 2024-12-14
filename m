Return-Path: <linux-kernel+bounces-446090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E49F1FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2061656D0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C72193070;
	Sat, 14 Dec 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7h5SyhS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004018039
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734190551; cv=none; b=j1DdH9wDjbM5VbYYU4C68RqP4o5d86wB8Q97HU6Tb9cWYCBBzkTmu15e69l24fC8AQXZUjI14ROwxzBBSTFcNDjrcf2xhqkEeHrcD6Ig8RNNnqkzPugzxaD4wNkhSy5/wy+FUM+yzS0BSySPdihtwmnp6gYjdz7iqWV1MJ2JCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734190551; c=relaxed/simple;
	bh=uSCFLyOzY12sd0P2T5xQn2Moyu/qPWn/YYVBaZf61zk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FjaVgrtCuRb8cOwKY6bSk+W/q7J8o+NgJTq+wC2jitQdfrNjzi4VgjwxWb/Z4H50IE69hgejQelRytbpCPlmccvFeTrJg8c0lmLCLj49unGzvTjJ/cNJzZvyFyGFhmYrLpLO4jK4pXgMRLEc4bFkNvIVxIIbZ+7T55ReoJFIIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7h5SyhS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53f757134cdso3158465e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734190547; x=1734795347; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLbSax+p06VLE36M3XSjU+HJbZ5A9uKBhZ4K6J4wh4s=;
        b=g7h5SyhScTtiZCbgl7LVTmDXU4JNm3DL98lQaKmO5XMhopjhg7/lv/VUvtfREzTz/Y
         Wl/J66PbglqWChpkr0m1ea+Cx3MMDTmDsF6ULpj/CaOhM9VlujxnQo7yMZkmv0xQfW8g
         7DgkqJQBzzVmDPg4lqS0MDJG7dZOSCIBtGI8uDxhUU3Uu6XLouwv6IIDMCkJ5Zgxsuw2
         uxabkcmldb7fmKok4uQ5Ida2ORij7Za4bbOFnxch69dsgwLeBwN/SEZ85J94hvO1tyda
         FVUAYGLliAC64/AIw7F8aXS1Sa6Pk2qWvG/QYgmwJpJ057yvFUM2Pfp2TyxQYlIJc+Nu
         8OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734190547; x=1734795347;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLbSax+p06VLE36M3XSjU+HJbZ5A9uKBhZ4K6J4wh4s=;
        b=DvHxD6wmuarTdE1jS5oeyHwevDd1dSqpLsL6qbSWw4BE6WKPMeefiJwxad7MrDhPTH
         ra54CPuLmb+8q2wB8hOlVlz9+mVmyplFPdQDPBnpIIK4K/Spd1GTDoU+SLtbVZ6AMOSz
         NaekXmMingI/elkBtIWt8kWDAHgfmsY2g8vtARV98VN47Rm3tUj8kmM6nlaupZNlm8Jp
         m8zbVPM0s/oznsHI1CDEJnY3yK+3JiGy65pEpEeDLuby8vJ29kk/egjROGnnKRE2PJhv
         JjINc4VtwBRpAFPxlkYjvMFGNDMyLJ0NTdOi9WLhtaQS5pFjGm5BOaQVa37f9Y956bHA
         O7/w==
X-Forwarded-Encrypted: i=1; AJvYcCWadxbVsVNtZCbD3o/tyy0JlXQ6K6Pr5QDMDmV9DG0i6USTAysh2/5FPol/zph7TViXmrcaHO+KYHiDnE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3vWdHcagP2bziFCaxHOpV0TQdHKWjbBL4qT4V4qXokAYHVm7
	Nnd9IIA200bb3W7EIjbeWNoJLjUaC0DqyLwQRJALeUBfLwtHbwQP2E8D/a7AQQ8=
X-Gm-Gg: ASbGnctNPIsiY6vWn0gn593ONvZAxqdeVV8Xj9hYpM8pHZUUDx9OjB2pJnOHRWK1JtK
	RDaNVn+HMrOcJY/u/Mi5n4irXX0QBvj09Lr9aEjShWybJaIBTtw90PEA9cqeG++m+OUKJRhzlm/
	mIKsTyjfdRxRtfotSUUXZcIXFhdcbxoR15cPtMEnRov9EQ8s6lbV4iHXyDiAg8F63j1/oT3BJmZ
	r3e8hbh09Vd2NA6T8MATmMFRhxMnT6K6SXhh9qfoVSdvrsC9IzSEf01721HDcUT
X-Google-Smtp-Source: AGHT+IEpdHXgq/AJVIBZFdCRma3KIOfO9gPTKCk88qdhJgKWQyKYuomFP9P2bj2ZCBIJ+C8NUXyj9w==
X-Received: by 2002:a05:6512:68c:b0:53e:3a73:d05a with SMTP id 2adb3069b0e04-54099b71a9fmr1891769e87.55.1734190547608;
        Sat, 14 Dec 2024 07:35:47 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c1357csm249821e87.182.2024.12.14.07.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 07:35:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm/nouveau: remove drm_encoder_slave interface
Date: Sat, 14 Dec 2024 17:35:43 +0200
Message-Id: <20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+lXWcC/x3MQQqEMAxG4atI1gZsKAN6lWEWwf6OAWmlxSKId
 7e4/BbvXVSQDYWm7qKMasVSbHB9R/Oq8Q+20EwyiHfiPMd0VOjBiHMKyFw2rWD9hOBFFvU6Umv
 3jMXO9/v93fcDzB/upGcAAAA=
X-Change-ID: 20241214-nouveau-encoder-slave-a6dd422fa4a9
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=uSCFLyOzY12sd0P2T5xQn2Moyu/qPWn/YYVBaZf61zk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXaXQuEDw5ySVoU+n5Nw1LD88fntA/Rrb912KI
 o4pUz5SayeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ12l0AAKCRCLPIo+Aiko
 1dTwCACID+Vjt7FKREkIANKuhTq731TOGXKSrTAu/XNc9u6SoxQhz1qB1ijxgp+jMjdoV6V0pPR
 hWTa5yjtgL6MEYGQD2V8x4hNUs3JF16HpKPntJuE3tuVVnZV80Lt5+xIaNnKQIchfgL0W19q6Rr
 CmRykLXqJiYPb10gUtXWdJpAEWdnoKU+9X9OnYRPJMPxLklckECxcYN7TNqYuH6o1Q1mgvej2Qi
 qT/OF8QSoZmcF/vLj61gubdL/AqFNLJYF4i/QV+GbDPlEG/2yNy6H9rrumGnQE43oFVrlbr39Yl
 u3DddD6qx0ggLEWxIhgPW3Zvbrm94+vkP5L/LZfH/FpWgkul
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The nouveau driver is the only user of the drm_encoder_slave interface.
Demote it from KMS helpers module to the nouveau driver itself, moving
corresponding I2C encoders to be handled by nouveau driver too.

Ideally those two drivers should be converted to the drm_bridge
interface, but it's unclear if it's worth spending time on that.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/nouveau: incorporate I2C TV encoder drivers
      drm/nouveau: vendor in drm_encoder_slave API

 drivers/gpu/drm/Makefile                           |   1 -
 drivers/gpu/drm/i2c/Kconfig                        |  18 ----
 drivers/gpu/drm/i2c/Makefile                       |   6 --
 drivers/gpu/drm/nouveau/Kconfig                    |  20 ++++
 drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   3 +
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  12 +--
 .../drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c    |  30 +++---
 .../drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c   |   8 +-
 .../drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h   |   7 +-
 .../drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c    |  33 ++++---
 .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  20 ++--
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
 .../gpu/drm/nouveau/include}/i2c/ch7006.h          |   0
 .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 108 ++++++++-------------
 .../gpu/drm/nouveau/include}/i2c/sil164.h          |   0
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
 18 files changed, 155 insertions(+), 219 deletions(-)
---
base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
change-id: 20241214-nouveau-encoder-slave-a6dd422fa4a9

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


