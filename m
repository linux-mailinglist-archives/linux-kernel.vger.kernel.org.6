Return-Path: <linux-kernel+bounces-373394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E92A9A563E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C2F1F2236D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA371991B2;
	Sun, 20 Oct 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdvEMOxH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C431198E6F;
	Sun, 20 Oct 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453240; cv=none; b=oF+rubtCZ3r2VPwsybkta79LZpShi+zD4ZzaC8Aq11//1o7pO19s+zoV8mSz/qd89z2OzWUK3Eg3uapyKnDeoPDCMIZEeYGVsMifNos0afMdj5S9GnVOPxpsHQ0C3SALsNk8VfZ9xopPzRcW08BdGJsOzfW0Thqtf9EylfzcWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453240; c=relaxed/simple;
	bh=6Qat5CV6Gvn1Mg9L2SWD8nbWS8IHMjd9Ue15KWtpNH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kst0EzhlKtUCIm4dI/iu2O0LQTBp33j75Z8dKlI07Iud0ayTze4eVof+/wi87fZA20+ONub7O5y9mU+j3dNzl+i0onL/tdGkYnTfE+2IPZoauBs2YRpORkcipyti3MtbLFs4XmJb2KRq2NxhVD5SoHIxbu1vKT6jlIntYsejLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdvEMOxH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43158124a54so4875655e9.3;
        Sun, 20 Oct 2024 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453236; x=1730058036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQnRaKE3CWs3EWJZg8TyJXymOuu8Xu8+zwME5vygCHY=;
        b=MdvEMOxH0aeg6X3cBfvAu08pgaUpNEywHQ9yOaW0qnjUWY6vgs0bJ8Zq+ePqOZ/S+6
         lIvxoZpqlTWWfGcZ6fDkIQEiTwwZtl55wkyrorj5lXozPU6kr/8dSO1d8v0a09W1Fa+a
         j88INwWjc7IxzDX7NvWLPPYBEaKu7gor2vmG3EiyZ7gCHWgBNoRfDp6S7yoWTVgElAua
         yd+SNXftfVIgjhJW5pUZjlgVlRIVkIMRVeCGPcRDNLUuKZNulmXpEEOC1w1aX5N7o/yZ
         pUroK72J1L9hWWfipvkJSZUMpWVkLy3aAygJzZozAiuopOhjpOh7TQFHzZ1LNK0oHui0
         z5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453236; x=1730058036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQnRaKE3CWs3EWJZg8TyJXymOuu8Xu8+zwME5vygCHY=;
        b=Q6HygGQ6DG5v0crDVjjjDCRe8EDY1R3A4qsxZEqm+ZxsueRaNHjVit6yXZzmrpskH/
         7E/uRs3vxGu2rRfzvdQJrSZiv9ysNfmT9gdd1Rb2dbaPgOIU+eckzCexz8AkyQiP9CPg
         yYmMqgG7SSCeQZGzSTRA0n72Mix/QLiIWqWFTnCFznQN8mFasM6qXcJLKJeTmp9JP66R
         DYHXnp/SVDMl9iqqpDJnCDdXAJ2UZELRbzJyrN6VGVJJlHuRLwEvzfl+pdfvUXAdyQll
         bpxmNaKt11+K5EFxqTV4lw+jUiNUOn1bmxHAmVv9vnOHKtbQ/aqk4co8rYQnjGG3rXV6
         3eNA==
X-Forwarded-Encrypted: i=1; AJvYcCV3x1GwL32RoIQB+b49WglL/E2znbGkbD1qw/8wz0fTLz4VBB4uJnWugWdusqlM6IrYB4gJGJxrt/LSbgdi@vger.kernel.org, AJvYcCXfG4sD41JfcEJj90iH8rIC5S0ONHqRYDvEh4zaqFQs1V4vg/PUUaL7gxCCFoqRXx2QC2XdKLKiumMU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80cTGl6n9yV8ihMa0rXjq0aLJqQKSMpurm5lLrZEJ17LFvJWY
	+dvHRdwUfTPKaLvVdFy0Cp+KEfvf5ZMKl3vs4g9AmkMN4cCdGPuL
X-Google-Smtp-Source: AGHT+IER7WxMhtca3NnQLC4SYayehZGXzJ7NBOCivfUTBCBRarub38ixEnpaJTcsLBxvtoMw5X+pdA==
X-Received: by 2002:a5d:59a4:0:b0:37d:3ec9:a006 with SMTP id ffacd0b85a97d-37eab7589bbmr2973152f8f.10.1729453236398;
        Sun, 20 Oct 2024 12:40:36 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:36 -0700 (PDT)
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
Subject: [PATCHv2 04/23] ARM: dts: socfpga: align fpga-region name
Date: Sun, 20 Oct 2024 19:40:09 +0000
Message-Id: <20241020194028.2272371-5-l.rubusch@gmail.com>
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

Binding and setup expects to match fpga-region instead of old naming.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 01cc5280f..1562669b3 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -87,7 +87,7 @@ pdma: dma-controller@ffe01000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			compatible = "fpga-region";
 			fpga-mgr = <&fpgamgr0>;
 
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index aa0e960a3..90e4ea61d 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -80,7 +80,7 @@ pdma: dma-controller@ffda1000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
-- 
2.25.1


