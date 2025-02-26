Return-Path: <linux-kernel+bounces-534052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A89A46230
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831C93B382C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC32222A1;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBBx+spe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BA80BEC;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=dLPQAcYF+x53LQkeirbE6pUayD2Z0euyKLnf6dun8az3Y1ejfBFcxHDsPXMsSC/PbQLcV+crKxRjZua2pv7BAjpP8USSYFwnvw232yjuoPXX25W2eHmhuVZNFwytXt5HRZJYAq2s6kCLnh0qE6UcZPyQ3PdZvymkVxLyLh/TBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=rfDn+KiVBkmx3nDlyBVL/TWI0/nwyuJ+FW3EGRqP6ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdY2GQuKTEalakpdap7zahX7XaMrUtp248C8GMh5b5hITQBb33jI2IVuCH52GHNcU5wyKo5qXAmG8VKGlngThk0sQCgwiNYF/eta+sP57K6jvijFJfm4XeOq6z9FaWNofMroAWT7XPsIDHK+BkT6Dz7dEerm4ofjDtHB5pew+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBBx+spe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3396C4CEE9;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=rfDn+KiVBkmx3nDlyBVL/TWI0/nwyuJ+FW3EGRqP6ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pBBx+speW0xpfNhtMDTiYGRYbQ/Q5EeqP+uBinXNqJial5ntCD1tE71qjsNxn1mlu
	 LTxaw/B+ls5aNu9Ss30MSedBLYp0UFWYdAZFJBtb8+NpKWQYQg/WvnkqnMfLFX6YwX
	 pPzVFhbUgfyzVPsKf4+mL7vZycA52+az7cDPxi7lEF8pz7Xzp7xwQciU+Aukw4rGx/
	 +RKK6tMTVM0baLB1yNG3/qZCmSuZEylio1puI3oaKIkwqgcJv/mVBtxobeSzVX2zEm
	 n/AWLLntmWBB18zdoBDgUJH1U0PRinZ6dWJtpBab6Yfd6/BOdsTgyj/ADpuGOCRSnl
	 3K4sq1+SKQ/pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B4C18E7C;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:25 +0100
Subject: [PATCH v2 3/9] usb: storage: alauda: Use const for card ID array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-3-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=1734;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=xAXPKBDwOOBoB15BevA7fkgOtiFU68x7gTE2+hUwyPY=;
 b=xV5Vhk4iWlyer4unDR4p2EIq6gdYddi2WvMjqMUq1gHJvZJs8Ts0KzxzgmSAK2Sa+elAhzkpC
 QDam+rQUI3PAH7RqCGQWhe3XJIL9bR+31UJhZp0QuAsdI33PHVm1cHi
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

The alauda_card_ids array is only read, and not modified.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V2:
- new patch
---
 drivers/usb/storage/alauda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 6263c4e61678e890e0192c5c9dad9b97dbaf0e66..e01f3a42bde4200da245c17abd5299c062868204 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -174,7 +174,7 @@ struct alauda_card_info {
 	unsigned char zoneshift;	/* 1<<zs blocks per zone */
 };
 
-static struct alauda_card_info alauda_card_ids[] = {
+static const struct alauda_card_info alauda_card_ids[] = {
 	/* NAND flash */
 	{ 0x6e, 20, 8, 4, 8},	/* 1 MB */
 	{ 0xe8, 20, 8, 4, 8},	/* 1 MB */
@@ -200,7 +200,7 @@ static struct alauda_card_info alauda_card_ids[] = {
 	{ 0,}
 };
 
-static struct alauda_card_info *alauda_card_find_id(unsigned char id)
+static const struct alauda_card_info *alauda_card_find_id(unsigned char id)
 {
 	int i;
 
@@ -383,7 +383,7 @@ static int alauda_init_media(struct us_data *us)
 {
 	unsigned char *data = us->iobuf;
 	int ready = 0;
-	struct alauda_card_info *media_info;
+	const struct alauda_card_info *media_info;
 	unsigned int num_zones;
 
 	while (ready == 0) {
@@ -1132,7 +1132,7 @@ static int alauda_transport(struct scsi_cmnd *srb, struct us_data *us)
 	int rc;
 	struct alauda_info *info = (struct alauda_info *) us->extra;
 	unsigned char *ptr = us->iobuf;
-	static unsigned char inquiry_response[36] = {
+	static const unsigned char inquiry_response[36] = {
 		0x00, 0x80, 0x00, 0x01, 0x1F, 0x00, 0x00, 0x00
 	};
 

-- 
2.48.0.rc1.219.gb6b6757d772



