Return-Path: <linux-kernel+bounces-538772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43341A49CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1EC1895861
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DA27603F;
	Fri, 28 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtM7GyPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8951EF385;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=uvYRDaEwsXblaA+S5z18vg5kOVjYo7lsocs92K/LxIl5dplbhGNAkD1InG7zCOJ7lX951BfTS72ox4Yjvo3O7iLHXteP5Ss31SFmZCn87C/Z3GxNbuKDK2zZZfORsbaeabIUPbXy2I6q6x9CEC7JcQUFhC4g7iuPIJLbYvQuf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=Gq4AWL6AY/PqYXGSEP4IhXEpS+l4bIw3E4nTSJGtDgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQHE4K4bNJ0nhPGHuhv9T/bN9gZd8srL3Y0OV8+F7BnlxR64xZlF52lRd4zjePgSCF6ZnucbJvboDsMIhNB0ZaIC1zCTVnNOafN7wBMM/aJVpNp4qeRxJAzGvkCkBgqN3/5WG4LQr22VhgBO5ufhZmavNQKo6OE6Nl6ydB8Z8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtM7GyPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16931C4CEEB;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755495;
	bh=Gq4AWL6AY/PqYXGSEP4IhXEpS+l4bIw3E4nTSJGtDgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AtM7GyPw3HxmjuDvsKVmkYBvTJO3VGul0/t+ZmqwAjovV6kr+vbpSh/xQfUaB78hN
	 K1yh9xsA5RYMu72YmVXGz73AjP1HodEDL9B+xgqu/N2Z4Eq+FY1sgp/jfX7kZxHyhZ
	 2huNwJQnglDgrizsZotiwRastFNjIXUb0Vwc7LsbOYwistl0coOlR9wv9k0h1Ia5wo
	 xsOuPFD2jlLLDTc+uvh0Ucfzvt5wS/B3k2Hx0Ms393GQFatvhi9CtEA+KB11Wc67R3
	 nkf5dqUE0dsMVouvJPzMsI/LwjRmJ9Q0XKW5+Nd4d8coO70hDEiqUryIz6yr96kvbk
	 NEYpEIYe99WZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC97C282C1;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:22 +0100
Subject: [PATCH v3 7/9] usb: storage: sddr09: Use const for constant arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-7-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=2527;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=l+RAY2RPsx/JPY4RJUMnd+IPm3/INCAlkSXItxmAg4Q=;
 b=6WBB8ETU477ruMo1xN/6W31d5OrSbxNiYQANwHrc/DsmaKLwdBrF+DRVOFoMu9N0t3v79sAzw
 fcvHCUvcTgzCwytQJQ6Jy3SAAwJsxM9BFHnDSv5ViAJOp4K8plvf6Z9
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

The nand_flash_ids, inquiry_response, and mode_page_01 arrays are only
read, not modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

V2:
- new patch
---
 drivers/usb/storage/sddr09.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
index d21ce3466e25842757b3e278d522c55b7c1f19de..e66b920e99e25c90b581ff1f3eae16ed0cfd903c 100644
--- a/drivers/usb/storage/sddr09.c
+++ b/drivers/usb/storage/sddr09.c
@@ -144,7 +144,7 @@ static inline char *nand_flash_manufacturer(int manuf_id) {
  * 256 MB NAND flash has a 5-byte ID with 2nd byte 0xaa, 0xba, 0xca or 0xda.
  */
 
-static struct nand_flash_dev nand_flash_ids[] = {
+static const struct nand_flash_dev nand_flash_ids[] = {
 	/* NAND flash */
 	{ 0x6e, 20, 8, 4, 8, 2},	/* 1 MB */
 	{ 0xe8, 20, 8, 4, 8, 2},	/* 1 MB */
@@ -169,7 +169,7 @@ static struct nand_flash_dev nand_flash_ids[] = {
 	{ 0,}
 };
 
-static struct nand_flash_dev *
+static const struct nand_flash_dev *
 nand_find_id(unsigned char id) {
 	int i;
 
@@ -1133,9 +1133,9 @@ sddr09_reset(struct us_data *us) {
 }
 #endif
 
-static struct nand_flash_dev *
+static const struct nand_flash_dev *
 sddr09_get_cardinfo(struct us_data *us, unsigned char flags) {
-	struct nand_flash_dev *cardinfo;
+	const struct nand_flash_dev *cardinfo;
 	unsigned char deviceID[4];
 	char blurbtxt[256];
 	int result;
@@ -1545,12 +1545,12 @@ static int sddr09_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 	struct sddr09_card_info *info;
 
-	static unsigned char inquiry_response[8] = {
+	static const unsigned char inquiry_response[8] = {
 		0x00, 0x80, 0x00, 0x02, 0x1F, 0x00, 0x00, 0x00
 	};
 
 	/* note: no block descriptor support */
-	static unsigned char mode_page_01[19] = {
+	static const unsigned char mode_page_01[19] = {
 		0x00, 0x0F, 0x00, 0x0, 0x0, 0x0, 0x00,
 		0x01, 0x0A,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -1584,7 +1584,7 @@ static int sddr09_transport(struct scsi_cmnd *srb, struct us_data *us)
 	}
 
 	if (srb->cmnd[0] == READ_CAPACITY) {
-		struct nand_flash_dev *cardinfo;
+		const struct nand_flash_dev *cardinfo;
 
 		sddr09_get_wp(us, info);	/* read WP bit */
 

-- 
2.48.0.rc1.219.gb6b6757d772



