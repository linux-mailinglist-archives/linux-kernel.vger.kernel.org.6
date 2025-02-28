Return-Path: <linux-kernel+bounces-538770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D87A49CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3603B07EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DF2702DF;
	Fri, 28 Feb 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTNcsXp6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A71EF370;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=U6shN7mcZZxyotl4epGNOP5UaN14vbP8EUwzW18D41FWcdeaXagzOB+iUMsayVt6UcC78IcTvZU4681pw30jA5MFiFT235gi6IS0Osc3mh3RwBGQaPMNwOS25UwgKW6Q/kdjIyGuPIje7h0JicpyFYcwJFkploYwrPUj4vSmjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=cdSuKnT2sd9mu09u9x2uroSHcOnXLi4YExIlWOzziOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJj0GEmSKD1zW7p0T8oRigW6sEDGWIFxY2gBG9hNS/tHL1mJTS+Pwrk+MMETlym0Y3YmD9rO1auWO8Jg2VTnIJEH38D9MHotj+tkB4FI4VK5jUewTUgSrYHOPDCuQZfMDxDrcacBFH2jGfTuJunucsELIjC4uf1Y6tbWlUuiA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTNcsXp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E628BC4CEE9;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755494;
	bh=cdSuKnT2sd9mu09u9x2uroSHcOnXLi4YExIlWOzziOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HTNcsXp6J+YGrdD7hmDLy33HufXX/fo7Kn9p2OXZf5u98oGzEZFrcnVmMP37xlhPu
	 FT0gqiCklBiWf9cbXrRLbD0aPZ18WLOfYnsbROUuaUxX6KEa7+orbvhSqfA73wswe/
	 KFXIWWshQOpJA8DBMaRRyuLFwpzxJKZR73EOg80VN4V/tvdc8H2sA13BcV4PplwWFg
	 OLMPNzYLOxkV8FNnMlX9Wiq6qjAEJAItYRbISFmUwAHa66FU/9TVuRyi5/zJTQlNKM
	 G/OMq+BQbI08AjxNZ8IZt5lCUWOmI6HU8HJZ5/DJG9kVRBrjDeEPS1w3VEvKJXpC7A
	 HEHiYMi72ULEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA7C282D1;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:19 +0100
Subject: [PATCH v3 4/9] usb: storage: datafab: Use const for constant
 arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-4-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=2538;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=yfxYfaF8Q7PIxOVWEnYYboHL7YcgLcujoqn0SQzuem4=;
 b=JbKx0x32ZLzV6QqtxmDJURu77gmnOpKmN1kohJvtrdILXcI6OtZbOs9C5+mjbgi2BQLx08CP4
 Ovc0j/bPp/SCwW6sBmUDyP84ulfxo/kJP/4ih3aOhtHb9wpSKqz3BBY
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

These arrays are only read, not modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

V2:
- new patch
---
 drivers/usb/storage/datafab.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
index bbfa2398b17036f431c0692bbf794bdb01d68cdf..9ba369483c9b36c2f662749c32bf81b525ae897f 100644
--- a/drivers/usb/storage/datafab.c
+++ b/drivers/usb/storage/datafab.c
@@ -319,7 +319,7 @@ static int datafab_determine_lun(struct us_data *us,
 	//
 	// There might be a better way of doing this?
 
-	static unsigned char scommand[8] = { 0, 1, 0, 0, 0, 0xa0, 0xec, 1 };
+	static const unsigned char scommand[8] = { 0, 1, 0, 0, 0, 0xa0, 0xec, 1 };
 	unsigned char *command = us->iobuf;
 	unsigned char *buf;
 	int count = 0, rc;
@@ -384,7 +384,7 @@ static int datafab_id_device(struct us_data *us,
 	// to the ATA spec, 'Sector Count' isn't used but the Windows driver
 	// sets this bit so we do too...
 	//
-	static unsigned char scommand[8] = { 0, 1, 0, 0, 0, 0xa0, 0xec, 1 };
+	static const unsigned char scommand[8] = { 0, 1, 0, 0, 0, 0xa0, 0xec, 1 };
 	unsigned char *command = us->iobuf;
 	unsigned char *reply;
 	int rc;
@@ -437,16 +437,16 @@ static int datafab_handle_mode_sense(struct us_data *us,
 				     struct scsi_cmnd * srb, 
 				     int sense_6)
 {
-	static unsigned char rw_err_page[12] = {
+	static const unsigned char rw_err_page[12] = {
 		0x1, 0xA, 0x21, 1, 0, 0, 0, 0, 1, 0, 0, 0
 	};
-	static unsigned char cache_page[12] = {
+	static const unsigned char cache_page[12] = {
 		0x8, 0xA, 0x1, 0, 0, 0, 0, 0, 0, 0, 0, 0
 	};
-	static unsigned char rbac_page[12] = {
+	static const unsigned char rbac_page[12] = {
 		0x1B, 0xA, 0, 0x81, 0, 0, 0, 0, 0, 0, 0, 0
 	};
-	static unsigned char timer_page[8] = {
+	static const unsigned char timer_page[8] = {
 		0x1C, 0x6, 0, 0, 0, 0
 	};
 	unsigned char pc, page_code;
@@ -550,7 +550,7 @@ static int datafab_transport(struct scsi_cmnd *srb, struct us_data *us)
 	int rc;
 	unsigned long block, blocks;
 	unsigned char *ptr = us->iobuf;
-	static unsigned char inquiry_reply[8] = {
+	static const unsigned char inquiry_reply[8] = {
 		0x00, 0x80, 0x00, 0x01, 0x1F, 0x00, 0x00, 0x00
 	};
 

-- 
2.48.0.rc1.219.gb6b6757d772



