Return-Path: <linux-kernel+bounces-319713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A80970117
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C661F22F9B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE801537DF;
	Sat,  7 Sep 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KSf9TGV6"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFF1384BF;
	Sat,  7 Sep 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699615; cv=none; b=RxvLJ7E5KzqoPsUwiVfdbqF2j8pOZdCg5481lNT0iHwnbplepsXHAZ1wI66kFeyRQW09WpedurpLbm8Sl+E1JVNDUITXaIVqIgZc2LxdGQbk2coMDMy8uj2eK2glIbXyqWB5++ZAXzgV07kI+0wAbnr3FT3GWyOwa73Q42DSijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699615; c=relaxed/simple;
	bh=iW4kPlXxu37yfL9FJ/tJj3k3DqFzi26mGnjj8suS9lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q9Lj3dTAd2qLe0VfQ6QNOVeO5CMI+voy2qpUt+cY1x/vZrjQDNUqYNhmw2wkYJJxY4HtzWmsC9iigqs62AOx5OdNbJDymr2rANsh3Wn3ZaLYrEZBSnek0lTlewDx69/DdyXKuzAzc0GKA30fg+HRAZ+3UDYntG//dilKErnCdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KSf9TGV6; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id mpQXsPTZ8Ne0ImpQYsxdp4; Sat, 07 Sep 2024 09:00:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725692417;
	bh=rX81KQHUGSEqEz2QKyT6FzHMJ4cGxuCMFPTkegHxuyY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KSf9TGV69Sur6qViQeAfUSY3LTR3tH7pAHSL7Qa5xvsuvuj0CHN/DmkXDVnmDnJo5
	 jOK5OO3iRLaw8e6FFoRxvQvUCIZws3dCr8BLaO2m6o4K+E+DoVVwlePo4xy+DFwCZ5
	 dslVcbiiV81rD+fY9bJr28wkJj7a9HVfeiApuGl5mQXHhr1bXtQxvbURwHu4FfO7CS
	 6hmJHrubc6zYMPNhcZZ7gwZh6ezlvgXlJvhjgqi+PN34iNJaI75vLUSE71/hNkGvfz
	 f1MmZagPwYTPkPiFkPG8TPN6BNff+Ahu6T1NuwLCt+sJw2JgpMO/xiUSTJN7wL4oDy
	 qEwvhMdrlQAGQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Sep 2024 09:00:17 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	openbmc@lists.ozlabs.org
Subject: [PATCH] =?UTF-8?q?peci:=20npcm:=20Constify=20struct=20peci=5Fcont?= =?UTF-8?q?roller=5Fops=E2=80=8B?=
Date: Sat,  7 Sep 2024 09:00:04 +0200
Message-ID: <3c7d455745c2265c19ed02f026dfc9610271d3c2.1725692376.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'struct peci_controller_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   8003	    784	     48	   8835	   2283	drivers/peci/controller/peci-npcm.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   8003	    776	     48	   8827	   227b	drivers/peci/controller/peci-npcm.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/peci/controller/peci-npcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/peci/controller/peci-npcm.c b/drivers/peci/controller/peci-npcm.c
index ec613d35c796..fa91be58f6f3 100644
--- a/drivers/peci/controller/peci-npcm.c
+++ b/drivers/peci/controller/peci-npcm.c
@@ -224,7 +224,7 @@ static const struct regmap_config npcm_peci_regmap_config = {
 	.fast_io = true,
 };
 
-static struct peci_controller_ops npcm_ops = {
+static const struct peci_controller_ops npcm_ops = {
 	.xfer = npcm_peci_xfer,
 };
 
-- 
2.46.0


