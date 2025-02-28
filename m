Return-Path: <linux-kernel+bounces-538775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B3A49CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CE17423A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2F276042;
	Fri, 28 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB/cChVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EF1EF38A;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=CpkJSO3zxUwdb6nczaSuq/fQ1bMi6K2YforUQ94rhN7k/TC3KZ/BG6/VBb3W/HCrV5MPphSa84olR1TeGFvjjvSytpDUXU+aVqcYp6ciFgRMsW5rfmH/eaPrdD1DbmGHPFtpf8dG7tdPNvFm8TR3CgZ5ILMD8Ik2omiT6EP7mUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=MiRF0uXvn34502afdF7reNDak4SO4C5gMDBkC3zfM94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsyxS2kppDDwp8Kjwm4/H+AhV8B+1YniNi5rfAEmWtha/UHgMRBgbMcV7WjI+yrygLMZ/Fk4E6z7xMOJliueLxkH2IkN5KT32OqP2Xd6fqrfZV0LUzTYigT5MtFWzYU4BxiP+J8MXVgFJvBEXeTBstwwxuzIyg0PNVrBtGsslEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB/cChVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A284C4CEEC;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755495;
	bh=MiRF0uXvn34502afdF7reNDak4SO4C5gMDBkC3zfM94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JB/cChVIs8fywSgJ0AO0xm896GpS7BWtrq/zLAA7GeY/WNoxedEiTKCAA7aYDOq9h
	 cPbMCi6YwfP+ySGz8WhQ+nGdPu8N/wVc/FuryQUTtdIZ9lO23iyFtoWqepRc47N4Ra
	 JrCdAoVw9k9d4pLW6yWY0lO95SIoC2w2j0lZmHjJoBYgFHFfLIeYrTwOuSdY3GoF6S
	 nCCoTbXc3tdbgqIj7EoxH9RSqXNnsu9D5nNOtVFV9Rb7frN0bUKCJUyKDQZdnmSJiE
	 7V2eJ8u4jrczJMv5FFYC6mzEj3ZMEfYi7DNRze5xfq2dvdJRejIM2oEGUtEmCOUZmx
	 NY06hmhXk5IJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0170BC282C6;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:21 +0100
Subject: [PATCH v3 6/9] usb: storage: realtek_cr: Use const for constant
 arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-6-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1603;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Z4dFHNFlKFnAbpKqq4pi0I1NGjP1CC9FXDl74xxbcAw=;
 b=wADBdezbHfISTEs1/feZNXSrsSUOdAx6ibWlswwtMJBeMO7Ko8xzT4WRGA5sjyxOMngCV++1h
 1l44956ZjtWAzVLAIfckYMCtkbrtmspXifp6FZ9tyLx28DSIQE4s8ur
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

These arrays are only read, never modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

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



