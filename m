Return-Path: <linux-kernel+bounces-401885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F6B9C2096
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C334B23F34
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E2121B42D;
	Fri,  8 Nov 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojh1PRn7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629F21B421
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080163; cv=none; b=tEkWNbfCnOGtSyOrEEg8PMVg/q9gsGbx2PwIWbkupsvudOyNHarv3OcTPr+tkfR1pjFwKAzOYYt8AA/DWP+NQsqYJ3X6oTUlVbo+U9abBXTYcWzfWg0242O1DtpQqu5B3sQM6huqqhWgHMbbJKcTQ1TQP8I2qmK++SgXGc2d5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080163; c=relaxed/simple;
	bh=PQ/aJvm69j4lPhF8o2Xa28OhkWmIoRJK40HEev5Priw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5MEzLvfLzJILlqTqJS4GhCaPb5n9DjFZn6y+NeKCJ+NwvhhkoK+zLgF52KL/CQqnzxjcpX8r3aWo2gW5il0ueyjPQtSmHe6JRDX4HcDnMIQ/4G7gRzpb0PE+zjAkXN3B5lCRy9ZT7J8YmyI4dMJ/QeETAkUl2RvrIcAZ8fHKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojh1PRn7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso18962615e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080160; x=1731684960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nVKb2hvRP3zLcKR7jduFefSLqPzAllC+DJORNI8QjA=;
        b=Ojh1PRn7bd5YgyJEXEqPPG8vCIKpSbDcwue7+RAk/fSY55MH8BawQKlwtRAOpD/BEI
         8E6hozS5TVi68qadGOtuKXc9VuxQwnthRzQ3fMct6zV2h6rMj/trU+94NHntQ5UqMbhz
         41F9uRrN2MZnLosGbA1UA6VqCAVWR/yJxjOxSdDPd2amR998kPVxdvY0pK4H1zBMQ3fk
         Yi5C9zkLxrhFgYcPMN5rPDdwEZ9vbywsFtVg9COEfFEprq0XcOKAlYrmSpt8ZyqqOzsq
         vrNFXCxswbw3T/x15J5/hh3DmN7IZXLy/0Dq+3jbJk2mKSzIrRcK+Sq1Jrpbnr8IVWUM
         dHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080160; x=1731684960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nVKb2hvRP3zLcKR7jduFefSLqPzAllC+DJORNI8QjA=;
        b=DCO8hwZ8GO1eCYUiYEukaJ9cX+mDhLZ3CieUwLYpnGdycjBGoviYLcvKeJfF2utsoy
         RDP/qnWpQQ8RiP0Wcgq8cNxOSkNdauqYfbeFW7fZKbrKW7gnqk6OB3XOhaRT4lrab9ts
         4DA6wQpHbj9hChR7odFhPYpyUPvuaYrq3oMdDaC1vhc5mu9Hayz+UvSqCZNzNPL/pKLh
         RyCJ/znyP+GzJLGn1ZD+4KcdBTnoQJEmtirwDfrn3qNSjW240MjyvwPC3QVvIRJTY6JF
         Dy/2WYL+ez5ArOYyaHRDF3riE9A22JHDtQpmM5uL4WoZB9zfhYLfA3yKAZAimH/snk24
         82/A==
X-Forwarded-Encrypted: i=1; AJvYcCU5SQjda9vHmEUhfZ0f15Lm/0HzRN9KQ82tO27Ac4n6kuaW+2utKdgk1d93D3RCR+A9A1CzdTNLjtKZPJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpDjBAYovZNZzn0Q8TDDtDbY8T2W7AkZk2IJjfA5A7FHdhp9m
	amhZx6wBuOjMN0AHfvZth0UGAAOGEWIOWRb2UfOGIQBk7yEoBOna
X-Google-Smtp-Source: AGHT+IFuTl+S8WzS1KOeDdZG5ICETzGr8yuMTt04P9wVoRLrVQEU567NoDmp9dR1QkFr8R1TeWkRsg==
X-Received: by 2002:a05:600c:3ca0:b0:42c:b037:5f9d with SMTP id 5b1f17b1804b1-432b74fd71emr27480065e9.3.1731080159667;
        Fri, 08 Nov 2024 07:35:59 -0800 (PST)
Received: from eichest-laptop.gad.local ([2a02:168:af72:0:c5c8:af8e:e93d:4656])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b34csm74750545e9.14.2024.11.08.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:35:59 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: linux@armlinux.org.uk,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	wahrenst@gmx.net,
	elinor.montmasson@savoirfairelinux.com
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Date: Fri,  8 Nov 2024 16:34:34 +0100
Message-ID: <20241108153546.268695-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio.

With commit d469b771afe1 ("ARM: dts: imx6: update spdif sound card node
properties"), the more generic audio-codec property is used instead of
the old spdif-controller property. Since most i.MX6 boards now use the
audio-codec property together with the linux,spdif-dit and
linux,spdif-dir compatible driver, it makes sense to enable
SND_SOC_SPDIF in the imx_v6_v7_defconfig. This will ensure compatibility
with the updated device tree.

Without this change, boards that use the audio-codec property will show
the following error message during boot when using the
imx_v6_v7_defconfig and spdif audio is not working:
[   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card: snd_soc_register_card failed

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
Changes in v2:
- Improve the commit message. (Stefan)
- Removed the fixed tag because it is not fix. It just improves the
  example configuration. (Stefan)

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 333ef55476a3..c771d7dbcadc 100644
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


