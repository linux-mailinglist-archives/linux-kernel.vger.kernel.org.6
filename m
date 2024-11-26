Return-Path: <linux-kernel+bounces-422796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87319D9E44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E2C284019
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F71DF274;
	Tue, 26 Nov 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RR9BpE9d"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4D1DE8A1;
	Tue, 26 Nov 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651978; cv=none; b=O04XSoF0bEk7Aicn2/BhnUPU/9uOpSpccZDf2uIo0hIl9oiIrPG/lm3GUyzRenhZg76/FIOZrHJlnMPrlKcE3lYhshul4YoMLhKoKV377sion2JDp/Ifoi84uzVMVPNW4xJpNqRwyq48kyPo+aNczilZPKD42VgrW8iMYiUi37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651978; c=relaxed/simple;
	bh=dATSUb/cm/H2kE3RhPvnpyA0SxLGuMRfNPzjgnxKGvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsGilZzlgAiwwABY3+PMooUhJfCB7Nl2jgPF1mzd81ICPFb0bEcVWrsh1u8U2u86AzouSfwgVk219WRWCXVYdCzx85cDSBycWr9iw+RmYG8M+NtUcu6psh678t3/D/R6QKqlXbBeMjWtX3xt3+dQRfTGyznmXLQxf/Q2kFOXmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RR9BpE9d; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i8SqavSewzD1TGIVT6OBwxDtJQAOeVswFTfEkI2KfEQ=; b=RR9BpE9dyzlXZVn5bRCplQs7Pu
	I9MpuX+zaOn3ksqFuh4qfwx37eBth1T5mnQW9Gb687ZaDhFKM5goEldB/TxppYhCAw6w90UnPhPoV
	HO+qhIVaBwyeMeuYgKp2UjVtIXARd9xx2RN5K8raPSeQs659Nha4xBt44791XwDCV/GDfWG8w25cl
	fi8ZGoT5gXY9bmlKMFbdeAMSI1kp8BAzUe5/rU1G81/13yRD86bm6xUDu+6naGC21NB5Dw0PQLGUZ
	Z+ANj4Ju2eQRzfBppEpi0Dy2iS7+plve2HupOPafDlT4N3Hh+5XFk7xEUqQ8WB1dUOkHERRgozHch
	TUMv9u6A==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tG1ux-0002yD-VN; Tue, 26 Nov 2024 21:12:16 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: [PATCH v2 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Tue, 26 Nov 2024 21:12:10 +0100
Message-ID: <20241126201213.522753-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a bridge and glue driver for the DSI2 controller found
in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.

As the manual states:
The Display Serial Interface 2 (DSI-2) is part of a group of communication
protocols defined by the MIPI Alliance. The MIPI DSI-2 Host Controller is
a digital core that implements all protocol functions defined in the
MIPI DSI-2 Specification.


While the driver structure is very similar to the previous DSI controller,
the programming model of the core is quite different, with a completely
new register set.

Another notable difference is that the phy interface is variable now too
in its width and some other settings.

changes in v2:
- clean up includes (Diederik)
- fix Kconfig description (Diederik)
- constant naming (Diederik)
- binding fixes (paths, sorting, labels) (Rob)
- move to use regmap
- drop custom UPDATE macro and use FIELD_PREP instead
- use dev_err instead of DRM_DEV_ERROR


Heiko Stuebner (3):
  drm/bridge/synopsys: Add MIPI DSI2 host controller bridge
  dt-bindings: display: rockchip: Add schema for RK3588 DW DSI2
    controller
  drm/rockchip: Add MIPI DSI2 glue driver for RK3588

 .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   |  119 ++
 drivers/gpu/drm/bridge/synopsys/Kconfig       |    6 +
 drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
 .../gpu/drm/bridge/synopsys/dw-mipi-dsi2.c    | 1030 +++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |   10 +
 drivers/gpu/drm/rockchip/Makefile             |    1 +
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  523 +++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
 include/drm/bridge/dw_mipi_dsi2.h             |   95 ++
 10 files changed, 1788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
 create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi2.h

-- 
2.45.2


