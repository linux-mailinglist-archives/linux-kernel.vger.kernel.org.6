Return-Path: <linux-kernel+bounces-309018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526C8966541
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F751C21504
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8601B5815;
	Fri, 30 Aug 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwDWIf0H"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912291B581C;
	Fri, 30 Aug 2024 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031317; cv=none; b=sKFBABSs8ZlIifY+5ZdvAD6udDkDZLrxQUodp2lPVYEYOte7mf2udKc1Nknbx/lc8K3YJMaJfoWyolDnhY2ESWflYkPI8Csq0eWO4CJK3sFhOdoxTlhzPAXlzfCasFxzxh3m4RTF7+/j73T/Ug596QetrsMgfOMRszX4dVMIGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031317; c=relaxed/simple;
	bh=91uWyfm568CCbYIbngjclSfnY9hEYDhvMPm+4uK4NBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFhjCVizP7OwQ9tstO9bIRsXvHb4Duab/4VT4nxZs83523J8TOwI4DsWiY9O1sNl9citmz0HqV5nqJXkp+nCBaOvb3r/b/jcsYxKTMIloU7W5NB9IMOULg74mMIDy80M8s+n2Z44RnXCrkDPbG5uE9pWsI/WfQELd3sXC+otG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwDWIf0H; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39f37a5a091so6570765ab.1;
        Fri, 30 Aug 2024 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031315; x=1725636115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwcy2RWpl0Jy35HmMik2lryKjWDim5fRSydnX94H64Q=;
        b=HwDWIf0HPBsu4HNF862FshlIg2mWDFzqK0nBKZrs4apvWRURDSSv/fY0IDBocSnZsi
         vtU3mMrn/ZHDqDZHkremWn/vN1IJwMF/YgbDoH3uvQWNYMLUANmdobou7gXF1JOQHTXy
         yCsuJ945xcw+byNPwNdQmSR/egF6yd30Fbpsl5P9xtOpoKoLdv/AyBo3g5Z1h5lo0ht3
         pK/GFlMBQm9n8Dgy2pug0Q964RXGClWbMK0EsWmdxmc2KcBHSt0+0MFudGbPC0igOjsu
         6+/y3sQT0Clasq6qY1LCpqxarAKpjyWvKA1hqJQRKZ+SSnOlE/Fa7gPTqgFLVjXFfdX3
         +2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031315; x=1725636115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwcy2RWpl0Jy35HmMik2lryKjWDim5fRSydnX94H64Q=;
        b=WIxbJRZxLCThavku43QkzUAzHCesz0L9QfBBLex8IN/fwmyAG77kZk7XuclTG2SUSs
         Mkp/ndPoTqBvU7cDIjYL9NlyFYd4ot6sf89PuHgwm07XSEWKZPJQ001Vg2H2QGiCj7IK
         EF96gO/L6eWc3oSIWvRW5MYc0lZ30PUFd5rw2CxXBDDa91Ixf1qoR2UPejNkeXkSvQHt
         qJzAXmnjlBA7peSs6NBFEo9XR6wxizA8Wkw3F1Dtevxii8ZK2hHH3YJtTrrot2wfBNDS
         Sd4LcrT6dQpC0WkQAwyr/Cjh1liPVkyKooxWkJsLLFXt5eDXHZoS2ppeDObGg8Kc3+x8
         1zsA==
X-Forwarded-Encrypted: i=1; AJvYcCVKSAy7eHF6SmOVhBWu/tHi/HmCkJRU2YlE+L93eFTbqbrK1Im7gMXDrxeUIP5OpHZZj2CcrBtLM9Ux@vger.kernel.org, AJvYcCW/D/c2GsYyno2D1Nw6t5plh0DSMORVWTCCZ1gfWs2d6qMkFkG1aMp5NPqhIL3SxZZJ3yHKkMTMRYGsaJ7U@vger.kernel.org
X-Gm-Message-State: AOJu0YybT4TI3dl3CgglBrnrLrlyhvSXn83RAuBKSIraVFFrnRBFiSi/
	FEoHoH5s65tntP7GSLDb7uT8/UX3RcYnT3JG7amHHCQR0BB5vtPb
X-Google-Smtp-Source: AGHT+IE6+7F4IwUjoUpungdPIgK7N7zKDEIZ0Pa/PFwI4Lam2pC3QvZ+yFwkBy87CRSIvERTOe7b3Q==
X-Received: by 2002:a05:6e02:1d04:b0:39d:286c:5b72 with SMTP id e9e14a558f8ab-39f378acb8emr64753255ab.28.1725031314408;
        Fri, 30 Aug 2024 08:21:54 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3af97203sm8826155ab.1.2024.08.30.08.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:21:53 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	markyao0591@gmail.com,
	s.hauer@pengutronix.de
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	aarnoud@me.com,
	ldearquer@gmail.com,
	algea.cao@rock-chips.com,
	cristian.ciocaltea@collabora.com,
	Shimrra Shai <shimrrashai@gmail.com>
Subject: [PATCH v5? 0/6] Tweaked basic Synopsys DW HDMI QP TX driver for Rockchip RK3588
Date: Fri, 30 Aug 2024 10:21:24 -0500
Message-ID: <20240830152132.8894-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I saw Cristian Ciocaltea's proposed basic driver for the Synopsys DW
HDMI QP transmit (TX) facility on the Rockchip RK3588 and noticed that
it had seen some critique and thought I'd help it along a little by
making some of the changes that others had suggested in the discussion
thread. This package is mostly like his(?) original but features the
following changes suggested by Conor Dooley and Heiko Stuebner:

 * Documentation for the device tree bindings specifies the various
   clocks explicitly in both the general (synopsys,dw-hdmi-qp.yaml)
   and Rockchip-specific (rockchip,rk3588-dw-hdmi-qp.yaml) files.
 * Changed the compatibles for the RK3588 VO0 and VO1 GRFs in the
   Device Trees (rk3588-base.dtsi) to reflect their different natures.

and some of my own changes:

 * Tweaked the driver code slightly - mostly organizational, but also
   added a mutex around device access in the dw_hdmi_qp_... method
   that was present in the downstream BSP driver which might have been
   necessary to prevent thread bugs.
 * Improved grammar & punctuation in some of the English on the
   Kconfigs and output messages.

Let me know how you like it. I hope this is suitable enough for kernel
integration as I'd really like to be able to get some of the newest
kernels having video bringup out of the box. I'm testing and
developing on the Firefly ITX-3588J board; not sure if this will also
work on the Rock 5B too, as I don't have one, but since little was
done to the original driver I don't think it should break anything.
Moreover, I wanna get the device tree bindings nailed on this point
because I'd like to prepare a UEFI firmware package for this board
that would be capable of booting mainline kernels from this (or a
soon-to-be) version onward, without needing a separate device tree
file with the kernel, like a "proper" PC. That naturally implies
having at least all basic desktop functionality down, including video
output, before the DT is "baked" into the firmware.

- Shimrra Shai

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
Link to Cristian's original w/previous versions' history: https://lore.kernel.org/linux-rockchip/20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com/

Total changes:
 Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml          |  89 +++++++++++
 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml | 171 ++++++++++++++++++++
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml                            |   6 +-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                                      |  44 ++++-
 drivers/gpu/drm/bridge/synopsys/Kconfig                                            |   8 +
 drivers/gpu/drm/bridge/synopsys/Makefile                                           |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c                                       | 780 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h                                       | 834 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig                                                   |   9 ++
 drivers/gpu/drm/rockchip/Makefile                                                  |   1 +
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c                                     | 431 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c                                        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h                                        |   1 +
 include/drm/bridge/dw_hdmi_qp.h                                                    |  36 +++++
 14 files changed, 2409 insertions(+), 4 deletions(-)

