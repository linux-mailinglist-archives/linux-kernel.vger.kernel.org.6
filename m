Return-Path: <linux-kernel+bounces-228957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837E916916
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D791028AC37
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8241667D8;
	Tue, 25 Jun 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o310z5fg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F31607A7;
	Tue, 25 Jun 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322547; cv=none; b=Y8+cV110yTOk75muhq3OGe4VtS5MmN9FRQ9+oJVl577UnlvNn0bh4nLri2a1IierTVB1Yx8R1lO/VbfIkVaSQiQ0oy26shnbyeBZH+zGyf4FKLpT2aQzyc7Gznpw6NODJmtcdkDryF+M7Uk22w5h/WwWG0Y5SPz0c4HIxc9FuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322547; c=relaxed/simple;
	bh=MuIgi2rVJpIa0IwYNcsJ7osmJ4rVGwuAMgxuVIPDTxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0m8Z+1tBtlmRn7D0/T76agBvrzp7y8HdbB3fmaidjWy/UAT2kLNCpFsaSTlSaoMjqGlx1Uv2yHua9kpXVBpYKirisU1TS7lHxludD3n/uOwwoTleVP6AsmZ9VX1eO+37S9NqAhB7sB+/pDWATDFtdELz7Rdn1ft4rEgRiQfRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o310z5fg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6372AC4AF19;
	Tue, 25 Jun 2024 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322547;
	bh=MuIgi2rVJpIa0IwYNcsJ7osmJ4rVGwuAMgxuVIPDTxc=;
	h=From:To:Cc:Subject:Date:From;
	b=o310z5fgMZ/huy02LqBGnCv74F06NXRNGJe0S5JP8n/4/TDbwx9tBWtsEBTdRHkh1
	 7mf3lUPnU5TX5uTneCPEumPeqG4S3cdB3TeU6p1IXcZ4U1o8MjpdgzwKX63yCN1vgc
	 Htl6ioX1pmE+0vWAURLEO/InwvSQbmvC8gh9y7+2aOPCERoUtoPf/HijgekgG6Z37W
	 oJQ1VxFosym/F3GaKVEobocMN2GULqo88zlZWftSu4t+zfrqiYqVTY48YqhBGw70Dk
	 nTikYvs546KzjeQAcgkxQ0Q/J5MJ7uVb1uZzN2NDjrliyOpdwlzBzd3CMw5V+Ao2Vq
	 q+Tamlt74NLPg==
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
	Michael Walle <mwalle@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
Subject: [PATCH 0/2] drm/panel: initial support for the Ortustech COM35H3P70ULC
Date: Tue, 25 Jun 2024 15:33:15 +0200
Message-Id: <20240625133317.2869038-1-mwalle@kernel.org>
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

Michael Walle (2):
  dt-bindings: display: panel: add Ilitek ili9806e panel controller
  drm/panel: add Ilitek ILI9806E panel driver

 .../display/panel/ilitek,ili9806e.yaml        |  63 +++
 MAINTAINERS                                   |   5 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9806e.c | 413 ++++++++++++++++++
 5 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9806e.c

-- 
2.39.2


