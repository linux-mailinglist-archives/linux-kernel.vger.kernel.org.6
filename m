Return-Path: <linux-kernel+bounces-226302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41526913CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16A21F22832
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8774718307F;
	Sun, 23 Jun 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bvT+Orc4"
Received: from msa.smtpout.orange.fr (out-65.smtpout.orange.fr [193.252.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7A18306F;
	Sun, 23 Jun 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159635; cv=none; b=WoPuEKz4wVt+YMSK2h5O7qOLbW7jfW8vZv+sfW53ZI+nvPlOi4quWRZzlMTeX+kXIx2eSrsZqufLTCExyJeun/9jW8ctEvsM8pXK3wBWyLtbDTLnmB9jy/dTmZef+gYQGtvIvUKVYGEVJcijeYyzUG7qQwLC6NZJyVcYww2GABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159635; c=relaxed/simple;
	bh=xn/bYX9nXV2+s7Y5CdExXZOsyPxwtWyQZbAE9riVZzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+VT04stH+aftlLYgs+YKSlx0ZWITB+kLcENOgz1S6FqczKNH+/12CUdTsJu97/OTQz7HJgB420RPz4hEWQkE5na1mTNFNbn2fajUbAFz1jc5d3mjMYuV9L3jt7H2Ecps3jPfd+sZWeOafkortmFCpe/YcXRmLZemkFSmy/Dy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bvT+Orc4; arc=none smtp.client-ip=193.252.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LPoWsaLbz6H4sLPoWsNZPd; Sun, 23 Jun 2024 18:11:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719159098;
	bh=kaFvdfIOWtupjnAleAY1qcroO+ccHQ2tdJGDcVUeyB0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bvT+Orc4k44jsLDJdXNh9di3qYYz2iZG95kO6AFtXPVRP0jgZbnTB6le6kqgh8K0T
	 mhSgBTM48vToFcXd22PzCMYvqcSONs3n+VjLbjBAVfAXfClWLn+/dhx1GeVC2T86YA
	 E3hZZPlwiqdhdLaafvnlA8yXIwty7+dWFH9EcAKz1ICQaubHZeWb2VqpoMKFe4Eoir
	 UBeT9UrUo+nk35l3AwxWnmImdtvgno63xaj5gL9UXgXt5JjFMlCPUcbGG5I/ZVShgo
	 mWyGCojLFSKmdme3D14LrdT6Mqv8Z8zj5Us4wuVXiuSt+1kNkcS+QC7wnp8ZzFnebV
	 ux/yAlzkbgZpg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 18:11:38 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: knav_qmss: Constify struct knav_range_ops
Date: Sun, 23 Jun 2024 18:11:31 +0200
Message-ID: <a8b4b428f97fc584f38bf45100aa9da241aeb935.1719159074.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct knav_range_ops' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   7498	   1193	      0	   8691	   21f3	drivers/soc/ti/knav_qmss_acc.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7566	   1145	      0	   8711	   2207	drivers/soc/ti/knav_qmss_acc.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/soc/ti/knav_qmss.h       | 2 +-
 drivers/soc/ti/knav_qmss_acc.c   | 2 +-
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index a01eda720bf6..9325e8ce2e25 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -333,7 +333,7 @@ struct knav_range_info {
 	void				*queue_base_inst;
 	unsigned			flags;
 	struct list_head		list;
-	struct knav_range_ops		*ops;
+	const struct knav_range_ops	*ops;
 	struct knav_acc_info		acc_info;
 	struct knav_acc_channel	*acc;
 	unsigned			num_irqs;
diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 3d388646ed43..269b4e75ae40 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -450,7 +450,7 @@ static int knav_acc_free_range(struct knav_range_info *range)
 	return 0;
 }
 
-static struct knav_range_ops knav_acc_range_ops = {
+static const struct knav_range_ops knav_acc_range_ops = {
 	.set_notify	= knav_acc_set_notify,
 	.init_queue	= knav_acc_init_queue,
 	.open_queue	= knav_acc_open_queue,
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 06fb5505c22c..f2055a76f84c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -411,7 +411,7 @@ static int knav_gp_close_queue(struct knav_range_info *range,
 	return 0;
 }
 
-static struct knav_range_ops knav_gp_range_ops = {
+static const struct knav_range_ops knav_gp_range_ops = {
 	.set_notify	= knav_gp_set_notify,
 	.open_queue	= knav_gp_open_queue,
 	.close_queue	= knav_gp_close_queue,
-- 
2.45.2


