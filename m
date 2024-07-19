Return-Path: <linux-kernel+bounces-257248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD793775E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594C52828CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0396512B169;
	Fri, 19 Jul 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ACpoUuoc"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934B127B56;
	Fri, 19 Jul 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390283; cv=none; b=fkjOrR6AXqRndecnc6KTsWvJexhuSo6cr0Ch8r76jt0/fqnuMVG0DI/T5S0Fj2GYHyR4o11yo8PowqamMxSDs4WmrbMuQSEmxkc7HlP6oVzT8ajJxwcFrilf9yiN0NCvxqTchFTp+mjI7DgeZDNyB3ZPGxB0f5657p2oLjAyies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390283; c=relaxed/simple;
	bh=KUYDhmviLLJEEK/fupi8+po8it+Wlsoi1APE7MEJ75Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7CeHwBwNVlxrCU5dxtg8N4kFRvKH87NZTcJZr0jewettf5lIzzqN2Fg8dzVYjXokntpt7/l+TzlSw0YrX52cKbPmXN+0WMR6Fwdu7Fp2ovcxlMZoDN6lvLdoZqeubirWWH//4osGnJxvKR/vDw24VYRmBWIQSPCU+2f30jal88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ACpoUuoc; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7suUV
	Yazi9ZfI0XPGUqIsnu4KlBc3BTZkvP+NK8M+R8=; b=ACpoUuocZ1nLMd943h4v5
	DCtp9kZkWimnuLMg0SIAhwJ0adx94XMEQTBFRj+Ctyc4umiuNu7MnHIgK2bkmM00
	4Epkm5awnQm6L3FMbOfdokpudMu8jzfjYyDUCk+MXb2feMzk5NAAttbyGBmxsi+G
	MXm5bM8J0Yj5NIT1oMj8YM=
Received: from localhost.localdomain (unknown [111.48.69.247])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDnj1OrVJpm7BaPAQ--.29396S2;
	Fri, 19 Jul 2024 19:57:33 +0800 (CST)
From: limiao <limiao870622@163.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	limiao870622@163.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao <limiao@kylinos.cn>
Subject: [PATCH] clk: sophgo: fix warning emitted by objtool
Date: Fri, 19 Jul 2024 19:57:27 +0800
Message-Id: <20240719115727.27857-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj1OrVJpm7BaPAQ--.29396S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45Gw1fAr4kur1UWr43GFg_yoW8ZrW3pa
	srA3yDur4jqr17Xa17twn29F93t3y3KFW7JryxG34rZw15JF4kJ3WSka4kZFyjqrWfXFW3
	Ar48Kw47JF4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8sqdUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiLxEhzWVOFCf0bQAAsT

From: limiao <limiao@kylinos.cn>

for ARCH=x86, the combination of CONFIG_OBJTOOL=y enables
a host tool named 'objtool' which runs at compile time,
when CONFIG_CLK_SOPHGO_CV1800=y or m, objtool will produces
the following warning:

drivers/clk/sophgo/clk-cv18xx-ip.o: warning: objtool:
mmux_round_rate() falls through to next function aclk_set_rate()

we can find the reason from objtool help document(tools/objtool/
Documentation/objtool.txt):

Objtool warnings
----------------
...
8. file.o: warning: objtool: funcA() falls through to next function funcB()
...
   2) funcA() uses the unreachable() annotation in a section of code
     that is actually reachable.

so we replace unreachable() with returning an errno to avoid this warning.

Signed-off-by: limiao<limiao@kylinos.cn>
---
 drivers/clk/sophgo/clk-cv18xx-ip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
index 805f561725ae..0fe9a9bd3f49 100644
--- a/drivers/clk/sophgo/clk-cv18xx-ip.c
+++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
@@ -602,7 +602,7 @@ static inline struct cv1800_clk_mmux *hw_to_cv1800_clk_mmux(struct clk_hw *hw)
 	return container_of(common, struct cv1800_clk_mmux, common);
 }
 
-static u8 mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
+static int mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
 {
 	struct clk_hw *hw = &mmux->common.hw;
 	struct clk_hw *parent = clk_hw_get_parent(hw);
@@ -613,7 +613,7 @@ static u8 mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
 			return i;
 	}
 
-	unreachable();
+	return -EINVAL;
 }
 
 static int mmux_enable(struct clk_hw *hw)
@@ -648,6 +648,8 @@ static long mmux_round_rate(struct clk_hw *parent, unsigned long *parent_rate,
 			return *parent_rate;
 
 		id = mmux_get_parent_id(mmux);
+		if (id < 0)
+			return *parent_rate;
 	}
 
 	div_id = mmux->parent2sel[id];
-- 
2.25.1


