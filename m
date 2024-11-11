Return-Path: <linux-kernel+bounces-404566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD279C4597
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BC0B247C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9819B3F9;
	Mon, 11 Nov 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfGlCXcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F214AD3F;
	Mon, 11 Nov 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350886; cv=none; b=NHln36MUTsf27oT5aIrmDnCUEmEukiV69DjcXKBVKv2Pn0G6Q2N2dwMXiIUvPYs21gFDNkXykRjLGdz81Bwc4NzWNz9O4veke/8at0OmbUOT9gyekr27HFILOlKSzFPStwJqEjN/XfgtFtMaj9UF7yjNFSVCzdio/A1WpTDjCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350886; c=relaxed/simple;
	bh=EtuMHL3/DLNa8FkUzMzR2zBOQPr2/uCcVvYj9VpDX0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mnrvGGJHsKlku8axK+yJTnwsNnHket888dH7R4Q+AwEKZbYrgbG615jFLmT6EbZoKWiC+4dBzDpOxHnVzej+N0PlZp6s8r5QwGPwMHRpJzkS/6W4IMO1B5c07cbq6KEG3NjdoIzsSan4stDkah9YWJ2nyQRmeSmr3jM2G5Ti8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfGlCXcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9DEC4CECF;
	Mon, 11 Nov 2024 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350886;
	bh=EtuMHL3/DLNa8FkUzMzR2zBOQPr2/uCcVvYj9VpDX0o=;
	h=From:Subject:Date:To:Cc:From;
	b=HfGlCXcg7/Z6DrO4jQ+GqrJuwh3bKRLs0ZnuD9hcd0On22DkSnY8HcOFyhPEq4Jv/
	 RK0T9V9TtFy3GzUYAFPfCbngNZhRSIe2jWBt+IIUL7RdQ/ncVT6f5i5wPuCcvGjLTV
	 IxHO4XgrxYA+Xog1ktQVnh4sFCUSa8lNQG9QWrVRPkMKpZVY/jXH4HDxAKGUYtmsGp
	 dhEUxUwDy6XqYOc+UK4Vn/L3t6B1rW6jRTMW6UU1E34k+eoqGtVpPC9Zha6tJtfgdw
	 AI2cAQUZBcwkOr8AikTGlbHnM5O2FvJTp0Iu9e2o3iGfzYVwDJ1HDs8XhF01KvAa1t
	 F5EdwwCyb/1vQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 00/17] ASoC: maxim: Convert to use maple tree caches
Date: Mon, 11 Nov 2024 18:47:32 +0000
Message-Id: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERRMmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINBNLM5P1s1NrMjMBZIFOam6icYmaabmZsapFomWSkBtBUWpaZkVYCO
 jY2trARrWUYtiAAAA
X-Change-ID: 20241111-asoc-maxim-maple-a34f5763e8a9
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EtuMHL3/DLNa8FkUzMzR2zBOQPr2/uCcVvYj9VpDX0o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFXedEgXvK17+Josa3z449525kpVrFJkz9gQ
 iu72el3nymJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRVwAKCRAk1otyXVSH
 0CfqB/9L1lWAtkc2geX2PucCtcg5z8mT9dORiIH3GsDtGXhzw7EI+DdaztdHWW0fwHyKrAMHQhr
 /R2qyMCzgLZDInfngvwoK+oQ/ihDSzWNLvciFapnMYEUbT9oeGGd9ewWKxfXvmcA5uYmxUJA89w
 7tGNKnsxV6gu+4c/yJFeqOJKncQLl0F8c5+KTWcUQo4eATZK4QcA3aw+qBqcu6mFi8nAu9OvgtL
 O0uO2M06Drj5aVsUq4ydvVhSv5vDBYDDdchSLuQDO/WDcfrInJ0WwkR/gYdEom73yfukCs7bZ09
 QssN9JYjGBEnv5zXof8oNuIEpS/dE8qS2KhNTydu6IOX1uo2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

A big batch of updates to convert the Maxim CODEC drivers to the more
modern maple tree register cache.

max9768 has been left as it has 2 bits of register address and therefore
is a good candiate for rbtree.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (17):
      ASoC: max98088: Use maple tree register cache
      ASoC: max98095: Use maple tree register cache
      ASoC: max98095: Use maple tree register cache
      ASoC: max98363: Use maple tree register cache
      ASoC: max98371: Use maple tree register cache
      ASoC: max98373: Use maple tree register cache
      ASoC: max98388: Use maple tree register cache
      ASoC: max98390: Use maple tree register cache
      ASoC: max98396: Use maple tree register cache
      ASoC: max98504: Use maple tree register cache
      ASoC: max98520: Use maple tree register cache
      ASoC: max9860: Use maple tree register cache
      ASoC: max9867: Use maple tree register cache
      ASoC: max9877: Use maple tree register cache
      ASoC: max98925: Use maple tree register cache
      ASoC: max98926: Use maple tree register cache
      ASoC: max98927: Use maple tree register cache

 sound/soc/codecs/max98088.c     | 2 +-
 sound/soc/codecs/max98090.c     | 2 +-
 sound/soc/codecs/max98095.c     | 2 +-
 sound/soc/codecs/max98363.c     | 2 +-
 sound/soc/codecs/max98371.c     | 2 +-
 sound/soc/codecs/max98373-i2c.c | 2 +-
 sound/soc/codecs/max98373-sdw.c | 2 +-
 sound/soc/codecs/max98388.c     | 2 +-
 sound/soc/codecs/max98390.c     | 2 +-
 sound/soc/codecs/max98396.c     | 4 ++--
 sound/soc/codecs/max9850.c      | 2 +-
 sound/soc/codecs/max98504.c     | 2 +-
 sound/soc/codecs/max98520.c     | 2 +-
 sound/soc/codecs/max9860.c      | 2 +-
 sound/soc/codecs/max9867.c      | 2 +-
 sound/soc/codecs/max9877.c      | 2 +-
 sound/soc/codecs/max98925.c     | 2 +-
 sound/soc/codecs/max98926.c     | 2 +-
 sound/soc/codecs/max98927.c     | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241111-asoc-maxim-maple-a34f5763e8a9

Best regards,
-- 
Mark Brown <broonie@kernel.org>


