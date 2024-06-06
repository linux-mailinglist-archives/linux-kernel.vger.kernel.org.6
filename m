Return-Path: <linux-kernel+bounces-203781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F9A8FE06F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EA7285BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503713BC3B;
	Thu,  6 Jun 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="c4eC9uS5"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC113C675;
	Thu,  6 Jun 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660870; cv=none; b=tnUOJyazHEduDm6SRZFuBmIoCAboy4V6dovhmMqlmjgc/Hp/umScF5CHXwfeNa0uc0kI47zvrG3v9Kqth2qFsvZERyAWgRUFitRWHqQ2Sqpoj2ZAdNIeEYTScXJ2EQy++iQEqih51EVGRTfF4aWns+Uqjrt4vWwNj1lFJonvyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660870; c=relaxed/simple;
	bh=p1FDlWXoVPCJ7MNHGNHriCykJy7aRX1Tu7g5xwnDktw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fffJZBCuh1eHStNVtGbUgf1j8TICDwMY2H576Xtybg/Mgz/mz3ZiuW2VhqTxOtry1BeTDY+c5csc7EFP9fwzPGXE1n2ne5Fj2tyqBslMz66BrszSefpVsJG+YJtaGR9d/RSdhjKuWqzRUhqnI1mPFh8GJ24O/bbV52/RWvUU3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=c4eC9uS5; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rWI5m1U8WZONuvT7buWmPuUYX+NAa5bK0qV0IQb8Ies=; b=c4eC9uS5iXgp7XbHutJh3p/q8M
	oMep5sMobTnQ2ROT+H9j8UdNHXW1zBA/YxrTt87bgZcpGU7Vq8Evu5Uz7PKnALw5owAza/cCIOITg
	i3HwJyZDrEKACGvydUeYN6Zbnxt8frQ18E1VWDlbs257mMh5Vj5eVW0KG1Z18MolrR4YMgReToAzd
	PR6/3FP6BCuTO7OjWZCW1jQD3meZfaGBsoJkaCDSaG0ployY+J9rVBPBwdo/5xmj2a+p2xBHuAJbh
	aoVfo9goEWIu2a22JPWlMP5ytCM4NcXLgmQVLFVU6x3T9v7Ma+pvNrkFBRYVaNYq6YyWPDXH9BZPm
	X/2wI8vw==;
Received: from [89.212.21.243] (port=51044 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF83W-00BWkF-3D;
	Thu, 06 Jun 2024 10:01:06 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH v2 2/3] dt-bindings: display: simple: Add PrimeView PM070WL4 panel
Date: Thu,  6 Jun 2024 10:01:03 +0200
Message-Id: <20240606080104.3663355-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606080104.3663355-1-primoz.fiser@norik.com>
References: <20240606080104.3663355-1-primoz.fiser@norik.com>
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
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add PrimeView PM070WL4 7.0" 800x480 TFT LCD panel compatible string.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- sort alphabetically 

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a272..4dedcfe8b5a3 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -280,6 +280,8 @@ properties:
       - powertip,ph128800t006-zhc01
         # POWERTIP PH800480T013-IDF2 7.0" WVGA TFT LCD panel
       - powertip,ph800480t013-idf02
+        # PrimeView PM070WL4 7.0" 800x480 TFT LCD panel
+      - primeview,pm070wl4
         # QiaoDian XianShi Corporation 4"3 TFT LCD panel
       - qiaodian,qd43003c0-40
         # Shenzhen QiShenglong Industrialist Co., Ltd. Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel
-- 
2.25.1


