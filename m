Return-Path: <linux-kernel+bounces-439960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E3A9EB6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CA2162F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB122FE17;
	Tue, 10 Dec 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P2f+7EHd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320D2153DC;
	Tue, 10 Dec 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849020; cv=none; b=EpHaxPRhGggfePbNzRgALqTeOG07sS3evPMjbdv4sJnXyK7rpqRDyGSIappaIuznXMeXJGcagKb+FfunUVkvVcuJURnTOSEMASScfHqUWq89jifycDx5zS0OVdP7BlVl0aDC4KsxN5yTTW03E20FqjNMT4npbHTp0jfxE6gAd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849020; c=relaxed/simple;
	bh=ZvD8OXAxS0yJUidLsVdKZA2YjRg0YV+PscUgOu6Lb0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY7QUoDxFpcdEpMHbg3aNF9U+IL3vjUtUUN5x4oyYcfZf7ZvJxDZUkSb3HFsjXRWQ9dxAp1iy7pZpqshiqZ3U1oX78QafpKG16dBkgLkJPdK7ypoJLd9A/i3RrqaLuLON7RNja4vu0uzgphTxoMw4S0jjOU0Rj0uLpxG4pJSUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P2f+7EHd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733849017;
	bh=ZvD8OXAxS0yJUidLsVdKZA2YjRg0YV+PscUgOu6Lb0o=;
	h=From:To:Cc:Subject:Date:From;
	b=P2f+7EHdLGnKfNttoyErGAHVKOkcbZYdTUqhR94eUUmgoSubDuhoWi8sw+pvIHTMi
	 79wczl8rZgzbO+eqoS+wMfGx+nepQ3YSlURpIFQvu3M8SmthMFrhCzjY1EgtmLFUQP
	 A4Eqm309guTngUUWjbtN4jUzvDWPCOIsVWbJF3qOKRKQi8czMfmkwDkOr8DCPDdIQC
	 yfQJIWhqpsk82JENzFd1MaAFcBOns1jRW+ghnExJ57jlphvqNsrz5fTc+6S9Mgcodt
	 1I/3tjxZypiRLPuB8wimrjGsi0lEfiZwxOMvlmEhHZN8C3EbXbrWKFB1e+rR3wGqiW
	 OhXRu9RG3tTng==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0407D17E37AF;
	Tue, 10 Dec 2024 17:43:37 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 68DCA48CC8A; Tue, 10 Dec 2024 17:43:36 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 0/2] Rockchip W552793DBA-V10 panel support
Date: Tue, 10 Dec 2024 17:41:29 +0100
Message-ID: <20241210164333.121253-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This has been tested in combination with the series from Heiko Stübner
enabling DSI support for the RK3588 [0] [1] on the RK3588 EVB1.

[0] https://lore.kernel.org/linux-rockchip/20241209231021.2180582-1-heiko@sntech.de/
[1] https://lore.kernel.org/linux-rockchip/20241203164934.1500616-1-heiko@sntech.de/

Thanks for having a look.

Greetings,

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: display: panel: Add Raydium RM67200
  drm/panel: add Raydium RM67200 panel driver

 .../display/panel/raydium,rm67200.yaml        |  72 +++
 drivers/gpu/drm/panel/Kconfig                 |   8 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm67200.c | 503 ++++++++++++++++++
 4 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67200.c

-- 
2.45.2


