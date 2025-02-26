Return-Path: <linux-kernel+bounces-534060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E259A4623F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C7417536A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2633227B83;
	Wed, 26 Feb 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMQ2D97N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761722173E;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=q30b05acZmFC53YTwFn0Vjd24RISEINjev8dEX3GKMbF0RYwRV+GrZxR5dGagRltMWPeI13RntbsHtGxAClpEEFd7bwU3OYKwOpNfaDxAKftQap7IyFhBQmdylttMyT7irqVXvCjMR69iHf/tIRsGmlUuK+hU6RZmAbQNQ2Z5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=3+NFvBIkl2OxeODbUHRWrngU00eA9zNm0aCEsh3XfoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjWtWu+Pt8OHKVidA/FsxVhhgwy6S/tDtg7n0yaB0aelMWZNnpcGQbOafcos1mpPuTdut+AtVSfiIidzEa1dQUg4wr2p3fWOIDPAKKmyCUY9rIshxyjumIWPfPfp3Yupln39LNg8qRV8xiiGxMcXK/tXsRiJJ5bGpiVdT1eUchM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMQ2D97N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7679C4CEED;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=3+NFvBIkl2OxeODbUHRWrngU00eA9zNm0aCEsh3XfoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kMQ2D97NEg1fnj8z9iPtJomtnu6AfWSQ0hkXTCGV2+A8azhcIJ0glpMjPQlIWRII2
	 tHQjGOoaFrxl1e/NclbWa6qBMcmEf8O7805AUw/LCMKBQkaXT+ZOlfYuge6k0vHFgv
	 DDuXgwrDoMxZK+KNlDAP+VCDuWsBtruFSLYmKxfNwztBBm/CpPzaPo8I9hw7m32gCo
	 fN8AcmRCgXayxYTtLwl5n6kSyIcKDzZXTV/JQbYD8/yIY1rHBSicEwbjof0RtFp7Fr
	 575VJiyN2oRsLBjFTYpxQ1P4PMpg1ys18FE5DY+h0smmkJ2L1VBbToM7uR1Xs1jgs9
	 Q7v8tyfaOyI5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC979C18E7C;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:28 +0100
Subject: [PATCH v2 6/9] usb: storage: realtek_cr: Use const for constant
 arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-6-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=1414;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=0nUrIAObJf+vvhJgWgBJJPr5uidrcg9fnFV47ZCiRf8=;
 b=yNC8wwiEJpTwvZ2ZJcdEasNQZyUBepYeM9CxLx3+7xPGzfB6agD2VCgDgaLyYzOPS/QjqWoKw
 keq/0ubOI4IAhaZzRPcNLUiTrJ1SF2xK8nJOoshhOdDNMNqO9LITQLs
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

These arrays are only read, never modified.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V2:
- new patch
---
 drivers/usb/storage/realtek_cr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 2a82ed7b68eaa75993e786afeda0d5d3a3c3bfce..4e516b44513672ebe7889247a70043e0dd013bc8 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -191,7 +191,7 @@ MODULE_DEVICE_TABLE(usb, realtek_cr_ids);
 	.initFunction = init_function,	\
 }
 
-static struct us_unusual_dev realtek_cr_unusual_dev_list[] = {
+static const struct us_unusual_dev realtek_cr_unusual_dev_list[] = {
 #	include "unusual_realtek.h"
 	{}			/* Terminating entry */
 };
@@ -797,10 +797,10 @@ static void rts51x_invoke_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
 	struct rts51x_chip *chip = (struct rts51x_chip *)(us->extra);
 	static int card_first_show = 1;
-	static u8 media_not_present[] = { 0x70, 0, 0x02, 0, 0, 0, 0,
+	static const u8 media_not_present[] = { 0x70, 0, 0x02, 0, 0, 0, 0,
 		10, 0, 0, 0, 0, 0x3A, 0, 0, 0, 0, 0
 	};
-	static u8 invalid_cmd_field[] = { 0x70, 0, 0x05, 0, 0, 0, 0,
+	static const u8 invalid_cmd_field[] = { 0x70, 0, 0x05, 0, 0, 0, 0,
 		10, 0, 0, 0, 0, 0x24, 0, 0, 0, 0, 0
 	};
 	int ret;

-- 
2.48.0.rc1.219.gb6b6757d772



