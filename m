Return-Path: <linux-kernel+bounces-405861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17729C583A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482DB1F22D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1715A858;
	Tue, 12 Nov 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sd+R4R4x"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F3157E99
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415620; cv=none; b=AkdclC8gyISj2aQAwr4VehnDP39qjIh1bFYJNZueojYUXiRaAQI7u846Bm/qfs/bBVsyAlspIZ6mV/zPUocOgLk9Q/v5lLe1BY3MQDl5yTXfRRZk2vD5/F/p8OS79z3Q99yuPf20OvXVdiDUTdbfACqnhgNgPlhBP4Dh0cZuq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415620; c=relaxed/simple;
	bh=mTIuBHDtMDhcOZyTGY2hUzmuvgccOGQdsMV9XXiNuXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfwDXY/658NmlELfoEgW7fut75fnmITE8HMJY9ZBWnGqoIBe34EQDZ7TKpPPuJEoFv+88pEvPEAlDraFFk0AFGOtRNZxaKV1SRAb3KHZgs+NPUVeEfTyX0+5HGz49bLAHtDrpLBjU27V2tJhoN6zTsH/CrPLu4vtoqnlVH9g5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sd+R4R4x; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731415617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qM10d3IH9VrxILc/DbYNXlNEfOGEP8rjVSaajjLDWy0=;
	b=sd+R4R4xfC/2Bw9zssH5rPFu1cKl7G2R9r8jDRfTdvnX+gc6rH0/D1bd9ULhMiehMMYm0g
	YjsZuiDxPSTOQFnX7AbMK3Cqzoumn5jKmlc39CDu5iEFaznmN5JtbBhgjzblrgSHNbnWZC
	ZrqrcVs63445Np4WYoequz4wwsxgbXRf6zWlgwdJCaTfyUzomkue3pBOg1fZ956YuQP3rD
	bRpAe6dge97WpFxhPldyQKFc193UvY2RoV4YTLPwQxJxKpT5YM0RDzwaiLrPbtav3EvfJP
	EkPuFlIBQVFPpthDAis5km1YmvuS4CtebRUJBVBaO6fuPoWWx9B08A+493zPFA==
To: lee@kernel.org,
	wens@csie.org
Cc: linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] mfd: stpmic1: Use devm_register_power_off_handler()
Date: Tue, 12 Nov 2024 13:46:48 +0100
Message-Id: <219e0de8bcd1b2ef24142c837d8331ffc535ab26.1731415409.git.dsimic@manjaro.org>
In-Reply-To: <cover.1731415409.git.dsimic@manjaro.org>
References: <cover.1731415409.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Simplify the code a bit by using devm_register_power_off_handler(), which is
a purpose-specific wrapper for devm_register_sys_off_handler().  No intended
functional changes are introduced.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/mfd/stpmic1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index d8a603d95aa6..081827bc0596 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -170,11 +170,7 @@ static int stpmic1_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	ret = devm_register_sys_off_handler(ddata->dev,
-					    SYS_OFF_MODE_POWER_OFF,
-					    SYS_OFF_PRIO_DEFAULT,
-					    stpmic1_power_off,
-					    ddata);
+	ret = devm_register_power_off_handler(ddata->dev, stpmic1_power_off, ddata);
 	if (ret) {
 		dev_err(ddata->dev, "failed to register sys-off handler: %d\n", ret);
 		return ret;

