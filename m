Return-Path: <linux-kernel+bounces-534058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C44FA4623C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BCB188736E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0547227586;
	Wed, 26 Feb 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBR+PAyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C72221739;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=mJQTMPaOpwKWenM+wL462VUfMkWhgOGrui5kFN5cpM7JG0kahg5Xn6QMiCZZMnP2qB0u45jZszS90zcFKd0j+HKC92YZEz9f8rkELYBx7XiyBvFvNyVnFJ+3k5JfgLneqlYYhCiMsSSCGnqTwq2TXsqz6LUGfyDQ5M9eJ8W90zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=1RsQM3p8xDMxTY4Sd1Vra8yukKbT55Y/Ik1kgDjut/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAI0g3z2VkXuoPLm9sHOOA3yKis/5AcRyssA0kDUdZrtMsvyLC9RpjgG/iV+Eug8/3DYdQ0aMJdxY49LAuRFXn5kE6UXKfQh3X0vfwbmJo8M6RrjnkAA0ZyqDaChxggedGbmP3HQXXiQGYN+hH5wCoPnQ/y35MTQl2LmB0KgA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBR+PAyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F37D8C4CEEE;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579452;
	bh=1RsQM3p8xDMxTY4Sd1Vra8yukKbT55Y/Ik1kgDjut/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LBR+PAyEsMdbhP/NhDkSKd+vahPw7zOf04xi9xX0G4zAbJaNVokwxgLhHFYw7Ce1Q
	 2Z3JBOc+0Tcr89a01GVRkuq49v1iD8s7A5ymuEcFMgJhO3dhIl0BJ5E9yRYXlvM0Hr
	 S0Dj24xF7Us5hU/55AENwU1Njd+Ra1ueARN8xBqJCmheXiiWVJEqgnora3Q/b58KQI
	 a2/oafebUfCBWJRhgYPJmLtNTN9YtP04lIQ2uF0J4M+sqxYpxcwArak3BYQB5yGHM2
	 HxkBCHwMasl0UMqQ6Ud0KJ8cPF0fSkx93A2tL0yYi1YHra0Fy5XGAC8v+5zfFrKVIJ
	 H/9H3JA34fdWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84AC19778;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:30 +0100
Subject: [PATCH v2 8/9] usb: storage: sddr55: Use const for constant arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-8-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=1112;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=C7r28z1CFDV+sjQ7yiPOSMNteEWeKSpRUku1z3cAVDw=;
 b=YuvuOBJy+MirOAneLt7BuRHA3K01RUAXy/oJzPdR4gMU/FUr1G0Dut5fQeBkMLP3Mqei9WLw5
 /KKgx2FY460BuIB3Lj4iv23TkpxIWhNYdfxfbm3NITH3RwC8Wx4X46r
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
 drivers/usb/storage/sddr55.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index d5cdff30f6f31f98d3d58ffcdd2426d7cd385cbb..b323f0a3626031905b946ce64ddf04539a6e3232 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -775,11 +775,11 @@ static void sddr55_card_info_destructor(void *extra) {
 static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
 	int result;
-	static unsigned char inquiry_response[8] = {
+	static const unsigned char inquiry_response[8] = {
 		0x00, 0x80, 0x00, 0x02, 0x1F, 0x00, 0x00, 0x00
 	};
  	// write-protected for now, no block descriptor support
-	static unsigned char mode_page_01[20] = {
+	static const unsigned char mode_page_01[20] = {
 		0x0, 0x12, 0x00, 0x80, 0x0, 0x0, 0x0, 0x0,
 		0x01, 0x0A,
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

-- 
2.48.0.rc1.219.gb6b6757d772



