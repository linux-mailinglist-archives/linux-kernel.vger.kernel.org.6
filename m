Return-Path: <linux-kernel+bounces-534059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8BA4623A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB533AE855
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FC227581;
	Wed, 26 Feb 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFqTgdqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C522173D;
	Wed, 26 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579452; cv=none; b=c8dvixlJ3YomvY2Kiz0JHbnECUQItvQgkeWsrM9G7+ugoXXLF/7K1l8gwLA/+6fKyOim0MMUi1uPQjCzZnC9hEhTYa+QI+z1oS+gemzz8GKLjVIVQEmLFRBbuSu1aJ/T4tC4juHFxe0/g1Thqh1vLmNUNRg0MoorL5jnyA6vDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579452; c=relaxed/simple;
	bh=jUkw+0qqo77n7xl7JQ8f7bG6tUCWZhM6MFwDw9efri8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2Fe30v4TMqifHMuf5TObJ790XQtrQeLlhMTaDXPF8NfH3NO1YxiZ8nK1KNcSbHvloN7wpsf8uOvzlwuwZlDYsaknb49+5nm9aDRqTXegt7WcU05iuTHSCWP34JjISKl0xJ94/hNLnXTsqW19v6NXbxjAEppMkOkCYZRlgnNGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFqTgdqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C323BC4CEEA;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579451;
	bh=jUkw+0qqo77n7xl7JQ8f7bG6tUCWZhM6MFwDw9efri8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZFqTgdqEnETyo4qOK+Clnop91Czl0Sa9/OrPpeyGThdjKCabO+qXzrOI3RjXv4Z7C
	 xzWrjC0uO7ebke+A4J3RvzgmSH5j5OC3w/jTgKg/C82J5yctMWkItY24xDfAslN2GV
	 p/ayCdrCyznPf5fzcqByEIGUYZbXiACPkdqu5P6NiWvKThxH2StueFK96JZq5dePjY
	 QqGHt/DFr/P3qfAU1OE9e11Yiocz3UTcP9VuZZcrKX81UAPK3avQQHIXQUH/S+aou+
	 MRipkELplPYU66ycGQP4yIk+QhqRtD+5nA6orlUIYcwG+wHKBdcCSP97i9pL4l1rqw
	 aBo4bdEBahjtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF54C19777;
	Wed, 26 Feb 2025 14:17:31 +0000 (UTC)
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 15:17:27 +0100
Subject: [PATCH v2 5/9] usb: storage: initializers: Use const for constant
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-misc-const-v2-5-ab655a4a29cc@posteo.net>
References: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
In-Reply-To: <20250226-misc-const-v2-0-ab655a4a29cc@posteo.net>
To: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579450; l=891;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=E3sv7MUTjUoAFshGx3e7fa3LASnJqeGyCGNhGtip8E4=;
 b=e9djsAqkZ4XnlACb+EI453tnroUtGkD58yGmdSWYpfkInGcsTwB551/xvIIPIytkjdEKrY7V2
 3JcC++IDHIsAQA0IpzE4CRdD36/ISBdF8NxT402z/qLs60wHbX+Ydws
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: Jonathan Neuschäfer <j.ne@posteo.net>

init_string is only read, not modified.

Signed-off-by: Jonathan Neuschäfer <j.ne@posteo.net>
---

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



