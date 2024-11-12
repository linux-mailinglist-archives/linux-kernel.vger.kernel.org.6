Return-Path: <linux-kernel+bounces-405860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774E19C5839
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5900284731
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C1158D9C;
	Tue, 12 Nov 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="e+MHcSui"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9415665D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731415620; cv=none; b=UztVVTdPb+IwBeeFADujS+wNnSIjdS/2pUAxIk+VLj6SDAgSCqBk1MTpYH6TDUmB7w8JpvTWxer9MMKR8bmsf4s7xNn49nSeKT6+PCyl2hKZGxd7V4RyM//1LuvFjm7ppdUmnv90tbyn/RehQr4Z0cvaFXUCvygKZ1OOqZQM7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731415620; c=relaxed/simple;
	bh=0/aZPMK5piXN5Joa3ZKspiM/u0wAyb3Ir/ZZZpZ9DcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7SVML4O6f99dfZL1k/7dLfs4QYyGWeTVFJMcX6MFTQAJEBLwMP/01fSMSzu+NSdoe2XCy7YPDRyCqf/F7DMTSIkmkoSSxUaLtHhn5xO5BGbnSHvlOfi6DkYQShjhfby9wQ3bdNtGeF8r3+gzKk22lfmSok07C+WltjgCkgX+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=e+MHcSui; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731415616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3reXWz7HFkL+BhofFSbk2jiGd2SMoyu6cDW1cYgWG/s=;
	b=e+MHcSui590+tGpHh1FcQDw0OghUMcJSDQtFTOIEcJ1ifYXOTcqCm2cLLdyhoyX5JxN/Kb
	l1B51T+Q1XBxzbHFf12B62yNYwdyJanDyzzUc6uzJ69Uail6+9A62OKNtuxZQWyQ6ePs9X
	uDtra4+r+/NYzglExFAHZT6eDfDP/j77U10276X4cUbJcTaZSNmF8CFu56rf1lwTdIZoUF
	TS3wkWeAElfoCsDfL+qAHl+Bx8Nbn2xgKxwZ24dwBFcbiUnCBVPbR3QNgp8d7FegtkVPP/
	DOz5IEwFurvsDLWZ24aT+JSJwOtzjDvenDR9yoif3vo/Ybjhptq4dNnoPHJQ3A==
To: lee@kernel.org,
	wens@csie.org
Cc: linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] mfd: axp20x: Use devm_register_power_off_handler()
Date: Tue, 12 Nov 2024 13:46:47 +0100
Message-Id: <ab1f059f4b5bef75da3d3903d0fbf28bddffd57c.1731415409.git.dsimic@manjaro.org>
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
 drivers/mfd/axp20x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 4051551757f2..2005d4291332 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1429,10 +1429,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 	}
 
 	if (axp20x->variant != AXP288_ID)
-		devm_register_sys_off_handler(axp20x->dev,
-					      SYS_OFF_MODE_POWER_OFF,
-					      SYS_OFF_PRIO_DEFAULT,
-					      axp20x_power_off, axp20x);
+		devm_register_power_off_handler(axp20x->dev, axp20x_power_off, axp20x);
 
 	dev_info(axp20x->dev, "AXP20X driver loaded\n");
 

