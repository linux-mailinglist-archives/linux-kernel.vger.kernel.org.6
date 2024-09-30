Return-Path: <linux-kernel+bounces-344897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8057698AF60
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2248E2838D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816E187578;
	Mon, 30 Sep 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b="IOJAwtPO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D44183CD1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732826; cv=none; b=osWWtXGagRPE9YOkkMVthy7PZCBr2p6KvGQ4oScRRlCYRH+fFq7/PSK2mJGgaAEjLitM7p/FmQf7vunxEOe2C1TsgC502jwhjvSC0xoVqFH+OSnAwu/eT8oP1AocS5KwxST8gEcX+O+BpzCymZS+QZlXyNNPeZU9zpKG7IfhWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732826; c=relaxed/simple;
	bh=6zSuEcQkhJkexSq4MDKw4eikgATy7hT8rk8dNP6Etq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QH0xkDzTyNdvCAM5Pdz/ZLAukNw5Y5Hmx3B45oYNwNGBt007f30R0plACoAffBEnvFbxB/d0F4uKciWa6EbsA7uXhl5kpjU5VxEtZAHSrtFesBCvjmWu1ur6VL8dGje1epolWeXGuZy5voKGlxRGJncS0ItPNU9cdJ+eeFb2ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b=IOJAwtPO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7191fb54147so3495732b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1727732824; x=1728337624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMqHdeTj7ucU9GaPyPzazSvBub7TbuDBX6paCdDs648=;
        b=IOJAwtPO1hZH3W+fzBDgbj5hYcE3yCipu+Nc2JGjpK8GVAMXA6HxcMKCQmS/217ccM
         A1Q5LnOt1+fkD3lW9GyY3rqIQeQn7F6dRBQouoR7L7Hb4BsNhEQILF07skMiV+cMnMhC
         B34CIzgqyiHRTHkFiLLcb/uCueaEMqT+z+Oz2uI8gBi72QXFjTdN9bRA/9h3Tq5oIUoU
         6o+Sbm08zK1ZJp0QaATxEFFbrH5HP2EHgiQd2HP6KCfh5JkGU8AwlgSF1F8qvVgKttOG
         3jJaCfDq3KktDUPq2FLv6zGnDXLTDP6mMlrKg6ELjcHwRMSk6X9fx4pyTDTKpU7Zcvjo
         a9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732824; x=1728337624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMqHdeTj7ucU9GaPyPzazSvBub7TbuDBX6paCdDs648=;
        b=XelLpr+HxEOyGmB5jx/EifJWY/dbHIM4SfuOi2u0Iv/c1brhGjFKyKj9YkEisbAxPe
         f7SkVvENYRuj0G4cdZZvL6Wm8b+LEKebzzAP+adHBPfbmxU01ZZz1FIinlSfpMLfiC1K
         d4Wv9cDy+lgkFgN8zOthSqdCkhmhDKtzUW1cQDpc06kRZRPnr7Jib+OzjnMfOKmWpQEe
         aFch6tocdkRRPGfgFu5DkW5Vy7kArw4+lo/UJwCopliBlRvjiZkevL5x5fIkFk9xqkFD
         sF0dVdNZANOkPxqH/+6foOyO1rMhz1dwzfCVaai55aVxo3Bp3hOdJHxRlLh+nqEwsCmE
         NOqg==
X-Forwarded-Encrypted: i=1; AJvYcCWP7jGnNubLyBlpao6Vgkng2n1YKnPmokiECEFzMHXbT8Eymlktz+dYABnm6hoMTmcddcPkwnvNKrL7hfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSatXv6LdUeavKObyBLHbXU8BkYQHLKdXWX09xdl5XhRarP9jb
	sgrvatt/UmW+DZwQHVocD5d7zD5/1+7whWJWq7wER18krM9ZojXDWGRdZiBfcZE=
X-Google-Smtp-Source: AGHT+IGeWoerl1azL8qki/9a37LglG5WrGNd9x7T+yJy4k0261Nq+LgWrsllmElNr2v1P/aDOf8PhQ==
X-Received: by 2002:a05:6a00:1989:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-71b25f6eee1mr17646128b3a.15.1727732824378;
        Mon, 30 Sep 2024 14:47:04 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:8aa3:d4c6:5fe7:c47c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc88bsm6734573b3a.71.2024.09.30.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:47:03 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	"William A. Kennington III" <wak@google.com>
Subject: [PATCH] ARM: dts nuvoton: Add EDAC node
Date: Mon, 30 Sep 2024 14:46:59 -0700
Message-ID: <20240930214659.193376-1-william@wkennington.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "William A. Kennington III" <wak@google.com>

We have the driver support code, now we just need to expose the device
node which can export the EDAC properties for the system memory
controller. Tested on real hardware to verify that error counters show
up.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 5aeb5009a5d7..019abceb16a0 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -127,6 +127,13 @@ clk: clock-controller@f0801000 {
 			clocks = <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
 		};
 
+		mc: memory-controller@f0824000 {
+			compatible = "nuvoton,";
+			reg = <0xf0824000 0x1000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		gmac0: eth@f0802000 {
 			device_type = "network";
 			compatible = "snps,dwmac";
-- 
2.46.1.824.gd892dcdcdd-goog


