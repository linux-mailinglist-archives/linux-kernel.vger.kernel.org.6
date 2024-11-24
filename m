Return-Path: <linux-kernel+bounces-419951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B59D74CE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334F9C03623
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45122C5C3;
	Sun, 24 Nov 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFCZIQNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C021E104C;
	Sun, 24 Nov 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456204; cv=none; b=pelhrzvyvYd/K5cLhJsCohhOKUznmuI0bT0nXTQ6uGFPyG9Q8F3jY3ChfHYRWgFBID+zPLZcWTlw24q9zUpXpceg/uGccqpOVJ+gQkNLmLaXtQaQJty7IoCsLdRGb1Irxmwrgu9jOqAWxfrC1y0raaz1MbAJKfKObfhIoY7S2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456204; c=relaxed/simple;
	bh=hOp+3hnTUmq5KtXdBGWHnNkR7+OMzmecAlimsq/dwBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anSjgMI6c/Psc6SfZwsb/pRN3Nt0Qmb2rlOv4xZYxXvAi3D0yLzqXF+yA442P38QpiGhy43D4CFsfyrDmmBtO4IrsQcspQyijOwc9Q44V1To2V7cHxTZFltgii2yf5WADyvAEeUiQUlKiimvlffP8Tg3fpX+BYIKRMf1yyOWgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFCZIQNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BA0C4CECC;
	Sun, 24 Nov 2024 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456204;
	bh=hOp+3hnTUmq5KtXdBGWHnNkR7+OMzmecAlimsq/dwBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFCZIQNPvHnyj8zcmCl+uNnmu8uiDGSJnXQjCTGT8sAwfQfbjV6vrnQP6R/JBC+C2
	 BXwSLspLvF9imyvb6VmGw7lKT1+avspqfP+aidFGJeZGCIjOc97jbVc6dd96Xre6/Q
	 wr8YlCZQSBc/1K9lwzkdGH/23h9htNQ2Wbegk+o6lah4z36tg0kx3fiRbXZB07EYre
	 XWG4xDBy1rWTJREVPM9y9Fb8b2q3g/XGwit4QEk/E/wioQOTFSbNWLni3a6Zk7kq/k
	 1IK/nRGRqRieA1ts8zWIdqtxGwsu1pmhLoeNL4htr+fe/WJ47dCfQye9Qyy1ZUHXIN
	 VElYKhOuJhnhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 07/48] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:48:30 -0500
Message-ID: <20241124134950.3348099-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 8a16b5cdae26207ff4c22834559384ad3d7bc970 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902113320.903147-4-liaochen4@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 1c4482ad507d9..78bdfd855d11b 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -468,6 +468,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


