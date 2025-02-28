Return-Path: <linux-kernel+bounces-538773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DCA49CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1D0173C23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25127603E;
	Fri, 28 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abgwjrZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FB1EF388;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=S3Re7yhe9wYn8Yc8I1ztaQG3/oOlxpVdy1IXQo4+JUwgfLiZkPUITQoBmhT4hBSOpoCW4RlUbB+N0d1uIPRqg5/rq/Yo9lt2GM9itxDa16QjWY+yyI3lMFCqvbOJ1O9Lmw692abs1eqmrDYOriX7DSngfuLALCDlOumPDdibSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=9x2Hidl1O6sKtm76DH4TpyEnKkidRy45QDcdEAdE2ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzmjBIgdpEbXC1BP91e9OlM+A54XYeNiQC11essFyW9/zoT6dam+inakIG/Q7wCj0TL+D3DFRYYSdAVecICwJ5WZCE+3GBsuTb1uudMln052c/C8IHO6ciR54IQWonS1MZzlHD8L9fptcM6Er2MrHahXFXnHNc4ZcjQj1sHTW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abgwjrZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F020EC4CEEA;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755495;
	bh=9x2Hidl1O6sKtm76DH4TpyEnKkidRy45QDcdEAdE2ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=abgwjrZfyO1tcmz0v4lY25wDkRNRuXtWxAcUASxJyUkSEx6nctrw4QlL8iR8llKwx
	 S/1p4fqC0dRkr+PUVBv6wUgg5LDulTkc64FnUCGxnwCPTFBV8O6lu2qI11i7MEx3zy
	 ILLfHVwbEq/UW9fuIpTYiAoWelWw5ckn+PSL6YhD4a1x4PJzLAFoDGsBFJbYsH4mLH
	 Q2AjoHEDwTeGB2xBqqLEXlIcJ0NPITz73xm4RU5IxqWomlnRMf8Qu7XQX7LOsTF4sX
	 Coe9qxQohRvA1jWpgoPKiFObzOksZwF2zNFUke3T9j9HKCDhNnqRnpQP9A5hYsPpEU
	 CGgpCdYa+hcjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DD1C19776;
	Fri, 28 Feb 2025 15:11:34 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:20 +0100
Subject: [PATCH v3 5/9] usb: storage: initializers: Use const for constant
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-5-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1080;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=r2Pmb5RZo+2KbXzcIr/5x62LkugYhFe+V92n7WTCzmg=;
 b=nJfZo9IKgEu9bf/bIEQOn/ZGJ2NG9zqb3+2qsk4n8SeRA+UkXrUMnRD2il9igI58pidcTScq5
 Yp+aEXlaGBbAWalpto7G1D0pcfl/Lpit38ADapWYxb/1ZCqgjbCezTW
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

init_string is only read, not modified.

Declaring data as const makes it easier to see what's going on, and can
prevent unintended writes through placement in a read-only section.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

V3:
- elaborate why const is a good idea

V2:
- new patch
---
 drivers/usb/storage/initializers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/initializers.c b/drivers/usb/storage/initializers.c
index f8f9ce8dc71029aff5ceaf4d62f596a30bbceca2..b243bd5521a66deb3ca3603b52ccf603e191a4de 100644
--- a/drivers/usb/storage/initializers.c
+++ b/drivers/usb/storage/initializers.c
@@ -54,7 +54,7 @@ int usb_stor_ucr61s2b_init(struct us_data *us)
 	struct bulk_cs_wrap *bcs = (struct bulk_cs_wrap*) us->iobuf;
 	int res;
 	unsigned int partial;
-	static char init_string[] = "\xec\x0a\x06\x00$PCCHIPS";
+	static const char init_string[] = "\xec\x0a\x06\x00$PCCHIPS";
 
 	usb_stor_dbg(us, "Sending UCR-61S2B initialization packet...\n");
 

-- 
2.48.0.rc1.219.gb6b6757d772



