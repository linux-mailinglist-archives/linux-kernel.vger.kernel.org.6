Return-Path: <linux-kernel+bounces-249616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4856792EDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040CB283B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235F16EB48;
	Thu, 11 Jul 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AI76M2CN"
Received: from msa.smtpout.orange.fr (msa-211.smtpout.orange.fr [193.252.23.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9116E89C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719114; cv=none; b=OMGGX4QkIA0vRq2zQ9ZxQGw4lCBCkWvzlcZilUgOBR+KmmIM0IoV6Q73niRkjQSZu0PK2GuAPJhrtux8PhyHj2zY6W0uaQRlqCYvD6yOfqZFYx3F0ewjUPzSEIcBq/bFRsL7iuBku9u342vUbNVImwj0SID0i7Px3din4PqRx6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719114; c=relaxed/simple;
	bh=I1lh+9PWxnRfpKf5KyMuGtWHTLzEMQ4QrU/SElqg0lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTdDiMUttHWVV4dPD9IFUJP+DiRhrsZ+LBPe7bQ7aMXtsJJEQsE9ko0VJhx0OeNmqgoDS89hgGADGiPu7d/HFBv/pBL1GRdQ1s3mqNgf0AVUqfxe6GjtqrbvG3iHWlMx0UkTE2IU9O6JXEzc5p7Jiae8Zvtjrx1AJ2FCWNDgdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AI76M2CN; arc=none smtp.client-ip=193.252.23.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id RxdPsAr1uHTrpRxdwsVM6q; Thu, 11 Jul 2024 19:31:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720719105;
	bh=CYDBY2pWQO+vL7jUvHWkdq6VSa180NCvhyL35LhJ4nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AI76M2CNz/N0+vD1wQnHuPFx3lNMObmO+djuwzVfE+tEFcf41Gc4mxZ9lWQE9ygtD
	 73FG9DaAXzSrSVqCt89PNak4DHz0jBDk30k0SQPUwuFp4OUY4dNL6dRqZgZY7bHvl3
	 QC1PoyOOivnLhNtxvWk4PKNNK/uYCzZK29IdIHHlW7Qrd1JvZo5qs7hMgA+qF/v7GL
	 ZkG6rTisyxlvedh1MOALNEIgyV8CSOIEvPboywkMMUGQd0+urlO5JSrcLr3LwN5C5S
	 RyQ/qcicJIM+8VJcyUlehJBjc4gKwl1VNBX7gMrJuTc3Ld/hAoUqyjlkjFOS6YGyil
	 FHdESRH/i/nug==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 19:31:45 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] phy: cadence-torrent: Constify a u32[]
Date: Thu, 11 Jul 2024 19:31:09 +0200
Message-ID: <34e23ceb6b7b7eb730ee8deee21d231b504dc65f.1720718240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'cdns_torrent_refclk_driver_mux_table' is not modified in this driver.
And it is only used as a "const u32 *".

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  93578	   4798	     16	  98392	  18058	drivers/phy/cadence/phy-cadence-torrent.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  93606	   4790	     16	  98412	  1806c	drivers/phy/cadence/phy-cadence-torrent.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/phy/cadence/phy-cadence-torrent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index e99fa19aafb2..098c141c28c2 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -285,7 +285,7 @@ static const int refclk_driver_parent_index[] = {
 	CDNS_TORRENT_RECEIVED_REFCLK
 };
 
-static u32 cdns_torrent_refclk_driver_mux_table[] = { 1, 0 };
+static const u32 cdns_torrent_refclk_driver_mux_table[] = { 1, 0 };
 
 enum cdns_torrent_phy_type {
 	TYPE_NONE,
-- 
2.45.2


