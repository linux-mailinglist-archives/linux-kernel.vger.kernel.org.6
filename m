Return-Path: <linux-kernel+bounces-527369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA4A40A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D540E3B1122
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720520A5DF;
	Sat, 22 Feb 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utTsuwll"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46B1CDA3F;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243447; cv=none; b=SFh3cIhKsugICzQCjrTPb1/prUvNGxlNvSe5t7YfE0XDGuI8VoW3tHg9nXnXKSCNzi3jV4PZhs2lyKEUhQ15C06UsfXnvxLfeDjxWUwJoBCM3JZ2PHXbHwiO6Ap1rIlNXRYTA55qiCrRARQ7heqLpKHOOUxCIED1HhTu3COSu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243447; c=relaxed/simple;
	bh=WbAitZIglxWavPqRqVXLV21zKZHr6h1VYULp51wlyco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUSAyyzrYMaGqmCmJ3F1pubIMR0othcX3UUy3rHT4b8huJLa0tnl6c4pd0Jc/YNDLwAEPBGJYniZuyNT9akq5zg/agWZKNdrXJNdgPBotDwOkGMPvvtDO9augHxgaIXPZi3gBPG/OGC5jJFdQOnnOhzDpZA/eOvqkFEuPcdbL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utTsuwll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91C38C4CEE9;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740243447;
	bh=WbAitZIglxWavPqRqVXLV21zKZHr6h1VYULp51wlyco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=utTsuwllYtOc/9Tv29GaMqqQ0t8DxhuhkYgfOSM7sbvdMjsIp7wbEOYmaHGl03o3L
	 CVMUhnzg0+0sVaS2NDFvAH7/KaYB1xmhQsQPp2jZAUVKSKX4LGwZ122vAOU7YBMZyB
	 I/JokxYIRWlzKpFNvhwFlBwROMVkj0YefX98L0RN6OOHP9l4nkc5F7WLwmXouH2N+I
	 vESVhcXcL6D1StVXgzVey+SBWBtwmNu4suckBL2l4iOByd3icSzmQpQbRPlZuarEFX
	 D3lPukcQFSNPk9eTsMfy7AXpHlwN/hXL+/zMEryODNz6sWHeCkRG7Wxifo1/3xVr6G
	 eNVa5ykOF9zqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0CC021B6;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sat, 22 Feb 2025 16:56:49 +0000
Subject: [PATCH 4/4] soc: apple: rtkit: Cut syslog messages after the first
 '\0'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-apple-soc-misc-v1-4-1a3af494a48a@svenpeter.dev>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
In-Reply-To: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=XmS84SoHATsmW4yIuH/yX1sErrlBc4P71wmt3DfDGeo=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/ouxi+/pm7Ov+GW8XbZ0X35fc+0Wo63t2ifWBm8oPy5x
 jLvS+p1HaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJlE9iZFhQvnpuRLrzJF3+
 5Ieqeg3y7Jyb+Jd7Ha4yb1jQcCw2IIWRoaNu37tZWSsWV/06lORaflOEcalCfeqTvfdn1/md/LX
 /NxsA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Janne Grunau <j@jannau.net>

Certain messages from DCP contain NUL bytes in the random data after the
NUL terminated syslog message. Since the syslog message ends with '\n'
this results in a dev_info() message terminated with two newlines and an
empty printed line in the kernel log.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index b7f4654c3341..595efce265ce 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -476,7 +476,7 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 
 	log_context[sizeof(log_context) - 1] = 0;
 
-	msglen = rtk->syslog_msg_size - 1;
+	msglen = strnlen(rtk->syslog_msg_buffer, rtk->syslog_msg_size - 1);
 	while (msglen > 0 &&
 		   should_crop_syslog_char(rtk->syslog_msg_buffer[msglen - 1]))
 		msglen--;

-- 
2.34.1



