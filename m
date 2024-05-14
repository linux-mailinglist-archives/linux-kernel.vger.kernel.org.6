Return-Path: <linux-kernel+bounces-178852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5F8C58A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD68282535
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEE17EB94;
	Tue, 14 May 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h6j0Oi32"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C783A0E;
	Tue, 14 May 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700254; cv=none; b=K9pHwYXjcvcgdjcazTH4QoIkBBakuNos6wqiXCberZCUTg8hPQumI8VB0evOy+kT2lH7ICtJjFVNxXBIRhc0v25DUaFLnfn4JSUL6mvVO7vQ2tUdSIhieMYAxpfTs8TvfIUh2wtZijeTGETKd2Bn8f3a44s13sSjnCKesf0RpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700254; c=relaxed/simple;
	bh=CqnaB1BN4nBb+zItuDL9d2XlJtw6H0xho2dEcrDXwOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNTXMWYr0o12ZIHQwDjJnQgjRTaDDwvSpIbui1+pjYUQos9MG8TS46OCO+qGTyJ4ODDE3FRGjMOek61x4cxYfqAR28/Q6xTJu3+f+d3nENtKoCE1xDdOOTv28S4BODjAw36hRJ9zzLEOtteWrKiqyuoo5kfg4S8wqGPgpE6T2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h6j0Oi32; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715700250;
	bh=CqnaB1BN4nBb+zItuDL9d2XlJtw6H0xho2dEcrDXwOs=;
	h=From:To:Cc:Subject:Date:From;
	b=h6j0Oi32w48wjQBW7NWOXa7mbVqQFc69vrfraAeHWNegLn+qS56X3wPmDRBlxfTCA
	 nZ5rx+Fm1LJTt10D1FLZjSeLwXqxohZWaYkSmlUoXHiLdD2Xrpk2yutUzv+RQWYga9
	 T22iQyj1PzcD6/UWX5IePmOVIWFhOUQ4gXlXRxUr/lvx4/eQs0a1yiXOz6JHmRCyeT
	 6Ei4olmbRS/CMynULtfFHAC7COmP98F3SSY7pW3mBy6n5SyOBf3dbh0+RKqX6cUWm+
	 68fjXNy+SawuwicCdGep/8CKL520KVpe+q+BiGvWNNzsN8qZIo16wNFvG2FpvAGjeG
	 ZzYtNvIAbFeAQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1D45637811D1;
	Tue, 14 May 2024 15:24:06 +0000 (UTC)
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
Subject: [PATCH 0/3] drm/rockchip: vop2: Add VP clock resets support
Date: Tue, 14 May 2024 11:19:44 -0400
Message-ID: <20240514152328.21415-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
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

Detlev Casanova (3):
  drm/rockchip: vop2: Add clock resets support
  arm64: dts: rockchip: Add VOP clock resets for rk3588s
  dt-bindings: display: vop2: Add VP clock resets

 .../display/rockchip/rockchip-vop2.yaml       | 27 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  8 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 30 +++++++++++++++++++
 3 files changed, 65 insertions(+)

-- 
2.43.2


