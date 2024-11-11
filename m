Return-Path: <linux-kernel+bounces-404573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291359C4542
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF042283F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1031BCA01;
	Mon, 11 Nov 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyVTdFj0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5D1BC092;
	Mon, 11 Nov 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350896; cv=none; b=j96q177swCMKXYgnQUCkvWdHvRyDirXmeDed4Aw0vDhy0d8blv1QHLP20cJ9jcsVN41HSHVPvZEM2SOpA1Nqu4SYikYuQilfc1Cb38yU1wz6iBx79K7QKsCdtZk2Prh5POb9b/RItr+rccFV61XEovMXkX7cWBDuEDktlkj2VxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350896; c=relaxed/simple;
	bh=PP/+OKSVvnjzzTEnchRnvRhBHJ5+IFY6W2VqU560TTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbYJZlAXyANDFn44k8D17d7fG9sQVvdZudlyCaUXndpBatqS16aZvLaEHSINqLaDnYzra4M2TV6Wq6Oio7nJ9iLgt5zaA/astdXanGgTcdYmMz3Oycu/x7cOvANds6jCbg6DHoDkiTiOH1gMObNup+ZN8jUX68lBBt4EkWwlqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyVTdFj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1256FC4CED7;
	Mon, 11 Nov 2024 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350896;
	bh=PP/+OKSVvnjzzTEnchRnvRhBHJ5+IFY6W2VqU560TTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jyVTdFj08bCHu5dSMNa58hzlmpcTDsbI91ByBtwCFe0go8OqDoiXiFFet6E5IHANh
	 1YFNYea+PRac7LrEnzFlMPpNhrmByErAy10rhHZGZXt2bK0lE4/PpTYKTFBs9bgJzh
	 NDq8k9euJO9Hje3YikDK+dKlt8uM56xKXfov1SC/cDEWwDb/6h5GraLhNPzBFyWQNX
	 t4fSdzA5wib24zu/+J1AwK6NS+WYimXed4FM4LZn2uLl1ZYxeAZQN1iz7YxffOlVdF
	 1MMfRtEKla2f8qNV+Ed+7+4qCQ76aIz4f3cmb5c9o0hsN8LI60QNAoUs+mGHiB4Vkx
	 Av994IGDLhXng==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:39 +0000
Subject: [PATCH 07/17] ASoC: max98388: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-7-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PP/+OKSVvnjzzTEnchRnvRhBHJ5+IFY6W2VqU560TTM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFckQMcm7/QDoEFXE4c3wRuYqkifeAFbv2PP
 ZpmBPpMCLeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRXAAKCRAk1otyXVSH
 0P44B/9Z4FPjIl5rlGxopCN/J0P7YI+t57kuWmv+BVvFB6YupB8R3DflqzYRYhL/fPl78/yLDEc
 YRhBokDA4/h1KvHBAReLbz3SWRaXqR8YOFn9opcKRbvVtGYwVou3VYkJKlgzhBovoQ0W7xnGk3Q
 K+xOqiB9trH3Rp1cbLNVzKFl2pTLPVz1jRgELo378kh3SfcYcbNGmspjdXm4X3DtbHtxNAXpazh
 UsQUhL9IETnHqLKn4yCkhwNSa6+JlrmU6b1hHoeFxKFly6/e/S7JaVgURDhNXPucUQpOvLB8Jjj
 gdMtxTRGRzQsqSdGR+rR3lblzTNpCWT1vvTxBJPnv3K1RVNl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98388.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index b847d7c59ec012778e3d2f44526e96b5210ec494..f05c8079ad36e77f5cee9213bea8f41481da6536 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -883,7 +883,7 @@ static const struct regmap_config max98388_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98388_reg),
 	.readable_reg = max98388_readable_register,
 	.volatile_reg = max98388_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct snd_soc_component_driver soc_codec_dev_max98388 = {

-- 
2.39.5


