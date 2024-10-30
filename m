Return-Path: <linux-kernel+bounces-388680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21919B62FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53A5281846
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192EF1E9061;
	Wed, 30 Oct 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh+8eXZd"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD921E7C37
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290902; cv=none; b=oFj0AQ3btDEEmRCu3O1Crf5LkoKzgfeCLesaSDivX9llB99r3fOSuLAhV8fPJSPuWkchN8S52mdtVGSBWytJxQoyYiJLUokosr9I5q/jyqy3f4I1Zpe/DCMMDW0U3nUl8XjZWBqOaPqHyXYv8oM6/hBkkAzBWDwGQnbw9Pb+TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290902; c=relaxed/simple;
	bh=3xH3qWof9iskT+svJ3Ofkpc3VWG5qZ2V+ON244P64yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNSJuR9sOrkRdZCPxrAL81kQIvGa+CAcMVBbEscWRG37gK/u0EJovXV8GIpn/038w153ytOUgbRHRwE2MRI57K/+rCyj/d/VxoysLKcaz1kt1+zRJ2SRweHozwzyx8AHEBOV2st79haRVgxVvW9SaOTDYP3EduaDhQDHJ2bRZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oh+8eXZd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so8527035a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730290899; x=1730895699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mU7t2F60MLsG2LmsYh482PvDcQpTzay71lGqfQCsp9Q=;
        b=Oh+8eXZd4iJxoaHGgtGVncUgxDsPzb+lQQMM5NQ87soU+7+xHSbU9586JX6JwEUWlk
         b/VRsxdFbFX9PUAu224bdOIXmS/pgiGDLarglHizS7REueoW1dUf3e8cR0Wx7AAIuwIF
         1P27UFbJ0zymePvBUapTUEAbdWHrHtqoRuH1Q1FHskfAj0pYQRXWuwCUrCdd7wPfWZvw
         YE9gQ1x3eqoARFkpGt+w1Zne31yrM+7y66gh5aWrN+TIHxBBwOwNKo53miG5Xcscxe+D
         0LiK4SFGF6Vu/XnmOGh2ErIKgh/EnpH9lZp7i6/oiJZp1MbrVGCWgmfFBjv+WExYkP/i
         4/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730290899; x=1730895699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU7t2F60MLsG2LmsYh482PvDcQpTzay71lGqfQCsp9Q=;
        b=rWQwDxQVQm26TtWk+ma1INABZcJ63ooE1uDhDZNTZ9WOzlImSIKazoeE+q+YtRoM2+
         HzDSLV9zv1hk5oCXUvfycVlwFbCrJypbW/UHTFmYrF3Xkz6+zfuiI20N04oyK1yDc2f/
         YqB2/1uJi2bXgR2mh2u+7/089CVPera21Am1+YJSYwrVYqvLXKnw2rYWRDjH5pLgf+y7
         WTNO4UOMU12CxquXYfXAI+gyBz0zoFjWF4E3I66UxjgJUi8tDJaa0HkIZNIWNP0ecPhw
         x25/PMGY6Ed5cNWFJsPcfPmPgMngNuFliaEk0/YvAKyxSO1fX+TlnxjUeC6fCYj4h1c4
         AZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2EFk8V1BW7g8aM4eKr0bVF31XMPnAgQ9vDRre4V1Ckr5UjbE5zjoK29GKY1ctorIxdGawFR3rKBAYJFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7LTyjKziPp8BtmSM0eDT1VgKfuWyHIWze8AYCgYHOZvcI6b5
	stYVOt7ld3c7ZOEVoF2geGtSZyb+HoTnmGQTVxxWK87LyPmskNi7
X-Google-Smtp-Source: AGHT+IFLs++qvOnrQcBcH8hYdDdVxrrVuWucZjSjakPaFv4ezw0P51xiY+UuomQqQpb3qzlI8z2wIg==
X-Received: by 2002:a17:907:9487:b0:a99:c0be:a8ac with SMTP id a640c23a62f3a-a9de5ee477dmr1552093866b.37.1730290898593;
        Wed, 30 Oct 2024 05:21:38 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029890sm564494466b.56.2024.10.30.05.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 05:21:38 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: linux@armlinux.org.uk,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	elinor.montmasson@savoirfairelinux.com
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Date: Wed, 30 Oct 2024 13:21:12 +0100
Message-ID: <20241030122128.115000-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. This
change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sound
card node properties") which moves away from the old "spdif-controller"
property to the new "audio-codec" property.

Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node properties")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 333ef55476a30..c771d7dbcadcd 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -321,6 +321,7 @@ CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_FSL_ASOC_CARD=y
 CONFIG_SND_SOC_AC97_CODEC=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
+CONFIG_SND_SOC_SPDIF=y
 CONFIG_SND_SOC_TLV320AIC3X_I2C=y
 CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SOC_WM8962=y
-- 
2.43.0


