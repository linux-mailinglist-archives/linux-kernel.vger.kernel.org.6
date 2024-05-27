Return-Path: <linux-kernel+bounces-191030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569968D05C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888AC1C223E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451716C854;
	Mon, 27 May 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="wel+q3Hg"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93615F3FC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822161; cv=none; b=u2X6ZRwJqDUiO8IuLxKfwEUI+dR20zyg2dA3i2cQc/PUn3W0sw5G61R1m2wvYwNtdXTODywlc3EwGU8VpMAUe/KncK9M0Mn14qWMHcOXrNXBMLA7nDDKFPRpwgZzHtBZTorjAbtFUbEY1aU725LZru4Fo9S/Pe5nSxv/yYzvHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822161; c=relaxed/simple;
	bh=RWXMU3GyJCU75uomT+8y1qOi6l/HEYh3drr95SCacsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1v3TVY0LOZMDBsRJF8bYHfDqyPBvdHAXg3vBRASBgMEXFa2EpzbSv8LURA2rPsUQfaeWqszKROA+TYu0mRGxx28kR6OScMCaRofkqzkMSs6BXRF3EXFckaThyoblvFEhmudaMEtk7uz+craM4EOf3sMz2Kcv/H7t4PxgZza9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=wel+q3Hg; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822151; bh=RWXMU3GyJCU75uomT+8y1qOi6l/HEYh3drr95SCacsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wel+q3HgXrc/bEV8os0BtkKGeV5x5N2XLFJBMj19VHjQ916hKFtUmleHzdcXnHMft
	 BfEciLuwqXQXqoPcLSAU9uny37EyszoqQNda/5nhP5Z469ckni8EpZg/wqgabsP9Wk
	 QTVXAvgBzlDf0dLvMTIdhhlINzU66hqYA1RdkmYzwo/kD7WpbfoMRwExgHWVvp5p05
	 XRcQmSQC+vcMjbr6e3VeRr29J4s/x/6Ukrtm4ekTT9aVRRmoteyHAFDk3FFm3JX67S
	 C5Mtjios1KjfHAlOOY3iRwmYz34ruxKWcrk2+Ks0pWNpVVyNk46Fc0LufiKkBfSe6+
	 cxyhkKoWeTFmw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiX1954007;
	Mon, 27 May 2024 18:02:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Rakesh Ughreja <rughreja@habana.ai>
Subject: [PATCH 6/8] accel/habanalabs/gaudi2: unsecure edma max outstanding register
Date: Mon, 27 May 2024 18:02:22 +0300
Message-Id: <20240527150224.1953969-6-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527150224.1953969-1-obitton@habana.ai>
References: <20240527150224.1953969-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rakesh Ughreja <rughreja@habana.ai>

Netowrk EDMAs uses more outstanding transfers so this needs to be
programmed by EDMA firmware.

Signed-off-by: Rakesh Ughreja <rughreja@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
index 34bf80c5a44b..307ccb912ccd 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
@@ -479,6 +479,7 @@ static const u32 gaudi2_pb_dcr0_edma0_unsecured_regs[] = {
 	mmDCORE0_EDMA0_CORE_CTX_TE_NUMROWS,
 	mmDCORE0_EDMA0_CORE_CTX_IDX,
 	mmDCORE0_EDMA0_CORE_CTX_IDX_INC,
+	mmDCORE0_EDMA0_CORE_WR_COMP_MAX_OUTSTAND,
 	mmDCORE0_EDMA0_CORE_RD_LBW_RATE_LIM_CFG,
 	mmDCORE0_EDMA0_QM_CQ_CFG0_0,
 	mmDCORE0_EDMA0_QM_CQ_CFG0_1,
-- 
2.34.1


