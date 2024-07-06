Return-Path: <linux-kernel+bounces-243226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4B92933A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BAB2833A7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B31779B7;
	Sat,  6 Jul 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mGTNW4DV"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72048176239
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264939; cv=none; b=JeRhXGEWJRvFwCOdqjI1VO23s874z1vWTpUv21D69I0FFOhnHkvEhT21L0aqvLEtRW43QvzDaKmcQ2ne08DVM69pzpSWc33FRBYnpUkQQBo/W28sqfOKF4+CYf/+L0CtVa/8QUjkgltjOGGqvLtlOoIzL3T+TEY9IA9ZQajD1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264939; c=relaxed/simple;
	bh=sMBjjjQoRzu/y6oDuR1pOkVv5xeFLjAXjqL3/H01n3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2icCw7gcFQf6PvvRO0pMJz38jkAgT6EEH7WTVdn7s+Zec0lK0DD23WC6N5s76WDWFb7AZxVqGMOLM+kuLM6Ral8dNTJEZyzGkWTpymlxxE+IoHWZcOFQTw3glR3XZdukCXejT/lrfDp/c+QcyoRY8gGO9z7CG0EwVvW3rKUPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mGTNW4DV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=RKPno80B5b7lMNmuILEfR5vn3B5nA82KHZrBqcTfrZE=; b=mGTNW4
	DVedLtKjZp1Vr888EnmryAFZ9XwyXRbyYwt/V3u1KOYBOC+IsHrT2MkW7YlCCdkS
	azco/mwoUoXbgOS6M1U7SuYHD6CQeKFHAcYuhgJFrv9WnuO+Fzzv3jNKgNdZmDZj
	Peu93Rb7I21FUH9EBmoLlB5AjT78783hh66Hkx1qv3aRdxLJnQIES/NFAg1EhUtu
	weMBT37yUHeVuC203oga7Q5TbMrYBRbqrQJEBwcrtKcpztaSpPX2Hg7J8UBEPMkp
	almAeWaZ6/RoZjRAJhmtjyQzJ6XhkTdGLggGqx0pRbgs1MDmJLe+6sMF4zDJCvAf
	ZwKMnrsYBJqYXI4Q==
Received: (qmail 3810984 invoked from network); 6 Jul 2024 13:21:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:57 +0200
X-UD-Smtp-Session: l3s3148p1@FMhQY5IcZuFQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 50/60] i2c: tegra-bpmp: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:50 +0200
Message-ID: <20240706112116.24543-51-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-tegra-bpmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra-bpmp.c b/drivers/i2c/busses/i2c-tegra-bpmp.c
index b0840fa0f53e..dabadbcc6d6a 100644
--- a/drivers/i2c/busses/i2c-tegra-bpmp.c
+++ b/drivers/i2c/busses/i2c-tegra-bpmp.c
@@ -275,8 +275,8 @@ static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
 }
 
 static const struct i2c_algorithm tegra_bpmp_i2c_algo = {
-	.master_xfer = tegra_bpmp_i2c_xfer,
-	.master_xfer_atomic = tegra_bpmp_i2c_xfer_atomic,
+	.xfer = tegra_bpmp_i2c_xfer,
+	.xfer_atomic = tegra_bpmp_i2c_xfer_atomic,
 	.functionality = tegra_bpmp_i2c_func,
 };
 
-- 
2.43.0


