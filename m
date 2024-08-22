Return-Path: <linux-kernel+bounces-297867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC595BEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1981C2158C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD11D1720;
	Thu, 22 Aug 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrGKfggg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF03A8D8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354145; cv=none; b=VpCtDCvaVTck1SMZoP9zyu73hwv4ShCgAnh2rEVnJ1S5mOZp8PreDtqlzfGeo2uyxtpeRob3YJUlkJgjUDwajuXZ7rNN5oDytXspLwGSgy3imGdRub2dBKwe1bfN41z7RRDasdBF8+j+8f9c8J8Oypb2XWhviJwdxZmvhv6VfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354145; c=relaxed/simple;
	bh=nMY1SpzGoP8oeW0CCyhb2py/IKmlVcolBjcNTRB94bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4hHS1U+sFfEv+r5SFxnMqm8rBFQGnoinIq1hHpD3wjMixST2EG0zjkpv8vbeJnS2Rb0mVXtPZBnW12ING4tesC065qg0t2qT7Twb6iqfJw6IhfzTpPHZOk2vwLy8Rm5sNHwOsvqkSQbrVfMqILv15Gfr+u55YKWqG1ODgABkp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrGKfggg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D39C4AF15;
	Thu, 22 Aug 2024 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354145;
	bh=nMY1SpzGoP8oeW0CCyhb2py/IKmlVcolBjcNTRB94bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FrGKfggg0RqKGEADj8upTbVV2vULhc0wuFAIt/NeFlYJCquWifB9+wRiU9uN/Or/e
	 H8suP8YWjg/dQ8M3h82wzChv8r8hdh19M74U6a0k0kRGcR7uxf+ypA16/X+h7v9u8n
	 maqMtaP/o014NIs2SJDABM97eTFoK9RpMD/OBME4cZ95KF26ktf8fMXLgaplVMchVb
	 gYS+EYtPdGyr1Aj/sFeFKmW8qFGVmArgBP6Pi1Af0jJdyUJ2f/40dPlDo0i7GcMKag
	 MrBxCTPRahoFCRbHSOKXDH/LlqZp90Gk6fqi9dSzEp7+vh5PUqnhzer+/YHkiXys9I
	 K3mldEPj0y3gQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 20:13:37 +0100
Subject: [PATCH 3/5] regmap: Use locking during kunit tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-b4-regmap-maple-nolock-v1-3-d5e6dbae3396@kernel.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nMY1SpzGoP8oeW0CCyhb2py/IKmlVcolBjcNTRB94bo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmx45Xnb0AO+klDAfjuZTanNIr2Sl1IK78oEHoi
 RHupP7GFl6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZseOVwAKCRAk1otyXVSH
 0IlNB/4sujDfssqMAFFVfGMlBY+P/eYdMxzxMqDsvPLXwk3B833qyVPbfKLsdHOCTifxPs29bGU
 QJOKU4qA5e37G6FnS9t0lTuMjknafH4bdES+sj/FehZQyO7M728TP+F4M9Ata9jS/4RAseCJpSL
 KZzbTcbYrnSQ/6DVo8c0HoKOeQDMkK/HQajxOBKjMlBsJ0zTDbtG6GGXsKacR04pIrwMQ8f0566
 nKG5TQK6lg7jATjGGcxrpcnjvxvaIBXEewIjWFpO92q2mkQODWLzXzFGRUyuZxflsWNSIYntiXs
 m/br6Oh07fOuV7sDTJx2hiAL/srD4GQfZIXl6MUFj5dhB/t3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is no reason to bypass the locking when running the kunit tests,
leave it enabled as standard.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index d790c7df5cac..b80b447c87a2 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -151,8 +151,6 @@ static struct regmap *gen_regmap(struct kunit *test,
 	struct reg_default *defaults;
 
 	config->cache_type = param->cache;
-	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
-					config->cache_type == REGCACHE_MAPLE;
 
 	if (config->max_register == 0) {
 		config->max_register = param->from_reg;

-- 
2.39.2


