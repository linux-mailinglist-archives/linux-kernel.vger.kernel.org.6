Return-Path: <linux-kernel+bounces-171266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503CB8BE200
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83394B275D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3315D5C9;
	Tue,  7 May 2024 12:23:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC4158A2D
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084589; cv=none; b=ViHAU7kLsPP22jPtEH2Jy0qD8yyc9JbtjqIfBfkJvZnGZxIpKDJQ62Y7nbCSPaOzbH/nobBKhokK5w2clTaV4zYY7fiE5xbolObjNClHT8NU6HwWakCWaI9hCW8VvYsfEuSf0jfhvjTcTJeC9k75WfQ11SdA1u1MflM0VRkb464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084589; c=relaxed/simple;
	bh=/tewlST2Ag3AZqZaR15gI8C1/pmeGOyOph5go6pPIeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Totbo+qP2brEGkpQbZC3P2p6NEy1dT4OI0vCAqpSlQU9SxpxOr1MkFESvHmWG482NITPAN2BWatcH1ZR9i/l85cLa2odCf33/plQbi3ilqnOhh8zuaAPNGN8a8EHd0SxyM8DE2GieGHt+IuYdyVu8k4JTvlwQU9LaF8Kd8J+PLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s4Jqa-0006h6-8J; Tue, 07 May 2024 14:23:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 3/3] nvmem: rockchip-efuse: set type to OTP
Date: Tue,  7 May 2024 14:22:56 +0200
Message-Id: <20240507122256.3765362-4-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507122256.3765362-1-heiko@sntech.de>
References: <20240507122256.3765362-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

This device currently reports an "Unknown" type in sysfs.
Since it is an eFuse hardware device, set its type to OTP.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/nvmem/rockchip-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 2b40978ddb18c..013e67136f3b9 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -206,6 +206,7 @@ static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 static struct nvmem_config econfig = {
 	.name = "rockchip-efuse",
 	.add_legacy_fixed_of_cells = true,
+	.type = NVMEM_TYPE_OTP,
 	.stride = 1,
 	.word_size = 1,
 	.read_only = true,
-- 
2.39.2


