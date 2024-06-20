Return-Path: <linux-kernel+bounces-222414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58415910126
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96772853ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91371AAE0C;
	Thu, 20 Jun 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FQMd+sGa"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E411A4F2B;
	Thu, 20 Jun 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878089; cv=none; b=J0/wZRTvN+y37arVwASPVOpIBSmkBeajBTXnQJ7rAKtMX0F6EqioeHOe6doa4vOa16TLrDjfCKVgW7AtEfNvAdFnuwLh05mVRg8S5GqXvTVWM7mU6SnvKY5kMvlF5fG2uP7FRqcS8Ekx0FkVwFRUjLBESeTi+17mbcJ4PvJFhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878089; c=relaxed/simple;
	bh=uPSc/aFYOBicJU5ByMPn/EfmfsVERpR9NIo+Kp9Kuaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxrDoj9lifXH1sA9XD6hAqGKfTEZn7p1KciZ9XTzxnapA1Ly3Lh72MX42zbZoZbyC0OeiLUOsBfUYeexG1JRkVe9IZeD69ApB/bx5CpvHHpcBegApAwmE/WQiC2tSHIFsI8G/0mTJ2UTOQw8TXyGAsgKDdoVxBCwtM2vZNRShZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FQMd+sGa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878085;
	bh=uPSc/aFYOBicJU5ByMPn/EfmfsVERpR9NIo+Kp9Kuaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQMd+sGaS9mWBAyggmubXUNDCT5UwAkXnXEqZhteD8k10mWqw27ky2hY4eoJ6d0H3
	 X9n5Kj0sN4A2YFJywWr8RPm0r/GD5+7MJ06SxpTZc1Ndh+915udFvdVMCs+Iv6ZuQa
	 eEH5XWMa5yAyAVleCj9AvYcCZ56OEHWBavdbV6RD9/6CYSRlganxtXct8zQEJ14xLu
	 drQLdqQuDKIWh/hc3OKVXD8ecBvOV7TcGUbhlLw5jeaxGuPG2VjRPmM80VjPJGFv+a
	 rjvncXjkQj78TKTBlWYbuIAWoI5dEEty5Vks3T8H2XZod8vnYCQXce4vfbftDjSrdM
	 +bTAJ9m5QYj8g==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1DB2137821AA;
	Thu, 20 Jun 2024 10:08:05 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jassisinghbrar@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	houlong.wei@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/4] mailbox: mtk-cmdq: Stop requiring name for GCE clock
Date: Thu, 20 Jun 2024 12:07:47 +0200
Message-ID: <20240620100750.1075790-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
References: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Global Command Engine mailbox has only one clock hence
requiring clock-names is useless.

Get the first (and only) clock instead, without name checks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4aa394e91109..66dbc8e846d8 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -629,7 +629,7 @@ static int cmdq_probe(struct platform_device *pdev)
 		}
 	} else {
 		cmdq->clocks[alias_id].id = clk_name;
-		cmdq->clocks[alias_id].clk = devm_clk_get(&pdev->dev, clk_name);
+		cmdq->clocks[alias_id].clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(cmdq->clocks[alias_id].clk)) {
 			return dev_err_probe(dev, PTR_ERR(cmdq->clocks[alias_id].clk),
 					     "failed to get gce clk\n");
-- 
2.45.2


