Return-Path: <linux-kernel+bounces-538769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FADA49CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC781893E73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871F26E63C;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y11VSiuo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DF1EF361;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=gT8PYy7/GnzeXJxFzE1PFnLJef0Dw9ITC6bdXSWaCuRbfYI/O5Wzk/bzP9DSjAnaaRWpf939zW3C15CQJqfP1yhChY346A0cjMjm4Yv+XYFRXhWoLr00F4QhOktgsYq6p4F2E4t3tumR2c3LPJRH2iegmgm63P5FPJrJyh5lSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=bf3wlblmTinnWFniIp02mcMiY7kKvz+UH9UrgdVi1Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsZbzvUSA9kCmm2ZAGwkq3eme0P1zUE28A7g9FloWsuEXtLxaPpaxLNZ0H42LTXDmM36dfZQ5cTz6w3hqvwojfa1irTH7t8hmu5jMaMIHORwlYD1/ogcQs2ciZe1yeokrxkvhyL46Ub5CiKSkPEruBHskdqKZJgJOqH4MEqIorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y11VSiuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D002BC4CEE2;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755494;
	bh=bf3wlblmTinnWFniIp02mcMiY7kKvz+UH9UrgdVi1Yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y11VSiuosDDu4OvhcY+kGVxaTlIeV+imkEeXTsRvgfbIY8CQuKmcmWDLqUAY047JS
	 JXG8AL7iT3bgIKhjYoIIsvU/80Q5eKcFSuMaxJsWs3x9oAIbdeaYNErEyeCB1G9El6
	 o7D00ezfyXbg03AHpnQ8ifkVor7C33a1CsEjChc/Sdt8QsrDw6jV4m+i2S0E/i+eaF
	 YE5QYH8du3QRweSp9Orkm2jY5JuIAz6pieg9KeMNYz0yAI/cSkzVrwJAy+vUsvbnci
	 K+dihqLkEcLpmfiufLANTU1Tg0IAiyuGMjO8y1/DFKEBd0PAYRqcXDOq69izu1DQ1b
	 aBfXIUvysnCkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED7C282D0;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:17 +0100
Subject: [PATCH v3 2/9] usb: storage: transport: Use const for constant
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-2-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1083;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=5QhhUgzLhqlm9TuqxkqZvu43pDK5vNdB37hr9QmYLe0=;
 b=Do+TFHXIzpuTMoqzCo0Tlwt1aL6JJT8DwkXkg/H3OvZYEdkDmwi2cv0YFHb/HTKnG0germ+oH
 3FcQCQ4aPi4AYzYLjafm50iYjfGO2uOQK+QciXxn5RZ3CgOFtFWEsdV
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

This array is only read, not modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

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



