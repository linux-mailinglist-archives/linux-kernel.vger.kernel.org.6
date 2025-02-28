Return-Path: <linux-kernel+bounces-538771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62352A49CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7921893E54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C247270EA4;
	Fri, 28 Feb 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkkhCryX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D91EF371;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=aQgzKvsK2e3dSdlhYbNwuj7jhX1eGANDG+Z/MW9O8/IF4opY8bDvF0IMCB9HV7Z5IRmKeRtXF3EglHnw/PFVnZsODYb/1xUzSD1VlsVyxVL5kwNDuJEhcFObxNWXy7FtorQGaPIojJx+177cp0aqGwofDSlEvm3t/fcVGlmYYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=aKlncfAD52qhbmB8otrNB1dlymN8jkXdFtomJldZZM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGXjPmZI1tUpYbvgJN0dRaC0zmanJAPiDJex+ehvMtnKwAPwjJ1TzBlWMwfLpNHFIVuEvV/+fH0yTQy0pdnv8mo5al+i05YWCukqvi5Sn7z4i4nsGoRb43WUTHc30r/Lp/2TIVEFHx+DkBUmiwtOi03XaSlis+68tmnvQOv/sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkkhCryX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB57BC4CEE8;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755494;
	bh=aKlncfAD52qhbmB8otrNB1dlymN8jkXdFtomJldZZM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CkkhCryXjjPzHl0z2JkQfQnjW6907M3nHF7bug2FHcUN2BCfOjOYTGuvcoTq6ePjJ
	 CfuyNuYDwChXY2fixNyR2H9JK/a3yrikL8eXZcsrSQppQybuNrY/CxKf7Clil3QUj/
	 Ri/CY555E7fSLp2bXLkzmkIFkudxSYI+81WfrmDgskc/8BAUfUz/B3mfR1rqX119YD
	 8K9Q+hAIJgrBJN+V8tuiB5mF8kWB+MuXyM1hThC57lh9CWRrH8wzNv0H6zL3uMmB9+
	 qk2BCs8s7NyDQQKgovFswrZQvJ+yMrxnZ+Fr6NTg6vD9+KoPBIXLh7wOlQdueuHQ4X
	 UxPFDpK7wqWTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC35C282C1;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:18 +0100
Subject: [PATCH v3 3/9] usb: storage: alauda: Use const for card ID array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-3-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1923;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=AZumiHFV94k9HcBLZR6/HqBt2YaBXyvzIkuQ2zvtWu4=;
 b=7qv1Cd/INWh/lZF4QpH0wu5HRq6qdQDZ65XW11dcqRHlPkoDgZDiwVk4a4xitAUAuiBPD5d81
 W4RebuHnTelCFEKEumtfyEZXcIfLfczTk/A2gxSoMLMYfDFUA+m+G+E
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

The alauda_card_ids array is only read, and not modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

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



