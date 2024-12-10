Return-Path: <linux-kernel+bounces-439167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06C9EABD1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C012C1882B56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4542327A0;
	Tue, 10 Dec 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="M4tPxCH8"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D53232783;
	Tue, 10 Dec 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822474; cv=none; b=l3pP10BuvieztXv53+arLmr/R7ilJI9jlix62Nu1YO/CHJdauAKbNlzW2MXUX7ABW6cz+/7SZihVutlY4ccb6EjkkrjcTBu37Wl/i4viFcDJvc/W1kWNnK/uQvG0gBthOftT7iB2VwHuWJjkASeqc69JsMDnO9ihX5ZhubEwoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822474; c=relaxed/simple;
	bh=LAsNn7Nx8ist8QPjVQjeHAkHug2v5S6N7m7OAlkjahg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMHznpHIg9+A94smtR/FfW/WGKQ/ruXQD3IjpqUlLmGXCn/LVu0uaIePzZWCo1VM7YIj0o1VjTiahJ44uODJZGhNgRBdNjAdtHP3MGRQElmWD2u0Q2t3srL6af7xp1PNdxEbuHzTRQJf+rzrVF6Behs5ohGEMx3KjvZo9xRnkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=M4tPxCH8; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=P0pfvqLWYJo81wiydC4h9petXJVrnjiHjNHuHLyT144=; b=M4tPxCH8u5cj+29W9XsEhgZNZl
	67YUe4R6OB+e7ooQGA2PftBeO7uKHma/v8ljy5SKZ0mh5iJlE7Vd3tWqySF3LyCy4YNE4P0vCsOcK
	UjJpCKrQTNCLYG8Z2ex1OQrj6jGIjPn5u6HBOHFLsT20EyIPzkUmGXVc3k8gfGqlVdZJ977La3euk
	2j3+/A4eFWa+31RiuZINdxwiH6rKHaQgqOHmL0JCgELrEjeSDoZWWAgx4dTtOIG8JuCzvlQ0AzvjR
	HoLBHf4OQkhtV7o1awVC9yaZGTwHFsZSWaombrGre7iktK7R1wJOhNeAA/hN//G6viRA8HhLj6uz0
	EvKnr4AQ==;
Received: from [89.212.21.243] (port=59230 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tKwQZ-001jvW-0d;
	Tue, 10 Dec 2024 10:21:11 +0100
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
Subject: [PATCH v5 3/3] arm64: dts: imx8mm-phyboard-polis-peb-av-10: Set lvds-vod-swing
Date: Tue, 10 Dec 2024 10:19:01 +0100
Message-Id: <20241210091901.83028-4-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210091901.83028-1-andrej.picej@norik.com>
References: <20241210091901.83028-1-andrej.picej@norik.com>
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

Set custom differential output voltage for LVDS, to fulfill requirements
of the connected display. LVDS differential voltage for data-lanes and
clock output has to be between 200 mV and 600 mV.
Driver sets 200 Ohm near-end termination by default.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v5:
- no change
Changes in v4:
- no change
Changes in v3:
- no change
Changes in v2:
- use new properties from previous patches
---
 .../boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
index a9de42cf14be..8bf9cc553bea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
@@ -186,6 +186,8 @@ port@2 {
 			reg = <2>;
 			bridge_out: endpoint {
 				remote-endpoint = <&panel_in>;
+				ti,lvds-vod-swing-clock-microvolt = <200000 600000>;
+				ti,lvds-vod-swing-data-microvolt = <200000 600000>;
 			};
 		};
 	};
-- 
2.34.1


