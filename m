Return-Path: <linux-kernel+bounces-423325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC69DA5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076A7B288C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F719C574;
	Wed, 27 Nov 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="ApVr8M+K"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F140199381;
	Wed, 27 Nov 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703477; cv=none; b=VnQjhKif3ticAAXyfWskMlHl+98nt+RjCAfhzWNePenu1uP15IO9Eo+IpRnNEIKYBNUZ4GZo6nXNuIFa+Qe4kbxKSd/cWIpGfVJVJJ6STucA0AnEQ1zGMSEoWxgRRz+gkS6rXOpuR1AdIK17Qc+kK6nsQ5VlhoC3kGkmOOIlaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703477; c=relaxed/simple;
	bh=F45LVCLx9Mq6oGWGV9My6tx+JnMEqfqbg6TQvNuNQtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVWTeZazepkx+v7yzyLBVpG+x4neBjwoqJV94aF/njNuouO2FxBiUKUBEw/R7wc8ZgykgRvx6MYqPwuO9yI5tApnvEsFNbkpDNq8Ix5WhEJ5MWdbFYnjUmAlWHHOmlsA5ShM4M48SKXXeMrbiFH8sDbiJ7AlOLkhASJ4eC4AZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=ApVr8M+K; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rpRTZD3rQ6fcXSI3x3w5V3GlJGBpXq/aq88YWpZoftc=; b=ApVr8M+KE8vU+gn1q1aC7Yityx
	sc2dSDSVljqDpPiLxEuKKjC56nYdwV+6qQEr77t98vVZDzEMonvqIViilqBtQ7SPHE+R5qA/4aGn1
	FCz2gvHkJPXDbhhz3O1mjgBZVKTByGb/Lsyk5vheI/OZlMFxMP2slbvwgAG2icK7io4ZmQJKVjCt2
	9jpkHkEhbYTkueW9W0aZLCuZQFbXaHtm1EJds5gVT+66khGh8PLc/BHaG79e0LcCuVwQy3wFzMM+s
	raW1Kme0Yw+IKP3nCRg5VMcmOxsncUJH3kg2J41NtT0VZKFztl3VqZMP9e1OW2794Y/opJTmNk+cT
	OuW3tWDw==;
Received: from [89.212.21.243] (port=49750 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tGFK9-007Rx6-0K;
	Wed, 27 Nov 2024 11:31:08 +0100
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
Subject: [PATCH 3/3] arm64: dts: imx8mm-phyboard-polis-peb-av-10: Set custom lvds_vcom
Date: Wed, 27 Nov 2024 11:30:31 +0100
Message-Id: <20241127103031.1007893-4-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127103031.1007893-1-andrej.picej@norik.com>
References: <20241127103031.1007893-1-andrej.picej@norik.com>
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
of the connected display. LVDS diferential voltage for data-lanes and
clock output has to be between 200 mV and 600 mV.
Driver sets 200 Ohm near-end termination by default and since
LVDS_VCOM_CHA_LVDS_VOD_SWING (0x19) [3:2] sets both data-lane and clock
output voltage we have to set the register to the value of 0x0C (0b11 <<
2):
- Steady-state differential output voltage for LVDS data-lanes:
  min: 300 mV, typ: 402 mV, max: 511 mV
- Steady-state differential output voltage for LVDS clock lane:
  min: 234 mV, typ: 314 mV, max: 399 mV

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 .../boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
index a9de42cf14be..709b555ca753 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-av-10.dtso
@@ -179,6 +179,7 @@ port@0 {
 			bridge_in: endpoint {
 				remote-endpoint = <&dsi_out>;
 				data-lanes = <1 2 3 4>;
+				ti,lvds-vcom = <0x0C>;
 			};
 		};
 
-- 
2.34.1


