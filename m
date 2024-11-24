Return-Path: <linux-kernel+bounces-419670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1CA9D7098
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8181282BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D721AF0C4;
	Sun, 24 Nov 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHoBvJUT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E01AF0AE;
	Sun, 24 Nov 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455209; cv=none; b=QC/Nc6Osz6CtmoosO5Dh9wTrO8JJHkFQaG4R1QcTNKTmj44ol3+MhdNj6cJdxzaDhIP4AYfV1fKnKEVpylb//9YibcJGYxRs4QQEcEfP2+Mo+KM0cQfoOY4nDnYrvqJGD7n9YRtZdKxg04EELEVAjMELWdBm1nC5KcCq0laKUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455209; c=relaxed/simple;
	bh=oSIQvle1ew5pN7VwVsVScLef5rxVvT1ygF1+neTcx7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opIO2g0TXuO0HjTk3MSiUAYS4r4MwygUrX2HS0EiI8fB2f/UMjZTaLGxETfY0gmI5AU823TtkyhLBLBWgAlod2YqKXmAVAAHWE/jV8HCIiUCu0kthrWDsk2yFT5xJ4/YhMnt7rNRM+CuONhmQ3aPQrAjkFLnq8IRPEFOsvjGnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHoBvJUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F06DC4CED6;
	Sun, 24 Nov 2024 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455208;
	bh=oSIQvle1ew5pN7VwVsVScLef5rxVvT1ygF1+neTcx7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHoBvJUT3G+jqNHc73Nscf9xnD8CRtKjHo9WIwzjT4iO2WyTpPVNO4OqdiEiTmOr+
	 UmqbivQEdX7v6pTw6xBaJ7Tczxqx+/7E3+VXPEJyagbG3/gU71M+fivuMdOstvrdAT
	 5+vj8loSQMED5Aft1z8xU1KQQQUTsQ6BcYn/j7PK49ypJBiel6jVpc1LxhrzRVjHOf
	 iBdXzLEtV20b2QH7qAfIMEa4LKz+XGwPac+DbBLqacz3txG1G6PfpWI65fVxzT29y4
	 +3zTLYEneEzMmtOY7LLvJc3o7erGvMfdrONWqf+obD4vq3oEWDg5JR7+oNBuI7C5Fm
	 /i/lS+9zD8azg==
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
Subject: [PATCH AUTOSEL 6.12 014/107] drm/mcde: Enable module autoloading
Date: Sun, 24 Nov 2024 08:28:34 -0500
Message-ID: <20241124133301.3341829-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 10c06440c7e73..f1bb38f4e6734 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -473,6 +473,7 @@ static const struct of_device_id mcde_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mcde_of_match);
 
 static struct platform_driver mcde_driver = {
 	.driver = {
-- 
2.43.0


