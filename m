Return-Path: <linux-kernel+bounces-367783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE69A06C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477B6B283C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0C206071;
	Wed, 16 Oct 2024 10:12:18 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3B206066;
	Wed, 16 Oct 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073538; cv=none; b=ghgoht1pWA/lXE5SxrBa1OrPGe1yRuV8C2DTRTQwH+DKVG5wSEIci5TQ9wH53LeqRtX5QGLeThQRmXKxbvQLY03DRFY5hBAunYmmB74ouRQ5g+Ju61duG67kSoPT9CEk2mD7jogeR5Qbbskm4gfNetfuRm40CuYXKkrsOW0Kxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073538; c=relaxed/simple;
	bh=tY129SltKRUhos5C1Geur7NbRBRS+caoSjnZKXDAc0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVI1EXmPozMp/JzyneGeanviXnTjL0v1BljL9i04cXFnk4Y+gKiU7kCiAh938pqa/dgFM05+H7ddJh/cimLQfgNaTIo+26mZ+SA7HERUS2tClf/6GrTuGtb3pYDY9sBoBCiVJbSCZYlceHZc/hY0rN7lGTc318eBuBZ6wqQJHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <adiupina@astralinux.ru>)
	id 1t10yX-002LP7-Vr; Wed, 16 Oct 2024 13:09:53 +0300
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.43.70])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XT6FS3yDczkWvP;
	Wed, 16 Oct 2024 13:11:40 +0300 (MSK)
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
	lvc-project@linuxtesting.org,
	Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [PATCH v5] clk: mvebu: Prevent division by zero in clk_double_div_recalc_rate()
Date: Wed, 16 Oct 2024 13:11:22 +0300
Message-Id: <20241016101122.2092-1-adiupina@astralinux.ru>
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
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrgeefrdejtdenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrdduleekrdegfedrjedtmeegheeiledvpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgvsggrshhtihgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtthhope
 hmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghdprhgtphhtthhopehptghhvghlkhhinhesihhsphhrrghsrdhruhenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1729064367#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12208138, Updated: 2024-Oct-16 07:58:54 UTC]

It is not known exactly what values can be contained in the registers
at the addresses DIV_SEL0, DIV_SEL1, DIV_SEL2, so the return value of
get_div() can be zero.

The documentation does not describe the behavior of hardware when
receiving a zero rate divider, so add warning assertion and bail out
with a default value if it is violated to prevent division by zero.
Non panic_on_warn systems would at least survive in this case but
still have a valuable trace. The warning assertion would state in
the code that the condition is very unexpected and most probably
won't ever happen but not 100% sure because it depends on hardware
behavior.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v5: using WARN_ON_ONCE() and changing the commit message
v4: replace hw->init->name with clk_hw_get_name(hw)
v3: fix indentation
v2: added explanations to the commit message and printing 
of an error message when div==0
 drivers/clk/mvebu/armada-37xx-periph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 13906e31bef8..ad7b477596ed 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -343,6 +343,9 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
 	div = get_div(double_div->reg1, double_div->shift1);
 	div *= get_div(double_div->reg2, double_div->shift2);
 
+	if (WARN_ON_ONCE(!div))
+		return 0;
+
 	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
 }
 
-- 
2.30.2


