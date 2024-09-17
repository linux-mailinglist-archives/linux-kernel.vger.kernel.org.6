Return-Path: <linux-kernel+bounces-331738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532697B0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377761C21EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44681170A0B;
	Tue, 17 Sep 2024 13:23:01 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6B4C66;
	Tue, 17 Sep 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579380; cv=none; b=SSlVKAHhO8rvKT3iOJwcyI1TkTaNLEAH3vZ7SSnKImVKlK5KsLSGZDbjDEyKT2tXyfsPj+cvWdpdAbcox1R6A2FpjIjqe7TgI7vIW3S+p3VagaBEFMp0HtLAnz+8FXIMZz1DIbikR13HeYvGGqKPAzzc+B/0wrKFyOw2io8xG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579380; c=relaxed/simple;
	bh=sjod+E4bj0zjVaCFVHpuJ7kBig2rZ+x3vecW1/4QbF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiCQzldyaOtRTYdOQmLyjdLAHSGUnI0KgICLT/iOyew0lHh5E5K3i+E+86Qg1RQEccHCMyaOpiXczwO6+htr0uypV4k4XIFr76uLgeM0CTj/EQxnxDa3ue/gS0akzildcyqH871Tuuixt/OxRxFJEVrgkCUQWSFq+6bTV4pK+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1sqY8g-00D6mY-No; Tue, 17 Sep 2024 16:21:06 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.39.98])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X7Mrt42DFzkXGg;
	Tue, 17 Sep 2024 16:22:22 +0300 (MSK)
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
Subject: [PATCH v3] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
Date: Tue, 17 Sep 2024 16:22:01 +0300
Message-Id: <20240917132201.17513-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <82162974-00b5-44c9-bbb8-701e6c871bb0@lunn.ch>
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
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeefkedufedvkeffuedtgfdugeeutdegvdffffejfffgleffieduhfejvdelffdvudenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrfeelrdelkeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrdduleekrdefledrleekmeegudegheeipdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgvsggrshhtihgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtth
 hopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1726239283#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12178289, Updated: 2024-Sep-16 05:03:55 UTC]

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
v3: fix indentation
v2: added explanations to the commit message and printing 
of an error message when div==0
 drivers/clk/mvebu/armada-37xx-periph.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 8701a58a5804..b32c6d4d7ee5 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
 	div = get_div(double_div->reg1, double_div->shift1);
 	div *= get_div(double_div->reg2, double_div->shift2);
 
-	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	if (!div) {
+		pr_err("Can't recalculate the rate of clock %s\n", hw->init->name);
+		return 0;
+	} else {
+		return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	}
 }
 
 static const struct clk_ops clk_double_div_ops = {
-- 
2.30.2


