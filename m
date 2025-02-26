Return-Path: <linux-kernel+bounces-534054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93CDA4622E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16917C1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F522222A0;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyYM6wiO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D599191F6A;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=NzOGEBlhMn8woJV1gHT/EI8x1mxK7wy9Qzmjoq6j1e1yJtqrSqAggx0fn8D6idh9yeINwlzc2KHNwHHkmH2760OzfPu0HBVTbt3LDcLe7qJIAjgkHdlC2gj11dGOGXVVW1UGlQpsln0qX/j8jJrgD+qqkBqmI7hvJ6JXvGlNDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=cG41MNyc8x+QEktsxSBjUBrLBNatZCQO437Ub1tz6tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNF+s6rMr1A88NBAO/I49qtuve0CczNvxWQ1hFIfd/ydS9tpFg3XcnIYLFrRVa3p3EZPPy7cndq4tazI+nd/+au3sndGL0VPulzsMHRo4A+cKIkpV/e0piNbwBYXfL+6NcPVJ5GqJNZ0gutBrEfqCdF7QzAyuLFoVQpAa+N6LpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyYM6wiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B64EAC4CEEB;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=cG41MNyc8x+QEktsxSBjUBrLBNatZCQO437Ub1tz6tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YyYM6wiOjALYvTxi8K3R7VtOMav2exWrbFdZhEFvRg6f1/npY+1rPhQ4tjtB+BsEx
	 6CeIHhZ3tMPf173fRjOm8F1+1hdl7GC7NrdjGEBzptik64GLE603IGbSwJ8Evf83WS
	 MtXTCUHeNCra4I3mDauss/+2KyFPAlUh0gzQL5RykfEn8bni4LWCBhDEUg2ZyTLVIC
	 trxsIYz2tqc4Pme/37fdXCZu+sts+BuuYZUOqvbuHFTkwyWTFIruPnuCjzpY3jonzQ
	 QQrjOeBIM73anKJ8UJBXZ1akupsZFJ6inklX3Xi8soCtQ829gEIP56ACy4RcczDLr/
	 FBEJ4ZnO1dQig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84DC021B8;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:26 +0100
Subject: [PATCH v2 4/9] usb: storage: datafab: Use const for constant
 arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-4-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=2349;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=5889APtKFFab054l3Ee3spnWaj/UxBWmua1IlElw8Hk=;
 b=AU338qvvEAePEg9jLLeMUgQzbkLqosqROpA/Ngu4KxLu0N+nAlUKqOim3VKzHIX3mqqaxeZI3
 G8p/zLIP7eqDxP/YhPj6atkVfpOeIsNmgqt3iUYzyhUsbrC2t/R0+9l
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

These arrays are only read, not modified.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

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



