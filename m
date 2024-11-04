Return-Path: <linux-kernel+bounces-395415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FC9BBDA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2E32827F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C71CBA04;
	Mon,  4 Nov 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAxJk0gP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AF1B5EBC;
	Mon,  4 Nov 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747102; cv=none; b=gbpe0ekQPLUIsCQR9pAn3t4oAVQfZ9S6Lz3KZjamStMiywqxzl7Isf3KDNk0cPGLDXgtlbqEISI/j8paGhb6fZE8RzMOH0N+HP2PPdHuYRYuJ3IX14jhfRyXUPSk+6uT7qMLqPIelDMOTY/h7SjyDxeH3Cawk7DEo+PGpsh2ARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747102; c=relaxed/simple;
	bh=IpevLm9zmMO/WRd+BeiK2wsuMbU3lla0NcYACvtD4YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjTVfb40nJBsphVDfX/pNsdQb9DdeUFU4B/b/T56t0skbUSVk2HKEkytdwpZ/dIY+wzDcri+d0djoaQnQftuxCgvBO0+PvoR8SK4wiknE9vwn3laTH8EUFGp2HJfYF56duIPIW5NW30YPqwhsWm+lj6Z1001eCdHjDf7QN4pXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAxJk0gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA04C4CECE;
	Mon,  4 Nov 2024 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747102;
	bh=IpevLm9zmMO/WRd+BeiK2wsuMbU3lla0NcYACvtD4YE=;
	h=From:To:Cc:Subject:Date:From;
	b=kAxJk0gPb0VUSWzcApxGGx8coNbK8gpwrnfLw3vl+JvRMGYNEwiAGt0MfbM+3mmoY
	 yE+zMLacNqVwyflLLp6H75oT2XZ39qeeUom0hFKO28o3YXe3r/60x/2eCMW5DAQZWm
	 1iwYew0JnXYxbZtBOX2c1skDFvEWcmbloQbKjitZhFWynICawctLz0LeFB//0Y5TSc
	 7f4oAufA3fxs8MOhuKC979iztCKooqZeQ7CAaFG8bvhECOAeco3Kg//Hx3meUhsJr6
	 aZQoIw9Autc9B4IPl8YsBq4DvLtHYKdhG/qY8i9hPDQ2lFoO0Qb0RqNdMFLPTe5ZAO
	 1Rlu1GTu0gsIA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:04:55 -0600
Message-ID: <20241104190455.272527-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
index 87e23d16ed0f..724b202863a8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
@@ -356,7 +356,7 @@ int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
 		const char *fw_name;
 
 		/* ext-osc32k was the only input clock in the old binding. */
-		fw_name = of_property_read_bool(dev->of_node, "clock-names")
+		fw_name = of_property_present(dev->of_node, "clock-names")
 			? "ext-osc32k" : NULL;
 		ext_osc32k_clk = devm_clk_get_optional(dev, fw_name);
 		if (IS_ERR(ext_osc32k_clk))
-- 
2.45.2


