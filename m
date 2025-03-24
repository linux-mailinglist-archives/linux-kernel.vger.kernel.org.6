Return-Path: <linux-kernel+bounces-574501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7CA6E606
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B057171F34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8F195985;
	Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5J3o8rG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F151F3FEE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853389; cv=none; b=hk5oYsbqjWKBdQh71muEIxbDSaQwf18W4yG057Nj7RvRkkp5TX1He6F/ldn/FWdBP5Xx78j/QqBWGPdLKBnjcZPzVSv7aZ3upT769ZVvecsstBSl7ve9Qg/5BI+lP0fgRi0yy4sc45AiuYqJBr/Xr07lYHXn7s5lMnxT+2teI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853389; c=relaxed/simple;
	bh=SMqJ/mdxDUlaT7sCHuMQcldNMFe2OQbR1k57sPHhsYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUGIGPS8CPJU0TKT7KJvisIJDBxW+fk8Yur04o9G9KOR8czC/N++M1Lk15JN+i8ApICtZqzptTA6nu04kwwG9IS/n6RQnSzEwSTwJ7MNFGcnFTAjm8YIAW8gJ+OMjDKMfel/v899uPX04kO0PElQVoyY2Xicd7MABirr9CSPhww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5J3o8rG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88179C4CEE4;
	Mon, 24 Mar 2025 21:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853388;
	bh=SMqJ/mdxDUlaT7sCHuMQcldNMFe2OQbR1k57sPHhsYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5J3o8rGqRFbhzpVB+HSQSUCd+LB8+GKgriCJ76BHS8VJyVHtfzRGlmom1lo+Cv3q
	 RYVvKq/Pm5hBYgYRyIYna+qnuxgXbVVL5+5/mVXWvnesZdHRAxOMxuv+Au8js02H3f
	 u2AVOoWIsvEugOE1Lt4Nd4zH8jL06Xvi5kD87dHbCHlrskBZhinxkhxUBPSMmLHqn3
	 +9Lnp1xAeX1nD01n83RFuNR4VBkcicqPlvLA62EYaEflmT1f0FdcTfN06kC6LoFqDg
	 0RA1r7PYP+Xqg00hYtBavMcWVM0vAmyAUG+h+AgXEKa5CHj5TUtUqx32FUCjtF9i4+
	 biNIBhtBFYmmQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 16/22] media: dib8000: Prevent divide-by-zero in dib8000_set_dds()
Date: Mon, 24 Mar 2025 14:56:06 -0700
Message-ID: <bd1d504d930ae3f073b1e071bcf62cae7708773c.1742852847.git.jpoimboe@kernel.org>
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

If dib8000_set_dds()'s call to dib8000_read32() returns zero, the result
is a divide-by-zero.  Prevent that from happening.

Fixes the following warning with an UBSAN kernel:

  drivers/media/dvb-frontends/dib8000.o: warning: objtool: dib8000_tune() falls through to next function dib8096p_cfg_DibRx()

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Fixes: 173a64cb3fcf ("[media] dib8000: enhancement")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202503210602.fvH5DO1i-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/media/dvb-frontends/dib8000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index 2f5165918163..cfe59c3255f7 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2701,8 +2701,11 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 	u8 ratio;
 
 	if (state->revision == 0x8090) {
+		u32 internal = dib8000_read32(state, 23) / 1000;
+
 		ratio = 4;
-		unit_khz_dds_val = (1<<26) / (dib8000_read32(state, 23) / 1000);
+
+		unit_khz_dds_val = (1<<26) / (internal ?: 1);
 		if (offset_khz < 0)
 			dds = (1 << 26) - (abs_offset_khz * unit_khz_dds_val);
 		else
-- 
2.48.1


