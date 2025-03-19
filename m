Return-Path: <linux-kernel+bounces-568177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2BA68F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E4A164D24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFC21DE3CA;
	Wed, 19 Mar 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLElYh9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100B1C9EAA;
	Wed, 19 Mar 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394377; cv=none; b=Zdlqx8gX7GGztCBxOViFmTeAXmohIj6ctx3obPvoyM76+3/viyU07PqlIkwwQmAg6P+AXM4iWOX//iA+5f6/w1dTzsFovMmI7Qq8RFQWr52eiOEdveOdDQaiRoRS5SoeGDKk00FfSKqIP53hGguUMyZgFWLPMMzcfBeM17ligzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394377; c=relaxed/simple;
	bh=85SNvPgvlH/GTxa9y+gugKmDHhXkflhLM6OsnTIZgQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTCDGKL49ugAUmY8SJC9quqGjhQyMDpWt3+8o4JYr3e6VG5jr4MXkkWkBsA2bs6VxrX7gHd/n/L5fyrzx4GqOEOxaBdhgGU8P+90Yot2S39J9n4uHAnoN1RJ0lsnfzIMQOPejdPKSyDEExYnXfW9du+Im6eOhWSKTWD9PQ0iWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLElYh9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382EBC4CEEE;
	Wed, 19 Mar 2025 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742394376;
	bh=85SNvPgvlH/GTxa9y+gugKmDHhXkflhLM6OsnTIZgQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PLElYh9mOKV/D6o5H/0LPmmCHC6+ydrcer3092ORziYL74imo3u2+YCr3HTZQqVVh
	 cLObop0b7zviL15ZZ4qV25xMUGuspY4yfVMGI4pPXG0FmAPGtcdWswhRnLOQqI8MJQ
	 dXcOOkLwNgCb6fxvYZxXteZa1RWMq9XmG9JSazG9zad4mat+/W0kF9StO6BZ1AqsAd
	 s7NuAWpctvBRg8ueLSBj8adezLKhX19Xcme6Iwez65XDmZ+IS089BFjTRT74Ke+mnD
	 WS7t+RNT3O2X9/AIjDxKyq5iRN47EAbLFio1kkNWiA8qMXIkKXlE2Qj6GFZ1EnWSSX
	 ZeJwbezgLV5ww==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 19 Mar 2025 15:25:58 +0100
Subject: [PATCH 2/2] of: address: Allow to specify nonposted-mmio
 per-device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-topic-nonposted_mmio-v1-2-dfb886fbd15f@oss.qualcomm.com>
References: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
In-Reply-To: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742394367; l=1142;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=y0+qWRNj3lsLNFcFdTqYiv2iqNp+DnBmvGNXCkwjQPs=;
 b=q/IA7Pig2c6uLp+qOjzt6OBMjX2S94U8+3a2kv8zNQMo3xTgbUSF7umlrVJl/Sn1ujeveIsOv
 NZN2ymSUt9UCouX0w+8xgZFCpY4wPeVjj8M3pN3tT2Fpr0bt6RbOFz9
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Certain IP blocks may strictly require/expect a nE mapping to function
correctly, while others may be fine without it (which is preferred for
performance reasons).

Allow specifying nonposted-mmio on a per-device basis.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/of/address.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 2041ea112ded70e11d3831b403901c36c8c29a93..f0f8f0dd191cfe05dfc29246da5fe665d5fb9c6e 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1035,10 +1035,11 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
 static bool of_mmio_is_nonposted(const struct device_node *np)
 {
 	struct device_node *parent __free(device_node) = of_get_parent(np);
-	if (!parent)
-		return false;
 
-	return of_property_read_bool(parent, "nonposted-mmio");
+	if (of_property_read_bool(np, "nonposted-mmio"))
+		return true;
+
+	return parent && of_property_read_bool(parent, "nonposted-mmio");
 }
 
 static int __of_address_to_resource(struct device_node *dev, int index, int bar_no,

-- 
2.48.1


