Return-Path: <linux-kernel+bounces-243487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9F9296CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248DD28272A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A38814;
	Sun,  7 Jul 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UG1BaYS5"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA045AD24
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720333432; cv=none; b=kvsi6mu2SVXE7K0lPvDZuctBdUQzqw5QL1I4X/yH4c5Sjz0A6b9kUQdsY5R0HL3CfoEjnjLUWUqIsskLBc3CAFa3HB08kASfyZkIYYihjbF2OPDdrcOLUTP+cMudvsQsM6nGIo7440Ht4qiDxC1CkgUZe4NFj/vJaNicXfieQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720333432; c=relaxed/simple;
	bh=Kr8q7jgtvxXVl4D8u942YnL8udJewM780MCOxyFlPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQsUWAOZxhL5bU0deLNsktXMHbx0WxRoV1d4llinQ3zPu24DaO/L8GSlgD19hLzVAOn5Ov+qwgQp/CFE+Ca+40gt8iYvpmfDwM7OTKfQNnfB93Yariasr5JLb+OrqE+9iylt7ifEpU9hVVjYord8mT8r86K4kt5WTIByhwN2rqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UG1BaYS5; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id QKkEsyOxChEtDQKkWs8JLE; Sun, 07 Jul 2024 07:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720331269;
	bh=Ghi6/9KK5dnA4d7xrwkCyOhDZvJBSxCQgYi3tZ7zCuA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UG1BaYS5p50YBPSwi/Swqw/Ei+LajcK5WrI3tsOSriwLjEBS4TtTB64qkeuRQBvZq
	 pqg4k0guhhYIzkmJIY7VzCHzOIEePsz5qPbDzkI0b16m97fmLj1bl7aJNlAXQGmvil
	 BMwQ63yIMqJ9ogHWOuan2tiWMhtDNBLu/hycRjVlz7vrhDsF3cYA34ROnc4ycw6YcK
	 TfgO3c9uVxNoXtvCOZnv8DuTsTjbdTivBTLQMNItDjjeBNB5Csa4IIMt2CclcgX6nt
	 aIgrdKvDO690XhgaYAN0pZgFZzVcaR+8kYKzyHVHuVfVZGEN/UF/muwhDHkh+tyzK2
	 IERxLON+14o9A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jul 2024 07:47:49 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fchiby@baylibre.com,
	fparent@baylibre.com,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/3] soc: mediatek: pwrap: Constify struct pmic_wrapper_type
Date: Sun,  7 Jul 2024 07:47:20 +0200
Message-ID: <5b4b60c5dfd6d8fe893b05cfc96c0e2d67705463.1720331018.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct pmic_wrapper_type' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  45336	   8724	     16	  54076	   d33c	drivers/soc/mediatek/mtk-pmic-wrap.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  45528	   8532	     16	  54076	   d33c	drivers/soc/mediatek/mtk-pmic-wrap.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Compile tested-only

Changes in v2:
   - Add R-b

v1: https://lore.kernel.org/all/ee3160978ac6564663d044815f24cf79e2e0744e.1719652155.git.christophe.jaillet@wanadoo.fr/
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index efd9cae212dc..0da0cdec5050 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2397,7 +2397,7 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
 	.init_soc_specific = pwrap_mt8183_init_soc_specific,
 };
 
-static struct pmic_wrapper_type pwrap_mt8195 = {
+static const struct pmic_wrapper_type pwrap_mt8195 = {
 	.regs = mt8195_regs,
 	.type = PWRAP_MT8195,
 	.arb_en_all = 0x777f, /* NEED CONFIRM */
@@ -2423,7 +2423,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
 	.init_soc_specific = NULL,
 };
 
-static struct pmic_wrapper_type pwrap_mt8516 = {
+static const struct pmic_wrapper_type pwrap_mt8516 = {
 	.regs = mt8516_regs,
 	.type = PWRAP_MT8516,
 	.arb_en_all = 0xff,
@@ -2435,7 +2435,7 @@ static struct pmic_wrapper_type pwrap_mt8516 = {
 	.init_soc_specific = NULL,
 };
 
-static struct pmic_wrapper_type pwrap_mt8186 = {
+static const struct pmic_wrapper_type pwrap_mt8186 = {
 	.regs = mt8186_regs,
 	.type = PWRAP_MT8186,
 	.arb_en_all = 0xfb27f,
-- 
2.45.2


