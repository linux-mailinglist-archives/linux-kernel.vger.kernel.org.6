Return-Path: <linux-kernel+bounces-238524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077FB924B86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5951C228B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EE17DA15;
	Tue,  2 Jul 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Y9PSy9V9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c94TL3NO"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97217A5A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958847; cv=none; b=btv7shZQAGwdFV2vxDc4wasRKGR73AimFZyq+NCvz/W+GlYnM6uUfRkH1jbdIHnjatgRYAg1+0SH0wggovAhwR5ol0t+8Sia5zU2mtMTeTcx5ouLxD9iA7cMzdDwwDtStLhyqYTCe7GQ4mZLJYlMqCkkenpGV54RHEGQHSllDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958847; c=relaxed/simple;
	bh=FAjamNAqol9oFFwGy78qp37v4RAzWv+5EK5yNCkx7zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WroTONbfm7PYk0T0qJi/HOwjlmqfJ6Oovao+6Wa8vfm+A6n1S8sENQOMNcDaBZlDiMqUzKWx3Fkw3oPmX8QYAsyEtShAkU9DghCevvz/OZHzIc5R0/GB0E61Tio0Tvf0j7sxqR8o9ZwZ7sFJ37N5fqvwAuKN5Ep+MjRMl9Rl9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Y9PSy9V9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c94TL3NO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0BCC113802A7;
	Tue,  2 Jul 2024 18:20:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Jul 2024 18:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719958845; x=
	1720045245; bh=ody5HCrdHgBlLUVNyBxe9FK0hNGkd1ti0Yfpg/IrLj0=; b=Y
	9PSy9V9NLsyVpuHiZW54jxXen4AvlvDfSlNRHKO70vfnTX38pUtwQHqrFroIzLIG
	9Wfqor5dkYX+4sOf1940a6fil8oC/UGcrLH9fEwTjkihTGDEFW1ExgPWIR1JwW73
	PQPcKH1pEVCggJYEtk39P8aRheK4dsD3bl7vdRWLoUWJY+oqYizj3O3o6IFUJsxK
	mrA3UMzegYLJdqwcHT64CQegZnK23q9xoaP1dHd1xxPyJlcVTD1VtL9BZVbUZvC1
	iGKCRlzxNg9ZU9jlUf1+qk2UjBqUnPODqJwVgR/GKHUunkkthIXQk1OWi8WwNHr2
	985Q9EIXtOClrH1PaV+fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719958845; x=
	1720045245; bh=ody5HCrdHgBlLUVNyBxe9FK0hNGkd1ti0Yfpg/IrLj0=; b=c
	94TL3NOb/yhWq3K/UtRbcAzGOXjMF5XQaP5nyIgWTC49MHa7n5SKWsrBKL4lyxpi
	E0JJofEQBGnCgT5IPIzcn8Q5gqQfZudMGZDKQh2HYwgA8VUFCD+bEP2eFMgqeeXP
	CO9PiOZi6t5w5mmaleNQzkxF2j9sCj0dtbhgWZOW2EVlLl9N14eexxjBIPJ+Fmvd
	7tLbuKS79bPeFUUfWCpgiw5iJMWgf+XKpHGaZQ9dhD+ltg2Pb3Oed/iYJerYcthf
	+9KsmnNbJZ5gyt+SUEWMTrvYP1mwI0+h4H2afIRbaunWzUsXs3jL91BAYRiuiBzX
	usaJw26t7CG3HFA6ATL8Q==
X-ME-Sender: <xms:PH2EZmHsmIGWWoAyp3YEXZB1PAFZ-GlaCo59i0l-toijSm3RywS88Q>
    <xme:PH2EZnXn3eFWOyyPGYvlfmIsfWIrMbqaPRzAn3rnRo-gl-DlZ_-EKyDDvTJVWJqhl
    EcZDKrczer-EYvKorw>
X-ME-Received: <xmr:PH2EZgIDq1bX6DMydoxB9OEKo2QofP6ZwH55BXV37xOm9ZAAnvhh2JtWtTtmFabCOifBbyXPYcRHkajrbw_rg2zPCGBhpaQO4yRT4azFJcGuKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:PH2EZgGAP1Id4M5aJzQ6uKmoG6vPkDjaqc-R4Pbg_-zAVqCsV1bnIA>
    <xmx:PH2EZsUqOi0PLDqq8M_jiKyoylZkxHUSKGvx08KKQ3moUvW_DbMjvg>
    <xmx:PH2EZjPQs0huHzBscjuYVekDRHqXDDZSb05NJ3yXHRAScJhoUTY6_A>
    <xmx:PH2EZj0JPx0awyZnEXkw1TBxGiW47PKV3VV_VU8nTc0-w41zFUqm7w>
    <xmx:PX2EZpjrUzvSzVTJQxndpEmAWd9Qq7fvehswmdajeCp7asm-JvIVY6Pg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 18:20:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] firewire: ohci: use inline functions to operate data of self-ID DMA
Date: Wed,  3 Jul 2024 07:20:33 +0900
Message-ID: <20240702222034.1378764-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code of 1394 OHCI driver includes hard-coded magic number to operate
data of Self-ID DMA.

This commit replaces them with the inline functions added/tested in the
former commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 12 +++++++-----
 drivers/firewire/ohci.h |  1 -
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 5b90ca72fa64..c95f26c74e2b 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2003,7 +2003,7 @@ static void bus_reset_work(struct work_struct *work)
 	struct fw_ohci *ohci =
 		container_of(work, struct fw_ohci, bus_reset_work);
 	int self_id_count, generation, new_generation, i, j;
-	u32 reg;
+	u32 reg, quadlet;
 	void *free_rom = NULL;
 	dma_addr_t free_rom_bus = 0;
 	bool is_new_root;
@@ -2028,7 +2028,7 @@ static void bus_reset_work(struct work_struct *work)
 	ohci->is_root = is_new_root;
 
 	reg = reg_read(ohci, OHCI1394_SelfIDCount);
-	if (reg & OHCI1394_SelfIDCount_selfIDError) {
+	if (ohci1394_self_id_count_is_error(reg)) {
 		ohci_notice(ohci, "self ID receive error\n");
 		return;
 	}
@@ -2038,14 +2038,15 @@ static void bus_reset_work(struct work_struct *work)
 	 * the inverted quadlets and a header quadlet, we shift one
 	 * bit extra to get the actual number of self IDs.
 	 */
-	self_id_count = (reg >> 3) & 0xff;
+	self_id_count = ohci1394_self_id_count_get_size(reg) >> 1;
 
 	if (self_id_count > 252) {
 		ohci_notice(ohci, "bad selfIDSize (%08x)\n", reg);
 		return;
 	}
 
-	generation = (cond_le32_to_cpu(ohci->self_id[0], has_be_header_quirk(ohci)) >> 16) & 0xff;
+	quadlet = cond_le32_to_cpu(ohci->self_id[0], has_be_header_quirk(ohci));
+	generation = ohci1394_self_id_receive_q0_get_generation(quadlet);
 	rmb();
 
 	for (i = 1, j = 0; j < self_id_count; i += 2, j++) {
@@ -2102,7 +2103,8 @@ static void bus_reset_work(struct work_struct *work)
 	 * of self IDs.
 	 */
 
-	new_generation = (reg_read(ohci, OHCI1394_SelfIDCount) >> 16) & 0xff;
+	reg = reg_read(ohci, OHCI1394_SelfIDCount);
+	new_generation = ohci1394_self_id_count_get_generation(reg);
 	if (new_generation != generation) {
 		ohci_notice(ohci, "new bus reset, discarding self ids\n");
 		return;
diff --git a/drivers/firewire/ohci.h b/drivers/firewire/ohci.h
index d83fd4731d56..71c2ed84cafb 100644
--- a/drivers/firewire/ohci.h
+++ b/drivers/firewire/ohci.h
@@ -31,7 +31,6 @@
 #define  OHCI1394_HCControl_softReset		0x00010000
 #define OHCI1394_SelfIDBuffer                 0x064
 #define OHCI1394_SelfIDCount                  0x068
-#define  OHCI1394_SelfIDCount_selfIDError	0x80000000
 #define OHCI1394_IRMultiChanMaskHiSet         0x070
 #define OHCI1394_IRMultiChanMaskHiClear       0x074
 #define OHCI1394_IRMultiChanMaskLoSet         0x078
-- 
2.43.0


