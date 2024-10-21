Return-Path: <linux-kernel+bounces-374857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65B9A7128
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5EB1C229A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9D1F4FD8;
	Mon, 21 Oct 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TicH7zoH"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA691EF090;
	Mon, 21 Oct 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532234; cv=none; b=k2N6ILNEmdWfEjXNrJo2Tals1C55+pdcjGXI2jRS+0vPvSsXu/pZEN5wil2Et7ucvDw9qlfsvthg6n6L/aGmpskPmLtcsJv9FvrwqqMbY7+TWlNkHC2Y2ITuKiGk4ZS33P3CXDaxrjZEkI9M69204r9PwitZIv6uOYa2OYnSHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532234; c=relaxed/simple;
	bh=j2WxG1gi9sX9Q9XHaunLYPDXuZFPxo2eTPeWaKuZNcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VENYDb/M/o2sVRfFxyW34IcB1MOwy93NvtR3WiKZ3wTbOuPIxkZCUFwF8VI7fxI/Lv0atHyRY4imLFFNoO28WRpyLV9Vm7/lAVFlJ8av8uowuWunfwx/u880BEuMZ6vovFjIlO/MSSHQO0vqHQBMwZkOVdpJFd2UXi7kiBhW/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=TicH7zoH; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A1dLRRt6Gpz+f3YNGF2cRhz0EDeBb4t+Te4s+RjcUeE=; b=TicH7zoHSO/zBerogX1gayWkSf
	88X/+mHp2gw4uyWRe95YxVe53C5/g2Jy2HNGLDLTA6g0miIl4F1gxdBVx+Be5bIIuYdoiq4K5BtSN
	MqYE/oWlWjm2WIhmbUUMQtTS+w60MTUlFILt06iwtb7kZGgRk+ecgj2Y4niLjoN+jEg9Ekr/eYZjC
	0hCY1cuBENypXwqgfKXLefgu0qsbKFQVzm0H2n7tOzCPUgJ8sDzCsarqeQ1ZMuDzCsS3xRyjPx6af
	22I2cM0a8cJrSu+qH0qOm0TlP+zTPEQiZLckz7c13XGIDF13ZuH3n9lCTnrrxW0yIO2Q+ZXT/yH+D
	HWjPJqvw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E
Date: Mon, 21 Oct 2024 19:36:31 +0200
Message-Id: <20241021173631.299143-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241021173631.299143-1-andreas@kemnade.info>
References: <20241021173631.299143-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable drivers used on Kobo Clara 2E

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 333ef55476a30..0beecdde55f58 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -68,6 +68,7 @@ CONFIG_BT=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_NXPUART=m
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=y
@@ -253,6 +254,7 @@ CONFIG_MFD_ROHM_BD71828=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_BD71815=y
+CONFIG_REGULATOR_BD71828=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
 CONFIG_REGULATOR_DA9063=y
-- 
2.39.5


