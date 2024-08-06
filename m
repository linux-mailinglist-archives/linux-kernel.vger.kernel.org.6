Return-Path: <linux-kernel+bounces-275779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 598BA9489B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA531F25163
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8715B11E;
	Tue,  6 Aug 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J5Fa5cYH"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26CB663
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927714; cv=none; b=SR2v0n7jpse2xawTDLtTmOvFc4FX7zQX8XKI+sd1CvmoKQ/fgJlsM7Lc9H7ChfZ9+BbGHrgDvJ7o8OA1hYNenkG0hnJXeo1+xMP9OoSjgRJnotMYuEPzXmdBq266noW6RSkuSNfz4zHR1ZEGGbV1c7KEAOsHCL3M2W1tYYHxHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927714; c=relaxed/simple;
	bh=J4M4kvsLInnExY/QCbU9J9DriPGrhWN5e+IA/qfKpcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cf4TYW52ZURC+y98ottBE5sJJ1+qXRJz59VJmdxwdUFjgWtElWDU32ZVH09xxq2p3g/TI9EtZa0x51ANUl0kYEXPhmoGN6+dIe9DI8n7Y53IykL8525KoFl2xT+XVCc3Or/oz0tmzbAQp95pmPOh5sUX8eJ7c30f2VRS1eczv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J5Fa5cYH; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4763fxB0017009;
	Tue, 6 Aug 2024 00:01:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qyS6gmL9fUjso1gx6fyW6lU
	7ArR8Ee+ubGGTs2Kfv8g=; b=J5Fa5cYHUKVxf26BKhTcZvVjpY1Dy2SN5lno19B
	hE1BcWYGE38neuYOtOirTV6GatKilxphJswTGQj/AbtCCUMZKAVSzrDrmw7JlzR8
	dbKl+qU6t3XJWFbeCjMTyfbYWxFPUhc115qJkXl/1djEvKzYKFXFn9jheQrEzyi0
	dOcEeoKh9DpQ+hXa08KoisG47ubOjbqyOM5SnkpOwDCGXY6Eyb0QJuDZNbj+TplL
	ufQnWyyU7KLti10i3kg/s9VZ0qmpI/4qsZ754yJfay9U80UtUBa7frxKg+m8JG6s
	vd3YIJ8UxBPAU6MqsRpNmL7Fy3XQm/x1iUW1YA8RU0zv7BQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40uc5f0g8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 00:01:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 00:01:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 00:01:42 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id EEA3D3F70BD;
	Tue,  6 Aug 2024 00:01:37 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <--to=netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <--to=sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>,
        <ndabilpuram@marvell.com>, <--to=bbhushan2@marvell.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH] octeontx2-af: Fix CPT AF register offset calculation
Date: Tue, 6 Aug 2024 12:31:35 +0530
Message-ID: <20240806070135.1541607-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hv1rnbR03hwtaEFuQhDfBM9ActLYKc3n
X-Proofpoint-GUID: hv1rnbR03hwtaEFuQhDfBM9ActLYKc3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_05,2024-08-02_01,2024-05-17_01

Some CPT AF registers are per LF and others are global.
Translation of PF/VF local LF slot number to actual LF slot
number is required only for accessing perf LF registers.
CPT AF global registers access does not requires any LF
slot number.

Also there is no reason CPT PF/VF to know actual lf's register
offset.

Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 3e09d2285814..daf4b951e905 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -632,7 +632,9 @@ int rvu_mbox_handler_cpt_inline_ipsec_cfg(struct rvu *rvu,
 	return ret;
 }
 
-static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
+static bool validate_and_update_reg_offset(struct rvu *rvu,
+					   struct cpt_rd_wr_reg_msg *req,
+					   u64 *reg_offset)
 {
 	u64 offset = req->reg_offset;
 	int blkaddr, num_lfs, lf;
@@ -663,6 +665,11 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
 		if (lf < 0)
 			return false;
 
+		/* Translate local LF's offset to global CPT LF's offset to
+		 * access LFX register.
+		 */
+		*reg_offset = (req->reg_offset & 0xFF000) + (lf << 3);
+
 		return true;
 	} else if (!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK)) {
 		/* Registers that can be accessed from PF */
@@ -697,7 +704,7 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 					struct cpt_rd_wr_reg_msg *rsp)
 {
 	u64 offset = req->reg_offset;
-	int blkaddr, lf;
+	int blkaddr;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
@@ -708,18 +715,10 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	if (!is_valid_offset(rvu, req))
+	if (!validate_and_update_reg_offset(rvu, req, &offset))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	/* Translate local LF used by VFs to global CPT LF */
-	lf = rvu_get_lf(rvu, &rvu->hw->block[blkaddr], req->hdr.pcifunc,
-			(offset & 0xFFF) >> 3);
-
-	/* Translate local LF's offset to global CPT LF's offset */
-	offset &= 0xFF000;
-	offset += lf << 3;
-
-	rsp->reg_offset = offset;
+	rsp->reg_offset = req->reg_offset;
 	rsp->ret_val = req->ret_val;
 	rsp->is_write = req->is_write;
 
-- 
2.34.1


