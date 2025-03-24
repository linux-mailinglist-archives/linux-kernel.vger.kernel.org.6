Return-Path: <linux-kernel+bounces-574505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31515A6E60C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC469175C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BE1F4E27;
	Mon, 24 Mar 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzHRw7h9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7B1F463F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853391; cv=none; b=VGWIJ1o9tpHdn/2HEIPDJwTRb8LN9K74vhJBVSoH8JXQtGQsQDPQ3P15ItZGXhX8AQVtOeu5rMbm/IpLkHAB/97RwBLmpdwA93f6Cd0PkvpMa8eR/tkExLfvzIfrQFhKvT+I0L+YanQVs8UlltSIihHaqEsagAh6ajxSfcMxWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853391; c=relaxed/simple;
	bh=VuFv/fY2c3UlfJj7TY8YR+/Rbs1bTh9wtoJHKV3Knvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFrpDytYFeyo4GXf///gJ1ONmTv430d6JIrPj4cljmTVQHKAWvFbac2QLPFwZslhmiuDyLBGpxk5CWuXbW4BYyEg2a6UzZoTODUeR9t8Q05RIGtV2C8Ajs3wzZm+Tmn5idfZ2b0ftKU/XwUus4zE/bzPDBN/DImJOAQhT2ExJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzHRw7h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA98C4CEDD;
	Mon, 24 Mar 2025 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853390;
	bh=VuFv/fY2c3UlfJj7TY8YR+/Rbs1bTh9wtoJHKV3Knvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzHRw7h9DEffgGb2+gjZPoAsWfRzuI7qW4TckHNnIevjvI63ZaGceqKv+usxAFgyR
	 tQtiT6tJkdsl4HmaM7h4CEdhgsCMzqVlIgrqbUq1YRM5gEdbGZqhZiQuiC4e1smqkv
	 s655MCWZd/we2fpHsjRg9t1QsFqyeTJQGge6EXjU12iirFmWFq01klEKMcBMyQI6iA
	 R/nWAfROnD4IVlGCI6WLxyH5O9cwf5c9Q3CEnyU4erCI7RgDddx0QO7vJnxgWmcKBU
	 LKBbsoCKgvt5cUWz19zrYGHvnkS5AdiLn3OZj67IFAEqOF5YsJMXMnK9yQUFVD7Gci
	 om+l9XcvXA0og==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 20/22] regulator: rk808: Remove undefined behavior in rk806_set_mode_dcdc()
Date: Mon, 24 Mar 2025 14:56:10 -0700
Message-ID: <2023abcddf3f524ba478d64339996f25dc4097d2.1742852847.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ctr_bit is negative, the shift counts become negative, causing a
shift of bounds and undefined behavior.

Presumably that's not possible in normal operation, but the code
generation isn't optimal.  And undefined behavior should be avoided
regardless.

Improve code generation and remove the undefined behavior by converting
the signed variables to unsigned.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: rk806_set_mode_dcdc() falls through to next function rk806_get_mode_dcdc()
  vmlinux.o: warning: objtool: .text.rk806_set_mode_dcdc: unexpected end of section

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503182350.52KeHGD4-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 7d82bd1b36df..1e8142479656 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -270,8 +270,8 @@ static const unsigned int rk817_buck1_4_ramp_table[] = {
 
 static int rk806_set_mode_dcdc(struct regulator_dev *rdev, unsigned int mode)
 {
-	int rid = rdev_get_id(rdev);
-	int ctr_bit, reg;
+	unsigned int rid = rdev_get_id(rdev);
+	unsigned int ctr_bit, reg;
 
 	reg = RK806_POWER_FPWM_EN0 + rid / 8;
 	ctr_bit = rid % 8;
-- 
2.48.1


