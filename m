Return-Path: <linux-kernel+bounces-226322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97760913D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DFBB21457
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD89183092;
	Sun, 23 Jun 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJiiseiW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10503183066
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162841; cv=none; b=cJGdqhQmAypMA1YBav7xvwsq1BLk7e3/agXwImBUOHgIqePcIn4XuHYXWRYrR4Jl+tQ4G3yfxGNSxnPS48JPtIRKOwkC9N0eqRcZo1yTZNlG4JqJLrGsWB3/jsZ0a+MwE5fo4BnVSDHTInUn8w9KBr/axQbpiX08YnDEjsDxInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162841; c=relaxed/simple;
	bh=wwJ/x5XQ4O8z0BMXu0cwRhaztroWtvuR6Gh0bMKRKps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlW3U+JRnCQlddyK1+vANfuVJkAPY1lFFVmkAUSL7WHEDudUy+nZCIZFRf9aaUrjbvjQLdVHmU4hUbgNxUQBt/GrpNwgoFXahwF9X2wHBx/2gwlVXSvXkPO/WX0MLa+J1ssMT1TzaIPxfczwmS+Esuu3qAE78jTYJC/FKpmQrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJiiseiW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so2826830f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719162838; x=1719767638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/zZtNnC/KzVU1jMIJC4/FDxQCHloTtcrOBctLMG5CU=;
        b=xJiiseiWNVKavH3Mrg54iyLYF/TMIKS9UfXdZBuD6AcQ/Io03eL99ZtTvjDV1c3ECU
         R9dFET+miJaly6QGrc56QHc7YqkU4ffWjZmIiHmDnvVNSeFGWZZic3swGVDherPMAfhc
         BQa18djriw2gowvMYN8BQGfRzdwAqihDthODHuEUBGIxFjovOLZBnFvmG4h/l3keW5nx
         vGyAt1kHicr+VHYBzNI+B9FesOWpNqHBH6bkjfk3vvNBRGhRs6PFu7zXBcjby9nb+H2i
         n/ojCLdr4OxprKRlEoHvJZd3PcyaPSNu1D0VCl2PepJSmJlaNp2zY3HaCUk8eTVwFfIh
         cyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719162838; x=1719767638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/zZtNnC/KzVU1jMIJC4/FDxQCHloTtcrOBctLMG5CU=;
        b=kxoJHCxulqqzOhgI3tTrru1ETeBE5ScmSJaKvNiyXeRhI+ICSn1W1v9SvQYyOMesj7
         slcIYPDLGZkPFEaBG2G7qXTSuuurQcVXzCRPVKLVpeQCKKQggqArsRqkYa45kYfRiEnw
         Iu/KsXzV+ouAUMhCR9FfoAdi5Y0AtCFSZZTW8jwTrkFyte3u9TXC8uOVHavDKkvpBaGp
         0oIIERAsRC94866QKXarjhPIDRRnea9KCTqFrhVHqJO61bJaYRg5As5/s2F9+O5iiFmp
         tA3npUD4aHWV33Fuxf3DDcuJDv9sups05/JSs+VOB9vvGrJRP7uqO1DvCjBxeFs3m9vx
         ceWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtasELh4khntaaWQeIB0N6wK/kAbKQ/5YOWJyqSkxD6h1Q+5cpGKnpqekAauVJn0bndAf8fe48mNGBKEvd0Fk/KTCPTLUOLsW+ghtj
X-Gm-Message-State: AOJu0Yz8+LTQoc0o46np0Uz/Xp+k9PNerUn/vxS42HHnYO/5uIV1EQJg
	2oWRvSgWt6F5KrkUO9KCUB7TcuycY4HPgFTQJCEH78fyeKPCfApXfXhbc/RliE0=
X-Google-Smtp-Source: AGHT+IEsXcCBagsv8tL9AutPCA7iuhEkYPNHkSumgoYjzJz2RJ7sKny+qlwrzaHOmWv3pbnNRkCa6A==
X-Received: by 2002:a5d:68cd:0:b0:360:38a6:6bd8 with SMTP id ffacd0b85a97d-366e3686fa8mr2576414f8f.20.1719162838394;
        Sun, 23 Jun 2024 10:13:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6769sm7908377f8f.5.2024.06.23.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:13:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Bluetooth: hci: fix build when POWER_SEQUENCING=m
Date: Sun, 23 Jun 2024 19:13:52 +0200
Message-ID: <20240623171352.305053-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BT_HCIUART_QCA, which is a bool and an HCI UART component, uses now
power sequencing, so we need to be sure BT_HCIUART_QCA=y and
POWER_SEQUENCING=m cannot happen:

  /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_serdev_probe':
  drivers/bluetooth/hci_qca.c:2401:(.text+0xc48): undefined reference to `devm_pwrseq_get'
  /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_shutdown':
  drivers/bluetooth/hci_qca.c:2192:(.text+0x29e8): undefined reference to `pwrseq_power_off'
  /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_on':
  drivers/bluetooth/hci_qca.c:1808:(.text+0x3390): undefined reference to `pwrseq_power_on'

Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 87484f5de8e3..90a94a111e67 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -105,6 +105,7 @@ config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on NVMEM || !NVMEM
+	depends on POWER_SEQUENCING || !POWER_SEQUENCING
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
-- 
2.43.0


