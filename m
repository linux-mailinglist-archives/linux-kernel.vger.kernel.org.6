Return-Path: <linux-kernel+bounces-447035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B89F2C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB071665E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390F201006;
	Mon, 16 Dec 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="YfRN386t"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B920010B;
	Mon, 16 Dec 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339309; cv=none; b=jbIdupYQLVLpCGWYSUlJt+ia7l5HgCdQaljx4sDAHi0Eg6NO8AJLM3bKI+c4FrGkfzeKyQ736dcJxTaGj7bgHzPvpVGYIjOeCeQOsgGzALMkIUoMS6DUpA9/LeAJjxWuAq503juDrJdDYRxrXdbSgHLdZWc0aCWoG/EYHQCSRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339309; c=relaxed/simple;
	bh=zVKeCIH1VGJhL+OhLeNbUxiWRqfIdDYSg5bqbcwnFG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+xSeByKirB94S5qe+lIGStubEBKQ1R/O208A96dLvdM2xu6CNrvh1/98wQim0ZtBfWgc1hrZJApZ+Hphcg7yfCKA+LTXlxY2Y3rqstp0vlcgdUoZYMaLn5gUtX+i1i6xYPG1S9FehzSaf6hyXi89FTVyuwxdrWqTIhmLbCWfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=YfRN386t; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oPHS+vG8QIPL7cOVz1Q//RMyZMwZXBy2d7Sjyi0gdrg=; b=YfRN386tBJPkmbobGcUmDGhHQ2
	pyZptxVKu0KtEqAdvfH9YH8Y3az9IGHviqpye1N+tpVejHRbtDF0PMVZ8LbznzUXBHChrGJQMbOj0
	P+ZfZUoV8I39EmC9h6nCDHwSg7An3k6557xml9qeZcTHSB9kbWAk/BDi1Lo3x5XYd+zPfrvPbjUkq
	ujgwy8Q/xYK0dXLQXsFzfTQGkO0FNEd7OIwrROHpjjiZy9aUfexpRKC/v+MAoF44Tqyy6ncOlc0Gj
	XSYNoJC8X8UBU+8pjTZks6XxoUXyC7I630rzipxaeUTabSfNYr+sIdJaYgmV/mUJd/4kebJQwkEHv
	rTmB+RGg==;
Received: from [89.212.21.243] (port=57844 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tN6sW-0053uC-2v;
	Mon, 16 Dec 2024 09:55:00 +0100
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
Subject: [PATCH v7 0/3] SN65DSI83/4 lvds_vod_swing properties
Date: Mon, 16 Dec 2024 09:54:07 +0100
Message-Id: <20241216085410.1968634-1-andrej.picej@norik.com>
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

The LVDS differential voltage swing can be specified as arrays of min, max
in microvolts. Two arrays, one for data-lanes and one for clock-lane can
be specified. Additionally, because LVDS voltage swing depends on near-end
termination this can now also be specified with separate property.

Driver goes through the tables, taken from datasheet [1] and selects the
appropriate configuration. If appropriate configuration can not be found
the probe fails. If these properties are not defined default values are
used as before.

This patch series depends on the patch
"[PATCH v2 11/15] arm64: dts: imx8mm-phyboard-polis: Add support for PEB-AV-10"
(https://lore.kernel.org/all/20241202072052.2195283-12-andrej.picej@norik.com/)
which is currently under review. Please apply the dependent series first before
applying this one.

v1 is at: https://lore.kernel.org/all/20241127103031.1007893-1-andrej.picej@norik.com/
v2 is at: https://lore.kernel.org/all/20241203085822.2475138-1-andrej.picej@norik.com/
v3 is at: https://lore.kernel.org/all/20241203110054.2506123-1-andrej.picej@norik.com/
v4 is at: https://lore.kernel.org/all/20241205134021.2592013-1-andrej.picej@norik.com/
v5 is at: https://lore.kernel.org/all/20241210091901.83028-1-andrej.picej@norik.com/
v6 is at: https://lore.kernel.org/all/20241212121712.214639-1-andrej.picej@norik.com/

[1] https://www.ti.com/lit/ds/symlink/sn65dsi83.pdf?ts=1732738773429&ref_url=https%253A%252F%252Fwww.mouser.co.uk%252F

Best regards,
Andrej

Andrej Picej (3):
  dt-bindings: drm/bridge: ti-sn65dsi83: Add properties for
    ti,lvds-vod-swing
  drm/bridge: ti-sn65dsi83: Add ti,lvds-vod-swing optional properties
  arm64: dts: imx8mm-phyboard-polis-peb-av-10: Set lvds-vod-swing

 .../bindings/display/bridge/ti,sn65dsi83.yaml |  34 +++-
 .../imx8mm-phyboard-polis-peb-av-10.dtso      |   2 +
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 145 +++++++++++++++++-
 3 files changed, 176 insertions(+), 5 deletions(-)

-- 
2.34.1


