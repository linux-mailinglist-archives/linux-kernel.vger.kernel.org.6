Return-Path: <linux-kernel+bounces-331406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4797AC75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AD8B222F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250A14A4E9;
	Tue, 17 Sep 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="RfYUSAnf"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38F847B;
	Tue, 17 Sep 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559671; cv=none; b=sTKSddbCyrgOBjDpvzhtafI0ss5qCSqDVdMipD6QXUbDeLTzGZu97c+lj1YXkGzxWFhc17yM47TgIUPXkigKkzQyCJYleMEvEWtYjh3n2A1rMtvf2eCLQcpHCrGjlGugY/IolH/AL0Gw4d24omUWn3bopHH0qq0iAH7xfzMTkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559671; c=relaxed/simple;
	bh=RyH+uVE9CwEOnk1OEb9c/htXe6YY24cQGkNL/8j3HJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIAwZF1BuP4bSQZ0tlTkUdyATQ69Cq/0DRP1MwUZdOMmuQI29aGLPo33FNjG/czdsBSDFDSz1sAL9z9zUZ1Zvivd8qRtORDPJdJsYkydrK2oqSilxoLVD9wIo98qWmMHOIXbWlW47Dy9utzYlpSm0jJjy6rZyCDyXzxfLOs8r1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=RfYUSAnf; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 1862E100002;
	Tue, 17 Sep 2024 10:54:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726559649; bh=gnnqirEGVQIaeAPSXoxwkTNiA3zJLHnpp4lImQKsAlI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RfYUSAnfq/2jOhdAIGKG8Rl3PD2rqjkgFFjsePr2LC3F7tqfbqipyMSqH3gUz8rA4
	 kky2ZdhSaqyEEzPX6M5Uv1xM5BgGtRVuWtTI1Wjj+6w0HvlrqLlghsD9Y5LgJDfkqp
	 EsXnR2PtCJmHsnVc6yv0sfDz3LGbo/ewjEBsawgmwg3ZEI+mc56yb9Sv8UWZJLYnq5
	 JQ6rr7KvmTuaoWz/Lb4DYZvndWpTKUThd+pxQUXME9M9rX7mV9VHyQH+pJAV94yFdR
	 KUy105EP+K7v0g1HD1z3HwI8Tm6UChPo2J/0ozGPDWYSG3heoPH5Ouu5lG33yhgzdM
	 SIaQj5ByHbxQQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 17 Sep 2024 10:53:26 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Sep
 2024 10:53:06 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Maxime Ripard <mripard@kernel.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] clk: si5341: Prevent division by zero in si5341_output_clk_determine_rate()
Date: Tue, 17 Sep 2024 10:52:50 +0300
Message-ID: <20240917075250.19333-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 187786 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/17 06:34:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/17 06:27:00 #26601446
X-KSMG-AntiVirus-Status: Clean, skipped

In si5341_output_clk_determine_rate() division by zero is possible if the
following conditions are met:
- rate > (parent_rate / 2);
- (parent_rate / 2) is not multiple of rate;
- CLK_SET_RATE_PARENT flag is not set.

Add zero value check to prevent division by zero.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 61c34af50c5f ("clk: si5341: Switch to determine_rate")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/clk/clk-si5341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 6e8dd7387cfd..d0d68a5bba74 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -855,7 +855,7 @@ static int si5341_output_clk_determine_rate(struct clk_hw *hw,
 	} else {
 		/* We cannot change our parent's rate, report what we can do */
 		r /= rate;
-		rate = req->best_parent_rate / (r << 1);
+		rate = (r << 1) ? req->best_parent_rate / (r << 1) : 0;
 	}
 
 	req->rate = rate;
-- 
2.30.2


