Return-Path: <linux-kernel+bounces-568176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D4A68F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954093A6C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9131DA112;
	Wed, 19 Mar 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULh2ca0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3A1C9EAA;
	Wed, 19 Mar 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394373; cv=none; b=Ls9MwgIy/2wpWQtCZIQbj2MSWsVzr47qFaCliF4jHp7z5Wu3MLduLkbEs7keE0aewa+eEXmbP0DmEnR4Zmez1PE3A/boa/FcvssEVNjMctlpR7xPJ7brzY8k4bOhFLuuvWAK9EMAto7SiljlXkALsDZ5SbXTNH85bHa5ssMVPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394373; c=relaxed/simple;
	bh=felFitzAfVwGDg+nw420Ie8NgeeaGNR7lMYUTvtD8SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOQFz4BdY6D+bDbNdMYUuW6eV5fLGfqiaYvFshQQt8aWIvOsvpjFBl5JATd8I7WkAxXPd5q0dQprB1D3Gg/rpRxZbVG7ob2AKC1y7hbwcXxqSNDTpa4cHGUBhCBM6XxHtkcY1CdfwejJixPiRk9TZzQY9XZS9TVKglmmncw6rpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULh2ca0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D864C4CEE8;
	Wed, 19 Mar 2025 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742394373;
	bh=felFitzAfVwGDg+nw420Ie8NgeeaGNR7lMYUTvtD8SA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ULh2ca0CQyIzCwUKHiakRPqW1dY2NdSmwGXV5vrg7EyjxhxIJrQKHHznonfmfmg4A
	 55da4VnQMFJYoYMbDyxM7vtqr2Gh4i7J4O6C2NdwP3Jtn1XenkY4V9Tk3oqISFO/14
	 gMCag3egjrKdpOB3V02rHlX5wv/aICRe3zTWFTMwLZ67FxI7zPjHPZIUU363HSe2yv
	 anRmZ4wJX1AGl9MDCQ807QeZHxyfmMtyTRDZcez88Awdld1Fs6RLkSqwSe+G5tgZWN
	 oY7jDgp4m5TlSlI+UuzUjR2RD4ZdWQ0//zkr19HY+k1SVnWY2XAmh28E+BYsPmDN7r
	 NNK/Qq8YlJdag==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 19 Mar 2025 15:25:57 +0100
Subject: [PATCH 1/2] of: address: Expand nonposted-mmio to non-Apple
 Silicon platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-topic-nonposted_mmio-v1-1-dfb886fbd15f@oss.qualcomm.com>
References: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
In-Reply-To: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742394367; l=1022;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=kRSnoBpvWDoY+tUUEVYLHvYCbHYustA1YR/PxkJVib8=;
 b=tzrLllFMNO1tAVV7igQDQn687UgZfZnwzqCC1cUBZSDdD6hbukdAVwG3QyVNx3OsdfymDKmQR
 B6AiUrQyNNzCzH7HJnIvO1+cIak/bkB142NaUQnfDm7Jru3BTajuKr8
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The nE memory attribute may be utilized by various implementations,
not limited to Apple Silicon platforms.

Drop the early CONFIG_ARCH_APPLE check.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/of/address.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index d177a2b9edaf8de28b1b132156e9a951763c4e79..2041ea112ded70e11d3831b403901c36c8c29a93 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1031,15 +1031,9 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
  *
  * Returns true if the "nonposted-mmio" property was found for
  * the device's bus.
- *
- * This is currently only enabled on builds that support Apple ARM devices, as
- * an optimization.
  */
 static bool of_mmio_is_nonposted(const struct device_node *np)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
-		return false;
-
 	struct device_node *parent __free(device_node) = of_get_parent(np);
 	if (!parent)
 		return false;

-- 
2.48.1


