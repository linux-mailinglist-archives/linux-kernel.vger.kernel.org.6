Return-Path: <linux-kernel+bounces-283799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC194F8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8411DB21266
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02B18B47C;
	Mon, 12 Aug 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="XkdwHxAG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE679CD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497377; cv=pass; b=CKbY4dTltzlWQcaplJvlJr0dNRIA02MJrC3inD/Km3R76IC62xe4oXwmUDnqH/JYkYHoPbfpoNRHUsYZcueagXfesue5rHuhDD4x6GYpA5BHkxwMBjYSPraAYISpMiZ4HjSSLkk9lmG2JRJSOPVQ3RQuhUPvzOgzvmamxcSvrqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497377; c=relaxed/simple;
	bh=MnO4tIREus6heRvqmjc4AnWIi7fYa5MCQ1KAHajbuys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EdOmThKbEAjwna+sggyNJZyrsrMMIfJnYLr6Oc6NItlfL0MNK+6+2YBWz4GBei7fdL+Ny+cYglguYfaCzkt6ZxHNofOa+n7jGFhQc01iyYsO1JkjHTx+vF7fSbZn74hmYvD5n5aiNi6HkxU486r97pjeOksAo4wkkXbkZwMA8+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=XkdwHxAG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723497340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lLM8Nabp4cPHVThFZTVOq5Bd+gc6p2PC79wIMbKRl9Hcr0l1ujTJk78kaSHIbYBwcmGJmKxjmUOqKA/Sspoh29t4RCcWW+iV6tXGn9l1N8tZkh+KK98LcCsn1B65enUBdDhZX8s9QWkaESpu+C4bJPK6H5V7e2d4BcVVfRinMOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723497340; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nI08eMuuYklw9xaxXgCwGjyVvNmHkByhpTj6sj4w9O4=; 
	b=dzuBH1QtKNU2bABQNS2za1JhS+n6HtYzV3crBzYqBCovMDer2XumU9a0oAbt7u9WsM2BSqu2Q1yCdX9PPJ5iobd7zZbb7byViJWPKz+AwJl4Vo4Ndeg7uQMGn8FteUcKuXz0biy1j7NxlSuQ++2AMQk4OLTxc0WYNbAoIauyuzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723497340;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=nI08eMuuYklw9xaxXgCwGjyVvNmHkByhpTj6sj4w9O4=;
	b=XkdwHxAGvcxLoBbNv/2+Qtr/rFlGZr+zlG22nw+JFQeMFdFU/os8KSBsqV29YdEb
	gWIf6HpQeYvzTQGslOVVGZ07PApOnhm0KB+XE8GBrOE89iq2wHRLw+9Ry4vqjtc5AsU
	6ONUJ0om1NrFJhf3OAd0ksQXPgxsxjE9t7kWR1M4=
Received: by mx.zohomail.com with SMTPS id 1723497338310681.7662889692687;
	Mon, 12 Aug 2024 14:15:38 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/4] Rockchip DW HDMI driver cleanup/improvements
Date: Tue, 13 Aug 2024 00:15:07 +0300
Message-Id: <20240813-dw-hdmi-rockchip-cleanup-v1-0-b3e73b5f4fd6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFt7umYC/x3MSQqEMBBA0atIrbvAxAHxKtKLWClNYXcMCQ4g3
 t3g8i3+vyBxFE7QFxdE3iXJ6jPUpwByxs+MYrNBl7ouO6XRHujsXzCutJCTgPRj47eAVTV2pNq
 pbYgh5yHyJOe7Hr73/QBMFmeOagAAAA==
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

This series provides a few patches to cleanup/improve the Rockchip DW
HDMI platform driver.

Note the patches were initially sent as part of [1], in an attempt to
add support for the RK3588 HDMI TX Controller, but were removed in the
next revision as the patchset followed a different development path,
i.e. not relying on the existing driver anymore.

[1] https://lore.kernel.org/all/20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (4):
      drm/rockchip: dw_hdmi: Use modern drm_device based logging
      drm/rockchip: dw_hdmi: Simplify clock handling
      drm/rockchip: dw_hdmi: Use devm_regulator_get_enable()
      drm/rockchip: dw_hdmi: Drop superfluous assignments of mpll_cfg, cur_ctr and phy_config

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 92 ++++++++---------------------
 1 file changed, 26 insertions(+), 66 deletions(-)
---
base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
change-id: 20240812-dw-hdmi-rockchip-cleanup-33b8c16f65ce


