Return-Path: <linux-kernel+bounces-370228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFA9A2996
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57581C2508D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF51E0088;
	Thu, 17 Oct 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPSdJdCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9931DFE36
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183855; cv=none; b=JuKvOJ3NLTOJEtdVBPNExNRoGZPkLlCjA1Q53x7mOI0kPrQuvKrBdnmTx6138z1XGkoPmeznV0XLRbBwOe4KTaEzmWQxmaZoscYgZ5BjA8FGea09ziWLDFN9rIyisGUEIpEd+FhpqNNsdrnB430kb6lPJDaCLxADpiwy3816MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183855; c=relaxed/simple;
	bh=wsrgcgckUzKVDFRbi/YSgS+i6orOaA/wjwoY2un0FkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcUi9v2HYvBP7tmfNpnQyAIF00VaQoqAmg6F4Bc/TOElp47A0tYEHTwXYfWVr8GewG+gP3Qng6scR6wJAfFbY1ATQrnY9R0q8dbgRJu3CA9ongukbFvlyOsMgg2SGiymdfKY5BYkQVvzFzMdDIMwzvVds94tQwLcd/PAn/+Z96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPSdJdCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD84C4CED1;
	Thu, 17 Oct 2024 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183854;
	bh=wsrgcgckUzKVDFRbi/YSgS+i6orOaA/wjwoY2un0FkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPSdJdChZ4CsjAXpj7jll/CSOcrp9Fsardvs+Zx5SUFf58aH/0PdA4KStFuh7BG95
	 oLflm20l62VCdmIvyJC7E6rs/z5qNUB3fuBfszWD/zd2MxpCmLvGtfvhmPOWJyj1MM
	 fuww8dwrcN6WmYn4VBA0ak+NNTtuyaiuI8oAOcHU1lJqQZY0sY8F3FawIfwMY3XDT6
	 z7QAj/62kseMB483JxxBzMDK0mWnPhNjtMh/xGcvXPqZcaDHojcgwk1K5gb3CsH/5X
	 WMLkv3G8qbkad8pqVOBPmGAzlz6v+f4Rte9dexDGcbfTRdescapMvrruq8ovHAJhJP
	 NNvJE5WfpWgJA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/10] arm/twd: Remove clockevents shutdown call on offlining
Date: Thu, 17 Oct 2024 18:50:35 +0200
Message-ID: <20241017165041.6954-5-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017165041.6954-1-frederic@kernel.org>
References: <20241017165041.6954-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm/kernel/smp_twd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a2b0..42a3706e16a6 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -93,7 +93,6 @@ static void twd_timer_stop(void)
 {
 	struct clock_event_device *clk = raw_cpu_ptr(twd_evt);
 
-	twd_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
 
-- 
2.46.0


