Return-Path: <linux-kernel+bounces-286491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC2951B99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3638F284F95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8C1B29C3;
	Wed, 14 Aug 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Fq/CHCG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faSfH/me"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265D1B150A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641154; cv=none; b=GrqP03Lx5UXVyJUF5RZyzRvHgjN94JKl48XgQ83aIospHqK+jqc5r8hvEgwMlyAmrnVCK/+atEtlHdc6Tx04zWEgrh0w8ip2bXIe7S5yC7XctinK+c3DctSTprLKy9iYLeTOQ7FwLdzEUBjxxlLNHJbWhsXGSCE/b+WIxtrhAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641154; c=relaxed/simple;
	bh=z77wcTGipU3vU3Z9hRt3R4GCiGBDCqnr3cJoObfy3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1XxAOSEUDJltVvy14jRMaqVH/WK4p6b2BeZ57PbgiKcJedk900OaQrcw3CfUVRzU93WLNOfYEZQGmI/PiXTuZPLW6B0RlcLclBpv3UypHdYt0ITTE0iLtljsayaucNVLXGmKt/thwIievAtF1WjSkm0Bh9Ga3Ze2eD0BtYSbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Fq/CHCG2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faSfH/me; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A01071389445;
	Wed, 14 Aug 2024 09:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 09:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723641151; x=
	1723727551; bh=6eQz40i7Qbf0+e3nqYJywvuPegD2nGTCSj//GbNl60U=; b=F
	q/CHCG22HXcNnD+Lu+tzXCbEKOS5teQH3+7frIt3/9g0YQVVmdkNzzFD3PObw1dO
	JlF1mxqeBWsPYf6nvUGSCZgJBbGoGyah8umKuHYRk30yLkqdoThRlxKg9apRx2lC
	7Lqip80a9JscNRqm/JuhaI31VvGSGwz5Djf9EXigOdv8xH+Qal61OwLtnEaG/Geh
	Iw2+lGCedWdTVS4NG10DhnW1MYPxRNRB4PTHkzeSx+pUOEP0/RTGcU+3toGeWJsT
	AwUvqQ0B+n2DjMQ+jSTHGMNDK+4V0YAqwbSda54e2LR4C9WW7cWG0JbcgoXHLwT+
	Fd0gicNjR0uc67cjav4Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723641151; x=
	1723727551; bh=6eQz40i7Qbf0+e3nqYJywvuPegD2nGTCSj//GbNl60U=; b=f
	aSfH/meWOQpAk66Nq2mMFcLcJnf+P64H2D70u526GD77MdComXDmljw6HTorZPzu
	L44yKkLAzCA3Vldlb77ZvzLLD8XiuHQaHENF6v9zfR+CyrvX+T8EuqegjNvL4Sx+
	3TRmuDdCaJl5taovmJMA8jrZNe7EoiNLc+9gF6fxB3htBwGjugJAw6qKguKQN7tI
	S+7TydKqLAuyIjhSJ4ludL13apZHQgcCcMIW1+3N2D/4oV3eDKc2HrZex1E/OLQf
	RxsTajRRe9WPC6u1Z9/AeS3ovReu3xsSJYsuwBDg6vMGzRT1L8RNwoK3mshyJffh
	MKjz2wyqt1zwuO4fs9QOw==
X-ME-Sender: <xms:P628ZiK_WzuwrrAoqEICdzaVaP3LpyGhbm4DszHOdEVqmUtsVcohRA>
    <xme:P628ZqIJF6uMpYXGe3KWg1eTZsiGpLlSIiZyfE65FP7t1xcyls925P1FfUKUvQPfe
    dOSzZ1oYDiZMRjTcJc>
X-ME-Received: <xmr:P628Ziv-LuA6P6vexyCmuXaQtuhp8-zYw6IZNCNyEX2p_AdIm2_pqzdm7h-AhF0iCZButUl7TH79B817S-k9roceecqZYccpyX6YozNeq6oS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P628ZnZG5IpHRmigA4lvEyeM5WViFwYYcSN7WI_FmjrQuY0Uv-O9hQ>
    <xmx:P628ZpbIi7-2qdWsO-GwPYxhRLkkfUSq3i0truLVtEuJD77zTxqQCQ>
    <xmx:P628ZjDI6aNfCdQETjn3uSO34Idt6hOnKdaFzat3xteHk0f2_iHr9A>
    <xmx:P628ZvbtQnPa2gbM2_og3TP5QhzBD_qMZYzq_RP_aTxa2IBcqGhayQ>
    <xmx:P628ZokSE2eCBFQFDSs_gm1z6wYRmE9fBWyYIK1oTCb24x1xevO327rW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:12:30 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] firewire: core/ohci: minor refactoring for computation of configuration ROM size
Date: Wed, 14 Aug 2024 22:12:22 +0900
Message-ID: <20240814131222.69949-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
References: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of space for configuration ROM is defined by IEEE 1212. The start
and end offsets are available as some macros in UAPI header.

This commit uses these macros to compute the size.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 3 ++-
 drivers/firewire/ohci.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 32ac0f115793..f71e118ef60a 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -564,7 +564,8 @@ static int read_rom(struct fw_device *device,
 	return rcode;
 }
 
-#define MAX_CONFIG_ROM_SIZE 256
+// By quadlet unit.
+#define MAX_CONFIG_ROM_SIZE	((CSR_CONFIG_ROM_END - CSR_CONFIG_ROM) / sizeof(u32))
 
 /*
  * Read the bus info block, perform a speed probe, and read all of the rest of
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 979f1e1f2d16..53132eae37fe 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -174,7 +174,7 @@ struct iso_context {
 	u8 tags;
 };
 
-#define CONFIG_ROM_SIZE 1024
+#define CONFIG_ROM_SIZE		(CSR_CONFIG_ROM_END - CSR_CONFIG_ROM)
 
 struct fw_ohci {
 	struct fw_card card;
-- 
2.43.0


