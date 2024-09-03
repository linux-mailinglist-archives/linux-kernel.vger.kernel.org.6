Return-Path: <linux-kernel+bounces-313709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEBF96A8E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C44282444
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849AA1E00A3;
	Tue,  3 Sep 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CondBZaC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F731E0089;
	Tue,  3 Sep 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396232; cv=none; b=FGrfOPa6qoFDpi9SrCTAbJRjK9hiCTbv0Qrk98G5BwCGIBJkhMi3StzLYqARt5ozyvCdosDW49rjP72P0i6u9l/jnZADSUDf4sv7FizLXifNSb60QIMXOQE09kTajRWMBSE3gLI7b6b48ArgWqJtELSVOFJ8k+vjSrTrU3Gl/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396232; c=relaxed/simple;
	bh=xkjJAkRtdjadOygJ/vhfSHZytLz50swBJbt7HL4EALc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAJyuhSBkQ91QO+/8Lri+huBl8NWh5ioL0K3qdTGrEtP5IWBeRYHzg15xGa7IXGQcBXynP/SQX50fubssITpmmNg0GhvF9AyshjfYbhJzEVKtKi52gRv9TjqGLK6RzqddrxD183usBA8VE7HLpADFaUuzE4wD1NNXNvHJdTyO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CondBZaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A1C4CEC4;
	Tue,  3 Sep 2024 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396232;
	bh=xkjJAkRtdjadOygJ/vhfSHZytLz50swBJbt7HL4EALc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CondBZaCIzFdwHJXvJlEMrs+BXQJ9xjXAgKPGvzxr7uDG1aVw1JARIxdFb0VRpI2M
	 8S1rQT1ytjsmS5FWfEyhKOGhzJ7b1/YGrgO0/y4TkaTQJjgwoiwKKCs5BnQH3vuXfA
	 HVCgYq10Sd9j/d+o5HbzE0sK3I5BVl1pRTkjZrg8+w9iBWOOE+eJVwjn2WhmQEJTgO
	 qbZolelnGOh/5buYq23+W6KHTI0ALbnOEFN6fxeS0dDPSVpJeDhkTHq3xZZe2E2Emh
	 bX03vdfvkEAcdjJgvWP1tmttXiyj6/E9WHIMEEfpP+B+kTdcC3pWP8m9l9LPgZGagj
	 UFS9v4+d1K4Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	cristian.ciocaltea@collabora.com,
	emil.velikov@collabora.com,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/20] ASoC: allow module autoloading for table board_ids
Date: Tue,  3 Sep 2024 15:23:36 -0400
Message-ID: <20240903192425.1107562-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 5f7c98b7519a3a847d9182bd99d57ea250032ca1 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-3-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sof-mach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 354d0fc55299b..0c5254c52b794 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -162,6 +162,8 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
+
 static struct platform_driver acp_asoc_audio = {
 	.driver = {
 		.name = "sof_mach",
-- 
2.43.0


