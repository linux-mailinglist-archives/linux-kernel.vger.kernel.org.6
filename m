Return-Path: <linux-kernel+bounces-373393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9D9A563C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7479B1C20F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFC1990CE;
	Sun, 20 Oct 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeDKrYDd"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37490198A0E;
	Sun, 20 Oct 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453239; cv=none; b=cig4n7xDwdz/ptjQI+aowMoh4kq6O4GwzzftKO1PSn4M1r6yi6ewI5bCpoSkG3zQEffQZPAHNQFqqcJB7GDv/yPl2Pi5UesS4A5r3zih6tqGq6jmWdqYypWwymIFWDuCEVm63gqWcGEXQa7o2y9vl/AL+T5rKw/NZOrkys+zxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453239; c=relaxed/simple;
	bh=zUAJFmmnkJAWnOviaASwhwRRUPKQVvu8A4WKyBwFSeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sm0yCZ8R4IoUYXH/xszjiKRi43tQy2GhlibpCp1ud2U4djLHeoTFZir2+8QbDaNk7mGY9l87xPQZXiVajsq9v+SjZuqHD+/EU/Iu+HV9pdpMbPi26ISCH6imSGNfYiigPuc03ngmesDK4vHXraCH5ZTuCSQsVrZ0IZyCocoIV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeDKrYDd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a966de2f4d3so35091166b.2;
        Sun, 20 Oct 2024 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453235; x=1730058035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk9braQhcUfjQhD1zhHgydTWlqcLCgBL7v99PtqcEgk=;
        b=QeDKrYDdEgUs3JEeTresRe1z8bKkhs5H7I9ZDzoKd+ypzcuaVZy2moBBIKb3XsgC33
         rR7xqZXetjfcjlLeM2G1C3lD2IdIEbxLeRzvhZ/0YXCiZB3nMZtSJarw+KiJPAvH8C1f
         HUYocbUFEOa79TLVvAkpKhk5qzd8KAjkNDLxPvhqSHcyemWFfbx/LIIbwsKvKKITeNYo
         SZrbSTh2/siDKToPljab2fltWH3b1Uilmdhmobpugbm3ni6EZWNcJ8mW5J7R7g9oAvwz
         D9ELEvT+dWxWhkkNAbAq8Sgi9popAA3od7xHSzyvJlO47OaLAnoNnJ99X255HqDzNgGS
         xDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453235; x=1730058035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk9braQhcUfjQhD1zhHgydTWlqcLCgBL7v99PtqcEgk=;
        b=vxpy/aLl8JVUlL+sNhHswzWk3vi+5hiEVkhD9b7+X1WIAxqNcnJa8Kr/pz3PscL+Nm
         5wN1p8ScOtUWYcbL+DPogrgjb4w7eXn02SsMh1qHOE0vtQkh6dN/Xjdku/Gp4RxqIMYe
         YHJEgXCoHkZN/uDHtLZetSZOxwcSp+KxwcCkZQghKMTwKcnoTduYMzHE+L2S/zkWOUgs
         EjiYRnVd7pLKc839VIQLdoLPflDMu/kPSak3UAYhcurdVGCKBOgQcG91s7A461zkx/wL
         CecG9mxf0ke85gJ4f0QWTqs12vlbhil4HVXy83YAF6u8i4cRqFtLP+ZNPL11NPKxaQT4
         /40w==
X-Forwarded-Encrypted: i=1; AJvYcCVsJURC69bGvjbUkxwaNPEo18jcGyiYDz8OFHUzqSytP4GEbECE690ZmlzjgBFSC6a9dyO3Q1ewdam8v9vA@vger.kernel.org, AJvYcCXx/C0QIhTh3nOaFCptyg7g0bFcPEEheR+8TaqNKCnsEsgWdIDI/vZfYKydWPdZzb9XHpEO1rLZtbAB@vger.kernel.org
X-Gm-Message-State: AOJu0YwxINwJhKBFepPOhDJbe/NX9X74gvWah7yN1+U8QuWkmjEmlEnR
	K2hjDmWbrm9/0r16/yCS9wmjdca40ga+emResPsUfoVz66MYFEXD
X-Google-Smtp-Source: AGHT+IE/fDR5kX58OzYRpo+s8afTu2DqWPvANQoZiz+MOG/8dfrXzp1n8R64yI0Q3T/sm35IPAPrtQ==
X-Received: by 2002:a17:906:dc90:b0:a9a:147d:fec2 with SMTP id a640c23a62f3a-a9a69a7b3ddmr300859966b.6.1729453235287;
        Sun, 20 Oct 2024 12:40:35 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:34 -0700 (PDT)
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
Subject: [PATCHv2 03/23] ARM: dts: socfpga: align dma name with binding
Date: Sun, 20 Oct 2024 19:40:08 +0000
Message-Id: <20241020194028.2272371-4-l.rubusch@gmail.com>
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

Binding expects the node name to match with dma-controller.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index c7ba1e4c7..01cc5280f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -68,7 +68,7 @@ bus {
 			#size-cells = <1>;
 			ranges;
 
-			pdma: pdma@ffe01000 {
+			pdma: dma-controller@ffe01000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffe01000 0x1000>;
 				interrupts = <0 104 4>,
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 7abb8a0c5..aa0e960a3 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -60,7 +60,7 @@ bus {
 			#size-cells = <1>;
 			ranges;
 
-			pdma: pdma@ffda1000 {
+			pdma: dma-controller@ffda1000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffda1000 0x1000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.25.1


