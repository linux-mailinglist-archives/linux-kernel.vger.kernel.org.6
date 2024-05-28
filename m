Return-Path: <linux-kernel+bounces-192263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B148D1ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726331F22D77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520B16D4E5;
	Tue, 28 May 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQf+4rVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FA16D4C8;
	Tue, 28 May 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898390; cv=none; b=P1QJ3VGi5rsCsrzdwvbW/ZpsHWj8TvMT/vBhCrw6azWps2GNkFILgeu+IJJivda331wz9wunvLfwXdVVjrcyMkwP2P6XCTSvNVhPyV+w/ZgtLzn6IHB8HO6CcPrTSwlyuSNdnjjn9HONc5Kc/fUNqdJwCS3WsFWX2kmpiIqmxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898390; c=relaxed/simple;
	bh=rzsvd6VD1/owQGZsk5QhfmqulEVL1FBeAwPMuDez2po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pf5NfrlX8CWmJAcYUSbZlOQHLVet2LDr1zn6NqVHVO1VSOjxqUxNc5wQ2YCEwdT5OpWxvT/lW8b02pTEPZiMjDNw8l/ltpQ+/KO2uG0TpamtFqaIPKZtBXMWtJKFJQIcX1B7MGnHyejygepyLSkIDgtlJD22fj2xCF8agde7wkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQf+4rVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B86DC3277B;
	Tue, 28 May 2024 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898390;
	bh=rzsvd6VD1/owQGZsk5QhfmqulEVL1FBeAwPMuDez2po=;
	h=From:To:Cc:Subject:Date:From;
	b=DQf+4rVBPll8AM8kJkFhAKRuprdBNvYgQGlMlzR5NRXs+UKn1rKVGNsbzxDTQU6bu
	 ejgvsFCmE6hSG+l+Fp88v7WqQIOPvdOUdCcMHKRJ48akBkb7bUxFSW7YziWtOPlH+v
	 V6Q74zsQEFe7DRdHPXUUFafaB1kqNBvwA+2cDQT7VWZT5IRFXPRk7l8Sx8zaEdgfML
	 ykqvhjRK+KHyFe3+UQ7vloertTwWOaG0OD1uJRQ1GTdZSZXX0SGWoSpYQTVr45MLX5
	 TXml6U4FxpUgSHe8GWRsO3fSn/R3QFOnBirg+Z3tdc/OQekLZMdRY3OR5eHgvWmUQz
	 TtJoqVbeQ5uTw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno Sa <nuno.sa@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	Andrea Collamati <andrea.collamati@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: ad9739a: drop COMPILE_TEST option
Date: Tue, 28 May 2024 14:12:58 +0200
Message-Id: <20240528121304.3695252-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Build testing without SPI results in a warning:

WARNING: unmet direct dependencies detected for REGMAP_SPI
  Depends on [n]: SPI [=n]
  Selected by [m]:
  - AD9739A [=m] && IIO [=m] && (SPI [=n] || COMPILE_TEST [=y])

There is no need for this particular COMPILE_TEST option, as allmodconfig
and randconfig testing can just assume that SPI is enabled separately.

Drop it to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3c2bf620f00f..ee0d9798d8b4 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -133,7 +133,7 @@ config AD5624R_SPI
 
 config AD9739A
 	tristate "Analog Devices AD9739A RF DAC spi driver"
-	depends on SPI || COMPILE_TEST
+	depends on SPI
 	select REGMAP_SPI
 	select IIO_BACKEND
 	help
-- 
2.39.2


