Return-Path: <linux-kernel+bounces-383653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B59B1EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E390B1F211B6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16617B505;
	Sun, 27 Oct 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN386mQY"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EA16F8F5;
	Sun, 27 Oct 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039824; cv=none; b=dW4LAdwTG1R7eNeMHfVlIVLABZjkdw6wyZcuQAwSsfsCFY3/Q2V+xhQrWFPeXIxmVtPGOYxwEhTgIZUMsU/8iUfeYnPJnnveZxmePcSISBO1A06agUP0aKcpulNciu2/dwi42wmLT+OEmYaAki2qdxJ99/+5emfTiNWL+c6Fw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039824; c=relaxed/simple;
	bh=zUAJFmmnkJAWnOviaASwhwRRUPKQVvu8A4WKyBwFSeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfh+tW26SHz0MwVlXcF0WiOU0Zq2MhIXiz7Sxdscl+XNGy1L5NEjIXKK8251mtoA6RyMlJ8QX6frPLzGB126r5TtZMT4va7QemgwAOFlFjQlbZ8HDaDyvy5aXkWDMnVD4OPyL6cxuvV/anWmFEmPZuJtSwYbuytChI/yCuo7A70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN386mQY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a966de2f4d3so43926366b.2;
        Sun, 27 Oct 2024 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039821; x=1730644621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk9braQhcUfjQhD1zhHgydTWlqcLCgBL7v99PtqcEgk=;
        b=iN386mQY2Xvev7/hWjgHdXYsvHKHOC+24pMc5P+4u1nFclX+n9p8LME6HOxYO6eEkX
         D1c89AlZMcLkQUFsMpCYzp2t6W3QDAVqOusRtRmw4YPfh0sH2sW1XPzOpn+e2M+voa0m
         MYdAxQNJnnTKbKZWZtAmhfB5Yw9h1LGT4b7p/QL3UZ1FirDsS7AeuMs1xTr+kDlaGFNT
         GSu1QZhKSkpvDY+imyYj1znfiJtigyBdfHYiIcn8UkOkcQZK1AUpd52aBI028LHh9xoz
         b/m8ATIpU4g+bK6k7M8YUYOXvHi/Y0U2wSbJ0YnmHhaXoykGBpxpEZ6Ub9mh1N9rTcxu
         /COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039821; x=1730644621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk9braQhcUfjQhD1zhHgydTWlqcLCgBL7v99PtqcEgk=;
        b=gZDDi0jJL3oAguRdSd7gcFBMS6XcmwzNVFuyLQU7r120dWxG16DmB38eUI6Z/YwZCU
         /iuKd0brp7Q2j6wveQiK7Wr2wvvSUoIo+qmCPbtmtpq6JI2Mwh+2Kagudi0Z/p6hQtzj
         PfJvnbvajnjUKzekiZXwsxF8KaHjzTFZ/vJnU7yqSh5mFRLy+UpJbaHNsGvvXor9frAd
         pUVEgaO7A8ynvtALbnDnqzmGkNrOvW2H0QR0QPIx8P9240vTAFUnXaxQ2ESGA+ui7X49
         gJ0tbY+CeU9A2JX3s4sOTjYDofmjYdkFrQZmuRnk273FH6HZ4dpNmHPBuicqq8BdhHN9
         m9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSMQR84h3xxuSMXnf7u3Io1LkFhCRLl5yLb1yD8GbKOplcgfI/s6+hcP+VsYwzA1aKwHIqa3KI69jA@vger.kernel.org, AJvYcCWOG5x5vjP3YAXkjYPqpAQCeEtMCrc+7cfaxImmXGqmNOZoBpfX3I+fEtEOetD3xi2T1wCVbWEceYFheq1x@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuTllfhP+BwME8fwgJ1H+vXOA59bYpWiyB7iK65kxqdnscvZK
	iFA1O45Abv7qp8heUUW70byBEAWacoR1H6e3lrESOAl/FT9ggs/k
X-Google-Smtp-Source: AGHT+IHNWv59mwrCGUavlqTnI52sw88LvxT0FqNsinS2oUZgdblwk8PiTWZgC8Ext0fYq+Mr2AgMTw==
X-Received: by 2002:a17:907:a41:b0:a9a:cee1:3cc9 with SMTP id a640c23a62f3a-a9de631d910mr207252266b.13.1730039820623;
        Sun, 27 Oct 2024 07:37:00 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:00 -0700 (PDT)
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
Subject: [PATCHv3 03/22] ARM: dts: socfpga: align dma name with binding
Date: Sun, 27 Oct 2024 14:36:35 +0000
Message-Id: <20241027143654.28474-4-l.rubusch@gmail.com>
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


