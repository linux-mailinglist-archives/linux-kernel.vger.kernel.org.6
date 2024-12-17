Return-Path: <linux-kernel+bounces-449868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF39F5722
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E27A1891EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFB11F9ED9;
	Tue, 17 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BmBKZbhs"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D51F8ADB;
	Tue, 17 Dec 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464691; cv=none; b=pNZttjVg39LANUp9NI2aLo2W7ibJIAOKBeLuxKFW1WW5Cs/R6Z6segEwNs6IPw/HWIfS6VVWgTb6YNgZer0oFeMziAH4Y7XsCLtDOPJvcX8ULlhDS+iedKx8MDpOjBTvcTaI404a1BH5nVG99zOu6wJrNsHZr7WKZJOSCgrgLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464691; c=relaxed/simple;
	bh=82v8W/aCfyKyNH4lLoqsF3249ZAUx/s7U0qVBPIAcBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juszMEGMsfFIDUO+aV6vGp55IV002rsLwlZcdhuDG4GRWHA3b8hK7BSv2t+2Hz80r5jqPHZnvtSf/WNBoGHAQurE3msdZ7oiD4Ps2P7Hb9Pppkd8F8S6bbjURHxGd6Gm2LHj+BTuovncjqUj3fEnzm8JWNrHXoP11LTGgm9cVcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BmBKZbhs; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B50FEC002817;
	Tue, 17 Dec 2024 11:44:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B50FEC002817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1734464688;
	bh=82v8W/aCfyKyNH4lLoqsF3249ZAUx/s7U0qVBPIAcBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmBKZbhs7Hl3w51VzWeyghKPj39aujguXxZFdaSBQNdp1pAG01bxK2MVl+aAIjrGp
	 ol/j48AB/7LvLGlfN8y2xDlgPM8ggXQPX/dziPSoLpzLcQalRU/1/i6roPtJWTaXbC
	 skWqjXImOwsaBMjkA4OL+VchCcjcTG4r33aIpSEk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6976A18041CAD2;
	Tue, 17 Dec 2024 11:44:48 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH 2/2] memory: brcmstb_memc: Match rev c.1.5 compatible string
Date: Tue, 17 Dec 2024 11:44:39 -0800
Message-ID: <20241217194439.929040-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217194439.929040-1-florian.fainelli@broadcom.com>
References: <20241217194439.929040-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the revision c.1.5 compatible string and apply the v2.1x register
layout such that we can properly control the Self Refresh Power Down
timeouts with those controller version(s).

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/memory/brcmstb_memc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index 4f17a93aa028..a2750142cef7 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -236,6 +236,10 @@ static const struct of_device_id brcmstb_memc_of_match[] = {
 		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.4",
 		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
 	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.5",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
 	/* default to the original offset */
 	{
 		.compatible = "brcm,brcmstb-memc-ddr",
-- 
2.43.0


