Return-Path: <linux-kernel+bounces-534057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696E5A4623D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FBA169690
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CF226D13;
	Wed, 26 Feb 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6x+Y3e8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F89221737;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=UN2TBG4JkHMKVZ7W1aYP0HZSi45GRrS/Aul9c2RK2+U8XsX+tTbLbD/MjxPMIVHpi9VGH4n/5m52X12isGFzD6meu+0fXaQ64MkhOwjGHrzJU88tBo4Gi6nGVyECN0/BSL9e4GaEkYjMXBu/u7dLiAn79rBwCJkpl0heclFmMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=gy9L3x8k8B5gcqzVvt2xn24gsfsjDplxAJqQiUm8/dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnNNnZ7HpP1KLhQNYoi2IT6tz7PCXwBpF2ZLa7N+GUAe3Jjhyckw+4ceZCLP5IsyvLcfwW3QkS/6FOfGYOa8wjUnT4EmIyMpSYTVmEyjQIZogxSBCoq8ijNGK8brBdztgzEpKRfDCJWtU2BC52CxXB3l/VtysTb4FPFxgnKWiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6x+Y3e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E350DC4CEEC;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=gy9L3x8k8B5gcqzVvt2xn24gsfsjDplxAJqQiUm8/dM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n6x+Y3e8/cqwIwZwmYUUL+IjveLn6g+aCuv5NGCs/X8NCRyHvXgdWAiJUCPNlSBNq
	 P3eD/8gtFjK33LYz+uLbVv/JQUIhiAFYt/z+2/MoupPAwwXXLneUDz6pmd+w29XsJI
	 KrLzKI5henG3vc93+HSh4IR9oAv8QhBd7t8QJsu1YFQtcVG6c47YSNWq4b2sgnbZb5
	 KvYozdEd96xdywL8RRLVA3/tQNcndDdiGXYA4lE6/EK9nuuzh9AEzATCoInuQBIjva
	 VMFPFAqubRGhRHvP16OIljt2uMpUSv4zkugSpNj4dq1kLdf7da36Ah0v2S4wySU/gs
	 2FAxFd2u2Wvvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC020C021B8;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:29 +0100
Subject: [PATCH v2 7/9] usb: storage: sddr09: Use const for constant arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-7-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=2338;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=oiy7JMUiNsF7jAMsycKXLX9emEI7I94zOx6UYYuFPIw=;
 b=gx+Ezsp8uEFwYxCFguYAQ7PobyhDzls3okFaCAh+nL8rrv6XFFty+YUMMmwHnb7BhBZh5e4vk
 7dyi9axEobvADVttTncX8A31Uw6xBxvf/GxHsGOxZD9V2rqr3bBRRWn
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

The nand_flash_ids, inquiry_response, and mode_page_01 arrays are only
read, not modified.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

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



