Return-Path: <linux-kernel+bounces-355403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44149951B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8292428169E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01841DE3AE;
	Tue,  8 Oct 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iCfmdhxJ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F81DE2A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397830; cv=none; b=W3PFXlfzRfakcF9bYKixlt24AQ7Ft1ECa8L5/NpPX7zHbUDWRDwW1BLWAdQI6kDwLD2JPhxYCJtfAHCpcGc/fGDg43pFjQSqEVZDadPKiwBJWQX0zQAzxbDeP3T8EZBPg03pFYfp9lJUAhYoiVRQpSfOjbztThqtYfsoRQxe1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397830; c=relaxed/simple;
	bh=f82uy+YFx5JMLDwgAU+VaNObbZ5MndEKgnbzqF9z/1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MyauVVrjP0VWhbOtQD2Byy/JylsUJWTciepEu4PqZl34HSoPvaTrUHSYngS5uin38o5T/1DvpP7nA84NbNpsmazPgBS1SmC0duckNe5XLtEjhNP/kL+AKNjmNkKNs+oaDfcESQ+uahdJ6P/Oby/uHfy5ox/JxkHWU4zL48c7AK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iCfmdhxJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728397824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/3XlY1mk3YffFm14gr4Vck9xAjVw/HMK/Fujtptt3Ds=;
	b=iCfmdhxJTDBVZOQxJEpqCo0XhkZLYtiwUlujqu5mum+6xJna15iGDtoy/u+7/gV7JN59ej
	V3TyVARPetlo9d/iJeeBdb6XoEMtMRxilXkrFJBF/boP2RgcI/HbZVe0vf4EDobMDJgl88
	rxsmHPAcjb8brfjbjCYr+6syqSdIXz5Sn6Q3/oi9HVg162Z7nijN2+hgDUpuGMrp+0ifx1
	YqYWXAKR22e9cIWTTwxyQaF1WNsc1JJ6xNCtSrL/5IQWGhAY4Qv/pqxAnXb0TAn7iDjuJ4
	kl0lhPpZK7eqMT2pBhxDOys/9WYcoYspqsgvN4E8DKWz8rFp7tkYdahgjrnYNA==
To: linux-kernel@vger.kernel.org
Cc: lee@kernel.org,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] mfd: rk8xx-core: Check "system-power-controller" first
Date: Tue,  8 Oct 2024 16:30:10 +0200
Message-Id: <08d4e88974c205eba124086ce156622e2e4cdc20.1728397516.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Commit 961748bb1555 ("dt-bindings: mfd: rk8xx: Deprecate rockchip,system-
power-controller") made the property "rockchip,system-power-controller"
deprecated in favor of the shorter, universal form "system-power-controller".
Following the updates to the board dts files, [1] make the favored property
name checked first, to save a few CPU cycles.

[1] https://lore.kernel.org/linux-rockchip/20241008105450.20648-1-didi.debian@cknow.org/T/#u

Cc: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/mfd/rk8xx-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 39ab114ea669..ed892bddf7b5 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -785,8 +785,8 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
 
-	if (device_property_read_bool(dev, "rockchip,system-power-controller") ||
-	    device_property_read_bool(dev, "system-power-controller")) {
+	if (device_property_read_bool(dev, "system-power-controller") ||
+	    device_property_read_bool(dev, "rockchip,system-power-controller")) {
 		ret = devm_register_sys_off_handler(dev,
 				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
 				    &rk808_power_off, rk808);

