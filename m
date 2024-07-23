Return-Path: <linux-kernel+bounces-259520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348F9397C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134291C217A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498713213E;
	Tue, 23 Jul 2024 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="KpVFC0rm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKv7suAr"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0DBE6C;
	Tue, 23 Jul 2024 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697159; cv=none; b=WODYb1YjKkqXCi+I4Z9MWwBLlRcVXDJoo6zJFYcL1atI6kHqA2sEn2hKvljPPfGmpNcWeT3/NGMNvOWZRZRzqY+LKuTbMyWVPxLRvfIC8BUoxo0rdUGji5jB5Z1leXzPwugZ/sSWhxRiBj06GNxfJvLkKeppiwRB2NowYQGaO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697159; c=relaxed/simple;
	bh=IkarGNjUMzsVK52tfxhA8TBBu+FmIkwAa4o85lxFhdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doaY4+aP3JC4+97ocrI6fuCJ+uEs97l5XK5VJZlcWsRuQdGeZ+DGQQ1VH/jPeqckRLyKR3EB/V/sr/krYwqKETEu6imqozCtXWYD6m2tuUxvYlCZKFobC63p1wvi6zH25L0RnQp5RATiTf+gdPFpDCkWk9lRx11Apy95waulCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=KpVFC0rm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKv7suAr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5430311400F9;
	Mon, 22 Jul 2024 21:12:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Jul 2024 21:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1721697155; x=1721783555; bh=ZsmQ0WLvV3wDMpmJh5hyy
	IvCia9aqqRrsxaRN9p9k8M=; b=KpVFC0rmyRJnigwIgmW4XYPH60IJcPbH7Dc78
	U2IqzbUOQoW9zyZwllTOkuoOe8E+pIMsTtACefOifJi4tb67jHCjmV0Hq+ICQ/c2
	OKWEm1PmTntt7hs40Gb8ZEAlJ/9laUWeJSMqHA50M5s20XaDkT2AxHlVaZ/WQrgP
	5ZWGI9TACnvP7TfqzWMJCY1VYKG+2G4WZOt2dY9yR+rbO7fIrZ+bjOFcP+NxAVZd
	NcfQq2MvAGTJU2jP4etjZcg/SisEqtxqfVe0/PAcFSXT9KvVPWTcrB7EJpkY30gd
	lTjmrICW29BTmBvMBCUiin4qL4HfyQsZ7EDtV0bZiDpoNh5lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721697155; x=1721783555; bh=ZsmQ0WLvV3wDMpmJh5hyyIvCia9a
	qqRrsxaRN9p9k8M=; b=EKv7suArKyv1KxMz5+Km0n7urw9Iq+7BVd5arkYsLzMx
	p/8IGVV05ICK1fK/uXSXcnPYQ03fYJt4s33AYRPrdF+FlSWCIDngSy1RAe1jxN36
	R8xPGJltsY7My1S2cmd+sD/3Uxy5wPRBJXW8Lhp0xKgcBsYB4EePeMvOXVAEg3CP
	xPLuk9+P9DwRriKCldxHFTWuvuwRYXq3H4+1oFEa0FAZKellDwtyZHDjZU+l9Ho4
	byFD2B09Ak/9mgoiAKYJr9F2+Tu2mlrYyADhYNyrsSfpjgXZDqoJkv4L7uG2laF7
	P5tyK82a9a3gkALVoNVRVb2HsmzFehuae3AVa8CNxw==
X-ME-Sender: <xms:ggOfZjFQ6CmAgQRN-H5jlopvQT4fwutWDFj-zDBYHmF8tCAilHiIVg>
    <xme:ggOfZgVHGEMedNKLutbz2Gwe1L8dFz93cEnSkeohonK8V-p_QqITJt6-U6RErXGRk
    jf8x0pWKiVd8x1-VfY>
X-ME-Received: <xmr:ggOfZlITISeNEI8t0fbJIaoPY_taR0WnhQoeVeVVswRJRiLeGchX3S7kjH92>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheekgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ggOfZhFS7JAU1-hHL1CntZJvu7og1TafzajtZzF0v76NfHiNaobARQ>
    <xmx:ggOfZpX7Saix60URPBTG-6tZq9v84q16oCm_UgpwRW7NvpWAg-7e3g>
    <xmx:ggOfZsOYysNJUFIkTuiHn21ajzEvUSk4cm1FA8egxBQXPXawCpAh-A>
    <xmx:ggOfZo3O48L4m-Rx3BJj2RvI1ROI8MvgpQnbDpKS9ggO3AghWR3_fQ>
    <xmx:gwOfZoGcZToV3IIcph0UAXMtNRukCAfB2rKwrkXc0pgppgot4DbdqnHy>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 21:12:31 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: tiwai@suse.com
Cc: kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: cs35l41: Fixup remaining asus strix models
Date: Tue, 23 Jul 2024 13:12:24 +1200
Message-ID: <20240723011224.115579-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust quirks for 0x3a20, 0x3a30, 0x3a50 to match the 0x3a60. This
set has now been confirmed to work with this patch.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 766f0b1d3e9d..e61c5924b4ea 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10360,10 +10360,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
-	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
+	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
-- 
2.45.2


