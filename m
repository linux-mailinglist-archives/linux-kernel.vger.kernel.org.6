Return-Path: <linux-kernel+bounces-357861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC8C997714
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB020B21DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF51E1A14;
	Wed,  9 Oct 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="TiP6/K6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="diN9xSGH"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320217C22F;
	Wed,  9 Oct 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507493; cv=none; b=GonoiEnZfOagf2GTGMc8NhQwVjJkdhoAR6W8zU3l+KcqtHlPrZWnZ2ihveMKFbm3hUg26xg3DREr+vCu/2Sk4GuqHBJSLqXky7kETX1qcBv+pHhuRHDIrdI5/gSi2D/owCchNw4LMz64Ftwfru/g2cjzOXjiHmtHSweZbnXsKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507493; c=relaxed/simple;
	bh=EmLHpmHu6fZJcx5a04tuUFq99wDdou69w9OymJbxJiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYcT3ptUekevB+JgwZkfnEimcRhju0tqN0fawEHD+Dc3P7pVgxUS2SXyJr9r7ozcFSlWs2sLGfuMKSQ6VZFRI33/6mEHj1Nkz9nODfmoVoeaArxD1AcGn5GCqJSScn+8MPFYIHzDeQrPVn/iL3IScQRBnGetEv8se5V1vpHRlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=TiP6/K6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=diN9xSGH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B1881380258;
	Wed,  9 Oct 2024 16:58:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 16:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1728507489; x=1728593889; bh=OXOcebiHEm292X92vQIjq
	ovPU1hccWDL8wKSy5ENrfk=; b=TiP6/K6ruphDq47Wm+/+3IaAzvTkzqc7bYhC6
	TrMG3OC9hkIUJEc4iVAhU4tCqZdZ8l1AHrwa/QrnwmYOQc7JohK6NFFpxXQuR8lA
	GBvwYY+jsTOkaBsH8o9KphkoqTtK0HNDUzeXLiFiQGy7M3HSXJryW1+wLRa+xY2N
	hzIqDRFMGCj6Md9WjTUbu963qfv6Zjc0r1RJGXOYfm/RI5WIUR2h2vtBfkLv9xGg
	kDGp/fV+PZ8dED15x7A0b8TijoOVT84Q7ZTEbrqevBFaz08TWWri4lelF2j/Tk0i
	CnblOWXaKXGZE7uDXam2GnCMjAxus7fN9T5xLxq/bL0QxkBqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728507489; x=1728593889; bh=OXOcebiHEm292X92vQIjqovPU1hc
	cWDL8wKSy5ENrfk=; b=diN9xSGHGgCZ189mf6B51D4e0w2o+dRR6UvtzU8sjqZn
	wefMzoSmfkqMMOgfFqUP9CayC2AYediLOPmUTuH3dQ1qk/TMkFOGLO99KaawxAFl
	41+HWSG+xM8obuZkKJFT2Kqb6z82hbnTokSksjUzd0JmzU3G9FmECyQUuitR4tLp
	GXkRJmvEdsA3zdMZmIvZCQYJhuvO9igm0dDpTImGr0rVXTYRn/jNMKdYILc/iSnO
	6x65ZnakvsK0pUkf0FAz+DtBa8TdpVZDheJMCo2c+LRAwO/Dp2mmpyObQkFPumuu
	3pijFvUdDHPUkw5xU3C/o1CTXRUOQKGQkN1Pck4/cw==
X-ME-Sender: <xms:YO4GZ9dwAkbEtHBiSr5rzDLmYsr9tlBnJ3l0GSPUaSbeerOXl4ureA>
    <xme:YO4GZ7NRlcDDNt70YAFfjAdJf2lYYOWrSkewVZpJyI7s6vX_vFl1cwKkvP_YxE6yj
    XnHxZcUiguoODA2lf0>
X-ME-Received: <xmr:YO4GZ2jzXqmTnDip3qf9Zr03xk1sUocLGdW2M-akvA-vRk8iwlIx4Tt13zeakA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghs
    fdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtd
    fhuddukefffeekiefftddtvdfhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvg
    hsrdguvghvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthhifigrihesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshho
    uhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhesohhpvghnsh
    houhhrtggvrdgtihhrrhhushdrtghomhdprhgtphhtthhopehfohhsshesrghthhgrrghr
    ihhqrdhmhidrihgupdhrtghpthhtohepshhimhhonhhtsehophgvnhhsohhurhgtvgdrtg
    hirhhruhhsrdgtohhmpdhrtghpthhtohepshgsihhnughinhhgsehophgvnhhsohhurhgt
    vgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepkhgrihhlrghnghesrhgvrghlthgvkh
    drtghomhdprhgtphhtthhopehpvghrvgigsehpvghrvgigrdgtii
X-ME-Proxy: <xmx:YO4GZ29_4ETh1xSuPfRVaItkIRW8Ydqk-OlnkR1Q5XgOx1kdIJhrEQ>
    <xmx:YO4GZ5vAq_76JzS9EvVl8PuudoZMUJc0fsPXmXY8LxTJfva9eYKfNA>
    <xmx:YO4GZ1Hg9jenfx8lLyoAheiFgntzAVZAQvZkarRz28IU_jVKyGQxHw>
    <xmx:YO4GZwPa7xwJFhEYDAz4Qjv-Xk-Ir24qtiw2fHHjg-2DMy8_dCN4RQ>
    <xmx:Ye4GZ_JZYLmnyK6Dr1BaQCbLJMacVQ0m0rlf5iv07N6IhEr9ON2d-ZKS>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 16:58:04 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	rf@opensource.cirrus.com,
	foss@athaariq.my.id,
	simont@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	perex@perex.cz,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: fixup ASUS GA605W
Date: Thu, 10 Oct 2024 09:58:00 +1300
Message-ID: <20241009205800.40570-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GA605W laptop has almost the exact same codec setup as the GA403
and so the same quirks apply to it.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 41e1119877b3..19b0bae074b6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10507,7 +10507,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALC285_FIXUP_CS35L56_I2C_2),
-	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_CS35L56_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1ed3, "ASUS HN7306W", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.46.2


