Return-Path: <linux-kernel+bounces-558595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F096FA5E852
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23907AC5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9FF1F1931;
	Wed, 12 Mar 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKh0bE8f"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028D1F1531
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821804; cv=none; b=dbee0APQ4dlInBZdTxQ1FYcuI2GnGXgrZEJoUgWY8oDRdVAl4b9zWLbGpKQAWIuTnVBbRjA8j6DSx1wh8YHvk198an6wCW1EjbJS+yICbUDWnuhVPTPBD04j4+0+w3fX0HYvEW4YEKaHNNEtu202osPyKDDrO5bqm+WFnkFsbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821804; c=relaxed/simple;
	bh=jKbOUFo/QpG3issCs2i4WX7naelfGHn+4IO1WTag5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6nmE4gzvZgbJNPKBXkRyfQbc+W8SJouryaViEAFlNnhc6Z7pTZnFnpWR8UuIX27pg0xUz1J6LMzcAu1nmP/JWMXios10pF5DzP4SFu9H9/MtmQMISxkAL6nnFCz623S8+t6FW+ASuS8jrUiDglxc9t2d8fgv8IZI2Tujk/aNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKh0bE8f; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so574304a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741821801; x=1742426601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLItQqCf1upGBSXyTCmQWhPc9KffbuhOFWAykScbb6c=;
        b=NKh0bE8fkwDWnweoV7Wx/22KvHyGbHeG8GYyJSBopXPyhmOm7fqVsulfcSectUJPMV
         v9kq60knheHu8RG8Y7AC+a+vEnmsS3vTJecetaQ492jirbd80wO3X4j08K1tps3YMjUp
         duBEPzTu7AbltV0iHKF8XOdgJylkloWOJPDX4nSjU4pjrdDmUOUXFL24ji1Glb2vlVDS
         2qP361zuvUUKRDL7H2elefcFTeMxiZ7VIARI70EXAM8Lq7uEG1lHMIHiTjmD8VtjG5lf
         4A80xghyx38Do12Gv0hGDi2jPDPFU/JHLyziCeNi5rheYjGwNOWGHjMae4A604UsD6ES
         SSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741821801; x=1742426601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLItQqCf1upGBSXyTCmQWhPc9KffbuhOFWAykScbb6c=;
        b=YggNKKc411LIHrC20rxaysJqDmWR9euvxelQUNGIsdYaSPw3/hwZ9mNJ1Z5sXeZaDM
         7GBu7v2FwDtgdZxD/UHjoJSVM49/xBPA6aeuN4nDwTD5iHwNdgLYGj4E615HMY6W0eYf
         EuomcV082MgQIQK07dmehLTR1cv6JQUgvXdjdjjJfuUSh5zNqTm/PpCjL7r8HoMsFJtp
         Pu516ErblYCJQ0dwuTAkYi/gNe//hJ3ItVeoHNlwTIyDGFF03Lsixid2of5bAAJ5gfTg
         WvManku7287FQJ5TUJ/3XhbeBE6wDim3rqiRJfnsf5jcTszg80I8Je4NriMR9V4s8rKQ
         MKgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZlkK9f+IRsxpelk8ONeCiiOXb4MY7zi9vHIIaH/UuC3MAVU3aqwPUMcc6HoRS49P7HccMWdOpZTP63o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1bv9ij1JV4dMrhXNTxhljheaG3i/2hg2PfcMmdm578rHtJD6
	uPrx++yN2pnmEVTBRAbaMWbqdY12t4vYOUQoWVP0NHrCpUCa+LAO
X-Gm-Gg: ASbGncusNbn17XvhUFsRjF5PFMgW8cFIqBYhEIjXqbB1kdTdtgB3nfA7gc9CRTo9NBm
	ncngRR34oZ5GjlkEX7vjRj9YQ2cjQMRmyGyvb7nwIgPpOqqGlcPBxHnLA7ITxYRNJd9mJ128v5v
	sW/VrheRjIWrL0HaL0V2khOjXTOlUHuaKZW6NMfQTJj/84NlxRE1ueaylGvdhJk/NawNf2c4+VY
	YvPriVvFJRAHNCDhOGrpXaKNXaGyoENwje/p9bYvF2pTk1bjKAyboiM8O/vDO8wyBrTw8NHze+2
	rpKIqpng6q8QpSpM6NUdIidEnXBIKTW0ICC14kgm1LIQShNMej3hRGJiEdR+1DE1IiSFu5SBYEz
	YxlhvpvM7+aBfIQ3/CwHTBKfjEoFN5X4=
X-Google-Smtp-Source: AGHT+IGTT9lbHnlAuZxDgl2ruuPaXaEWe6rhYtxsk5VuLikqAKEjXsCw9yzdc7f50PpSyBlv1A41Nw==
X-Received: by 2002:a05:6402:5109:b0:5e0:58ca:6706 with SMTP id 4fb4d7f45d1cf-5e5e24db96amr31469423a12.30.1741821800942;
        Wed, 12 Mar 2025 16:23:20 -0700 (PDT)
Received: from localhost.localdomain (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe223sm26732a12.70.2025.03.12.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:23:20 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] drm/panfrost: Add PM runtime flags
Date: Thu, 13 Mar 2025 00:23:18 +0100
Message-ID: <20250312232319.25712-2-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312232319.25712-1-simons.philippe@gmail.com>
References: <20250312232319.25712-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the GPU is the only device attached to a single power domain,
core genpd disable and enable it when gpu enter and leave runtime suspend.

Some power-domain requires a sequence before disabled,
and the reverse when enabled.

Add PM flags for CLK and RST, and implement in
panfrost_device_runtime_suspend/resume.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  4 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index a45e4addcc19..189ad2ad2b32 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -406,11 +406,38 @@ void panfrost_device_reset(struct panfrost_device *pfdev)
 static int panfrost_device_runtime_resume(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	int ret;
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT)) {
+		ret = reset_control_deassert(pfdev->rstc);
+		if (ret)
+			return ret;
+	}
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS)) {
+		ret = clk_enable(pfdev->clock);
+		if (ret)
+			goto err_clk;
+
+		if (pfdev->bus_clock) {
+			ret = clk_enable(pfdev->bus_clock);
+			if (ret)
+				goto err_bus_clk;
+		}
+	}
 
 	panfrost_device_reset(pfdev);
 	panfrost_devfreq_resume(pfdev);
 
 	return 0;
+
+err_bus_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS))
+		clk_disable(pfdev->clock);
+err_clk:
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT))
+		reset_control_assert(pfdev->rstc);
+	return ret;
 }
 
 static int panfrost_device_runtime_suspend(struct device *dev)
@@ -426,6 +453,16 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	panfrost_gpu_suspend_irq(pfdev);
 	panfrost_gpu_power_off(pfdev);
 
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS)) {
+		if (pfdev->bus_clock)
+			clk_disable(pfdev->bus_clock);
+
+		clk_disable(pfdev->clock);
+	}
+
+	if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT))
+		reset_control_assert(pfdev->rstc);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index cffcb0ac7c11..f372d4819262 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -36,10 +36,14 @@ enum panfrost_drv_comp_bits {
  * enum panfrost_gpu_pm - Supported kernel power management features
  * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
  * @GPU_PM_VREG_OFF: Allow turning off regulators during system suspend
+ * @GPU_PM_RT_CLK_DIS: Allow disabling clocks during system runtime suspend
+ * @GPU_PM_RST_ASRT: Allow asserting the reset control during runtime suspend
  */
 enum panfrost_gpu_pm {
 	GPU_PM_CLK_DIS,
 	GPU_PM_VREG_OFF,
+	GPU_PM_RT_CLK_DIS,
+	GPU_PM_RT_RST_ASRT
 };
 
 struct panfrost_features {
-- 
2.48.1


