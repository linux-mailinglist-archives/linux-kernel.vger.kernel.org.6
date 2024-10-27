Return-Path: <linux-kernel+bounces-383652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A979B1EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B031F21743
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720B1741D1;
	Sun, 27 Oct 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKsQsLv4"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CD3166F25;
	Sun, 27 Oct 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039823; cv=none; b=tSNTzYEFooO1w2ebc4UWD/3K2Rzgn9Q5iS30UUj4x9kFg1X8cjl5bW48DWvfqeqUx/8gxbDHdQIq6vn1p+rWQI7+0pXO5NsXzhYwCMR6bAHCsMvi3a963vtaPi9B/fGAPhdHB8EBYQtRTObAgDSlr/YfhOaspsVjgavPrSFvZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039823; c=relaxed/simple;
	bh=McMTyWzS0Bg4WFWkM4x5Eq6n8AM1vXInQ676orlwBs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpbF8smzrBZ/OGGTlpea4ISPFhSXzjtAIc2Q0azyqEy8s1jna+xxsvx3Dhh03JO1yLqpDGTi4kJUYBtlGwWW8uteApLx04qtTXcGAo1B0OSIcAV/w8e8T39xHAjndDU/8FHFfJyjSDXmkAgdOCMJpPGgffiIqI4EgxwI841ICwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKsQsLv4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c94c0bf354so470419a12.1;
        Sun, 27 Oct 2024 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039820; x=1730644620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7BTF2QgV5p9nNttdJyKFEUTkRzHJB1L1AnxAUE0mKw=;
        b=DKsQsLv4PmC8Fht2+m4ReXBu4RDhB1TY0ZJr2Vx0sI/uW7yhxvCyzvSWPopcLVvwAJ
         uAKL0s7tTPPf0JHgl6d4cFpQcNx69xENW8fKu+qODSk5l71jX1PSxXmOrIbC+HNfqbMx
         3t22qjrY59W+wYxytcumkb2GqP/xXAVBdtzDZZH8wOlpzxmgKkzv/qD3UCknBz6AeeJI
         nUcXRSJ4wGoeCkc/uusiSZTRMf/12+L6Deui85sDO5MMGA1jpLJay2R6gP/LbjN6ET4p
         uoOkbW+4f5Dzv1ZNy2k443GBmCLaac29tAeP1tpvrXaFi1AwIUJcEWStnTvwC6tbRvDR
         1Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039820; x=1730644620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7BTF2QgV5p9nNttdJyKFEUTkRzHJB1L1AnxAUE0mKw=;
        b=CeuK1AsNMm6TzoeoJTFIPpRH/FXLPgZz0BwV66PSoyRvUXVR3Kmtr5NxcHLpnN15gm
         kM5ShfkqDdbiL0j/3beuLQtMGRGHBeRO9rogX93F/Z0GYqq6e/qyGcvxSmobevfdEndT
         i+3cJwv8mBrNQilXTm2sL6U7AMWe5WN7oBPja+99XyeS1PrUf1Gk9OdSJnqx3yNLdKi7
         9HBl8oWrFX1dp+FwHVxmCRKB2zmjRVtHFiyVdNTonnO0gUCZYQMnNPDmMmXUoFdw6iBr
         33iH+fcyi5fbLmJCdj3Mv4jL4/n6s/r5K6Emu9DoclHfY6bmVjOfVLjfyWzzBZrN0fsL
         cWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy58lP44PdOEt3e/rfAnSdqRv44GdyyAX5qKwscuIZIwRFflwfSa1V/G432p9ihQMV3q7SYaHcjw/3s99C@vger.kernel.org, AJvYcCXey1EIaXMKTkfamYYAQPtWsbR8kCuwGt1O1Xu/aMnkPRJO+e3J2IvnT2lILzhkH2WAPKoUkmKazvLS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rBCsBCz41mOfa4OuHVbLfgL741sPKKzt51yXvDMLkIrRQGjM
	7vYtZhgT/KE9xtU8b5cJAJCK/xHldDvaa+eSRsALgTs3vEEe8Ak+p22qkA==
X-Google-Smtp-Source: AGHT+IH213Vf8xr6wl/OZIsTWCpbeibIB0rD6ONpIkkTnKmu+a97JWDkMnauVcg5HcMoNrcqrcpmrg==
X-Received: by 2002:a17:907:6d24:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a9de5fa6a7bmr212086966b.8.1730039819577;
        Sun, 27 Oct 2024 07:36:59 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:36:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 02/22] ARM: dts: socfpga: align bus name with bindings
Date: Sun, 27 Oct 2024 14:36:34 +0000
Message-Id: <20241027143654.28474-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding expects the bus node name to match bus and not amba.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 35be14150..c7ba1e4c7 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -62,7 +62,7 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 7113fe5b5..7abb8a0c5 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -54,7 +54,7 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1


