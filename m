Return-Path: <linux-kernel+bounces-252657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6AA93166D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C570A1F22280
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0999C18E777;
	Mon, 15 Jul 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="sV7MsJVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzr7+7Yg"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE1180A70
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052694; cv=none; b=pAZkYQ1JIvJzWivO1W/BYWBT9IYS4VHGcOeGGlzCDu0CN+16Eys62sfvLAqwIrsseoRh88C7em12lDsgTRNgFtNRfc/QKzXUCHIUTAzila2uhjlvM7ushJ/BQlN4WlsS9FKvJ2ZtWjMzJq3khJPtHDm/XTw9GoXtw3rHzGepDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052694; c=relaxed/simple;
	bh=LfG1VDt4gSGv/VcekoGMoZlmptanf/PJL58P9rn7JUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRwTTf/XQ7bUgtn6Si1yPauMBNcOXAJRWKQV14r4vYoqAgzcgKKau/KVelvHoChPEZAGtUGKqCpaXnF5eU+f/ultbjL9rd2VcTsWJ2Z75g81TxsGeP4CjsDd7W7JNcDOVUqMxmq4TCosdvZfW/X4/bOT1zVoKyvBeEtw71I1yxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=sV7MsJVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzr7+7Yg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3DF2E1147BAF;
	Mon, 15 Jul 2024 10:11:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 10:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1721052691; x=1721139091; bh=uAPBkJz7cUB+jKW4K/YyB
	GV9YVinq0tpJehNjAkb+Qs=; b=sV7MsJVKz7kjfZu7zMj0CkUZ1s2mTipmsHkPE
	o3MJDQ5FWkDn9rvvW3cb9rxqVezP1SpSsw2PSRZmoyqEV9XZylr3QMRtOgpxsXXU
	qdZji4E5POsdvwBD6VCXkfBJv0Lyz3zr4zDmP2fL6uWzswuviglJh1ptQruyDaJY
	Zxop5oL0mi8xKDHjrhcHIpP81W4NL63lxDBVf5s7OmBaulsJ7ynVFkaUZwPiNoZD
	bibVg6vvNMl4GsIX9ajPCl40r0ckncwvg5g0pdm/RZfd+PWiW7XttUEX7F6+xzdc
	Xb0uckR0fL1kakhCIKw6SRNrN1KZmQMDhZAVmbc/kQT6rsndg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721052691; x=1721139091; bh=uAPBkJz7cUB+jKW4K/YyBGV9YVin
	q0tpJehNjAkb+Qs=; b=lzr7+7YgKDmIHS8fKwr+B7S1CTRRmDkkX3NQsUdEdVs4
	29DgsFtofywI6gAYrOYoqP+F2bk15EJJ/vFMODZNosYjZBzZyYqzEnLmu0BBnpwV
	+e7W4i1YaHL3+eGFEQ811Fsw4W5yssm9H6rtntmp54TTh2TCDWG8FSAxdjHJp/o4
	rGzpd0j6Uvt40fSxUqWrJCCmL0t6D6tlS68Yw6PKJtwNQyWumhjy8ZRzFX6rdUSY
	G99IO2r+CWFgR8tHp1oUjb3q/3RTM0wXfpuMGP2Cf6EbIy7XiC98bo2afWPXAwS3
	Q7dyHut2bFFu5veCqExAW4xj65FBuC5AnbujreESTg==
X-ME-Sender: <xms:Ei6VZpo1-WrfCRxMH6lou-GHg42AmKCKHF5XY_4xA2KgqqBjF60opg>
    <xme:Ei6VZrpKMrBIEl6IOL42b-tOOoSZPd1flsrIOINUuJwgBbE8H8KRMaOlSFB9mhoh5
    1G1Bbjv5pndd3I>
X-ME-Received: <xmr:Ei6VZmNFZVtH3goCbbov5t2QKuDn-gtvIrRMHiS5wI21zEA8IEt0uwZLtyhnFTec_Q_n3YA8z-NYW59_pPsnsFEYrIT98y8n0okhDf7euHKwM_zv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifhrihhffhhinhcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhhi
    fhhfihhnsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeekvdfhkefgtdeugf
    elueejffelueeludegieejtedtveekteetieehkedvkeevleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhhifhhfihhnsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:Ei6VZk7pnPyCwq8hCcm-h1y3EtJ_NF5X0iqCq3ATR0D-D-LXN7vZJQ>
    <xmx:Ei6VZo4ul3wWOKgER-Fc06LSvD7aoNLIqaB3ucwA0JVqquKvtCuVjg>
    <xmx:Ei6VZsgCAXAK47KCL3D1XLuBUIHPPtVfThln_LTlreboH8wGBh3cMQ>
    <xmx:Ei6VZq5w6wvsK_Gh3391gFfnFqqFqs8XEB3S3HfrZxjt-Uag4YDykA>
    <xmx:Ey6VZj0nbXSg2ZDIhmtkt8Rx0o3D_Nn1ZQaL9219HXPY1H_7NYfjrQLP>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 10:11:29 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Griffin Kroah-Hartman <griffin@kroah.com>
Subject: [PATCH] staging: vme_user: vme_tsi148.c: remove redundant newlines
Date: Mon, 15 Jul 2024 16:11:02 +0200
Message-ID: <20240715141102.142186-1-griffin@kroah.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2ec9c2904404..9066c53150ec 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -1653,8 +1653,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 	case VME_DMA_PCI:
 		pci_attr = src->private;
 
-		reg_split((unsigned long long)pci_attr->address, &address_high,
-			&address_low);
+		reg_split((unsigned long long)pci_attr->address, &address_high, &address_low);
 		entry->descriptor.dsau = cpu_to_be32(address_high);
 		entry->descriptor.dsal = cpu_to_be32(address_low);
 		entry->descriptor.dsat = cpu_to_be32(TSI148_LCSR_DSAT_TYP_PCI);
@@ -1662,8 +1661,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 	case VME_DMA_VME:
 		vme_attr = src->private;
 
-		reg_split((unsigned long long)vme_attr->address, &address_high,
-			&address_low);
+		reg_split((unsigned long long)vme_attr->address, &address_high, &address_low);
 		entry->descriptor.dsau = cpu_to_be32(address_high);
 		entry->descriptor.dsal = cpu_to_be32(address_low);
 		entry->descriptor.dsat = cpu_to_be32(TSI148_LCSR_DSAT_TYP_VME);
-- 
2.45.2


