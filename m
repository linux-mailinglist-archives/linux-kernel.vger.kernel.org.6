Return-Path: <linux-kernel+bounces-534730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F19A46A82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093681889C71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817A2397B4;
	Wed, 26 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0Xm6pVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38786238D33;
	Wed, 26 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596417; cv=none; b=NdKJhmOieKBXrwjiMVUaffCogPbi7aVwZ98ot3nMDn+oeU8MQVJismuU+avz9sUsxDWcsQ7fIMQYoKB12U9YjVCj3v7Eqt/5KkqBr2iXL6dzTHOfVHxqfrttdx8m5+kBW1VEgJZqD4LaY+mrjlOjwPodRIfCpgbbVTOMJwR2aF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596417; c=relaxed/simple;
	bh=+42kuksOlhzcBQPYk3PSr8n66m0DZ2Ays+BbNMN38cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tS7Z9JKphhirkxVtjkiUbUtQKinOAddABrntz50/u1Q85Of7Zmupt5O3r/79VL86ZtyJjROQgzIbXGQVb8bTCYEO/utd/ByiwE013q7GIzNLGnYptKuozTakeWbwZAAUoKJihZooUCAGTsk2UIpbPKHsCg9039GBIo8DiuHzsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0Xm6pVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAA9BC4CEEA;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596416;
	bh=+42kuksOlhzcBQPYk3PSr8n66m0DZ2Ays+BbNMN38cY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U0Xm6pVmkP2OlUb3J4Cv/yIEuucen0nc8VsYSW5vwJonhMr68Uiwqjo7mB+7ZHvQ9
	 JrI8zTh8Spu3oNow/c9bIlP51XGoUHzmFv8d47gjq0+QR0U2tf90GmZOP7qFRFA5ch
	 L7bPUaCYHr/6V5NV/pyMcP3cauMbIzwvzsaMOkBjlEqui0/pMHdd1A5QaUF83tgg9C
	 iXGIW+fqc9ifLkGpHQ12yKobijT/oAxatH4sB9gEvJuuSgmKRKendZN6kB5JTKLIwo
	 xo4WVnoNRKl64Uk85ALl9wWkoPjFW9HoeV+oPybyUyCEtLlV1ZOAxGkHD5a+rtQfla
	 77CH70JYioL+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D329BC021B8;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 26 Feb 2025 19:00:06 +0000
Subject: [PATCH v2 4/4] soc: apple: rtkit: Cut syslog messages after the
 first '\0'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-apple-soc-misc-v2-4-c3ec37f9021b@svenpeter.dev>
References: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
In-Reply-To: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=J8uNhQd4K8sLsyiwKJwYYfLSFRN53J4ELGphw4z4HHQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/r+lH1uAVs+eKaVxVdt0rz+94SbXkKDzbIZyQ1mUcv+a
 JxaF+DVUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZiIcR7D//TfGe0xl/Wt21bf
 Zdi9Lv2qgW5tVm7mim5lq2Lvki4PTkaG6W3nfsh4rJnOdmP2FS2WiU2Ha5LXhUpPLNM+Ntuoy1O
 FGwA=
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
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 4b78463dd5a1..5fffd0f003dc 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -477,7 +477,7 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
 
 	log_context[sizeof(log_context) - 1] = 0;
 
-	msglen = rtk->syslog_msg_size - 1;
+	msglen = strnlen(rtk->syslog_msg_buffer, rtk->syslog_msg_size - 1);
 	while (msglen > 0 &&
 		   should_crop_syslog_char(rtk->syslog_msg_buffer[msglen - 1]))
 		msglen--;

-- 
2.34.1



