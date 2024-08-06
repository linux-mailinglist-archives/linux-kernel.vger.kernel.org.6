Return-Path: <linux-kernel+bounces-276202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B9948FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB27286033
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2991C6898;
	Tue,  6 Aug 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mo9pXGxS"
Received: from msa.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F131C57AF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949350; cv=none; b=FI3Opkjy6Nl9ZE3yGRxQMhhWu/0eU/STrPCtN8nouahQDiaT1hJ0IpLHN9bKHekh+Ay8kQLxtaU1JlO319plhue9BfTdXjBa5SAVDKC1GFUwTh6kQsU2QArbc4ZiaQIDHH1db6vuUZNo4pGPYarAANuM3ui83KgxQ4hRmY7m6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949350; c=relaxed/simple;
	bh=4KmLtLBnvDikI9Rip9vpoXE1FdlAAl+VZX5fVPpaU68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JELu85U2++4C8Go7ExZsS4TlhnpfdHWn1fB+RKZaTNxneXccsddA4mn+xiLFbPQ6D97tu882fP96VHDN9cuZ01sdYpDWGugMt+n4Y3WzCBYr7U67VCkgHNwN516Cdw4AMwDD/Nz9qdTwcuSUDfsuSLsy0yYfZUIH4og8U1Yk16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mo9pXGxS; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bJoKs9q28nYGvbJoKs7vs0; Tue, 06 Aug 2024 15:01:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722949270;
	bh=fd+q0vZYHuoCmsWlgBR8lxVgdxoOXK0jnBOTKPNn9Xc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mo9pXGxS+gqtuzKDrWPpyw/kEW6r/rvJsspVcw04pq4CRZS2ncTSi7yBGLKgnWOFI
	 xrSbcRZwU9ksX+wqJbyIf8/Bs106av0y2k2odjLAEze59wROp1RFAoAMYAlofzOoAb
	 ut/35XpV/NycEaDAm/DyITxb2IdQ3HZ+oSh98HfCHxQLv565E8hwciqcg5UstTqZeZ
	 3/yCaCAt33G0FVHiRb8RiYkLmalr9+ssxBzQtGmpOHCmJkAEF/H3c6R5ZJoLKLySKC
	 cZhaUfB+LjG1TbqbV9w/LVyLigcnmtzMQsqKkJpVTtUEzOREXKWCP4UK0AvELnF9J1
	 0avidKzcY4NJA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Aug 2024 15:01:10 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: bd9576: Constify struct linear_range
Date: Tue,  6 Aug 2024 15:01:04 +0200
Message-ID: <a4e37991ea7b47145ab033128c8dd49f73a983e6.1722949232.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct linear_range' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

This is also more consistent with the other struct linear_range declaration
above.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  20767	   4544	      0	  25311	   62df	drivers/regulator/bd9576-regulator.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  21023	   4288	      0	  25311	   62df	drivers/regulator/bd9576-regulator.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/regulator/bd9576-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index d4ca7b3f4036..bf5f9c3f2c97 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -68,25 +68,25 @@ static const struct linear_range voutL1_xvd_ranges[] = {
 	REGULATOR_LINEAR_RANGE(220000, 0x6e, 0x7f, 0),
 };
 
-static struct linear_range voutS1_ocw_ranges_internal[] = {
+static const struct linear_range voutS1_ocw_ranges_internal[] = {
 	REGULATOR_LINEAR_RANGE(200000, 0x01, 0x04, 0),
 	REGULATOR_LINEAR_RANGE(250000, 0x05, 0x18, 50000),
 	REGULATOR_LINEAR_RANGE(1200000, 0x19, 0x3f, 0),
 };
 
-static struct linear_range voutS1_ocw_ranges[] = {
+static const struct linear_range voutS1_ocw_ranges[] = {
 	REGULATOR_LINEAR_RANGE(50000, 0x01, 0x04, 0),
 	REGULATOR_LINEAR_RANGE(60000, 0x05, 0x18, 10000),
 	REGULATOR_LINEAR_RANGE(250000, 0x19, 0x3f, 0),
 };
 
-static struct linear_range voutS1_ocp_ranges_internal[] = {
+static const struct linear_range voutS1_ocp_ranges_internal[] = {
 	REGULATOR_LINEAR_RANGE(300000, 0x01, 0x06, 0),
 	REGULATOR_LINEAR_RANGE(350000, 0x7, 0x1b, 50000),
 	REGULATOR_LINEAR_RANGE(1350000, 0x1c, 0x3f, 0),
 };
 
-static struct linear_range voutS1_ocp_ranges[] = {
+static const struct linear_range voutS1_ocp_ranges[] = {
 	REGULATOR_LINEAR_RANGE(70000, 0x01, 0x06, 0),
 	REGULATOR_LINEAR_RANGE(80000, 0x7, 0x1b, 10000),
 	REGULATOR_LINEAR_RANGE(280000, 0x1c, 0x3f, 0),
-- 
2.45.2


