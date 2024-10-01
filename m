Return-Path: <linux-kernel+bounces-346565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D76598C5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD2B1C24083
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4131CCEDF;
	Tue,  1 Oct 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="eAhzF+wo"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5211B5820;
	Tue,  1 Oct 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810473; cv=none; b=lgxwE/z0qUEtTL1fH6tbX8wvoCpAwQCqm7NpPT8gB2bavnp49Z/bHLX6ePPsygbjhajguXX8peQCVV/bPEz/XWOJlzoHGoLs4XHUYcUY+qm1UQ6TtkYUeqZw9oCKF8KEx0TcomXUi0axF/XMC4DPdjsP4hKuBo3fMZz1ALBtfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810473; c=relaxed/simple;
	bh=c7zFNn+Mgez+Y9zHry4VSAq7W/1SrN5YFvt3fipXU0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIMb73BBtdMvyAw6vtZZ7njHiMfaOxGHxlq+8suWCSfgH7b3FjfXm+z6NRNlOJMwc8XP4Tk1x37Eh+sYql7hhl3bk9TLbjtLpeF0sP88Fn0fAvWCZbBIk9Rcclk+lbS6VVCV4r+LoM+1WRgFsNLcv5mXTbXduozxdrRIQwr5ei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=eAhzF+wo; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id D3FCC1E000A;
	Tue,  1 Oct 2024 22:11:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru D3FCC1E000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1727809871; bh=UmJNbXllIaG1Doy7kbysmC0vkO90MSqRndg2Q7c52PM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=eAhzF+woU7fU+yPVa0a7WNFeU0atssHgFHC24IAvIxHnsZUUEOfqpB9ZQQjd2CUig
	 vDYcM7L0lHvGOCH+VaXsmJiKvaNCJ48aHiN+bQH34BusWU+CCLUFCiY68e9I14/iNt
	 QgKgNEwzIaZD061GrMlZcw7eXfasNBxHUm/UBSDrGHLpx89X84LUd+R5g7hhIqhIKa
	 btahgxkxrkf+HGNRVe6MpvMJId6VpwmY/YVuIf44ZCkpAavbXBs9xKD8E8UsMQagA3
	 TV260qvUm2mbpOOyuOKt8n91x6Vp2i/Yvl784rxQyNvg3mTT30o04bIzZSiQPQbYC1
	 K0A4LmKwwmTsw==
Received: from ksmg02.maxima.ru (unknown [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Tue,  1 Oct 2024 22:11:11 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.20) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Tue, 1 Oct 2024
 22:11:09 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Liam Girdwood <lgirdwood@gmail.com>
CC: Murad Masimov <m.masimov@maxima.ru>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Venkata
 Prasad Potturu <venkataprasad.potturu@amd.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: amd: acp: drop bogus NULL check from i2s_irq_handler
Date: Tue, 1 Oct 2024 22:08:39 +0300
Message-ID: <20241001190848.711-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188128 [Oct 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 37 0.3.37 76d1f08bc1e1f80c2a3a76a1cc8929a49fe2f262, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg02.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;maxima.ru:7.1.1;81.200.124.62:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/01 15:39:00 #26689466
X-KSMG-AntiVirus-Status: Clean, skipped

When i2s_irq_handler is called, it's guaranteed that adata is not NULL,
since IRQ handlers are guaranteed to be provided with a valid data pointer.
Moreover, adata pointer is being dereferenced right before the NULL check,
which makes the check pointless, even if adata could be NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 sound/soc/amd/acp/acp-platform.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 3a7a467b7063..ce712aea953d 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -142,9 +142,6 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	u16 i2s_flag = 0;
 	u32 ext_intr_stat, ext_intr_stat1;

-	if (!adata)
-		return IRQ_NONE;
-
 	if (adata->rsrc->no_of_ctrls == 2)
 		ext_intr_stat1 = readl(ACP_EXTERNAL_INTR_STAT(adata, (rsrc->irqp_used - 1)));

--
2.39.2


