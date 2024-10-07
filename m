Return-Path: <linux-kernel+bounces-353401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F294992D49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52211284115
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA71D4353;
	Mon,  7 Oct 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEGg4NaF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910817B4E9;
	Mon,  7 Oct 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307883; cv=none; b=McxX2luEDn4t2s7iVAm3+QY7txxEZqDN26GI/on8WUT/5WlLHgMX00fj9aKDO5UNOHzAvGSYvnmLqHt221y1eCYA6Q7dv19zoyj/SgFlGqYlfWGOkCbghJfNnOELdQV+/fBbOWDDxUkIY72nTBBPIEiUy5sokdPIMMdy8svrf58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307883; c=relaxed/simple;
	bh=FCENLo1EiHQMx6q7FwEZvnv56M9gcuqYvT3ODLO+4Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAbVEP+xd7P3YmyNIJqO+4DdfBkzMUW20NEXtOeSY0SzZKp4WCsGHOGmxjFBAwadhYJacTUWLsCCNA37WAKx+pOnFsHwPds6RLRT7EgmnS1Xq7zjLOAnGY1oFYAAisKYSeJLlEA+ToTZesvt3xrwpmf9p7owjDwfa4NHjNZxDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEGg4NaF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cdab63866so278634f8f.2;
        Mon, 07 Oct 2024 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307880; x=1728912680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5Nye5ldjQgTKDDGDplMBYjcGztZjG3K0j8WIaJzCPo=;
        b=aEGg4NaFCB+bLNOJHf+S5VvzriVrVlYs8p0NdWliwbMgL/0csJoYKAHbq2GiKzUfuM
         AoEuGZssPlp4ywyLjX1RMKn4uVbWAHh1EHZDlwAal3/87kzj5hNi4oQIIfnxhw7GzdSy
         AgFO03Zelvph00xwTHamPG2Xs5Z5nPPJ+o9hSg3ZIm+dL/P261yiI4iC6u63ogfY+1CE
         0eN/VPyppdTC2KDKGTSZxXkjWuQhTZQC4HSpQrVb21gb4u2E6lIycxMIPRHejDW0cli2
         QREUlqUxSG9rsOwdh6tSodlivgEVk/ToWhQEqx93u36ijRXZIxOczNP/khonXLAKE+R2
         J/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307880; x=1728912680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5Nye5ldjQgTKDDGDplMBYjcGztZjG3K0j8WIaJzCPo=;
        b=lBnOl0HtPwtgPcb33GT5gvk+37pnCxg2RKacCppNbB9AMxkxCpx0KTl07Vj3r5r8hB
         IapDeRePM/WOosXN/bvYDS5NlTzJHfse6hPSU/oNdGCT+diLet0sUgTs6Jw3GLRm+ywQ
         CGxc07qpTCX81kSOLiAiCN1eG/72pbdItDTWZVlgZtmSYJKTQU+6RUFZcHz8TEEeAGS4
         QUKEdE0Bokk9MsUoPTUYrbUr4MquOh9JCptKLl/AUR7UmG2ntenkdjTd9INNsV3uF0Hk
         Iuna5uSh10V9Ir/nSu73KuTdjQocLimnq3JYj7PmhscdDNC0KMcZmahxamJSLVjVU4ph
         nzYw==
X-Forwarded-Encrypted: i=1; AJvYcCWNZP/IINEJXkBNsUwgmQn1wV2JI5BG6DwD3ErmajOZXnZP+Z23jyRdf9ehD4/ooMZ0GDufvGHvRbZX@vger.kernel.org, AJvYcCXFQPGeiHGITFoM9IHeIeixR+pOI7ZVMF8ypjR1Thc8Vzrz6Ya45UOjK2fj4X3z24Npkg+0E/wgZguo4Deb@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpQRCJfdjKyD7X8ivJg9t+AvOKvlKi8YOPtlp4Hivrd2ZHw8h
	vLNS7l2QyUUGed32oU5WV0t4FQZi1W0eGYUS1iAUZ9whrDv1ndbGZQILNw==
X-Google-Smtp-Source: AGHT+IHnDdv2w2nnHlJQznmkjLwXxA9EnWruQ31I9LZadkWFhdoKh0AXAUHEx4lUUoM6Gt6ynFH7HA==
X-Received: by 2002:a05:6000:1888:b0:37c:cd6c:798 with SMTP id ffacd0b85a97d-37d0e4e79cemr3219809f8f.0.1728307879771;
        Mon, 07 Oct 2024 06:31:19 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:18 -0700 (PDT)
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
Subject: [PATCH 1/8] ARM: dts: socfpga: fix dtschema issues
Date: Mon,  7 Oct 2024 13:31:08 +0000
Message-Id: <20241007133115.1482619-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007133115.1482619-1-l.rubusch@gmail.com>
References: <20241007133115.1482619-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several warnings of dtbs_check in the socfpga.dtsi and
socfpga_arria10.dtsi.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         |  6 +++---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 10 ++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 35be14150..1562669b3 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -62,13 +62,13 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
-			pdma: pdma@ffe01000 {
+			pdma: dma-controller@ffe01000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffe01000 0x1000>;
 				interrupts = <0 104 4>,
@@ -87,7 +87,7 @@ pdma: pdma@ffe01000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			compatible = "fpga-region";
 			fpga-mgr = <&fpgamgr0>;
 
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6b6e77596..32464e3d1 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -54,13 +54,13 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
-			pdma: pdma@ffda1000 {
+			pdma: dma-controller@ffda1000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffda1000 0x1000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>,
@@ -80,7 +80,7 @@ pdma: pdma@ffda1000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
@@ -88,7 +88,7 @@ base_fpga_region {
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-		clkmgr@ffd04000 {
+		clkmgr: clkmgr@ffd04000 {
 				compatible = "altr,clk-mgr";
 				reg = <0xffd04000 0x1000>;
 
@@ -685,6 +685,8 @@ nand: nand-controller@ffb90000 {
 
 		ocram: sram@ffe00000 {
 			compatible = "mmio-sram";
+			#address-cells = <1>;
+			#size-cells = <1>;
 			reg = <0xffe00000 0x40000>;
 		};
 
-- 
2.25.1


