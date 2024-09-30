Return-Path: <linux-kernel+bounces-343808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F5989FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43FE9B25AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6515818CBEF;
	Mon, 30 Sep 2024 10:50:17 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313918BB9E;
	Mon, 30 Sep 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693417; cv=none; b=fMrqRiYu7WbHrrH2QcSg2UsEFe4ZhmYTvJpH6pZWyJvWEh12fb2vFjakm60oPwW207S89He5frC8LfM8j4+hA0iI7GgpCTjDpc4FiC2X2w7pAyRt7CACK5VLbaRjANIWwFVgDZHEs+dzJuKlMQG7BgSj43UwX69rFrhQQ81Beeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693417; c=relaxed/simple;
	bh=w4J45orhsf8tZYcUUE666E7eYUVbtcrj8y83qf8plJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qm7oHFUrG7hc+k3RuePLaJRx5enI16tMS29vSUFDURDY6J0kD/LPDk9zHvmRxyF008+UFYHGQTZQeWCyrW41VAKm4OU3iFXa2qBT0DAqqdg1/dQ+cNaeOIAoCJ7NuMC0OoXyrTP8iW3KDgfJKridbOD3gM8DexgAHbSacifqtqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.108] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1svDwx-00Fdfn-N7; Mon, 30 Sep 2024 13:48:19 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.42.81])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XHHrt5xRnz1gwkc;
	Mon, 30 Sep 2024 13:49:50 +0300 (MSK)
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
Subject: [PATCH v4] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
Date: Mon, 30 Sep 2024 13:49:34 +0300
Message-Id: <20240930104934.4342-1-adiupina@astralinux.ru>
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
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrgedvrdekudenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrdduleekrdegvddrkedumeegtdeludeipdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgvsggrshhtihgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtthhope
 hmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1727684630#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12190301, Updated: 2024-Sep-30 09:34:50 UTC]

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
v4: replace hw->init->name with clk_hw_get_name(hw)
v3: fix indentation
v2: added explanations to the commit message and printing 
of an error message when div==0
 drivers/clk/mvebu/armada-37xx-periph.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 13906e31bef8..2f0145a76f22 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
 	div = get_div(double_div->reg1, double_div->shift1);
 	div *= get_div(double_div->reg2, double_div->shift2);
 
-	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	if (!div) {
+		pr_err("Can't recalculate the rate of clock %s\n", clk_hw_get_name(hw));
+		return 0;
+	} else {
+		return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+	}
 }
 
 static const struct clk_ops clk_double_div_ops = {
-- 
2.30.2


