Return-Path: <linux-kernel+bounces-333470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C680197C936
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C491C21D19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2919DF52;
	Thu, 19 Sep 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="mWS1L1JC"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7AF19B5B4;
	Thu, 19 Sep 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749051; cv=none; b=qPp3lI+kHJpyLTHzIPQVy9vD8xxyacaAsdX3tQhj0xXPpXS3vqfvKMO35DLOrjTBhbC2OlG0HPzW5Mmn4eYexwOxj1od4NW3va9ON5+Kh+Bf05Y8d8TanRtcV33GzrZ9ws/tLDDDyZpY5A4JWqVWC5MB7cBZxSuJbuY6LvT3IFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749051; c=relaxed/simple;
	bh=AZnLPid0iFOo8njVxwurLLWt246eu7E+Yizf2AMJDHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq0Rhj4L06V/eQepiZgOcGG8sHH6AzU8dCKckMDf6Wr3zBWcWJambnNdiHsXSUArLrpvoYTo5E5OokrvcoG1tjxvKgXapkjNE2BxL4TbIyTL6uX/X1rW6GV/4h1olJGjobbvDvBxy+OP+p4hekH62lIusrUB+ZfD3HPXK6dJVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=mWS1L1JC; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id B99A6100002;
	Thu, 19 Sep 2024 15:30:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726749022; bh=DNVzB01qHTsJ/pl2a0SdlteK0f50ibC+uxZiZtDnZbU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mWS1L1JCi1MDIY5eYaVN067rxVXuaaaXtGzeBjjtPQPPFttvlvk94gYIANz9Tv14g
	 aLlfljOR9UVfQAoPB9o9r+QgnOweUQUATfoZBHV68g9VbYhslm9vttJeJxrb1fJeaA
	 PNpSMRLoJusfNcZyzi9HuhjszLtCdzVuM2WZS0r4gokxgoNNKxyB05CQtQ8Pz1RbVt
	 XuLnGC0NBkgIXn4hOku1IU8FkJZqRpQXo5XU+Rmeg/5tc6JzEEXsaE8DGFjKKp/U8M
	 3fkDgacy/uX1cAUbMV0l9OIrJTxfCnZQUr/UrMbksncmdAQ9wx/DDhE79UpdWn21ha
	 tDNSY7DgpZ0vA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 19 Sep 2024 15:29:40 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Sep
 2024 15:29:20 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Maxime Ripard <mripard@kernel.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] clk: si5341: Adjust rate rounding in si5341_output_clk_determine_rate()
Date: Thu, 19 Sep 2024 15:29:05 +0300
Message-ID: <20240919122905.14026-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917075250.19333-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187861 [Sep 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/19 11:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/19 10:29:00 #26627046
X-KSMG-AntiVirus-Status: Clean, skipped

In si5341_output_clk_determine_rate() division by zero is possible if the
following conditions are met:
- rate > (parent_rate / 2);
- (parent_rate / 2) is not multiple of rate;
- CLK_SET_RATE_PARENT flag is not set.

Add zero value check and provide a higher rate in such case.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Update "Fixes" tag, in case of possible division by zero provide
 a higher rate as suggested by Stephen

 drivers/clk/clk-si5341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 6e8dd7387cfd..278fb341d3d7 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -855,7 +855,7 @@ static int si5341_output_clk_determine_rate(struct clk_hw *hw,
 	} else {
 		/* We cannot change our parent's rate, report what we can do */
 		r /= rate;
-		rate = req->best_parent_rate / (r << 1);
+		rate = r ? req->best_parent_rate / (r << 1) : req->best_parent_rate;
 	}
 
 	req->rate = rate;
-- 
2.30.2


