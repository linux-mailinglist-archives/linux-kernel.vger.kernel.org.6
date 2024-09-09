Return-Path: <linux-kernel+bounces-321495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F7971B39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25043283EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D41B9B37;
	Mon,  9 Sep 2024 13:38:48 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157A1B9B24;
	Mon,  9 Sep 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889127; cv=none; b=tcn7VlJXg8Lbklki5YefOxar+XifWBdqbdYjawOaoZaLZPglCyCx6Q7k+AKCGG0P06IBVn9QDJlTY3fgfCBG/OABuJ+67jJF1Mb/f0JGmVoQksanI3AtzMdnGnQdlVpz5F7Z+lA5Nj7hx5xnis2L4Vd1iRXtTx6sHUOCqhjXEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889127; c=relaxed/simple;
	bh=O8gX/5RIGsAcWdIaQgqKjVgDinsG/6/Ad0M6d8EJ2e8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbtl6isxCXPkf16VG00va5X7hU9F6q84uPYDlKoGqRDReC3RiBgVGl9CkOAr9IvcQT6DA4UEhizqU07UBXwX3h2QBmiPe0jUbmj9Jur0RPBcaRBpZgFISHWdCcIu7/0USseMTbeMeWZNXeX9iT22IWj5tQ85MdVmMpZAyIk2Tzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.108] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1sneZv-00BKRR-Qi; Mon, 09 Sep 2024 16:37:15 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.22.196])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X2Sb44xNlz1gxcY;
	Mon,  9 Sep 2024 16:38:24 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
Date: Mon,  9 Sep 2024 16:38:07 +0300
Message-Id: <20240909133807.19403-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrvddvrdduleeinecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdeftddvieeltddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudelkedrvddvrdduleeimeefheekkeeipdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgvsggrshhtihgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtth
 hopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1725884359#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12165610, Updated: 2024-Sep-09 11:24:55 UTC]

get_div() may return zero, so it is necessary to check
before calling DIV_ROUND_UP_ULL().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 8701a58a5804..d0e1d591e4f2 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -343,7 +343,10 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
 	div = get_div(double_div->reg1, double_div->shift1);
 	div *= get_div(double_div->reg2, double_div->shift2);
 
-	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	if (!div)
+		return 0;
+	else
+		return DIV_ROUND_UP_ULL((u64)parent_rate, div);
 }
 
 static const struct clk_ops clk_double_div_ops = {
-- 
2.30.2


