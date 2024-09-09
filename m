Return-Path: <linux-kernel+bounces-321952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159229721E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E801C230CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8F188CDF;
	Mon,  9 Sep 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fwIzJDZM"
Received: from msa.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17BBA42
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906923; cv=none; b=N1+3NyboDGJyFm93qlxEazQ3KSoyGV1bB+315fa/HkD1ahKc1yZfFATlYZI5GR1tSBiy2PcVB76AbkItCkUQCVshNdUmLSXKpSLNFKpQrYWFwALHmDfV4ij6LTE1E5RubsVcnKd4Ij9T9Q+exfDdpWBYb+OWXnP303AJ4Y7Vfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906923; c=relaxed/simple;
	bh=28Vh0FDQd5/QA5SXE5lLz7s8CGcA02HisBIGph5waW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHbEuEDBYPtgV8yqu4nFr2cPceISLTOqPASHfIvdGICuL2a5k+Y1fjvUm95L2PSMgFRylaIx4wsCyzuI0NQRoucC5pUZrD4LvOo/C2JjfkT93XZUIreVExR6suREyS5A3yf9XhGVMlFY64t4uzkDKAW5rYDFcQiNqTTvAlqlIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fwIzJDZM; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id njEGsHZy04lSjnjEGs0dic; Mon, 09 Sep 2024 20:35:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725906913;
	bh=K2hlH2ab5/0XKaw9GaNDmz2ys+LddPEedIbMg1S8VjY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fwIzJDZMp0/cRKG8GpuH3zdwai+tZHSQzebtinF+P8/4F68Gij3iKk+JaoGF+M+Vy
	 01a9375enLKB4KDWR4uOCDLTZi1AjkucYQ4fpeHGLxvONh9s2ZPdCtHHyjikFy1tty
	 Z/PMlmXesgzsJWKt2GfCpzZw3TLvIRl/BjRlMGLOX4VO4XcG+cDweonojLhigVxZ7Z
	 +W9rqcf9bf6Ye/81ol8/YQTbPXwhn0SNotSsO1eVzCaFB8O7El8RVug/rNqtadgHMF
	 hZwZ3vzyVE7FiZ9nYitXz+D4QEYGq+SGFCUwpwndnJHZwcSfefaX8n00jyfzTydu3f
	 1EmkcDBjBm+yQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 09 Sep 2024 20:35:13 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	patches@opensource.cirrus.com
Subject: [PATCH] regulator: wm8400: Constify struct regulator_desc
Date: Mon,  9 Sep 2024 20:35:08 +0200
Message-ID: <fde33ecfd9bbdbdc1da1620c9f3b1b7a72f9d805.1725906876.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct regulator_desc' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4419	   2512	      0	   6931	   1b13	drivers/regulator/wm8400-regulator.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6307	    624	      0	   6931	   1b13	drivers/regulator/wm8400-regulator.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
--
Compile tested only
---
 drivers/regulator/wm8400-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index c4a229f66dec..fb3ca7956d00 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -112,7 +112,7 @@ static const struct regulator_ops wm8400_dcdc_ops = {
 	.get_optimum_mode = wm8400_dcdc_get_optimum_mode,
 };
 
-static struct regulator_desc regulators[] = {
+static const struct regulator_desc regulators[] = {
 	{
 		.name = "LDO1",
 		.id = WM8400_LDO1,
-- 
2.46.0


