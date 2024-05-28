Return-Path: <linux-kernel+bounces-191648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E1C8D11DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532C71C21A55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4476F066;
	Tue, 28 May 2024 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvMLMhg0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0D6E5FD;
	Tue, 28 May 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862761; cv=none; b=TI8AdSj9SkkfB6PGe7SvfRWM98fYZA5u+3sqiOeTmFp8aQk21nJnUXcF7cWDO9Cr/GUesoGlsScd3nnuqaTRf2udFIh5vfx21vgz++X4GAD2UKrgUgzTBlK4rsi1JeNs4vP1SSsCF7koulYUbPQhURNp9lRStjUSbBFzrEwKejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862761; c=relaxed/simple;
	bh=p22A/lXRFtR5eyOAnbBPalHf4A13ph1FqOaAKEvnv7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS/VL01yv7weIw5lKy8I6FjeR+/CQieJZCRTlPjW4JJSfnHl1KupK5rKpXp2cHaPmlZ3j2olftwEOjtnHAaU/YGsCqoNC7SIgnCJ4PeiBCCeOUso0XmlKrBVQvWJ5hVDsCCHoqhApO7FuoK7WqPyZAwqlKH3nk7qF8WpRPXPNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvMLMhg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD03C4AF08;
	Tue, 28 May 2024 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862760;
	bh=p22A/lXRFtR5eyOAnbBPalHf4A13ph1FqOaAKEvnv7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvMLMhg0oUXAlXx2inbCSK45ObtuuI+kkejemtlSdUSUVwUroxRO7bUOVdo2hKE48
	 3maCKZr6dKhDIhdiFO2uPSvhRoQ00hPYk1unQ2bYLvvAapDIDdaMFFxfiSxK67znMm
	 Di4/n9BrGlwU7Xxlom+J6aOs9Qad3ZsM5XPtGCblLf7F8ZQPTzEz7sdySVLwTIAoyT
	 xtR6RgqwmDpZACtTwM0K9qgOLSsr3DJiLtTfm3IlBkapvfln7y8QBI+0n/nWGl6HF2
	 AAdrW3KM34p8PwyUvMVSFsf44RtskOt25UDvoJGWrz5CFSzyBk8WPG2V7IQWjjakUd
	 40e0BXkr0zUSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.15 2/2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Mon, 27 May 2024 22:19:14 -0400
Message-ID: <20240528021915.3905424-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021915.3905424-1-sashal@kernel.org>
References: <20240528021915.3905424-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Aleksandr Aprelkov <aaprelkov@usergate.com>

[ Upstream commit 80fea979dd9d48d67c5b48d2f690c5da3e543ebd ]

If devm_add_action() returns -ENOMEM, then MSIs are allocated but not
not freed on teardown. Use devm_add_action_or_reset() instead to keep
the static analyser happy.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
Link: https://lore.kernel.org/r/20240403053759.643164-1-aaprelkov@usergate.com
[will: Tweak commit message, remove warning message]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 761cb657f2561..ec4c87095c6cd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3239,7 +3239,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.43.0


