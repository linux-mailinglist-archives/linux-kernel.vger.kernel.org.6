Return-Path: <linux-kernel+bounces-243186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B839292E3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD69E1F2184F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914A13C83D;
	Sat,  6 Jul 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KogWU+Jz"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5A13AD18
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264907; cv=none; b=dYtQG/1PA6b/hJMTZRpseGqzJop9+Wp5g9fQzWzCHwzUOWnOosGH4VXFe/strVqp43d6ZMdO9WZpZtbU1cymMrvMWmMzRZ+eYwlX5Sbf4utvW58HkjgSY2T8ss33ecO4l813rW9Nl8PvIP9zjntPKQ7+sa47CoOl0RB7pefK2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264907; c=relaxed/simple;
	bh=9lVLZWRc7NAlCXEos/Ht+9OXDaJDePn7bYvBLBWeZ78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLDD06BJqRPhJg318jPhoiEs2b+3u+43bY6XT3Gm7gSJhgzJJI0QgwY39FZVhw3/lzSRXSXF9g0nUEQlECpXHiYk8iS1mWWEHAeqssU2PsA4tnYOEhmSaVBfumCMkceFnqZoVpBwVOZn+eO/MT5mx9h7RjOIlzpwSA/9GnGBY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KogWU+Jz; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=D1BuoUJ5rXFWGybNFHM62IQOacbAYA+TSmxYZ9HLfeM=; b=KogWU+
	JzPp3w0jQi5IbflPz3B/JK/4yhnX6vdtEhOU9hNgBMdOeGMm2t9aC+3LK0RTVdNs
	SoNr+F+M93O1jUTVgL31cAcYmpqV4dzJFtIVJJq2BKlwobytQBnrxTDFkObdWJlx
	m77Q8pLKU5rnh6X5nfN23pFbsFTDHpVK7ml2MZGaJZxWWeGypY8RZMPkOOv62U4j
	r+l9H6pKHWWexRwOrYwCJwhSNt2FqJB7xaDkuplHionbf0KStZOB5IkVnT1TBwBW
	opBlcYvyM9IG9sYDcGgAOII91xICWaUsnEBxxKQoAXztrwUa3bfAu7rRwjIKYf2u
	Qrju2kzpOxFAAQcw==
Received: (qmail 3809660 invoked from network); 6 Jul 2024 13:21:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:29 +0200
X-UD-Smtp-Session: l3s3148p1@SDCiYZIccpBQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/60] i2c: cros-ec-tunnel: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:10 +0200
Message-ID: <20240706112116.24543-11-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 2737fd8abd32..ab2688bd4d33 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -235,8 +235,8 @@ static u32 ec_i2c_functionality(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm ec_i2c_algorithm = {
-	.master_xfer	= ec_i2c_xfer,
-	.functionality	= ec_i2c_functionality,
+	.xfer = ec_i2c_xfer,
+	.functionality = ec_i2c_functionality,
 };
 
 static int ec_i2c_probe(struct platform_device *pdev)
-- 
2.43.0


