Return-Path: <linux-kernel+bounces-271551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91139944FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FFEB22C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076D1B4C2E;
	Thu,  1 Aug 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGOeJvzb"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525371B3F25;
	Thu,  1 Aug 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528224; cv=none; b=sv9xjaMdXbwvq3nLL/9btKAUnk4c2eHvJNF++weO7O3T7WH+o4S+4N8JLuBXbkhsUY85m3VF/4wSrLUSrEAy5+6/gtry7GsGE+7mB7YO7IgX9LIkcWgKrBO1eg2e6N8QMjxtSnWUfu4TT3xtLIKXzmN0uTsNs0VWlmhWSmy5pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528224; c=relaxed/simple;
	bh=lKEyCcZ5xvVxKerc19SgPa49hrP9i/Su9pkaJ2TQK24=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsN0IElwQI7zQ1Puz7ZhV3tqRux0b1HqptfKh+xLCJaAXYx6+PSRTnYrwnEWgugIJEvk7cv0Fw6Ii792y4iHba+e+V94AzVhy7wVYHoftWoa9/9EGSYo76QGRb79BLa2EOSkyiKR2CLd6XgI6p3hFzc1mvnIKJIoz3JHWc/9tRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGOeJvzb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so4721427a12.3;
        Thu, 01 Aug 2024 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528222; x=1723133022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oqZSVf3Pja7+3axQ7FhMBZCb9fhp3k28x1dNv+Nkh0=;
        b=TGOeJvzbnTtLPZhLd/0JKqHyIFdVFhIte2id0+FvnOoep4w9jOj0M3ZINw1cxmIGO5
         UC/7lf9ejtK3GSzGxWLhTiHvtnL4/P4vmXOXozWpW18KC27/8YFrM5vG/I2T347dVy9W
         rGwQaTsE4Zo2LJxP0a2AmndiAMAc6I62V7ICJggStCTvbiZeJzNiRIasLtV65/Y+z3z9
         rPmQdWnpqNB1aGquH0vYveZOmSsuz192snrFJqLO6qXR/D+H+/BBBoO6MNfaz4J26Oko
         NAjXKzoC4TXkdCx/XEQ3SD+4BsAZ6eZ8Ad7qyOsB5IG3B5iLpvSxgNCKSmSz26JjCXB/
         KADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528222; x=1723133022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oqZSVf3Pja7+3axQ7FhMBZCb9fhp3k28x1dNv+Nkh0=;
        b=Ux2wHq/mIFUHb/8kUr5vAQmyTcTUApVlp8h0qpFZggQolgC/5+LWHrSj7KBfdTuA6K
         4t9kTdKR5DYNZlUx+5szRymXQFG5wwU3A084/Hz+Y46A+We5Y28cpm5gzejRiN7Y75Ca
         kEQ8fj0kbCf6nr6kHm9iL8K+C2JFwtLfaGNnoiUKRBy3BwFaEmreE+dgdfiA/+nRCZZS
         1/BrxONCZAzZ2dTAbZIa7wKfz9UwTUAhHZ4FQ9PmpBgtS/Gx52e2l5UkGXvq5MPnuvl+
         98MylGBAjzLPVWt57+uHUKZbU+0h3GKh0P2qbwYuxlJx72CNmnJXvMX43B3Zk1n9bGik
         9fJw==
X-Forwarded-Encrypted: i=1; AJvYcCWqOy0eUipmTQOm3Tdo4m6av8bHEQ9ZwEqvyR8hrIwwH0Nnv8N1EWd4Z2TrNt8DipygLi2DZHVmL0v8/9oHSoUVzaL7GfTcaSExu218yhHXOy5SNl/UmuZOOmmMHuviSHL+ufhC+Ul65g==
X-Gm-Message-State: AOJu0Yx81SWH6lOnJhP58Fqlry7gZlvxVvFIjKrUlMKQ2KfTTRvgtyOo
	g9D3sePRd9zea4JxHYA6oH6JhebUsBKlFd5drB0pj8L50NN/8XJA
X-Google-Smtp-Source: AGHT+IG6tg51ynV80wHlsk0sv7Mrh3n5BGlH6OX14TfmA459p8pb2kTLYFECWUzhBXE/TS8GtQj3HQ==
X-Received: by 2002:a17:90b:4b92:b0:2cf:f3e9:d5c8 with SMTP id 98e67ed59e1d1-2cff952e810mr843435a91.31.1722528222522;
        Thu, 01 Aug 2024 09:03:42 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:42 -0700 (PDT)
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
Subject: [PATCH v3 01/11] ARM: dts: aspeed: Harma: revise hsc chip
Date: Fri,  2 Aug 2024 00:01:25 +0800
Message-Id: <20240801160136.1281291-2-peteryin.openbmc@gmail.com>
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

Revise HSC chip name and address to match LTC4287.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index c118d473a76f..d99fba321379 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -276,11 +276,10 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	power-monitor@22 {
-		compatible = "lltc,ltc4286";
-		reg = <0x22>;
-		adi,vrange-low-enable;
-		shunt-resistor-micro-ohms = <500>;
+	power-monitor@44 {
+		compatible = "lltc,ltc4287";
+		reg = <0x44>;
+		shunt-resistor-micro-ohms = <250>;
 	};
 };
 
-- 
2.25.1


