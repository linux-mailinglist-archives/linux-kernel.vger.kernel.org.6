Return-Path: <linux-kernel+bounces-316489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D596D04D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B5F28418C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1F193414;
	Thu,  5 Sep 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="isGlYCcr"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7E19340B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520960; cv=none; b=NO7yzPtOsOE1IQh9zUqzAoCvm6G+8eNXDrje18USAdSLsWukaTQFjCYGS+DY6sKUrOrCu6W46rMzz5nV6UvQkR0XFSuVqjC38VlbPZiPe7U4tzuvBM7KEOCjc40WzwgVpF+yexgyPS7ginUzhPJsN8WkmWuvSgouNe8hZxGxJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520960; c=relaxed/simple;
	bh=06hHvaXsr8CHUUh+tR66f3ol7vovqbRb1hyjXKEtvhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VghEzijkn8vlQ4alY8lAy6zRU8JWGiVgaP3KUHeqoRr8JLlGrrOWhbMyyBz0VUNC/fYPHn8n5ztMz0V0WhlurN6djGQ97XglErQNwOtqot6E3MjWbQFQpK9dl3yqszFezyza+DytT5sq3MwbC5GsbsttxwxK/jvloYMcvaHdW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=isGlYCcr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 480FCFF80A;
	Thu,  5 Sep 2024 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725520955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ebeTHJJbb+PLFbrG1rBx4pw6eea7SBZUAwaWEbHB2HQ=;
	b=isGlYCcrZxvgK8RrZaiIvw31/xfwNgJLYqlKFCWf60JSLeaiFGQuQurGe2W7uEnfvR5yyM
	kJ3QDmdWJmvb9PWxmW8xS2Rf2evzyF5ry8OSKrVzxu2Sj0QvTfAhEG4CPqVZl70DIl2DgV
	+cVzIPjxRYelptNTg1GEvTO0IGXH/T8wjIbts45+YzGo0dAKO4adWMbbslgXczh0G3WYKq
	zmaHOPPw2OSbiNFU6oumOyaAO/sjFVS5d4qbvnO2gzw5YflN/Ewi5DdxeH8QNzh2D7qRyN
	911xIrhrFkMMfZUM+92JTYYbQcsvc7CFrg5Zl4bon1t0IQR4Z2FICnT0fkLaKA==
From: Herve Codina <herve.codina@bootlin.com>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: fsl: qe: ucc: Export ucc_mux_set_grant_tsa_bkpt
Date: Thu,  5 Sep 2024 09:22:15 +0200
Message-ID: <20240905072215.337010-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

When TSA is compiled as module the following error is reported:
  "ucc_mux_set_grant_tsa_bkpt" [drivers/soc/fsl/qe/tsa.ko] undefined!

Indeed, the ucc_mux_set_grant_tsa_bkpt symbol is not exported.

Simply export ucc_mux_set_grant_tsa_bkpt.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409051409.fszn8rEo-lkp@intel.com/
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/ucc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index 21dbcd787cd5..892aa5931d5b 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -114,6 +114,7 @@ int ucc_mux_set_grant_tsa_bkpt(unsigned int ucc_num, int set, u32 mask)
 
 	return 0;
 }
+EXPORT_SYMBOL(ucc_mux_set_grant_tsa_bkpt);
 
 int ucc_set_qe_mux_rxtx(unsigned int ucc_num, enum qe_clock clock,
 	enum comm_dir mode)
-- 
2.46.0


