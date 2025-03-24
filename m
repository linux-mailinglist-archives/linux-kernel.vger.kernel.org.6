Return-Path: <linux-kernel+bounces-574506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1984A6E60E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F5D18985B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A11F540F;
	Mon, 24 Mar 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAj5QSgi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC71F4C8E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853391; cv=none; b=Wv9UQsKcuTlMzTVzBI4QaODksYAOPb2+6VNAlvFWH5afCHWvTcPpxq9aJbvjzxc8krpOrLFtEZ3vW443Y256Of08B3Em111/143z3c8xjIEksYZLqLnZ5f+hL7fUbSn+TMDurgeFOlRBU8fi5L7oniJQ+OyePH9aSw/FmsQfVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853391; c=relaxed/simple;
	bh=n8tygGcCBvI5bEr58ByQaC/880pDiVAdBJyD9A6bB2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkvOepL7Qbf/ywzOzyPYS4KxsJnY6x0M/kDDJuJeZxy8gghD9ndychltaFmC4Fu6SMbIiY3iOnZPk2jnHRfqibogu5PV9UgOx9B9ptS7bNWfVDK6XrsyRWkx1ultCcYldATev4T6l8DKR2arpbK7qMxXwABFLZzgp1wV0C3I6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAj5QSgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA6BC4CEF3;
	Mon, 24 Mar 2025 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853391;
	bh=n8tygGcCBvI5bEr58ByQaC/880pDiVAdBJyD9A6bB2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAj5QSgi6ipkeUkyLvHs7mM3W/U9ZMS+2UuduZddIyNdLgp3hlxxugSsBYPTaq2B/
	 2JysdxbE3/YqCL6bkoh2SzrnUgXhYdgYV644dL+E0wXGd1/oL2dC9JeNlsot81Hzkp
	 UNB0uYr/B8ZHKmOuC3oZKZhVLCj5wEp5SwCniPCa3aoxql1B6BOR7gp9DOHthhWweh
	 iHylK1C8DdTeG7s55ivVFxZ7CguP0GbDTjxD+76bU85H5cUKqb1qEZKXlZTNPW78bA
	 E4GBvecLaQqyiyohkEoCb21UbjmMdFxVwYPPvC2vGrfqGOVehPxzW9zVX3wDyRez4y
	 97x7ozTp+PClQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 21/22] pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
Date: Mon, 24 Mar 2025 14:56:11 -0700
Message-ID: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With CONFIG_COMPILE_TEST && !CONFIG_CLK, pwm_mediatek_config() has a
divide-by-zero in the following line:

	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));

due to the fact that the !CONFIG_CLK version of clk_get_rate() returns
zero.

This is presumably just a theoretical problem: COMPILE_TEST overrides
the dependency on RALINK which would select COMMON_CLK.  Regardless it's
a good idea to check for the error explicitly to avoid divide-by-zero.

Fixes the following warning:

  drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of section

Cc: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/pwm/pwm-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 01dfa0fab80a..7eaab5831499 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -121,21 +121,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
 
+	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
 		writel(0, pc->regs + PWM_CK_26M_SEL);
 
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {
-- 
2.48.1


