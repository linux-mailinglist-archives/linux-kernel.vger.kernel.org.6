Return-Path: <linux-kernel+bounces-249779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0A92EFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B01F23451
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985EC16A95E;
	Thu, 11 Jul 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SZqgLZD2"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D916DC16
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726502; cv=none; b=afz0tJYIfx3BkcNCnsci+vWgmqSNjP9i5RL5ioYCLeP8/pYTxLJrYPx/mIqcQhuU9ZCECY+dN2Qz/KHbV3IVSMyXdpEplZYHDD4QftHSHDINwqRmb1jlkCE6EAJKrfFLYr6uY9kF9K/JFliRYFAEH0oWGojmhkzQDhxxHd1/5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726502; c=relaxed/simple;
	bh=v71AQWRiys5rJQ4xv9+/2guDlwUCwFTFheOUGFbDVbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QODF7GWnwjEUEWibwjAxceV61Li/Lrifln/zyZnFKOkag7BxlTTZSrPEIUNY9LsHkBsIMle2Oy+ry4OY0XiIzmQ3vEd+H2ocGf8yW5uf/VmZyKdpRokAtyo32eIe7EjV8c2mJporqKfLmPJtCqeG8nnZ+pwJGbTkle3ZBXWcihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SZqgLZD2; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.. ([77.131.3.214])
	by smtp.orange.fr with ESMTPA
	id RzZBsCMFrj4pfRzZBsIiR7; Thu, 11 Jul 2024 21:34:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720726498;
	bh=zXP3sX2ock8JSJD3V0LkyeBJQLuvRqLa/4BAy1nJsH8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SZqgLZD2K5Whf1JsFaD1Hx/LG/aial+SuQnUKiQqbtrDMVSULcUGttuqBJnUyr6iw
	 sY+Ci+uM7iEuFaB23QEzV5il7gu/sEhSaEYmGiZxe/7vE/AUXWSK5tXuzJq5UTdS2v
	 UMI3Ljg9y9GRW4gy+g+2auZimAQvXqJk1P+dpzQhkVwVuO5UmFdmasxqphitmw6TuB
	 TU8MlVhOTN7aFQQALmAS2l6N8KF1peE3dJc/FqzXDesQS6Y0xFGZ0Y0ZJCo848B3UH
	 YA0kNse3ZP7CeMXkMieJeMTV9RuXoS+4O1HWnzKwplp/q3AqNxf7na6tChIQFjbIVo
	 w9/jkDgmKusnw==
X-ME-Helo: fedora..
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 21:34:58 +0200
X-ME-IP: 77.131.3.214
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] phy: cadence: Sierra: Constify some structs
Date: Thu, 11 Jul 2024 21:34:51 +0200
Message-ID: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is just about constification of some structs.

Before:
======
   text	   data	    bss	    dec	    hex	filename
  60489	   4342	     16	  64847	   fd4f	drivers/phy/cadence/phy-cadence-sierra.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  60897	   3878	     16	  64791	   fd17	drivers/phy/cadence/phy-cadence-sierra.o

All patches have been compile tested only.

Christophe JAILLET (3):
  phy: cadence: Sierra: Constify struct cdns_reg_pairs
  phy: cadence: Sierra: Constify struct cdns_sierra_vals
  phy: cadence: Sierra: Constify a u32[]

 drivers/phy/cadence/phy-cadence-sierra.c | 88 ++++++++++++------------
 1 file changed, 44 insertions(+), 44 deletions(-)

-- 
2.45.2


