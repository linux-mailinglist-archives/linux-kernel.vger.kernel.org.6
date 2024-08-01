Return-Path: <linux-kernel+bounces-271552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88034944FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E203286266
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163B1B32DA;
	Thu,  1 Aug 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIeatOHn"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636F1B142A;
	Thu,  1 Aug 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528227; cv=none; b=D9rPNi9kW7YN/Zy9Xc2U++9Vhb8lwcZldWmoLf5/FKfGrY42oNWXaYsTMVqU4k8c63SiJIve286p5MRyrARIhHZ9pJVZvkRTvHd95HKDUfrUk8CP1pW5nq8mAUJwEZ5LUxI/vGNNdw6GLDd9rZ/4bUsKgHyINRK8OxQeVNjrNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528227; c=relaxed/simple;
	bh=kRnxb3dXW8VJlRr49TK8Noo7AABu5eqP19UU4CfnoPM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXFvNYLHy3AngXDK+KWVSYsu2dC37TwWPIylbcRbZRCwYuoLPhgXR+TGOfT3t/l4OS5JotIcDzpigcqzKc9DQip/nLNswtrZcpjYBCeKMqFTJdOqMuG3imwEDJJwy/41xFUSF/RpYCXh6Gc6/PzzwBnL/GPI2UwRbYep0X4Ookk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIeatOHn; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so4619537a12.1;
        Thu, 01 Aug 2024 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528225; x=1723133025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Xvc/KjGA8csQnGpC5265d0N0RHT5WtgS5gajMnjS20=;
        b=eIeatOHns5wXQNyU0fQBcIeQT6Id750a3gQ2DS3X1GDlrOBGq0Vtz4fKXzGHmFqcDc
         YwvhLsTCQs++pnukoVbMgLjJVgp1NZ4ERHrU5MY0+K7yBG+qPRhmy+USeGQh0lOMfQMt
         3X2PDHEYqUXT8HwhNzrTl/s1jMhntZWVODjVCFdeFWRlok6DTfCNhFzAGmgmxcVnNL+M
         5sSqCyiy+pP0olKAEr89OOqqsv59EI92T9LpdD4DtcMGG7ztugKI6+8MRZ158OQUsrhj
         YIPPhEMxHolYL/kvX/ej/RQ1FNx2BhhJ8YSQqGdool5/rMpMM+goxv7WPYJVKzgasqx4
         kNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528225; x=1723133025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xvc/KjGA8csQnGpC5265d0N0RHT5WtgS5gajMnjS20=;
        b=vU3aj2ZfnAUJv2uTa0JDzDn4oRsT8pNj/c32uWZ/hFi1MPi+gDisk6D2yjEkwyP6tZ
         MHCQBsWf+l9ptbowlWFq9hKJq5yLlb4qO4Jt7BSxxxio+IepgZOZQWFJ7gVKTSFx0iga
         p0kD8UxEUVio4SbVZezmnbgLKLEoiTKpI5vXRhbop34MDX10Zj4sgmbWcB7CkGoq9PF8
         YPkBPhyuF1l8jWL+Q3S9bTAoz4vRAq6ItmgIPZaRiN0rTlkYiVB68OsXuIiFeKcMaJG3
         7Qxl0fdGhunJvMcTn5IfFjNFc4KknondaHuZPyPk6YbjU6EgfOtwUULkJ+Y+JzRVgfv7
         rYwA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Xr76RIDdrUqJ/p3P5ih0zO9qSVATrO51ftAdH9c7Tb5YixX+6LhBcztZq/VMnok0bSmcPBt4XbeE1LoDLIrNMzAQJNTGWsTRZSYowQwsYfgeiU2gbymzufgocbZopvR5lHgWhyIvNg==
X-Gm-Message-State: AOJu0Ywn1vxtQ1YPlXWWOjwAZHzj70mbxGCLgYsqjYC6VUDL46NW1Q+c
	ZbVn4/wJj+K3P74Eo8JbE2wfE1hoB5PS2eOyqtSYeX4BhJiHyZ/k
X-Google-Smtp-Source: AGHT+IGlU2dt7pndOA3Re1nLJoWTvZUFUwdcLWsGa5x2aRYRnbOEpyrYhTN1gMD98bbpeN6JFr+Lig==
X-Received: by 2002:a17:90a:a417:b0:2c9:6f8d:7270 with SMTP id 98e67ed59e1d1-2cff9544dc7mr680631a91.42.1722528225310;
        Thu, 01 Aug 2024 09:03:45 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:44 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] ARM: dts: aspeed: Harma: add VR device
Date: Fri,  2 Aug 2024 00:01:26 +0800
Message-Id: <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add isl69260, xdpe152c4 device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d99fba321379..8fb30029e46c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -398,6 +398,30 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			power-monitor@61 {
+				compatible = "isil,isl69260";
+				reg = <0x61>;
+			};
+			power-monitor@62 {
+				compatible = "isil,isl69260";
+				reg = <0x62>;
+			};
+			power-monitor@63 {
+				compatible = "isil,isl69260";
+				reg = <0x63>;
+			};
+			power-monitor@64 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x64>;
+			};
+			power-monitor@66 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x66>;
+			};
+			power-monitor@68 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x68>;
+			};
 		};
 		imux29: i2c@1 {
 			#address-cells = <1>;
-- 
2.25.1


