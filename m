Return-Path: <linux-kernel+bounces-171268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366418BE202
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B96B23519
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF515B96B;
	Tue,  7 May 2024 12:23:12 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFD15CD63
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084592; cv=none; b=LH7XBCZnp9C/q5kyh75Ji499Ayw2sZEikJQBhUmb9PXAmmPMrA2sCx+xoQKPB1MKarjXTD/R8Ic5TMrILYXyfABca3jlGrtwlbL6HpWICPpoDQqo364Gn4nneE9TRMwXfJfz7HIwu9OQx6auVyLvemmLySpGFxjjXB2eDHDA5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084592; c=relaxed/simple;
	bh=YmrVIs9HB41SZ4AUA4rNUoZtMI7Gwe0P4MbrUBibe38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ay8TrjxMbZB003tJgnMAp/sofilmOCnyyPzzDKw0+cjsJ9WUiOHXeJdMDQojr7fECtnDvwLQQ6/a8R9UEgPCOYnvm/0tHibqnJiBhQLv14tfRhsPw8dDr6HBGFmWDiHoJ7HT3Cq3kanU5L364s/2axiTly4zMYIT7jq2O9W0HlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s4JqZ-0006h6-CK; Tue, 07 May 2024 14:23:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/3] nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
Date: Tue,  7 May 2024 14:22:54 +0200
Message-Id: <20240507122256.3765362-2-heiko@sntech.de>
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

The Rockchip OTP describes its layout via devicetree subnodes,
so set the appropriate property.

Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/nvmem/rockchip-otp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index cb9aa5428350a..7107d68a2f8c7 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -255,6 +255,7 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 static struct nvmem_config otp_config = {
 	.name = "rockchip-otp",
 	.owner = THIS_MODULE,
+	.add_legacy_fixed_of_cells = true,
 	.read_only = true,
 	.stride = 1,
 	.word_size = 1,
-- 
2.39.2


