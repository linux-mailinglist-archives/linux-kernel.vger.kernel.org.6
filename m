Return-Path: <linux-kernel+bounces-538774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BEA49CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B807A9C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7CE276041;
	Fri, 28 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTBe2Pmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2291EF389;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755495; cv=none; b=gQERpVjVh1t+yPoSIi3pKl0OrYtRHeiNWHGdq/xJvIJpDKFLlh6qXM3tJVpxAqHFLbjnvEJ945yH9f4/ESUfavjtaMSup7dXE3jOdll7FakP8ALAI65AgvTseKG08pBI6E7gVW8qO9idmH2jgUAmOSdElm88tFyWZvkqaM1n72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755495; c=relaxed/simple;
	bh=m9oCxP9/ETxoHFPO9KXHbJ6twMmsrtK7h4rb6GlG0uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQeAilQq3+jz9aCwolGEYlj44pfI7soRgzbClKgHo+6BPjowhk8qsCAUrZdM/+1m8cSyeDcK32VG1JLRMPEgt6AA3KqQzWjuh+wzMqFxiBy86soghDFyxt50DbNo9zQ8MA9WE9CNaMi5cM25QPZwXhEw7DrmzZR+uNm0w2ScOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTBe2Pmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33B6DC4CEEF;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740755495;
	bh=m9oCxP9/ETxoHFPO9KXHbJ6twMmsrtK7h4rb6GlG0uU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YTBe2PmwYr1JJip8EUYvg4m7NXKGo+abx3iF04MVWqc/cAAxlHlhlGspJqOllAfrj
	 jllQDyP/ouFz40egRxyUAk8mahQCWlgS240O4OuAu3qGVG9GHjnUIC8/FXbDS5S/v6
	 r4UUazYCfp+B05bRGpcCf3PjhIfQ5qWllw8/lHxADHljOUZ/DY+wCrrHBiSs5GbbQ5
	 n7RenSvA7885vmpwDsOXkqMQorkb2EUxW0YB5rvPFdp5vCl/y2CXr1iykC3LO+TeDA
	 foC5Rj4zQGw0lyCN8oqUQTbsH23AkbrHiwpd/KBuVcvq1MoLXZfsDcoLC6g5LmIOeC
	 32sOuDy/9wqYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10EC282D1;
	Fri, 28 Feb 2025 15:11:35 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 28 Feb 2025 16:11:24 +0100
Subject: [PATCH v3 9/9] usb: storage: shuttle_usbat: Use const for constant
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-misc-const-v3-9-09b417ded9c4@posteo.net>
References: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
In-Reply-To: <20250228-misc-const-v3-0-09b417ded9c4@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740755487; l=1113;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=c3zFUpIiLQBTnxFuX58IYeC708hZ2OFipFj3XEiE89M=;
 b=17wwAL61o0Jxp0MpLVODKSR5Di1ZGuLePUAxm0dBAjg9XqlvS+dfhTNn3txurpA0eEvTR+bhD
 VBaqrrNEvXeAsyefhBm1t9roTEB21NVsLaiAcO0Rq7eMhdHhDVxA4eR
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
 drivers/usb/storage/shuttle_usbat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
index c33cbf177e6fcaa80e0d2639594d1314c59f4950..27faa0ead11d1b0ee9e45ba6a3ee5bade8a416e4 100644
--- a/drivers/usb/storage/shuttle_usbat.c
+++ b/drivers/usb/storage/shuttle_usbat.c
@@ -1683,7 +1683,7 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 	struct usbat_info *info = (struct usbat_info *) (us->extra);
 	unsigned long block, blocks;
 	unsigned char *ptr = us->iobuf;
-	static unsigned char inquiry_response[36] = {
+	static const unsigned char inquiry_response[36] = {
 		0x00, 0x80, 0x00, 0x01, 0x1F, 0x00, 0x00, 0x00
 	};
 

-- 
2.48.0.rc1.219.gb6b6757d772



