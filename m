Return-Path: <linux-kernel+bounces-423322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08E9DA5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2686AB2794D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28B1991D8;
	Wed, 27 Nov 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="KFqokzSy"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C71990B7;
	Wed, 27 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703473; cv=none; b=GrYKvn3L12X47XyBeo9ImejUVKNMW9M7OfdP6aJJ/uJSi1hvCMvfc/8ezbDa2h3sdoZvdmCqWs/jECrnLwhBGJu++cHNYuB34FH1oVRs3XXrutyw5XrlakMDNKWH0JTgnaXfLWmXLzxtoWTM3gldSxe2OjLh0Q/2DVoA5cws1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703473; c=relaxed/simple;
	bh=QjrSngw00Yk1E3PWCsXuMHzd4AyrcaxVrlw4Em+rEzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRmOZ1a5Gf+qpjsz95iI2SpYK2/a3EmJO7OscLiQ/JhadtKZavGVVtHoWQg9/TWogajDvISBGQCxNsw1B6hV8/OFf47BEKOm9ta32IsGVAWtzf7Pvxi4XgoBlCjLXleCd5M4ZeLGEz7rzOGTrZotQGkNg7UG1Kg9ApgCHjrh0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=KFqokzSy; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GlNV48MQ4G7U/3atikXtOonokPebd5St2HI4ngxfLBg=; b=KFqokzSyu7Wye4UwKlHRqnQi9i
	6ZC8cOeLuFtStrRftgOX36FHc1iImeukZen/FfW7RBwdZh3Feiy/AhX16Ka5oZG+H9EkJvy7pq2HD
	WbVBbLQ9dzwID4YX0E8zxySjBas/gMQO6H3YB2dVGoixXvA0qSDf9rKLGZplQOaOt4hogfMNXasCm
	3VR57T1TyTsGz86aBnQeCrke1t3laTmFOT7oL7IDCdEUpKuBk7P1jkpaNqBetVGaGIiaaS/G2KCWS
	s0xOCZeT6cRjDUHbEFnkwMWeAXAAowDFmeBH3jPYkQIpiyMSyatNZ0w+c80HIlqECgRryAlkcehsP
	PrShsijw==;
Received: from [89.212.21.243] (port=49750 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tGFK3-007Rx6-1d;
	Wed, 27 Nov 2024 11:31:03 +0100
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] sn65dsi83: Add LVDS_VCOM option in device-tree
Date: Wed, 27 Nov 2024 11:30:28 +0100
Message-Id: <20241127103031.1007893-1-andrej.picej@norik.com>
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

This patch series depends on the patch
"[PATCH 11/15] arm64: dts: imx8mm-phyboard-polis: Add support for PEB-AV-10"
(https://lore.kernel.org/linux-arm-kernel/20241125081814.397352-12-andrej.picej@norik.com/)
which is currently under review. Please apply the dependent series first before
applying this one.

Best regards,
Andrej

Andrej Picej (1):
  arm64: dts: imx8mm-phyboard-polis-peb-av-10: Set custom lvds_vcom

Janine Hagemann (2):
  dt-bindings: drm/bridge: ti-sn65dsi83: Add optional property
    ti,lvds-vcom
  drm/bridge: ti-sn65dsi83: Add ti,lvds-vcom as optional property

 .../bindings/display/bridge/ti,sn65dsi83.yaml      | 14 +++++++++++++-
 .../freescale/imx8mm-phyboard-polis-peb-av-10.dtso |  1 +
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              | 10 +++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.34.1


