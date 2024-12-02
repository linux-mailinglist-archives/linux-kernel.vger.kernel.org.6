Return-Path: <linux-kernel+bounces-427001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D49DFB15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26647281CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107981FA160;
	Mon,  2 Dec 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="U3mHkCle"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0C1F9F5F;
	Mon,  2 Dec 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124087; cv=none; b=kzSIZlq4h6CHa/WzkhFnzaa2ppkam6jSusjqFkNgSOq0sb20UT8eg+9jsHL57WUWsJD+wFG8plklMOTb4trlrpfxKQyffUfhLr92fTSmuFVkioMcGLcH4xj3VXmuO9GUPjU7Q6giNvlgMT1YfyZTTm3JkvAEke9ZTW+QLW4S9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124087; c=relaxed/simple;
	bh=rsUOsnZzL/cPTFN+NTTRqYWitRuBfPOdYQTVqz6WMqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZuUblBDf0ys/+ZCRtYbBZ2TZdyOtneugEZEpKqYhp68l9S/OReP1Sw5XNeCujVirfEDxkt27YgNS1HAGqH0GIKT6S7oYCyzeIbRDUsqR9cfAGDwG8H+Stx3J/s0Ibk+shBY85Vg9rzhCdWo9mpFrzayo7l9iHfDpqS/ugjMxjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=U3mHkCle; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Rwea67uy2jIokoFQFq/C5FAz7zmhPEtMvXbqK3IJZg0=; b=U3mHkCleMFRSq3Le45APSeNpcX
	+/gGAmE0DNAKr+/CMhDgllW/+nHTzQ3HgYFcow1xf0pWZavBdsJaPS5aYSIIy3e3Wi0o9DvD9fTNf
	JpEWgE5lZ7D1Lvsf7W2bdnb0iZ79t2U7fPYSopTA1jX5pvKarlnULQC/1b/zt7/JTgc92HoFAHuxg
	QMfD1uCfXwKG2psuCKxZtZAYfXR+n2RG5o1rHb/4epYhCC+hky2xU9M2RaYFF3qgNSLWq5AcP4uWP
	lZRkFkY5nuhA9RpFaQ1/qxq/zsUMMHEt/lGtdHPXRWWlvHoblOJb6dBvhPOpWLGBtqKuTJSrvgv76
	g7sNCiGQ==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0k5-007Bva-0N;
	Mon, 02 Dec 2024 08:21:13 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 04/15] arm64: dts: imx8mm-phycore-som: Assign regulator for dsi to lvds bridge
Date: Mon,  2 Dec 2024 08:20:41 +0100
Message-Id: <20241202072052.2195283-5-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
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

From: Yashwanth Varakala <y.varakala@phytec.de>

Add a missing voltage regulator of 1.8v to the sn65dsi83
(dsi_lvds bridge) node. Due to the absence of this regulator, a fallback
dummy regulator is used and that triggers a warning message from the
kernel. Assigning the appropriate regulator avoids the warning.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 8de5a46512b0..7e859c65317a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -286,6 +286,7 @@ sn65dsi83: bridge@2d {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sn65dsi83>;
 		reg = <0x2d>;
+		vcc-supply = <&reg_vdd_1v8>;
 		status = "disabled";
 	};
 
-- 
2.34.1


