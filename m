Return-Path: <linux-kernel+bounces-404567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67179C453A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0742838F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A381AB539;
	Mon, 11 Nov 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRYPpVyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE61AA788;
	Mon, 11 Nov 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350888; cv=none; b=p6tvhc8xW2yVrJ11vlLe6cjfjw5r47M3QJDvwn4qj1ZyXEiSi5lZSrdqKnjEP4bUiNrp0laH/FpWZuztNxa/4p2Ze+MlGizD5ZKcVOsCm3Ys2LaXw4f/uw1qGR7Mh9rOUZ66sfpruw2JEt3/9kNrRBxnYcnZwpew34LBWDKc5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350888; c=relaxed/simple;
	bh=fzuZds5l63O/35wZQk4QdpDVZpbfKI/IfiqOwle8YCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8qBLgNcLB25ksUA+zAvEjGnihhAd6KzUSrJqK/UM9N8B+HBdCyA9+svtWzlKIHXinnir39+nBq9xouGnbUb71frdiCiTh0wLgzCzbB9LnephRyQxLW0o3eTsEptWed44erYNbn9mbb5GAqjjDZgQkDTxP8DxI8hHpdU5GnnbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRYPpVyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B37C4CED4;
	Mon, 11 Nov 2024 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350887;
	bh=fzuZds5l63O/35wZQk4QdpDVZpbfKI/IfiqOwle8YCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YRYPpVynY3JhstfPC92DDvg2AR/o+7gwL5VBogjAbHlA5RA/dwjABxcDTMhXuoQGM
	 u2Ed5NUy7IJNkop/BScRZG4ULPhvtlPl5J7CnqWzL/yQY5omnzz87Yc2UGgWN/5vwg
	 rMasYJx6p6BlpbRV4v8/PW0fB4j4uaHxsYCkZ5H38AHA0a0KmtVUGzGA8tcbEyS57E
	 bY52+6YGK/pamxS9f8qq/DHu0Ez/JKGGtxuZ94Ti03dUFeFy89ygumnVd1I4VUbr4q
	 YfEb6J5yQa2QLA0Y1amuieCMhr4B2Rm+tV8qDr+DCwV68hyTMUWPXBqn2F8uI/EBsg
	 dI/ZDsb6X/6kw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:33 +0000
Subject: [PATCH 01/17] ASoC: max98088: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-1-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fzuZds5l63O/35wZQk4QdpDVZpbfKI/IfiqOwle8YCs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFYPEBRPKygLxSOjRklQz21v2wLSsuPHSG4L
 9ZOrNSQEtqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRWAAKCRAk1otyXVSH
 0BnWB/kBgml3U6ok4mRKSSvrpPPvukqFHYsOYLy5s6bDk4YBBQIGoMfhTWlWdKGV9E4AjBw2hRj
 Wa/g0gkJVAr9VPgItNDHWTJKtCwydrs6OXTmd+sSgelp+SqPBkcuPx/U7A6dJNbQqsPuwBU4mG1
 rtpp5cB5zgYTWZS8wNLbilU/bC8UNzP1MnGyyC0zu99ThqS8sZgavukWFNwZvjRgGG7EH6almEx
 Uwnrqgd52dHabg7TIbT3dxUbWtWvYfltneep1iWv85Wbxakn74MAHDd6xFKDsa6PnTluzhlehrE
 0X/IUqO6jRljCZqHkQU8K+e2mSiw8RS7Wy8PGJKX2rGAZuTq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98088.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 8b0645c63462070d6d584c7d43d96d21f3dd6cfb..4fa47347111247dc74a90b531dfbe3c19e36dc59 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -301,7 +301,7 @@ static const struct regmap_config max98088_regmap = {
 
 	.reg_defaults = max98088_reg,
 	.num_reg_defaults = ARRAY_SIZE(max98088_reg),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /*

-- 
2.39.5


