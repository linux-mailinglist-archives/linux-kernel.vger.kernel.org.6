Return-Path: <linux-kernel+bounces-527372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A36AA40A69
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2E1189F34F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799620AF66;
	Sat, 22 Feb 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8afU9t5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A51FF7B0;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243448; cv=none; b=SYmN+7VJm6zU023wXcatxEjZfPe8zZSb2tb9P1f33husJjF1aJBbCBu18pvkPyCKM737RkAops7LNH5ut/yPkhTP65e7sK2vnpjW63RUeXtCKyml8vicfrGR6dijsWgKhymBpL2/xPFS5hqKpoT35fr9bxg7Yu/ByZviJqt7D/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243448; c=relaxed/simple;
	bh=ikludOBLGJcDCnJlNymHnygt+Sj54F2yzuxmtj0+M9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJ1OhzQRI50BCGylL29qFRWBHr5qdM0+psnrctNghr8o01UWNcpBJ6tP1UqP08mGfCfDGwAq0tJNQp9ZdtjeAySsCdCT76euOLaN7KZwyK36PZzUN+pqMXQJ0yAhPP4kHfXx9fgMGRuooOerTIqc+rl8bDuoeTwZhrzQW9Opg3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8afU9t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74FEAC4CEE6;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740243447;
	bh=ikludOBLGJcDCnJlNymHnygt+Sj54F2yzuxmtj0+M9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t8afU9t54Yj9QLzkL6figMynucP3g7eJ/UCCqimCNK1afn4Y48AFxmYVm6YxwWzqn
	 mDqXeUpAA/liAz5pnQmOcYN6jNmgoNVNvXioxrKOFgVKSF6H6jZrcm9pCU+dkMYIgO
	 YpJJOn/KAi4CBW5S/UVrRNydHWvhXzwlaM6NEQ+AMK2VAbYg3OrHmsvbYjhk8p3vOT
	 2EjCNURx/kjes30fD/d7oF5seVA1IsaQxB+PHQeUkMh18kMEEjdGg8O+0gBtva6IDQ
	 f8f3TGjGPTEvdmbCJJ1lb31dkq65SLAwakWgkmEOuBMAfr67CJo6v5WM5PEcf/DRUn
	 x6vmneEIgV1vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BAC021B5;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sat, 22 Feb 2025 16:56:46 +0000
Subject: [PATCH 1/4] soc: apple: rtkit: Add APPLE_RTKIT_PWR_STATE_INIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-apple-soc-misc-v1-1-1a3af494a48a@svenpeter.dev>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
In-Reply-To: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=Bzvx04lIOmxyPohnaPEhCN5D4RKIiEvPi9Robq/Ze9c=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/ouxo/rVmyVvXBlx/HL/Axro6/Jf2Ssqfr/+Ipx6jHuu
 KDniVYSHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJCGxhZHh0ra7t9n/1E1ll
 755zRtot3xw8K+ajqgR70srn+008qgUZ/tcXvJuyb+fM1yfjOO95aXLUX8/v25pepLcgoOz4/13
 vnRgB
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Janne Grunau <j@jannau.net>

This state is needed to wake the dcp IOP after m1n1 shut it down.

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



