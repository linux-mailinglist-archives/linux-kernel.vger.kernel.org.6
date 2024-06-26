Return-Path: <linux-kernel+bounces-230996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BD9184B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36ED21C20970
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229631850B8;
	Wed, 26 Jun 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd1Go5Rw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636D45C07;
	Wed, 26 Jun 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413089; cv=none; b=FjZd2H3aDGU3ycms+MAASmYhTEkXOHB4E480NUc23ghMqcypT5EmiFvA6U5H5knatuCyk/BzuTCJHvCvZ4Jg4wQgKMGMEN/cY+ctopFXWVBufExNibI7QMWls7d68VtTPixQTHaFhtcIFMsLlHmOCLxBvBBnfIKePzF8osRNsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413089; c=relaxed/simple;
	bh=Hd7daRwxk/5b3ynTV/NWquiYpBPUHgnrHUul26N5148=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sx+bS+HC5gyZdIg66xYj4c+G2ieY9DXO1bYKqWiekJCUJdoOEzVQ250N3C1Oq0DenlUIOpBCN1wMXq3dqDqPF5qlAVAdqha8g8TdvjHVUU6ZfipV0T1XvMmAECSjLd6i2Iq3Nt6XA84gxaofEiLiIzKGm4F4BcCf4TZf8oLiZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd1Go5Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0F4C116B1;
	Wed, 26 Jun 2024 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719413089;
	bh=Hd7daRwxk/5b3ynTV/NWquiYpBPUHgnrHUul26N5148=;
	h=From:To:Cc:Subject:Date:From;
	b=kd1Go5RwfdzjsxpX50Q9C9qSQyieHnReXq62iln9jiHWNngprPriaPPiH5p9rFDWv
	 myL54IJMQqvbT77+L4meE1KgzHUTKkz+1OxqkhahEmIVYNVVi3HKNBzdIC0mFI0YIb
	 hx3qtPIiKXIC55CrGozm9R5ndws8Y8kB6okk4+wHG/saou0S6eQ5PKUmgDze/+aAPm
	 s9RzFS4e9B3DqswOaitVgzRkMnvMKyLJzQh+qEl37ax6kNoIag7Hjirk/+/Hfb68Yr
	 0Jsuvx2Vn9l2iF4B+ceVjB1vfal7bduYMYh0DWgXB2YMZX07IgRXUtQPai7wayevmy
	 fEWivTYdiaJBg==
From: Michael Walle <mwalle@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
Subject: [PATCH v2 0/2] drm/panel: initial support for the Ortustech COM35H3P70ULC
Date: Wed, 26 Jun 2024 16:44:31 +0200
Message-Id: <20240626144433.3097793-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for the 480x640 DSI panel from Ortustech. The
panel uses an Ilitek ILI9806E panel driver IC.

v2:
 - use drm_connector_helper_get_modes_fixed(), thanks Dmitry.
 - slight header files cleanup

Michael Walle (2):
  dt-bindings: display: panel: add Ilitek ili9806e panel controller
  drm/panel: add Ilitek ILI9806E panel driver

 .../display/panel/ilitek,ili9806e.yaml        |  63 +++
 MAINTAINERS                                   |   5 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9806e.c | 402 ++++++++++++++++++
 5 files changed, 480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e.c

-- 
2.39.2


