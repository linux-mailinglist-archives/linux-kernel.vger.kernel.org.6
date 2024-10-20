Return-Path: <linux-kernel+bounces-373392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9DF9A563A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1A11F21C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867B198A17;
	Sun, 20 Oct 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYjabbB2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03F1957FD;
	Sun, 20 Oct 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453236; cv=none; b=BT6Dti6LzLS375DY8E8JxZcPCfJOamG/jkv0o8Fw+h8qU3a2NJkcEKZhYpcoAQUmR9845sqDpNYv2oqGDeOEMMISU3M9WmgSNwvcY1Fyc6YPGLs6pQfUgqepsgxctOV0bn189IWxpUwduBMqAzyl7qsej1HydjaLB8bOwsYEoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453236; c=relaxed/simple;
	bh=McMTyWzS0Bg4WFWkM4x5Eq6n8AM1vXInQ676orlwBs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUOzklbS39ZOOMFV92KVaHK9nLB7AvproVR5Sg+MoCs/Nio37jGpqiaK1R3z4if1DyK4SMHRDnGh3wzYmPb31NtWiQWxQI1xb+X4GDS3Z4P8aS1aBZDmQObomALx8rXVTq/2GvQRsJjcsfVeMNQcBWLNnj3A5Tu958N7AFld1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYjabbB2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a68480e3eso25260966b.1;
        Sun, 20 Oct 2024 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453233; x=1730058033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7BTF2QgV5p9nNttdJyKFEUTkRzHJB1L1AnxAUE0mKw=;
        b=DYjabbB2j5c+Vdrwq7qD9DYAK/9ZiwJ2LcHV+clSTzOX4r9pzqoZldgEc8zr4cma6/
         iMAr1eGUYjcccQ4mvO1zCZ4CCUVVEPJXi4yQMzYovVW6AZiMDkfi8SLoe6cO704BOSKn
         rVgRxZQRWsQQMXNE3AlH6m9FgiyLXn7L4SzWawAaMoGVoEvOY0ThlKPbFovTNWTpBPNs
         g413bLetTUjZ8nDI/A4jXrzyrvOYSLntg27xaTxjrV6O9P6EFPHVYZNhoRE1GwlyIoJL
         9rS9CvvpEyIhbejADGfr9IisNTb6ZgPTQzLAzRFZcQ00rdj3uCLZ2yHcyZBBC0ZI1HCg
         aqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453233; x=1730058033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7BTF2QgV5p9nNttdJyKFEUTkRzHJB1L1AnxAUE0mKw=;
        b=rC5AARXce2DyLBP53nG1OHgK6fhQiSbqptGNasD6eEvdB2q8JpBx7u8lc8UwMxzUzE
         hyFWhmleFEsBkyDi8zu/JWIyl3r5cpnlNNNzqdbBxW0iVSaHkLXgXxnBsOVNI3wq1PEG
         HNIn8WtQ4Ux5h9QKZl7bDgu1LL+MbkN9phF8uShoIkO9DTuNae3K8ISnoiq0gQT+Zt6u
         NBjrZrv8RpaVjNgIeNuXK+vcA23LJXuh0T0hIvc4qSnmrf582VO5Xy7UscL83RSJU/Du
         OnrNgCAjghWHn7QaVJymbgGqhSNcjqBcy+lTOr0PMr9AnyYeXYQhslqmDly5UkAW+nn0
         2ICg==
X-Forwarded-Encrypted: i=1; AJvYcCU/mduWYDKkhX2H5fNaXAjHJmO/ghbM/T6Rmp6cYXoRJN7ZUHFFljW+asYpttjGHfdR/wyY6GtbQD9mv75j@vger.kernel.org, AJvYcCWji4Y4C7JNYeCgpm5MeUHEsMvaVTe7ObQyvluvSgafz9t53MXKIuZ5+QgPIvrMQYya7yZmYCQDxwXq@vger.kernel.org
X-Gm-Message-State: AOJu0YytAKdtilgvGaQSSUE3Lt6Iy03jz9CVEF1f6h2iDU4epvzZr23E
	hxsYRXEHYS7RYWApHCnJqOIQOovyLn+nb41NByoURGShjoy62Qvl
X-Google-Smtp-Source: AGHT+IHIPy0w64KwZCJzE4v/DFqFINpH4qYlAw3nXSjCuQPizSxqR85cFPUFjcbg/F/q+RvKiQZlPA==
X-Received: by 2002:a17:907:7e83:b0:a9a:522a:ba3a with SMTP id a640c23a62f3a-a9a69a65ed1mr396830166b.2.1729453232769;
        Sun, 20 Oct 2024 12:40:32 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:31 -0700 (PDT)
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
Subject: [PATCHv2 02/23] ARM: dts: socfpga: align bus name with bindings
Date: Sun, 20 Oct 2024 19:40:07 +0000
Message-Id: <20241020194028.2272371-3-l.rubusch@gmail.com>
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


