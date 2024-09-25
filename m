Return-Path: <linux-kernel+bounces-338187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003798547B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA21F224F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37DC15575D;
	Wed, 25 Sep 2024 07:49:37 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A582C13C83D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250577; cv=none; b=frw0K7h/nmeZ3sOUtFr/wZDL7oAV6kCEoGY31SmO+gdC/GLzezqj9e91wGpFbGv4q5u+QqgfRd/st8txMLI4+AQaAbL60KXs1Oar1/nG2Q9Suu6D7/L78Ft+gfe3vlVcy5//axs38L9I0Y063UlBhzUGQYghk0gPcGpKH66OA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250577; c=relaxed/simple;
	bh=mSzc1ITUqsH0MPtg9MUooZiCcKBWQTodDfsYcUrrUcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gL5ORrMNrlpaXHTbQCocesZu1LEZloCIdq2ix2A2XhUrWFZEMhU9BwAaNOov11DGhHiYP6kQQYUTOrbB/kfmLfzsKLRmFm2qLS+wZemItqEIJYZ/IWM0hP3ggT+6Y3GwIm3+5k9Q3acDzXoAyfLqNwDS6zu86XT71QgSht7ccCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip-77-25-16-238.web.vodafone.de [77.25.16.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4XD8511kCrzMQYm;
	Wed, 25 Sep 2024 07:49:25 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Esben Haabendal <esben@geanix.com>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH 0/2] mtd: spi-nor: macronix: reading SFDP by all Macronix chips
Date: Wed, 25 Sep 2024 09:49:01 +0200
Message-Id: <20240925074903.1983601-1-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Add reading SFDP to all Macronix chips.
All chips in the Macronix competabilites table
have a replacement chip that support SFDP.
Macronix stop producing any chip without SFDP 15 years ago.
The benefit of reading SFDP is by supporting
fater op-codes for newer chips.

This patch do not add an all flashes support.
This patch extend the already support of SFDP to all Macronix chips.
The new chips that reuse JEDEC IDs and chips that
are absend from the Macronix competabilites table.
The patch just remove the restriction!

Erez Geva (2):
  mtd: spi-nor: core: add manufacturer flags
  mtd: spi-nor: macronix: add manufacturer flags

 drivers/mtd/spi-nor/core.c     | 9 +++++----
 drivers/mtd/spi-nor/core.h     | 4 ++++
 drivers/mtd/spi-nor/macronix.c | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.39.5


