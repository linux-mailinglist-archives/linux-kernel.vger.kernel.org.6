Return-Path: <linux-kernel+bounces-446345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A009F231F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083BC1886456
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2A148FF2;
	Sun, 15 Dec 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jq+CmCM7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B48320E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734257973; cv=none; b=iPKpLW0jodHIO3OCQlLa1JEaJ9Bj9gqxTxwb9FqMZIaEOLfLzbzh8SWmXMy8qtbARKImJZx2j5NCliuYwf+5HinCm5dDgV5pdNJEazwjh1rUXe9avg5hHPMpcovpU36GXBY8FTzM8O8DnIFJitzQGpklMZCKH5F0MGFkl7psKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734257973; c=relaxed/simple;
	bh=3uERJoyD6tEdmd7Ye5Z7DP4u68QhGn6/3ku1AADiaSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j9l8kKB3vyZr0S+8ds/22/TcGlHfNf6XfrzTZUhoMgNvEIfSHsri3VGr1vxn6hCsEvTJ09GmyHKML7kUgKIfcKAel2RtkCWhPiiAJVViQC62FKYMQo9RUryQfqlWsCP6VISBIUqILHpSpyiNQ5EwUXAKUi2BqrSDmlEIQmhypus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jq+CmCM7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso36444031fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734257970; x=1734862770; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmJRlCgQ43HqhYS9HmW8tiBWnQtuxSsa3zDxVOfvub4=;
        b=Jq+CmCM7brUXlFORb3DhwEhphFG5KWeYOb+DaYLceSntHMxwMSnObDsWjToTX/xYqr
         TIXJlEKLuZjTt+mJH/hU9cV+crw0Ni3Q1uBBGMQJYFwprlHHCw7H6ysSjuR6Jr+Chr06
         Dn7IvyoyuThyllF1WaO3y6Al6zI6H3OA2oMpa9XOnftEbDz/FOZqjZaIk7jxYCY8n+e7
         +sw3NOsHheAacOB0KFXupsZfzFusxem12axp+K57NQA+CYJtewunOaElJanC+8f4c2Tf
         XIG6kiat3/CkOx/vo45OED1gWz78i32JOUqvsoseIpz3rwF3ianDw4KlZarWAlEZtblb
         oX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734257970; x=1734862770;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmJRlCgQ43HqhYS9HmW8tiBWnQtuxSsa3zDxVOfvub4=;
        b=h0sJ2DlwCa1De5deQV948Yje8HDYRTI/a2pvpTdnsZ468RVVk3judRCdPwH9SchvNB
         EkJDCmXbYvPX2e0svI2lhXcY7Z/pxicv0lc7H+GwEu9eRAegiIpMtJ4QTGNSi8DJ6KQ4
         m6NqV417e+w2P/OEN+eZO6TnMT2cdions1t09baErfAiNUw/MnIypmWtVYb7fXL4gD/H
         oY3o7I77yd1WLXUyfDAySIIQGvwFik41TrSVFN58VcQ9SVg8YAqWqDw93lyaK9ZkhohS
         K1sgwalpNrU2MrlUS11jkR1BPK/xDyVAkEe0wlpem1rygxb2t1sPwMeXiHDQkhIhsKIS
         e1xA==
X-Forwarded-Encrypted: i=1; AJvYcCWeBuXq526jQcY1Rtpw0JVOg0kub5Ih5/iMOl90ad1Y0zEpMiLDvwCNrokh4w03D66dMgVUe5IKftzCgRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsvA0SinC1n+TIzXc83c5XCki3uPRzanl72lHM8GLw+y15Joj
	+Zxx/7erCDFrevw61veeUkoslKwVZ/XaotPzuiTKfUtf2sYFWFpkKp/wGwkVXlc=
X-Gm-Gg: ASbGncsIrgDvdZ5/kAEpFtycB3ezgvnXHva952m6sruMsaiZDtAqdTwn3YqjhQ8LQnb
	y33bEuZ2g/gsFs6rauFF4osazMhmEJrGk9oy1JxU5vEzaLSLh1eGz0cRYV1QibH4XzCD6Of80m+
	ll9hOQVK+N7caYir52aj/bHGQ0+aY1AJ9vjkULji6mqfh2mzGhTL78bZvzyt2I4WJEF614JRCr1
	FHqZYCzPPrZMaGmMSrivv772C/Rp557t0A6yPrJOTeVLjA7tiZVvxin9a3mDnl5
X-Google-Smtp-Source: AGHT+IGWyXChb/D3B2rPy2AbSmqVSVzMB+hbWmEQo+gBesrAsnI7rlvG3Pz1R9B+snZAh8Q1EO+Auw==
X-Received: by 2002:a05:651c:2109:b0:2ff:9b6f:23d9 with SMTP id 38308e7fff4ca-302544268a1mr24067711fa.7.1734257969909;
        Sun, 15 Dec 2024 02:19:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d546sm5270851fa.11.2024.12.15.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 02:19:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] drm/nouveau: remove drm_encoder_slave interface
Date: Sun, 15 Dec 2024 12:19:22 +0200
Message-Id: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqtXmcC/4WNQQ6CMBBFr0K6dgwdG4iuvIdhMdIBJiGtmUKjI
 dzdygVcvpf89zeTWIWTuVWbUc6SJIYCeKpMP1EYGcQXNlijs2gdhLhmphU49NGzQpopM1DjvUM
 cyNHVlO1LeZD30X10hSdJS9TPcZPtz/4rZgs1PNlT27SuRb7cZwmk8Rx1NN2+71+5zvEQuwAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3uERJoyD6tEdmd7Ye5Z7DP4u68QhGn6/3ku1AADiaSo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXq0vCch41TAM7WiRPkozL/rQQweK5oSKeHQ4y
 RBmwJGmxyWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ16tLwAKCRCLPIo+Aiko
 1Yr7B/936nIs6FtfnNKBW5AwyrppVEyPZFGQpirMdY83dKN7czEFsLt8zQYuJU5tJ686XowwX2D
 UsMiuGW5oAF3GXiXWDW53Z7lYXrepHGepoJvp7Zu21GxssPV9Kzgs9ST8kT+9Uy9DPCDEbRQuF4
 ACXVXFxo1jy6ozYd/76xCnjeW/W0rkdI9+GqzWPAmggzy+I/KYwAzN1uM4t7Nk7RAZwKZMthyZS
 Vo6nRyPasl5RhLttKblMSXeDQEVQC5CzqMSLef9IYMB4vYJ1K1SLtJpI3pzmBLeWhx4JFjwezYG
 GzShXf1g//MCGCvQp3nx7a25wm4bCjT6e/hY4L/RYo7Ssa0E
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The nouveau driver is the only user of the drm_encoder_slave interface.
Demote it from KMS helpers module to the nouveau driver itself, moving
corresponding I2C encoders to be handled by nouveau driver too.

Ideally those two drivers should be converted to the drm_bridge
interface, but it's unclear if it's worth spending time on that.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Renamed symbols in defconfig (Laurent)
- Added missing Kbuild file (Laurent, LKP)
- Renamed guarding defines in include files.
- Dropped mentions of two removed functions.
- Link to v1: https://lore.kernel.org/r/20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org

---
Dmitry Baryshkov (2):
      drm/nouveau: incorporate I2C TV encoder drivers
      drm/nouveau: vendor in drm_encoder_slave API

 arch/arm/configs/multi_v7_defconfig                |   4 +-
 arch/parisc/configs/generic-32bit_defconfig        |   4 +-
 arch/parisc/configs/generic-64bit_defconfig        |   4 +-
 drivers/gpu/drm/Makefile                           |   1 -
 drivers/gpu/drm/i2c/Kconfig                        |  18 ----
 drivers/gpu/drm/i2c/Makefile                       |   6 --
 drivers/gpu/drm/nouveau/Kconfig                    |  20 ++++
 drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   3 +
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  12 +--
 drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild        |   5 +
 .../drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c    |  30 +++---
 .../drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c   |   8 +-
 .../drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h   |  11 ++-
 .../drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c    |  33 ++++---
 .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  20 ++--
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
 .../gpu/drm/nouveau/include}/i2c/ch7006.h          |   4 +-
 .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 109 ++++++++-------------
 .../gpu/drm/nouveau/include}/i2c/sil164.h          |   4 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
 22 files changed, 172 insertions(+), 232 deletions(-)
---
base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
change-id: 20241214-nouveau-encoder-slave-a6dd422fa4a9

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


