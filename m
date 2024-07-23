Return-Path: <linux-kernel+bounces-260317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072593A6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3CD2820C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E213C3F5;
	Tue, 23 Jul 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lzfkyCuR"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D00158A07
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759815; cv=none; b=rqTkExvx+tNjbfMZb55m0J89A31Nj+bg1tA8Vto7eS1RQ5i6QT7ORm4HUoxYqZsRBBgH6JDL9o/id5gVLYn1u6vFPp5DmTsCBIoC/9l7MTX25yKO4FXkn3XwOe4eAkPuHa/BjEoti3n0cOvmcfNrkSWdozcpERz15wjamKor4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759815; c=relaxed/simple;
	bh=wCjAe5rysnyPHTE32w/Il9C+QuDxWjSafUc9QGpJhDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQn0Llwjctx9OsqRPRFxIsF7qVSBHuCq2DC/wXYPAowQbR42QdFHvEuIjz3RCn9lJPcNoAfwVwM9KDf/e9aMpEOgwwnulyZh9ji4Po4ZeKLcEvmEo4HBpeXwciRMUk5cLwgqTTiKo+xzDvDNZldvH1ATJ4N6fqLMdg00ECbqsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lzfkyCuR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-708e75d8d7cso3338567a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721759812; x=1722364612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+UFYRZSUcd9DOmvcNxoBDJyVG+xJwiw5jLRr8VEv+0=;
        b=lzfkyCuRoMwFEPPToAps9A8OXa9eBj+yCwFIvxntR68Hrd33afxpl+7nCR2VaGdmhf
         tzsrBi93tLOwfkzkL6oE5MAa7A1kNjl/TJhbgPQAxJFtPkO5Zboe/VeXrXxh6gcU8ddq
         LbVRtGB6vSoCti7hTggSRL9p5lz5tfNNRLl3mDk0zvmCbOe9yZ1uoO8CQTgHVd5nq4zY
         63T5qyMEWkp1sZMWAC2cV1yBkq5eHHG6kN7hQk1lZkdpyUC4WV8JCU2YMFEMTIvsgQFP
         JsFg+uuEdsW5toyZnOEz6mQ77qITDNP6jCBPbgz0nuIShJEDOUmVnYPrtOIN+V1Z2IoI
         VF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759812; x=1722364612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+UFYRZSUcd9DOmvcNxoBDJyVG+xJwiw5jLRr8VEv+0=;
        b=RC2LtAICfDoceJLqZiRvdANn6A+oPAEB46Fm3uq1X/fLoRBBByGpQ7/IQB6IbYYxbU
         MwN/n8De3qrucZc9nHzEfOuaGOldBiOYCkFbTJigawNCcmpTLipWkPWpbwXKWou4uCUg
         b4Lo6eiVPfrkB+RkTAPUw57OiZRsXk+Rj2HeOviqqWPIXwDgFx2Zi4pd6zfnoAYm3T4k
         EvLxmwHHPTzIwPYg2u98gcIUm87r3V+1f83t2YR2hcWS+OjthbvGqiPg7Rwc4KmSbjiD
         tQaidJrvucLcpo3a2OaPY7qP333uW5yYKwWmaer1Rl91X9HL4hbuD/dwF2P93m6zBqnh
         sUow==
X-Forwarded-Encrypted: i=1; AJvYcCWBpVVweqN+PQVYqUzAgFTpoAPHf1a5OLFFhU9I9H8WRTdTbE1m+u6qROkDB/P2UoFIm4v9MgWZJXcFeWBfxODge3huJS0mqimAY3ix
X-Gm-Message-State: AOJu0YzF9iUPanTdzqoxrzk+zhuKYV+uKinJvehP0YuL3jwpvKcbLWCU
	/uNlCkzR4UfPH1u4K+84u42MLsfLp8MtR+hnvmsEnx17BtCuvpP/19ULRw6+wZA=
X-Google-Smtp-Source: AGHT+IEE0rY9DlgVCA4eTLFv5LAFuDv0yqZEcQ2Yvr1s4IANSDqUYYNRsOGkILxVq+PW1Epg0/lx1A==
X-Received: by 2002:a05:6830:7007:b0:703:5971:70a4 with SMTP id 46e09a7af769-709234bddc7mr781730a34.28.1721759811906;
        Tue, 23 Jul 2024 11:36:51 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f6172f97sm2131109a34.54.2024.07.23.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:36:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: don't emit XFER_BITS for empty xfer
Date: Tue, 23 Jul 2024 13:36:47 -0500
Message-ID: <20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This adds a check on xfer->len to avoid emitting an XFER_BITS
instruction for empty transfers in the AXI SPI Engine driver. This
avoids unnecessary delays caused by executing an instruction that has
no effect on the actual SPI transfer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 447e5a962dee..cb3fdcbca2be 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -258,7 +258,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					clk_div - 1));
 		}
 
-		if (bits_per_word != xfer->bits_per_word) {
+		if (bits_per_word != xfer->bits_per_word && xfer->len) {
 			bits_per_word = xfer->bits_per_word;
 			spi_engine_program_add_cmd(p, dry,
 				SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_XFER_BITS,

---
base-commit: 67e899c7df7dd8507ab61a2e71fe6c8299afd427
change-id: 20240723-spi-axi-spi-engine-opt-bpw-e801253aa43a


