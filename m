Return-Path: <linux-kernel+bounces-334073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40A97D253
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBC71C2296C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC37DA6C;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7szP3+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA162AEF5;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=Tt4yqakVjkO4VgD4pmNy69L2TRcN5sJ0jJuZ1Ug6F/hC9s5mwUXrSSHRywa2I2NI5mYdNdZ7JcWzDuQZN5zOHF9EXSPFjX0IulbhLiDWjEdnUSpstPrLR8cfcA5G1Q7NnrT+B4oqsIcRXOCvGS29Ll1bbNFf/3Rz+bCzTNDVhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=zYrG4JOdof5Kb4KbKr9UqFtgnrrQGTE+AbTafTRVifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oeliz8XlBH4B80z6/NLhWub/1VfE3yiKB2sWyGQFJbX2y+fZuN8NoNsSdywOQb8NonZkH250dTm76o5woz5SNrchxec1aH+ZxzAfZhNqJd0qoHnm8Nc1ujuNps07HCeqJTkNefg7QwNDgPG6qN3S+NdmqKwL2th83s+GngUrRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7szP3+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4805C4CECD;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820175;
	bh=zYrG4JOdof5Kb4KbKr9UqFtgnrrQGTE+AbTafTRVifY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m7szP3+fwUyzikmJZ2LdFSgLmJZ3olD/2ioaIno0bkiPeKe+WUfWfFsiRGBfarO5g
	 2m+2sgPGZuU9E+0fVUdCdNyRSMJXXp/WWS5+yTyw+DOWvIXvEqn3PR9ZQyrR8aKBz2
	 z5jOE+rqhL86qsUaUr4cvBCo/HwULe1bnqpnGWA3VI0Ds2hv5vNAmpH/KlAiCH5TGu
	 PxZCpp+B+6OyJPynndxV41VuK7yXGt0P3zP9VRwnykSrYwQkRB3lL73OIeZYAnDTzv
	 KtQAVQT5Ah358eGuYn6t7mUPXI9ohR40L6Vk55BC1TdXeFN2hDECqYMSz9xLkQMy9d
	 lZNWTMvDRFesg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6FCCF58DD;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:16:11 +0800
Subject: [PATCH 1/6] clk: meson: mpll: Delete a meaningless spinlock from
 the MPLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-mpll_spinlock-v1-1-5249a9a7e2b7@amlogic.com>
References: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
In-Reply-To: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820173; l=1612;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=BZXhg4CTNZVT2pfn9n5YtAFzBvDkKei7u08ePhTMQ5Y=;
 b=c5RWy2so9ARwlG7HP5tJMif6Xs8tPQe83hHw4BrCVOzlgZUKN4PVqezSrnxDy0IjHki3OrbUv
 9rUeCaK7jI7CMadjwdGnhqnZsyzNB6BuZ9yonfem7thhHL6aJo+BlDv
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The existing locking mechanism of CCF can effectively avoid concurrent
register access. struct meson_clk_mpll_data has no meaning in defining
a spinlock repeatedly.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-mpll.c | 11 -----------
 drivers/clk/meson/clk-mpll.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index f639d56f0fd3..aa9abd06ae65 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -112,26 +112,15 @@ static int mpll_set_rate(struct clk_hw *hw,
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
 	unsigned int sdm, n2;
-	unsigned long flags = 0;
 
 	params_from_rate(rate, parent_rate, &sdm, &n2, mpll->flags);
 
-	if (mpll->lock)
-		spin_lock_irqsave(mpll->lock, flags);
-	else
-		__acquire(mpll->lock);
-
 	/* Set the fractional part */
 	meson_parm_write(clk->map, &mpll->sdm, sdm);
 
 	/* Set the integer divider part */
 	meson_parm_write(clk->map, &mpll->n2, n2);
 
-	if (mpll->lock)
-		spin_unlock_irqrestore(mpll->lock, flags);
-	else
-		__release(mpll->lock);
-
 	return 0;
 }
 
diff --git a/drivers/clk/meson/clk-mpll.h b/drivers/clk/meson/clk-mpll.h
index a991d568c43a..4ffd3aeef799 100644
--- a/drivers/clk/meson/clk-mpll.h
+++ b/drivers/clk/meson/clk-mpll.h
@@ -20,7 +20,6 @@ struct meson_clk_mpll_data {
 	struct parm misc;
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
-	spinlock_t *lock;
 	u8 flags;
 };
 

-- 
2.42.0



