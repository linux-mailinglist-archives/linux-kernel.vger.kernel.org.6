Return-Path: <linux-kernel+bounces-429027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E39E1860
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3219FB299D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66711DE4C4;
	Tue,  3 Dec 2024 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="IohL/7cH"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2E1DDC3D;
	Tue,  3 Dec 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216340; cv=none; b=OPMg5Gw5rymLjrH8kaZ+8tsoVV+GLz2jATxsMMZMStZ2SK2qRib6n+g14BXUA6Rdynw/KFv/pxgAbso7U+j7uljvrIfp86QkbfS3MfQSL0n0FZrTrCjKCwkgrtDXrX+tnPofDLj0FiQulgN6yBPAq9KFzBf/Iz6/rlmrRyMEqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216340; c=relaxed/simple;
	bh=jpVkQG4ut9qf/pljgv0GIyKYTYR+HbX906dK5JPbMGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXaByZThJefM+pSWg7eA39h+fA7MooGRnauL0z/QVsmz5LwR3mOkq78nk5xYsW/VfmpI7c5OIiV7ZJWp96CBi2z8C6M3vHLnQWlE3qmIKVVAfijnGL2bmgPIBRjBJeDN6UKkURp8UqveWb8BRfG1547KXO3l+NL1HHKIj5A2IjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=IohL/7cH; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X412GLjVjNgho4d5BU2d+RZdrHHdZR4eFJmgPaiIEUM=; b=IohL/7cHd6PBHWtvYAg8G8g2Z4
	dandx4NF3wie961zgDH7zBPPol2b3nSNRVE9FZijFqx7ChLAJ/gNe57kL4tlrfgLLDEBg/D1Q6KDl
	sEUrS8nAw2oqW15U2/OrTXssRcTG5ICUHgu69+IfwRnFLKNqEUdYKCVIungVWb8dk31T+T6yA6XwG
	Wgb8azFG13W1asAMyQoiCU/IzWqLilF8sfHWsxzMeX6iHLxZWzkCqIYXC9uBMVVErqUNuoari40SS
	ybZa69aEktxNAF2dA50uzPt867fTHJbEvFv9gpT6tMiyxbQyMBeDVM045FVQ0+HjPqN10kQ4ECBuD
	LacpYQig==;
Received: from [89.212.21.243] (port=47386 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tIOk7-00BGOq-0Y;
	Tue, 03 Dec 2024 09:58:50 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 0/3] SN65DSI83/4 lvds_vod_swing properties
Date: Tue,  3 Dec 2024 09:58:19 +0100
Message-Id: <20241203085822.2475138-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi all,

this is a v2, which is quite different than the v1. The LVDS differential
voltage swing is now specified as arrays of min, max in microvolts. Two
arrays, one for data-lanes and one for clock-lane can be specified.
Additionally, because LVDS voltage swing depends on near-end termination
this can now also be specified with separate property.

Driver goes through the tables, taken from datasheet [1] and selects the
appropriate configuration. If appropriate configuration can not be found
the probe fails. If these properties are not defined default values are
used as before.

v1 is at: https://lore.kernel.org/all/20241127103031.1007893-1-andrej.picej@norik.com/
v2 changes are described in corresponding patches.

[1] https://www.ti.com/lit/ds/symlink/sn65dsi83.pdf?ts=1732738773429&ref_url=https%253A%252F%252Fwww.mouser.co.uk%252F

Best regards,
Andrej

Andrej Picej (3):
  dt-bindings: drm/bridge: ti-sn65dsi83: Add properties for
    ti,lvds-vod-swing
  drm/bridge: ti-sn65dsi83: Add ti,lvds-vod-swing optional properties
  arm64: dts: imx8mm-phyboard-polis-peb-av-10: Set lvds-vod-swing

 .../bindings/display/bridge/ti,sn65dsi83.yaml |  36 ++++-
 .../imx8mm-phyboard-polis-peb-av-10.dtso      |   2 +
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 144 +++++++++++++++++-
 3 files changed, 176 insertions(+), 6 deletions(-)

-- 
2.34.1


