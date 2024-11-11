Return-Path: <linux-kernel+bounces-404569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDD9C453E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0458283F32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C071B0F2B;
	Mon, 11 Nov 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvU0ytRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F081ADFE8;
	Mon, 11 Nov 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350891; cv=none; b=k/B1mjr8RQGZzhCF3D+bAATtlatGXW4/wwkvFxXwONlX8nrQxsFmGiasCO8nOhIfqW/fo8RcjaMLYiqj+BFnsWUm9T1GnG0+UvvNw5WcfEcoTH+We8fPFQwhKcLNDqgQe7097YN2Vlnw2WLpEMpEIpIqRpedF6XIcvscDuiOvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350891; c=relaxed/simple;
	bh=LORot0VvayhT+ehE0LyJo3cBiGvj959ER97bGj7zf6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtZipK0+wt2cuThsNWq9+XM6SJ6IAIgndMhsbXX4ihagBxstVthlKls8cOisUGlK9IJhsDR6YZV9gbGJUiy8Rywu9u+ZKpIPZVi0BDPFRd2Ywstd3KlziSEclaFCYM8JqDy0lOuIzTfkTnGC8k8oS5BBJD6r9xC+NoBQEivrZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvU0ytRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEEEC4CED5;
	Mon, 11 Nov 2024 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350890;
	bh=LORot0VvayhT+ehE0LyJo3cBiGvj959ER97bGj7zf6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rvU0ytRABdsO2cIRPM5/p6JbkE9djik47cWwvgTfPmy3yDSWgV9grPMEws1EQWW28
	 8diJfbdmsctdPTaK+o2qdrZ+Oj0XbbIYGooH2R042+GaRuVwLNrsuGi9Po+3HRoRgQ
	 sJFajBCJfyMN1jmcuOi1ZCuaolpyqki8y3tEVcozzcEnolGkQss0A7ng2C/gVqda1S
	 n5ksnXe0I1PdrKtU4LkJcDOX41qk+J2a05q/RecWKwSQH5mSwRzphWRODfXvgAJRlR
	 wHW4bj8clnYJ66b1KHq7lr/5EjvdiZvgyX80LHKqNC8jmKkWehBK0RLG9iTuJGG1k5
	 YmC8HzxAgkMiQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:35 +0000
Subject: [PATCH 03/17] ASoC: max98095: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-3-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LORot0VvayhT+ehE0LyJo3cBiGvj959ER97bGj7zf6w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFZpPP9SxN7a4yscYzFjGyoKPLcjGK0wHkOZ
 HiVebewIVeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRWQAKCRAk1otyXVSH
 0J+QB/4thGEwLTip9KtTcsxnd8XG95TdEpwRuyD0fB/WuioMl/7f14NU6f3Pd3M2m7TQgpmRKBY
 rVFwsLAhAXAKMXntuANxqJRr0lAfNAImPQKvsGtgW7Y35dWzah+FvRWkfEB2eQlJBNoYlC0sKfy
 PJ3kl/Y2U+0+PsvutR7z9QrQq7jJkNM/SzeF0Ep5PQyvalOhSZTpjtx5gs9yH9rLPvlZefAa0aX
 fSKu8wmFTU93HwNQ8Q9bA+eE2iMPSp6CgraO/mXSPS7PbhKs3bzEE3YRVjzEeyyx2jquXgSauMP
 nWj/eOyOBRDdMngyG9oh9Xl7szm6FHFBYUV3tCRfsbYVrWTA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98095.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 7e525d49328d2e2ddb21c60ad4af91a9f92ec4bd..6f492ba8ebb4e7c9a4c58e8c0ff091eef72103b1 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -238,7 +238,7 @@ static const struct regmap_config max98095_regmap = {
 	.reg_defaults = max98095_reg_def,
 	.num_reg_defaults = ARRAY_SIZE(max98095_reg_def),
 	.max_register = M98095_0FF_REV_ID,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.readable_reg = max98095_readable,
 	.writeable_reg = max98095_writeable,

-- 
2.39.5


