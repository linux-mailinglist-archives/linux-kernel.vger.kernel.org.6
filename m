Return-Path: <linux-kernel+bounces-171265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C88BE1FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F38B2736A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D310158A38;
	Tue,  7 May 2024 12:23:09 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0D158A31
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084589; cv=none; b=ltzIkNMyVunk+TCV9KeMUlsW3t+WWdjowZk1JTk+VgKc2FTkttWLS6NhEgUroFqGndq7LLIwK46ZU+qu9eAWHjvm4mq0wXi4DOjmjGNf3cmaOBH/W/jn0jyn4t9nJ31EphBvX2ccpnwEDz9QoWwehInSQULuysZBpNKtI1gru/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084589; c=relaxed/simple;
	bh=r3EKQBXM9BOBP2LuLkAi7otT04mJ0BbAFhnAp6q3MBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPesHNeM4iHEznOJHK2qfY/ha78DL1DPzE8QZOtjrr7ZjzsEzIv8WY8jXkKCZ7tOVKrATnfd/JBEDFDHnvF0LWZVu6yrNhYF+GI/iUN2Y9AcpEUiWj3+drX+1GiFK9tXfwJ7871RMtmskn9q1rtQNcGRzyNWD15PfmG8NLbzUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s4JqZ-0006h6-PV; Tue, 07 May 2024 14:23:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/3] nvmem: rockchip-otp: Set type to OTP
Date: Tue,  7 May 2024 14:22:55 +0200
Message-Id: <20240507122256.3765362-3-heiko@sntech.de>
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

The Rockchip OTP is obviously an OTP memory, so document this fact.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/nvmem/rockchip-otp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 7107d68a2f8c7..ebc3f0b24166b 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -256,6 +256,7 @@ static struct nvmem_config otp_config = {
 	.name = "rockchip-otp",
 	.owner = THIS_MODULE,
 	.add_legacy_fixed_of_cells = true,
+	.type = NVMEM_TYPE_OTP,
 	.read_only = true,
 	.stride = 1,
 	.word_size = 1,
-- 
2.39.2


