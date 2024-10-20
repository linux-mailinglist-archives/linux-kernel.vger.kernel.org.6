Return-Path: <linux-kernel+bounces-373391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289AF9A5638
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE5D1F21DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51119882B;
	Sun, 20 Oct 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzvJ6bLP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F1192D7E;
	Sun, 20 Oct 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453235; cv=none; b=cic2A4L9hYNQ5D6vXPWS/hivRZEDPUO3V2J9Czl++/AznDPztxWfR5J5uZDDNhvtUgEbYj1qTc3Y5m4+nneBabbiAs4ILiBarMudQmSRZrTCVBp98SbTh/s/W8mtxYzvt1yYgnSd5AkJIuvJdUBEqxMLAdAe3vbVRv7HzPHwhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453235; c=relaxed/simple;
	bh=Ex8CaFl67w1VtC2hc/lcNDnGnJtDLlBtJT/wSUiYmBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKagivMZNU0xB6AOx4o7br7ohbhOZsjJT3tQHjQpHNrW4SaTdQ2Xv8jhGZcNxkljE5ItvOmTeh6NOeU+4K9gYFf+NTTOHZ1XUsB0UcHJDT7uEwVW1PK/Fy1n8K85vjE6HtjMbrEUk0nhfS9ajOS6Mqkkz/0phz6myW85gTwuhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzvJ6bLP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a68480e3eso25260466b.1;
        Sun, 20 Oct 2024 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453231; x=1730058031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rm8BK0uAln/RMAZHBbXqzd3kfEXu0sK1tEB93lCjSg=;
        b=KzvJ6bLPP3+jvr+SOrqZPHu/ZPRoMqwUOcYLRBOtlkvyyfRU4P+BNqr90kH4nEPdtd
         YtdU2oM+hTLP5xD/cxAiHc0qYBY5ZqhHNJ4pIovyPZGiHtbumbk2O8jusF+qrxB6DWQj
         64trKg+Aiz84RTXQUg33bKuVUnXjPKjMylJTjhuGD08325nWR4LYN6IpGFJnqoFB3/Hl
         ZNmKp9zAjOI66JHTyxLdITBy2hd/xWaywUIgXJ80gXK6Q7O2H+1al1chfng2zUQB6f1F
         tYOJuE/M3mS8m9OSGq4iKuaxYhA8IqN+FKxHixq8B3937qlY+MSHN6thOF2xNTkk0VkC
         uDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453231; x=1730058031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rm8BK0uAln/RMAZHBbXqzd3kfEXu0sK1tEB93lCjSg=;
        b=CIZ2Lt3QVttJtLEOpupuCpeZzaQ4mYIDtyPwAC2teu3myTFfIxcX1FOpUy49qQbsKc
         +6mPWf6oy+I2EGjVV5UhCkDZCC1z76xYotyFzXRs/bGz+ZaOYCmlceZjWi7Pplo8Gf3o
         ODDWQnMynXScj74UmgC5LovEiAL1cFQPn7iQhplrtswdbDVEn/vMd2Yr/YDCTzrSrmmT
         LLXzixVzLTa4/owxj4xan4tvRAgxx9m5ugOvjvkQPRCeVrIPjcW9NzryN3pSddVdrUPF
         afsXPpGT85X4jyfq3/HD+LD4J15NCkJfQX5xmmvDxtl5CXZZ3r2y/5deT+Uw7Hid4kQc
         CaVg==
X-Forwarded-Encrypted: i=1; AJvYcCUM84xPSHiJtqC/8i0ln3O0qEukE3Jw0QscVPvCpeppXU9LiMOQZWX0PyFXqm6txJxiA9Q9wKoAdPFF@vger.kernel.org, AJvYcCWIDky13gZgAmvPIK4z0LVZf4cT6r9isL/aoLTz4oadPx/bAWxLtjMwxmDek/rI3/5l3m7w3fS3bJCz04Gv@vger.kernel.org
X-Gm-Message-State: AOJu0YybRzzXu+aiezFtEW5eVryHPBoSh5qda8nGXx36nKgwYm6OdQyi
	AnX68FSfLVawjt7wEcosNanGBGYCupPYjhM9G12HFRmmON9COl2s
X-Google-Smtp-Source: AGHT+IHtfGr8Jn2qJY1vED/49gsHlJI5Lv0aZebGkpLVQi0IgWpjVINOKsGl8bc6I/VjRFuEX6U2Ag==
X-Received: by 2002:a17:907:9708:b0:a9a:3793:994b with SMTP id a640c23a62f3a-a9a69cdaa03mr381959266b.13.1729453231036;
        Sun, 20 Oct 2024 12:40:31 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:30 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 01/23] ARM: dts: socfpga: fix typo
Date: Sun, 20 Oct 2024 19:40:06 +0000
Message-Id: <20241020194028.2272371-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A semicolon was fallen off the wall.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6b6e77596..7113fe5b5 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -169,8 +169,7 @@ main_gpio_db_clk: main_gpio_db_clk@74 {
 
 						main_sdmmc_clk: main_sdmmc_clk@78 {
 							#clock-cells = <0>;
-							compatible = "altr,socfpga-a10-perip-clk"
-;
+							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x78>;
 						};
-- 
2.25.1


