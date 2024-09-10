Return-Path: <linux-kernel+bounces-323619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF797403B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF97C1C258E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988381AB53F;
	Tue, 10 Sep 2024 17:31:53 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58D19E7E0;
	Tue, 10 Sep 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989513; cv=none; b=NNpRbK/oOOjYmGaQo/pMuMcg1TvakokZB8OH7ZRI/jSJs1ZuINTOP7j7TLFBzjAM7TcS6JmX2Mk4zcrXs2wxx7xZGOuseRreZa/T70tG18Yd0CjP2AMKAv0js2sGFTzgWTdp8FGN7D/74g1RubKtnCpcQuz9xwjtryofXX+IAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989513; c=relaxed/simple;
	bh=NNbh+sXGelMxk4znxZuaQp3EAwKDlyzCigg5+NauWxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETgyjBmqFI8xeUw7en2nDgdrUTLwRUxYbm2mNRhjde1qBqRbxBVkJl4K5RGFmt5kAVLMHFVpVIX1dg/xEubR6LcVo51h3lGvQierThSGXA/vShoZr2y2sHDhj0KlWHijtru5E3+qc0MtZuU47jd/zWejeJKQtgJyjGK1igdnktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.111] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1so4h0-00BhQ6-Ta; Tue, 10 Sep 2024 20:30:18 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.23.11])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X39jY0XxFz1c0X1;
	Tue, 10 Sep 2024 20:31:28 +0300 (MSK)
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
Subject: [PATCH v2] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
Date: Tue, 10 Sep 2024 20:31:10 +0300
Message-Id: <20240910173110.31944-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <884103b1-e373-4446-b9fd-1cb06cd75360@lunn.ch>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeefkedufedvkeffuedtgfdugeeutdegvdffffejfffgleffieduhfejvdelffdvudenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrvdefrdduudenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrdduleekrddvfedruddumeegjedutddtpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgvsggrshhtihgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtth
 hopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1725985059#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12168349, Updated: 2024-Sep-10 15:21:50 UTC]

get_div() may return zero, so it is necessary to check
before calling DIV_ROUND_UP_ULL().

Return value of get_div() depends on reg1, reg2, shift1, shift2
fields of clk_double_div structure which are filled using the
PERIPH_DOUBLEDIV macro. This macro is called from the
PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).

It is not known exactly what values can be contained in the registers
at the addresses DIV_SEL0, DIV_SEL1, DIV_SEL2, so the final value of
div can be zero. Print an error message and return 0 in this case.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: added explanations to the commit message and printing 
of an error message when div==0
 drivers/clk/mvebu/armada-37xx-periph.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 8701a58a5804..8e749a354ffc 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -343,7 +343,13 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
 	div = get_div(double_div->reg1, double_div->shift1);
 	div *= get_div(double_div->reg2, double_div->shift2);
 
-	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	if (!div) {
+		pr_err("Can't recalculate the rate of clock %s\n",
+										hw->init->name);
+		return 0;
+	} else {
+		return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	}
 }
 
 static const struct clk_ops clk_double_div_ops = {
-- 
2.30.2


