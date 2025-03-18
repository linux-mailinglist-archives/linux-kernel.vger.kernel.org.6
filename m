Return-Path: <linux-kernel+bounces-566076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B99A672D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD28D189F67A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2A520C016;
	Tue, 18 Mar 2025 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JjoaLZnt"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83F20B7E9;
	Tue, 18 Mar 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297752; cv=none; b=HKyBYQa3iFW8pqpGrpzA2ssAe4preHK3mBmBX4yeS+tqWOwscd0GmXvYmlxlmSW0CrZr7K0ZUeeZLsshbUM6cJGCQipu5u/FfBUvkf5FGORlFAxnqnM4LLTzhD9icfZVM71HBhJfB2d7m0FUecbk8f1oKWYwT0SGDXDZovGIw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297752; c=relaxed/simple;
	bh=/6CF2wMzbpy7fKpS53DJ5LlhZBb3PsXTEdnWg8I9YkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RjgMGQDYn2VdQPh3+9dFT8fL6Iu5NyOiGw92Odf0Keaf6u28c0yeEowxp5vANn7WukxdI+eG3FhvyFVW7rR79ITQEpOye9/2IHqplTFp7f7Fw+HJgFpz+LQbQ/W2d5pDih3jw1V4dJD7qWCK9j/LDnFpV+hVPpV60iM3x9PqzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JjoaLZnt; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52IBZQeT3053345
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 06:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742297726;
	bh=DsN1ncMlJ5zo/5NafwL+81jdetyHrIDDsHNQZGF7/6o=;
	h=From:To:CC:Subject:Date;
	b=JjoaLZntQRZ0LeHi/40id75IAoZZpZYaPjmx5gcAXlhhNYnRGWOivteR+mjihfXdQ
	 PDOnhg09I5XAvrjLzmNqrCNrpoODyk11jAfVwBibAS6SQMt+mWRfB/Jy9e6rmz2cxK
	 Ok9vU98qSxEbgD31N+w/y5/SlLwwRco6+8cASdeU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52IBZQLb007471
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 06:35:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 06:35:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 06:35:25 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.98])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IBZOxL104649;
	Tue, 18 Mar 2025 06:35:25 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <peter.ujfalusi@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <perex@perex.cz>, <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH] ASoC: ti: j721e-evm: Fix clock configuration for ti,j7200-cpb-audio compatible
Date: Tue, 18 Mar 2025 17:05:24 +0530
Message-ID: <20250318113524.57100-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For 'ti,j7200-cpb-audio' compatible, there is support for only one PLL for
48k. For 11025, 22050, 44100 and 88200 sampling rates, due to absence of
J721E_CLK_PARENT_44100, we get EINVAL while running any audio application.
Add support for these rates by using the 48k parent clock and adjusting
the clock for these rates later in j721e_configure_refclk.

Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

Error log for J784S4-EVM platform which uses this compatible:
<https://gist.github.com/Jayesh2000/22784d790f493ca182bb78c8d5015c9b>

After this fix, test log for 44100 rate:
<https://gist.github.com/Jayesh2000/13ab5852109f899fa2ceb466f8c130d9>

For rates 8k, 16k, 24k, 32k, 48k, 96k the scki used is the default
value i.e. 24576000 Hz. When any application request sampling rate from
11025, 22050, 44100 or 88200, the clk_set_rate calls are invoked in
j721e_configure_refclk and the scki is modified to 22579200 Hz.

 sound/soc/ti/j721e-evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 2057d46ad884..0e7e4ff950b5 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -182,6 +182,8 @@ static int j721e_configure_refclk(struct j721e_priv *priv,
 		clk_id = J721E_CLK_PARENT_48000;
 	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_44100])
 		clk_id = J721E_CLK_PARENT_44100;
+	else if (!(rate % 11025) && priv->pll_rates[J721E_CLK_PARENT_48000])
+		clk_id = J721E_CLK_PARENT_48000;
 	else
 		return ret;
 
-- 
2.34.1


