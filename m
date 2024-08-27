Return-Path: <linux-kernel+bounces-303819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5B96156B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2761C22A31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1EC1CFEAE;
	Tue, 27 Aug 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PlYaOoXw"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2B1BF329;
	Tue, 27 Aug 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779596; cv=none; b=edEpk4zeMLCJfpmjVSk6Ev2hs9oDpBgP/Vh7+0EfEvMeHZ2HbL8DRQR+fA7kUI3j8/UNEP34bqi6FH7jwJKHWBh+Rn6DGG+hB0nzfzPusIxXs+BUVp891B0y91chI3m7ouLKCvtjbg1Gw0j8oRhqswfQCuDo4FDLm+DyMPy8Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779596; c=relaxed/simple;
	bh=+PM8bXH2UryDMrC3rlRWE82lzqJ8PZLlxIHZuvdwvwo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DmoOBonEKFYyOxZbOWUTAD+qmozWXACwqJyStOdBXFqxVgga5ZOmyOnLdsg3TPUNDeJV2p1WDA65j4JEHv18vp7noG/iSwBR/zCJmZMsINWgLGAyfO89k0FFqAkB2sepjH184x2AX2cXS0js5xLVsqvR9Fp+PXRnjuNR19SpQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PlYaOoXw; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724779285; bh=c+XdUW2HyezXRZFbH4M2CkXSP30Z8vGHOUKGOFRwacs=;
	h=From:To:Cc:Subject:Date;
	b=PlYaOoXwaBRqPpL3+klv8gneI3lxqLcEftsA93IthNvZRg0u2uQTckoy5XFjbfkIr
	 +vs9LqMt5QXTnn31w+SdvrRodUxTWh/CF198MZnP6S7mOM3CK6k2aKbwkN1YxoyJaj
	 Tbm1ksl3SPpIWCtTg6g0NHLUy/vrpbSvTbvyyZrE=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 54DA9CC4; Wed, 28 Aug 2024 01:21:13 +0800
X-QQ-mid: xmsmtpt1724779273tge318x5y
Message-ID: <tencent_EC61FECEE03D06AE0D29C514581901BDFB09@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JueDab4DiXX4BJWLPp1GuKLmZ4WHH8UTqZdc2vYzS2ABulFhHYBU
	 NZWaSHccgHzh5batmbcQJ9r5gCEvC8kI/EDwPKosR2lTdtgJjSIHmyOy9JrgW4r4s461nz5v9XdQ
	 OpQ3EnstRXatKNHVXT9y9pehLaEtgBxO+OfoycNifWtjUVQv4m7seMHqrmlt6UyMPQ0xWgBYsyvc
	 QyA21u9YYmUKzPBUBwtPkEgjSfQW5lc3OGtYUp439CkGFkNjn0lQpD+mOFS5tJ7K5jKK/V9SxMZW
	 a9MpXVoqF1t8Cz7pHQblHaZ8MTXjbykIjdnanliPKNJpGNCWSyl6uxl8XonLLHQxtphKr+rmfVWj
	 c99f4IxbNA0KIly7ZRjoRwe1+2LfNq8GxvXd3j0+KgE1f42s4D+36e2iXVYJ6fj09vhlQSA29Lv6
	 TQ8/P/BBxLFFZFEaisIeZ1lGqXHeKZmk0jBjFprXVtMnRWA/IZ5dg/fjMThOzxOx7ZdcnSfXti4P
	 wmu9PITFCdAE7MXCSTmTAMKoTILTd+IzqHC79wLr92MqzKg3iofSCWMLxLTsuESp+7q6mc/2IgNh
	 mRMMFWRR0UcIuVWu7BdIkbwy1w5LrDXjEGW205AsExc+aOqJ7EskFUxssOSo59+LdxzYBSh9iU+E
	 yzszaDvBDJ9t5TzyWepdCRVKyjHhwHZQbgn36CgwXxJD9DwOqiXh7SlH/IbEjN/+F/jIadqCQM1V
	 X5KfqtRO6JlVPZSFQL4Eam2mnybo/VtJ1FHhz+NYm+TixbZNz2msInmk3f5coQyA7YmBdNY68nMy
	 bgTgVxnLXkQS8ZfypC9izejR2tJFWmbAlysA897FgfEDt/NO5Bn8GFOk9Hs8pzbS2MzblDzOjgnU
	 ddDxl5FUbzyEjouxv5U7cIJF0M/JoUsdU7fxOnL2O5odoTryWyV4S5avaua23TD+kxKPPAyv9+T3
	 waOTFByVmylLuCHztatP9rsie6Z00n3XAipk69EHb1BxlJ68r3aZ1ATbI3UYlglSq317OjYHUWqZ
	 hmXMIGoqibSTpHODL8dbT7eMuPoxKPGynrI02MvQPuE3tgHuZg
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: jiping huang <huangjiping95@qq.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>
Subject: [PATCH] clk: Delete init for local variable "best_crent_rate".
Date: Wed, 28 Aug 2024 01:21:10 +0800
X-OQ-MSGID: <20240827172110.65134-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  I'm sorry, my last submission may not expressed it clearly, and there \
is an error delete. Therefore, I would like to generate a new patch and \
explanations.
  Actually, it is, the local variable 'best_crent_rate' is only used in \
line 2355 for the judgment 'best_crent_rate!=parent ->rate'. However, \
if the "if (clk_core_can_round (core))" branch condition in line 2306 \
is true, the value of the local variable "best_crent_rate" will be \
updated by "best_crent_rate=req.best_crent_rate;" in line 2319, otherwise \
it will be directly returned in the "else if" branch in line 2325 and the \
"else" branch in line 2329.
  In summary, it is unnecessary to store the "parent ->rate" value in \
"best_crent_rate" in line 2301.
  Thank you for your precious time!

Signed-off-by: jiping huang <huangjiping95@qq.com>

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8cca52be993f..b6ff88f63bc4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2297,8 +2297,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 	/* save parent rate, if it exists */
 	parent = old_parent = core->parent;
-	if (parent)
-		best_parent_rate = parent->rate;
 
 	clk_core_get_boundaries(core, &min_rate, &max_rate);
 
-- 
2.34.1


