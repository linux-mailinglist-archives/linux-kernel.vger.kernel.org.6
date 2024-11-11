Return-Path: <linux-kernel+bounces-404577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7D9C454F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6C3B25DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F91C1AD4;
	Mon, 11 Nov 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9dbJD0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5291BF7E0;
	Mon, 11 Nov 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350902; cv=none; b=eYiqkys+UtEAlgT9QQYJzS499dgXQ3yJCFFGZDJia135NONDBn89VWqK7hzoXJ+GkUd850BtPz7rE8mT6xd5Qdk+Y+u5KXmgQQNc6jCi4DQw9OSz3rd/DZGCE1jbu/IN0S69iG9iBBmq1l2d1jcfopIjGiZUxdfFxsRjoCGAW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350902; c=relaxed/simple;
	bh=uzhxmJpVGGFBF8MrG+YMDo8tJY44qTxsuHA5JeVZ03k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbtOl/z3gOfdKEi1LY5Rc3XmWMFbw3PLEPODhMLXT8mZwR1RrR3G6jKfkuOVidjGVI1bVDd7VcsgE8IH2lqoatpFdShRvb7NHhC6xu8n4db4bh0phnKduKrwMerbxmeH+Msn+dWMn+hpZ35iwI97kUPqttk2PbbIhVItf9j4clI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9dbJD0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59E8C4CECF;
	Mon, 11 Nov 2024 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350901;
	bh=uzhxmJpVGGFBF8MrG+YMDo8tJY44qTxsuHA5JeVZ03k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N9dbJD0NNVkTXTzPTL4iz4E4s9mN7uRXQLpCI81QugEAAEq5cGsBSGpMvXexsU/PB
	 WybClSDDW7k4TRYkETuYkSWzaVinsiuEBTka2HKfcMFi9qQPuDqqivlCK+B85Jaudc
	 LC+U643jgCVIu7oYO4zrfhB9IMORTdgLD1V23Lx59R8q3GBWFepF0MGQl5NddWxfBx
	 bfjkYm/X0fYYMZCZXQbZYHisSyNdhq5FLxJA3mJhpdjYmdrLEvmnsX+2JrVCvI77mm
	 ZqqDiRgyVkLgrdmBFS2bWl6A4yf82eCqIN4qbg7PZ9PGfvhug713PIK6XxXaPDWnUO
	 wiwgJ4qjtE++A==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:43 +0000
Subject: [PATCH 11/17] ASoC: max98520: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-11-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uzhxmJpVGGFBF8MrG+YMDo8tJY44qTxsuHA5JeVZ03k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFfiPPFFgMTqXlsCRgbECYgiiaPgSKRxBEOB
 TSTUF1v0F+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRXwAKCRAk1otyXVSH
 0BmPB/0dKtrfDc9cZzenF0MqgjbK8yiOZfrE7qo34w2yZnzRtVY+g548TBY3QOxmDk4PYbPemK+
 LRdwPW4V36RKzEomsKN9a2nsGkK+29HGsheqa8t5Grw6HNSi5v/1LOoUjmQLV8OExZt6xOeNyaP
 fAap1Ejy8No9/CfUqGEsTDAk1DEi1mLOxmfy29iRauN2AXkABAh3CmP29P4agP2cZCDgnlRvc8d
 gYACD0VKa81AO3tKFXskyA7g8fp+hJSFWGBtMOX3uD1Npa3+r5u//xMNmf9uITXnozkTURt5AgL
 KDX3FNpHz06sp2BzsbPh5PMJt49gcMMWkJ3GOdAmqay4vGTi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98520.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98520.c b/sound/soc/codecs/max98520.c
index 479ded22672ecf0b9095c5da235d52917af4eaec..67166fa5453a3ee3f0f1d47c55bccf9f5f6502b5 100644
--- a/sound/soc/codecs/max98520.c
+++ b/sound/soc/codecs/max98520.c
@@ -665,7 +665,7 @@ static const struct regmap_config max98520_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98520_reg),
 	.readable_reg = max98520_readable_register,
 	.volatile_reg = max98520_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static void max98520_power_on(struct max98520_priv *max98520, bool poweron)

-- 
2.39.5


