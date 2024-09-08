Return-Path: <linux-kernel+bounces-320171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233CF9706FC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44AE1F2191A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B51598EC;
	Sun,  8 Sep 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AqGNOmWK"
Received: from msa.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36865156F46
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795670; cv=none; b=qOdH2k5i3j3/HjjXiBOjVbYDJX7fgh79pMHDO4MRDFJ28OLazTZgvR97rnuSw4jDLIgT6s1jVX+cLyz1fl70XE26L1zPL7ACldMmNjhVL3X27ViCfqhbct8PraVfifEKAHSv8YYpnZih+VXOoAVt4QUsPfI0OGtoU671vzL4Qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795670; c=relaxed/simple;
	bh=1Qhx0AQRK9ttQdmzZmSAGaRrUT0Salp94PcJRhj61wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaqyrhlNEhXxJEfpZBeqIsvzA1vkdHH1rcSlrO11eKgnMiGSIrAXfUqT+YMsnHB8UU10BEAn+EjvXbifwH7QazxQoG3GF4nYk6bccInA8A+dJaEQGq7NnHWJxky5JaOHWBskEEQh0naasiYZCj9TVKFI3T4mgzuAUbtLDnSjNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AqGNOmWK; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nGHgsexU2GrBenGHrswgtK; Sun, 08 Sep 2024 13:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725795659;
	bh=rkF1WqCp0VrtzogJvR0Aay0dOwijVk8Eg1QDROv0aUE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AqGNOmWKnq45uCle5syYWekhyf5/Be1v40Tr67NyUwzh4pZ33RmrpsW4Im67j9fI0
	 qg2UWYq2MRXMFTgPNLgSIHorXLkVia3kiIXTmhHAZ+tLEsIUxhFZSmHFcs+FTFUKta
	 e2UWEOIWvt9yrED5SFGSJpkAOqRGFmQRcXWtByl5CC570yIsbIzSsQO4GChZpTqKwX
	 Q97D3FLBrzlPRV9oRJjWyTf22C7HjA4bewV32+jNfqS9z1QUPg566NqdoyXZ7YogGk
	 uzHGrcpSmq/+s68PC8h1hI6dwqLd5h8yTDo2J1iaDUc7I/g2a7KEqF7CwpmFlM6R9M
	 ilPgjiNjMhOsQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Sep 2024 13:40:59 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lgirdwood@gmail.com,
	iskren.chernev@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] regulator: max77826: Constify struct regulator_desc
Date: Sun,  8 Sep 2024 13:40:44 +0200
Message-ID: <1aaff0efb601832cd11949653d5872e7e39fbd7f.1725791361.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725791361.git.christophe.jaillet@wanadoo.fr>
References: <cover.1725791361.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct regulator_desc' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   3906	   5808	     16	   9730	   2602	drivers/regulator/max77826-regulator.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   9218	    496	     16	   9730	   2602	drivers/regulator/max77826-regulator.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
--
Compile tested only
---
 drivers/regulator/max77826-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/max77826-regulator.c
index 5590cdf615b7..376e3110c695 100644
--- a/drivers/regulator/max77826-regulator.c
+++ b/drivers/regulator/max77826-regulator.c
@@ -153,7 +153,7 @@ enum max77826_regulators {
 
 struct max77826_regulator_info {
 	struct regmap *regmap;
-	struct regulator_desc *rdesc;
+	const struct regulator_desc *rdesc;
 };
 
 static const struct regmap_config max77826_regmap_config = {
@@ -187,7 +187,7 @@ static const struct regulator_ops max77826_buck_ops = {
 	.set_voltage_time_sel	= max77826_set_voltage_time_sel,
 };
 
-static struct regulator_desc max77826_regulators_desc[] = {
+static const struct regulator_desc max77826_regulators_desc[] = {
 	MAX77826_LDO(1, NMOS),
 	MAX77826_LDO(2, NMOS),
 	MAX77826_LDO(3, NMOS),
-- 
2.46.0


