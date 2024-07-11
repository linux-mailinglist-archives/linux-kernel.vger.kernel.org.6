Return-Path: <linux-kernel+bounces-249612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5892EDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F949283445
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7416DC15;
	Thu, 11 Jul 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RKGfCXy+"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AB161B43
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719085; cv=none; b=i5aAtkd9z4XOmC5XxLWJzQSq5lw163b83ZN+I/UI9QiGRisEyWASJDIPLkGSPOdP2B+C2udnJ8FVJ1Vsd+dGQinp8eCOr28HvHuaD1UkpJlqPsd2FTTkKKT4qTMA5oCXKjcAJgLoxgoYvJV8EynpEn6FPf4l0Jyd73PEbu0xMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719085; c=relaxed/simple;
	bh=i5M/KkEe+fepdyPiWkDJhqjuHP7yldYG6MEfdBmuf1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hksn12BRez6KK76ya0YrbBGCuPA2ah9g+3etienx1L8oePm4RtJW//nq9jAisTO1cwW6jFhq70ei2AP5EUZVUnAfxUBs9KbjHoyxg2NJ2i1FaYBTzxkEvwaRpYRfOy2Nez3QJ3LDcB3nZWkGdbr+LaW0yOysiOzBvrkVVgd9x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RKGfCXy+; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id RxdPsAr1uHTrpRxdQsVLWC; Thu, 11 Jul 2024 19:31:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720719073;
	bh=RRQXTK+lQmAsyj99iqPHXhZaL0F3tchaEGasoQcNsJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RKGfCXy+SgyVVuegeHXFR9X/K4vy2r5C/OqqhX1Jt7URhz/8Wl8GE4CJClVkmOfag
	 JdcvlzDivjhY5PnmQ86winemWbm3hV7D09j+2d91kFXbtKtbfwUFdHpEDobvFNM3P4
	 RzntG9QMIbD5vNpdHaU3ylw6ITkrkZ/a0lOcPlk5Aw5qTaArCkF4fF+dVpxzB5FII4
	 AKGbV5hg1xJRgMrjeTg0R04QvxcjVHypXVxYs9AxjKAig3EqAXePBWgjUyx3OeOtCc
	 QiDYwnivWHW8N/S5CkkmmWJgmMINyYAiu6GxR50Ar9+fF3AAZiy/QFdncjhSxCHL3K
	 XcUVp9P5XV5Bg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 19:31:13 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] phy: cadence-torrent: Constify struct cdns_reg_pairs
Date: Thu, 11 Jul 2024 19:31:05 +0200
Message-ID: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is just abour constification of some structs.

It turns about 15 ko of data in ro section:

Before:
======
   text	   data	    bss	    dec	    hex	filename
  78154	  20222	     16	  98392	  18058	drivers/phy/cadence/phy-cadence-torrent.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  93606	   4790	     16	  98412	  1806c	drivers/phy/cadence/phy-cadence-torrent.o

All patches have been compile tested only.

Christophe JAILLET (4):
  phy: cadence-torrent: Constify struct cdns_reg_pairs
  phy: cadence-torrent: Constify struct cdns_torrent_vals_entry
  phy: cadence-torrent: Constify struct cdns_torrent_vals
  phy: cadence-torrent: Constify a u32[]

 drivers/phy/cadence/phy-cadence-torrent.c | 376 +++++++++++-----------
 1 file changed, 188 insertions(+), 188 deletions(-)

-- 
2.45.2


