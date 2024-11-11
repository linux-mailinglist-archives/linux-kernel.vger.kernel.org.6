Return-Path: <linux-kernel+bounces-404581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 465AA9C454A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24961F22726
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8711C7B67;
	Mon, 11 Nov 2024 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdQ+QLIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A151C75E2;
	Mon, 11 Nov 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350908; cv=none; b=lItdNtu2cTTGhVsYpit+N7Qn5ZxOYM7e1wT+kUtEQmNLkg9H6ex4gZ5EBU/SwgUvRSOcTIiuYWgG633p3r/x3Kcn9cyTPROeAtWpL5YKr56p/5TYfJVHlSa38pIF3U0bSxyf34CfhgN2xY8Sl+v3BiypqR5ouFTkZJis0b/3zTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350908; c=relaxed/simple;
	bh=VmKq34hofpsVB2gQvsAOT87ZBzY85i4d2Xl6NwYxCJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlPDJlnPEl2/IDfPuAr0A1n41YrXOBTbtbuYt1dxgGr8zD1iJzuh+MK+s4oItYlxe8WiHlvPJuvh268edr8fLPnlZ4o/5s/MikyOeiMGJRb3jF+PW/bR03CYHqSC/DHiI52bsyweTFO3ItmgW/+hXtfAqPnVB4GemgsbJnQz6f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdQ+QLIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71135C4CED4;
	Mon, 11 Nov 2024 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350907;
	bh=VmKq34hofpsVB2gQvsAOT87ZBzY85i4d2Xl6NwYxCJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HdQ+QLIbDJQ8FMn4IdDqeiZ2Ch1+nGlItcs4IVQ+iVLnpBmJ0POEiPo9+faMGAiif
	 Og9/S6Db3NgbTTsd+EmVGN+Ha4Xlc9qnOEoUIFw5VinzJcpwEyA3dmiuCM874LXnxr
	 rIYFOZket4mG4Rl/TxKujAuBfyAwplMOcylrver36jqzS7lPinM3Io4oT9QtD19eH6
	 AmGrMISoxXWuAap3YKQPHQCvqeblc1+rY0O3gFZnYABbiqemwvi8aOIglkPMZpyXWP
	 Uz9lx05z59CqTHfvyUZHToGIRniYF+fRxOeU7iAyZvtaaytRCibBP5Wie40k5JREaC
	 e8k09O1mDAaSA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:47 +0000
Subject: [PATCH 15/17] ASoC: max98925: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-15-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VmKq34hofpsVB2gQvsAOT87ZBzY85i4d2Xl6NwYxCJs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFie9srf3aY14XaaGfe8fA8hDoC0j731VIrX
 74gHLJZ7DOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRYgAKCRAk1otyXVSH
 0F9GB/9sS2DXF0aaNFDBNmwOV6dxtvW1xshR1ym6oE6qf8UP287nESEn4ldUbkLp15pqSSM0Qbd
 PVJtBbZWMGNe/ovO/xpGvjIfVSzeJ/ElEIXFFlZcGGVyucOrc4OYSRulHGTns2xqtGbdJ7f3WQ3
 5TJOJwXjRYkDSRxTQNji7efUzesF3ErpeMswsH55Dwji4eHtHKpHXdO7RmkmKZeptSqblmWcABT
 tP4oPymx3NW+RSzRg8RXB6Bjv/57DSkJyu7TIanmurdL57sKihJeIXXjV9B0KIUpYyR9DvoFq2j
 9b5DYx31jb5QVhAm0ifTQZ/x4gptlAYmOLdFg0cxJmpAvYLF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98925.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 66c78051bd09896c6973f24e16d83544f252d3c3..8a931cf840626dce7f8334461c95241cf4de042f 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -554,7 +554,7 @@ static const struct regmap_config max98925_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98925_reg),
 	.volatile_reg     = max98925_volatile_register,
 	.readable_reg     = max98925_readable_register,
-	.cache_type       = REGCACHE_RBTREE,
+	.cache_type       = REGCACHE_MAPLE,
 };
 
 static int max98925_i2c_probe(struct i2c_client *i2c)

-- 
2.39.5


