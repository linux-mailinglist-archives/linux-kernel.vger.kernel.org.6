Return-Path: <linux-kernel+bounces-388013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C79B5934
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3EB1C216AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430915575C;
	Wed, 30 Oct 2024 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hu+QhaOM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DD22334
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252251; cv=none; b=D/P5rdAQebe9l5ej5nGjRT0IpvMXDTBBRZA3UdP5Kmd7N7KhXY0MwtjJrRMfgJIIlij7IVid6PMfA8y45z0LGV7hoRZBNRMBdmBTy8dA4u3PwSiU53oTRQcr+ZdgoTvrHVzkkwQW1ibHCkPsiiqVJnB7Ul/kuqWdfGcJUv2tHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252251; c=relaxed/simple;
	bh=u0wRbUpUbd8eRidaKgPD3AVQ7UgkD56WXefRXLDR0es=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ez9zAx4s3LDF1lZB+dc9U7CidB3Ei2MVtdlk94FvxTWgQI5vCI5vgMRII3VgdGWMKW3HJNi2wzcAU71YxyUl4b+PrQ+cfLsnyI6PticZa6OC+dRUjLvY3PqmmG6wOD01D8WXd9kBRXA+A4qbxvNYaHHYVNdQxGj1NGj8tWwMvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hu+QhaOM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 82338ce0965f11efbd192953cf12861f-20241030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ayZ15KMuy8YT+MalqR6y/T6iKNCjhQrVgR1kRLPQd8c=;
	b=hu+QhaOMh3IrLFvqwZd/WEKxQXvaXr35Q6m6glSUKLb8MU7+YwppaOrtOtu4bu77qjYEXHKM35HhCjdgDq+mfplwXiJFN7OocYsuGrRT4moiMukxDMVblVD97LLqwYnz2SnfodyqcahZJn7KXaK1FwyHG1LUl8K0kpc5aDBLR28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1d44a4da-e243-46bb-832f-30c44d4b998b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:f6d46448-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 82338ce0965f11efbd192953cf12861f-20241030
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 554073609; Wed, 30 Oct 2024 09:37:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Oct 2024 09:37:20 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Oct 2024 09:37:20 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Karl Li <Karl.Li@mediatek.com>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chien-chih.tseng@mediatek.com>, <andy.teng@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH v2 0/1] Add MediaTek APU SMC call Definition
Date: Wed, 30 Oct 2024 09:35:27 +0800
Message-ID: <20241030013533.855696-1-karl.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Karl Li <karl.li@mediatek.com>

Based on tag: next-20241029, linux-next/master

Hello,

This patch introduces the SMC calls for MediaTek APU.

The start and stop sequences of the APU microprocessor are managed within the ARM Trusted Firmware (ATF), which requires a secure and reliable communication channel to issue commands from the non-secure world. This patch adds the necessary infrastructure to issue these SMC calls, ensuring that the APU can be securely managed by the system's software.

Please review and provide feedback.

Best regards

---

Changes in v2:

- Move header file to include/linux/firmware/mediatek/
- Rename header file name to mtk-apu.h
- Update define macro name to __MEDIATEK

Karl Li (1):
  soc: mediatek: Add command for APU SMC call

 include/linux/firmware/mediatek/mtk-apu.h | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/linux/firmware/mediatek/mtk-apu.h

-- 
2.18.0


