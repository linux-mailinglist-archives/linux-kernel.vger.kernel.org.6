Return-Path: <linux-kernel+bounces-303978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDAE9617DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB80283AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE781D2F78;
	Tue, 27 Aug 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UJepcORI"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846E146D6A;
	Tue, 27 Aug 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786139; cv=none; b=gttYdd3tWPoCYnRCW0dqEOO/T0wk+kfFhUuiNrLOejPKHjh4yTe6EsFaEbIHZ92ZJP8LdSUlrLrMAXyBWQVEWMPgorm1ChZCtGml/Yz2r3DAqLZZyHpXdhOuYKmQlMzwZPuW4ES8NRLOEbnOMBOwevqf5JBJMpvIDIY7DyTpVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786139; c=relaxed/simple;
	bh=jabYyamu7DASq95qkpSX31tv3SineQAeHuDW7SGS8qk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GprAdjEwTYdVwj77PRUe6sd52j66YUpAzq2DoA4txi/A3C6VxK96z7qTr6EPyzXKPeZZqQAffIx1dC2uRB+Yo40K4ZnEAUw+gsOR10bBiRwFX4rxi2dj/ffKKGnXdRcppToH5aDAd4U9os8LPo34OjkctGMu+xAk/fuQoLE0R+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UJepcORI; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724785835; bh=hU7ofY00NIzY7HQ0Ss9KlIal31nOOy8WuXlW+57Dwcg=;
	h=From:To:Cc:Subject:Date;
	b=UJepcORIUyWuD57wuiZKi+R6KQ2byY/JKJ4UnNW2XiODiyYx0zl08Hxcr+9ejlTz8
	 MUrv+lTZxMDB7koDHAz6GgC7Dli25e/DwI/GVh21pHjoscDsG6rOdhxKuQnqTBOEt9
	 RCncODbvcgYbnl15EgbYDIcefiz9g9G9lg0icaZg=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 29934AC8; Wed, 28 Aug 2024 03:10:25 +0800
X-QQ-mid: xmsmtpt1724785825txqyvfh1i
Message-ID: <tencent_B732022EF733FCEDC36B0E601B62889DB00A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznCM+daMDhg00chSC1QSmQAsB5g36rh0PhHo49Kw+xS8E1b+Npss
	 dFt31s5i63Br5ivP96Cn4y/UevKztoUD/2xvhDqSaFcFMg4IRu3SYs/lky9UEwNaaJEHm1bX+4DB
	 5OC3Lbxr9+VNmnvUSM1ijOnVr3Bguuipt5sA3Stqwp/EhWJhqjhGFrv7fr9eFS56O+TgScasmH5f
	 9vUn+IlFiVqsQonVruvr77f9DOgZ4yPn/ir8n/OhuMvSX6/wXy9d6DyWnS36K7uxqirSNRk2fsSu
	 aJvybHaFJHfl2cBi5gZUGIx35hRTGe0b2srGZdQjE0TNYCSDW1bm/DoxxJ2jnE8RBl+Bu09vbg7a
	 Dg/rGl4TlRXu6GRVlXYeOtkvuRyR2ZpOgfE+jJvQKP/fxP28C5K3pqwJ8hdQBSTKjAPHb/49dGOi
	 Bz6G8/EGxGWKPjDHKX/1KuiuaExZ7N9XTWs3IetjhkQ7VsKmkcXKaMK2uGBHx5K32epi7PDf4Q74
	 V3I2/6n2pC038WI9GHsCGfGDwgy4uRbkHuplLIyqPZJDYd342ih19G0viiGMAcjpBhyvMnHvNb+M
	 7LgCvYyoY0oHPpY8IjqCzE+YTtcQNNG+YuFSlzGoTVa6r+4OuFemM8vYZGKf5c19BqKibQdIvMJd
	 n5qykqUX6gXvBy8F3alV5yrkZD0tjJED7InVuBJtQFSxtfc41hIXF4KbNiQrb8mVPY/B8wOxjE4l
	 RCCIcTaxthtdK8EA0I0l9uNvwJ2QkZcPX7SMkxY07uHUd0rIJmyE9BOsbQhd7XZq1Pt4jIcBbmii
	 8lMOgFAEJqU+PvXpViEImj1TEpveCH8wgF0WfRkLUk2zBGdrrnD6azlC2LqMHuYj/Fk1+fmxPdj3
	 d2Z7STRsQuh+6NeTlVPa/U+3IAU7YGvlC05xTubEbmQ+FM0C3rkJf+R5EE3Ny3CQrGadunt4HqvO
	 UYEp++GdytTcBA8qG9Tmq2Y5vWjzje/U5/d6mV9RZefcAQTGVHPHUlvdK//K7qoyqdg6oYwlXCR8
	 FLSZTorH9nlzlH/+0o
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: jiping huang <huangjiping95@qq.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>
Subject: [PATCH] clk: Delete unused initial value for local variable "best_parent_rate".
Date: Wed, 28 Aug 2024 03:10:22 +0800
X-OQ-MSGID: <20240827191022.65346-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  At function "clk_calc_new_rates" entrance, assigned "parent->rate" to
"best_parent_rate" as its initial value, but this initial value is unused
in subsequent logic. Analysis is as follows.
  The local variable 'best_parent_rate' is only used in line 2355 for
the judgment 'best_parent_rate!=parent->rate'. However, if the
"if (clk_core_can_round (core))" branch condition in line 2306 is true,
the value of the local variable "best_parent_rate" will be updated by
"best_parent_rate=req.best_parent_rate;" in line 2319, otherwise it will
be directly returned in the "else if" branch in line 2325 and the "else"
branch in line 2329.
  Thank you for your precious time!

Signed-off-by: jiping huang <huangjiping95@qq.com>

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8cca52be993f..b6ff88f63bc4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2297,8 +2297,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 	/* save parent rate, if it exists */
 	parent = old_parent = core->parent;
-	if (parent)
-		best_parent_rate = parent->rate;
 
 	clk_core_get_boundaries(core, &min_rate, &max_rate);
 
-- 
2.34.1


