Return-Path: <linux-kernel+bounces-534727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C7A46A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456B816D884
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AA523959B;
	Wed, 26 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmI9ua6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AE238D43;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596417; cv=none; b=YqxZGgfwNSNeNISzRcaIpPTDKnpzshxYSVKp9W8DdcbVt7xmEcTDLyQhM2Qiz3LbcQC3BuR3r/9dgmyaR5yE1Y+SRa3cUZuhjfB0RSLs3h9kpqAzGrUR2D3c1tYob85q0X3MazBLb9Eed2MUHPdPbUWW6ZWzS4X4DI9vMMoH+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596417; c=relaxed/simple;
	bh=VHk6+dPKZF78pRrNidDKIzcA8Vd8WnrEysNDQjAv7p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StKSHC3nYayP+4mFju9RKPwqwHsFnsn4QPho+9D7IOm8QTMPR+0Wpk4ccxF8MDLv71H58pbJ6IPmqHMWAFa3YiahXiUmhGPSk7gcq6H2PQ/XJRNptx4fTheCTrwVXXGsBahdGnmiIuS5gXhFErEBRZiL94D/rcu2ec18Z42ve2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmI9ua6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9121C4CEE8;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596416;
	bh=VHk6+dPKZF78pRrNidDKIzcA8Vd8WnrEysNDQjAv7p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lmI9ua6Ci+qh1KVirQDshLct2N6hauoIY8BAPYgX4hXNgKUiUAE0ZZcFt8yta7sj7
	 nZLIhACUs7o9JPplNDjdhxxAOUmYM488AHK70BDi6/bfH5Ma4SDxU0NPsamQHU2FN5
	 o6SQ20c6Nz0s8HpZ8WgeXDkPyrRqT8+AhnoN8ixAaf7+EmP8oUSH0WZj53H+1rVDU+
	 5feQBxYGwkGRtgsF/j+fmcp3Aw8pZlI3k0/52cQpNRrUDzr3by+ive0FZD1sGhYU7W
	 q0eAqBAK3RuohHoc3U61r26G4izkkjvxVuazNrkmcC1yFQzv0voPeht9yRQbaIE/Nv
	 T9geiyNzFauYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F4C19776;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 26 Feb 2025 19:00:03 +0000
Subject: [PATCH v2 1/4] soc: apple: rtkit: Add and use PWR_STATE_INIT
 instead of _ON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-apple-soc-misc-v2-1-c3ec37f9021b@svenpeter.dev>
References: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
In-Reply-To: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=7cIMb5W1B1VA4bj9uxkLGyPS9AbrGxHzx345cZFtAjE=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/r+lD1Bh8qjJmd9L3nt8Wfjzf+VE6cxljdMYp51V4h1z
 vIHkkldHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJ2P5kZLgmfEC234zvaQHL
 m+Umc17u7+aRLZvYOX3X/zuc2WEseraMDC8UpRU3M5w+m8wbFMrmMJk5MVT9T/cVw9a5b4/G77j
 qwgkA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Janne Grunau <j@jannau.net>

This state is needed to wake the dcp IOP after m1n1 shut it down
and works for all other co-processors as well.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 2f5f878bf899..be0d08861168 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -12,6 +12,7 @@ enum {
 	APPLE_RTKIT_PWR_STATE_IDLE = 0x201, /* sleeping, retain state */
 	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10, /* running but no communication */
 	APPLE_RTKIT_PWR_STATE_ON = 0x20, /* normal operating state */
+	APPLE_RTKIT_PWR_STATE_INIT = 0x220, /* init after starting the coproc */
 };
 
 enum {
@@ -898,7 +899,7 @@ int apple_rtkit_wake(struct apple_rtkit *rtk)
 	 * Use open-coded apple_rtkit_set_iop_power_state since apple_rtkit_boot
 	 * will wait for the completion anyway.
 	 */
-	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_ON);
+	msg = FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_STATE_INIT);
 	ret = apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE,
 					  msg);
 	if (ret)

-- 
2.34.1



