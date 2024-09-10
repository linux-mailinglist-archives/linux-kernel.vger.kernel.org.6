Return-Path: <linux-kernel+bounces-323579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41E973F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751DB1F2A658
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9971BBBD5;
	Tue, 10 Sep 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osUJv7pE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F71BAECA;
	Tue, 10 Sep 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988995; cv=none; b=YmG+U3ZCBoC71pWPHtwE7VViTpLfOcr1ueOdiKhPdtwYE+zBqflHj+HTEXJQL7KBbsfOSecEs/6Zytk+hqTvRRcWNb21dS2BK/5giB7xARckR66QXdWmJsZuoQx/XftI6QighIAcwgjPZJs+woOuyiSJkL4Ip6EJVrYW0XbmZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988995; c=relaxed/simple;
	bh=VZHOWKabHNgeKbkC8OGTVZ9kgKI2uaQEWjQehB8zWfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nodAOtoA0Ojnj3qCHtCmBRj2Pp4rJ5Vvbg0XP+lv8ZOzuEkCQWK3R1wmrkbubb7Wow9rYQu2hLYV50d8gsJTlPHGdIWcsiif96pgkJJdshnH2Aq8Wufon1vvMyth6JwNQ2rm/tWRDky34YSHifCxmNTO+pSSJWDpHrvRGeW3BFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osUJv7pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89093C4CEC3;
	Tue, 10 Sep 2024 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988994;
	bh=VZHOWKabHNgeKbkC8OGTVZ9kgKI2uaQEWjQehB8zWfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osUJv7pEaC+FzW/vXLyuexqAobJFbZ53aGJlwizvCoFk1/r0BRfVqPBKsDuM15Yl2
	 Jjf5N4bR5xoB2GK+V5cTQ1Utr+/zp7EHtju1RrmdVHm0p+9m6Wc6kycCDrA8SuaWXG
	 AjI78asvqskkHziHDX+jmAdika9jthMIgmdqLKvcHky8qFSB64Y7YdnAzmXjzvb7t/
	 6CdQVRocOfsVuzFgL0DQEHI3gi1MNB0vhDAY95FuhCEr8DpSlw710kD3wUCb66JsNJ
	 sEUaOfQdQ9f49Cw0B/yweiAyF/BaMnOh4HxPeluHp1qPG2SDKq8FOwyVjbOOhHrsGj
	 oawPYYoIvtQrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/12] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:22:47 -0400
Message-ID: <20240910172301.2415973-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 934b44589da9aa300201a00fe139c5c54f421563 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-4-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tda7419.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index e187d74a1737..3914deb060ca 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -623,6 +623,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
-- 
2.43.0


