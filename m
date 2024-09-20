Return-Path: <linux-kernel+bounces-334076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D0597D256
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80999B2247A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B307DA6E;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PetVLVQ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7F2BAEF;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=Na/bWi3jNVLkVVMa3pbrHngFkIbgyxlr9WMo1CDRDjVtpmaW8ysEVMM6YHdPUld5JtviTWGskZ3MMhIiBdBQahMfu8ZwpTccbqEtMHdOnMCfOiXljAbZp/AXAQp7JDBiytgyqgsguhDIetb2Jksoos65Bw9+aCnl1SWLEu69g0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=KGg+9yxlFddJLvy59fqrK62adIYW2fdEx4QtkoNDsrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTwy9tCF1OQkjSZsFttU0kUBQg9sgE/qwJI56blUs+1TzoqxQjIDdYNcumjgnLpWehpPf6Ub+7k9IiiXG7mtpkS8+HGXo6IQmkaQnOxfq6yZeKsxtvOAcYOWbNmSETf4PysDT0wkpAtGTF73w/a0ctnIZf5rIhY/bkc5HITFkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PetVLVQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D2AC4CED0;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820175;
	bh=KGg+9yxlFddJLvy59fqrK62adIYW2fdEx4QtkoNDsrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PetVLVQ+3aRmiyk7jD37i7VBES0LRNaEcx1+/3DbN288tLnLBJirx6WWfzlJEA/af
	 fMe66vfaM9Y2arpx2JcaLTgk2b6fGDhaX6WjzvhKvPGngb304Jw1shjJmdYMCMYtRW
	 b0BhtwSLXzNRc71Z7RvrjyfhETBf/QFTxUfJ/I5yxfka4px6v06GKb2BgySTuhE08I
	 rycCXPqCabVPfs9tpI452Mh/20wnZpJHsalMGHngMSYteeQFB8mZ7kLY9hlqwBxqiF
	 rZelzOs93zVCxygRwuVQ4tmiLeDwRVsu3mivCF64Tev/5XcY9am2jvGYhr4NKdMA9o
	 vpSqoUGS57zwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74ECCF58EA;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:16:13 +0800
Subject: [PATCH 3/6] clk: meson: meson8b: Delete the spinlock from the MPLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-mpll_spinlock-v1-3-5249a9a7e2b7@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820173; l=1042;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=N+7gK8ye2ZH8Sz8SGwh9nN4Tn81n4jpbYcpMlhBsfdw=;
 b=dphtUdfobSoHJkXJrIcLyyGoAhtVltiI2V0nUCiZXjLIwlYlcis4LsTvsd/4d/Gg5DfGZ6PUO
 OqjLr1Eei1QAyuIutGAG1gmYy2uTt1vpwQylU9mZVhHDYpYCp/cMf3Y
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

It is meaningless to define a spinlock in the struct meson_clk_mpll_data.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/meson8b.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index b7417ac262d3..5011768c0f4e 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -492,7 +492,6 @@ static struct clk_regmap meson8b_mpll0_div = {
 			.shift   = 25,
 			.width   = 1,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
@@ -537,7 +536,6 @@ static struct clk_regmap meson8b_mpll1_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
@@ -582,7 +580,6 @@ static struct clk_regmap meson8b_mpll2_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",

-- 
2.42.0



