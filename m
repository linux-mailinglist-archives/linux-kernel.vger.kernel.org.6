Return-Path: <linux-kernel+bounces-186634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C08CC6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB72282DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8E14658A;
	Wed, 22 May 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ra4bYDEH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A931BF2A;
	Wed, 22 May 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404397; cv=none; b=WDLldLMAEcaBatUJ0WrjbTEnddVsUjs1E/L+vjt7/ty9Vc01j1Me1QZ5SUaaDpWrcc9267eTQNjHRa+SSHDWe+r5pD8u4Y3/0VYIhUYCR9zKhXe3G1P9fTWEI/hO235u5Uknr1EKWH/zIYoH0OQ+bXYpM7uneoReGDrzdN5m/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404397; c=relaxed/simple;
	bh=lm8k6cSxbN2GrVxuYEbg4VxWMDNFrajpEdmYY4k5qro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQmsFbR+EQPMeaHGbfN9XgzFMwmONiTxGj3tiknE05dWM7NVQTybCgy65t6KiIk970hOkVFvfBb//n7b+Rh12VkZgAmwhIIEQaRq8L78QK6hva9Uw2JVUv3C2tc0fdESqDF7196agBUP5FiA9loCkk9ZRl47xPbv9ksBsG0j+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ra4bYDEH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716404393;
	bh=lm8k6cSxbN2GrVxuYEbg4VxWMDNFrajpEdmYY4k5qro=;
	h=From:To:Cc:Subject:Date:From;
	b=ra4bYDEHRutYlU5PzUg3VvmAEBtFGOnvMe/9zxuILkGD0Y5YUT+QV33nXgCq8wou0
	 qJnJtouYSY14vbxON0F0KuN5O0pQ5pZ3uo/SVpzKy4JVQ7OUbWmcpcl2scL59bfAfA
	 YacR+6fQBFLMZ7bvovO8M3T40PI15R51sFI1zCsAV34EI7I5/+BjohdHQGzf1WEwM/
	 hSnkp3iOMLWBYifFHE7XkpwW5VAWrraoE6QsqhBbwgy/MifoKnMvB8cxkIYNtJAnlD
	 lagTyE9BGW4QpyYerxqSosKKifXFuT8utl3Jp80PS63b4ZtW8ifjEF45X+/ODOYt1i
	 37AQdquoNdkNQ==
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BA6AA3782169;
	Wed, 22 May 2024 18:59:50 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 0/3] drm: rockchip: vop2: Add VP clock resets support
Date: Wed, 22 May 2024 14:57:47 -0400
Message-ID: <20240522185924.461742-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock reset must be used when the VOP is configured. Skipping it can
put the VOP in an unknown state where the HDMI signal is either lost or
not matching the selected mode.

This adds support for rk3588(s) based SoCs.

Changes since v1:
- Add AXI and AHB clock resets
- Set maxItems for !rk3588 in vop2 bindings

Detlev Casanova (3):
  vop2: Add clock resets support
  arm64: dts: rockchip: Add VOP clock resets for rk3588s
  dt-bindings: display: vop2: Add VP clock resets

 .../display/rockchip/rockchip-vop2.yaml       | 40 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 12 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 30 ++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.44.1


