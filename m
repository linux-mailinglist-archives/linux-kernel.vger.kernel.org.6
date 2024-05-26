Return-Path: <linux-kernel+bounces-189617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6668CF2F3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C0F281894
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4F08F68;
	Sun, 26 May 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Y7Re1F/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtdQLRS4"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D66FD3;
	Sun, 26 May 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714647; cv=none; b=gIGiS0ErdC/TXCuKBCHdJf5FunYyoR+vR5YcVqWaH7kNV7DhiHyEL+QNeP9KSTqOrO1Hvb1wZMg6kdRDMQnEPJsRP7ehg7E/w9tylpR3p/aevrMptg2NcKg2wb+pxvHUzEf1e+5nfN48kmFDZqrJ1HiJLUitq4zTmjlifXyNBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714647; c=relaxed/simple;
	bh=8CrjV8UfJrDF9O25lLIHM93qe07O22Mo5Dlz1E/1Gw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe13ZZRDqxNgQhBuBBsGtkLgE5cryexl+t1ZeNWLb/WGKoIu0ACyuvZ5jPCZDySg4or+VKbgBKhMpcyFkPzaA45dYCEd215nmgkTWXj4n68EDzQGBograa1K/i3IQmcFHOFH6rehmzqIUDELk5PLEzTvknN1uwpLOH2upEuoxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Y7Re1F/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtdQLRS4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6F6D31380118;
	Sun, 26 May 2024 05:10:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 26 May 2024 05:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1716714643; x=1716801043; bh=mKJHgmashDivalhHdFKG0
	1oCbJyBiIOuYrEgsZqZ19M=; b=Y7Re1F/noP48dAgZTLxVjKMpXSr8/yQZMVft5
	+7tLLT/smXcdcIGuy+bVkqhsgjNWKVR7vKP1D20gQe4iYb+WXqw3WiBS2GF6iun5
	jKUtDMet+wVK1CQZ1zE+Wv/QHNaHe86WAhlTsIpZ/Du4LT4s7RPWDuDNGufmxgOT
	VTYYMPZKqkMZ3ER0TA1Q/dFLEu6tvC+gOfFOrS6YEa8a/o5MPPUQcm23IwtNThIR
	cVX4xVW1k7Nb5cqiUdnTZDcaF9y+QKtBSKRYz4TYm69mZQRzV1R7VDkV8ZqJ1GnC
	i/N+9MH2+j3V023aK7yP4oTtQDFA4+GySOfOh8Op3JR6AlMNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716714643; x=1716801043; bh=mKJHgmashDivalhHdFKG01oCbJyB
	iIOuYrEgsZqZ19M=; b=KtdQLRS4e3N08FFSCAYA3VFIkLyEw7C1E6aCfL5S9/DO
	iYOUqre5B2LoyNmv1oSRylm9mB+FOu4m3Ne9D9gifPlMyKRXpJnnWK8bla8mMZ5N
	I+/h/2UBcnjNeMjqTnY9pRcGAyu8wsTy3hLNyP4LMvWm5UeY3NVyiC77ju9HpQrV
	58zu7H9McNrhzUuhkRhtIAZjV7A4YUOTq7WCmGWSivHuUVbnWw1e0VgopopZqbEU
	G69lUl+V9KTlZTCTtxRgs1xmOXMs55A46m8F3AGjtwnG4t0Pq7VIJhgn+rpYcxVZ
	8vCpdscuqAGt4myG/+Qn87Ac2L/hISiwyvQvFhoLWQ==
X-ME-Sender: <xms:kvxSZk16d1uB0y4nVBOwCXLjcuwJoYoWj9TACTafr3l0lCb5BlvD3w>
    <xme:kvxSZvFcshYqeBZZpZ-pP1uVUqubIFZOjVLVXeH_iXmut8TkHUsOusWpqyVU-iKns
    ObMK6b0KVNdWtRJ8CU>
X-ME-Received: <xmr:kvxSZs5w_ozVTQhrr6dyyXs_h1qnL4Cr9SuQCdcba3UhBR87KstWJ_CA8XNB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:kvxSZt2HeohLAUpH2DdrfYivtaMgDf_yfDm8OjA3qyyAlbk1fGK3vg>
    <xmx:kvxSZnErPFRI4c_9utuTRKee1nOOrh9SoJ3v30pbw1kNef3CYLtUMw>
    <xmx:kvxSZm-huHdfEecbT3bTpKUZjnO1yOdHvoOnPV1T0qqANtmjTH2Enw>
    <xmx:kvxSZskHmGFnvQW1mNpi8lJ26y8TtUEoWmhvRvekGNguLkgRM6zk9Q>
    <xmx:k_xSZv97OHsuQbQrmnToN2sjYJmzo1-937i5TgUetwS-TB-4Mo_ppavE>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 May 2024 05:10:38 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: tiwai@suse.com
Cc: perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp
Date: Sun, 26 May 2024 21:10:32 +1200
Message-ID: <20240526091032.114545-1-luke@ljones.dev>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2024 ASUS ROG G814J model is much the same as the 2023 model
and the 2023 16" version. We can use the same Cirrus Amp quirk.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a696943aec0d..df86108f4fe1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10307,7 +10307,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
-- 
2.45.1


