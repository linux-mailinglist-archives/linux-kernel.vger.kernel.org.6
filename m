Return-Path: <linux-kernel+bounces-534051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03920A46231
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAE7A3413
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F85221F39;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmIzyOHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D543155322;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=iwlpxYF4BRz67rOnEbUCk3CU/i2Sb1gJZ0hkg6HRQxEPC5mvCOJdm2aWZzUeoM4w3RUXswIeQqe1qx+HtKZeL5WkngoGqOjSt+S7/vkJOhywzNvQ7Xu11G+qHLnqI3Ep0wkVJFh0hZF2/dnohYiTtJWQFXhfl+dcInS5CbzKuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=K62ixmOjU179BilLrdtMX6NMlsV0HPw/mur95lpLVjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c69UKfxECip85M0o1n7lmC8BmB7BcL6/OWKD+lWXmCXmXZNWv93AU6QUpyF9B4pCyGKqGxd4bIEJDdBEPFFWxXUOe0mm3+ADcfL8f09mDbVYVqAnAf/45ZpdUlGjUG9vgx/WEzsjwh/uGGV8JzZCkEOoiSwZkthVT2tVJlRGoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmIzyOHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A5E7C4CEE8;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=K62ixmOjU179BilLrdtMX6NMlsV0HPw/mur95lpLVjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lmIzyOHizCaZAju2C7IMkuP1LCgDwS1SCRcJgdom4UZcwFz0ux1rjS6idA+OsYZMP
	 cyYW/K0QqKlFkTt9aZNGeO+2jkmT08Zldu9fXuKn0Ey+Iu7xagGGXoYZQ7zyn+0UYO
	 zyI7R3szjrYiK7NrdxyZmEraVgWXh1429cvHb66daurqDCMgApvecY19QKyyCJ7JA0
	 jSAlikAdGSd2UTq3TGRMPQo0CvWPoKykqKAwnJrHBFvg62NTHEon3PGFzuGVuMMdW8
	 YTQNA9Ue+U9FGFYkIzyK2+K5O+xVsTuzK/EAHp7HNTDhvlaiapFpQWfaAmWMJF5m/m
	 xQuLJL5+pdTBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B714C19777;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:24 +0100
Subject: [PATCH v2 2/9] usb: storage: transport: Use const for constant
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-2-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=893;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=nCzpJM3/zudVjCfMlG+Oo6xwILkwbL682EKLwocy/kg=;
 b=lyHT+26EK6qmfohCAo8e05Ihj7lHLa719aBwcSP2MiZPYO0GbADJ6SUOjHAwbrtTUhbp7Hzbd
 XiK5kPyOekHAamnhE5wM2hnDdWgAwBL7fJHb58K46jDRw+2dJ32C44L
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

This array is only read, not modified

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V2:
- new patch
---
 drivers/usb/storage/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index e6bc8ecaecbb202714be69c6db6b0a4824de4855..1aa1bd26c81f2f9fbd508fdfed4465e6482bdef0 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -528,7 +528,7 @@ static void last_sector_hacks(struct us_data *us, struct scsi_cmnd *srb)
 	u32 sector;
 
 	/* To Report "Medium Error: Record Not Found */
-	static unsigned char record_not_found[18] = {
+	static const unsigned char record_not_found[18] = {
 		[0]	= 0x70,			/* current error */
 		[2]	= MEDIUM_ERROR,		/* = 0x03 */
 		[7]	= 0x0a,			/* additional length */

-- 
2.48.0.rc1.219.gb6b6757d772



